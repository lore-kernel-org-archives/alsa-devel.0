From: "Allyn, Mark A" <mark.a.allyn@intel.com>
Subject: Bluetooth audio driver causing kernel oops with
	alsa-driver-hg20070206
Date: Wed, 7 Feb 2007 10:06:20 -0800
Message-ID: <5FD5754DDBA0B1499B5A0B4BB541948585D5D7@fmsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1572480155=="
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

--===============1572480155==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C74AE2.ABC3BC61"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C74AE2.ABC3BC61
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello:
=20
I have tried the snapshot, alsa-driver-hg20070206, on a system running
Red Flag and that has a sigmatel 2202 Codec on the Intel-hda device. The
kernel is 2.6.17.
=20
The enclosed dmesg output shows a kernel oops that happened when I tried
to run the alsaconf command. It appears that the problem is in the
snd_bt_sco_volume_get function (which is within the btsco driver).=20
=20
I am wondering, can this be due to a structure mismatch between the
btsco driver and the Alsa tree? I tried searching for btsco within alsa
and could not find it.=20
=20
Who is responsible for the btsco audio driver?
=20
Thank you
=20
Mark Allyn

------_=_NextPart_001_01C74AE2.ABC3BC61
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2912" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D265125917-07022007>Hello:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D265125917-07022007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D265125917-07022007>I have =
tried the=20
snapshot, alsa-driver-hg20070206, on a system running Red Flag and that =
has a=20
sigmatel 2202 Codec on the Intel-hda device. The kernel is=20
2.6.17.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D265125917-07022007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D265125917-07022007>The =
enclosed dmesg=20
output shows a kernel oops that happened when I tried to run the =
alsaconf=20
command. It appears that the problem is in the snd_bt_sco_volume_get =
function=20
(which is within the btsco driver). </SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D265125917-07022007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D265125917-07022007>I am =
wondering, can=20
this be due to a structure mismatch between the btsco driver and the =
Alsa tree?=20
I tried searching for btsco within alsa and could not find it.=20
</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D265125917-07022007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D265125917-07022007>Who is =
responsible=20
for the btsco audio driver?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D265125917-07022007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D265125917-07022007>Thank=20
you</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D265125917-07022007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D265125917-07022007>Mark=20
Allyn</SPAN></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C74AE2.ABC3BC61--


--===============1572480155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1572480155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1572480155==--
