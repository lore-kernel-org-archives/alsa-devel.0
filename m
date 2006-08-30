From: Andreas Hartmann <andihartmann@freenet.de>
Subject: [Realtek ALC260] Can't enable SPDIF out
Date: Wed, 30 Aug 2006 17:38:00 +0200
Message-ID: <44F5B0D8.8090402@p54A1A81E.dip0.t-ipconnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

Hello!

I've got a MAXDATA ECO 4000IW notebook, which has an ICH6-chipset (Realtek
ALC260). It offers a jack for a microphone and a jack for headphones,
which is used as a S/PDIF out additionally.

My problem is, that I can't get the S/PDIF out to work. I'm not able to
switch the jack between analog and S/PDIF. Switching on S/PDIF with the
IEC958 knob (alsamixer) does not work.


I'm using SuSE 10.1 with kernel 2.6.16.21-0.13-default with alsa-driver
1.0.12 (I updated the drivers - I had the same problem with the original
ones).

Could you please tell me, how to get S/PDIF out to work?


Kind regards,
Andreas Hartmann


lspci-vvv
00:1b.0 Audio device: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio Controller (rev 04)
        Subsystem: Mitac Unknown device 8048
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size 04
        Interrupt: pin A routed to IRQ 209
        Region 0: Memory at d0180000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
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


lspci -nvvv
00:1b.0 Class 0403: 8086:2668 (rev 04)
        Subsystem: 1071:8048
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size 04
        Interrupt: pin A routed to IRQ 209
        Region 0: Memory at d0180000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
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




notebook1:/proc/asound/card0> cat codec#1
Codec: Generic 14f1 ID 2bfa
Address: 1
Vendor Id: 0x14f12bfa
Subsystem Id: 0x14f10001
Revision Id: 0x90000

notebook1:/proc/asound/card0/pcm1p/sub0> cat info
card: 0
device: 1
subdevice: 0
stream: PLAYBACK
id: ALC260 Digital
name: ALC260 Digital
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

notebook1:/proc/asound/card0/pcm0p/sub0> cat info
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: ALC260 Analog
name: ALC260 Analog
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

card: 0
device: 0
subdevice: 0
stream: CAPTURE
id: ALC260 Analog
name: ALC260 Analog
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1


notebook1:/proc/asound/card0> cat codec#0
Codec: Realtek ALC260
Address: 0
Vendor Id: 0x10ec0260
Subsystem Id: 0x10710235
Revision Id: 0x100400
Default PCM: rates 0x560, bits 0x0e, types 0x1
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
Node 0x02 [Audio Output] wcaps 0x11: Stereo
  PCM: rates 0x560, bits 0x0e, types 0x1
Node 0x03 [Audio Output] wcaps 0x211: Stereo Digital
  PCM: rates 0x560, bits 0x1e, types 0x1
Node 0x04 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80
0x80] [0x80 0x80] [0x80 0x80]
  PCM: rates 0x160, bits 0x06, types 0x1
  Connection: 7
     0x12* 0x13 0x14 0x15 0x16 0x0f 0x10
Node 0x05 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80
0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  PCM: rates 0x160, bits 0x06, types 0x1
  Connection: 8
     0x12* 0x13 0x14 0x15 0x16 0x07 0x0f 0x10
Node 0x06 [Audio Input] wcaps 0x100391: Stereo Digital
  PCM: rates 0x160, bits 0x1e, types 0x1
  Connection: 1
     0x19
Node 0x07 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x23, nsteps=0x41, stepsize=0x03, mute=1
  Amp-In vals:  [0x80 0x80] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x80
0x80] [0xa3 0xa3] [0xa3 0xa3] [0xa3 0xa3]
  Connection: 8
     0x12 0x13 0x14 0x15 0x16 0x17 0x0f 0x10
Node 0x08 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x37 0x37]
  Connection: 2
     0x02 0x07
Node 0x09 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x02 0x07
Node 0x0a [Audio Mixer] wcaps 0x20010e: Mono Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00] [0x00]
  Amp-Out caps: ofs=0x23, nsteps=0x41, stepsize=0x03, mute=0
  Amp-Out vals:  [0x00]
  Connection: 2
     0x02 0x07
