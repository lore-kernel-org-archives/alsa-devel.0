From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001793]: No sound on ASUS A8N-VM CSM
Date: Mon, 13 Mar 2006 17:39:47 +0100
Message-ID: <05b9e061cce6386ed42db81995cd5f25@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 17CB41B6
	for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2006 17:39:48 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been set as DUPLICATE OF issue 0001632.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1793> 
======================================================================
Reported By:                labene
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1793
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.15 standard
======================================================================
Date Submitted:             01-29-2006 18:31 CET
Last Modified:              03-13-2006 17:39 CET
======================================================================
Summary:                    No sound on ASUS A8N-VM CSM
Description: 
No sound on ASUS A8N-VM CSM, chipset nForce 430 (HDA nvidia) don't have
sound on the speaker but found by kernel 2.6.15 and exist with alsamixer
!
I don't any issue in the line :
options snd-hda-intel model=???? position_fix=1

I don't know where is the problem !


cat /proc/asound/cards :
0 [NVidia         ]: HDA-Intel - HDA NVidia
                     HDA NVidia at 0xfebd8000 irq 5

lspci -nv :


0000:00:00.0 0500: 10de:02f0 (rev a2)
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0
        Capabilities: <available only to root>

0000:00:00.1 0500: 10de:02fa (rev a2)
        Subsystem: 10de:cb84
        Flags: 66MHz, fast devsel

0000:00:00.2 0500: 10de:02fe (rev a2)
        Subsystem: 10de:cb84
        Flags: 66MHz, fast devsel

0000:00:00.3 0500: 10de:02f8 (rev a2)
        Subsystem: 10de:cb84
        Flags: 66MHz, fast devsel

0000:00:00.4 0500: 10de:02f9 (rev a2)
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0

0000:00:00.5 0500: 10de:02ff (rev a2)
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0
        Capabilities: <available only to root>

0000:00:00.6 0500: 10de:027f (rev a2)
        Subsystem: 10de:cb84
        Flags: 66MHz, fast devsel

0000:00:00.7 0500: 10de:027e (rev a2)
        Subsystem: 10de:cb84
        Flags: 66MHz, fast devsel

0000:00:02.0 0604: 10de:02fc (rev a1)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Capabilities: <available only to root>

0000:00:03.0 0604: 10de:02fd (rev a1)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        Capabilities: <available only to root>

0000:00:04.0 0604: 10de:02fb (rev a1)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        Capabilities: <available only to root>

0000:00:05.0 0300: 10de:0240 (rev a2)
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 11
        Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Memory at d0000000 (64-bit, prefetchable) [size=256M]
        Memory at fc000000 (64-bit, non-prefetchable) [size=16M]
        Expansion ROM at febe0000 [disabled] [size=128K]
        Capabilities: <available only to root>

0000:00:09.0 0500: 10de:0270 (rev a2)
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0
        Capabilities: <available only to root>

0000:00:0a.0 0601: 10de:0260 (rev a2)
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0

0000:00:0a.1 0c05: 10de:0264 (rev a2)
        Subsystem: 10de:cb84
        Flags: 66MHz, fast devsel, IRQ 5
        I/O ports at 0600 [size=64]
        I/O ports at 0700 [size=64]
        Capabilities: <available only to root>

0000:00:0b.0 0c03: 10de:026d (rev a2) (prog-if 10)
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 5
        Memory at febde000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: <available only to root>

0000:00:0b.1 0c03: 10de:026e (rev a2) (prog-if 20)
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 3
        Memory at febdfc00 (32-bit, non-prefetchable) [size=256]
        Capabilities: <available only to root>

0000:00:0d.0 0101: 10de:0265 (rev a1) (prog-if 8a [Master SecP PriP])
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0
        I/O ports at ffa0 [size=16]
        Capabilities: <available only to root>

0000:00:0e.0 0101: 10de:0266 (rev a1) (prog-if 85 [Master SecO PriO])
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 5
        I/O ports at e800 [size=8]
        I/O ports at e480 [size=4]
        I/O ports at e400 [size=8]
        I/O ports at e080 [size=4]
        I/O ports at e000 [size=16]
        Memory at febdd000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: <available only to root>

