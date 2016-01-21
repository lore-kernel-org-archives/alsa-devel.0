From: Sebastian Wagner <sebastian@spawnhost.de>
Subject: Re: Microphone Jack on "Acer Aspire V 15 Nitro"
Date: Thu, 21 Jan 2016 22:45:39 +0100
Message-ID: <56A15183.20606@spawnhost.de>
References: <569FD04E.7020603@spawnhost.de> <s5hlh7jtaty.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060509060905060205010103"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from spawnhost.de (spawnhost.de [46.4.57.208])
 by alsa0.perex.cz (Postfix) with ESMTP id 277012604BE
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2016 22:45:43 +0100 (CET)
Received: from [192.168.0.14] (ip5f5be143.dynamic.kabel-deutschland.de
 [95.91.225.67]) by spawnhost.de (Postfix) with ESMTPSA id 8553F90901
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2016 22:45:41 +0100 (CET)
In-Reply-To: <s5hlh7jtaty.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060509060905060205010103
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Am 21.01.2016 um 12:45 schrieb Takashi Iwai:
> On Wed, 20 Jan 2016 19:22:06 +0100,
> Sebastian Wagner wrote:
>>
>> Hi list,
>>
>> the "Acer Aspire V 15 Nitro" has a combined headphone + microphone jac=
k.
>> The headphone worked out-of-the-box (Ubuntu 15.10), but no microphone
>> was recognized. Also, I couldn't find anything about "Realtek ALC255" =
in
>> my /usr/share/doc/alsa-base/driver/HD-Audio-Models.txt.gz
>>
>> after some googling, I've managed to get my microphone jack working:
>> Adding "options snd-hda-intel model=3Ddell-headset-multi" fixed the is=
sue.
>> See https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1420988
>> for a similar setup. As the bug is still open, I thought this might be
>> of interest.
>>
>> I've attached my alsa-info.txt
>=20
> Does the machine have no built-in mic?  In alsa-info.sh output, there
> are only "Headphone Mic" and "Headset Mic" as inputs.
> Also, does the headphone output still works with this quirk?
>=20
> In anyway, please give alsa-info.sh output without the model option,
> too.

Hi,

It does, but it is not detected:

* internal speakers are working fine with and without quirk
* internal mic doesn't work
* headphone works with and without quirk
* headset mic only works with quirk.
* I didn't tested anything connected via HDMI

I've attached the alsa-info.txt without option. Also, with the quirk,
the alsamixer input throttles are not very intuitive. I have these
throttles:

1. Headphone Mic boost
2. Capture
3. Capture 1
4. Headset Mic boost
5. Input Source
6. Input Source 1

I'm still trying to find the ones that have an effect.

Sebastian

--------------060509060905060205010103
Content-Type: text/plain; charset=UTF-8;
 name="alsa-info-no-input.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="alsa-info-no-input.txt"

upload=3Dtrue&script=3Dtrue&cardinfo=3D
!!################################
!!ALSA Information Script v 0.4.64
!!################################

!!Script ran on: Thu Jan 21 21:17:51 UTC 2016


!!Linux Distribution
!!------------------

Ubuntu 15.10 \n \l DISTRIB_ID=3DUbuntu DISTRIB_DESCRIPTION=3D"Ubuntu 15.1=
0" NAME=3D"Ubuntu" ID=3Dubuntu ID_LIKE=3Ddebian PRETTY_NAME=3D"Ubuntu 15.=
10" HOME_URL=3D"http://www.ubuntu.com/" SUPPORT_URL=3D"http://help.ubuntu=
=2Ecom/" BUG_REPORT_URL=3D"http://bugs.launchpad.net/ubuntu/"


!!DMI Information
!!---------------

Manufacturer:      Acer
Product Name:      Aspire VN7-592G
Product Version:   V1.03
Firmware Version:  V1.03


!!Kernel Information
!!------------------

Kernel release:    4.2.0-25-generic
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         x86_64
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     k4.2.0-25-generic
Library version:    1.0.29
Utilities version:  1.0.29


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Sound Servers on this system
!!----------------------------

