From: Joschi Brauchle <joschi.brauchle@tum.de>
Subject: No sound on Thinkpad T440s in Docking Station
Date: Tue, 29 Apr 2014 17:22:26 +0200
Message-ID: <535FC3B2.2020506@tum.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6642654720015492557=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from postout1.mail.lrz.de (postout1.mail.lrz.de [129.187.255.137])
 by alsa0.perex.cz (Postfix) with ESMTP id CB948265112
 for <alsa-devel@alsa-project.org>; Tue, 29 Apr 2014 17:22:28 +0200 (CEST)
Received: from lxmhs51.srv.lrz.de (localhost [127.0.0.1])
 by postout1.mail.lrz.de (Postfix) with ESMTP id 3gJ66X2lfjzyS7
 for <alsa-devel@alsa-project.org>; Tue, 29 Apr 2014 17:22:28 +0200 (CEST)
Received: from postout1.mail.lrz.de ([127.0.0.1])
 by lxmhs51.srv.lrz.de (lxmhs51.srv.lrz.de [127.0.0.1]) (amavisd-new,
 port 20024)
 with LMTP id TvHE0msevMyh for <alsa-devel@alsa-project.org>;
 Tue, 29 Apr 2014 17:22:26 +0200 (CEST)
Received: from [192.168.109.246] (zzz-dyn-pat-199.lnt.ei.tum.de
 [129.187.109.199])
 (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by postout1.mail.lrz.de (Postfix) with ESMTPSA id 3gJ66V1F0szyS5
 for <alsa-devel@alsa-project.org>; Tue, 29 Apr 2014 17:22:26 +0200 (CEST)
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

This is a cryptographically signed message in MIME format.

--===============6642654720015492557==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms050502080701080402090502"

This is a cryptographically signed message in MIME format.

--------------ms050502080701080402090502
Content-Type: multipart/mixed;
 boundary="------------040105010603070502000305"

This is a multi-part message in MIME format.
--------------040105010603070502000305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Dear all,

using openSUSE 13.1 on an Thinkpad T440s, I am not getting sound once=20
the laptop is docked to its docking station.

I suspect an additional SND_PCI_QUIRK is needed for this model.
"pactl list" returns
----------------
alsa.mixer_name =3D "Realtek ALC292"
alsa.components =3D "HDA:10ec0292,17aa220c,00100001"
----------------
for the analog audio output sink in docked state.

Hence I assume a new line similar to this
----------------
SND_PCI_QUIRK(0x17aa, 0x220c, "Thinkpad T440s", ALC269_FIXUP_LENOVO_DOCK)=
,
----------------
is needed?

What about the ALC292 instead of 269 Realtek chip...?

Please find alsa-info.sh output attached.
--=20
Dipl.-Ing. Joschi Brauchle, M.S.

Institute for Communications Engineering (LNT)
Technische Universitaet Muenchen (TUM)
80290 Munich, Germany

Tel (work): +49 89 289-23474
Fax (work): +49 89 289-23490
E-mail: joschi.brauchle@tum.de
Web: http://www.lnt.ei.tum.de/

--------------040105010603070502000305
Content-Type: text/plain; charset=UTF-8;
 name="alsa-info.txt.8EAih5QE1T"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="alsa-info.txt.8EAih5QE1T"

upload=3Dtrue&script=3Dtrue&cardinfo=3D
!!################################
!!ALSA Information Script v 0.4.61
!!################################

!!Script ran on: Tue Apr 29 15:21:16 UTC 2014


!!Linux Distribution
!!------------------

Welcome to openSUSE 13.1 "Bottle" - Kernel \r (\l). openSUSE 13.1 (x86_64=
) # /etc/SuSE-release is deprecated and will be removed in the future, us=
e /etc/os-release instead LSB_VERSION=3D"core-2.0-noarch:core-3.2-noarch:=
core-4.0-noarch:core-2.0-x86_64:core-3.2-x86_64:core-4.0-x86_64" NAME=3Do=
penSUSE PRETTY_NAME=3D"openSUSE 13.1 (Bottle) (x86_64)" ID=3Dopensuse CPE=
_NAME=3D"cpe:/o:opensuse:opensuse:13.1" BUG_REPORT_URL=3D"https://bugs.op=
ensuse.org" HOME_URL=3D"https://opensuse.org/" ID_LIKE=3D"suse"


!!DMI Information
!!---------------

Manufacturer:      LENOVO
Product Name:      20ARS0BH00
Product Version:   ThinkPad T440s
Firmware Version:  GJET67WW (2.17 )


!!Kernel Information
!!------------------

Kernel release:    3.11.10-7-desktop
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         x86_64
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     k3.11.10-7-desktop
Library version:   =20
Utilities version:  1.0.27.2


!!Loaded ALSA modules
!!-------------------

snd_hda_intel
snd_hda_intel
thinkpad_acpi


!!Sound Servers on this system
!!----------------------------

Pulseaudio:
      Installed - Yes (/usr/bin/pulseaudio)
      Running - Yes

ESound Daemon:
      Installed - Yes (/usr/bin/esd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [MID            ]: HDA-Intel - HDA Intel MID
                      HDA Intel MID at 0xf0630000 irq 66
 1 [PCH            ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0xf0634000 irq 65
 4 [ThinkPadEC     ]: ThinkPad EC - ThinkPad Console Audio Control
                      ThinkPad Console Audio Control at EC reg 0x30, fw u=
nknown


!!PCI Soundcards installed in the system
!!--------------------------------------

00:03.0 Audio device: Intel Corporation Device 0a0c (rev 0b)
00:1b.0 Audio device: Intel Corporation Lynx Point-LP HD Audio Controller=
 (rev 04)


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!-------------------------------------------------------

00:03.0 0403: 8086:0a0c (rev 0b)
	Subsystem: 17aa:220c
--
00:1b.0 0403: 8086:9c20 (rev 04)
	Subsystem: 17aa:220c


!!Loaded sound module options
!!---------------------------

!!Module: snd_hda_intel
	align_buffer_size : -1
	bdl_pos_adj : 32,1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1=
,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	beep_mode : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,=
Y,Y
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
	power_save : 1
	power_save_controller : Y
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1=
,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0=
,0,0
	single_cmd : N
	snoop : Y

!!Module: snd_hda_intel
	align_buffer_size : -1
	bdl_pos_adj : 32,1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1=
,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	beep_mode : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,=
Y,Y
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
	power_save : 1
	power_save_controller : Y
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1=
,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0=
,0,0
	single_cmd : N
	snoop : Y

!!Module: thinkpad_acpi
	brightness_enable : 2
	brightness_mode : 4
	enable : Y
	experimental : 0
	fan_control : N
	force_load : N
	hotkey_report_mode : 0
	id : ThinkPadEC
	index : -536870912
	volume_capabilities : 0
	volume_control : N
	volume_mode : 3


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Intel Haswell HDMI
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x80862807
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
    bits [0x1e]: 16 20 24 32
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
    bits [0x1e]: 16 20 24 32
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
    bits [0x1e]: 16 20 24 32
    formats [0x5]: PCM AC3
  Power states:  D0 D3 EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x05 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Control: name=3D"HDMI/DP,pcm=3D3 Jack", index=3D0, device=3D0
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
  Connection: 0
  In-driver Connection: 3
     0x02 0x03 0x04
Node 0x06 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Control: name=3D"HDMI/DP,pcm=3D7 Jack", index=3D0, device=3D0
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
  Connection: 0
  In-driver Connection: 3
     0x02 0x03 0x04
Node 0x07 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Control: name=3D"HDMI/DP,pcm=3D8 Jack", index=3D0, device=3D0
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
  Connection: 0
  In-driver Connection: 3
     0x02 0x03 0x04
Node 0x08 [Vendor Defined Widget] wcaps 0xf00000: Mono
Codec: Realtek ALC292
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x10ec0292
Subsystem Id: 0x17aa220c
Revision Id: 0x100001
No Modem Function Group found
Default PCM:
    rates [0x5f0]: 32000 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D1 D2 D3 CLKSTOP EPSS
  Power: setting=3DD0, actual=3DD0
GPIO: io=3D5, o=3D0, i=3D0, unsolicited=3D1, wake=3D0
  IO[0]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
  IO[1]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
  IO[2]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
  IO[3]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
  IO[4]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
Node 0x02 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name=3D"Headphone Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Device: name=3D"ALC292 Analog", type=3D"Audio", device=3D0
  Amp-Out caps: ofs=3D0x57, nsteps=3D0x57, stepsize=3D0x02, mute=3D0
  Amp-Out vals:  [0x00 0x00]
  Converter: stream=3D0, channel=3D0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x03 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name=3D"Speaker Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Amp-Out caps: ofs=3D0x57, nsteps=3D0x57, stepsize=3D0x02, mute=3D0
  Amp-Out vals:  [0x00 0x00]
  Converter: stream=3D0, channel=3D0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
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
    rates [0x5f0]: 32000 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x08 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=3D0x17, nsteps=3D0x3f, stepsize=3D0x02, mute=3D1
  Amp-In vals:  [0x97 0x97]
  Converter: stream=3D0, channel=3D0
  SDI-Select: 0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 1
     0x23
Node 0x09 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Control: name=3D"Capture Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Control: name=3D"Capture Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Device: name=3D"ALC292 Analog", type=3D"Audio", device=3D0
  Amp-In caps: ofs=3D0x17, nsteps=3D0x3f, stepsize=3D0x02, mute=3D1
  Amp-In vals:  [0x80 0x80]
  Converter: stream=3D0, channel=3D0
  SDI-Select: 0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 1
     0x22
Node 0x0a [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name=3D"Mic Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D2, ofs=3D0
  Control: name=3D"Mic Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D2, ofs=3D0
  Control: name=3D"Beep Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D4, ofs=3D0
  Control: name=3D"Beep Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D4, ofs=3D0
  Amp-In caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x89 0x8=
9]
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
  Amp-In vals:  [0x80] [0x00]
  Connection: 2
     0x02 0x03
Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x12 [Pin Complex] wcaps 0x40040b: Stereo Amp-In
  Control: name=3D"Internal Mic Boost Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Control: name=3D"Internal Mic Phantom Jack", index=3D0, device=3D0
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x2f, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000020: IN
  Pin Default 0x90a60130: [Fixed] Mic at Int N/A
    Conn =3D Digital, Color =3D Unknown
    DefAssociation =3D 0x3, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x20: IN
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x13 [Pin Complex] wcaps 0x40040b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x2f, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000020: IN
  Pin Default 0x40000000: [N/A] Line Out at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
    DefAssociation =3D 0x0, Sequence =3D 0x0
  Pin-ctls: 0x00:
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x14 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name=3D"Speaker Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Control: name=3D"Speaker Phantom Jack", index=3D0, device=3D0
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00010010: OUT EAPD
  EAPD 0x2: EAPD
  Pin Default 0x90170110: [Fixed] Speaker at Int N/A
    Conn =3D Analog, Color =3D Unknown
    DefAssociation =3D 0x1, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 2
     0x0c 0x0d*
Node 0x15 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name=3D"Headphone Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Control: name=3D"Headphone Jack", index=3D0, device=3D0
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0001001c: OUT HP EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x0321101f: [Jack] HP Out at Ext Left
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0x1, Sequence =3D 0xf
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=3D01, enabled=3D1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 2
     0x0c* 0x0d
Node 0x16 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0001001c: OUT HP EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x00:
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 2
     0x0c* 0x0d
Node 0x17 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x18 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00003734: IN OUT Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 2
     0x0c* 0x0d
Node 0x19 [Pin Complex] wcaps 0x40048b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x2f, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000024: IN Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x00:
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x1a [Pin Complex] wcaps 0x40048b: Stereo Amp-In
  Control: name=3D"Mic Boost Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Control: name=3D"Mic Jack", index=3D0, device=3D0
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00003724: IN Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x03a11020: [Jack] Mic at Ext Left
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0x2, Sequence =3D 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=3D02, enabled=3D1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00003734: IN OUT Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 2
     0x0c* 0x0d
Node 0x1c [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1d [Pin Complex] wcaps 0x400400: Mono
  Pincap 0x00000020: IN
  Pin Default 0x40738105: [N/A] Modem Hand at Ext N/A
    Conn =3D ATAPI, Color =3D Purple
    DefAssociation =3D 0x0, Sequence =3D 0x5
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x20: IN
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x1e [Pin Complex] wcaps 0x400781: Stereo Digital
  Pincap 0x00000014: OUT Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 1
     0x06
Node 0x1f [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
  Processing caps: benign=3D0, ncoeff=3D124
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 8
     0x18 0x19 0x1a 0x1b 0x1d 0x0b 0x12* 0x13
Node 0x23 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 6
     0x18* 0x19 0x1a 0x1b 0x1d 0x0b
Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116,  7 Apr 27 16:43 /dev/snd/controlC0
crw-rw----+ 1 root audio 116, 11 Apr 27 16:43 /dev/snd/controlC1
crw-rw----+ 1 root audio 116,  2 Apr 27 16:43 /dev/snd/controlC4
crw-rw----+ 1 root audio 116,  6 Apr 27 16:43 /dev/snd/hwC0D0
crw-rw----+ 1 root audio 116, 10 Apr 27 16:43 /dev/snd/hwC1D0
crw-rw----+ 1 root audio 116,  5 Apr 27 16:43 /dev/snd/pcmC0D3p
crw-rw----+ 1 root audio 116,  4 Apr 27 16:43 /dev/snd/pcmC0D7p
crw-rw----+ 1 root audio 116,  3 Apr 27 16:43 /dev/snd/pcmC0D8p
crw-rw----+ 1 root audio 116,  9 Apr 27 16:43 /dev/snd/pcmC1D0c
crw-rw----+ 1 root audio 116,  8 Apr 29 17:18 /dev/snd/pcmC1D0p
crw-rw----+ 1 root audio 116,  1 Apr 27 16:43 /dev/snd/seq
crw-rw----+ 1 root audio 116, 33 Apr 27 16:43 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root 100 Apr 27 16:43 .
drwxr-xr-x 3 root root 300 Apr 27 16:43 ..
lrwxrwxrwx 1 root root  12 Apr 27 16:43 pci-0000:00:03.0 -> ../controlC0
lrwxrwxrwx 1 root root  12 Apr 27 16:43 pci-0000:00:1b.0 -> ../controlC1
lrwxrwxrwx 1 root root  12 Apr 27 16:43 platform-thinkpad_acpi -> ../cont=
rolC4


!!Aplay/Arecord output
!!--------------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: MID [HDA Intel MID], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: MID [HDA Intel MID], device 7: HDMI 1 [HDMI 1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: MID [HDA Intel MID], device 8: HDMI 2 [HDMI 2]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: PCH [HDA Intel PCH], device 0: ALC292 Analog [ALC292 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 1: PCH [HDA Intel PCH], device 0: ALC292 Analog [ALC292 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [MID]

Card hw:0 'MID'/'HDA Intel MID at 0xf0630000 irq 66'
  Mixer name	: 'Intel Haswell HDMI'
  Components	: 'HDA:80862807,80860101,00100000'
  Controls      : 21
  Simple ctrls  : 3
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',1
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',2
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]

!!-------Mixer controls for card 1 [PCH]

Card hw:1 'PCH'/'HDA Intel PCH at 0xf0634000 irq 65'
  Mixer name	: 'Realtek ALC292'
  Components	: 'HDA:10ec0292,17aa220c,00100001'
  Controls      : 22
  Simple ctrls  : 10
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 87
  Mono: Playback 0 [0%] [-65.25dB] [on]
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
  Front Left: Playback 0 [0%] [-65.25dB] [on]
  Front Right: Playback 0 [0%] [-65.25dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 0 [0%] [-51.00dB]
  Front Right: Playback 0 [0%] [-51.00dB]
Simple mixer control 'Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%] [0.00dB]
  Front Right: 0 [0%] [0.00dB]
Simple mixer control 'Beep',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 9 [29%] [-21.00dB] [off]
  Front Right: Playback 9 [29%] [-21.00dB] [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 63
  Front Left: Capture 0 [0%] [-17.25dB] [off]
  Front Right: Capture 0 [0%] [-17.25dB] [off]
Simple mixer control 'Auto-Mute Mode',0
  Capabilities: enum
  Items: 'Disabled' 'Enabled'
  Item0: 'Enabled'
Simple mixer control 'Internal Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%] [0.00dB]
  Front Right: 0 [0%] [0.00dB]

!!-------Mixer controls for card 4 [ThinkPadEC]

Card hw:4 'ThinkPadEC'/'ThinkPad Console Audio Control at EC reg 0x30, fw=
 unknown'
  Mixer name	: 'ThinkPad EC (unknown)'
  Components	: ''
  Controls      : 1
  Simple ctrls  : 1
Simple mixer control 'Console',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]


!!Alsactl output
!!--------------

--startcollapse--
state.MID {
	control.1 {
		iface CARD
		name 'HDMI/DP,pcm=3D3 Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.2 {
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
	control.3 {
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
	control.4 {
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
	control.5 {
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.6 {
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
	control.7 {
		iface CARD
		name 'HDMI/DP,pcm=3D7 Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.8 {
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
	control.9 {
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
	control.10 {
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
	control.11 {
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
	control.12 {
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
	control.13 {
		iface CARD
		name 'HDMI/DP,pcm=3D8 Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.14 {
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
	control.15 {
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
	control.16 {
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
	control.17 {
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
	control.18 {
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
	control.19 {
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
	control.20 {
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
	control.21 {
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
}
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
		name 'Mic Playback Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -3450
			dbmax 1200
			dbvalue.0 -3450
			dbvalue.1 -3450
		}
	}
	control.6 {
		iface MIXER
		name 'Mic Playback Switch'
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.7 {
		iface MIXER
		name 'Auto-Mute Mode'
		value Enabled
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Disabled
			item.1 Enabled
		}
	}
	control.8 {
		iface MIXER
		name 'Capture Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 63'
			dbmin -1725
			dbmax 3000
			dbvalue.0 -1725
			dbvalue.1 -1725
		}
	}
	control.9 {
		iface MIXER
		name 'Capture Switch'
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.10 {
		iface MIXER
		name 'Mic Boost Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 3'
			dbmin 0
			dbmax 3000
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.11 {
		iface MIXER
		name 'Internal Mic Boost Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 3'
			dbmin 0
			dbmax 3600
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.12 {
		iface MIXER
		name 'Master Playback Volume'
		value 0
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 87'
			dbmin -6525
			dbmax 0
			dbvalue.0 -6525
		}
	}
	control.13 {
		iface MIXER
		name 'Master Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.14 {
		iface CARD
		name 'Mic Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.15 {
		iface CARD
		name 'Internal Mic Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.16 {
		iface CARD
		name 'Headphone Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.17 {
		iface CARD
		name 'Speaker Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.18 {
		iface MIXER
		name 'Beep Playback Volume'
		value.0 9
		value.1 9
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -3450
			dbmax 1200
			dbvalue.0 -2100
			dbvalue.1 -2100
		}
	}
	control.19 {
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
	control.20 {
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
	control.21 {
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
	control.22 {
		iface MIXER
		name 'PCM Playback Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write user'
			type INTEGER
			count 2
			range '0 - 255'
			tlv '0000000100000008ffffec1400000014'
			dbmin -5100
			dbmax 0
			dbvalue.0 -5100
			dbvalue.1 -5100
		}
	}
}
state.ThinkPadEC {
	control.1 {
		iface MIXER
		name 'Console Playback Switch'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
ipheth
nls_iso8859_1
nls_cp437
vfat
fat
usb_storage
tun
fuse
rfcomm
vboxpci
vboxnetadp
vboxnetflt
bnep
af_packet
uvcvideo
videobuf2_core
videodev
videobuf2_vmalloc
videobuf2_memops
btusb
bluetooth
xt_tcpudp
xt_pkttype
xt_LOG
xt_limit
vboxdrv
rpcsec_gss_krb5
auth_rpcgss
oid_registry
nfs
fscache
lockd
sunrpc
ip6t_REJECT
nf_conntrack_ipv6
nf_defrag_ipv6
ip6table_raw
ipt_REJECT
iptable_raw
xt_CT
iptable_filter
ip6table_mangle
nf_conntrack_netbios_ns
nf_conntrack_broadcast
nf_conntrack_ipv4
nf_defrag_ipv4
ip_tables
xt_conntrack
nf_conntrack
ip6table_filter
ip6_tables
x_tables
snd_hda_codec_realtek
snd_hda_codec_hdmi
arc4
rtsx_pci_sdmmc
rtsx_pci_ms
memstick
mmc_core
iTCO_wdt
iTCO_vendor_support
x86_pkg_temp_thermal
coretemp
kvm_intel
kvm
crc32_pclmul
crc32c_intel
ghash_clmulni_intel
aesni_intel
ablk_helper
cryptd
lrw
gf128mul
glue_helper
aes_x86_64
iwlmvm
snd_hda_intel
thinkpad_acpi
mac80211
snd_seq
snd_hda_codec
snd_hwdep
joydev
pcspkr
serio_raw
snd_pcm
iwlwifi
cfg80211
rfkill
rtsx_pci
i2c_i801
lpc_ich
mfd_core
e1000e
shpchp
ptp
pps_core
mei_me
mei
snd_seq_device
snd_timer
snd_page_alloc
wmi
snd
battery
ac
soundcore
tpm_tis
tpm
tpm_bios
intel_smartconnect
acpi_cpufreq
mperf
sg
autofs4
linear
i915
drm_kms_helper
xhci_hcd
drm
i2c_algo_bit
thermal
video
button
processor
thermal_sys
scsi_dh_emc
scsi_dh_alua
scsi_dh_rdac
scsi_dh_hp_sw
scsi_dh
dm_snapshot
dm_mirror
dm_region_hash
dm_log
dm_mod


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x05 0x18560010
0x06 0x18560010
0x07 0x18560010

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:

/sys/class/sound/hwC1D0/init_pin_configs:
0x12 0x90a60130
0x13 0x40000000
0x14 0x90170110
0x15 0x0321101f
0x16 0x411111f0
0x18 0x411111f0
0x19 0x411111f0
0x1a 0x03a11020
0x1b 0x411111f0
0x1d 0x40738105
0x1e 0x411111f0

/sys/class/sound/hwC1D0/driver_pin_configs:

/sys/class/sound/hwC1D0/user_pin_configs:

/sys/class/sound/hwC1D0/init_verbs:


!!ALSA/HDA dmesg
!!--------------

[12198.450025] i915 0000:00:02.0: setting latency timer to 64
[12198.450110] snd_hda_intel 0000:00:03.0: irq 59 for MSI/MSI-X
[12198.450620] xhci_hcd 0000:00:14.0: setting latency timer to 64
--
[12198.450945] e1000e 0000:00:19.0: irq 65 for MSI/MSI-X
[12198.451006] snd_hda_intel 0000:00:1b.0: irq 66 for MSI/MSI-X
[12198.451043] ehci-pci 0000:00:1d.0: setting latency timer to 64
--
[25151.992951] usb usb3: root hub lost power or was reset
[25151.992984] snd_hda_intel 0000:00:03.0: irq 59 for MSI/MSI-X
[25151.993038] e1000e 0000:00:19.0: setting latency timer to 64
--
[25151.993204] ehci-pci 0000:00:1d.0: setting latency timer to 64
[25151.993239] snd_hda_intel 0000:00:1b.0: irq 66 for MSI/MSI-X
[25151.993252] ahci 0000:00:1f.2: setting latency timer to 64
--
[27891.995903] i915 0000:00:02.0: setting latency timer to 64
[27891.995995] snd_hda_intel 0000:00:03.0: irq 59 for MSI/MSI-X
[27891.996031] xhci_hcd 0000:00:14.0: setting latency timer to 64
--
[27891.996316] ehci-pci 0000:00:1d.0: setting latency timer to 64
[27891.996324] snd_hda_intel 0000:00:1b.0: irq 66 for MSI/MSI-X
[27891.996344] ahci 0000:00:1f.2: setting latency timer to 64
--
[33304.427102] usb usb3: root hub lost power or was reset
[33304.427139] snd_hda_intel 0000:00:03.0: irq 59 for MSI/MSI-X
[33304.427234] xhci_hcd 0000:00:14.0: irq 61 for MSI/MSI-X
--
[33304.427406] ahci 0000:00:1f.2: setting latency timer to 64
[33304.427422] snd_hda_intel 0000:00:1b.0: irq 66 for MSI/MSI-X
[33304.481693] tpm_tis 00:09: TPM is disabled/deactivated (0x6)
--
[34819.734831] ahci 0000:00:1f.2: setting latency timer to 64
[34819.734874] snd_hda_intel 0000:00:1b.0: irq 61 for MSI/MSI-X
[34819.734946] xhci_hcd 0000:00:14.0: irq 65 for MSI/MSI-X
[34819.734960] snd_hda_intel 0000:00:03.0: irq 66 for MSI/MSI-X
[34819.781367] tpm_tis 00:09: TPM is disabled/deactivated (0x6)
--
[35995.617286] i915 0000:00:02.0: setting latency timer to 64
[35995.617374] snd_hda_intel 0000:00:03.0: irq 59 for MSI/MSI-X
[35995.617409] xhci_hcd 0000:00:14.0: setting latency timer to 64
--
[35995.617500] mei_me 0000:00:16.0: irq 62 for MSI/MSI-X
[35995.617504] snd_hda_intel 0000:00:1b.0: irq 65 for MSI/MSI-X
[35995.617572] xhci_hcd 0000:00:14.0: irq 66 for MSI/MSI-X
--
[36871.626262] usb usb3: root hub lost power or was reset
[36871.626338] snd_hda_intel 0000:00:03.0: irq 59 for MSI/MSI-X
[36871.626386] xhci_hcd 0000:00:14.0: irq 61 for MSI/MSI-X
--
[36871.626488] e1000e 0000:00:19.0: irq 65 for MSI/MSI-X
[36871.626573] snd_hda_intel 0000:00:1b.0: irq 66 for MSI/MSI-X
[36871.626602] ehci-pci 0000:00:1d.0: setting latency timer to 64
--
[65312.976773] SFW2-INext-DROP-DEFLT IN=3Dwlan0 OUT=3D MAC=3D5c:51:4f:e7:=
40:aa:d8:67:d9:6e:a2:42:08:00 SRC=3D10.158.99.254 DST=3D10.158.98.255 LEN=
=3D358 TOS=3D0x00 PREC=3D0x00 TTL=3D255 ID=3D8522 PROTO=3DUDP SPT=3D67 DP=
T=3D68 LEN=3D338=20
[67496.115760] ALSA hda_codec.c:570 hda_codec: invalid CONNECT_LIST verb =
5[1]:0
[67496.116008] ALSA hda_codec.c:570 hda_codec: invalid CONNECT_LIST verb =
6[1]:0
[67496.116258] ALSA hda_codec.c:570 hda_codec: invalid CONNECT_LIST verb =
7[1]:0



--------------040105010603070502000305--

--------------ms050502080701080402090502
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIO6jCC
BHQwggNcoAMCAQICCQCJkBEVWD6HmzANBgkqhkiG9w0BAQsFADBxMQswCQYDVQQGEwJERTEc
MBoGA1UEChMTRGV1dHNjaGUgVGVsZWtvbSBBRzEfMB0GA1UECxMWVC1UZWxlU2VjIFRydXN0
IENlbnRlcjEjMCEGA1UEAxMaRGV1dHNjaGUgVGVsZWtvbSBSb290IENBIDIwHhcNMTQwMjEx
MTMxMTQ1WhcNMTkwNzA5MjM1OTAwWjBaMQswCQYDVQQGEwJERTETMBEGA1UEChMKREZOLVZl
cmVpbjEQMA4GA1UECxMHREZOLVBLSTEkMCIGA1UEAxMbREZOLVZlcmVpbiBQQ0EgR2xvYmFs
IC0gRzAxMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA6ZvDZ4X5Da71jVTDllA1
PWLpbkztlNcAW5UidNQg6zSP1uzAMQQLmYHiphTSUqAoI4SLdIkEXlvg4njBeMsWyyg1OXst
kEXQ7aAAeny/Sg4bAMOG6VwrMRF7DPOCJEOMHDiLamgAmu7cT3ir0sYTm3at7t4m6O8Br3QP
wQmi9mvOvdPNFDBP9eXjpMhim4IaAycwDQJlYE3t0QkjKpY1WCfTdsZxtpAdxO3/NYZ9bzOz
2w/FEcKKg6GUXUFr2NIQ9Uz9ylGs2b3vkoO72uuLFlZWQ8/h1RM9ph8nMM1JVNvJEzSacXXF
bOqnC5j5IZ0nrz6jOTlIaoytyZn7wxLyvQIDAQABo4IBJDCCASAwDgYDVR0PAQH/BAQDAgEG
MB0GA1UdDgQWBBRJt8bP6D0ff+pEexMp9/EKcD7eZDAfBgNVHSMEGDAWgBQxw3kbuvVT1xfg
iXotF2wKsyudMzASBgNVHRMBAf8ECDAGAQH/AgECMD8GA1UdHwQ4MDYwNKAyoDCGLmh0dHA6
Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL3JsL0RUX1JPT1RfQ0FfMi5jcmwweQYIKwYBBQUHAQEE
bTBrMCwGCCsGAQUFBzABhiBodHRwOi8vb2NzcDAzMzYudGVsZXNlYy5kZS9vY3NwcjA7Bggr
BgEFBQcwAoYvaHR0cDovL29jc3AwMzM2LnRlbGVzZWMuZGUvY3J0L0RUX1JPT1RfQ0FfMi5j
ZXIwDQYJKoZIhvcNAQELBQADggEBACwvqeBeQy8FcNxRlXVdgI47DMFjWFSBMIOcXalRh8m2
1w8runhIJGBCzPGi4jPhMh4ym1ETlXnGtazQJO0YFLwvKuovq7ITrEkdXgALBBhqmmXU6Ec1
vK7t33S22PGAUGWgxtojm41TR8psu0DJlV1OYHor5LtmQFWvtjPB6iMhbvxUnd0zQm5Ma9Xk
w/LqBrdaMmoyRXS2tW/+6v8cY6q7iNH4WK8gfo+///b3OHeLGrZQP609R3lGw1e0F2KHvZ6j
NiUHaCSqIvL2rynsN6UUma66AWCGdS1hFbp4loe1ks/hUJGeWToV7J5axob8KD5mutTZNa+t
PEkihYfub48wggTMMIIDtKADAgECAgQJ8QpjMA0GCSqGSIb3DQEBBQUAMFoxCzAJBgNVBAYT
AkRFMRMwEQYDVQQKEwpERk4tVmVyZWluMRAwDgYDVQQLEwdERk4tUEtJMSQwIgYDVQQDExtE
Rk4tVmVyZWluIFBDQSBHbG9iYWwgLSBHMDEwHhcNMDcwMjEzMTAwMzAxWhcNMTkwMjEyMDAw
MDAwWjBgMQswCQYDVQQGEwJERTEpMCcGA1UEChMgVGVjaG5pc2NoZSBVbml2ZXJzaXRhZXQg
TXVlbmNoZW4xJjAkBgNVBAMTHVplcnRpZml6aWVydW5nc3N0ZWxsZSBkZXIgVFVNMIIBIjAN
BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqO/o09gEXMn5kQtzol8T/lqBr/srstYxUEdm
+iF0lkZ3fWk31AR/NB6mHSSKqybVfmQeto+1Nz2MwfxIsBIEjjkmmk1JJhF/DqPpGMoDs9RK
1F9XR2rlwE8GXkWnEBjbeUDMzNj7oRASrf+FLwhrfMblDmxomxz70HZKjz6C9pXBmGtaF7s2
HK9WpgyIGlMT19tWJqHdSvlV0OlwZuxv8GpEPFGs4KNB01DpMJAd8hQQNNAxb9zOPXBuAvGu
nywHleXAw9ftzYOj7IHJZtyuSK10YR5qBxaoLWBzykP9/w8kihV5bhzLrQ+MdEh9gLQ0FW+D
0/S+K7AUTJYzXtusjwIDAQABo4IBkjCCAY4wDwYDVR0TAQH/BAUwAwEB/zALBgNVHQ8EBAMC
AQYwHQYDVR0OBBYEFJ2fI/AZG37HI10nKsylNjqmaeWJMB8GA1UdIwQYMBaAFEm3xs/oPR9/
6kR7Eyn38QpwPt5kMIGIBgNVHR8EgYAwfjA9oDugOYY3aHR0cDovL2NkcDEucGNhLmRmbi5k
ZS9nbG9iYWwtcm9vdC1jYS9wdWIvY3JsL2NhY3JsLmNybDA9oDugOYY3aHR0cDovL2NkcDIu
cGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1jYS9wdWIvY3JsL2NhY3JsLmNybDCBogYIKwYBBQUH
AQEEgZUwgZIwRwYIKwYBBQUHMAKGO2h0dHA6Ly9jZHAxLnBjYS5kZm4uZGUvZ2xvYmFsLXJv
b3QtY2EvcHViL2NhY2VydC9jYWNlcnQuY3J0MEcGCCsGAQUFBzAChjtodHRwOi8vY2RwMi5w
Y2EuZGZuLmRlL2dsb2JhbC1yb290LWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDANBgkqhkiG
9w0BAQUFAAOCAQEAg2g22cMLJTBw8Nzrx7+7k7999yz6vjHg55HEq1hd3d1ELK4KjEkCGF6l
KTahBzz1CFYU44HF5PsqiygKyf6G0u2CdkuPhH/I1fwx6bNg/XvQ5n+bhf2+ZGG3L6CH3SQJ
JmVpCBP0x9X7uDULpCB6VQNXw3rw13g+XUgwFaQCRlktxP38eCiXn0UaEUMXW4XHtK769gGU
7eD60ecjXxckEM6zZpsdFcjk+Zhy+0aKuxUx9ZyzSihk6idjDmm9Yj43x1q30M0i+BF2gKFM
4p289RGO2RjeQmS90B88qx/9kKPceF0SfRvpVlCoOPtUlEK8U4vS2pJzbBSsctHD/0y7aDCC
BZ4wggSGoAMCAQICBxZx6199LPQwDQYJKoZIhvcNAQEFBQAwYDELMAkGA1UEBhMCREUxKTAn
BgNVBAoTIFRlY2huaXNjaGUgVW5pdmVyc2l0YWV0IE11ZW5jaGVuMSYwJAYDVQQDEx1aZXJ0
aWZpemllcnVuZ3NzdGVsbGUgZGVyIFRVTTAeFw0xMzEwMDcwODE2MTZaFw0xNjEwMDYwODE2
MTZaMIHdMQswCQYDVQQGEwJERTEPMA0GA1UECBMGQmF5ZXJuMREwDwYDVQQHEwhNdWVuY2hl
bjEpMCcGA1UEChMgVGVjaG5pc2NoZSBVbml2ZXJzaXRhZXQgTXVlbmNoZW4xPjA8BgNVBAsT
NUZha3VsdGFldCBmdWVyIEVsZWt0cm90ZWNobmlrIHVuZCBJbmZvcm1hdGlvbnN0ZWNobmlr
MRgwFgYDVQQDEw9Kb3NjaGkgQnJhdWNobGUxJTAjBgkqhkiG9w0BCQEWFmpvc2NoaS5icmF1
Y2hsZUB0dW0uZGUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDDUTo3kvRFgmnS
RPxNZFPS0YKGEpDFHj90LrvM49ZdL95ZRW3yM7TDf1gmj+YGLecbIDvHBKB4ug4M6Sijndp9
TFFEWps+JKpKkezQjRx4/HNhXL7dlwyDsn1FixkRJjU+tAwWa+FMlLHMDA3rBohHKOhVmhNU
Hj9QL9CFoVuXhZlwjIio4urTCVGys8m5cmI1bwhGxjrHF/m4/jDYWiP3A+qgXiyxJpIdDM9W
HY9oGhbmIKYdNX+I9oP2aMIYxItsKUgXtVgswEwJKZ8aCi7RSUotDbi3Bv3jGRtrRAqjxrUY
xTTQejAwQFveljx7iyMczSEZXM8d+Mp/tnafvvi/AgMBAAGjggHdMIIB2TAvBgNVHSAEKDAm
MBEGDysGAQQBga0hgiwBAQQDADARBg8rBgEEAYGtIYIsAgEEAwAwCQYDVR0TBAIwADALBgNV
HQ8EBAMCBeAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMB0GA1UdDgQWBBRIPYxb
H3otuuvtVp6HesCmsA/g6zAfBgNVHSMEGDAWgBSdnyPwGRt+xyNdJyrMpTY6pmnliTAhBgNV
HREEGjAYgRZqb3NjaGkuYnJhdWNobGVAdHVtLmRlMHcGA1UdHwRwMG4wNaAzoDGGL2h0dHA6
Ly9jZHAxLnBjYS5kZm4uZGUvdHVtLWNhL3B1Yi9jcmwvY2FjcmwuY3JsMDWgM6Axhi9odHRw
Oi8vY2RwMi5wY2EuZGZuLmRlL3R1bS1jYS9wdWIvY3JsL2NhY3JsLmNybDCBkgYIKwYBBQUH
AQEEgYUwgYIwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jZHAxLnBjYS5kZm4uZGUvdHVtLWNhL3B1
Yi9jYWNlcnQvY2FjZXJ0LmNydDA/BggrBgEFBQcwAoYzaHR0cDovL2NkcDIucGNhLmRmbi5k
ZS90dW0tY2EvcHViL2NhY2VydC9jYWNlcnQuY3J0MA0GCSqGSIb3DQEBBQUAA4IBAQAr3wnm
z7doaFaoQ+5TDFubiPEyYsb5/oNs/mz/YCMe9aQZbBKBP27nTdQSOos/ui2CvQAVhYCt9/BN
a/aLo+t6HU5+EMeSbTnUus60WP7+UGM34LC4WiMbbXcEoM6ejf1wBGshtIOoF0uljXUMmft6
MRyEyPvE2qO3lNswfjSRQPoCkKEy4l2KWTi0Qj9+WQpvHgSjxto/E+K9ePIRciA05JKxkuMQ
b6s7RHmaSjrY6yEJL57T31ntotyMsTmnGuVnr7xeV/SFMnkEuFMckIJ/ltqd8Oskr4xDNoxw
S18rmMoWGrEkrqBGiaqW7szchvUClDe7tZZnWi6D3MsTRnNwMYIDWzCCA1cCAQEwazBgMQsw
CQYDVQQGEwJERTEpMCcGA1UEChMgVGVjaG5pc2NoZSBVbml2ZXJzaXRhZXQgTXVlbmNoZW4x
JjAkBgNVBAMTHVplcnRpZml6aWVydW5nc3N0ZWxsZSBkZXIgVFVNAgcWcetffSz0MAkGBSsO
AwIaBQCgggHFMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE0
MDQyOTE1MjIyNlowIwYJKoZIhvcNAQkEMRYEFOVX5SK/id4xOINT87f2X2LFSo5AMGwGCSqG
SIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggq
hkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwegYJ
KwYBBAGCNxAEMW0wazBgMQswCQYDVQQGEwJERTEpMCcGA1UEChMgVGVjaG5pc2NoZSBVbml2
ZXJzaXRhZXQgTXVlbmNoZW4xJjAkBgNVBAMTHVplcnRpZml6aWVydW5nc3N0ZWxsZSBkZXIg
VFVNAgcWcetffSz0MHwGCyqGSIb3DQEJEAILMW2gazBgMQswCQYDVQQGEwJERTEpMCcGA1UE
ChMgVGVjaG5pc2NoZSBVbml2ZXJzaXRhZXQgTXVlbmNoZW4xJjAkBgNVBAMTHVplcnRpZml6
aWVydW5nc3N0ZWxsZSBkZXIgVFVNAgcWcetffSz0MA0GCSqGSIb3DQEBAQUABIIBAKkH7U41
033Z6M92zXWE0YjYdsCAZEJoeKdPuCSNxMuM1VTzxSxsjvrXFeTjqIZMUgl+uRCacmICO+q/
2KV8MxvNKwQs5WxnlOkwS0nNdmQQo6U7oWatiaVgWZG7pRxsFhRughIt4WuYY8z4kHuLWKuV
IpJ4WWxuDKa3w8dew5CnO57eL4AkA9Hp9OHsUz/b6mwO75wjGgkMdyRTasgi+QtPWkX7as21
riVDdRDe0h3EfvX+P7xlpg5i+T1wDNz5hXebh0K1/S2N4dfWJryWO5V2cH3ecujA89xulSlI
WAcf5L+ZAx3xBHKf2/vOBYCM+sMM+2SWfsJ3PtfmfyEajfUAAAAAAAA=
--------------ms050502080701080402090502--

--===============6642654720015492557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6642654720015492557==--
