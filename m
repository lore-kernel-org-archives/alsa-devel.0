From: Steven Zakulec <spzakulec@mail.widener.edu>
Subject: Re: [HDA-Intel/ALC268] no sound
Date: Mon, 2 Jul 2007 20:45:14 -0400 (EDT)
Message-ID: <182517449.1183423514675.JavaMail.root@ccprodapp22>
Reply-To: Steven Zakulec <spzakulec@mail.widener.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_972_182541462.1183423514674"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ccprodapp22.campuscruiser.com (email.campuscruiser.com
	[216.35.68.59]) by alsa0.perex.cz (Postfix) with ESMTP id 334E6243C0
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jul 2007 02:45:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

------=_Part_972_182541462.1183423514674
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


I've attached the file.  I tried using aplay and ffplay- both had no trouble opening and playing a file, there was just no sound.
---------------------------------------
Original E-mail
From: Takashi Iwai [tiwai@suse.de]
Date: 07/02/2007 01:25 PM 
To: Steven Zakulec [spzakulec@mail.widener.edu]
Subject: Re: [alsa-devel] [HDA-Intel/ALC268] no sound

At Wed, 27 Jun 2007 17:34:15 -0400 (EDT),
Steven Zakulec wrote:
> 
> (Continued from this thread: http://mailman.alsa-project.org/pipermail/alsa-devel/2007-June/001459.html)
> 
> I've included the result of alsactl -f somefile store.  I thought it got sent to the list earlier, but apparently not. Below this I also added the alsa things from dmesg.

And the contents of /proc/asound/card0/codec#* files, please.
If you change the mixer status, these files also changed, too.

Also, please inform what you tested more exactly.  In which hardware
configuration and which application with what parameters...


Takashi

> 

> state.Intel {
>         control.1 {
>                 comment.access 'read write'
>                 comment.type INTEGER
>                 comment.count 2
>                 comment.range '0 - 64'
>                 iface MIXER
>                 name 'Front Playback Volume'
>                 value.0 57
>                 value.1 57
>         }
>         control.2 {
>                 comment.access 'read write'
>                 comment.type BOOLEAN
>                 comment.count 2
>                 iface MIXER
>                 name 'Front Playback Switch'
>                 value.0 true
>                 value.1 true
>         }
>         control.3 {
>                 comment.access 'read write'
>                 comment.type INTEGER
>                 comment.count 2
>                 comment.range '0 - 64'
>                 iface MIXER
>                 name 'Headphone Playback Volume'
>                 value.0 63
>                 value.1 63
>         }
>         control.4 {
>                 comment.access 'read write'
>                 comment.type BOOLEAN
>                 comment.count 2
>                 iface MIXER
>                 name 'Headphone Playback Switch'
>                 value.0 true
>                 value.1 true
>         }
>         control.5 {
>                 comment.access 'read write'
>                 comment.type INTEGER
>                comment.count 2
>                 comment.range '0 - 31'
>                 iface MIXER
>                 name 'Capture Volume'
>                 value.0 1
>                 value.1 1
>         }
>         control.6 {
>                 comment.access 'read write'
>                 comment.type BOOLEAN
>                 comment.count 2
>                 iface MIXER
>                 name 'Capture Switch'
>                 value.0 false
>                 value.1 false
>         }
>         control.7 {
>                 comment.access 'read write'
>                 comment.type INTEGER
>                 comment.count 2
>                 comment.range '0 - 31'
>                 iface MIXER
>                 name 'Capture Volume'
>                 index 1
>                 value.0 1
>                 value.1 1
>         }
>         control.8 {
>                 comment.access 'read write'
>                 comment.type BOOLEAN
>                 comment.count 2
>                 iface MIXER
>                 name 'Capture Switch'
>                 index 1
>                 value.0 false
>                 value.1 false
>         }
>         control.9 {
>                 comment.access 'read write'
>                 comment.type ENUMERATED
>                 comment.count 1
>                 comment.item.0 Mic
>                 comment.item.1 'Front Mic'
>                 iface MIXER
>                 name 'Input Source'
>                 value Mic
>         }
>         control.10 {
>                 comment.access 'read write'
>                 comment.type ENUMERATED
>                 comment.count 1
>                 comment.item.0 Mic
>                 comment.item.1 'Front Mic'
>                 iface MIXER
>                 name 'Input Source'
>                 index 1
>                 value Mic
>         }
>         control.11 {
>                 comment.access 'read write'
>                 comment.type BOOLEAN
>                 comment.count 1
>                 iface MIXER
>                 name 'Off-hook Switch'
>                 value false
>         }
>         control.12 {
>                 comment.access 'read write'
>                 comment.type BOOLEAN
>                 comment.count 1
>                 iface MIXER
>                 name 'Caller ID Switch'
>                 value false
>         }
>         control.13 {
>                 comment.access 'read write user'
>                 comment.type INTEGER
>                 comment.count 2
>                 comment.range '0 - 255'
>                 comment.tlv '0000000100000008ffffec1400000014'
>                 iface MIXER
>                 name 'PCM Playback Volume'
>                 value.0 255
>                 value.1 255
>         }
> }
> hda_codec: Unknown model for ALC268, trying auto-probe from BIOS...
> [   18.512000] ALSA /home/szakulec/alsa-hg/alsa-driver/pci/hda/hda_codec.c:2339: autoconfig: line_outs=1 (0x14/0x0/0x0/0x0/0x0)
> [   18.512000] ALSA /home/szakulec/alsa-hg/alsa-driver/pci/hda/hda_codec.c:2343:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [   18.512000] ALSA /home/szakulec/alsa-hg/alsa-driver/pci/hda/hda_codec.c:2347:    hp_outs=1 (0x15/0x0/0x0/0x0/0x0)
> [   18.512000] ALSA /home/szakulec/alsa-hg/alsa-driver/pci/hda/hda_codec.c:2355:    inputs: mic=0x19, fmic=0x18, line=0x0, fline=0x0, cd=0x0, aux=0x0
> [   19.236000] ALSA /home/szakulec/alsa-hg/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/patch_si3054.c:244: si3054: cannot initialize. EXT MID = 0000
> [   19.244000] ALSA /home/szakulec/alsa-hg/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/patch_si3054.c:256: Link Frame Detect(FDT) is not ready (line status: 0000)
> 
> 
> 
>                 comment.count 2
> :
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 



------=_Part_972_182541462.1183423514674
Content-Type: text/plain; name=codec.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=codec.txt

Codec: Realtek ALC268
Address: 0
Vendor Id: 0x10ec0268
Subsystem Id: 0x1179ff10
Revision Id: 0x100003
No Modem Function Group found
Default PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
Node 0x02 [Audio Output] wcaps 0x1d: Stereo Amp-Out
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x30 0x30]
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x03 [Audio Output] wcaps 0x1d: Stereo Amp-Out
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x3f 0x3f]
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x04 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x05 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0x1e]: 16 20 24 32
    formats [0x1]: PCM
