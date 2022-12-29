Crud:

CRUD Example
Directory Structure in Eclipse

JSP CRUD Example
index.jsp
<!DOCTYPE html>  
<html>  
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<title>JSP CRUD Example</title>  
</head>  
<body>  
<h1>JSP CRUD Example</h1>  
<a href="adduserform.jsp">Add User</a>  
<a href="viewusers.jsp">View Users</a>  
  
</body>  
</html>  

adduserform.jsp

<!DOCTYPE html>  
<html>  
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<title>Add User Form</title>  
</head>  
<body>  
  
<jsp:include page="userform.html"></jsp:include>  
  
</body>  
</html>  
userform.html
<a href="viewusers.jsp">View All Records</a><br/>  
  
<h1>Add New User</h1>  
<form action="adduser.jsp" method="post">  
<table>  
<tr><td>Name:</td><td><input type="text" name="name"/></td></tr>  
<tr><td>Password:</td><td>  
<input type="password" name="password"/></td></tr>  
<tr><td>Email:</td><td><input type="email" name="email"/></td></tr>  
<tr><td>Sex:</td><td>  
<input type="radio" name="sex" value="male"/>Male   
<input type="radio" name="sex" value="female"/>Female </td></tr>  
<tr><td>Country:</td><td>  
<select name="country" style="width:155px">  
<option>India</option>  
<option>Pakistan</option>  
<option>Afghanistan</option>  
<option>Berma</option>  
<option>Other</option>  
</select>  
</td></tr>  
<tr><td colspan="2"><input type="submit" value="Add User"/></td></tr>  
</table>  
</form>  

adduser.jsp

<%@page import="com.javatpoint.dao.UserDao"%>  
<jsp:useBean id="u" class="com.javatpoint.bean.User"></jsp:useBean>  
<jsp:setProperty property="*" name="u"/>  
  
<%  
int i=UserDao.save(u);  
if(i>0){  
response.sendRedirect("adduser-success.jsp");  
}else{  
response.sendRedirect("adduser-error.jsp");  
}  
%>  

BEAN:
User.java
package com.javatpoint.bean;  
public class User {  
private int id;  
private String name,password,email,sex,country;  
//generate getters and setters  
}  

dao:
UserDao.java
package com.javatpoint.dao;  
import java.sql.*;  
import java.util.ArrayList;  
import java.util.List;  
import com.javatpoint.bean.User;  
public class UserDao {  
  
public static Connection getConnection(){  
    Connection con=null;  
    try{  
        Class.forName("com.mysql.jdbc.Driver");  
        con=DriverManager.getConnection("jdbc:mysql://localhost:3306/test","","");  
    }catch(Exception e){System.out.println(e);}  
    return con;  
}  
public static int save(User u){  
    int status=0;  
    try{  
        Connection con=getConnection();  
        PreparedStatement ps=con.prepareStatement(  
"insert into register(name,password,email,sex,country) values(?,?,?,?,?)");  
        ps.setString(1,u.getName());  
        ps.setString(2,u.getPassword());  
        ps.setString(3,u.getEmail());  
        ps.setString(4,u.getSex());  
        ps.setString(5,u.getCountry());  
        status=ps.executeUpdate();  
    }catch(Exception e){System.out.println(e);}  
    return status;  
}  
public static int update(User u){  
    int status=0;  
    try{  
        Connection con=getConnection();  
        PreparedStatement ps=con.prepareStatement(  
"update register set name=?,password=?,email=?,sex=?,country=? where id=?");  
        ps.setString(1,u.getName());  
        ps.setString(2,u.getPassword());  
        ps.setString(3,u.getEmail());  
        ps.setString(4,u.getSex());  
        ps.setString(5,u.getCountry());  
        ps.setInt(6,u.getId());  
        status=ps.executeUpdate();  
    }catch(Exception e){System.out.println(e);}  
    return status;  
}  
public static int delete(User u){  
    int status=0;  
    try{  
        Connection con=getConnection();  
        PreparedStatement ps=con.prepareStatement("delete from register where id=?");  
        ps.setInt(1,u.getId());  
        status=ps.executeUpdate();  
    }catch(Exception e){System.out.println(e);}  
  
    return status;  
}  
public static List<User> getAllRecords(){  
    List<User> list=new ArrayList<User>();  
      
    try{  
        Connection con=getConnection();  
        PreparedStatement ps=con.prepareStatement("select * from register");  
        ResultSet rs=ps.executeQuery();  
        while(rs.next()){  
            User u=new User();  
            u.setId(rs.getInt("id"));  
            u.setName(rs.getString("name"));  
            u.setPassword(rs.getString("password"));  
            u.setEmail(rs.getString("email"));  
            u.setSex(rs.getString("sex"));  
            u.setCountry(rs.getString("country"));  
            list.add(u);  
        }  
    }catch(Exception e){System.out.println(e);}  
    return list;  
}  
public static User getRecordById(int id){  
    User u=null;  
    try{  
        Connection con=getConnection();  
        PreparedStatement ps=con.prepareStatement("select * from register where id=?");  
        ps.setInt(1,id);  
        ResultSet rs=ps.executeQuery();  
        while(rs.next()){  
            u=new User();  
            u.setId(rs.getInt("id"));  
            u.setName(rs.getString("name"));  
            u.setPassword(rs.getString("password"));  
            u.setEmail(rs.getString("email"));  
            u.setSex(rs.getString("sex"));  
            u.setCountry(rs.getString("country"));  
        }  
    }catch(Exception e){System.out.println(e);}  
    return u;  
}  
}  

