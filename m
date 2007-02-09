From: ByteEnable <ByteEnable@austin.rr.com>
Subject: Clevo D900T with hda-intel alc880
Date: Thu, 08 Feb 2007 22:31:28 -0600
Message-ID: <1170995488.4487.11.camel@MobileRob.site>
Reply-To: ByteEnable@austin.rr.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-L1K3oNQVrQJhLEWXpNyl"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-L1K3oNQVrQJhLEWXpNyl
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I have a Clevo laptop D900T with hda-intel audio and an ALC880.  I
finally have audio again with 1.0.14rc2.  From the docs it talks about
the timeout message because the alsa driver could not get an interrupt.
However, lspci says it has IRQ 21.  How can I remedy this?

dmesg:
ALSA
alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:696:
codec_mask = 0x3
hda_codec: Unknown model for ALC880, trying auto-probe from BIOS...
ALSA /home/ByteEnable/temp/alsa/alsa-driver-1.0.14rc2/pci/hda/hda_codec.c:2171: autoconfig: line_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA /home/ByteEnable/temp/alsa/alsa-driver-1.0.14rc2/pci/hda/hda_codec.c:2175:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA /home/ByteEnable/temp/alsa/alsa-driver-1.0.14rc2/pci/hda/hda_codec.c:2179:    hp_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA /home/ByteEnable/temp/alsa/alsa-driver-1.0.14rc2/pci/hda/hda_codec.c:2187:    inputs: mic=0x0, fmic=0x0, line=0x0, fline=0x0, cd=0x0, aux=0x0
hda_codec: Cannot set up configuration from BIOS.  Using 3-stack mode...
ALSA
alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:556:
hda_intel: azx_get_response timeout, switching to polling mode...
ALSA
alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:562:
hda_intel: azx_get_response timeout, switching to single_cmd mode
...
ALSA alsa-driver-1.0.14rc2/pci/hda/hda_codec.c:571: hda_codec: cannot
malloc
ALSA
alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1158: azx_pcm_prepare: bufsize=0x10000, fragsize=0x1000, format=0x11
ALSA alsa-driver-1.0.14rc2/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x11
ALSA alsa-driver-1.0.14rc2/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x2, stream=0x0, channel=0, format=0x0
ALSA
alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1158: azx_pcm_prepare: bufsize=0x10000, fragsize=0x1000, format=0x11
ALSA alsa-driver-1.0.14rc2/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x11
ALSA alsa-driver-1.0.14rc2/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x2, stream=0x0, channel=0, format=0x0
ALSA
alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1158: azx_pcm_prepare: bufsize=0x10000, fragsize=0x1000, format=0x11
ALSA alsa-driver-1.0.14rc2/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x11
ALSA alsa-driver-1.0.14rc2/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x2, stream=0x0, channel=0, format=0x0
ALSA
alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1158: azx_pcm_prepare: bufsize=0x10000, fragsize=0x1000, format=0x11
ALSA alsa-driver-1.0.14rc2/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x11
ALSA /home/ByteEnable/temp/alsa/alsa-driver-1.0.14rc2/pci/hda/hda_codec.c:627: hda_codec_setup_stream: NID=0x2, stream=0x0, channel=0, format=0x0
ALSA
alsa-driver-1.0.14rc2/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1158: azx_pcm_prepare: bufsize=0x10000, fragsize=0x1000, format=0x11
ALSA alsa-driver-1.0.14rc2/pci/hda/hda_codec.c:627:
hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x11

lspci output:
00:1b.0 Class 0403: 8086:2668 (rev 03)
        Subsystem: 1558:0900
        Flags: bus master, fast devsel, latency 0, IRQ 21
        Memory at b0000000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable-
        Capabilities: [70] Express Unknown type IRQ 0


--=-L1K3oNQVrQJhLEWXpNyl
Content-Disposition: attachment; filename=clevo900t.txt
Content-Type: text/plain; name=clevo900t.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

Codec: Realtek ALC880
Address: 0
Vendor Id: 0x10ec0880
Subsystem Id: 0x8800000
Revision Id: 0x90500
Default PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
Node 0x02 [Audio Output] wcaps 0x411: Stereo
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power: 0x0
Node 0x03 [Audio Output] wcaps 0x411: Stereo
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power: 0x0
Node 0x04 [Audio Output] wcaps 0x411: Stereo
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power: 0x0
Node 0x05 [Audio Output] wcaps 0x411: Stereo
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power: 0x0
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x1e]: 16 20 24 32
    formats [0x1]: PCM
