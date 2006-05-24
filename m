From: "John Matthews" <jm169@ohm.york.ac.uk>
Subject: Via 82xx Drivers
Date: Wed, 24 May 2006 13:27:50 +0100
Message-ID: <001b01c67f2d$7d4ecd10$0601a8c0@johnspc>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0018_01C67F35.DAFC9B60"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

------=_NextPart_000_0018_01C67F35.DAFC9B60
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Greetings,

I am writing to describe a problem I have involving the snd-via82xx =
audio drivers on 2.6 kernels.  I have updated to the latest alsa-drivers =
to no avail.

Everything works fine, apart from one small issue.  Certain programs =
have strange clicks at certain points.  The main example is with =
fluidsynth http://www.nongnu.org/fluid/   When a note is turned off =
there is a very loud click which can be louder than the note was - the =
same type of click that happens when you turn a channel on or off.

This doesn't happen with any other sound card that I have tried (tried a =
few others including snd-ice1712 on an m-audio delta 410).  It also =
doesn't happen with the via binary oss style drivers,  "viaudiocombo" =
which are available from via's website.

The clicks do happen (suprisingly) in exactly the same places with =
fluidsynth running into jack into snd-via82xx.

I have tried this on various different boards I have around, although =
they are all types of VIA epia mini-itx boards.

I have also tried dxs_support=3D1, dxs_support=3D2,dxs_support=3D3, =
dxs_support=3D4 and this doesn't help.

It may well be the same problem which was noted here.  =
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D1667

Its meant that I have to use the viaudiocombo drivers for this purpose, =
and I'd rather use the nice up to date alsa ones!

Please, I would be grateful for any help or thoughts - I am an =
experienced coder, though I've never worked with device drivers before,

Thanks,

John Matthews,
University of York

------=_NextPart_000_0018_01C67F35.DAFC9B60
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2873" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2><FONT face=3DArial =
size=3D2>Greetings,</FONT></DIV>
<DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I am writing to describe a problem I =
have involving=20
the snd-via82xx audio drivers on 2.6 kernels.&nbsp; I have updated =
to&nbsp;the=20
latest alsa-drivers&nbsp;to no avail.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Everything works fine, apart from one =
small=20
issue.&nbsp; Certain programs have strange clicks at certain =
points.&nbsp; The=20
main example is with fluidsynth <FONT color=3D#008000><A=20
href=3D"http://www.nongnu.org/fluid/">http://www.nongnu.org/fluid/</A></F=
ONT><FONT=20
color=3D#000000>&nbsp;&nbsp; When a note is turned off there is a very =
loud click=20
which can be louder than the note was - the same type of click that =
happens when=20
you turn a channel on or off.</FONT></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>This doesn't happen with any other =
sound card that=20
I have tried (tried a few others including snd-ice1712 on an =
m-audio&nbsp;delta=20
410).&nbsp; It also doesn't happen with the via binary oss style =
drivers,&nbsp;=20
"viaudiocombo"&nbsp;which are available from via's website.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>The clicks&nbsp;do happen (suprisingly) =
in exactly=20
the same places with fluidsynth running into jack into =
snd-via82xx.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV>I have tried this on various different boards I have around, =
although they=20
are all types of VIA epia mini-itx boards.</DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have also tried dxs_support=3D1,=20
dxs_support=3D2,dxs_support=3D3, dxs_support=3D4 and this doesn't =
help.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>It may well be the same problem which =
was noted=20
here.&nbsp; </FONT><FONT face=3DArial size=3D2><A=20
href=3D"https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D1667">ht=
tps://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D1667</A></FONT></D=
IV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Its meant that I have to use the =
viaudiocombo=20
drivers for this purpose, and I'd rather use the nice up to date alsa=20
ones!</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Please, I would be grateful for any =
help or=20
thoughts - I am an experienced coder, though I've never worked with =
device=20
drivers before,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>John Matthews,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>University of York</FONT></DIV>
<DIV>&nbsp;</DIV></FONT></DIV></BODY></HTML>

------=_NextPart_000_0018_01C67F35.DAFC9B60--



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
