From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Intel HDA Mixer on Intel Mac Mini
Date: Thu, 27 Apr 2006 15:52:26 +0200
Message-ID: <20060427135226.GO11777@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="JP+T4n/bALQSJXh8"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,
I have aquired a Intel Mac Mini. The soundcard is found by the kernel
but only the digital output works. The analog output and the built-in
speaker do not (other people can confirm this). Now I would like to know
if someone is working on the issue and if there is any documentation
available so that I could do it myself.

0000:00:1b.0 0403: 8086:27d8 (rev 02)
0000:00:1b.0 0403: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 02)
        Subsystem: Unknown device 8384:7680
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x40 (256 bytes)
        Interrupt: pin A routed to IRQ 21
        Region 0: Memory at 90440000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] #10 [0091]

(mini) [/proc/asound] cat devices
  0: [ 0]   : control
  1:        : sequencer
 16: [ 0- 0]: digital audio playback
 17: [ 0- 1]: digital audio playback
 24: [ 0- 0]: digital audio capture
 25: [ 0- 1]: digital audio capture
 32: [ 1]   : control
 33:        : timer
 48: [ 1- 0]: digital audio playback
 56: [ 1- 0]: digital audio capture
(mini) [/proc/asound] cat cards
 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0x90440000 irq 21
 1 [PSC805         ]: USB-Audio - Philips PSC805
                      Philips Electronics Philips PSC805 at usb-0000:00:1d.2-1, full speed
(mini) [/proc/asound] cat version
Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04 08:57:20 2006 UTC).

The Output of /proc/asound/card0/codec#0 is attached. Card1 is a USB
Soundcard I use because the Intel HDA doesn't work for me with analog
output yet.

Thanks,
        Thomas
--
Rathsbergerstrasse 28     D-91054 Erlangen / Burgberg     +49 (0) 9131 - 614720

--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=codec#0

Codec: SigmaTel STAC9221 A1
Address: 0
Vendor Id: 0x83847680
Subsystem Id: 0x100
Revision Id: 0x103401
Default PCM: rates 0x7e0, bits 0x0e, types 0x1
Default Amp-In caps: ofs=0x00, nsteps=0x0e, stepsize=0x05, mute=1
Default Amp-Out caps: ofs=0x7f, nsteps=0x7f, stepsize=0x02, mute=1
Node 0x02 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x7f 0x7f]
  Power: 0x0
Node 0x03 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0xff 0xff]
  Power: 0x0
Node 0x04 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0xff 0xff]
  Power: 0x0
Node 0x05 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x7f 0x7f]
  Power: 0x0
Node 0x06 [Audio Input] wcaps 0x1d0541: Stereo
  Power: 0x0
  Connection: 1
     0x17
Node 0x07 [Audio Input] wcaps 0x1d0541: Stereo
  Power: 0x0
  Connection: 1
     0x18
Node 0x08 [Audio Output] wcaps 0x40211: Stereo Digital
  PCM: rates 0x7e0, bits 0x0e, types 0x5
Node 0x09 [Audio Input] wcaps 0x140311: Stereo Digital
  PCM: rates 0x160, bits 0x0e, types 0x5
  Connection: 1
     0x11
Node 0x0a [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x08173f: IN OUT HP
  Pin Default 0x010b4040: [Jack] Line Out at Ext Rear
    Conn = Comb, Color = Green
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x02
Node 0x0b [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x081737: IN OUT
  Pin Default 0x4000000f: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x20: IN
  Connection: 1
     0x04
Node 0x0c [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x081737: IN OUT
  Pin Default 0x90130130: [Fixed] Speaker at Int N/A
    Conn = ATAPI, Color = Unknown
  Pin-ctls: 0x20: IN
  Connection: 1
     0x03
Node 0x0d [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x08173f: IN OUT HP
  Pin Default 0x4000000f: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x02
Node 0x0e [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x0824: IN
  Pin Default 0x4000000f: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x20: IN
Node 0x0f [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0837: IN OUT
  Pin Default 0x018b3010: [Jack] Line In at Ext Rear
    Conn = Comb, Color = Blue
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x05
Node 0x10 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x014be050: [Jack] SPDIF Out at Ext Rear
    Conn = Comb, Color = White
  Pin-ctls: 0x40: OUT
  Connection: 3
     0x08* 0x17 0x19
Node 0x11 [Pin Complex] wcaps 0x430681: Stereo Digital
  Pincap 0x0810024: IN
  Pin Default 0x01cbe020: [Jack] SPDIF In at Ext Rear
    Conn = Comb, Color = White
  Pin-ctls: 0x20: IN
  Power: 0x0
Node 0x12 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-Out vals:  [0x04 0x04]
  Connection: 7
     0x0e* 0x15 0x0f 0x0b 0x0c 0x0d 0x0a
Node 0x13 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 7
     0x0e 0x15* 0x0f 0x0b 0x0c 0x0d 0x0a
Node 0x14 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=0
  Amp-Out vals:  [0x00]
Node 0x15 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x4000000f: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
Node 0x16 [Volume Knob Widget] wcaps 0x600000: Mono
Node 0x17 [Audio Selector] wcaps 0x300903: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x0e 0x0e]
  Connection: 1
     0x12
Node 0x18 [Audio Selector] wcaps 0x300903: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x80 0x80]
  Connection: 1
     0x13
Node 0x19 [Vendor Defined Widget] wcaps 0xf30201: Stereo Digital
Node 0x1a [Audio Output] wcaps 0x30201: Stereo Digital
Node 0x1b [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x4000000f: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Connection: 1
     0x1a

--JP+T4n/bALQSJXh8--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
