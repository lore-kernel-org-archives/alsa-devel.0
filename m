From: "Allyn, Mark A" <mark.a.allyn@intel.com>
Subject: Relationship between bluttooth audio,
	usb audio and alsa drivers
Date: Tue, 6 Feb 2007 14:50:07 -0800
Message-ID: <5FD5754DDBA0B1499B5A0B4BB541948585D079@fmsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1344560745=="
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

--===============1344560745==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C74A41.26C311BB"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C74A41.26C311BB
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello:
=20
I am having an interesting situation where I have upgraded the audio
drivers, library, and utils from 1.0.10 to the current dev release of
1.0.14rc2 and ended up breaking the bluetooth audio and usb audio
drivers.
=20
The device that I have is an Intel HDA device with the STAC 9202 Codec.
When I attempted to run alsaconf, it would cause a kernel oops within
the blutooth audio driver. When I took that audio driver out (deleted it
and then re-ran depmod), then I found a kernel oops in the usb audio
driver (which accesses the microphone in a USB camera). When I deleted
that driver, I was able to run the alsaconf command.
=20
How are the bluetooth and usb audio drivers integrated with alsa? If I
do a find within alsa, I do not find any source files for the bluetooth
driver. How does that driver know the data structures of the alsa that
is installed? What do I have to re-compile upon installing a new alsa
besides the alsa-driver, alsa-library, and alsa-utils components of the
newest alsa from the alsa download site?
=20
Thank you
=20
Truly,
=20
Mark Allyn

------_=_NextPart_001_01C74A41.26C311BB
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2912" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D181133922-06022007><FONT face=3DArial=20
size=3D2>Hello:</FONT></SPAN></DIV>
<DIV><SPAN class=3D181133922-06022007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D181133922-06022007><FONT face=3DArial size=3D2>I am =
having an=20
interesting situation where I have upgraded the audio drivers, library, =
and=20
utils from 1.0.10 to the current dev release of 1.0.14rc2 and ended up =
breaking=20
the bluetooth audio and usb audio drivers.</FONT></SPAN></DIV>
<DIV><SPAN class=3D181133922-06022007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D181133922-06022007><FONT face=3DArial size=3D2>The =
device that I=20
have is an Intel HDA device with the&nbsp;STAC&nbsp;9202&nbsp;Codec. =
When I=20
attempted to run alsaconf, it would cause a kernel oops within the =
blutooth=20
audio driver. When I took that audio driver out (deleted it and then =
re-ran=20
depmod), then I found a kernel oops in the usb audio driver (which =
accesses the=20
microphone in a USB camera). When I deleted that driver, I was able to =
run the=20
alsaconf command.</FONT></SPAN></DIV>
<DIV><SPAN class=3D181133922-06022007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D181133922-06022007><FONT face=3DArial size=3D2>How =
are the=20
bluetooth and usb audio drivers integrated with alsa? If I do a find=20
within&nbsp;alsa, I do not find any source files for the bluetooth =
driver. How=20
does that driver know the data structures of the alsa that is installed? =
What do=20
I have to re-compile upon installing a new alsa besides the alsa-driver, =

alsa-library, and alsa-utils components of the newest alsa from the alsa =

download site?</FONT></SPAN></DIV>
<DIV><SPAN class=3D181133922-06022007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D181133922-06022007><FONT face=3DArial size=3D2>Thank=20
you</FONT></SPAN></DIV>
<DIV><SPAN class=3D181133922-06022007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D181133922-06022007><FONT face=3DArial=20
size=3D2>Truly,</FONT></SPAN></DIV>
<DIV><SPAN class=3D181133922-06022007></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D181133922-06022007><FONT face=3DArial size=3D2>Mark=20
Allyn</FONT></SPAN></DIV></BODY></HTML>

------_=_NextPart_001_01C74A41.26C311BB--


--===============1344560745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1344560745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1344560745==--