Node 0x07 [Audio Input] wcaps 0x100111: Stereo
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 1
     0x24
Node 0x08 [Audio Input] wcaps 0x100111: Stereo
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 1
     0x23
Node 0x09 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0a [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0b [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0c [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0d [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0e [Audio Mixer] wcaps 0x20010a: Mono Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00]
  Connection: 1
     0x02
Node 0x0f [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x02 0x1d
Node 0x10 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80]
  Connection: 3
     0x03 0x1d 0x02
Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x12 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x00:
Node 0x13 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x00:
Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x081003c: IN OUT HP EAPD Detect
  Pin Default 0x99130110: [Fixed] Speaker at Int ATAPI
    Conn = ATAPI, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0f
Node 0x15 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x081003c: IN OUT HP EAPD Detect
  Pin Default 0x02211020: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Black
  Pin-ctls: 0xc0: OUT HP
  Connection: 1
     0x10
Node 0x16 [Pin Complex] wcaps 0x40010c: Mono Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80]
  Pincap 0x0810: OUT
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x00:
  Connection: 1
     0x0e
Node 0x17 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x02, stepsize=0x4f, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x083734: IN OUT Detect
  Pin Default 0x02a11830: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Black
  Pin-ctls: 0x24: IN
  Connection: 1
     0x02
Node 0x19 [Pin Complex] wcaps 0x40008b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x02, stepsize=0x4f, mute=0
  Amp-In vals: 
  Pincap 0x083724: IN Detect
  Pin Default 0x99a30940: [Fixed] Mic at Int ATAPI
    Conn = ATAPI, Color = Unknown
  Pin-ctls: 0x24: IN
Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x02, stepsize=0x4f, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x083734: IN OUT Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x20: IN
  Connection: 1
     0x02
Node 0x1b [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x20: IN
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x0820: IN
  Pin Default 0x4015812d: [N/A] Speaker at Ext N/A
    Conn = Optical, Color = Purple
  Pin-ctls: 0x20: IN
Node 0x1e [Pin Complex] wcaps 0x400380: Mono Digital
  Pincap 0x0810: OUT
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x06
Node 0x1f [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x23 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x0b, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x81 0x81]
  Connection: 7
     0x18* 0x19 0x1a 0x1c 0x14 0x15 0x12
Node 0x24 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x0b, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x81 0x81]
  Connection: 7
     0x18* 0x19 0x1a 0x1c 0x14 0x15 0x13
Codec: Generic 11c1 Si3054
Address: 1
Vendor Id: 0x11c11040
Subsystem Id: 0x11790001
Revision Id: 0x100200
Modem Function Group: 0x1

------=_Part_972_182541462.1183423514674
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_972_182541462.1183423514674--
