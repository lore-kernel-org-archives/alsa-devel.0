From: Manuel Jander <manuel.jander@mat.utfsm.cl>
Subject: Soundcard Matrix patch.
Date: Fri, 28 Nov 2003 20:13:16 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1070064796.3275.16.camel@localhost>
Reply-To: manuel.jander@mat.utfsm.cl
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-pW/xjegLkXolh3HZVa+D"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-pW/xjegLkXolh3HZVa+D
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Here is patch to the current Soundcard matrix, to reflect the current
state of the Aureal driver.

Best Regards

Manuel J.

--=-pW/xjegLkXolh3HZVa+D
Content-Disposition: attachment; filename=alsa-doc.diff
Content-Type: text/x-patch; name=alsa-doc.diff; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by rapel.dcsc.utfsm.cl id hASN2PF03460

--- alsa-doc.html	2003-11-28 19:50:31.000000000 -0400
+++ alsa-doc2.html	2003-11-28 20:06:11.000000000 -0400
@@ -473,21 +473,21 @@
       <td>AU8810</td>
 	<td align=3D"center"><a href=3D"http://www.alsa-project.org/alsa-doc/do=
c-php/template.php?company=3DAureal&amp;card=3DGeneric&amp;chip=3DAU8810&=
amp;module=3Dau8810">Details</a>
       	</td>   =20
-      <td>[To]</td>
+      <td>[Tio][Rio](4)</td>
     </tr>
  <tr>
       <td>=A0</td>
       <td>AU8820</td>
-	<td align=3D"center"><a href=3D"http://www.alsa-project.org/alsa-doc/do=
c-php/template.php?company=3DAureal&amp;card=3DGeneric&amp;chip=3DAU8810&=
amp;module=3Dau8820">Details</a>
+	<td align=3D"center"><a href=3D"http://www.alsa-project.org/alsa-doc/do=
c-php/template.php?company=3DAureal&amp;card=3DGeneric&amp;chip=3DAU8820&=
amp;module=3Dau8820">Details</a>
       	</td>   =20
-      <td>=A0</td>
+      <td>(4)</td>
     </tr>
  <tr>
       <td>=A0</td>
       <td>AU8830</td>
-	<td align=3D"center"><a href=3D"http://www.alsa-project.org/alsa-doc/do=
c-php/template.php?company=3DAureal&amp;card=3DGeneric&amp;chip=3DAU8810&=
amp;module=3Dau8830">Details</a>
+	<td align=3D"center"><a href=3D"http://www.alsa-project.org/alsa-doc/do=
c-php/template.php?company=3DAureal&amp;card=3DGeneric&amp;chip=3DAU8830&=
amp;module=3Dau8830">Details</a>
       	</td>   =20
-      <td>[To]</td>
+      <td>[Tio][Rio](4)</td>
     </tr>
=20
=20
@@ -582,11 +582,12 @@
       	</td>    =20
       <td>(4),[Ro]</td>
     </tr>
- <tr bgcolor=3D"#aaaaaa">
+ <tr>
       <td>PCI 338-A3D</td>
       <td>AU8820</td>
-      <td>=A0</td>
-      <td>[X?]=A0</td>
+        <td align=3D"center"><a href=3D"http://www.alsa-project.org/alsa=
-doc/doc-php/template.php?company=3DAureal&amp;card=3DGeneric&amp;chip=3D=
AU8820&amp;module=3Dau8820">Details</a>
+        </td>
+      <td>(4)</td>
     </tr>
  <tr bgcolor=3D"#aaaaaa">
       <td>PCI 368-DSP</td>
@@ -1119,11 +1120,12 @@
 <tr><th rowspan=3D"5">
       <a href=3D"http://www.diamondmm.com/">Diamond Multimedia</a>
  </th></tr>
- <tr bgcolor=3D"#aaaaaa">
+ <tr>
       <td>MonsterSound mx300</td>
       <td>AU8830</td>
-      <td>=A0</td>
-      <td>[X?]=A0</td>
+        <td align=3D"center"><a href=3D"http://www.alsa-project.org/alsa=
-doc/doc-php/template.php?company=3DAureal&amp;card=3DGeneric&amp;chip=3D=
AU8830&amp;module=3Dau8830">Details</a>
+      	</td>
+      <td>[Tio][Rio](4)</td>
     </tr>
  <tr>
       <td>MonsterSound mx400</td>
@@ -3030,11 +3032,12 @@
       	</td>	=09
       <td>=A0</td>
     </tr>
- <tr bgcolor=3D"#aaaaaa">
+ <tr>
       <td>Montego II</td>
-      <td>=A0</td>
       <td>AU8830</td>
-      <td>[X?]=A0</td>
+      <td align=3D"center"><a href=3D"http://www.alsa-project.org/alsa-d=
oc/doc-php/template.php?company=3DAureal&amp;card=3DGeneric&amp;chip=3DAU=
8830&amp;module=3Dau8830">Details</a>
+      	</td>
+      <td>[Tio][Rio](4)</td>
     </tr>
  <tr bgcolor=3D"#00ff00">
       <td>Monterey</td>
@@ -3139,11 +3142,12 @@
  <tr><th rowspan=3D"2">
       <a href=3D"http://www.xitel.com/">Xitel</a>
  </th></tr>
- <tr bgcolor=3D"#aaaaaa">
+ <tr>
       <td>Storm Platinum</td>
-      <td>AU8330</td>
-      <td>=A0</td>
-      <td>[X?][To]</td>
+      <td>AU8830</td>
+        <td align=3D"center"><a href=3D"http://www.alsa-project.org/alsa=
-doc/doc-php/template.php?company=3DAureal&amp;card=3DGeneric&amp;chip=3D=
AU8830&amp;module=3Dau8830">Details</a>
+      	</td>
+      <td>[Tio][Rio](4)</td>
     </tr>
=20
    =20

--=-pW/xjegLkXolh3HZVa+D--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
