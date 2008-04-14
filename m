From: Ulrich Breymann <u.breymann@gmx.de>
Subject: no sound with snd-hda-intel - error docu
Date: Mon, 14 Apr 2008 19:27:21 +0200
Message-ID: <480393F9.7040704@gmx.de>
Reply-To: u.breymann@gmx.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050806050008040301050101"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 1A6D424465
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Apr 2008 19:29:38 +0200 (CEST)
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
--------------050806050008040301050101
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Dear Alsa-Developers,

unfortunately I hear no sound at all with SuSE Linux 10.3.
Volume is switched on (kmix).
The hardware is ok, it functions with Windows.

For your information I append

- the content of /proc/asound/card0/codec#2 (file intelcodec.txt)

- the result of command 'amixer -i' (file amixer_i.txt)

- the result of command 'lspci -nv' (file lspci_nv.txt)

and here the short results of some other commands:


lspci | grep -i audio:
00:1b.0 Audio device: Intel Corporation 82801I (ICH9 Family) HD Audio
Controller (rev 02)

lsmod | grep hda_intel:
snd_hda_intel         285212  1
snd_pcm                94852  2 snd_pcm_oss,snd_hda_intel
snd                    70452  9
snd_pcm_oss,snd_mixer_oss,snd_seq,snd_seq_device,snd_hda_intel,snd_pcm,snd_timer
snd_page_alloc         26248  2 snd_hda_intel,snd_pcm

rpm -qa | grep kernel:
kernel-bigsmp-2.6.22.5-31
kernel-source-2.6.22.5-31
linux-kernel-headers-2.6.22-19

cat /etc/modprobe.d/sound:
options snd-hda-intel enable=1 index=0
# u1Nb.Eq+LVzceV9F:82801I (ICH9 Family) HD Audio Controller
alias snd-card-0 snd-hda-intel


I hope this can help you (and later me & others).

Best regards


Uli








--------------050806050008040301050101
Content-Type: text/plain;
 name="intelcodec.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="intelcodec.txt"

content of /proc/asound/card0/codec#2  :


Codec: SigmaTel STAC9274D
Address: 2
Vendor Id: 0x83847621
Subsystem Id: 0x80860519
Revision Id: 0x100201
No Modem Function Group found
Default PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: ofs=0x00, nsteps=0x0e, stepsize=0x05, mute=0
Default Amp-Out caps: ofs=0x7f, nsteps=0x7f, stepsize=0x02, mute=1
Node 0x02 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x57 0x57]
  Power: 0x0
Node 0x03 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x2b 0x2b]
  Power: 0x0
Node 0x04 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x2b 0x49]
  Power: 0x0
Node 0x05 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x1f 0x1f]
  Power: 0x0
Node 0x06 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out
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
  Connection: 3
     0x02* 0x03 0x06