Node 0x07 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03, mute=1
  Amp-In vals:  [0xa3 0xa3] [0xa3 0xa3] [0xa3 0xa3] [0xa3 0xa3] [0xa3 0xa3] [0xa3 0xa3] [0xa3 0xa3]
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Power: 0x0
  Connection: 7
     0x18* 0x19 0x1a 0x1b 0x1c 0x14 0x15
Node 0x08 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03, mute=1
  Amp-In vals:  [0xa3 0xa3] [0xa3 0xa3] [0xa3 0xa3] [0xa3 0xa3] [0xa3 0xa3] [0xa3 0xa3] [0xa3 0xa3]
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Power: 0x0
  Connection: 7
     0x18* 0x19 0x1a 0x1b 0x1c 0x14 0x15
Node 0x09 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03, mute=1
  Amp-In vals:  [0xa3 0xa3] [0xa3 0xa3] [0xa3 0xa3] [0xa3 0xa3] [0xa3 0xa3] [0xa3 0xa3] [0xa3 0xa3] [0xa3 0xa3] [0xa3 0xa3] [0xa3 0xa3]
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Power: 0x0
  Connection: 10
     0x18* 0x19 0x1a 0x1b 0x1c 0x0b 0x14 0x15 0x16 0x17
Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x1e]: 16 20 24 32
    formats [0x1]: PCM
  Connection: 1
     0x1f
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x23, nsteps=0x41, stepsize=0x03, mute=1
  Amp-In vals:  [0xc1 0xc1] [0x00 0x00] [0xc1 0xc1] [0xb3 0xb3] [0x2f 0x2f] [0x1a 0x1a] [0xa3 0xa3] [0xa3 0xa3]
  Connection: 8
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15
Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x40 0x40]
  Connection: 2
     0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x03 0x0b
Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x34 0x40]
  Connection: 2
     0x04 0x0b
Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x34 0x34]
  Connection: 2
     0x05 0x0b
Node 0x10 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x0c 0x0d 0x0e* 0x0f
Node 0x11 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x0c* 0x0d 0x0e 0x0f
Node 0x12 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x0c 0x0d 0x0e 0x0f*
Node 0x13 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x0c* 0x0d 0x0e 0x0f
Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x083f: IN OUT HP Detect
  Pin Default 0x00000000: [Jack] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0c
Node 0x15 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x083f: IN OUT HP Detect
  Pin Default 0x00000000: [Jack] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0d
Node 0x16 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x083f: IN OUT HP Detect
  Pin Default 0x00000000: [Jack] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0e
Node 0x17 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x083f: IN OUT HP Detect
  Pin Default 0x00000000: [Jack] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0f
Node 0x18 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08133f: IN OUT HP Detect
  Pin Default 0x00000000: [Jack] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x24: IN
  Connection: 1
     0x10
Node 0x19 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x08133f: IN OUT HP Detect
  Pin Default 0x00000000: [Jack] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0xc0: OUT HP
  Connection: 1
     0x11
Node 0x1a [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08133f: IN OUT HP Detect
  Pin Default 0x00000000: [Jack] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x20: IN
  Connection: 1
     0x12
Node 0x1b [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08133f: IN OUT HP Detect
  Pin Default 0x00000000: [Jack] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x24: IN
  Connection: 1
     0x13
Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x00000000: [Jack] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x0820: IN
  Pin Default 0x00000000: [Jack] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
  Pincap 0x0810: OUT
  Pin Default 0x01000000: [Jack] Line Out at Ext Rear
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Connection: 1
     0x06
Node 0x1f [Pin Complex] wcaps 0x400200: Mono Digital
  Pincap 0x0820: IN
  Pin Default 0x00000000: [Jack] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
Node 0x21 [Volume Knob Widget] wcaps 0x600080: Mono

--=-L1K3oNQVrQJhLEWXpNyl
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-L1K3oNQVrQJhLEWXpNyl
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-L1K3oNQVrQJhLEWXpNyl--
