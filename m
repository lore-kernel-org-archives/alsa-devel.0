From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: HDA codec graphing
Date: Fri, 18 Jan 2008 21:47:00 +0500
Message-ID: <fmql6r$vh6$1@ger.gmane.org>
References: <5f52f6d70801170424o4682381fhc12416125a1b66a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010907030306090004070105"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 469DB245AC
	for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2008 17:47:36 +0100 (CET)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JFuNS-0001A3-DZ
	for alsa-devel@alsa-project.org; Fri, 18 Jan 2008 16:47:34 +0000
Received: from 90.151.17.24 ([90.151.17.24])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2008 16:47:34 +0000
Received: from patrakov by 90.151.17.24 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2008 16:47:34 +0000
In-Reply-To: <5f52f6d70801170424o4682381fhc12416125a1b66a8@mail.gmail.com>
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

This is a multi-part message in MIME format.
--------------010907030306090004070105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Claudio Matsuoka wrote:
> After a lot of time published only as a git repository, I created a
> page and tarball for Eduardo Habkost's codecgraph tool to graph the
> layout of HDA codecs. It may be useful for those tweaking or
> troubleshooting existing drivers. The page has also examples of
> different codec layouts rendered in SVG. See details at
> http://helllabs.org/codecgraph/.

Please find attached a codec file for SigmaTel STAC9227, for addition to the 
samples on your web page.

home:~# lspci -n -vv -d 8086:284b
00:1b.0 0403: 8086:284b (rev 02)
	Subsystem: 8086:2114
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at 90420000 (64-bit, non-prefetchable) [size=16K]
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

-- 
Alexander E. Patrakov

--------------010907030306090004070105
Content-Type: text/plain;
 name="codec#2-SigmaTel_STAC9227"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="codec#2-SigmaTel_STAC9227"

Codec: SigmaTel STAC9227
Address: 2
Vendor Id: 0x83847618
Subsystem Id: 0x80862114
Revision Id: 0x100201
Default PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: ofs=0x00, nsteps=0x0e, stepsize=0x05, mute=0
Default Amp-Out caps: ofs=0x7f, nsteps=0x7f, stepsize=0x02, mute=1
Node 0x02 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x5b 0x5b]
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
  Amp-Out vals:  [0xff 0xff]
  Power: 0x0
Node 0x06 [Vendor Defined Widget] wcaps 0xfd0c05: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0xff 0xff]
  Power: 0x0
Node 0x07 [Audio Input] wcaps 0x1d0541: Stereo
  Power: 0x0
  Connection: 1
     0x1b
Node 0x08 [Audio Input] wcaps 0x1d0541: Stereo
  Power: 0x0
  Connection: 1
     0x1c
Node 0x09 [Audio Input] wcaps 0x1d0541: Stereo
  Power: 0x0
  Connection: 1
     0x1d
Node 0x0a [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x08173f: IN OUT HP Detect
  Pin Default 0x0221401f: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
  Pin-ctls: 0xc0: OUT HP
  Connection: 2
     0x02* 0x03
Node 0x0b [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x08173f: IN OUT HP Detect
  Pin Default 0x02a19120: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x24: IN
  Connection: 2
     0x02 0x03*
Node 0x0c [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x081737: IN OUT Detect
  Pin Default 0x40000100: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Connection: 1
     0x03
Node 0x0d [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x08173f: IN OUT HP Detect
  Pin Default 0x01014011: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x02
Node 0x0e [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x081737: IN OUT Detect
  Pin Default 0x01a19021: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x24: IN
  Connection: 1
     0x04
Node 0x0f [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x081737: IN OUT Detect
  Pin Default 0x01813024: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
  Pin-ctls: 0x20: IN
  Connection: 1
     0x05
Node 0x10 [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0837: IN OUT Detect
  Pin Default 0x40000100: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Connection: 1
     0x04
Node 0x11 [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0837: IN OUT Detect
  Pin Default 0x40000100: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Connection: 1
     0x03
Node 0x12 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x40000100: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
Node 0x13 [Vendor Defined Widget] wcaps 0xf00001: Stereo
Node 0x14 [Vendor Defined Widget] wcaps 0xf00001: Stereo
Node 0x15 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-Out vals:  [0x04 0x04]
  Connection: 9
     0x0e 0x12 0x0f 0x0b* 0x0c 0x0d 0x0a 0x10 0x11
Node 0x16 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 9
     0x0e* 0x12 0x0f 0x0b 0x0c 0x0d 0x0a 0x10 0x11
Node 0x17 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 9
     0x0e* 0x12 0x0f 0x0b 0x0c 0x0d 0x0a 0x10 0x11
Node 0x18 [Audio Selector] wcaps 0x300103: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Connection: 1
     0x15
Node 0x19 [Audio Selector] wcaps 0x300103: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Connection: 1
     0x16
Node 0x1a [Audio Selector] wcaps 0x300103: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Connection: 1
     0x17
Node 0x1b [Audio Selector] wcaps 0x30090d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Connection: 1
     0x18
Node 0x1c [Audio Selector] wcaps 0x30090d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 1
     0x19
Node 0x1d [Audio Selector] wcaps 0x30090d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 1
     0x1a
Node 0x1e [Audio Output] wcaps 0x40211: Stereo Digital
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
Node 0x1f [Vendor Defined Widget] wcaps 0xf30201: Stereo Digital
Node 0x20 [Audio Input] wcaps 0x140311: Stereo Digital
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Connection: 1
     0x22
Node 0x21 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x40000100: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Connection: 5
     0x1e* 0x1f 0x1b 0x1c 0x1d
Node 0x22 [Pin Complex] wcaps 0x430681: Stereo Digital
  Pincap 0x0810024: IN EAPD Detect
  Pin Default 0x40000100: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Power: 0x0
Node 0x23 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=0
  Amp-Out vals:  [0x00]
Node 0x24 [Volume Knob Widget] wcaps 0x600000: Mono

--------------010907030306090004070105
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------010907030306090004070105--
