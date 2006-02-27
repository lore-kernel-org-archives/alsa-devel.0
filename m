From: "Adrian McMenamin" <adrian@mcmen.demon.co.uk>
Subject: PCM driver only plays tiny portion of clip
Date: Mon, 27 Feb 2006 16:07:06 -0000 (GMT)
Message-ID: <44054.217.150.108.178.1141056426.squirrel@newgolddream.dyndns.info>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk [81.1.65.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 8C81D190
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2006 17:07:13 +0100 (MET)
Received: from newgolddream.dyndns.info (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.1) with ESMTP id k1RG76sj026578
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2006 16:07:06 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

My driver (for sound on the Sega Dreamcast) will now play the first part
of a pcm sound =96 eg if I do the following:

cat hal.wav > /dev/dsp

I get the =93I=92m sorry=94 bit of =93I=92m sorry Dave I can=92t do that=94=
 =96 I am using
the oss emulation because I cannot get aplay to work on my system.

The clip however is stuck in an endless loop (in a sense this is the
expected behaviour =96 the sound system on the dreamcast normally loops o=
ver
its buffer until told to do otherwise) and most of the =93playback=94 is
silence.

As the DMA transfer to the sound memory is working, it looks like the
first 32k (or maybe just 4k =96 the period size) of the clip is transferr=
ed
but nothing else.

How do I let my driver know that it has played a period and therefore it
needs to load more into the buffer?

At the moment the following seems to be happening:

Create buffer in DMA space in main CPU addressed area
    |
    |
Transfer contents of buffer into memory space of sound chip via DMA
    |
    |
Start playback
    |
    |
Fire interrupt for period played


Then it gets stuck in a loop =96 the interrupt is fired and handled but
nothing else seems to happen.

I=92m a bit stuck and this might not be very clear, but any clues?




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