0000:00:0f.0 0101: 10de:0267 (rev a1) (prog-if 85 [Master SecO PriO])
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 5
        I/O ports at dc00 [size=8]
        I/O ports at d880 [size=4]
        I/O ports at d800 [size=8]
        I/O ports at d480 [size=4]
        I/O ports at d400 [size=16]
        Memory at febdc000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: <available only to root>

0000:00:10.0 0604: 10de:026f (rev a2) (prog-if 01)
        Flags: bus master, 66MHz, fast devsel, latency 0
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=128
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: faa00000-faafffff
        Capabilities: <available only to root>

0000:00:10.1 0403: 10de:026c (rev a2)
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 5
        Memory at febd8000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: <available only to root>

0000:00:18.0 0600: 1022:1100
        Flags: fast devsel
        Capabilities: <available only to root>

0000:00:18.1 0600: 1022:1101
        Flags: fast devsel

0000:00:18.2 0600: 1022:1102
        Flags: fast devsel

0000:00:18.3 0600: 1022:1103
        Flags: fast devsel

0000:04:05.0 0c00: 1106:3044 (rev 80) (prog-if 10)
        Subsystem: 1043:808a
        Flags: bus master, medium devsel, latency 128, IRQ 5
        Memory at faaff800 (32-bit, non-prefetchable) [size=2K]
        I/O ports at cc00 [size=128]
        Capabilities: <available only to root>

0000:04:08.0 0200: 10ec:8139 (rev 10)
        Subsystem: 10ec:8139
        Flags: bus master, medium devsel, latency 128, IRQ 5
        I/O ports at c800 [size=256]
        Memory at faaff400 (32-bit, non-prefetchable) [size=256]

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001632 suse 10.0,  yast, no ad1986a listed,  i...
======================================================================

----------------------------------------------------------------------
 labene - 01-29-06 18:54 
----------------------------------------------------------------------
lspci -nv


0000:00:10.1 0403: nVidia Corporation MCP51 High Definition Audio (rev
a2)
        Subsystem: nVidia Corporation: Unknown device cb84
<------------!!!!!
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (500ns min, 1250ns max)
        Interrupt: pin B routed to IRQ 5
        Region 0: Memory at febd8000 (32-bit, non-prefetchable)
[size=16K]
        Capabilities: <available only to root>

----------------------------------------------------------------------
 labene - 01-29-06 19:13 
----------------------------------------------------------------------
cat /proc/asound/devices
 17: [0- 1]: digital audio playback
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  0: [0- 0]: ctl
  1:       : sequencer
 33:       : timer

cat /proc/asound/pcm
00-00: AD198x Analog : AD198x Analog : playback 1 : capture 1
00-01: AD198x Digital : AD198x Digital : playback 1

cat /proc/asound/timers
G0: system timer : 1000.000us (10000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE
P0-1-0: PCM playback 0-1-0 : SLAVE


cat /proc/asound/card0/codec#0
Codec: Analog Devices AD1986A
Address: 0
Vendor Id: 0x11d41986
Subsystem Id: 0x104381b3
Revision Id: 0x100500
Default PCM: rates 0x07f, bits 0x0e, types 0x1
Default Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Default Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
Node 0x02 [Audio Output] wcaps 0x30311: Stereo Digital
  PCM: rates 0x060, bits 0x02, types 0x5
  Connection: 2
     0x01* 0x06
Node 0x03 [Audio Output] wcaps 0x44d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x97 0x97]
  Power: 0x0
Node 0x04 [Audio Output] wcaps 0x40d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x9f 0x9f]
  Power: 0x0
Node 0x05 [Audio Output] wcaps 0x40d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x9f 0x9f]
  Power: 0x0
Node 0x06 [Audio Input] wcaps 0x100511: Stereo
  PCM: rates 0x07f, bits 0x06, types 0x1
  Power: 0x0
  Connection: 1
     0x12
Node 0x07 [Audio Mixer] wcaps 0x200101: Stereo
  Connection: 8
     0x03 0x09 0x13 0x14 0x15 0x16 0x17 0x18
Node 0x08 [Audio Mixer] wcaps 0x200100: Mono
  Connection: 1
     0x07
Node 0x09 [Audio Mixer] wcaps 0x20010e: Mono Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80] [0x80]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80]
  Connection: 2
     0x04 0x05
Node 0x0a [Audio Selector] wcaps 0x300101: Stereo
  Connection: 3
     0x07* 0x04 0x05
