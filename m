From: Olivier Langlois <olivier@trillion01.com>
Subject: Only stereo output possible with ATI Tahiti XT HDMI
 Audio [Radeon HD 7970 Series] [1002:aaa0]
Date: Mon, 13 May 2013 23:15:19 -0400
Message-ID: <1368501319.18787.18.camel@Wailaba2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy12-pub.bluehost.com (oproxy12-pub.bluehost.com
 [50.87.16.10]) by alsa0.perex.cz (Postfix) with SMTP id 494972616D8
 for <alsa-devel@alsa-project.org>; Tue, 14 May 2013 05:15:23 +0200 (CEST)
Received: from [173.178.230.31] (port=34726 helo=[192.168.1.104])
 by box610.bluehost.com with esmtpsa (TLSv1:CAMELLIA256-SHA:256)
 (Exim 4.80) (envelope-from <olivier@trillion01.com>)
 id 1Uc5hx-0002Dh-Cg
 for alsa-devel@alsa-project.org; Mon, 13 May 2013 21:15:21 -0600
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


I have an HDMI chain with a Radeon card on 1 side and a 1080P monitor at the other end with a Pioner SC-09TX A/V Receiver in the middle.

Video is transmitted fine.
2 channels pcm plays fine on the receiver.

I am totally unable to output sound with 8 channels.

lano1106@whippet2 /proc/asound/card0 $ speaker-test -c8

speaker-test 1.0.27

Playback device is default
Stream parameters are 48000Hz, S16_LE, 8 channels
Using 16 octaves of pink noise
Channels count (8) not available for playbacks: Invalid argument
Setting of hwparams failed: Invalid argument

My neophyte instinct tells me that the problem is interoperability issue between the Radeon Audio controller and the SC-09TX receiver.
That would be great to be able to tweak the hda driver to workaround the problem but if I was able to manually program the hda codec module
to accept 8 channel LPCM input, that would be good enough for me.

My understanding is that in the advent of HDMI handshake failure, the sound source fallbacks to the bare minimum requirement that the HDMI
standard requires.

I have started to read Intel HDA manual. What I would like to know is:

Is it known if my particular HDA device is able to output 48KHz 8 channels LPCM? would it configurable manually?

Which HDA verbs should get familiar with if I want to tweak the code to configure the controller manually?

Thank you,
Olivier


lano1106@whippet2 ~ $ lspci -nn | grep Audio
01:00.1 Audio device [0403]: Advanced Micro Devices [AMD] nee ATI Tahiti XT HDMI Audio [Radeon HD 7970 Series] [1002:aaa0]

Linux: 3.8.12

alsalib:1.0.27

lano1106@whippet2 /proc/asound/card0 $ dmesg | grep ALSA
[    6.351490] ALSA sound/pci/hda/hda_intel.c:2848 0000:01:00.1: Handle VGA-switcheroo audio client
[    6.351491] ALSA sound/pci/hda/hda_intel.c:3040 0000:01:00.1: Using LPIB position fix
[    6.351493] ALSA sound/pci/hda/hda_intel.c:3157 0000:01:00.1: Force to non-snoop mode
[    6.351619] ALSA sound/pci/hda/hda_intel.c:3282 0000:01:00.1: chipset global capabilities = 0x0
[    6.354036] ALSA sound/pci/hda/hda_intel.c:1131 0000:01:00.1: codec_mask = 0x1
[    6.354061] ALSA sound/pci/hda/hda_intel.c:1600 0000:01:00.1: codec #0 probed OK
[    6.354062] ALSA sound/pci/hda/hda_intel.c:1716 0000:01:00.1: Enable sync_write for stable communication
[    6.411369] ALSA sound/pci/hda/patch_hdmi.c:1173 HDMI status: Codec=0 Pin=3 Presence_Detect=0 ELD_Valid=0
[    6.411397] ALSA sound/pci/hda/patch_hdmi.c:1173 HDMI status: Codec=0 Pin=5 Presence_Detect=0 ELD_Valid=0
[    6.411424] ALSA sound/pci/hda/patch_hdmi.c:1173 HDMI status: Codec=0 Pin=7 Presence_Detect=0 ELD_Valid=0
[    6.411453] ALSA sound/pci/hda/patch_hdmi.c:1173 HDMI status: Codec=0 Pin=9 Presence_Detect=0 ELD_Valid=0
[    6.411482] ALSA sound/pci/hda/patch_hdmi.c:1173 HDMI status: Codec=0 Pin=11 Presence_Detect=0 ELD_Valid=0
[    6.411512] ALSA sound/pci/hda/patch_hdmi.c:1173 HDMI status: Codec=0 Pin=13 Presence_Detect=0 ELD_Valid=0
[   29.487577] ALSA sound/pci/hda/patch_hdmi.c:951 HDMI hot plug event: Codec=0 Pin=3 Presence_Detect=1 ELD_Valid=0
[   29.487593] ALSA sound/pci/hda/patch_hdmi.c:1173 HDMI status: Codec=0 Pin=3 Presence_Detect=1 ELD_Valid=1
[   29.487605] ALSA sound/pci/hda/hda_eld.c:337 HDMI: ELD buf size is 0, force 128
[   29.487617] ALSA sound/pci/hda/hda_eld.c:356 HDMI: invalid ELD data byte 0

