From: Grzegorz Chwesewicz <grzegorz.chwesewicz@chilan.com>
Subject: No recording on hda-intel (AD1981HD)
Date: Sun, 3 Feb 2008 20:17:38 +0100
Message-ID: <200802032017.38614.grzegorz.chwesewicz@chilan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.chilan.com (mail.chilan.com [82.160.213.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 9171D10386C
	for <alsa-devel@alsa-project.org>; Sun,  3 Feb 2008 20:18:16 +0100 (CET)
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

	Hi. I have a problem with recording on HP nx6325 laptop with hda-intel 
(AD1981HD codec). The problem is described in [1], and [2], but nobody can 
help there, so I write here (maybe more developers reads mailing-list ;)).

Problem is that arecord, audacity or skype stops recording after 5-10 min. 
Unloading and loading modules helps, but only for another 5-10 min. What info 
do you need to debug the problem ?

PS. HG version differs only three patches (not related to the bug) from 
1.0.16rc2, so I didn't try HG.

References:

[1] https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2449
[2] https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3542
[3] http://www.analog.com/en/prod/0,2877,AD1981HD,00.html (codec data sheet)

Here is output from lspci:

################# BEGIN ##################################
00:14.2 Audio device: ATI Technologies Inc SB450 HDA Audio (rev 01)
        Subsystem: Unknown device 30b0:103c
        Flags: bus master, slow devsel, latency 64, IRQ 16
        Memory at 88000000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ 
Queue=0/0 Enable-
################ END #####################################

Here is output from cat /proc/asound/card0/codec#0:

################# BEGIN ##################################

Codec: Analog Devices AD1981
Address: 0
Vendor Id: 0x11d41981
Subsystem Id: 0x103c30b0
Revision Id: 0x100200
No Modem Function Group found
Default PCM:
    rates [0x7f]: 8000 11025 16000 22050 32000 44100 48000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
Default Amp-Out caps: ofs=0x3d, nsteps=0x3f, stepsize=0x05, mute=1
GPIO: io=4, o=0, i=0, unsolicited=1, wake=0
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=1
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=1
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0
  IO[3]: enable=0, dir=0, wake=0, sticky=0, data=1
Node 0x02 [Audio Output] wcaps 0x30311: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x60]: 44100 48000
    bits [0x2]: 16
    formats [0x5]: PCM AC3
  Delay: 3 samples
  Connection: 2
     0x01* 0x04
Node 0x03 [Audio Output] wcaps 0x441: Stereo
  Converter: stream=5, channel=0
  Power: setting=D0, actual=D0
  Processing caps: benign=1, ncoeff=70
Node 0x04 [Audio Input] wcaps 0x100511: Stereo
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x7f]: 8000 11025 16000 22050 32000 44100 48000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Power: setting=D0, actual=D0
  Connection: 1
     0x15
Node 0x05 [Pin Complex] wcaps 0x400187: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x3d, nsteps=0x3f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x38 0x38]
  Pincap 0x081173f: IN OUT HP EAPD Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  EAPD 0x2: EAPD
  Pin Default 0x92174110: [Fixed] Speaker at Int Front
    Conn = Analog, Color = Green
    DefAssociation = 0x1, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Connection: 2
     0x03 0x0e*
Node 0x06 [Pin Complex] wcaps 0x400185: Stereo Amp-Out
  Amp-Out caps: ofs=0x3d, nsteps=0x3f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x38 0x38]
  Pincap 0x081f: OUT HP Detect Trigger ImpSense
  Pin Default 0x0421201f: [Jack] HP Out at Ext Right
    Conn = 1/8, Color = Grey
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=37, enabled=1
  Connection: 2
     0x03 0x0e*
Node 0x07 [Pin Complex] wcaps 0x400104: Mono Amp-Out
  Amp-Out caps: ofs=0x3d, nsteps=0x3f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80]
  Pincap 0x0810: OUT
  Pin Default 0x410710f0: [N/A] Line Out at Ext Rear
    Conn = Analog, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0f