Pulseaudio:
      Installed - Yes (/usr/bin/pulseaudio)
      Running - Yes


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [PCH            ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0x84320000 irq 129


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1f.3 Multimedia audio controller: Intel Corporation Sunrise Point-H HD=
 Audio (rev 31)


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!-------------------------------------------------------

00:1f.3 0401: 8086:a170 (rev 31)
	Subsystem: 1025:1039


!!Modprobe options (Sound related)
!!--------------------------------

snd_pcsp: index=3D-2
snd_usb_audio: index=3D-2
snd_atiixp_modem: index=3D-2
snd_intel8x0m: index=3D-2
snd_via82xx_modem: index=3D-2
snd_atiixp_modem: index=3D-2
snd_intel8x0m: index=3D-2
snd_via82xx_modem: index=3D-2
snd_usb_audio: index=3D-2
snd_usb_caiaq: index=3D-2
snd_usb_ua101: index=3D-2
snd_usb_us122l: index=3D-2
snd_usb_usx2y: index=3D-2
snd_cmipci: mpu_port=3D0x330 fm_port=3D0x388
snd_pcsp: index=3D-2
snd_usb_audio: index=3D-2


!!Loaded sound module options
!!---------------------------

!!Module: snd_hda_intel
	align_buffer_size : -1
	bdl_pos_adj : 1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1=
,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	beep_mode : N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,=
N,N
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y=

	enable_msi : -1
	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(nul=
l),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),=
(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(nu=
ll),(null)
	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-=
1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	jackpoll_ms : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,=
0,0,0
	model : (null),(null),(null),(null),(null),(null),(null),(null),(null),(=
null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(nul=
l),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),=
(null),(null)
	patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(=
null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(nul=
l),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),=
(null),(null)
	position_fix : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,=
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	power_save : 0
	power_save_controller : Y
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1=
,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0=
,0,0
	single_cmd : N
	snoop : -1


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Realtek ALC255
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x10ec0255
Subsystem Id: 0x10251039
Revision Id: 0x100002
No Modem Function Group found
Default PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D1 D2 D3 D3cold CLKSTOP EPSS
  Power: setting=3DD0, actual=3DD0
GPIO: io=3D3, o=3D0, i=3D0, unsolicited=3D1, wake=3D0
  IO[0]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
  IO[1]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
  IO[2]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
Node 0x02 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name=3D"Speaker Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Amp-Out caps: ofs=3D0x57, nsteps=3D0x57, stepsize=3D0x02, mute=3D0
  Amp-Out vals:  [0x53 0x53]
  Converter: stream=3D1, channel=3D0
  PCM:
    rates [0x60]: 44100 48000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x03 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name=3D"Headphone Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Device: name=3D"ALC255 Analog", type=3D"Audio", device=3D0
  Amp-Out caps: ofs=3D0x57, nsteps=3D0x57, stepsize=3D0x02, mute=3D0
  Amp-Out vals:  [0x00 0x00]
  Converter: stream=3D1, channel=3D0
  PCM:
    rates [0x60]: 44100 48000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x04 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x05 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x06 [Audio Output] wcaps 0x611: Stereo Digital
  Converter: stream=3D0, channel=3D0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD3, actual=3DD3
Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x08 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Device: name=3D"ALC255 Analog", type=3D"Audio", device=3D0
  Amp-In caps: ofs=3D0x17, nsteps=3D0x3f, stepsize=3D0x02, mute=3D1
  Amp-In vals:  [0x97 0x97]
  Converter: stream=3D1, channel=3D0
  SDI-Select: 0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD3, actual=3DD3
  Connection: 1
     0x23
Node 0x09 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Device: name=3D"ALC255 Alt Analog", type=3D"Audio", device=3D2
  Amp-In caps: ofs=3D0x17, nsteps=3D0x3f, stepsize=3D0x02, mute=3D1
  Amp-In vals:  [0x97 0x97]
  Converter: stream=3D0, channel=3D0
  SDI-Select: 0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD3, actual=3DD3
  Connection: 1
     0x22
Node 0x0a [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name=3D"Beep Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D4, ofs=3D0
  Control: name=3D"Beep Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D4, ofs=3D0
  Amp-In caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x9b 0x9=
b]
  Connection: 5
     0x18 0x19 0x1a 0x1b 0x1d
Node 0x0c [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x03 0x0b
Node 0x0e [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0f [Audio Mixer] wcaps 0x20010a: Mono Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00]
  Connection: 1
     0x0d
Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x12 [Pin Complex] wcaps 0x40040b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000020: IN
  Pin Default 0x411111c0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0xc, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x00:
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD3, actual=3DD3
Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x14 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name=3D"Speaker Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00010014: OUT EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x90172120: [Fixed] Speaker at Int N/A
    Conn =3D Analog, Color =3D Grey
    DefAssociation =3D 0x2, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 1
     0x0c
Node 0x15 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x16 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x17 [Pin Complex] wcaps 0x40050c: Mono Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80]
  Pincap 0x00000010: OUT
  Pin Default 0x40000000: [N/A] Line Out at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
    DefAssociation =3D 0x0, Sequence =3D 0x0
  Pin-ctls: 0x00:
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD3, actual=3DD3
  Connection: 1
     0x0f
Node 0x18 [Pin Complex] wcaps 0x40048b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00003724: IN Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD3, actual=3DD3
Node 0x19 [Pin Complex] wcaps 0x40048b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00003724: IN Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD3, actual=3DD3
Node 0x1a [Pin Complex] wcaps 0x40048b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00003724: IN Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x00: VREF_HIZ
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD3, actual=3DD3
Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0001373c: IN OUT HP EAPD Detect
    Vref caps: HIZ 50 GRD 80 100
  EAPD 0x2: EAPD
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD3, actual=3DD3
  Connection: 2
     0x0c* 0x0d
Node 0x1c [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1d [Pin Complex] wcaps 0x400400: Mono
  Pincap 0x00000020: IN
  Pin Default 0x40700001: [N/A] Modem Hand at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
    DefAssociation =3D 0x0, Sequence =3D 0x1
  Pin-ctls: 0x20: IN
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD3, actual=3DD3
Node 0x1e [Pin Complex] wcaps 0x400781: Stereo Digital
  Pincap 0x00000014: OUT Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD3, actual=3DD3
  Connection: 1
     0x06
Node 0x1f [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
  Processing caps: benign=3D0, ncoeff=3D76
Node 0x21 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name=3D"Headphone Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0001001c: OUT HP EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x02211030: [Jack] HP Out at Ext Front
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0x3, Sequence =3D 0x0
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=3D01, enabled=3D1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD3, actual=3DD3
  Connection: 2
     0x0c 0x0d*
Node 0x22 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x8=
0] [0x80 0x80]
  Connection: 6
     0x18 0x19 0x1a 0x1b 0x1d 0x0b
Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x8=
0] [0x80 0x80] [0x80 0x80]
  Connection: 7
     0x18 0x19 0x1a 0x1b 0x1d 0x0b 0x12
Codec: Intel Skylake HDMI
Address: 2
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x80862809
Subsystem Id: 0x80860101
Revision Id: 0x100000
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D3 CLKSTOP EPSS
  Power: setting=3DD0, actual=3DD0, Clock-stop-OK
GPIO: io=3D0, o=3D0, i=3D0, unsolicited=3D0, wake=3D0
Node 0x02 [Audio Output] wcaps 0x6611: 8-Channels Digital
  Converter: stream=3D0, channel=3D0
  Digital: Enabled KAE
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1a]: 16 24 32
    formats [0x5]: PCM AC3
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x03 [Audio Output] wcaps 0x6611: 8-Channels Digital
  Converter: stream=3D0, channel=3D0
  Digital: Enabled KAE
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1a]: 16 24 32
    formats [0x5]: PCM AC3
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x04 [Audio Output] wcaps 0x6611: 8-Channels Digital
  Converter: stream=3D0, channel=3D0
  Digital: Enabled KAE
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1a]: 16 24 32
    formats [0x5]: PCM AC3
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x05 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Control: name=3D"IEC958 Playback Con Mask", index=3D0, device=3D0
  Control: name=3D"IEC958 Playback Pro Mask", index=3D0, device=3D0
  Control: name=3D"IEC958 Playback Default", index=3D0, device=3D0
  Control: name=3D"IEC958 Playback Switch", index=3D0, device=3D0
  Control: name=3D"ELD", index=3D0, device=3D3
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0b000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn =3D Digital, Color =3D Unknown
    DefAssociation =3D 0x1, Sequence =3D 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=3D01, enabled=3D1
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
  Devices: 0
  Connection: 0
  In-driver Connection: 3
     0x02 0x03 0x04
