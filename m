From: VDR User <user.vdr@gmail.com>
Subject: Problems with snd-hda-intel and Asus M2NPV-VM. Please
	help!
Date: Wed, 24 Jun 2009 11:34:49 -0700
Message-ID: <a3ef07920906241134m2f84ac06pef7465ce356f893f@mail.gmail.com>
References: <a3ef07920906241108u786a6c89j80f2ad89eebf7dcd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 15FC524843
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Jun 2009 20:34:49 +0200 (CEST)
Received: by qyk1 with SMTP id 1so1232484qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2009 11:34:49 -0700 (PDT)
In-Reply-To: <a3ef07920906241108u786a6c89j80f2ad89eebf7dcd@mail.gmail.com>
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

I posted this to the alsa-user mailing list but since then I've read
that the problem may actually be a bug in alsa so I've decided to
forward the posting here as well.  Thanks for your consideration.

Best regards,
Derek

---------- Forwarded message ----------
From: VDR User <user.vdr@gmail.com>
Date: Wed, Jun 24, 2009 at 11:08 AM
Subject: Problems with snd-hda-intel and Asus M2NPV-VM. Please help!
To: "mailing list: alsa" <alsa-user@lists.sourceforge.net>


Greetings. =A0I've been trying for several days now to get the internal
spdif working and am posting here as a last resort in hopes someone
will know what's wrong. =A0I'll post system details at the end.

My mainboard has 3 1/8" plugs on the back and an internal spdif_out
connector. =A0If I plug say headphones into the green connector on the
back, I hear sound in them. =A0I don't actually want to use analog sound
at all. =A0Instead I've plugged the internal spdif_out+ground into my
video cards spdif input. =A0Then I have the dvi output from the video
card going to an hdmi input on my tv. =A0Note, I have the same setup
(except for different mainboard) in another box and have used it to
test the video card, which worked fine. =A0The problem is spdif doesn't
seem to be working at all. =A0I've eliminated everything else down to
either a problem in alsa somewhere, or possibly my xine settings
(though I doubt it since I used the same settings from my working
box). =A0For alsa I've tried loading the snd_hda_intel driver with
"model=3D3stack", "model=3D3stack position_fix=3D1", and "model=3D3stack
position_fix=3D1 enable_msi=3D1". =A0None of these worked, I still get
nothing on spdif out. =A0I've also tried (un)muting tons of combinations
in alsamixer.

Could the problem be my kernel version? =A0Alsa version? =A0libasound?
Any ideas at all guys?? =A0Any and all help is GREATLY appreciated!

Best regards,
Derek

System details:
Please note there is no desktop/windows manager. =A0There is also no
keyboard/mouse plugged in. =A0This box is a dedicated htpc running VDR
and connected directly to a tv. =A0I'm using PuTTy SSH from my Windows
desktop for maintenance.

debian testing
kernel 2.6.30
asus m2npv-vm mainboard (tried both firmware 0901 and 1401) - uses mcp51 ch=
ipset
asus EN8400GS Silent 512MB pci-e video card (with spdif input connector)
vdr-1.7.8
xine-0.9.3
xine-vdpau r273

