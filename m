From: "Peter Antypas" <peter@joyfaktory.com>
Subject: ad1888 as in ASUS P4R800-VM motherboards
Date: Sat, 14 Feb 2004 09:26:46 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <002f01c3f317$58b65e90$6601a8c0@peterlaptop>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_002C_01C3F2DC.AA97AE20"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------=_NextPart_000_002C_01C3F2DC.AA97AE20
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I 've had no luck in using the cvs version with the ad1888 update. In =
fact, I can't even load snd-intel8x0.
I thought the intel8x0 module was supposed to work here?

cat /proc/pci reveals a PCI id of 1002:4341 with I/O at 0xfbe00000 to =
0xfbe000ff. It reports the device is (ATI Technologies) (rev 0)
grepping through the CVS source (checked out today) for "1002" or "4341" =
reveals nothing.

I added the PCI ids to snd-intel8x0 and it fails to grab the specified =
I/O ports. What could be the problem here?

TIA


Peter Antypas

Principal
Joy Faktory, LLC
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
www.joyfaktory.com
(303) 877-2404 ph
(303) 736-4183 fax
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
------=_NextPart_000_002C_01C3F2DC.AA97AE20
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1400" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>I 've had no luck in using the cvs =
version with the=20
ad1888 update. In fact, I can't even load snd-intel8x0.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I thought the intel8x0=20
module&nbsp;was&nbsp;supposed to work here?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>cat /proc/pci reveals a PCI id of =
</FONT><FONT=20
face=3DArial size=3D2>1002:4341 with I/O at 0xfbe00000 to 0xfbe000ff. It =
reports the=20
device is (ATI Technologies) (rev 0)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>grepping through the CVS source =
(checked out today)=20
for "1002" or "4341" reveals nothing.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I added the PCI ids to snd-intel8x0 and =
it fails to=20
grab the specified I/O ports. What could be the problem =
here?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>TIA</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Peter Antypas</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Principal<BR>Joy Faktory,=20
LLC<BR>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<BR><A=20
href=3D"http://www.joyfaktory.com">www.joyfaktory.com</A><BR>(303) =
877-2404=20
ph<BR>(303) 736-4183=20
fax<BR>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D</FONT></DIV></BODY></HTML>

------=_NextPart_000_002C_01C3F2DC.AA97AE20--



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
