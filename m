From: "Guillaume Badaut" <guillaume.badaut@wanadoo.fr>
Subject: Can't get the ens1370 second playback device working
Date: Tue, 6 Apr 2004 11:54:45 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <002101c41bbd$30fa3790$4f00a8c0@rythme2601paqn>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_001E_01C41BCD.F425CC60"
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

------=_NextPart_000_001E_01C41BCD.F425CC60
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

 I am using a SoundBlaster PCI 128 card (ens1370) that has 2 stereo =
output ports. I can use the first one, but I can't use the second one.
In /proc/asound/card0/, I can see : pcm0c, pcm0p and pcm1p.

So I tried to do :

aplay -D hw:0,1 audio.wav

But the sound I get output from the first output port, not the second.

aplay -D hw:0,1 ...

has the same effect as:

aplay -D hw:0,0 ...

Is there a bug in the ens1370 driver ? Or I am missing something ?

Guillaume Badaut.



------=_NextPart_000_001E_01C41BCD.F425CC60
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
<BODY bgColor=3D#ffffff><FONT size=3D2>&nbsp;</FONT>I am using a =
SoundBlaster PCI=20
128 card (ens1370) that has 2 stereo output ports. I can use the first =
one, but=20
I can't use the second one.
<P>In /proc/asound/card0/, I can see : pcm0c, pcm0p and pcm1p.</P>
<P>So I tried to do :</P>
<P>aplay -D hw:0,1 audio.wav</P>
<P>But the sound I get output from the first output port, not the =
second.</P>
<P>aplay -D hw:0,1 ...</P>
<P>has the same effect as:</P>
<P>aplay -D hw:0,0 ...</P>
<P>Is there a bug in the ens1370 driver ? Or I am missing something =
?</P>
<P>Guillaume Badaut.</P>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_001E_01C41BCD.F425CC60--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