lano1106@whippet2 /proc/asound/card0 $ cat eld#0.0
monitor_present         1
eld_valid               0

lano1106@whippet2 /proc/asound/card0 :( $ cat codec#0 
Codec: ATI R6xx HDMI
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x1002aa01
Subsystem Id: 0x00aa0100
Revision Id: 0x100300
No Modem Function Group found
Default PCM:
    rates [0x70]: 32000 44100 48000
    bits [0x2]: 16
    formats [0x5]: PCM AC3
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x02 [Audio Output] wcaps 0x221: Stereo Digital Stripe
  Converter: stream=1, channel=0
  Digital: Enabled
  Digital category: 0x0
  IEC Coding Type: 0x0
Node 0x03 [Pin Complex] wcaps 0x400381: Stereo Digital
  Control: name="HDMI/DP,pcm=3 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=0, device=0
  Control: name="IEC958 Playback Pro Mask", index=0, device=0
  Control: name="IEC958 Playback Default", index=0, device=0
  Control: name="IEC958 Playback Switch", index=0, device=0
  Control: name="ELD", index=0, device=3
  Pincap 0x00000094: OUT Detect HDMI
  Pin Default 0x185600f0: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=01, enabled=1
  Connection: 1
     0x02
Node 0x04 [Audio Output] wcaps 0x221: Stereo Digital Stripe
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
Node 0x05 [Pin Complex] wcaps 0x400381: Stereo Digital
  Control: name="HDMI/DP,pcm=7 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=1, device=0
  Control: name="IEC958 Playback Pro Mask", index=1, device=0
  Control: name="IEC958 Playback Default", index=1, device=0
  Control: name="IEC958 Playback Switch", index=1, device=0
  Control: name="ELD", index=0, device=7
  Pincap 0x00000094: OUT Detect HDMI
  Pin Default 0x185600f0: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=02, enabled=1
  Connection: 1
     0x04
Node 0x06 [Audio Output] wcaps 0x221: Stereo Digital Stripe
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
Node 0x07 [Pin Complex] wcaps 0x400381: Stereo Digital
  Control: name="HDMI/DP,pcm=8 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=2, device=0
  Control: name="IEC958 Playback Pro Mask", index=2, device=0
  Control: name="IEC958 Playback Default", index=2, device=0
  Control: name="IEC958 Playback Switch", index=2, device=0
  Control: name="ELD", index=0, device=8
  Pincap 0x00000094: OUT Detect HDMI
  Pin Default 0x185600f0: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=03, enabled=1
  Connection: 1
     0x06
Node 0x08 [Audio Output] wcaps 0x221: Stereo Digital Stripe
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
Node 0x09 [Pin Complex] wcaps 0x400381: Stereo Digital
  Control: name="HDMI/DP,pcm=9 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=3, device=0
  Control: name="IEC958 Playback Pro Mask", index=3, device=0
  Control: name="IEC958 Playback Default", index=3, device=0
  Control: name="IEC958 Playback Switch", index=3, device=0
  Control: name="ELD", index=0, device=9
  Pincap 0x00000094: OUT Detect HDMI
  Pin Default 0x185600f0: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=04, enabled=1
  Connection: 1
     0x08
Node 0x0a [Audio Output] wcaps 0x221: Stereo Digital Stripe
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
Node 0x0b [Pin Complex] wcaps 0x400381: Stereo Digital
  Control: name="HDMI/DP,pcm=10 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=4, device=0
  Control: name="IEC958 Playback Pro Mask", index=4, device=0
  Control: name="IEC958 Playback Default", index=4, device=0
  Control: name="IEC958 Playback Switch", index=4, device=0
  Control: name="ELD", index=0, device=10
  Pincap 0x00000094: OUT Detect HDMI
  Pin Default 0x185600f0: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=05, enabled=1
  Connection: 1
     0x0a
Node 0x0c [Audio Output] wcaps 0x221: Stereo Digital Stripe
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
Node 0x0d [Pin Complex] wcaps 0x400381: Stereo Digital
  Control: name="HDMI/DP,pcm=11 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=5, device=0
  Control: name="IEC958 Playback Pro Mask", index=5, device=0
  Control: name="IEC958 Playback Default", index=5, device=0
  Control: name="IEC958 Playback Switch", index=5, device=0
  Control: name="ELD", index=0, device=11
  Pincap 0x00000094: OUT Detect HDMI
  Pin Default 0x185600f0: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=06, enabled=1
  Connection: 1
     0x0c

whippet2 /sys/kernel/debug/tracing # cat trace_pipe
     kworker/u:5-130   [002] ...1 79390.094652: hda_send_cmd: [0:0] val=3f0900
     kworker/u:5-130   [002] ...1 79390.094665: hda_get_response: [0:0] val=ffffffff
     kworker/u:5-130   [002] ...1 79390.094667: hda_send_cmd: [0:0] val=3f2e08
     kworker/u:5-130   [002] ...1 79390.094677: hda_get_response: [0:0] val=0
     kworker/u:5-130   [002] ...1 79390.094679: hda_send_cmd: [0:0] val=3f2f00
     kworker/u:5-130   [002] ...1 79390.094689: hda_get_response: [0:0] val=0
     kworker/u:5-130   [002] ...1 79390.394001: hda_send_cmd: [0:0] val=3f2e08
     kworker/u:5-130   [002] ...1 79390.394045: hda_get_response: [0:0] val=0
     kworker/u:5-130   [002] ...1 79390.394050: hda_send_cmd: [0:0] val=3f2f00
     kworker/u:5-130   [002] ...1 79390.394071: hda_get_response: [0:0] val=0
     kworker/u:5-130   [002] ...1 79390.694227: hda_send_cmd: [0:0] val=3f2e08
     kworker/u:5-130   [002] ...1 79390.694281: hda_get_response: [0:0] val=0
     kworker/u:5-130   [002] ...1 79390.694286: hda_send_cmd: [0:0] val=3f2f00
     kworker/u:5-130   [002] ...1 79390.694307: hda_get_response: [0:0] val=0
     kworker/u:5-130   [000] ...1 28163.617406: hda_send_cmd: [0:0] val=3f2e08
     kworker/u:5-130   [000] ...1 28163.617420: hda_get_response: [0:0] val=0
     kworker/u:5-130   [000] ...1 28163.617425: hda_send_cmd: [0:0] val=3f2f00
     kworker/u:5-130   [000] ...1 28163.617436: hda_get_response: [0:0] val=0
     kworker/u:5-130   [000] ...1 28163.917628: hda_send_cmd: [0:0] val=3f2e08
     kworker/u:5-130   [000] ...1 28163.917642: hda_get_response: [0:0] val=0
     kworker/u:5-130   [000] ...1 28163.917647: hda_send_cmd: [0:0] val=3f2f00
     kworker/u:5-130   [000] ...1 28163.917657: hda_get_response: [0:0] val=0
     kworker/u:5-130   [000] ...1 28164.217846: hda_send_cmd: [0:0] val=3f2e08
     kworker/u:5-130   [000] ...1 28164.217860: hda_get_response: [0:0] val=0
     kworker/u:5-130   [000] ...1 28164.217865: hda_send_cmd: [0:0] val=3f2f00
     kworker/u:5-130   [000] ...1 28164.217875: hda_get_response: [0:0] val=0
     kworker/u:5-130   [000] ...1 28164.518101: hda_send_cmd: [0:0] val=3f2e08
     kworker/u:5-130   [000] ...1 28164.518115: hda_get_response: [0:0] val=0
     kworker/u:5-130   [000] ...1 28164.518119: hda_send_cmd: [0:0] val=3f2f00
     kworker/u:5-130   [000] ...1 28164.518130: hda_get_response: [0:0] val=0
     kworker/u:5-130   [000] ...1 28164.818310: hda_send_cmd: [0:0] val=3f2e08
     kworker/u:5-130   [000] ...1 28164.818323: hda_get_response: [0:0] val=0
     kworker/u:5-130   [000] ...1 28164.818328: hda_send_cmd: [0:0] val=3f2f00
     kworker/u:5-130   [000] ...1 28164.818339: hda_get_response: [0:0] val=0
     kworker/u:5-130   [000] ...1 28165.118549: hda_send_cmd: [0:0] val=3f2e08
     kworker/u:5-130   [000] ...1 28165.118563: hda_get_response: [0:0] val=0
     kworker/u:5-130   [000] ...1 28165.118568: hda_send_cmd: [0:0] val=3f2f00
     kworker/u:5-130   [000] ...1 28165.118579: hda_get_response: [0:0] val=0
