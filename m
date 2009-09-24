From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: Problem with mplayer and OSS on at91sam9g20(kernel
	2.6.30)
Date: Thu, 24 Sep 2009 14:36:26 +0200
Message-ID: <4ABB67CA.6000003@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atmel-es2.atmel.fr (mail.atmel.fr [81.80.104.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D9E72448E
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Sep 2009 14:36:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi,

We've been doing some tests here and we noticed a problem when using 
mplayer that we didn't have previously(on 2.6.27).

While playing audio through OSS emulation on 2.6.30 / at91sam9g20ek 
there seems to be issue with hardware parameters. The sound does not 
play and a bunch of error messages are comming on the console.

Here is the test case on angstrom:

-- mplayer output sample -------------------------

mplayer -quiet myfile.mp3

MPlayer 1.0rc1-4.1.2 (C) 2000-2006 MPlayer Team
CPU: ARM
Playing /media/sda/audio/01.mp3.
[..]
AUDIO: 44100 Hz, 2 ch, s16le, 192.0 kbit/13.61% (ratio: 24000->176400)
Selected audio codec: [mad] afm: libmad (libMAD MPEG layer 1-2-3)
[AO OSS]setup: driver doesn't support SNDCTL_DSP_GETOSPACE :-(

-- kernel output sample -------------------------

Atmel_ssc_dai: Entering atmel_ssc_hw_params()
natmel_ssc_hw_params: RCMR=00010420 RFMR=001f008f TCMR=4a010404 
TFMR=001f008f
atmel_ssc_dai: Starting clock
atmel_ssc_dai,hw_params: SSC initialized
Atmel_ssc_dai: Entering atmel_ssc_hw_params()
atmel_ssc_hw_params: RCMR=00010420 RFMR=001f008f TCMR=4a010404 TFMR=001f008f
atmel_ssc_dai,hw_params: SSC initialized
Atmel_ssc_dai: Entering atmel_ssc_hw_params()
atmel_ssc_hw_params: RCMR=00010420 RFMR=001f018f TCMR=4a010404 TFMR=001f018f
atmel_ssc_dai,hw_params: SSC initialized
asoc: machine hw_params failed
asoc: machine hw_params failed
asoc: machine hw_params failed
asoc: machine hw_params failed
asoc: machine hw_params failed
asoc: machine hw_params failed
asoc: machine hw_params failed
[..]
asoc: machine hw_params failed

MPlayer interrupted by signal 2 in module: ao2_init
atmel_ssc_shutdown: transmit disabled SSC_SR=0x000004cc
atmel_ssc_dau: Stopping clock
soc-audio soc-audio: shutdown
pop wq checking: Playback status: inactive waiting: yes
pop wq D1 WM8731 Playback
pop wq D3 WM8731 Playback

-- 2 error messages to note -------------------------
mplayer:
"[AO OSS]setup: driver doesn't support SNDCTL_DSP_GETOSPACE :-("

kernel:
"asoc: machine hw_params failed"


=> please note also that it is working correctly using the alsa output:
mplayer -ao alsa myfile.mp3

Here is the log while using the alsa output (it is working in this case):

root@at91sam:~$ mplayer -quiet -ao alsa /media/sda/audio/01.mp3
MPlayer 1.0rc1-4.1.2 (C) 2000-2006 MPlayer Team
CPU: ARM

Playing /media/sda/audio/01.mp3.
Audio file file format detected.
Clip info:
  Title: Angel
  Artist: Massive Attack
  Album: Mezzanine
  Year: 1998
  Comment: Ripped by Beto
  Track: 1
  Genre: Rock
==========================================================================
Forced audio codec: mad
Opening audio decoder: [libmad] libmad mpeg audio decoder
AUDIO: 44100 Hz, 2 ch, s16le, 192.0 kbit/13.61% (ratio: 24000->176400)
Selected audio codec: [mad] afm: libmad (libMAD MPEG layer 1-2-3)
==========================================================================
atmel_ssc_startup: SSC_SR=0x204
asoc: WM8731 <-> atmel-ssc0 info:
asoc: rate mask 0x6fe
asoc: min ch 1 max ch 2
asoc: min rate 8000 max rate 96000
Atmel_ssc_dai: Entering atmel_ssc_hw_params()
atmel_ssc_hw_params: RCMR=00010420 RFMR=001f018f TCMR=19010404 TFMR=001f018f
atmel_ssc_dai: Starting clock
atmel_ssc_dai,hw_params: SSC initialized
transmit enabled SSC_SR=0x000104cf
AO: [alsa] 44100Hz 2ch s16le (2 bytes per sample)
Video: no video
Starting playback...
[..]
atmel_ssc_shutdown: transmit disabled SSC_SR=0x000104c3
atmel_ssc_dau: Stopping clock
soc-audio soc-audio: shutdown
Exiting... (Quit)

pop wq checking: Playback status: inactive waiting: yes
pop wq D1 WM8731 Playback
pop wq D3 WM8731 Playback


egards,
Sedji