Node 0x0b [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x07* 0x04
Node 0x0c [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x04* 0x07
Node 0x0d [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x05* 0x08
Node 0x0e [Audio Selector] wcaps 0x300100: Mono
  Connection: 2
     0x08* 0x11
Node 0x0f [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 8
     0x1f* 0x20 0x1d 0x1d 0x27 0x28 0x29 0x2a
Node 0x10 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 3
     0x20* 0x1c 0x1f
Node 0x11 [Audio Selector] wcaps 0x300941: Stereo
  Connection: 2
     0x0f* 0x2b
Node 0x12 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 6
     0x11* 0x22 0x10 0x07 0x08 0x23
Node 0x13 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x97 0x97]
  Connection: 1
     0x11
Node 0x14 [Audio Selector] wcaps 0x30010c: Mono Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x97]
  Connection: 1
     0x23
Node 0x15 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x97 0x97]
  Connection: 1
     0x22
Node 0x16 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x97 0x97]
  Connection: 1
     0x21
Node 0x17 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x97 0x97]
  Connection: 1
     0x10
Node 0x18 [Audio Selector] wcaps 0x30010c: Mono Amp-Out
  Amp-Out caps: ofs=0x0f, nsteps=0x0f, stepsize=0x0b, mute=1
  Amp-Out vals:  [0x8f]
  Connection: 2
     0x19* 0x24
Node 0x19 [Beep Generator Widget] wcaps 0x700000: Mono
Node 0x1a [Pin Complex] wcaps 0x400185: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x9f 0x9f]
  Pincap 0x081f: OUT HP
  Pin Default 0x02214021: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
  Pin-ctls: 0xc0: OUT HP
  Connection: 1
     0x0a
Node 0x1b [Pin Complex] wcaps 0x400185: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x9f 0x9f]
  Pincap 0x081001f: OUT HP
  Pin Default 0x01014011: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0b
Node 0x1c [Pin Complex] wcaps 0x400185: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x9f 0x9f]
  Pincap 0x0837: IN OUT
  Pin Default 0x01013012: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Blue
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0c
Node 0x1d [Pin Complex] wcaps 0x400985: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x9f 0x9f]
  Pincap 0x081737: IN OUT
  Pin Default 0x01019015: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0d
Node 0x1e [Pin Complex] wcaps 0x400104: Mono Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x9f]
  Pincap 0x0810: OUT
  Pin Default 0x501700f0: [N/A] Speaker at Int N/A
    Conn = Analog, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0e
