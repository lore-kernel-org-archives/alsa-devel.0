From: "Peer Chen" <pchen@nvidia.com>
Subject: [Patch] Audio: Add nvidia HD Audio controllers of
	MCP67 support to hda_intel.c
Date: Tue, 31 Oct 2006 15:33:58 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B0C42D52B@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1412851970=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Andy Currid <ACurrid@nvidia.com>, Brian Lazara <BLazara@nvidia.com>, jgarzik@pobox.com, Emily Jiang <ejiang@nvidia.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--===============1412851970==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6FCBE.ECF8208A"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6FCBE.ECF8208A
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Add the support for HD audio controllers of MCP51,MCP55,MCP61,MCP65 &
MCP67.
The following hda_intel.c patch is based on kernel 2.6.18.

Signed-off by: Peer Chen <pchen@nvidia.com>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--- hda_intel.c.orig	2006-10-30 14:13:08.000000000 +0800
+++ hda_intel.c	2006-10-31 13:44:36.000000000 +0800
@@ -1640,8 +1640,14 @@ static struct pci_device_id azx_ids[] =3D=20
=20	{ 0x1106, 0x3288, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_VIA
}, /* VIA VT8251/VT8237A */
=20	{ 0x1039, 0x7502, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_SIS
}, /* SIS966 */
=20	{ 0x10b9, 0x5461, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ULI
}, /* ULI M5461 */
-	{ 0x10de, 0x026c, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_NVIDIA }, /* NVIDIA 026c */
-	{ 0x10de, 0x0371, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_NVIDIA }, /* NVIDIA 0371 */
+	{ 0x10de, 0x026c, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_NVIDIA }, /* NVIDIA MCP51 */
+	{ 0x10de, 0x0371, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_NVIDIA }, /* NVIDIA MCP55 */
+	{ 0x10de, 0x03e4, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_NVIDIA }, /* NVIDIA MCP61 */
+	{ 0x10de, 0x03f0, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_NVIDIA }, /* NVIDIA MCP61 */
+	{ 0x10de, 0x044a, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_NVIDIA }, /* NVIDIA MCP65 */
+	{ 0x10de, 0x044b, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_NVIDIA }, /* NVIDIA MCP65 */
+	{ 0x10de, 0x055c, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_NVIDIA }, /* NVIDIA MCP67 */
+	{ 0x10de, 0x055d, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
AZX_DRIVER_NVIDIA }, /* NVIDIA MCP67 */
=20	{ 0, }
=20};
=20MODULE_DEVICE_TABLE(pci, azx_ids);

-------------------------------------------------------------------------=
----------
This email message is for the sole use of the intended recipient(s) and m=
ay contain
confidential information.  Any unauthorized review, use, disclosure or di=
stribution
is prohibited.  If you are not the intended recipient, please contact the=
=20sender by
reply email and destroy all copies of the original message.
-------------------------------------------------------------------------=
----------

------_=_NextPart_001_01C6FCBE.ECF8208A
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-asci=
i">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 6.5.7233.6=
9">
<TITLE>[Patch] Audio: Add nvidia HD Audio controllers of MCP67 support to=
=20hda_intel.c</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><SPAN LANG=3D"zh-cn"><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Arial">A=
dd the support for HD audio controllers of MCP51,MCP55,MCP61,MCP65 &amp; =
MCP67.</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Arial">=
The following hda_intel.c patch is based on kernel 2.6.18.</FONT></SPAN>
</P>

<P><SPAN LANG=3D"zh-cn"><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Arial">S=
igned-off by:</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT COLOR=3D"#000080" =
SIZE=3D2 FACE=3D"Arial">Peer Chen</FONT></SPAN><SPAN LANG=3D"zh-cn"> <FON=
T COLOR=3D"#000080" SIZE=3D2 FACE=3D"Arial">&lt;pchen@nvidia.com&gt;</FON=
T></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Arial">=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</FONT></SPAN>
</P>