Node 0x06 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Control: name=3D"IEC958 Playback Con Mask", index=3D1, device=3D0
  Control: name=3D"IEC958 Playback Pro Mask", index=3D1, device=3D0
  Control: name=3D"IEC958 Playback Default", index=3D1, device=3D0
  Control: name=3D"IEC958 Playback Switch", index=3D1, device=3D0
  Control: name=3D"ELD", index=3D0, device=3D7
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0b000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn =3D Digital, Color =3D Unknown
    DefAssociation =3D 0x1, Sequence =3D 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=3D02, enabled=3D1
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
  Devices: 0
  Connection: 0
  In-driver Connection: 3
     0x02 0x03 0x04
Node 0x07 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Control: name=3D"IEC958 Playback Con Mask", index=3D2, device=3D0
  Control: name=3D"IEC958 Playback Pro Mask", index=3D2, device=3D0
  Control: name=3D"IEC958 Playback Default", index=3D2, device=3D0
  Control: name=3D"IEC958 Playback Switch", index=3D2, device=3D0
  Control: name=3D"ELD", index=3D0, device=3D8
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0b000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn =3D Digital, Color =3D Unknown
    DefAssociation =3D 0x1, Sequence =3D 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=3D03, enabled=3D1
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
  Devices: 0
  Connection: 0
  In-driver Connection: 3
     0x02 0x03 0x04
