From: "Zierath Bernd" <B.Zierath@ebv.com>
Subject: RE: AC3 passthru intel8x0 + cs4299
Date: Fri, 28 Feb 2003 11:31:33 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <51420C40A341F14499B8C5A488BEDA5801B795@EXSRV02.int.ebv.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
content-class: urn:content-classes:message
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

Hi,

here are my current config

lspci -v

00:1f.5 Multimedia audio controller: Intel Corp. 82801AA AC'97 Audio =
(rev 02)
        Subsystem: Siemens Nixdorf AG: Unknown device 0051
        Flags: bus master, medium devsel, latency 0, IRQ 5
        I/O ports at 2000 [size=3D256]
        I/O ports at 1800 [size=3D64]
-------------
0-0/0: Cirrus Logic CS4299 rev 4

Capabilities     : -headphone out-
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Crystal Semi 3D Stereo Enhancement

Current setup
Mic gain         : +20dB [+20dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : on
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=3D0 rev=3D0 AMAP DSA=3D0 VRA
Extended status  : VRA
PCM front DAC    : 48000Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Copyright Category=3D0x2 Generation=3D1 =
Rate=3D48kHz E
nabled
-------------
0:00 =3D 1990
0:02 =3D 1313
0:04 =3D 1f1f
0:06 =3D 001f
0:08 =3D 0000
0:0a =3D 001e
0:0c =3D 001f
0:0e =3D 005f
0:10 =3D 1f1f
0:12 =3D 1f1f
0:14 =3D 1f1f
0:16 =3D 1f1f
0:18 =3D 1f1f
0:1a =3D 0000
0:1c =3D 0000
0:1e =3D 0000
0:20 =3D 2000
0:22 =3D 0000
0:24 =3D 0000
0:26 =3D 000f
0:28 =3D 0201
0:2a =3D 0001
0:2c =3D bb80
0:2e =3D 0000
0:30 =3D 0000
0:32 =3D bb80
0:34 =3D 0000
0:36 =3D 0000
0:38 =3D 0000
0:3a =3D 0000
0:3c =3D 0000
0:3e =3D 0000
0:40 =3D 0000
0:42 =3D 0000
0:44 =3D 0000
0:46 =3D 0000
0:48 =3D 0000
0:4a =3D 0000
0:4c =3D 0000
0:4e =3D 0000
0:50 =3D 0000
0:52 =3D 0000
0:54 =3D 0000
0:56 =3D ffff
0:58 =3D 0000
0:5a =3D 0404
0:5c =3D 0000
0:5e =3D 0080
0:60 =3D 0022
0:62 =3D 0000
0:64 =3D 0000
0:66 =3D 0000
0:68 =3D 8824
0:6a =3D 0000
0:6c =3D 0000
0:6e =3D 0000
0:70 =3D 0000
0:72 =3D 0000
0:74 =3D 0000
0:76 =3D 0000
0:78 =3D 007e
0:7a =3D 0000
0:7c =3D 4352
0:7e =3D 5934
-------------
Intel8x0

Global control        : 0x00000002
Global status         : 0x00000100
AC'97 codecs ready    : primary
-------------
0 [82801AAICH     ]: ICH - Intel 82801AA-ICH
                     Intel 82801AA-ICH at 0x2000, irq 5
--------------
  0: [0- 0]: ctl
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
 33:       : timer
---------------
pcm
00-00: Intel ICH : Intel 82801AA-ICH : playback 1 : capture 1
---------------

what I'm trying , change no audio bit to 1 reg 0x68 in ac97_codec.c =
snd_ac97_spdif_default_put().
but I get errors in
intel8x0: clocking to 48000
ALSA ../alsa-kernel/pci/intel8x0.c:521: codec_semaphore: semaphore is =
not ready[0x1][0x100]
ALSA ../alsa-kernel/pci/intel8x0.c:553: codec_read 0: semaphore is not =
ready for register 0x56

I try activate the SPSA control in snd_ac97_mixer_build() like cs4205.

I also have no clue right now about the registers 0x30 and 0x34.=20
0x34 is maybe Codec Write Semaphore Register

CU
Bernd Zierath


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