<P><SPAN LANG=3D"zh-cn"><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Arial">-=
-- hda_intel.c.orig&nbsp;&nbsp;&nbsp; 2006-10-30 14:13:08.000000000 +0800=
</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Arial">=
+++ hda_intel.c 2006-10-31 13:44:36.000000000 +0800</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Arial">=
@@ -1640,8 +1640,14 @@ static struct pci_device_id azx_ids[] =3D </FONT><=
/SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Arial">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0x1106, 0x3288, PCI_ANY_ID, =
PCI_ANY_ID, 0, 0, AZX_DRIVER_VIA }, /* VIA VT8251/VT8237A */</FONT></SPAN=
>

<BR><SPAN LANG=3D"zh-cn"><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Arial">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0x1039, 0x7502, PCI_ANY_ID, =
PCI_ANY_ID, 0, 0, AZX_DRIVER_SIS }, /* SIS966 */</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Arial">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0x10b9, 0x5461, PCI_ANY_ID, =
PCI_ANY_ID, 0, 0, AZX_DRIVER_ULI }, /* ULI M5461 */</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Arial">=
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0x10de, 0x026c, PCI_ANY_ID, PCI_A=
NY_ID, 0, 0, AZX_DRIVER_NVIDIA }, /* NVIDIA 026c */</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Arial">=
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0x10de, 0x0371, PCI_ANY_ID, PCI_A=
NY_ID, 0, 0, AZX_DRIVER_NVIDIA }, /* NVIDIA 0371 */</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Arial">=
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0x10de, 0x026c, PCI_ANY_ID, PCI_A=
NY_ID, 0, 0, AZX_DRIVER_NVIDIA }, /* NVIDIA MCP51 */</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Arial">=
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0x10de, 0x0371, PCI_ANY_ID, PCI_A=
NY_ID, 0, 0, AZX_DRIVER_NVIDIA }, /* NVIDIA MCP55 */</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Arial">=
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0x10de, 0x03e4, PCI_ANY_ID, PCI_A=
NY_ID, 0, 0, AZX_DRIVER_NVIDIA }, /* NVIDIA MCP61 */</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Arial">=
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0x10de, 0x03f0, PCI_ANY_ID, PCI_A=
NY_ID, 0, 0, AZX_DRIVER_NVIDIA }, /* NVIDIA MCP61 */</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Arial">=
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0x10de, 0x044a, PCI_ANY_ID, PCI_A=
NY_ID, 0, 0, AZX_DRIVER_NVIDIA }, /* NVIDIA MCP65 */</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Arial">=
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0x10de, 0x044b, PCI_ANY_ID, PCI_A=
NY_ID, 0, 0, AZX_DRIVER_NVIDIA }, /* NVIDIA MCP65 */</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Arial">=
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0x10de, 0x055c, PCI_ANY_ID, PCI_A=
NY_ID, 0, 0, AZX_DRIVER_NVIDIA }, /* NVIDIA MCP67 */</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Arial">=
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0x10de, 0x055d, PCI_ANY_ID, PCI_A=
NY_ID, 0, 0, AZX_DRIVER_NVIDIA }, /* NVIDIA MCP67 */</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Arial">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0, }</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Arial">=
&nbsp;};</FONT></SPAN>

<BR><SPAN LANG=3D"zh-cn"><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Arial">=
&nbsp;MODULE_DEVICE_TABLE(pci, azx_ids);</FONT></SPAN>
</P>


<DIV>
<HR>
</DIV>
<DIV>This email message is for the sole use of the intended recipient(s) =
and may=20
contain confidential information.&nbsp; Any unauthorized review, use, dis=
closure=20
or distribution is prohibited.&nbsp; If you are not the intended recipien=
t,=20
please contact the sender by reply email and destroy all copies of the or=
iginal=20
message. </DIV>
<DIV>
<HR>
</DIV>
<P></P>
</BODY>
</HTML>

------_=_NextPart_001_01C6FCBE.ECF8208A--


--===============1412851970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1412851970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1412851970==--