Node 0x08 [Vendor Defined Widget] wcaps 0xf00000: Mono
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116,  2 Jan 21 21:13 /dev/snd/controlC0
crw-rw----+ 1 root audio 116,  9 Jan 21 21:13 /dev/snd/hwC0D0
crw-rw----+ 1 root audio 116, 10 Jan 21 21:13 /dev/snd/hwC0D2
crw-rw----+ 1 root audio 116,  4 Jan 21 22:14 /dev/snd/pcmC0D0c
crw-rw----+ 1 root audio 116,  3 Jan 21 22:14 /dev/snd/pcmC0D0p
crw-rw----+ 1 root audio 116,  5 Jan 21 21:13 /dev/snd/pcmC0D2c
crw-rw----+ 1 root audio 116,  6 Jan 21 22:13 /dev/snd/pcmC0D3p
crw-rw----+ 1 root audio 116,  7 Jan 21 22:13 /dev/snd/pcmC0D7p
crw-rw----+ 1 root audio 116,  8 Jan 21 22:13 /dev/snd/pcmC0D8p
crw-rw----+ 1 root audio 116,  1 Jan 21 21:13 /dev/snd/seq
crw-rw----+ 1 root audio 116, 33 Jan 21 21:13 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  60 Jan 21 21:13 .
drwxr-xr-x 3 root root 280 Jan 21 21:13 ..
lrwxrwxrwx 1 root root  12 Jan 21 21:13 pci-0000:00:1f.3 -> ../controlC0


