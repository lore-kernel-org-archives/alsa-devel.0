From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001596]: No sound or High pitched noise, dissapears if change made on mixer
Date: Tue, 14 Mar 2006 17:36:54 +0100
Message-ID: <547bf8b6015e8da6e4c33f2c5b51ad3e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 83C511CD
	for <alsa-devel@alsa-project.org>; Tue, 14 Mar 2006 17:36:54 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1596> 
======================================================================
Reported By:                jrgns
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1596
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.14-rc2
======================================================================
Date Submitted:             11-24-2005 11:26 CET
Last Modified:              03-14-2006 17:36 CET
======================================================================
Summary:                    No sound or High pitched noise, dissapears if change
made on mixer
Description: 
With the driver compiled as a standalone (1.0.10rc3), there's is sound, but
accompanied with a very high pitched noise. All sound dissappears the
moment I change something on the mixer.

There is no sound at all if the driver is compiled into the kernel or as a
kernel module (1.0.10rc1 and 2.6.14-rc2).

I tried loading the module with various model= and fix_position=
combinations as well.

Hardware:
lspci
0000:00:1b.0 Class 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio Controller (rev 04)

lspci -n -v -v
0000:00:1b.0 Class 0403: 8086:2668 (rev 04)
        Subsystem: 17c0:2017
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at b0000000 (64-bit, non-prefetchable)
[size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] #10 [0091]

lspci -v
0000:00:02.0 VGA compatible controller: Intel Corporation Mobile
915GM/GMS/910GML Express Graphics Controller (rev 04) (prog-if 00 [VGA])
        Subsystem: Wistron Corp.: Unknown device 2071
        Flags: bus master, fast devsel, latency 0, IRQ 10
        Memory at b0080000 (32-bit, non-prefetchable) [size=512K]
        I/O ports at 1800 [size=8]
        Memory at c0000000 (32-bit, prefetchable) [size=256M]
        Memory at b0040000 (32-bit, non-prefetchable) [size=256K]
        Capabilities: [d0] Power Management version 2

cat /proc/asound/card0/codec#0
Codec: Analog Devices AD1986A
Address: 0
Vendor Id: 0x11d41986
Subsystem Id: 0x0
Revision Id: 0x100400
Default PCM: rates 0x07f, bits 0x0e, types 0x1
Default Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Default Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
Node 0x02 [Audio Output] wcaps 0x30311: Stereo Digital
  PCM: rates 0x060, bits 0x02, types 0x5
  Connection: 2
     0x01* 0x06
Node 0x03 [Audio Output] wcaps 0x445: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x97 0x97]
Node 0x04 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x9f 0x9f]
Node 0x05 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x9f 0x9f]
Node 0x06 [Audio Input] wcaps 0x100511: Stereo
  PCM: rates 0x07f, bits 0x06, types 0x1
  Connection: 1
     0x12
Node 0x07 [Audio Mixer] wcaps 0x200101: Stereo
  Connection: 8
     0x03 0x09 0x13 0x14 0x15 0x16 0x17 0x18
Node 0x08 [Audio Mixer] wcaps 0x200108: Mono
  Connection: 1
     0x07
Node 0x09 [Audio Mixer] wcaps 0x200106: Mono Amp-In Amp-Out
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
Node 0x13 [Audio Selector] wcaps 0x300105: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x97 0x97]
  Connection: 1
     0x11
Node 0x14 [Audio Selector] wcaps 0x300104: Mono Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x97]
  Connection: 1
     0x23
Node 0x15 [Audio Selector] wcaps 0x300105: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x97 0x97]
  Connection: 1
     0x22
Node 0x16 [Audio Selector] wcaps 0x300105: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x97 0x97]
  Connection: 1
     0x21
Node 0x17 [Audio Selector] wcaps 0x300105: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x97 0x97]
  Connection: 1
     0x10
Node 0x18 [Audio Selector] wcaps 0x30010c: Mono Amp-Out
  Amp-Out caps: ofs=0x0f, nsteps=0x0f, stepsize=0x0b, mute=1
  Amp-Out vals:  [0x8f]
  Connection: 2
     0x19* 0x24