Node 0x1f [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x081727: IN
  Pin Default 0x02a190f0: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x24: IN
Node 0x20 [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x081727: IN
  Pin Default 0x018130f0: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
  Pin-ctls: 0x20: IN
Node 0x21 [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x0827: IN
  Pin Default 0x509700f0: [N/A] Aux at Int N/A
    Conn = Analog, Color = Unknown
  Pin-ctls: 0x20: IN
Node 0x22 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x993310f0: [Fixed] CD at Int ATAPI
    Conn = ATAPI, Color = Black
  Pin-ctls: 0x20: IN
Node 0x23 [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x0820: IN
  Pin Default 0x50b700f0: [N/A] Telephony at Int N/A
    Conn = Analog, Color = Unknown
  Pin-ctls: 0x20: IN
Node 0x24 [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x0820: IN
  Pin Default 0x50f700f0: [N/A] Other at Int N/A
    Conn = Analog, Color = Unknown
  Pin-ctls: 0x20: IN
Node 0x25 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x0145f0f0: [Jack] SPDIF Out at Ext Rear
    Conn = Optical, Color = Other
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x02
Node 0x26 [Power Widget] wcaps 0x500500: Mono
  Power: 0x0
  Connection: 8
     0x07* 0x08 0x13 0x14 0x15 0x16 0x17 0x18
Node 0x27 [Audio Mixer] wcaps 0x200101: Stereo
  Connection: 2
     0x1f 0x1d
Node 0x28 [Audio Mixer] wcaps 0x200101: Stereo
  Connection: 2
     0x1f 0x20
Node 0x29 [Audio Mixer] wcaps 0x200101: Stereo
  Connection: 2
     0x1d 0x20
Node 0x2a [Audio Mixer] wcaps 0x200101: Stereo
  Connection: 3
     0x1f 0x1d 0x20
Node 0x2b [Audio Mixer] wcaps 0x200100: Mono
  Connection: 1

----------------------------------------------------------------------
 rbenech - 02-04-06 02:28 
----------------------------------------------------------------------
I have same hardware using Suse 10... available for testing/debugging




lspci -nv
00:00.0 Class 0500: 10de:02f0 (rev a2)
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0
        Capabilities: [44] HyperTransport: Slave or Primary Interface
        Capabilities: [e0] HyperTransport: MSI Mapping

00:00.1 Class 0500: 10de:02fa (rev a2)
        Subsystem: 10de:cb84
        Flags: 66MHz, fast devsel

00:00.2 Class 0500: 10de:02fe (rev a2)
        Subsystem: 10de:cb84
        Flags: 66MHz, fast devsel

00:00.3 Class 0500: 10de:02f8 (rev a2)
        Subsystem: 10de:cb84
        Flags: 66MHz, fast devsel

00:00.4 Class 0500: 10de:02f9 (rev a2)
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0

00:00.5 Class 0500: 10de:02ff (rev a2)
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0
        Capabilities: [44] #00 [00fe]
        Capabilities: [fc] #00 [0000]

00:00.6 Class 0500: 10de:027f (rev a2)
        Subsystem: 10de:cb84
        Flags: 66MHz, fast devsel

00:00.7 Class 0500: 10de:027e (rev a2)
        Subsystem: 10de:cb84
        Flags: 66MHz, fast devsel

00:02.0 Class 0604: 10de:02fc (rev a1)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Capabilities: [40] #0d [0000]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/1
Enable+
        Capabilities: [60] HyperTransport: MSI Mapping
        Capabilities: [80] Express Root Port (Slot+) IRQ 0

00:03.0 Class 0604: 10de:02fd (rev a1)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        Capabilities: [40] #0d [0000]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/1
Enable+
        Capabilities: [60] HyperTransport: MSI Mapping
        Capabilities: [80] Express Root Port (Slot+) IRQ 0

00:04.0 Class 0604: 10de:02fb (rev a1)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        Capabilities: [40] #0d [0000]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/1
Enable+
        Capabilities: [60] HyperTransport: MSI Mapping
        Capabilities: [80] Express Root Port (Slot+) IRQ 0

00:05.0 Class 0300: 10de:0240 (rev a2)
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 50
        Memory at 00000000fd000000 (32-bit, non-prefetchable) [size=16M]
        Memory at 00000000d0000000 (64-bit, prefetchable) [size=256M]
        Memory at 00000000fc000000 (64-bit, non-prefetchable) [size=16M]
        [virtual] Expansion ROM at 00000000febe0000 [disabled]
[size=128K]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-

00:09.0 Class 0500: 10de:0270 (rev a2)
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0
        Capabilities: [44] HyperTransport: Slave or Primary Interface
        Capabilities: [e0] HyperTransport: MSI Mapping

00:0a.0 Class 0601: 10de:0260 (rev a2)
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0

00:0a.1 Class 0c05: 10de:0264 (rev a2)
        Subsystem: 10de:cb84
        Flags: 66MHz, fast devsel, IRQ 5
        I/O ports at 0600 [size=64]
        I/O ports at 0700 [size=64]
        Capabilities: [44] Power Management version 2

00:0b.0 Class 0c03: 10de:026d (rev a2) (prog-if 10)
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 225
        Memory at 00000000febde000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

00:0b.1 Class 0c03: 10de:026e (rev a2) (prog-if 20)
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 209
        Memory at 00000000febdfc00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [44] Debug port
        Capabilities: [80] Power Management version 2

00:0d.0 Class 0101: 10de:0265 (rev a1) (prog-if 8a [Master SecP PriP])
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0
        I/O ports at ffa0 [size=16]
        Capabilities: [44] Power Management version 2

00:0e.0 Class 0101: 10de:0266 (rev a1) (prog-if 85 [Master SecO PriO])
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 209
        I/O ports at e800 [size=8]
        I/O ports at e480 [size=4]
        I/O ports at e400 [size=8]
        I/O ports at e080 [size=4]
        I/O ports at e000 [size=16]
        Memory at 00000000febdd000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
        Capabilities: [b0] Message Signalled Interrupts: 64bit+ Queue=0/2
Enable-
        Capabilities: [cc] HyperTransport: MSI Mapping

00:0f.0 Class 0101: 10de:0267 (rev a1) (prog-if 85 [Master SecO PriO])
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 217
        I/O ports at dc00 [size=8]
        I/O ports at d880 [size=4]
        I/O ports at d800 [size=8]
        I/O ports at d480 [size=4]
        I/O ports at d400 [size=16]
        Memory at 00000000febdc000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
        Capabilities: [b0] Message Signalled Interrupts: 64bit+ Queue=0/2
Enable-
        Capabilities: [cc] HyperTransport: MSI Mapping

00:10.0 Class 0604: 10de:026f (rev a2) (prog-if 01)
        Flags: bus master, 66MHz, fast devsel, latency 0
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=64
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: faa00000-faafffff
        Capabilities: [b8] #0d [0000]
        Capabilities: [8c] HyperTransport: MSI Mapping

00:10.1 Class 0403: 10de:026c (rev a2)
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 5
        Memory at 00000000febd8000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
        Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [6c] HyperTransport: MSI Mapping

00:14.0 Class 0680: 10de:0269 (rev a1)
        Subsystem: 10de:cb84
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 233
        Memory at 00000000febd7000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at d080 [size=8]
        Capabilities: [44] Power Management version 2

00:18.0 Class 0600: 1022:1100
        Flags: fast devsel
        Capabilities: [80] HyperTransport: Host or Secondary Interface

00:18.1 Class 0600: 1022:1101
        Flags: fast devsel

00:18.2 Class 0600: 1022:1102
        Flags: fast devsel

00:18.3 Class 0600: 1022:1103
        Flags: fast devsel

04:05.0 Class 0c00: 1106:3044 (rev 80) (prog-if 10)
        Subsystem: 1043:808a
        Flags: bus master, medium devsel, latency 64, IRQ 58
        Memory at 00000000faaff800 (32-bit, non-prefetchable) [size=2K]
        I/O ports at cc00 [size=128]
        Capabilities: [50] Power Management version 2



----------------------------------------------------------------------
 labene - 02-04-06 15:44 
----------------------------------------------------------------------
I resolv the problem with a patch a8nvmsound.patch , see :
http://quaggaspace.org/a8nvm/a8nvmsound.patch

Extract the kernel 2.6.15.2 in your /usr/src directory 

link or rename the directory linux-2.6.15 to linux.

download the patch for kernel 2.6.15 and patch it :
------------------------------
# cp a8nvmsound.patch /usr/src
# cd /usr/src
# patch -p0 < a8nvmsound.patch

After downloading the patch, you'll have to patch the kernel with it and
then compile in ALSA support for the "Intel HDA sound". Then loading and
unmuting the PCM and Master volume settings. At this point, I have sound
which works pretty flawlessly in OSS emulation. If you get a "crackle"
when sounds are playing under ALSA native mode, you'll want to add : 
"options snd-hda-intel position_fix=1" to your /etc/modules.conf. My hope
is that future versions of ALSA eliminate the need for this patch at all.
-------------------------

good luck

Remy



----------------------------------------------------------------------
 rlrevell - 02-04-06 19:15 
----------------------------------------------------------------------
Argh, WTF?  Why in the hell do people bother making ALSA patches then don't
submit them?!?  Do they think we are f**king psychic?

----------------------------------------------------------------------
 Arnaud Patard - 02-04-06 20:23 
----------------------------------------------------------------------
Lee, there was a similar patch send on alsa-devel@. Look for the thread
called "AD1986a". iirc Takashi said he'll try to contact AD about this.

[ Side note : afaik this bug is a dup of other open bugs reports ]

----------------------------------------------------------------------
 gerick - 02-05-06 06:26 
----------------------------------------------------------------------
RE: the patch
It was my understanding that the patch disables surround sound (5.1) and
gives only stereo.  So it is a work around only, not a solutions.

----------------------------------------------------------------------
 quagga - 02-06-06 20:16 
----------------------------------------------------------------------
gerick is correct.  From my understanding of the patch listed on my site,
it kills surround sound in favor of getting sound working.  Sorry, I
didn't submit it here as well, its not really a solution and the issues
that this patch works around were already listed as bugs so I didn't want
to be a "me too" guy.

I had been following
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1678 and just
figured I'd wait and see how things developed.  

As of 1.0.11rc3, I still have issues with the board.  I don't get the
squeeling from the speaker but  I start out with sound only coming from my
right headphone (left is dead), and if I try to adjust the volume, the
whole card silences.

----------------------------------------------------------------------
 ukrcald - 02-13-06 14:00 
----------------------------------------------------------------------
Hi there, my first post so please bare with me if i'm in the wrong place
etc....

I have an ASUS A8N-VM CSM and am using th spdif connector on the board to
feed my AV amp. This digital audio out works fine with AMD64 Debian Sid
running under kernel 2.6.15. I use the hda_intel driver from the stock
kernel rather than resorting to OSS and the 'supported' Nvidia supplied
driver.

My problem is that I cannot get the analog capture to, well, capture
anything.

Is this releated to the problems that you guys seem to be having?
If it is then i'll try patching the kernel as sugested.

I've not had any of the sqeeking and screaming that some people report,
though again, is this just happening on analog outputs?
Rich

----------------------------------------------------------------------
 awjb - 02-13-06 15:02 
----------------------------------------------------------------------
Same problem here. I only get sound from the right speaker and the left one
does a  high pitch noise. If I select stereo downmix whole card goes
silent and won't do anything thereafter.

[03:00 PM][awjb@alkaid ~]$ rpm -q alsa-lib
alsa-lib-1.0.11-3.rc2.2

00:10.1 Audio device: nVidia Corporation MCP51 High Definition Audio (rev
a2)
	Subsystem: nVidia Corporation Unknown device cb84
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0 (500ns min, 1250ns max)
	Interrupt: pin B routed to IRQ 5
	Region 0: Memory at febd8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: <access denied>

----------------------------------------------------------------------
 tassilo80 - 03-01-06 13:13 
----------------------------------------------------------------------
Same problem, different Notebook (Samsung R65), alsa-driver and alsa-lib
version 1.0.11_rc3

cat /proc/asound/pcm
00-06: Si3054 Modem : Si3054 Modem : playback 1 : capture 1
00-01: AD198x Digital : AD198x Digital : playback 1
00-00: AD198x Analog : AD198x Analog : playback 1 : capture 1

Without patching there was no sound at all, neither from the internal
speakers (which are not listed in `alsamixer`) nor from the headphones.

I applied the changes made by the patch labene mentioned to the
alsa-driver-1.0.11_rc3 and as a result the headphones now work (left and
right). I tried switching/muting several switches in alsamixer, stereo
downmix, too, but the headphones still work.

Anyway, it would be great to get the internal speakers running.



Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-29-06 18:31 labene         New Issue                                    
01-29-06 18:31 labene         Distribution              => Debian          
01-29-06 18:31 labene         Kernel Version            => 2.6.15 standard 
01-29-06 18:54 labene         Note Added: 0007833                          
01-29-06 19:13 labene         Note Added: 0007834                          
02-01-06 15:38 thorstenl      Issue Monitored: thorstenl                    
02-04-06 02:20 rbenech        Issue Monitored: rbenech                     
02-04-06 02:23 rbenech        Note Added: 0007909                          
02-04-06 02:28 rbenech        Note Edited: 0007909                         
02-04-06 15:36 labene         Note Added: 0007916                          
02-04-06 15:44 labene         Note Edited: 0007916                         
02-04-06 19:15 rlrevell       Note Added: 0007920                          
02-04-06 20:23 Arnaud Patard  Note Added: 0007924                          
02-05-06 06:26 gerick         Note Added: 0007931                          
02-05-06 06:32 gerick         Issue Monitored: gerick                      
02-06-06 20:16 quagga         Note Added: 0007951                          
02-08-06 13:04 simonckenyon   Issue Monitored: simonckenyon                    
02-13-06 14:00 ukrcald        Note Added: 0008048                          
02-13-06 14:56 awjb           Issue Monitored: awjb                        
02-13-06 15:02 awjb           Note Added: 0008051                          
02-13-06 21:29 chalvorson     Issue Monitored: chalvorson                    
03-01-06 13:09 tassilo80      Note Added: 0008280                          
03-01-06 13:13 tassilo80      Note Edited: 0008280                         
03-07-06 15:20 quagga         Issue Monitored: quagga                      
03-13-06 17:39 rlrevell       Relationship added       duplicate of 0001632
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