Node 0x0b [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x08173f: IN OUT HP Detect
  Pin Default 0x02a1902e: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x24: IN
  Connection: 3
     0x02* 0x03 0x06
Node 0x0c [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x081737: IN OUT Detect
  Pin Default 0x01813021: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
  Pin-ctls: 0x20: IN
  Connection: 1
     0x03
Node 0x0d [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x08173f: IN OUT HP Detect
  Pin Default 0x01114010: [Jack] Speaker at Ext Rear
    Conn = 1/8, Color = Green
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x02
Node 0x0e [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x081737: IN OUT Detect
  Pin Default 0x01a19020: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x24: IN
  Connection: 1
     0x04
Node 0x0f [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x081737: IN OUT Detect
  Pin Default 0x01111012: [Jack] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x05
Node 0x10 [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0837: IN OUT Detect
  Pin Default 0x01117011: [Jack] Speaker at Ext Rear
    Conn = 1/8, Color = Yellow
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x04
Node 0x11 [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0837: IN OUT Detect
  Pin Default 0x400000fb: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Connection: 1
     0x03
Node 0x12 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x500000fe: [N/A] Line Out at Int N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
Node 0x13 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x500001ff: [N/A] Line Out at Int N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
Node 0x14 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x500001fd: [N/A] Line Out at Int N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
Node 0x15 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 9
     0x0e* 0x12 0x0f 0x0b 0x0c 0x0d 0x0a 0x10 0x11
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
  Connection: 3
     0x18* 0x13 0x14
Node 0x1c [Audio Selector] wcaps 0x30090d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 3
     0x19* 0x13 0x14
Node 0x1d [Audio Selector] wcaps 0x30090d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 3
     0x1a* 0x13 0x14
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
  Pin Default 0x01452130: [Jack] SPDIF Out at Ext Rear
    Conn = Optical, Color = Grey
  Pin-ctls: 0x40: OUT
  Connection: 5
     0x1e* 0x1f 0x1b 0x1c 0x1d
Node 0x22 [Pin Complex] wcaps 0x430681: Stereo Digital
  Pincap 0x0810024: IN EAPD Detect
  Pin Default 0x400000fc: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Power: 0x0
Node 0x23 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=0
  Amp-Out vals:  [0x00]
Node 0x24 [Volume Knob Widget] wcaps 0x600000: Mono




--------------050806050008040301050101
Content-Type: text/plain;
 name="amixer_i.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="amixer_i.txt"

Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 122 [48%] [-26.60dB]
  Front Right: Playback 122 [48%] [-26.60dB]
Simple mixer control 'Front',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 127
  Mono:
  Front Left: Playback 87 [69%] [-30.00dB] [on]
  Front Right: Playback 87 [69%] [-30.00dB] [on]
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 127
  Mono:
  Front Left: Playback 31 [24%] [-72.00dB] [on]
  Front Right: Playback 31 [24%] [-72.00dB] [on]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 127
  Mono: Playback 43 [34%] [-63.00dB] [on]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 127
  Mono: Playback 73 [57%] [-40.50dB] [on]
Simple mixer control 'Side',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 127
  Mono:
  Front Left: Playback 43 [34%] [-63.00dB] [on]
  Front Right: Playback 43 [34%] [-63.00dB] [on]
Simple mixer control 'Line In as Output',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'ADCMux',0
  Capabilities: cswitch
  Capture channels: Front Left - Front Right
  Front Left: Capture [on]
  Front Right: Capture [on]
Simple mixer control 'InMux',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 4
  Front Left: Capture 0 [0%] [0.00dB]
  Front Right: Capture 0 [0%] [0.00dB]
Simple mixer control 'InVol',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 14
  Front Left: Capture 0 [0%] [0.00dB]
  Front Right: Capture 0 [0%] [0.00dB]
Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Mic' 'Front Mic' 'Line'
  Item0: 'Mic'




--------------050806050008040301050101
Content-Type: text/plain;
 name="lspci_nv.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci_nv.txt"

00:00.0 Class 0600: 8086:29e0 (rev 01)
	Subsystem: 8086:5442
	Flags: bus master, fast devsel, latency 0
	Capabilities: [e0] Vendor Specific Information

00:01.0 Class 0604: 8086:29e1 (rev 01) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: e0000000-e2ffffff
	Prefetchable memory behind bridge: 00000000d0000000-00000000dfffffff
	Capabilities: [88] Subsystem: 8086:5442
	Capabilities: [80] Power Management version 3
	Capabilities: [90] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+
	Capabilities: [a0] Express Root Port (Slot+) IRQ 0
	Capabilities: [100] Virtual Channel
	Capabilities: [140] Unknown (5)

00:19.0 Class 0200: 8086:294c (rev 02)
	Subsystem: 8086:0001
	Flags: bus master, fast devsel, latency 0, IRQ 220
	Memory at e3200000 (32-bit, non-prefetchable) [size=128K]
	Memory at e3224000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at 30e0 [size=32]
	Capabilities: [c8] Power Management version 2
	Capabilities: [d0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable+
	Capabilities: [e0] Vendor Specific Information

00:1a.0 Class 0c03: 8086:2937 (rev 02) (prog-if 00 [UHCI])
	Subsystem: 8086:5442
	Flags: bus master, medium devsel, latency 0, IRQ 19
	I/O ports at 30c0 [size=32]
	Capabilities: [50] Vendor Specific Information

00:1a.1 Class 0c03: 8086:2938 (rev 02) (prog-if 00 [UHCI])
	Subsystem: 8086:5442
	Flags: bus master, medium devsel, latency 0, IRQ 18
	I/O ports at 30a0 [size=32]
	Capabilities: [50] Vendor Specific Information

00:1a.2 Class 0c03: 8086:2939 (rev 02) (prog-if 00 [UHCI])
	Subsystem: 8086:5442
	Flags: bus master, medium devsel, latency 0, IRQ 17
	I/O ports at 3080 [size=32]
	Capabilities: [50] Vendor Specific Information

00:1a.7 Class 0c03: 8086:293c (rev 02) (prog-if 20 [EHCI])
	Subsystem: 8086:5442
	Flags: bus master, medium devsel, latency 0, IRQ 17
	Memory at e3225400 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Debug port
	Capabilities: [98] Vendor Specific Information

00:1b.0 Class 0403: 8086:293e (rev 02)
	Subsystem: 8086:0519
	Flags: bus master, fast devsel, latency 0, IRQ 23
	Memory at e3220000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
	Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
	Capabilities: [70] Express Unknown type IRQ 0
	Capabilities: [100] Virtual Channel
	Capabilities: [130] Unknown (5)

00:1c.0 Class 0604: 8086:2940 (rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	Memory behind bridge: e3300000-e33fffff
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+
	Capabilities: [90] Subsystem: 8086:2940
	Capabilities: [a0] Power Management version 2
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.4 Class 0604: 8086:2948 (rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 00001000-00001fff
	Memory behind bridge: e3100000-e31fffff
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+
	Capabilities: [90] Subsystem: 8086:2948
	Capabilities: [a0] Power Management version 2
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1d.0 Class 0c03: 8086:2934 (rev 02) (prog-if 00 [UHCI])
	Subsystem: 8086:5442
	Flags: bus master, medium devsel, latency 0, IRQ 20
	I/O ports at 3060 [size=32]
	Capabilities: [50] Vendor Specific Information

00:1d.1 Class 0c03: 8086:2935 (rev 02) (prog-if 00 [UHCI])
	Subsystem: 8086:5442
	Flags: bus master, medium devsel, latency 0, IRQ 21
	I/O ports at 3040 [size=32]
	Capabilities: [50] Vendor Specific Information

00:1d.2 Class 0c03: 8086:2936 (rev 02) (prog-if 00 [UHCI])
	Subsystem: 8086:5442
	Flags: bus master, medium devsel, latency 0, IRQ 19
	I/O ports at 3020 [size=32]
	Capabilities: [50] Vendor Specific Information

00:1d.7 Class 0c03: 8086:293a (rev 02) (prog-if 20 [EHCI])
	Subsystem: 8086:5442
	Flags: bus master, medium devsel, latency 0, IRQ 20
	Memory at e3225000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Debug port
	Capabilities: [98] Vendor Specific Information

00:1e.0 Class 0604: 8086:244e (rev 92) (prog-if 01 [Subtractive decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=32
	Memory behind bridge: e3000000-e30fffff
	Capabilities: [50] Subsystem: 8086:5442

00:1f.0 Class 0601: 8086:2916 (rev 02)
	Subsystem: 8086:5442
	Flags: bus master, medium devsel, latency 0
	Capabilities: [e0] Vendor Specific Information

00:1f.2 Class 0101: 8086:2920 (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: 8086:5442
	Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 18
	I/O ports at 3458 [size=8]
	I/O ports at 346c [size=4]
	I/O ports at 3450 [size=8]
	I/O ports at 3468 [size=4]
	I/O ports at 3430 [size=16]
	I/O ports at 3420 [size=16]
	Capabilities: [70] Power Management version 3
	Capabilities: [b0] Vendor Specific Information

00:1f.3 Class 0c05: 8086:2930 (rev 02)
	Subsystem: 8086:5442
	Flags: medium devsel, IRQ 19
	Memory at e3225800 (64-bit, non-prefetchable) [size=256]
	I/O ports at 3000 [size=32]

00:1f.5 Class 0101: 8086:2926 (rev 02) (prog-if 85 [Master SecO PriO])
	Subsystem: 8086:5442
	Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 18
	I/O ports at 3448 [size=8]
	I/O ports at 3464 [size=4]
	I/O ports at 3440 [size=8]
	I/O ports at 3460 [size=4]
	I/O ports at 3410 [size=16]
	I/O ports at 3400 [size=16]
	Capabilities: [70] Power Management version 3
	Capabilities: [b0] Vendor Specific Information

01:00.0 Class 0300: 10de:0402 (rev a1) (prog-if 00 [VGA])
	Subsystem: 1458:3447
	Flags: bus master, fast devsel, latency 0, IRQ 16
	Memory at e2000000 (32-bit, non-prefetchable) [size=16M]
	Memory at d0000000 (64-bit, prefetchable) [size=256M]
	Memory at e0000000 (64-bit, non-prefetchable) [size=32M]
	I/O ports at 2000 [size=128]
	Capabilities: [60] Power Management version 2
	Capabilities: [68] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
	Capabilities: [78] Express Endpoint IRQ 0
	Capabilities: [100] Virtual Channel
	Capabilities: [128] Power Budgeting
	Capabilities: [600] Unknown (11)

03:00.0 Class 0101: 11ab:6121 (rev b2) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: 8086:5442
	Flags: bus master, fast devsel, latency 0, IRQ 16
	I/O ports at 1018 [size=8]
	I/O ports at 1024 [size=4]
	I/O ports at 1010 [size=8]
	I/O ports at 1020 [size=4]
	I/O ports at 1000 [size=16]
	Memory at e3100000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable-
	Capabilities: [e0] Express Legacy Endpoint IRQ 0
	Capabilities: [100] Advanced Error Reporting

04:03.0 Class 0c00: 104c:8023 (prog-if 10 [OHCI])
	Subsystem: 8086:5442
	Flags: bus master, medium devsel, latency 32, IRQ 21
	Memory at e3004000 (32-bit, non-prefetchable) [size=2K]
	Memory at e3000000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2





--------------050806050008040301050101
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050806050008040301050101--
