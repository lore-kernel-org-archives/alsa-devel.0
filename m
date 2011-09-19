From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: [RFC] Remove non-exist device and control from
	snd-ymfpci
Date: Mon, 19 Sep 2011 13:13:27 +0800
Message-ID: <CAN8ccibjZSqiMRg6bO+tSsdTZUNJ3Q6FFEF-sYsLf8np9SSY2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 0829B248DF
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Sep 2011 07:13:31 +0200 (CEST)
Received: by fxe22 with SMTP id 22so3663579fxe.38
	for <alsa-devel@alsa-project.org>; Sun, 18 Sep 2011 22:13:27 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

My ymf724f does not have spdif, only with ac97 stac9704

Is it feasible to remove playback device 2 (rear) and control (e.g. 4
ch Duplication) by checking sdac bit of ac97 registers to know that it
does not support 4 channels ?

How about device 1 spdif since this card does not have spdif connector ?

what is the difference of capture device 0 and device 3 ?



!!PCI Soundcards installed in the system
!!--------------------------------------

04:02.0 Multimedia audio controller: Yamaha Corporation YMF-724F [DS-1
Audio Controller] (rev 03)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

04:02.0 0401: 1073:000d (rev 03)
	Subsystem: 1073:000d




Simple mixer control 'IEC958',0
  Capabilities: cvolume pswitch pswitch-joined cswitch cswitch-joined penum
  Playback channels: Mono
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 16383
  Mono: Playback [off]
  Front Left: Capture 0 [0%] [-99999.99dB] [off]
  Front Right: Capture 0 [0%] [-99999.99dB] [off]
Simple mixer control 'IEC958 AC97',0
  Capabilities: pvolume penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 16383
  Mono:
  Front Left: Playback 16383 [100%] [0.00dB]
  Front Right: Playback 16383 [100%] [0.00dB]
Simple mixer control 'IEC958 AC97',1
  Capabilities: pvolume penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 16383
  Mono:
  Front Left: Playback 0 [0%] [-99999.99dB]
  Front Right: Playback 0 [0%] [-99999.99dB]
Simple mixer control 'IEC958 Loop',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958',1
  Capabilities: cvolume penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 16383
  Front Left: Capture 0 [0%] [-99999.99dB]
  Front Right: Capture 0 [0%] [-99999.99dB]

Simple mixer control '4ch Duplication',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'ADC',0
  Capabilities: pvolume cvolume penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 16383 Capture 0 - 16383
  Front Left: Playback 0 [0%] [-99999.99dB] Capture 16383 [100%] [0.00dB]
  Front Right: Playback 0 [0%] [-99999.99dB] Capture 16383 [100%] [0.00dB]
Simple mixer control 'ADC',1
  Capabilities: pvolume cvolume penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 16383 Capture 0 - 16383
  Front Left: Playback 0 [0%] [-99999.99dB] Capture 0 [0%] [-99999.99dB]
  Front Right: Playback 0 [0%] [-99999.99dB] Capture 0 [0%] [-99999.99dB]
Simple mixer control 'Digital',0
  Capabilities: cvolume penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 16383
  Front Left: Capture 16383 [100%] [0.00dB]
  Front Right: Capture 16383 [100%] [0.00dB]
Simple mixer control 'Digital',1
  Capabilities: cvolume penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 16383
  Front Left: Capture 16383 [100%] [0.00dB]
  Front Right: Capture 16383 [100%] [0.00dB]



**** List of PLAYBACK Hardware Devices ****
card 0: YMF724F [Yamaha DS-1 (YMF724F)], device 0: YMFPCI [YMFPCI]
  Subdevices: 32/32
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
  Subdevice #6: subdevice #6
  Subdevice #7: subdevice #7
  Subdevice #8: subdevice #8
  Subdevice #9: subdevice #9
  Subdevice #10: subdevice #10
  Subdevice #11: subdevice #11
  Subdevice #12: subdevice #12
  Subdevice #13: subdevice #13
  Subdevice #14: subdevice #14
  Subdevice #15: subdevice #15
  Subdevice #16: subdevice #16
  Subdevice #17: subdevice #17
  Subdevice #18: subdevice #18
  Subdevice #19: subdevice #19
  Subdevice #20: subdevice #20
  Subdevice #21: subdevice #21
  Subdevice #22: subdevice #22
  Subdevice #23: subdevice #23
  Subdevice #24: subdevice #24
  Subdevice #25: subdevice #25
  Subdevice #26: subdevice #26
  Subdevice #27: subdevice #27
  Subdevice #28: subdevice #28
  Subdevice #29: subdevice #29
  Subdevice #30: subdevice #30
  Subdevice #31: subdevice #31
card 0: YMF724F [Yamaha DS-1 (YMF724F)], device 1: YMFPCI - IEC958
[YMFPCI - IEC958]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: YMF724F [Yamaha DS-1 (YMF724F)], device 2: YMFPCI - Rear
[YMFPCI - Rear PCM]
  Subdevices: 1/1
  Subdevice #0: subdevice #0


ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: YMF724F [Yamaha DS-1 (YMF724F)], device 0: YMFPCI [YMFPCI]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: YMF724F [Yamaha DS-1 (YMF724F)], device 3: YMFPCI - PCM2
[YMFPCI - AC'97]
  Subdevices: 1/1
  Subdevice #0: subdevice #0




!!AC97 Codec information
!!---------------------------

0-0/0: SigmaTel STAC9704

PCI Subsys Vendor: 0x0000
PCI Subsys Device: 0x0000

Flags: 0
Capabilities     :
DAC resolution   : 18-bit
ADC resolution   : 18-bit
3D enhancement   : SigmaTel 3D Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off

0:00 = 6940
0:02 = 1313
0:04 = 8000
0:06 = 801f
0:08 = ffff
0:0a = 9f1f
0:0c = 801f
0:0e = 801f
0:10 = 9f1f
0:12 = 9f1f
0:14 = 9f1f
0:16 = 9f1f
0:18 = 0808
0:1a = 9818
0:1c = 0808
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = ffff
0:2a = ffff
0:2c = ffff
0:2e = ffff
0:30 = ffff
0:32 = ffff
0:34 = ffff
0:36 = ffff
0:38 = ffff
0:3a = ffff
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 0000
0:66 = 0000
0:68 = 0000
0:6a = 0000
0:6c = 0000
0:6e = 0000
0:70 = ffff
0:72 = ffff
0:74 = ffff
0:76 = ffff
0:78 = ffff
0:7a = ffff
0:7c = 8384
0:7e = 7605