adduser-success.jsp

<!DOCTYPE html>  
<html>  
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<title>Add User Success</title>  
</head>  
<body>  
  
<p>Record successfully saved!</p>  
<jsp:include page="userform.html"></jsp:include>  
  
</body>  
</html>  
adduser-error.jsp
<!DOCTYPE html>  
<html>  
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<title>Add User Error</title>  
</head>  
<body>  
  
<p>Sorry, an error occurred!</p>  
<jsp:include page="userform.html"></jsp:include>  
  
</body>  
</html>  
viewusers.jsp
<!DOCTYPE html>  
  
<html>  
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<title>View Users</title>  
</head>  
<body>  
  
<%@page import="com.javatpoint.dao.UserDao,com.javatpoint.bean.*,java.util.*"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
  
<h1>Users List</h1>  
  
<%  
List<User> list=UserDao.getAllRecords();  
request.setAttribute("list",list);  
%>  
  
<table border="1" width="90%">  
<tr><th>Id</th><th>Name</th><th>Password</th><th>Email</th>  
<th>Sex</th><th>Country</th><th>Edit</th><th>Delete</th></tr>  
<c:forEach items="${list}" var="u">  
<tr><td>${u.getId()}</td><td>${u.getName()}</td><td>${u.getPassword()}</td>  
<td>${u.getEmail()}</td><td>${u.getSex()}</td><td>${u.getCountry()}</td>  
<td><a href="editform.jsp?id=${u.getId()}">Edit</a></td>  
<td><a href="deleteuser.jsp?id=${u.getId()}">Delete</a></td></tr>  
</c:forEach>  
</table>  
<br/><a href="adduserform.jsp">Add New User</a>  
  
</body>  
</html>  

editform.jsp:

<!DOCTYPE html>  
<html>  
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<title>Edit Form</title>  
</head>  
<body>  
<%@page import="com.javatpoint.dao.UserDao,com.javatpoint.bean.User"%>  
  
<%  
String id=request.getParameter("id");  
User u=UserDao.getRecordById(Integer.parseInt(id));  
%>  
  
<h1>Edit Form</h1>  
<form action="edituser.jsp" method="post">  
<input type="hidden" name="id" value="<%=u.getId() %>"/>  
<table>  
<tr><td>Name:</td><td>  
<input type="text" name="name" value="<%= u.getName()%>"/></td></tr>  
<tr><td>Password:</td><td>  
<input type="password" name="password" value="<%= u.getPassword()%>"/></td></tr>  
<tr><td>Email:</td><td>  
<input type="email" name="email" value="<%= u.getEmail()%>"/></td></tr>  
<tr><td>Sex:</td><td>  
<input type="radio" name="sex" value="male"/>Male   
<input type="radio" name="sex" value="female"/>Female </td></tr>  
<tr><td>Country:</td><td>  
<select name="country">  
<option>India</option>  
<option>Pakistan</option>  
<option>Afghanistan</option>  
<option>Berma</option>  
<option>Other</option>  
</select>  
</td></tr>  
<tr><td colspan="2"><input type="submit" value="Edit User"/></td></tr>  
</table>  
</form>  
  
</body>  
</html>  
edituser.jsp
<%@page import="com.javatpoint.dao.UserDao"%>  
<jsp:useBean id="u" class="com.javatpoint.bean.User"></jsp:useBean>  
<jsp:setProperty property="*" name="u"/>  
<%  
int i=UserDao.update(u);  
response.sendRedirect("viewusers.jsp");  
%>  