!!Aplay/Arecord output
!!--------------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: ALC255 Analog [ALC255 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 7: HDMI 1 [HDMI 1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 8: HDMI 2 [HDMI 2]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: ALC255 Analog [ALC255 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 2: ALC255 Alt Analog [ALC255 Alt Anal=
og]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [PCH]

Card hw:0 'PCH'/'HDA Intel PCH at 0x84320000 irq 129'
  Mixer name	: 'Intel Skylake HDMI'
  Components	: 'HDA:10ec0255,10251039,00100002 HDA:80862809,80860101,0010=
0000'
  Controls      : 36
  Simple ctrls  : 9
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 87
  Mono: Playback 83 [95%] [-3.00dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 87
  Mono:
  Front Left: Playback 0 [0%] [-65.25dB] [off]
  Front Right: Playback 0 [0%] [-65.25dB] [off]
Simple mixer control 'Speaker',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 87
  Mono:
  Front Left: Playback 87 [100%] [0.00dB] [on]
  Front Right: Playback 87 [100%] [0.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 255 [100%] [0.00dB]
  Front Right: Playback 255 [100%] [0.00dB]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958',1
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',2
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Beep',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 27 [87%] [6.00dB] [off]
  Front Right: Playback 27 [87%] [6.00dB] [off]
Simple mixer control 'Auto-Mute Mode',0
  Capabilities: enum
  Items: 'Disabled' 'Enabled'
  Item0: 'Disabled'


!!Alsactl output
!!--------------

--startcollapse--
state.PCH {
	control.1 {
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 87'
			dbmin -6525
			dbmax 0
			dbvalue.0 -6525
			dbvalue.1 -6525
		}
	}
	control.2 {
		iface MIXER
		name 'Headphone Playback Switch'
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.3 {
		iface MIXER
		name 'Speaker Playback Volume'
		value.0 87
		value.1 87
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 87'
			dbmin -6525
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.4 {
		iface MIXER
		name 'Speaker Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.5 {
		iface MIXER
		name 'Auto-Mute Mode'
		value Disabled
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Disabled
			item.1 Enabled
		}
	}
	control.6 {
		iface MIXER
		name 'Master Playback Volume'
		value 83
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 87'
			dbmin -6525
			dbmax 0
			dbvalue.0 -300
		}
	}
	control.7 {
		iface MIXER
		name 'Master Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.8 {
		iface CARD
		name 'Front Headphone Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.9 {
		iface CARD
		name 'Speaker Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.10 {
		iface MIXER
		name 'Beep Playback Volume'
		value.0 27
		value.1 27
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -3450
			dbmax 1200
			dbvalue.0 600
			dbvalue.1 600
		}
	}
	control.11 {
		iface MIXER
		name 'Beep Playback Switch'
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.12 {
		iface PCM
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.13 {
		iface PCM
		name 'Capture Channel Map'
		value.0 0
		value.1 0
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.14 {
		iface PCM
		device 2
		name 'Capture Channel Map'
		value.0 0
		value.1 0
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.15 {
		iface CARD
		name 'HDMI/DP,pcm=3D3 Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.16 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.17 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.18 {
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.19 {
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.20 {
		iface PCM
		device 3
		name ELD
		value ''
		comment {
			access 'read volatile'
			type BYTES
			count 0
		}
	}
	control.21 {
		iface CARD
		name 'HDMI/DP,pcm=3D7 Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.22 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		index 1
		value '0fff000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.23 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		index 1
		value '0f00000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.24 {
		iface MIXER
		name 'IEC958 Playback Default'
		index 1
		value '0400000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.25 {
		iface MIXER
		name 'IEC958 Playback Switch'
		index 1
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.26 {
		iface PCM
		device 7
		name ELD
		value ''
		comment {
			access 'read volatile'
			type BYTES
			count 0
		}
	}
	control.27 {
		iface CARD
		name 'HDMI/DP,pcm=3D8 Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.28 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		index 2
		value '0fff000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.29 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		index 2
		value '0f00000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.30 {
		iface MIXER
		name 'IEC958 Playback Default'
		index 2
		value '0400000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.31 {
		iface MIXER
		name 'IEC958 Playback Switch'
		index 2
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.32 {
		iface PCM
		device 8
		name ELD
		value ''
		comment {
			access 'read volatile'
			type BYTES
			count 0
		}
	}
	control.33 {
		iface PCM
		device 3
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		comment {
			access 'read write'
			type INTEGER
			count 8
			range '0 - 36'
		}
	}
	control.34 {
		iface PCM
		device 7
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		comment {
			access 'read write'
			type INTEGER
			count 8
			range '0 - 36'
		}
	}
	control.35 {
		iface PCM
		device 8
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		comment {
			access 'read write'
			type INTEGER
			count 8
			range '0 - 36'
		}
	}
	control.36 {
		iface MIXER
		name 'PCM Playback Volume'
		value.0 255
		value.1 255
		comment {
			access 'read write user'
			type INTEGER
			count 2
			range '0 - 255'
			tlv '0000000100000008ffffec1400000014'
			dbmin -5100
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
rfcomm
nls_utf8
cifs
fscache
binfmt_misc
rtsx_usb_ms
bnep
memstick
hid_multitouch
snd_hda_codec_hdmi
snd_hda_codec_realtek
snd_hda_codec_generic
joydev
intel_rapl
nls_iso8859_1
acer_wmi
i2c_designware_platform
snd_hda_intel
i2c_designware_core
sparse_keymap
iosf_mbi
snd_hda_codec
x86_pkg_temp_thermal
intel_powerclamp
snd_hda_core
coretemp
snd_hwdep
kvm_intel
snd_pcm
kvm
snd_seq_midi
snd_seq_midi_event
crct10dif_pclmul
crc32_pclmul
aesni_intel
snd_rawmidi
aes_x86_64
lrw
snd_seq
gf128mul
glue_helper
ablk_helper
snd_seq_device
cryptd
uvcvideo
snd_timer
videobuf2_vmalloc
input_leds
videobuf2_memops
serio_raw
videobuf2_core
snd
v4l2_common
btusb
videodev
soundcore
btrtl
idma64
btbcm
virt_dma
media
btintel
bluetooth
mei_me
mei
intel_lpss_pci
shpchp
acpi_als
kfifo_buf
industrialio
intel_lpss_acpi
intel_lpss
tpm_crb
mac_hid
acpi_pad
parport_pc
ppdev
lp
parport
autofs4
btrfs
xor
raid6_pq
rtsx_usb_sdmmc
rtsx_usb
nouveau
i915
mxm_wmi
ttm
i2c_algo_bit
drm_kms_helper
r8169
ahci
drm
mii
libahci
i2c_hid
hid
wmi
pinctrl_sunrisepoint
video
pinctrl_intel


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x12 0x411111c0
0x14 0x90172120
0x17 0x40000000
0x18 0x411111f0
0x19 0x411111f0
0x1a 0x411111f0
0x1b 0x411111f0
0x1d 0x40700001
0x1e 0x411111f0
0x21 0x02211030

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:

/sys/class/sound/hwC0D0/hints:

/sys/class/sound/hwC0D2/init_pin_configs:
0x05 0x18560010
0x06 0x18560010
0x07 0x18560010

/sys/class/sound/hwC0D2/driver_pin_configs:

/sys/class/sound/hwC0D2/user_pin_configs:

/sys/class/sound/hwC0D2/init_verbs:

/sys/class/sound/hwC0D2/hints:


!!ALSA/HDA dmesg
!!--------------

[    4.752912] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    4.809900] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_a=
udio_component_bind_ops [i915])
[    4.810464] acer_wmi: Acer Laptop ACPI-WMI Extras
--
[    4.825014] input: Acer BMA150 accelerometer as /devices/virtual/input=
/input8
[    4.848052] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC255: =
line_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[    4.848055] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=3D0 (0x=
0/0x0/0x0/0x0/0x0)
[    4.848056] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=3D1 (0x21/0x=
0/0x0/0x0/0x0)
[    4.848057] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=3D0x0=

[    4.848058] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    4.859621] input: HDA Intel PCH Front Headphone as /devices/pci0000:0=
0/0000:00:1f.3/sound/card0/input9
[    4.859668] input: HDA Intel PCH HDMI/DP,pcm=3D3 as /devices/pci0000:0=
0/0000:00:1f.3/sound/card0/input10
[    4.859719] input: HDA Intel PCH HDMI/DP,pcm=3D7 as /devices/pci0000:0=
0/0000:00:1f.3/sound/card0/input11
[    4.859769] input: HDA Intel PCH HDMI/DP,pcm=3D8 as /devices/pci0000:0=
0/0000:00:1f.3/sound/card0/input12
[    4.868520] i2c_hid i2c-SYN1B7F:00: failed to retrieve report from dev=
ice.



--------------060509060905060205010103
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------060509060905060205010103--
