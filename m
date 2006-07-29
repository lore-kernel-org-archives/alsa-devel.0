From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002076]: arecord gives silence
Date: Sat, 29 Jul 2006 15:35:53 +0200
Message-ID: <199e2e93ad7a7388e9427f7a724ad026@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4100A166
	for <alsa-devel@alsa-project.org>;
	Sat, 29 Jul 2006 15:35:53 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D2076> =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Reported By:                jaime
Assigned To:                =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Project:                    ALSA - driver
Issue ID:                   2076
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               =

Kernel Version:             =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             04-26-2006 16:28 CEST
Last Modified:              07-29-2006 15:35 CEST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary:                    arecord gives silence
Description: =

IBM Thinkpad T21 with Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion
Audio Accelerator] (rev 01).

alsamixer correctly mixes the inputs over to the line out (I can hear
microphone in and line in successfully mixed) but arecord gives silence.

I've tried using a usb soundcard on the same machine, and everything works
fine there, so I think this is only the snd-cs46xx driver.

I'm not sure what other info is useful - please let me know. Thank you.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------------------------------------
 Raymond - 06-29-06 09:32 =

----------------------------------------------------------------------
Refer to https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D371#9010

Does it mean mean dsnoop is also not work with the hardware like CS46xx
due to its design ?


static struct snd_pcm_hardware snd_cs46xx_capture =3D
{
	.info =3D			(SNDRV_PCM_INFO_MMAP |
				 SNDRV_PCM_INFO_INTERLEAVED |
				 SNDRV_PCM_INFO_BLOCK_TRANSFER /*|*/
				 /*SNDRV_PCM_INFO_RESUME*/),
	.formats =3D		SNDRV_PCM_FMTBIT_S16_LE,
	.rates =3D		SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_48000,
	.rate_min =3D		5500,
	.rate_max =3D		48000,
	.channels_min =3D		2,
	.channels_max =3D		2,



----------------------------------------------------------------------
 Fred - 07-29-06 15:35 =

----------------------------------------------------------------------
I've the same system, enabled sound recording via ADC Volume in alsactl and
did the same test. The two first are OK, third is false

Subsystem: IBM Thinkpad T20

0000:00:05.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24
[CrystalClear SoundFusion Audio Accelerator] (rev 01)
	Subsystem: IBM: Unknown device 0132
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f4100000 (32-bit, non-prefetchable) [size=3D4K]
	Region 1: Memory at f4000000 (32-bit, non-prefetchable) [size=3D1M]
	Capabilities: <available only to root>


00-00: CS46xx : CS46xx : playback 31 : capture 1
00-01: CS46xx - Rear : CS46xx - Rear : playback 31
00-02: CS46xx - IEC958 : CS46xx - IEC958 : playback 1
Enregistrement en cours WAVE 'test1.wav' : Signed 16 bit Little Endian,
Taux 44100 Hz, St=E9r=E9o
Hardware PCM card 0 'Sound Fusion CS46xx' device 0 subdevice 0

Its setup is:
stream       : CAPTURE
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 16384
period_size  : 512
period_time  : 11609
tick_time    : 4000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 512
xfer_align   : 512
start_threshold  : 1
stop_threshold   : 16384
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
Termin=E9 par le signal Interruption...
Enregistrement en cours WAVE 'test2.wav' : Signed 16 bit Little Endian,
Taux 44100 Hz, St=E9r=E9o
Plug PCM: Hardware PCM card 0 'Sound Fusion CS46xx' device 0 subdevice 0

Its setup is:
stream       : CAPTURE
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 16384
period_size  : 512
period_time  : 11609
tick_time    : 4000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 512
xfer_align   : 512
start_threshold  : 1
stop_threshold   : 16384
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
Termin=E9 par le signal Interruption...
Enregistrement en cours WAVE 'test3.wav' : Signed 16 bit Little Endian,
Taux 44100 Hz, St=E9r=E9o
Plug PCM: Rate conversion PCM (48000, sformat=3DS16_LE)
Its setup is:
stream       : CAPTURE
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 7526
period_size  : 470
period_time  : 10666
tick_time    : 0
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 470
xfer_align   : 470
start_threshold  : 1
stop_threshold   : 7526
silence_threshold: 0
silence_size : 0
boundary     : 986447872
Slave: Direct Snoop PCM

Its setup is:
stream       : CAPTURE
access       : MMAP_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 48000
exact rate   : 48000 (48000/1)
msbits       : 16
buffer_size  : 8192
period_size  : 512
period_time  : 10666
tick_time    : 0
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 512
xfer_align   : 512
start_threshold  : 1
stop_threshold   : 8192
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
Hardware PCM card 0 'Sound Fusion CS46xx' device 0 subdevice 0

Its setup is:
stream       : CAPTURE
access       : MMAP_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 48000
exact rate   : 48000 (48000/1)
msbits       : 16
buffer_size  : 8192
period_size  : 512
period_time  : 10666
tick_time    : 4000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 512
xfer_align   : 512
start_threshold  : 1
stop_threshold   : 1073741824
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
Termin=E9 par le signal Interruption...

Issue History
Date Modified  Username       Field                    Change              =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
04-26-06 16:28 jaime          New Issue                                    =

05-02-06 18:11 tiwai          Note Added: 0009568                          =

05-04-06 12:11 jaime          Note Added: 0009613                          =

05-08-06 12:14 atler          Note Added: 0009645                          =

05-24-06 14:03 fuman          Issue Monitored: fuman                       =

06-29-06 03:29 Raymond        Note Added: 0010638                          =

06-29-06 03:30 Raymond        Note Edited: 0010638                         =

06-29-06 09:08 atler          Note Added: 0010642                          =

06-29-06 09:27 Raymond        Note Added: 0010643                          =

06-29-06 09:32 Raymond        Note Edited: 0010643                         =

07-29-06 15:35 Fred           Note Added: 0011306                          =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
