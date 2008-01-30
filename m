From: "Marcin Floryan" <marcin.floryan@gmail.com>
Subject: Re: ACER Aspier 5630 (snd-hda-intel ALC883)
Date: Wed, 30 Jan 2008 19:42:19 +0000
Message-ID: <14cea40a0801301142l67b3c911j335581288c053ddf@mail.gmail.com>
References: <14cea40a0801260447h5582a1cflc05670c7d0077a45@mail.gmail.com>
	<20080126184535.GL1177@serv.smile.org.ua>
	<14cea40a0801300829k5a09ccdci28f9f5e6a6121ef7@mail.gmail.com>
	<s5hhcgv2ry2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 72CFD24771
	for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2008 20:42:21 +0100 (CET)
Received: by el-out-1112.google.com with SMTP id z25so130678ele.8
	for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2008 11:42:20 -0800 (PST)
In-Reply-To: <s5hhcgv2ry2.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Andy Shevchenko <andy@smile.org.ua>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 30/01/2008, Takashi Iwai <tiwai@suse.de> wrote:

> Anyway, show the content of /proc/asound/card0/codec#* files and the
> generated file via "alsactl -f somefile store".  These will be helpful
> for further analysis.

Sorry, missed from the previous email. All with driver seto to model=auto

Codec: Realtek ALC883
Address: 0
Vendor Id: 0x10ec0883
Subsystem Id: 0x10250090
Revision Id: 0x100002
No Modem Function Group found
Default PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=2, o=0, i=0, unsolicited=1, wake=0
  IO[0]: enable=1, dir=1, wake=0, sticky=0, data=1
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0
Node 0x02 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x03 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x04 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x05 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x1
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0x1e]: 16 20 24 32
    formats [0x1]: PCM
Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=0x08, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x1f 0x1f]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 1
     0x23
Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=0x08, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x1f 0x1f]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 1
     0x22
Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital
  Converter: stream=0, channel=0
  SDI-Select: 0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0x1e]: 16 20 24 32
    formats [0x1]: PCM
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x1f
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x9b 0x9b] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80
0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 10
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17
Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x1f 0x1f]
  Connection: 2
     0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x03 0x0b
Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x04 0x0b
Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x05 0x0b
Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x12 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x14 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x083e: IN OUT HP Detect Trigger
  Pin Default 0xc2211110: [Both] HP Out at Ext Front
    Conn = 1/8, Color = Black
    DefAssociation = 0x1, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=00, enabled=0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x15 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x083e: IN OUT HP Detect Trigger
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
  Unsolicited: tag=00, enabled=0
  Connection: 5
     0x0c 0x0d* 0x0e 0x0f 0x26
Node 0x16 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x083e: IN OUT HP Detect Trigger
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
  Unsolicited: tag=00, enabled=0
  Connection: 5
     0x0c 0x0d 0x0e* 0x0f 0x26
Node 0x17 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x083e: IN OUT HP Detect Trigger
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
  Unsolicited: tag=00, enabled=0
  Connection: 5
     0x0c 0x0d 0x0e 0x0f* 0x26
Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x03 0x03] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08173e: IN OUT HP Detect Trigger
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x02a19930: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
    DefAssociation = 0x3, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08173e: IN OUT HP Detect Trigger
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08173e: IN OUT HP Detect Trigger
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x0281313f: [Jack] Line In at Ext Front
    Conn = 1/8, Color = Blue
    DefAssociation = 0x3, Sequence = 0xf
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08173e: IN OUT HP Detect Trigger
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x0820: IN
  Pin Default 0x4015130d: [N/A] Speaker at Ext N/A
    Conn = Optical, Color = Black
    DefAssociation = 0x0, Sequence = 0xd
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
  Pincap 0x0810: OUT
  Pin Default 0x02451120: [Jack] SPDIF Out at Ext Front
    Conn = Optical, Color = Black
    DefAssociation = 0x2, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Connection: 1
     0x06
