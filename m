From: "Raja M." <raja.mallik@moschip.com>
Subject: ALSA PCM core Q's
Date: Sun, 26 Feb 2006 11:50:42 +0530
Message-ID: <E044F591B954D84186173DB5134357A13C6E9E@lexus.moschip.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C63A9C.C51AC354"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
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

------_=_NextPart_001_01C63A9C.C51AC354
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


At present, I am involved in porting an SOC based audio controller(i2s) =
that has standalone codec chip(for ADC/DAC).=20

To my understanding, Alsa driver has four main harward components: =
PCM(for audio data stream), Control(for mixer arrangenment in terms of =
codec the audio controller uses), MIDI interface, Sequencer.

What I have observered in different embedded board is they have =
different ways to capture/playback data of audio stream like dma, mmap =
and others methods of directly copying audio controller hardware buffer =
into PCM substream of ALSA core.=20

However I would like to copy Rx/Tx FIFO hardware buffers to the PCM core =
and my board doesnot have dma/mmap support. How do I go ahead with this =
approach as I am very new to this?

Regards
Raja

------_=_NextPart_001_01C63A9C.C51AC354
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>ALSA PCM core Q's</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>At present, I am involved in porting an SOC based =
audio controller(i2s) that has standalone codec chip(for ADC/DAC).<BR>
<BR>
To my understanding, Alsa driver has four main harward components: =
PCM(for audio data stream), Control(for mixer arrangenment in terms of =
codec the audio controller uses), MIDI interface, Sequencer.<BR>
<BR>
What I have observered in different embedded board is they have =
different ways to capture/playback data of audio stream like dma, mmap =
and others methods of directly copying audio controller hardware buffer =
into PCM substream of ALSA core.<BR>
<BR>
However I would like to copy Rx/Tx FIFO hardware buffers to the PCM core =
and my board doesnot have dma/mmap support. How do I go ahead with this =
approach as I am very new to this?<BR>
<BR>
Regards<BR>
Raja</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C63A9C.C51AC354--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
