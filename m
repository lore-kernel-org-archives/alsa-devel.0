From: Jan Willies <jan@willies.info>
Subject: em8300 and ALSA problems
Date: Mon, 04 Feb 2008 16:32:29 +0100
Message-ID: <47A7300D.3010907@willies.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from will39.synserver.de (will39.synserver.de [212.40.172.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 7BE6B24467
	for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2008 16:33:25 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: dxr3-devel@lists.sourceforge.net
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I really want pulseaudio badly and since it doesn't work very good with OSS output, I decided to switch to ALSA. However, I'm running into some problems with ALSA. My dxr3 (em8300) card seems to be detected by ALSA (/proc/asound/cards lists it too): 

[root@server ~]# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: I82801BAICH2 [Intel 82801BA-ICH2], device 0: Intel ICH [Intel 82801BA-ICH2]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: EM8300 [Sigma Designs' EM8300], device 0: EM8300/0 [EM8300 DAC]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: EM8300 [Sigma Designs' EM8300], device 1: EM8300/1 [EM8300 IEC958]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

But for some reason it won't play anything:

[root@server ~]# alsaplayer --verbose -o alsa -d hw:1,0 Strong.mp3 
AlsaPlayer 0.99.80
(C) 1999-2004 Andy Lo A Foe <andy@alsaplayer.org> and others.
Output plugin: ALSA output v1.9.0beta12
error on set_format SND_PCM_FORMAT_S16
Unavailable hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_BE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: [32000 48000]
PERIOD_TIME: (21333 32000]
PERIOD_SIZE: 1024
PERIOD_BYTES: 4096
PERIODS: [2 256]
BUFFER_TIME: (42666 8192000]
BUFFER_SIZE: [2048 262144]
BUFFER_BYTES: [8192 1048576]
TICK_TIME: ALL
error on set_format SND_PCM_FORMAT_S16
Unavailable hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_BE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: [32000 48000]
PERIOD_TIME: (21333 32000]
PERIOD_SIZE: 1024
PERIOD_BYTES: 4096
PERIODS: [2 256]
BUFFER_TIME: (42666 8192000]
BUFFER_SIZE: [2048 262144]
BUFFER_BYTES: [8192 1048576]
TICK_TIME: ALL
failed to configure output device...trying OSS
error opening /dev/dsp
Failed to initialize plugin!
Failed to register plugin: /usr/lib/alsaplayer/output/liboss_out.so
failed to load output plugin (alsa). exitting...

I don't really have a clue what's going on. People on #alsa didn't either. Here's a link to tsalsa output: http://nopaste.com/p/a0NYa75gW

The module was loaded with options em8300 dicom_fix=1 dicom_control=1 dicom_other_pal=1 audio_driver=alsa. I'm running em8300-0.16.4-rc1


- Jan