Node 0x1f [Pin Complex] wcaps 0x400200: Mono Digital
  Pincap 0x0820: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
  Processing caps: benign=0, ncoeff=17
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x80 0x80] [0x00
0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
[0x80 0x80]
  Amp-Out caps: N/A
  Amp-Out vals:  [0x00 0x00]
  Connection: 11
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x23 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x80 0x80] [0x00
0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
[0x80 0x80]
  Amp-Out caps: N/A
  Amp-Out vals:  [0x00 0x00]
  Connection: 11
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x25 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x26 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x25 0x0b
Codec: Conexant ID 2bfa
Address: 1
Vendor Id: 0x14f12bfa
Subsystem Id: 0x1025007f
Revision Id: 0x90000
Modem Function Group: 0x2

*******************

state.Intel {
        control.1 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                comment.dbmin -4650
                comment.dbmax 0
                iface MIXER
                name 'Front Playback Volume'
                value.0 31
                value.1 31
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
                comment.range '0 - 31'
                comment.dbmin -3450
                comment.dbmax 1200
                iface MIXER
                name 'Mic Playback Volume'
                value.0 27
                value.1 27
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
                comment.range '0 - 31'
                comment.dbmin -3450
                comment.dbmax 1200
                iface MIXER
                name 'Line Playback Volume'
                value.0 0
                value.1 0
        }
        control.6 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Line Playback Switch'
                value.0 false
                value.1 false
        }
        control.7 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 3'
                comment.dbmin 0
                comment.dbmax 3000
                iface MIXER
                name 'Mic Boost'
                value.0 3
                value.1 3
        }
        control.8 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                comment.dbmin -1200
                comment.dbmax 3450
                iface MIXER
                name 'Capture Volume'
                value.0 31
                value.1 31
        }
        control.9 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Capture Switch'
                value.0 true
                value.1 true
        }
        control.10 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                comment.dbmin -1200
                comment.dbmax 3450
                iface MIXER
                name 'Capture Volume'
                index 1
                value.0 31
                value.1 31
        }
        control.11 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Capture Switch'
                index 1
                value.0 true
                value.1 true
        }
        control.12 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 1
                comment.item.0 Mic
                comment.item.1 Line
                iface MIXER
                name 'Input Source'
                value Mic
        }
        control.13 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 1
                comment.item.0 Mic
                comment.item.1 Line
                iface MIXER
                name 'Input Source'
                index 1
                value Mic
        }
        control.14 {
                comment.access read
                comment.type IEC958
                comment.count 1
                iface MIXER
                name 'IEC958 Playback Con Mask'
                value
'0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
        }
        control.15 {
                comment.access read
                comment.type IEC958
                comment.count 1
                iface MIXER
                name 'IEC958 Playback Pro Mask'
                value
'0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
        }
        control.16 {
                comment.access 'read write'
                comment.type IEC958
                comment.count 1
                iface MIXER
                name 'IEC958 Playback Default'
                value
'0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
        }
        control.17 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'IEC958 Playback Switch'
                value true
        }
        control.18 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 31'
                comment.dbmin -4650
                comment.dbmax 0
                iface MIXER
                name 'Master Playback Volume'
                value 31
        }
        control.19 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Master Playback Switch'
                value true
        }
        control.20 {
                comment.access 'read write user'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 255'
                comment.tlv '0000000100000008ffffec1400000014'
                comment.dbmin -5100
                comment.dbmax 0
                iface MIXER
                name 'PCM Playback Volume'
                value.0 255
                value.1 255
        }
        control.21 {
                comment.access 'read write user'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 120'
                comment.tlv '0000000100000008fffff44800000032'
                comment.dbmin -3000
                comment.dbmax 3000
                iface MIXER
                name 'Digital Capture Volume'
                value.0 120
                value.1 120
        }
}




-- 
Marcin Floryan
http://marcin.floryan.pl/

Please consider the environment before printing this email.