Node 0x08 [Pin Complex] wcaps 0x400083: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:
  Pincap 0x081727: IN Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x04a12020: [Jack] Mic at Ext Right
    Conn = 1/8, Color = Grey
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=38, enabled=1
Node 0x09 [Pin Complex] wcaps 0x400187: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x3d, nsteps=0x3f, stepsize=0x05, mute=1
  Amp-Out vals:  [0xbf 0xbf]
  Pincap 0x081737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x0181302e: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0x2, Sequence = 0xe
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Connection: 2
     0x03* 0x0e
Node 0x0a [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x4145f0f0: [N/A] SPDIF Out at Ext Rear
    Conn = Optical, Color = Other
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x02
Node 0x0b [Audio Selector] wcaps 0x300101: Stereo
  Connection: 6
     0x03 0x0c 0x09 0x0e* 0x05 0x18
Node 0x0c [Audio Mixer] wcaps 0x200101: Stereo
  Connection: 2
     0x1e 0x1f
Node 0x0d [Audio Selector] wcaps 0x30010c: Mono Amp-Out
  Amp-Out caps: ofs=0x0f, nsteps=0x0f, stepsize=0x0b, mute=1
  Amp-Out vals:  [0x80]
  Connection: 2
     0x10* 0x16
Node 0x0e [Audio Mixer] wcaps 0x200101: Stereo
  Connection: 8
     0x0d 0x11 0x12 0x13 0x1a 0x1b 0x1c 0x1d
Node 0x0f [Audio Mixer] wcaps 0x200100: Mono
  Connection: 1
     0x0b
Node 0x10 [Beep Generator Widget] wcaps 0x700000: Mono
Node 0x11 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x1f 0x1f]
  Connection: 1
     0x03
Node 0x12 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 1
     0x08
Node 0x13 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 1
     0x09
Node 0x14 [Power Widget] wcaps 0x500500: Mono
  Power: setting=D0, actual=D0
  Connection: 13
     0x0d* 0x0e 0x0f 0x10 0x13 0x14 0x15 0x16 0x17 0x18 0x19 0x1a 0x1d
Node 0x15 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x00 0x00]
  Connection: 8
     0x0c* 0x09 0x0e 0x0f 0x19 0x05 0x18 0x17
Node 0x16 [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x0820: IN
  Pin Default 0x995711f0: [Fixed] Digital Out at Int ATAPI
    Conn = Analog, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x17 [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x0827: IN Detect Trigger ImpSense
  Pin Default 0x5993e0f0: [N/A] Aux at Int ATAPI
    Conn = ATAPI, Color = White
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x20: IN
  Unsolicited: tag=00, enabled=0
Node 0x18 [Pin Complex] wcaps 0x400187: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x3d, nsteps=0x3f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x081737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x91a79121: [Fixed] Mic at Int Rear
    Conn = Analog, Color = Pink
    DefAssociation = 0x2, Sequence = 0x1
    Misc = NO_PRESENCE
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
  Connection: 2
     0x03* 0x0e
Node 0x19 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x593310f0: [N/A] CD at Int ATAPI
    Conn = ATAPI, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x20: IN
Node 0x1a [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 1
     0x05
Node 0x1b [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 1
     0x17
Node 0x1c [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 1
     0x18
Node 0x1d [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 1
     0x19
Node 0x1e [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 1
     0x08
Node 0x1f [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Connection: 1
     0x18

################ END #####################################

# uname -a
Linux ensima-hp 2.6.24 #18 SMP PREEMPT Sun Feb 3 01:19:45 CET 2008 i686 AMD 
Turion(tm) 64 X2 Mobile Technology TL-56 AuthenticAMD GNU/Linux

# cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.16rc2 (Thu Jan 31 
16:40:16 2008 UTC)

alsa-headers-1.0.16_rc2
alsa-lib-1.0.16_rc2
alsa-utils-1.0.16_rc1

-- 
Greetings
Grzegorz Chwesewicz, Chilan 
mailto:grzegorz.chwesewicz@chilan.com
