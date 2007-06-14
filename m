From: Robert Lemmen <robertle@semistable.com>
Subject: hda-intel without headphone output
Date: Thu, 14 Jun 2007 10:31:56 +0200
Message-ID: <20070614083156.GB26945@sandbender>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from d80-237-144-212.dds.hosteurope.de (debian.semistable.com
	[80.237.144.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 78A8210382F
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Jun 2007 10:37:31 +0200 (CEST)
Received: from sandbender (dslb-084-057-002-141.pools.arcor-ip.net
	[84.57.2.141])
	by d80-237-144-212.dds.hosteurope.de (Postfix) with ESMTP id
	472A7405E007 for <alsa-devel@alsa-project.org>;
	Thu, 14 Jun 2007 10:37:30 +0200 (CEST)
Received: from robertle by sandbender with local (Exim 4.63)
	(envelope-from <robertle@semistable.com>) id 1HykkG-0007LB-3S
	for alsa-devel@alsa-project.org; Thu, 14 Jun 2007 10:31:56 +0200
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

hi everyone,

i have a fujitsu siemens amilo pro v3515 notebook, with a via VT8251/
VT8237A chipset. sound works fine through the speakers, but i don't get
anything through the headphones, no headphone channel shows up in the
mixer, and the headphone jack switch doesn't mute the speakers. i have
alsa 1.0.13, and a 2.6.18 kernel. i tried all "model" settings that i
could find in ALSA-Configuration in the kernel tree. lspci -nv gives

04:01.0 0403: 1106:3288 (rev 10)
        Subsystem: 1734:10cb
        Flags: bus master, fast devsel, latency 0, IRQ 58
        Memory at c9100000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [70] Express Unknown type IRQ 0

(only the stanza for the sound card, yell if you need more), and /proc/asound/card0/codec#0 gives:

Codec: Generic 14f1 ID 5045
Address: 0
Vendor Id: 0x14f15045
Subsystem Id: 0x173410cb
Revision Id: 0x100100
Default PCM: rates 0x140, bits 0x0e, types 0x1
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
Node 0x10 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x2b, nsteps=0x2b, stepsize=0x05, mute=1
  Amp-Out vals:  [0x28 0x28]
  Pincap 0x0810014: OUT EAPD Detect
  Pin Default 0x92170110: [Fixed] Speaker at Int Front
    Conn = Analog, Color = Unknown
  Pin-ctls: 0x40: OUT
  Power: 0x0
  Connection: 2
     0x19* 0x17
Node 0x11 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x2b, nsteps=0x2b, stepsize=0x05, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x08113c: IN OUT HP Detect
  Pin Default 0x0121401f: [Jack] HP Out at Ext Rear
    Conn = 1/8, Color = Green
  Pin-ctls: 0xc0: OUT HP
  Power: 0x0
  Connection: 2
     0x19* 0x17
Node 0x12 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x2b, nsteps=0x2b, stepsize=0x05, mute=1
  Amp-Out vals:  [0xab 0xab]
  Pincap 0x08113c: IN OUT HP Detect
  Pin Default 0x01a19020: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x20: IN
  Power: 0x0
  Connection: 2
     0x19* 0x17
Node 0x13 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x214571f0: [Jack] SPDIF Out at Sep Rear
    Conn = Optical, Color = Yellow
  Pin-ctls: 0x00:
  Connection: 1
     0x18
Node 0x14 [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x081124: IN Detect
  Pin Default 0x97a7012e: [Fixed] Mic at Int Riser
    Conn = Analog, Color = Unknown
  Pin-ctls: 0x20: IN
Node 0x15 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x400001f0: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
Node 0x16 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x07, nsteps=0x07, stepsize=0x0b, mute=1
  Amp-Out vals:  [0x06]
Node 0x17 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Amp-In caps: ofs=0x14, nsteps=0x2b, stepsize=0x05, mute=1
  Amp-In vals:  [0x94 0x94] [0x17 0x17] [0x94 0x94] [0x94 0x94] [0x94 0x94]
  Power: 0x0
  Connection: 5
     0x19 0x14 0x12 0x11 0x15
Node 0x18 [Audio Output] wcaps 0x211: Stereo Digital
  PCM: rates 0x040, bits 0x06, types 0x5
Node 0x19 [Audio Output] wcaps 0xc11: Stereo
  PCM: rates 0x540, bits 0x0e, types 0x1
  Power: 0x0
Node 0x1a [Audio Input] wcaps 0x100d0b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x17, stepsize=0x05, mute=1
  Amp-In vals:  [0x17 0x17] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Power: 0x0
  Connection: 5
     0x17 0x14 0x12 0x11 0x15*
Node 0x1b [Vendor Defined Widget] wcaps 0xf00000: Mono
 
please tell me if there is anything i can do, any additional 
information you need, or any general tipps.

thanks  robert

-- 
Robert Lemmen                               http://www.semistable.com 