Node 0x0b [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x08* 0x09
Node 0x0c [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x08* 0x09
Node 0x0d [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x08* 0x09
Node 0x0e [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x08* 0x09
Node 0x0f [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x081003f: IN OUT HP EAPD Detect
  Pin Default 0x01011110: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x08
Node 0x10 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x081003f: IN OUT HP EAPD Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x20: IN
  Connection: 1
     0x09
Node 0x11 [Pin Complex] wcaps 0x40010c: Mono Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80]
  Pincap 0x0810: OUT
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0a
Node 0x12 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08133f: IN OUT HP Detect
  Pin Default 0x01a19930: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x24: IN
  Connection: 1
     0x0b
Node 0x13 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08133f: IN OUT HP Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x20: IN
  Connection: 1
     0x0c
Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08133f: IN OUT HP Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x20: IN
  Connection: 1
     0x0d
Node 0x15 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08133f: IN OUT HP Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x20: IN
  Connection: 1
     0x0e
Node 0x16 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0xb7331120: [Fixed] CD at Oth Mobile-In
    Conn = ATAPI, Color = Black
  Pin-ctls: 0x00:
Node 0x17 [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x0820: IN
  Pin Default 0xb7831121: [Fixed] Line In at Oth Mobile-In
    Conn = ATAPI, Color = Black
  Pin-ctls: 0x00:
Node 0x18 [Pin Complex] wcaps 0x400380: Mono Digital
  Pincap 0x0814: OUT Detect
  Pin Default 0x0145111e: [Jack] SPDIF Out at Ext Rear
    Conn = Optical, Color = Black
  Pin-ctls: 0x00:
  Connection: 1
     0x03
Node 0x19 [Pin Complex] wcaps 0x400280: Mono Digital
  Pincap 0x0824: IN Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x00:
Node 0x1a [Vendor Defined Widget] wcaps 0xf00040: Mono
Node 0x1b [Volume Knob Widget] wcaps 0x600080: Mono


alsactl names -f names | cat names
ctl {
        alsactl1 {
                name hw:0
                comment 'Physical Device - HDA Intel at 0xd0180000 irq 217'
        }
}
pcm {
        alsactl1 {
                name default:0
                comment 'Abstract Device - Default Device (Duplex)'
        }
        alsactl2 {
                name plug:default:0
                comment 'Abstract Device With Conversions - Default Device
(Duplex)'
        }
        alsactl3 {
                name front:0
                comment 'Abstract Device - Front Speakers (Duplex)'
        }
        alsactl4 {
                name plug:front:0
                comment 'Abstract Device With Conversions - Front Speakers
(Duplex)'
        }
        alsactl5 {
                name 'hw:0,0'
                comment 'Physical Device - ALC260 Analog (Duplex)'
        }
        alsactl6 {
                name 'plughw:0,0'
                comment 'Physical Device With Conversions - ALC260 Analog
(Duplex)'
        }
        alsactl7 {
                name 'hw:0,1'
                comment 'Physical Device - ALC260 Digital (Playback)'
        }
        alsactl8 {
                name 'plughw:0,1'
                comment 'Physical Device With Conversions - ALC260 Digital
(Playback)'
        }
        alsactl9 {
                name surround40:0
                comment 'Abstract Device - Front and Rear Speakers (Duplex)'
        }
        alsactl10 {
                name plug:surround40:0
                comment 'Abstract Device With Conversions - Front and Rear
Speakers (Duplex)'
        }
        alsactl11 {
                name surround51:0
                comment 'Abstract Device - Front, Rear, Center and Woofer
(Duplex)'
        }
        alsactl12 {
                name plug:surround51:0
                comment 'Abstract Device With Conversions - Front, Rear,
Center and Woofer (Duplex)'
        }
        alsactl13 {
                name surround71:0
                comment 'Abstract Device - Front, Rear, Side, Center and
Woofer (Duplex)'
        }
        alsactl14 {
                name plug:surround71:0
                comment 'Abstract Device With Conversions - Front, Rear,
Side, Center and Woofer (Duplex)'
        }
        alsactl15 {
                name spdif:0
                comment 'Abstract Device - S/PDIF (IEC958) Optical or
Coaxial Wire (Playback)'
        }
        alsactl16 {
                name plug:spdif:0
                comment 'Abstract Device With Conversions - S/PDIF
(IEC958) Optical or Coaxial Wire (Playback)'
        }
}
rawmidi {
}
timer {
        alsactl1 {
                name 'hw:CLASS=1,SCLASS=0,CARD=-1,DEV=0,SUBDEV=0'
                comment 'Physical Device - system timer'
        }
}
seq {
        alsactl1 {
                name default
                comment 'Default Device - Sequencer (Duplex)'
        }
        alsactl2 {
                name hw
                comment 'Physical Device - Sequencer (Duplex)'
        }
}


alsactl store -f config | cat config
state.Intel {
        control.1 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 64'
                iface MIXER
                name 'Front Playback Volume'
                value.0 41
                value.1 41
        }
        control.2 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Front Playback Switch'
                value.0 true
                value.1 true
        }
        control.3 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 65'
                iface MIXER
                name 'Mic Playback Volume'
                value.0 0
                value.1 0
        }
        control.4 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Mic Playback Switch'
                value.0 false
                value.1 false
        }
        control.5 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 65'
                iface MIXER
                name 'CD Playback Volume'
                value.0 0
                value.1 0
        }
        control.6 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'CD Playback Switch'
                value.0 false
                value.1 false
        }
        control.7 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 35'
                iface MIXER
                name 'Capture Volume'
                value.0 0
                value.1 0
        }
        control.8 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Capture Switch'
                value.0 false
                value.1 false
        }
        control.9 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 35'
                iface MIXER
                name 'Capture Volume'
                index 1
                value.0 0
                value.1 0
        }
        control.10 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Capture Switch'
                index 1
                value.0 false
                value.1 false
        }
        control.11 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 1
                comment.item.0 Mic
                comment.item.1 CD
                iface MIXER
                name 'Input Source'
                value Mic
        }
        control.12 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 1
                comment.item.0 Mic
                comment.item.1 CD
                iface MIXER
                name 'Input Source'
                index 1
                value Mic
        }
        control.13 {
                comment.access read
                comment.type IEC958
                comment.count 1
                iface MIXER
                name 'IEC958 Playback Con Mask'
                value
'0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
        }
        control.14 {
                comment.access read
                comment.type IEC958
                comment.count 1
                iface MIXER
                name 'IEC958 Playback Pro Mask'
                value
'0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
        }
        control.15 {
                comment.access 'read write'
                comment.type IEC958
                comment.count 1
                iface MIXER
                name 'IEC958 Playback Default'
                value
'0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
        }
        control.16 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'IEC958 Playback Switch'
                value true
        }
        control.17 {
                comment.access 'read write user'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 255'
                iface MIXER
                name 'PCM Playback Volume'
                value.0 230
                value.1 230
        }
}


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
