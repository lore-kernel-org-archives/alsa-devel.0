From: "Daniel Schnell" <daniel.schnell@gmx.net>
Subject: Q: is the ALSA-lib API thread-safe
Date: Thu, 5 Aug 2004 09:57:00 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1e2101c47ac1$ca702340$2c0aa8c0@lumpidu>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_1E1E_01C47AD2.8D665030"
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

------=_NextPart_000_1E1E_01C47AD2.8D665030
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

is the ALSA-Lib-API thread-safe concerning the following scenario:


in thread 1 the audio-processing takes place via snd_pcm_avail_update(), =

snd_pcm_begin(), snd_pcm_commit(). In thread 2 I call the functions:=20
snd_pcm_hwsync(), snd_pcm_avail_update() to get the actual delay via
bufferframes - snd_pcm_avail_update(). Should I lock these calls or
should I use instead snd_pcm_avail() in thread 2 ?
Is there any difference concerning thread-safety between the hw: layer =
or the plug: layer ?

Confused,

Ciao,

Daniel.

------=_NextPart_000_1E1E_01C47AD2.8D665030
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
<DIV><FONT face=3DArial size=3D2><FONT face=3D"Times New Roman" =
size=3D3>Hi,<BR><BR>is=20
the ALSA-Lib-API thread-safe concerning the following =
scenario:<BR><BR><BR>in=20
thread 1 the audio-processing takes place via snd_pcm_avail_update(),=20
</FONT></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><FONT face=3D"Times New Roman"=20
size=3D3>snd_pcm_begin(), snd_pcm_commit(). In thread 2 I call the =
functions:=20
</FONT></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><FONT face=3D"Times New Roman"=20
size=3D3>snd_pcm_hwsync(), snd_pcm_avail_update() to get the actual =
delay=20
via</FONT></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><FONT face=3D"Times New Roman" =
size=3D3>bufferframes -=20
snd_pcm_avail_update(). Should I lock these calls or</FONT></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><FONT face=3D"Times New Roman" =
size=3D3>should I use=20
instead snd_pcm_avail() in thread 2 ?</FONT></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><FONT face=3D"Times New Roman" =
size=3D3>Is there any=20
difference concerning thread-safety between the hw: layer or the plug: =
layer=20
?<BR><BR>Confused,<BR><BR>Ciao,<BR><BR>Daniel.</FONT><BR></DIV></FONT></B=
ODY></HTML>

------=_NextPart_000_1E1E_01C47AD2.8D665030--



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
