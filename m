From: joe+alsa@nahmias.net
Subject: [HDA Intel/AD1984] Alsa 1.0.14 not working on ThinkPad
	T61
Date: Wed, 4 Jul 2007 17:36:41 +0000
Message-ID: <20070704173641.GA7087@nahmias.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dot.nahmias.net (dot.nahmias.net [64.71.168.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 5160C1038C7
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2007 19:36:43 +0200 (CEST)
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

Hello,

I'm having trouble getting sound on my ThinkPad T61 working.  According
to the changelog for alsa-driver 1.0.14, support was added in that
version; however, no sound is coming out.

I'm running Debian unstable and I'd be happy to test any patches,
provide more info, etc...

Any help would be appreciated.

Thanks,
--Joe

PS - Here's some debugging info that may be of use:

$ uname -srvmo
Linux 2.6.21-2-686 #1 SMP Mon Jun 25 20:53:36 UTC 2007 i686 GNU/Linux

$ dpkg -l alsa* | grep ^i
ii  alsa-base                 1.0.14-1          ALSA driver configuration files
ii  alsa-modules-2.6.21-2-686 1.0.14-1+2.6.21-5 ALSA modules for kernel 2.6.21-2-686
ii  alsa-source               1.0.14-1          ALSA driver sources
ii  alsa-utils                1.0.14-1          ALSA utilities

$ aumix -q
pcm 90, 90
mic 0, 0
pcm2 100, 100
igain 56, 56

$ lsmod | grep snd
snd_hda_intel         244952  0
snd_pcm_oss            39680  0
snd_mixer_oss          15840  1 snd_pcm_oss
snd_pcm                72292  2 snd_hda_intel,snd_pcm_oss
snd_timer              20964  1 snd_pcm
snd                    49316  5 snd_hda_intel,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
snd_page_alloc          9544  2 snd_hda_intel,snd_pcm
soundcore               7424  1 snd

$ sudo lspci -vv -s 00:1b.0
00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio
Controller (rev 03)
        Subsystem: Lenovo Unknown device 20ac
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin B routed to IRQ 21
        Region 0: Memory at fe020000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express Unknown type IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
                Device: Latency L0s <64ns, L1 <1us
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed unknown, Width x0, ASPM unknown, Port 0
                Link: Latency L0s <64ns, L1 <1us
                Link: ASPM Disabled CommClk- ExtSynch-
                Link: Speed unknown, Width x0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)


$ cat /proc/asound/card0/codec#0
Codec: Analog Devices AD1984
Address: 0
Vendor Id: 0x11d41984
Subsystem Id: 0x17aa20d7
Revision Id: 0x100400
Default PCM:
    rates [0x7ff]: 8000 11025 16000 22050 32000 44100 48000 88200 96000
176400 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Default Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
Node 0x02 [Audio Output] wcaps 0x30311: Stereo Digital
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Connection: 3
     0x01* 0x08 0x09
Node 0x03 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
  Amp-Out vals:  [0x80 0x80]
  Power: 0x0
Node 0x04 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
  Amp-Out vals:  [0xa3 0xa3]
  Power: 0x0
Node 0x05 [Audio Input] wcaps 0x10050b: Stereo Amp-In
  Amp-In caps: ofs=0x27, nsteps=0x36, stepsize=0x05, mute=1
  Amp-In vals:  [0xa7 0xa7]
  Power: 0x0
  Connection: 1
     0x17
Node 0x06 [Audio Input] wcaps 0x10050b: Stereo Amp-In
  Amp-In caps: ofs=0x27, nsteps=0x36, stepsize=0x05, mute=1
  Amp-In vals:  [0xa7 0xa7]
  Power: 0x0
  Connection: 1
     0x18
Node 0x07 [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x22 0x21
Node 0x08 [Audio Input] wcaps 0x100501: Stereo
  Power: 0x0
  Connection: 1
     0x0c
Node 0x09 [Audio Input] wcaps 0x100501: Stereo
  Power: 0x0
  Connection: 1
     0x0d
Node 0x0a [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x04 0x21
Node 0x0b [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Connection: 2
     0x0f 0x21
Node 0x0c [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x27, nsteps=0x36, stepsize=0x05, mute=1
  Amp-Out vals:  [0x1e 0x1e]
  Connection: 5
     0x14* 0x15 0x16 0x20 0x25
Node 0x0d [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x27, nsteps=0x36, stepsize=0x05, mute=1
  Amp-Out vals:  [0xa7 0xa7]
  Connection: 5
     0x14* 0x15 0x16 0x20 0x25
Node 0x0e [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x03 0x04*
Node 0x0f [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x03* 0x04
Node 0x10 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x0f, nsteps=0x0f, stepsize=0x0b, mute=1
  Amp-Out vals:  [0x00]
Node 0x11 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x081f: OUT HP Detect
  Pin Default 0x0221401f: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
  Pin-ctls: 0xc0: OUT HP
  Connection: 1
     0x07
Node 0x12 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x081001f: OUT HP EAPD Detect
  Pin Default 0x90170110: [Fixed] Speaker at Int N/A
    Conn = Analog, Color = Unknown
  Pin-ctls: 0xc0: OUT HP
  Power: 0x0
  Connection: 1
     0x0a
Node 0x13 [Pin Complex] wcaps 0x40050c: Mono Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x00]
  Pincap 0x0810010: OUT EAPD
  Pin Default 0x511301f0: [N/A] Speaker at Int Rear
    Conn = ATAPI, Color = Unknown
  Pin-ctls: 0x40: OUT
  Power: 0x0
  Connection: 1
     0x1f
Node 0x14 [Pin Complex] wcaps 0x40008b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals: 
  Pincap 0x083727: IN Detect
  Pin Default 0x02a15021: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Red
  Pin-ctls: 0x24: IN
Node 0x15 [Pin Complex] wcaps 0x40008b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals: 
  Pincap 0x083727: IN Detect
  Pin Default 0x90a7012e: [Fixed] Mic at Int N/A
    Conn = Analog, Color = Unknown
  Pin-ctls: 0x24: IN
Node 0x16 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0837: IN OUT Detect
  Pin Default 0x593301f0: [N/A] CD at Int ATAPI
    Conn = ATAPI, Color = Unknown
  Pin-ctls: 0x00:
  Connection: 1
     0x0b
Node 0x17 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x55a601f0: [N/A] Mic at Int Top
    Conn = Digital, Color = Unknown
  Pin-ctls: 0x24: IN
Node 0x18 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x55a601f0: [N/A] Mic at Int Top
    Conn = Digital, Color = Unknown
  Pin-ctls: 0x00:
Node 0x19 [Power Widget] wcaps 0x500500: Mono
  Power: 0x0
  Connection: 2
     0x20* 0x21
Node 0x1a [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x0820: IN
  Pin Default 0x91f311f0: [Fixed] Other at Int Rear
    Conn = ATAPI, Color = Black
  Pin-ctls: 0x20: IN
Node 0x1b [Pin Complex] wcaps 0x40030d: Stereo Digital Amp-Out
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=1
  Amp-Out vals:  [0x27 0x27]
  Pincap 0x0810: OUT
  Pin Default 0x214411a0: [Jack] SPDIF Out at Sep Rear
    Conn = RCA, Color = Black
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x02
Node 0x1c [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x083737: IN OUT Detect
  Pin Default 0x21a15020: [Jack] Mic at Sep Rear
    Conn = 1/8, Color = Red
  Pin-ctls: 0x24: IN
  Connection: 1
     0x24
Node 0x1d [Vendor Defined Widget] wcaps 0xf00100: Mono
  Connection: 25
     0x07* 0x19 0x0a 0x0b 0x0c 0x0d 0x0e 0x0f 0x1a 0x1c 0x11 0x12 0x13
0x14 0x15 0x16 0x1e 0x1f 0x20 0x21 0x22 0x23 0x24 0x25 0x26
Node 0x1e [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x0e 0x21
Node 0x1f [Audio Mixer] wcaps 0x200100: Mono
  Connection: 1
     0x1e
Node 0x20 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x80 0x80] [0x9c 0x9c] [0x80 0x80] [0x80 0x80] [0x80
0x80]
  Connection: 5
     0x14 0x15 0x16 0x1a 0x25
Node 0x21 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x1f 0x1f]
  Connection: 1
     0x20
Node 0x22 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x03 0x04*
Node 0x23 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x03* 0x04
Node 0x24 [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Connection: 2
     0x23 0x21
Node 0x25 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 1
     0x1c
Node 0x26 [Vendor Defined Widget] wcaps 0xf00100: Mono
  Connection: 3
     0x14* 0x15 0x1c
