From: "Markus Rechberger" <mrechberger@gmail.com>
Subject: ATI Technologies Inc SBx00 Azalia
Date: Fri, 11 Jan 2008 15:47:56 +0100
Message-ID: <d9def9db0801110647s2f9005bbi977e1f5a981b4fdf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.236])
	by alsa0.perex.cz (Postfix) with ESMTP id 561AB2458F
	for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2008 15:47:58 +0100 (CET)
Received: by nz-out-0506.google.com with SMTP id m22so610041nzf.2
	for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2008 06:47:57 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

there seems to be an issue with this ATI SBx00 Azalia driver.

nmixer (which uses the oss emulated interface shows up 4 controls)
Vol (volume which seems to control the whole output volume)
PCM2 (maybe not routed on that notebook, it practically has no effect)
IGain (guess for the microphone which I haven't tested yet)
Digital1 (don't know)

if I try to start alsamixer, it doesn't seem to work and I get an
entry in dmesg whenever I try to run it:
$ alsamixer
alsamixer: function snd_mixer_load failed: Invalid argument

$ dmesg
...
[ 1269.997724] hda_codec: num_steps = 0 for NID=0x12

$ lspci
00:14.2 Audio device: ATI Technologies Inc SBx00 Azalia

$ lspci -vvvn
00:14.2 0403: 1002:4383
        Subsystem: 1002:4383
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size: 32 bytes
        Interrupt: pin ? routed to IRQ 16
        Region 0: Memory at f0300000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


----

$ arecord -l
 **** List of CAPTURE Hardware Devices ****
card 0: SB [HDA ATI SB], device 0: ALC262 Analog [ALC262 Analog]
  Subdevices: 2/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
card 0: SB [HDA ATI SB], device 2: ALC262 Analog [ALC262 Analog]
  Subdevices: 2/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1

----
$ arecord -L
default:CARD=SB
    HDA ATI SB, ALC262 Analog
    Default Audio Device
front:CARD=SB,DEV=0
    HDA ATI SB, ALC262 Analog
    Front speakers
surround40:CARD=SB,DEV=0
    HDA ATI SB, ALC262 Analog
    4.0 Surround output to Front and Rear speakers
surround41:CARD=SB,DEV=0
    HDA ATI SB, ALC262 Analog
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=SB,DEV=0
    HDA ATI SB, ALC262 Analog
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=SB,DEV=0
    HDA ATI SB, ALC262 Analog
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=SB,DEV=0
    HDA ATI SB, ALC262 Analog
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=SB,DEV=0
    HDA ATI SB, ALC262 Digital
    IEC958 (S/PDIF) Digital Audio Output
null
    Discard all samples (playback) or generate zero samples (capture)


----

$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: SB [HDA ATI SB], device 0: ALC262 Analog [ALC262 Analog]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
card 0: SB [HDA ATI SB], device 1: ALC262 Digital [ALC262 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

----

$ aplay -L
**** List of PLAYBACK Hardware Devices ****
card 0: SB [HDA ATI SB], device 0: ALC262 Analog [ALC262 Analog]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
card 0: SB [HDA ATI SB], device 1: ALC262 Digital [ALC262 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
root@osrc-laptop:/devel/alsa/alsa-driver# aplay -L
default:CARD=SB
    HDA ATI SB, ALC262 Analog
    Default Audio Device
front:CARD=SB,DEV=0
    HDA ATI SB, ALC262 Analog
    Front speakers
surround40:CARD=SB,DEV=0
    HDA ATI SB, ALC262 Analog
    4.0 Surround output to Front and Rear speakers
surround41:CARD=SB,DEV=0
    HDA ATI SB, ALC262 Analog
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=SB,DEV=0
    HDA ATI SB, ALC262 Analog
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=SB,DEV=0
    HDA ATI SB, ALC262 Analog
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=SB,DEV=0
    HDA ATI SB, ALC262 Analog
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
null
    Discard all samples (playback) or generate zero samples (capture)

----

root@laptop:/proc/asound# cat cards
 0 [SB             ]: HDA-Intel - HDA ATI SB
                      HDA ATI SB at 0xf0300000 irq 16
root@laptop:/proc/asound# cat devices
  0: [ 0]   : control
  1:        : sequencer
  7: [ 0- 3]: hardware dependent
 16: [ 0- 0]: digital audio playback
 17: [ 0- 1]: digital audio playback
 24: [ 0- 0]: digital audio capture
 26: [ 0- 2]: digital audio capture
 33:        : timer
root@laptop:/proc/asound# cat hwdep
00-03: HDA Codec 3
root@laptop:/proc/asound# cat meminfo
kmalloc: 53165 bytes
root@osrc-laptop:/proc/asound# cat modules
 0 snd_hda_intel
root@laptop:/proc/asound# cat pcm
00-02: ALC262 Analog : ALC262 Analog : capture 2
00-01: ALC262 Digital : ALC262 Digital : playback 1
00-00: ALC262 Analog : ALC262 Analog : playback 1 : capture 2
root@laptop:/proc/asound# cat version
Advanced Linux Sound Architecture Driver Version 1.0.15.
Compiled on Jan 11 2008 for kernel 2.6.23-rc6 (SMP).

maybe someone has more insight in that intel-hda driver.

thanks & best regards,
Markus
