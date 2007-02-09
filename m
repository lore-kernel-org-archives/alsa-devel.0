From: "Allyn, Mark A" <mark.a.allyn@intel.com>
Subject: Questions on STAC 9202
Date: Fri, 9 Feb 2007 14:55:29 -0800
Message-ID: <5FD5754DDBA0B1499B5A0B4BB54194858D0D3B@fmsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0221745767=="
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--===============0221745767==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C74C9D.659AD47D"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C74C9D.659AD47D
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi:
=20
I am working on a system with a STAC 9202 device.
=20
Looking at the code in the 1.0.14rc2 release, in the patch_sigmatel
file, I notice that the STAC 9202 configurations are bundled together
with the STAC 9250 series.=20
=20
Although the NID's seem to be the same for the input and output pins,
the information on the DMIC pin seems to be missing from the definitions
on the stac 9250 series. (The NID for the digital mic is 0x15).=20
=20
The device I have uses the DMIC for the only input; none of the other
pins are used for an input.
=20
I am attempting to create another section in the patch_sigmatel file
specifically for the STAC 9202 device that includes the DMIC nid.=20
=20
Do any of you know if alsa has sucessfuly supported a sigmatel codec
with a DMIC input?
=20
Thank you
=20
Mark

------_=_NextPart_001_01C74C9D.659AD47D
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2912" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D112134922-09022007><FONT face=3DArial=20
size=3D2>Hi:</FONT></SPAN></DIV>
<DIV><SPAN class=3D112134922-09022007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D112134922-09022007><FONT face=3DArial size=3D2>I am =
working on a=20
system with a&nbsp;STAC 9202 device.</FONT></SPAN></DIV>
<DIV><SPAN class=3D112134922-09022007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D112134922-09022007><FONT face=3DArial =
size=3D2>Looking at the code=20
in the 1.0.14rc2 release, in the patch_sigmatel file, I notice that the =
STAC=20
9202 configurations are bundled together with the STAC 9250 series.=20
</FONT></SPAN></DIV>
<DIV><SPAN class=3D112134922-09022007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D112134922-09022007><FONT face=3DArial =
size=3D2>Although the NID's=20
seem to be the same for the input and output pins, the information on =
the DMIC=20
pin seems to be missing from the definitions on the stac 9250 series. =
(The NID=20
for the digital mic is 0x15). </FONT></SPAN></DIV>
<DIV><SPAN class=3D112134922-09022007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D112134922-09022007><FONT face=3DArial size=3D2>The =
device I have=20
uses the DMIC for the only input; none of the other pins are used for an =

input.</FONT></SPAN></DIV>
<DIV><SPAN class=3D112134922-09022007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D112134922-09022007><FONT face=3DArial size=3D2>I am =
attempting to=20
create another section in the patch_sigmatel file specifically for the =
STAC 9202=20
device that includes the DMIC nid. </FONT></SPAN></DIV>
<DIV><SPAN class=3D112134922-09022007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D112134922-09022007><FONT face=3DArial size=3D2>Do any =
of you know=20
if alsa has sucessfuly supported a sigmatel codec with a DMIC=20
input?</FONT></SPAN></DIV>
<DIV><SPAN class=3D112134922-09022007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D112134922-09022007><FONT face=3DArial size=3D2>Thank=20
you</FONT></SPAN></DIV>
<DIV><SPAN class=3D112134922-09022007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D112134922-09022007><FONT face=3DArial=20
size=3D2>Mark</FONT></SPAN></DIV></BODY></HTML>

------_=_NextPart_001_01C74C9D.659AD47D--


--===============0221745767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0221745767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0221745767==--
