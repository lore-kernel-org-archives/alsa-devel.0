From: "Amar" <amar@ptank.com>
Subject: Broken pipe error es1371
Date: Wed, 10 Jul 2002 21:31:28 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <001201c22893$d42abf30$6401a8c0@ltamar>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000F_01C22859.266C7E40"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------=_NextPart_000_000F_01C22859.266C7E40
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi.  I hope this is the right place to send this, considering the dearth =
of messages in the archive for 2002.

I have been getting the following error from my newly-ALSA-aware =
application:

ALSA lib pcm_hw.c:384:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed: =
Broken pipe

I am using alsa driver and library version 1.0rc1 and more specifically =
the es1371 driver.
The hardware settings I am using are:

stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44101 (1445100000/32768)
msbits       : 16
buffer_size  : 512
period_size  : 64
period_time  : 1451
tick_time    : 10000

It was working a couple of days, and then suddenly stopped working.  Any =
ideas?

Thanks and regards,
     Amar

amar@ptank.com


------=_NextPart_000_000F_01C22859.266C7E40
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2716.2200" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi.&nbsp; I hope this is the right =
place to send=20
this, considering the dearth of messages in the archive for =
2002.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have been getting the following error =
from my=20
newly-ALSA-aware application:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>ALSA lib =
pcm_hw.c:384:(snd_pcm_hw_start)=20
SNDRV_PCM_IOCTL_START failed: Broken pipe<BR></FONT><FONT face=3DArial=20
size=3D2></DIV></FONT>
<DIV><FONT face=3DArial size=3D2>I am using alsa driver and library =
version 1.0rc1=20
and more specifically the es1371 driver.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>The hardware settings I am using =
are:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial =
size=3D2>stream&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=20
PLAYBACK<BR>access&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=20
RW_INTERLEAVED<BR>format&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=20
S16_LE<BR>subformat&nbsp;&nbsp;&nbsp; : =
STD<BR>channels&nbsp;&nbsp;&nbsp;&nbsp;=20
: 2<BR>rate&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : =
44100<BR>exact=20
rate&nbsp;&nbsp; : 44101=20
(1445100000/32768)<BR>msbits&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :=20
16<BR>buffer_size&nbsp; : 512<BR>period_size&nbsp; : =
64<BR>period_time&nbsp; :=20
1451<BR>tick_time&nbsp;&nbsp;&nbsp; : 10000<BR></FONT></DIV>
<DIV><FONT face=3DArial size=3D2>It was working a couple of days, and =
then suddenly=20
stopped working.&nbsp; Any ideas?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks and regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp;&nbsp; =
Amar</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><A=20
href=3D"mailto:amar@ptank.com">amar@ptank.com</A></FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;</DIV></FONT></BODY></HTML>

------=_NextPart_000_000F_01C22859.266C7E40--




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
PC Mods, Computing goodies, cases & more
http://thinkgeek.com/sf
