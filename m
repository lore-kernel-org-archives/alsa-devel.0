From: Mark Ziegler <info.mz@gmx.de>
Subject: Re: alsa-devel@lists.sourceforge.net
Date: Thu, 21 Nov 2002 20:56:33 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200211212056.33194.info.mz@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Kai,

thank you. You are right: my ide-dma is turned off. I only activated it i=
n the=20
SUSE setup, but I've never check if it is really switched on.
Unfortunately I can not turn on the dma:

linux:/home/woody # hdparm -m 8 -d 1 -u 1 -c 1 /dev/hda
/dev/hda:
 setting 32-bit IO_support flag to 1
 setting multcount to 8
 setting unmaskirq to 1 (on)
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 multcount    =3D  8 (on)
 IO_support   =3D  1 (32-bit)
 unmaskirq    =3D  1 (on)
 using_dma    =3D  0 (off)

Ok, this is probably because I've bought a brandnew motherboard with a=20
brandnew chipset (VIA KT400). So I will seek around for a dma solution.=20
Anyway, I tried again ecasound:
woody@linux:~> ecasound  -z:db -z:intbuf -i alsa,ice_spdif -o test.wav
*************************************************************************=
***
*               ecasound v2.0.4 (C) 1997-2001 Kai Vehmanen               =
  *
*************************************************************************=
***
(eca-chainsetup) Using double-buffer of 100000 sample frames.
(eca-chainsetup) Enabling extra buffering on realtime devices.
- [ Chainsetup/Enabling audio inputs ] ----------------------------------=
---
(eca-audio-objects) Audio object "alsa", mode "read".
(audio-io) Format: s16_le, channels 2, srate 44100, interleaved.
- [ Chainsetup/Enabling audio outputs ] ---------------------------------=
---
(eca-audio-objects) Audio object "test.wav", mode "read/write".
(audio-io) Format: s16_le, channels 2, srate 44100, interleaved.
- [ Engine/Init - mixmode "simple" ] ------------------------------------=
---
(eca-main) Prefilling i/o buffers.
(audioio-alsa3) warning! capture overrun - samples lost!  Break was at le=
ast=20
7.60 ms long.
(audioio-alsa3) warning! capture overrun - samples lost!  Break was at le=
ast=20
215.45 ms long.
(audioio-alsa3) warning! capture overrun - samples lost!  Break was at le=
ast=20
0.03 ms long.
- [ Engine/Exiting ] ----------------------------------------------------=
---
(audioio-alsa3) WARNING! While reading from ALSA-pcm device C0D0, there w=
ere 3=20
overruns.

That was only 1 Minute sampling.  Sometimes I get up to 500ms. That looks=
=20
strange to me. Mmmh, I should really hurry up getting my dma to work.=20
215ms!!!

But thank you very much

  Mark





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