Node 0x19 [Beep Generator Widget] wcaps 0x700200: Mono Digital
Node 0x1a [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x9f 0x9f]
  Pincap 0x081f: OUT HP
  Pin Default 0x01813030: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
  Pin-ctls: 0xc0: OUT HP
  Connection: 1
     0x0a
Node 0x1b [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x9f 0x9f]
  Pincap 0x081001f: OUT HP
  Pin Default 0x01014011: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0b
Node 0x1c [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x9f 0x9f]
  Pincap 0x0837: IN OUT
  Pin Default 0x9933f170: [Fixed] CD at Int ATAPI
    Conn = ATAPI, Color = Other
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0c
Node 0x1d [Pin Complex] wcaps 0x40098d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x9f 0x9f]
  Pincap 0x081737: IN OUT
  Pin Default 0x99f3f115: [Fixed] Other at Int ATAPI
    Conn = ATAPI, Color = Other
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0d
Node 0x1e [Pin Complex] wcaps 0x40018c: Mono Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x00]
  Pincap 0x0810: OUT
  Pin Default 0x901700f0: [Fixed] Speaker at Int N/A
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
  Pin Default 0x409700f0: [N/A] Aux at Ext N/A
    Conn = Analog, Color = Unknown
  Pin-ctls: 0x20: IN
Node 0x22 [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x0820: IN
  Pin Default 0x903300f0: [Fixed] CD at Int N/A
    Conn = ATAPI, Color = Unknown
  Pin-ctls: 0x20: IN
Node 0x23 [Pin Complex] wcaps 0x400080: Mono
  Pincap 0x0820: IN
  Pin Default 0x40b700f0: [N/A] Telephony at Ext N/A
    Conn = Analog, Color = Unknown
  Pin-ctls: 0x20: IN
Node 0x24 [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x0820: IN
  Pin Default 0x50f700f0: [N/A] Other at Int N/A
    Conn = Analog, Color = Unknown
  Pin-ctls: 0x20: IN
Node 0x25 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x014500f0: [Jack] SPDIF Out at Ext Rear
    Conn = Optical, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x02
Node 0x26 [Power Widget] wcaps 0x500500: Mono
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
     0x0f

======================================================================

----------------------------------------------------------------------
 tiwai - 03-14-06 17:33 
----------------------------------------------------------------------
Actually, the models I mentioned above should have the same fix as your
patch although your patch will be never merged (it breaks other boards).

----------------------------------------------------------------------
 merin - 03-14-06 17:36 
----------------------------------------------------------------------
Hi tiwai!
Just tried it, but neither model=3stack nor model=laptop brought any
improvement.
Any other idea?
Is there any work for this in progress?
That would be great!

Greets,
Merin

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-24-05 11:26 jrgns          New Issue                                    
11-24-05 11:26 jrgns          Distribution              => Gentoo          
11-24-05 11:26 jrgns          Kernel Version            => 2.6.14-rc2      
11-24-05 12:14 jrgns          Note Added: 0006840                          
11-24-05 12:14 jrgns          Note Added: 0006841                          
02-04-06 23:15 eIf            Note Added: 0007927                          
02-04-06 23:15 eIf            Issue Monitored: eIf                         
02-05-06 06:31 gerick         Issue Monitored: gerick                      
02-08-06 13:11 simonckenyon   Issue Monitored: simonckenyon                    
02-18-06 19:16 fluor          Note Added: 0008122                          
02-18-06 19:48 chalvorson     Issue Monitored: chalvorson                    
02-19-06 21:49 jrgns          Note Added: 0008137                          
02-19-06 21:57 eIf            Note Added: 0008138                          
03-04-06 18:23 merin          Note Added: 0008350                          
03-04-06 18:24 merin          Note Edited: 0008350                         
03-04-06 19:11 rlrevell       Note Added: 0008352                          
03-04-06 22:02 merin          Note Added: 0008354                          
03-05-06 11:29 merin          Issue Monitored: merin                       
03-06-06 05:48 stevenellis    Issue Monitored: stevenellis                    
03-14-06 17:09 tiwai          Note Added: 0008493                          
03-14-06 17:16 fluor          Note Added: 0008494                          
03-14-06 17:29 rlrevell       Note Added: 0008497                          
03-14-06 17:33 tiwai          Note Added: 0008498                          
03-14-06 17:36 merin          Note Added: 0008499                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