deleteuser.jsp
<%@page import="com.javatpoint.dao.UserDao"%>  
<jsp:useBean id="u" class="com.javatpoint.bean.User"></jsp:useBean>  
<jsp:setProperty property="*" name="u"/>  
<%  
UserDao.delete(u);  
response.sendRedirect("viewusers.jsp");  
%>  




REgistraion

For creating registration form, you must have a table in the database. You can write the database logic in JSP file, but separating it from the JSP page is better approach. Here, we are going to use DAO, Factory Method, DTO and Singletion design patterns. There are many files:

index.jsp for getting the values from the user
User.java, a bean class that have properties and setter and getter methods.
process.jsp, a jsp file that processes the request and calls the methods
Provider.java, an interface that contains many constants like DRIVER_CLASS, CONNECTION_URL, USERNAME and PASSWORD
ConnectionProvider.java, a class that returns an object of Connection. It uses the Singleton and factory method design pattern.
RegisterDao.java, a DAO class that is responsible to get access to the database
Example of Registration Form in JSP
In this example, we are using the Oracle10g database to connect with the database. Let's first create the table in the Oracle database:
CREATE TABLE  "USER432"   
   (    "NAME" VARCHAR2(4000),   
    "EMAIL" VARCHAR2(4000),   
    "PASS" VARCHAR2(4000)  
   )  
/  
We have created the table named user432 here.

index.jsp
We are having only three fields here, to make the concept clear and simplify the flow of the application. You can have other fields also like country, hobby etc. according to your requirement.

<form action="process.jsp">  
<input type="text" name="uname" value="Name..." onclick="this.value=''"/><br/>  
<input type="text" name="uemail"  value="Email ID..." onclick="this.value=''"/><br/>  
<input type="password" name="upass"  value="Password..." onclick="this.value=''"/><br/>  
<input type="submit" value="register"/>  
</form>  
process.jsp
This jsp file contains all the incoming values to an object of bean class which is passed as an argument in the register method of the RegisterDao class.

<%@page import="bean.RegisterDao"%>  
<jsp:useBean id="obj" class="bean.User"/>  
  
<jsp:setProperty property="*" name="obj"/>  
  
<%  
int status=RegisterDao.register(obj);  
if(status>0)  
out.print("You are successfully registered");  
  
%>  
User.java
It is the bean class that have 3 properties uname, uemail and upass with its setter and getter methods.
package bean;  
  
public class User {  
private String uname,upass,uemail;  
  
public String getUname() {  
    return uname;  
}  
  
public void setUname(String uname) {  
    this.uname = uname;  
}  
  
public String getUpass() {  
    return upass;  
}  
  
public void setUpass(String upass) {  
    this.upass = upass;  
}  
  
public String getUemail() {  
    return uemail;  
}  
  
public void setUemail(String uemail) {  
    this.uemail = uemail;  
}  
  
}  
Provider.java
This interface contains four constants that can vary from database to database.

package bean;  
  
public interface Provider {  
String DRIVER="oracle.jdbc.driver.OracleDriver";  
String CONNECTION_URL="jdbc:oracle:thin:@localhost:1521:xe";  
String USERNAME="system";  
String PASSWORD="oracle";  
  
}  
ConnectionProvider.java
This class is responsible to return the object of Connection. Here, driver class is loaded only once and connection object gets memory only once.

package bean;  
import java.sql.*;  
import static bean.Provider.*;  
  
public class ConnectionProvider {  
private static Connection con=null;  
static{  
try{  
Class.forName(DRIVER);  
con=DriverManager.getConnection(CONNECTION_URL,USERNAME,PASSWORD);  
}catch(Exception e){}  
}  
  
public static Connection getCon(){  
    return con;  
}  
  
}  
RegisterDao.java
This class inserts the values of the bean component into the database.

package bean;  
  
import java.sql.*;  
  
public class RegisterDao {  
  
public static int register(User u){  
int status=0;  
try{  
Connection con=ConnectionProvider.getCon();  
PreparedStatement ps=con.prepareStatement("insert into user432 values(?,?,?)");  
ps.setString(1,u.getUname());  
ps.setString(2,u.getUemail());  
ps.setString(3,u.getUpass());  
              
status=ps.executeUpdate();  
}catch(Exception e){}  
      
return status;  
}  
  
} 



Login:


Login and Logout Example in JSP
Login and Logout Example in JSP
Example of Login Form in JSP
In this example of creating login form, we have used the DAO (Data Access Object), Factory method and DTO (Data Transfer Object) design patterns. There are many files:
index.jsp it provides three links for login, logout and profile
login.jsp for getting the values from the user
loginprocess.jsp, a jsp file that processes the request and calls the methods.
LoginBean.java, a bean class that have properties and setter and getter methods.
Provider.java, an interface that contains many constants like DRIVER_CLASS, CONNECTION_URL, USERNAME and PASSWORD
ConnectionProvider.java, a class that is responsible to return the object of Connection. It uses the Singleton and factory method design pattern.
LoginDao.java, a DAO class that verifies the emailId and password from the database.
logout.jsp it invalidates the session.
profile.jsp it provides simple message if user is logged in, otherwise forwards the request to the login.jsp page.
In this example, we are using the Oracle10g database to match the emailId and password with the database. The table name is user432 which have many fields like name, email, pass etc. You may use this query to create the table:

CREATE TABLE  "USER432"   
   (    "NAME" VARCHAR2(4000),   
    "EMAIL" VARCHAR2(4000),   
    "PASS" VARCHAR2(4000)  
   )  
/  
We assume that there are many records in this table.

index.jsp
It simply provides three links for login, logout and profile.

<a href="login.jsp">login</a>|  
<a href="logout.jsp">logout</a>|  
<a href="profile.jsp">profile</a>  
login.jsp
This file creates a login form for two input fields name and password. It is the simple login form, you can change it for better look and feel. We are focusing on the concept only.

<%@ include file="index.jsp" %>  
<hr/>  
  
<h3>Login Form</h3>  
<%  
String profile_msg=(String)request.getAttribute("profile_msg");  
if(profile_msg!=null){  
out.print(profile_msg);  
}  
String login_msg=(String)request.getAttribute("login_msg");  
if(login_msg!=null){  
out.print(login_msg);  
}  
 %>  
 <br/>  
<form action="loginprocess.jsp" method="post">  
Email:<input type="text" name="email"/><br/><br/>  
Password:<input type="password" name="password"/><br/><br/>  
<input type="submit" value="login"/>"  
</form>  
loginprocess.jsp
This jsp file contains all the incoming values to an object of bean class which is passed as an argument in the validate method of the LoginDao class. If emailid and password is correct, it displays a message you are successfully logged in! and maintains the session so that we may recognize the user.

<%@page import="bean.LoginDao"%>  
<jsp:useBean id="obj" class="bean.LoginBean"/>  
  
<jsp:setProperty property="*" name="obj"/>  
  
<%  
boolean status=LoginDao.validate(obj);  
if(status){  
out.println("You r successfully logged in");  
session.setAttribute("session","TRUE");  
}  
else  
{  
out.print("Sorry, email or password error");  
%>  
<jsp:include page="index.jsp"></jsp:include>  
<%  
}  
%>  
LoginBean.java
It is the bean class that have 2 properties email and pass with its setter and getter methods.

package bean;  
  
public class LoginBean {  
private String email,pass;  
  
public String getEmail() {  
    return email;  
}  
  
public void setEmail(String email) {  
    this.email = email;  
}  
  
public String getPass() {  
    return pass;  
}  
  
public void setPass(String pass) {  
    this.pass = pass;  
}  
  
  
}  
Provider.java
This interface contains four constants that may differ from database to database.
package bean;  
  
public interface Provider {  
String DRIVER="oracle.jdbc.driver.OracleDriver";  
String CONNECTION_URL="jdbc:oracle:thin:@localhost:1521:xe";  
String USERNAME="system";  
String PASSWORD="oracle";  
  
}  
ConnectionProvider.java
This class provides a factory method that returns the object of Connection. Here, driver class is loaded only once and connection object gets memory only once because it is static.

package bean;  
import java.sql.*;  
import static bean.Provider.*;  
  
public class ConnectionProvider {  
private static Connection con=null;  
static{  
try{  
Class.forName(DRIVER);  
con=DriverManager.getConnection(CONNECTION_URL,USERNAME,PASSWORD);  
}catch(Exception e){}  
}  
  
public static Connection getCon(){  
    return con;  
}  
  
}  
LoginDao.java
This class varifies the emailid and password.

package bean;  
import java.sql.*;  
public class LoginDao {  
  
public static boolean validate(LoginBean bean){  
boolean status=false;  
try{  
Connection con=ConnectionProvider.getCon();  
              
PreparedStatement ps=con.prepareStatement(  
    "select * from user432 where email=? and pass=?");  
  
ps.setString(1,bean.getEmail());  
ps.setString(2, bean.getPass());  
              
ResultSet rs=ps.executeQuery();  
status=rs.next();  
              
}catch(Exception e){}  
  
return status;  
  
}  
}  