ii =A0alsa-base =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A01.0.20+dfsg-1
=A0 =A0 =A0 =A0 ALSA driver configuration files
ii =A0alsa-utils =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 1.0.20-1
=A0 =A0 =A0 =A0 ALSA utilities
ii =A0libesd-alsa0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
0.2.41-4
=A0 =A0 =A0 =A0 Enlightened Sound Daemon (ALSA) - Shared lib
ii =A0libsdl1.2debian-alsa =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1.2.13-4=
+b1
=A0 =A0 =A0 =A0 Simple DirectMedia Layer (with X11 and ALSA

htpc:~$ sudo alsactl init
Unknown hardware: "HDA-Intel" "Analog Devices AD1986A"
"HDA:11d41986,104381b3,00100500" "0x1043" "0x81cb"
Hardware is initialized using a guess method

htpc:~$ cat /proc/asound/cards
=A00 [NVidia =A0 =A0 =A0 =A0 ]: HDA-Intel - HDA NVidia
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0HDA NVidia at 0xfe024000 irq 22

htpc:~$ cat /proc/asound/devices
=A00: [ 0] =A0 : control
=A016: [ 0- 0]: digital audio playback
=A017: [ 0- 1]: digital audio playback
=A024: [ 0- 0]: digital audio capture
=A033: =A0 =A0 =A0 =A0: timer

alsamixer shows:
Card: HDA NVidia
Chip: Analog Devices AD1986A
Master =A0 =A0Headphon =A0 =A0PCM =A0 =A0 Front =A0 =A0Surround =A0Center =
=A0 =A0LFE
Line =A0 =A0 =A0CD =A0 =A0 =A0 Mic =A0 =A0Mic Boos =A0IEC958 =A0 IEC958 D =
=A0 Aux =A0 =A0 =A0 Mono
=A0 =A0Beep =A0 =A0 Channel Stereo D
(everything is unmuted except stereo downmix)

htpc:~$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: NVidia [HDA NVidia], device 0: AD198x Analog [AD198x Analog]
=A0Subdevices: 0/1
=A0Subdevice #0: subdevice #0
card 0: NVidia [HDA NVidia], device 1: AD198x Digital [AD198x Digital]
=A0Subdevices: 1/1
=A0Subdevice #0: subdevice #0

htpc:~$ aplay -L
default:CARD=3DNVidia
=A0 =A0HDA NVidia, AD198x Analog
=A0 =A0Default Audio Device
front:CARD=3DNVidia,DEV=3D0
=A0 =A0HDA NVidia, AD198x Analog
=A0 =A0Front speakers
surround40:CARD=3DNVidia,DEV=3D0
=A0 =A0HDA NVidia, AD198x Analog
=A0 =A04.0 Surround output to Front and Rear speakers
surround41:CARD=3DNVidia,DEV=3D0
=A0 =A0HDA NVidia, AD198x Analog
=A0 =A04.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=3DNVidia,DEV=3D0
=A0 =A0HDA NVidia, AD198x Analog
=A0 =A05.0 Surround output to Front, Center and Rear speakers
surround51:CARD=3DNVidia,DEV=3D0
=A0 =A0HDA NVidia, AD198x Analog
=A0 =A05.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=3DNVidia,DEV=3D0
=A0 =A0HDA NVidia, AD198x Analog
=A0 =A07.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=3DNVidia,DEV=3D0
=A0 =A0HDA NVidia, AD198x Digital
=A0 =A0IEC958 (S/PDIF) Digital Audio Output
null
=A0 =A0Discard all samples (playback) or generate zero samples (capture)

htpc:~$ cat /proc/asound/card0/codec#0
Codec: Analog Devices AD1986A
Address: 0
Function Id: 0x1
Vendor Id: 0x11d41986
Subsystem Id: 0x104381b3
Revision Id: 0x100500
No Modem Function Group found
Default PCM:
=A0 =A0rates [0x7f]: 8000 11025 16000 22050 32000 44100 48000
=A0 =A0bits [0xe]: 16 20 24
=A0 =A0formats [0x1]: PCM
Default Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
Default Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
GPIO: io=3D0, o=3D1, i=3D0, unsolicited=3D0, wake=3D0
Node 0x02 [Audio Output] wcaps 0x30311: Stereo Digital
=A0Converter: stream=3D5, channel=3D0
=A0Digital: Enabled GenLevel
=A0Digital category: 0x2
=A0PCM:
=A0 =A0rates [0x60]: 44100 48000
=A0 =A0bits [0x2]: 16
=A0 =A0formats [0x5]: PCM AC3
=A0Delay: 3 samples
=A0Connection: 2
=A0 =A0 0x01* 0x06
Node 0x03 [Audio Output] wcaps 0x44d: Stereo Amp-Out
=A0Amp-Out caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
=A0Amp-Out vals: =A0[0x17 0x17]
=A0Converter: stream=3D5, channel=3D0
=A0Power: setting=3DD0, actual=3DD0
=A0Processing caps: benign=3D1, ncoeff=3D70
Node 0x04 [Audio Output] wcaps 0x40d: Stereo Amp-Out
=A0Amp-Out caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
=A0Amp-Out vals: =A0[0x17 0x17]
=A0Converter: stream=3D0, channel=3D0
=A0Power: setting=3DD0, actual=3DD0
Node 0x05 [Audio Output] wcaps 0x40d: Stereo Amp-Out
=A0Amp-Out caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
=A0Amp-Out vals: =A0[0x17 0x17]
=A0Converter: stream=3D12, channel=3D0
=A0Power: setting=3DD0, actual=3DD0
Node 0x06 [Audio Input] wcaps 0x100511: Stereo
=A0Converter: stream=3D0, channel=3D0
=A0SDI-Select: 0
=A0PCM:
=A0 =A0rates [0x7f]: 8000 11025 16000 22050 32000 44100 48000
=A0 =A0bits [0x6]: 16 20
=A0 =A0formats [0x1]: PCM
=A0Power: setting=3DD0, actual=3DD0
=A0Connection: 1
=A0 =A0 0x12
Node 0x07 [Audio Mixer] wcaps 0x200101: Stereo
=A0Connection: 8
=A0 =A0 0x03 0x09 0x13 0x14 0x15 0x16 0x17 0x18
Node 0x08 [Audio Mixer] wcaps 0x200100: Mono
=A0Connection: 1
=A0 =A0 0x07
Node 0x09 [Audio Mixer] wcaps 0x20010e: Mono Amp-In Amp-Out
=A0Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
=A0Amp-In vals: =A0[0x80] [0x80]
=A0Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
=A0Amp-Out vals: =A0[0x80]
=A0Connection: 2
=A0 =A0 0x04 0x05
Node 0x0a [Audio Selector] wcaps 0x300101: Stereo
=A0Connection: 3
=A0 =A0 0x07* 0x04 0x05
Node 0x0b [Audio Selector] wcaps 0x300101: Stereo
=A0Connection: 2
=A0 =A0 0x07* 0x04
Node 0x0c [Audio Selector] wcaps 0x300101: Stereo
=A0Connection: 2
=A0 =A0 0x04* 0x07
Node 0x0d [Audio Selector] wcaps 0x300101: Stereo
=A0Connection: 2
=A0 =A0 0x05* 0x08
Node 0x0e [Audio Selector] wcaps 0x300100: Mono
=A0Connection: 2
=A0 =A0 0x08* 0x11
Node 0x0f [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
=A0Amp-Out caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
=A0Amp-Out vals: =A0[0x00 0x00]
=A0Connection: 8
=A0 =A0 0x1f 0x20 0x1d 0x1d 0x27* 0x28 0x29 0x2a
Node 0x10 [Audio Selector] wcaps 0x300101: Stereo
=A0Connection: 3
=A0 =A0 0x20 0x1c* 0x1f
Node 0x11 [Audio Selector] wcaps 0x300941: Stereo R/L
=A0Connection: 2
=A0 =A0 0x0f* 0x2b
=A0Processing caps: benign=3D1, ncoeff=3D0
Node 0x12 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
=A0Amp-Out caps: ofs=3D0x00, nsteps=3D0x0f, stepsize=3D0x05, mute=3D1
=A0Amp-Out vals: =A0[0x08 0x08]
=A0Connection: 8
=A0 =A0 0x11* 0x22 0x00 0x21 0x10 0x07 0x08 0x23
Node 0x13 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
=A0Amp-Out caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
=A0Amp-Out vals: =A0[0x80 0x80]
=A0Connection: 1
=A0 =A0 0x11
Node 0x14 [Audio Selector] wcaps 0x30010c: Mono Amp-Out
=A0Amp-Out caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
=A0Amp-Out vals: =A0[0x80]
=A0Connection: 1
=A0 =A0 0x23
Node 0x15 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
=A0Amp-Out caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
=A0Amp-Out vals: =A0[0x17 0x17]
=A0Connection: 1
=A0 =A0 0x22
Node 0x16 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
=A0Amp-Out caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
=A0Amp-Out vals: =A0[0x80 0x80]
=A0Connection: 1
=A0 =A0 0x21
Node 0x17 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
=A0Amp-Out caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
=A0Amp-Out vals: =A0[0x80 0x80]
=A0Connection: 1
=A0 =A0 0x10
Node 0x18 [Audio Selector] wcaps 0x30010c: Mono Amp-Out
=A0Amp-Out caps: ofs=3D0x0f, nsteps=3D0x0f, stepsize=3D0x0b, mute=3D1
=A0Amp-Out vals: =A0[0x80]
=A0Connection: 2
=A0 =A0 0x19* 0x24
Node 0x19 [Beep Generator Widget] wcaps 0x700000: Mono
Node 0x1a [Pin Complex] wcaps 0x400185: Stereo Amp-Out
=A0Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
=A0Amp-Out vals: =A0[0x11 0x11]
=A0Pincap 0x0000001f: OUT HP Detect Trigger ImpSense
=A0Pin Default 0x02214021: [Jack] HP Out at Ext Front
=A0 =A0Conn =3D 1/8, Color =3D Green
=A0 =A0DefAssociation =3D 0x2, Sequence =3D 0x1
=A0Pin-ctls: 0xc0: OUT HP
=A0Unsolicited: tag=3D00, enabled=3D0
=A0Connection: 1
=A0 =A0 0x0a
Node 0x1b [Pin Complex] wcaps 0x400185: Stereo Amp-Out
=A0Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
=A0Amp-Out vals: =A0[0x11 0x11]
=A0Pincap 0x0001001f: OUT HP EAPD Detect Trigger ImpSense
=A0EAPD 0x2: EAPD
=A0Pin Default 0x01014011: [Jack] Line Out at Ext Rear
=A0 =A0Conn =3D 1/8, Color =3D Green
=A0 =A0DefAssociation =3D 0x1, Sequence =3D 0x1
=A0Pin-ctls: 0x40: OUT
=A0Unsolicited: tag=3D00, enabled=3D0
=A0Connection: 1
=A0 =A0 0x0b
Node 0x1c [Pin Complex] wcaps 0x400185: Stereo Amp-Out
=A0Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
=A0Amp-Out vals: =A0[0x91 0x91]
=A0Pincap 0x00000037: IN OUT Detect Trigger ImpSense
=A0Pin Default 0x01013012: [Jack] Line Out at Ext Rear
=A0 =A0Conn =3D 1/8, Color =3D Blue
=A0 =A0DefAssociation =3D 0x1, Sequence =3D 0x2
=A0Pin-ctls: 0x20: IN
=A0Unsolicited: tag=3D00, enabled=3D0
=A0Connection: 1
=A0 =A0 0x0c
Node 0x1d [Pin Complex] wcaps 0x400985: Stereo Amp-Out R/L
=A0Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
=A0Amp-Out vals: =A0[0x11 0x11]
=A0Pincap 0x00001737: IN OUT Detect Trigger ImpSense
=A0 =A0Vref caps: HIZ 50 GRD 80
=A0Pin Default 0x01019015: [Jack] Line Out at Ext Rear
=A0 =A0Conn =3D 1/8, Color =3D Pink
=A0 =A0DefAssociation =3D 0x1, Sequence =3D 0x5
=A0Pin-ctls: 0x24: IN VREF_80
=A0Unsolicited: tag=3D00, enabled=3D0
=A0Connection: 1
=A0 =A0 0x0d
Node 0x1e [Pin Complex] wcaps 0x400104: Mono Amp-Out
=A0Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
=A0Amp-Out vals: =A0[0x03]
=A0Pincap 0x00000010: OUT
=A0Pin Default 0x501700f0: [N/A] Speaker at Int N/A
=A0 =A0Conn =3D Analog, Color =3D Unknown
=A0 =A0DefAssociation =3D 0xf, Sequence =3D 0x0
=A0Pin-ctls: 0x40: OUT
=A0Connection: 1
=A0 =A0 0x0e
Node 0x1f [Pin Complex] wcaps 0x400081: Stereo
=A0Pincap 0x00001727: IN Detect Trigger ImpSense
=A0 =A0Vref caps: HIZ 50 GRD 80
=A0Pin Default 0x02a190f0: [Jack] Mic at Ext Front
=A0 =A0Conn =3D 1/8, Color =3D Pink
=A0 =A0DefAssociation =3D 0xf, Sequence =3D 0x0
=A0Pin-ctls: 0x24: IN VREF_80
=A0Unsolicited: tag=3D00, enabled=3D0
Node 0x20 [Pin Complex] wcaps 0x400081: Stereo
=A0Pincap 0x00001727: IN Detect Trigger ImpSense
=A0 =A0Vref caps: HIZ 50 GRD 80
=A0Pin Default 0x018130f0: [Jack] Line In at Ext Rear
=A0 =A0Conn =3D 1/8, Color =3D Blue
=A0 =A0DefAssociation =3D 0xf, Sequence =3D 0x0
=A0Pin-ctls: 0x20: IN VREF_HIZ
=A0Unsolicited: tag=3D00, enabled=3D0
Node 0x21 [Pin Complex] wcaps 0x400081: Stereo
=A0Pincap 0x00000027: IN Detect Trigger ImpSense
=A0Pin Default 0x509700f0: [N/A] Aux at Int N/A
=A0 =A0Conn =3D Analog, Color =3D Unknown
=A0 =A0DefAssociation =3D 0xf, Sequence =3D 0x0
=A0Pin-ctls: 0x20: IN
=A0Unsolicited: tag=3D00, enabled=3D0
Node 0x22 [Pin Complex] wcaps 0x400001: Stereo
=A0Pincap 0x00000020: IN
=A0Pin Default 0x993310f0: [Fixed] CD at Int ATAPI
=A0 =A0Conn =3D ATAPI, Color =3D Black
=A0 =A0DefAssociation =3D 0xf, Sequence =3D 0x0
=A0Pin-ctls: 0x20: IN
Node 0x23 [Pin Complex] wcaps 0x400000: Mono
=A0Pincap 0x00000020: IN
=A0Pin Default 0x50b700f0: [N/A] Telephony at Int N/A
=A0 =A0Conn =3D Analog, Color =3D Unknown
=A0 =A0DefAssociation =3D 0xf, Sequence =3D 0x0
=A0Pin-ctls: 0x20: IN
Node 0x24 [Pin Complex] wcaps 0x400000: Mono
=A0Pincap 0x00000020: IN
=A0Pin Default 0x90f700f0: [Fixed] Other at Int N/A
=A0 =A0Conn =3D Analog, Color =3D Unknown
=A0 =A0DefAssociation =3D 0xf, Sequence =3D 0x0
=A0Pin-ctls: 0x20: IN
Node 0x25 [Pin Complex] wcaps 0x400301: Stereo Digital
=A0Pincap 0x00000010: OUT
=A0Pin Default 0x014510f0: [Jack] SPDIF Out at Ext Rear
=A0 =A0Conn =3D Optical, Color =3D Black
=A0 =A0DefAssociation =3D 0xf, Sequence =3D 0x0
=A0Pin-ctls: 0x40: OUT
=A0Connection: 1
=A0 =A0 0x02
Node 0x26 [Power Widget] wcaps 0x500500: Mono
=A0Power: setting=3DD0, actual=3DD0
=A0Connection: 8
=A0 =A0 0x07 0x08 0x13 0x14 0x15 0x16 0x17 0x18
Node 0x27 [Audio Mixer] wcaps 0x200101: Stereo
=A0Connection: 2
=A0 =A0 0x1f 0x1d
Node 0x28 [Audio Mixer] wcaps 0x200101: Stereo
=A0Connection: 2
=A0 =A0 0x1f 0x20
Node 0x29 [Audio Mixer] wcaps 0x200101: Stereo
=A0Connection: 2
=A0 =A0 0x1d 0x20
Node 0x2a [Audio Mixer] wcaps 0x200101: Stereo
=A0Connection: 3
=A0 =A0 0x1f 0x1d 0x20
Node 0x2b [Audio Mixer] wcaps 0x200100: Mono
=A0Connection: 1
=A0 =A0 0x0f
