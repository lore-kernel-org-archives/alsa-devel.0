From: Joschi Brauchle <joschi.brauchle@tum.de>
Subject: Re: No sound on Thinkpad T440s in Docking Station
Date: Fri, 02 May 2014 10:16:10 +0200
Message-ID: <5363544A.8040508@tum.de>
References: <5360BAD0.3060808@tum.de>	<s5h61lqix9b.wl%tiwai@suse.de>	<53612D54.10302@tum.de>
 <s5h7g64skkx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8994910342765501218=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from postout1.mail.lrz.de (postout1.mail.lrz.de [129.187.255.137])
 by alsa0.perex.cz (Postfix) with ESMTP id AE072260799
 for <alsa-devel@alsa-project.org>; Fri,  2 May 2014 10:16:38 +0200 (CEST)
In-Reply-To: <s5h7g64skkx.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a cryptographically signed message in MIME format.

--===============8994910342765501218==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms060401050503060403010406"

This is a cryptographically signed message in MIME format.

--------------ms060401050503060403010406
Content-Type: multipart/mixed;
 boundary="------------020206090606030603070106"

This is a multi-part message in MIME format.
--------------020206090606030603070106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

On 05/02/2014 09:31 AM, Takashi Iwai wrote:
> At Wed, 30 Apr 2014 19:05:24 +0200,
> Joschi Brauchle wrote:
>>
>>
>>
>> On 04/30/2014 06:43 PM, Takashi Iwai wrote:
>>> At Wed, 30 Apr 2014 10:56:48 +0200,
>>> Joschi Brauchle wrote:
>>>>
>>>> Dear all,
>>>>
>>>> using openSUSE 13.1 on an Thinkpad T440s, I am not getting sound onc=
e
>>>> the laptop is docked to its docking station.
>>>>
>>>> I suspect an additional SND_PCI_QUIRK is needed for this model.
>>>> "pactl list" returns
>>>> ----------------
>>>> alsa.mixer_name =3D "Realtek ALC292"
>>>> alsa.components =3D "HDA:10ec0292,17aa220c,00100001"
>>>> ----------------
>>>> for the analog audio output sink in docked state.
>>>>
>>>> Hence I assume a new line *similar* to this
>>>> ----------------
>>>> SND_PCI_QUIRK(0x17aa, 0x220c, "Thinkpad T440s", ALC269_FIXUP_LENOVO_=
DOCK),
>>>> ----------------
>>>> is needed?
>>>> What about the ALC292 instead of 269 Realtek chip...?
>>>
>>> It's a compatible chip, so the codec name doesn't matter.
>>> You can try it with model=3Dlenovo-dock option with the recent kernel=
s.
>>> For Haswell, it's safer to pass twice
>>> (model=3Dlenovo-dock,lenovo-dock).
>>>
>>> Let us know if this works for you.
>>>
>>>
>>> Takashi
>>>
>>    Hi Takashi,
>>
>> so i have:
>> ------------------ /etc/modprobe.d/50-sound.conf -------------------
>>
>> options snd-hda-intel model=3Dlenovo-dock,lenovo-dock
>> options snd slots=3Dsnd-hda-intel,snd-hda-intel
>> # 3hqH.vsazS+ZIdb9:Intel Corporation
>> alias snd-card-0 snd-hda-intel
>> # u1Nb.8dI5aUgInHB:Intel Corporation
>> alias snd-card-1 snd-hda-intel
>> ------------------
>> and rebooted, but still get no sound from the headphone jack on the
>> dock, although the built-in speakers immediately mute when plugging in=

>> headphones.
>
> Give alsa-info.sh output with that state for further checking.
>
>
> Takashi
>

Please find alsa-info attached while docking and with=20
"model=3Dlenovo-dock,lenovo-dock" option.

--------------020206090606030603070106
Content-Type: text/plain; charset=UTF-8;
 name="alsa-info.txt.vFKTzpWAN3"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="alsa-info.txt.vFKTzpWAN3"

upload=3Dtrue&script=3Dtrue&cardinfo=3D
!!################################
!!ALSA Information Script v 0.4.61
!!################################

!!Script ran on: Fri May  2 08:11:51 UTC 2014


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
                      HDA Intel MID at 0xf0630000 irq 63
 1 [PCH            ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0xf0634000 irq 64
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


!!Modprobe options (Sound related)
!!--------------------------------

snd-hda-intel: model=3Dlenovo-dock,lenovo-dock=20


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
	model : lenovo-dock,lenovo-dock,(null),(null),(null),(null),(null),(null=
),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(=
null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(nul=
l),(null),(null),(null)
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
	model : lenovo-dock,lenovo-dock,(null),(null),(null),(null),(null),(null=
),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(=
null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(nul=
l),(null),(null),(null)
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
  Pin Default 0x18560020: [Jack] Digital Out at Int HDMI
    Conn =3D Digital, Color =3D Unknown
    DefAssociation =3D 0x2, Sequence =3D 0x0
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
  Pin Default 0x18560030: [Jack] Digital Out at Int HDMI
    Conn =3D Digital, Color =3D Unknown
    DefAssociation =3D 0x3, Sequence =3D 0x0
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
  Control: name=3D"Speaker Playback Volume", index=3D0, device=3D0
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
  Control: name=3D"Headphone Playback Volume", index=3D0, device=3D0
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
  Control: name=3D"Dock Mic Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D1, ofs=3D0
  Control: name=3D"Dock Mic Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D1, ofs=3D0
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
     0x0c* 0x0d
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
     0x0c 0x0d*
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
  Control: name=3D"Dock Mic Boost Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Control: name=3D"Dock Mic Jack", index=3D0, device=3D0
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x2f, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000024: IN Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x20: IN
  Unsolicited: tag=3D03, enabled=3D1
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
  Unsolicited: tag=3D04, enabled=3D1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD0, actual=3DD0
Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Control: name=3D"Headphone Playback Switch", index=3D1, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Control: name=3D"Dock Headphone Jack", index=3D0, device=3D0
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00003734: IN OUT Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x40: OUT VREF_HIZ
  Unsolicited: tag=3D02, enabled=3D1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 2
     0x0c 0x0d*
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

crw-rw----+ 1 root audio 116,  7 May  1 19:38 /dev/snd/controlC0
crw-rw----+ 1 root audio 116, 11 May  1 19:38 /dev/snd/controlC1
crw-rw----+ 1 root audio 116,  2 May  1 19:38 /dev/snd/controlC4
crw-rw----+ 1 root audio 116,  6 May  1 19:38 /dev/snd/hwC0D0
crw-rw----+ 1 root audio 116, 10 May  1 19:38 /dev/snd/hwC1D0
crw-rw----+ 1 root audio 116,  5 May  1 19:48 /dev/snd/pcmC0D3p
crw-rw----+ 1 root audio 116,  4 May  1 19:48 /dev/snd/pcmC0D7p
crw-rw----+ 1 root audio 116,  3 May  1 19:48 /dev/snd/pcmC0D8p
crw-rw----+ 1 root audio 116,  9 May  1 19:48 /dev/snd/pcmC1D0c
crw-rw----+ 1 root audio 116,  8 May  2 10:11 /dev/snd/pcmC1D0p
crw-rw----+ 1 root audio 116,  1 May  1 19:38 /dev/snd/seq
crw-rw----+ 1 root audio 116, 33 May  1 19:38 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root 100 May  1 19:38 .
drwxr-xr-x 3 root root 300 May  1 19:38 ..
lrwxrwxrwx 1 root root  12 May  1 19:38 pci-0000:00:03.0 -> ../controlC0
lrwxrwxrwx 1 root root  12 May  1 19:38 pci-0000:00:1b.0 -> ../controlC1
lrwxrwxrwx 1 root root  12 May  1 19:38 platform-thinkpad_acpi -> ../cont=
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

Card hw:0 'MID'/'HDA Intel MID at 0xf0630000 irq 63'
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

Card hw:1 'PCH'/'HDA Intel PCH at 0xf0634000 irq 64'
  Mixer name	: 'Realtek ALC292'
  Components	: 'HDA:10ec0292,17aa220c,00100001'
  Controls      : 28
  Simple ctrls  : 13
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
Simple mixer control 'Headphone',1
  Capabilities: pswitch
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [on]
  Front Right: Playback [on]
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
Simple mixer control 'Dock Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Dock Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%] [0.00dB]
  Front Right: 0 [0%] [0.00dB]
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
	control.2 {
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
	control.3 {
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
	control.4 {
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
	control.5 {
		iface MIXER
		name 'Headphone Playback Switch'
		index 1
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.6 {
		iface MIXER
		name 'Dock Mic Playback Volume'
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
	control.7 {
		iface MIXER
		name 'Dock Mic Playback Switch'
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.8 {
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
	control.9 {
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
	control.10 {
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
	control.11 {
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
	control.12 {
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
	control.13 {
		iface MIXER
		name 'Dock Mic Boost Volume'
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
	control.14 {
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
	control.15 {
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
	control.16 {
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
	control.17 {
		iface MIXER
		name 'Master Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.18 {
		iface CARD
		name 'Dock Mic Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.19 {
		iface CARD
		name 'Mic Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.20 {
		iface CARD
		name 'Internal Mic Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.21 {
		iface CARD
		name 'Speaker Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.22 {
		iface CARD
		name 'Headphone Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.23 {
		iface CARD
		name 'Dock Headphone Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.24 {
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
	control.25 {
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
	control.26 {
		iface PCM
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		value.2 0
		value.3 0
		comment {
			access read
			type INTEGER
			count 4
			range '0 - 36'
		}
	}
	control.27 {
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
	control.28 {
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
usb_storage
tun
ipheth
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
arc4
iwlmvm
mac80211
snd_hda_codec_realtek
rtsx_pci_ms
snd_hda_codec_hdmi
rtsx_pci_sdmmc
iwlwifi
mmc_core
memstick
iTCO_wdt
cfg80211
iTCO_vendor_support
rtsx_pci
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
snd_hda_intel
snd_hda_codec
snd_hwdep
snd_pcm
joydev
serio_raw
i2c_i801
thinkpad_acpi
pcspkr
rfkill
lpc_ich
mfd_core
snd_seq
shpchp
e1000e
ptp
pps_core
mei_me
mei
snd_page_alloc
snd_timer
snd_seq_device
wmi
snd
tpm_tis
soundcore
battery
ac
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
drm
xhci_hcd
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
0x19 0x23a11040
0x1b 0x2121103f

/sys/class/sound/hwC1D0/user_pin_configs:

/sys/class/sound/hwC1D0/init_verbs:


!!ALSA/HDA dmesg
!!--------------

[    7.801742] shpchp: Standard Hot Plug PCI Controller Driver version: 0=
=2E4
[    7.801751] ALSA hda_i915.c:58 HDA driver get symbol successfully from=
 i915 module
[    7.801784] snd_hda_intel 0000:00:03.0: irq 63 for MSI/MSI-X
[    7.801895] snd_hda_intel 0000:00:1b.0: irq 64 for MSI/MSI-X
[    7.803714] rtsx_pci 0000:02:00.0: irq 65 for MSI/MSI-X
--
[    7.807674] iwlwifi 0000:03:00.0: irq 66 for MSI/MSI-X
[    7.809422] ALSA hda_codec.c:570 hda_codec: invalid CONNECT_LIST verb =
5[1]:0
[    7.809483] ALSA hda_codec.c:570 hda_codec: invalid CONNECT_LIST verb =
6[1]:0
[    7.809549] ALSA hda_codec.c:570 hda_codec: invalid CONNECT_LIST verb =
7[1]:0
[    7.810117] input: HDA Intel MID HDMI/DP,pcm=3D8 as /devices/pci0000:0=
0/0000:00:03.0/sound/card0/input9
[    7.810263] input: HDA Intel MID HDMI/DP,pcm=3D7 as /devices/pci0000:0=
0/0000:00:03.0/sound/card0/input10
[    7.810321] input: HDA Intel MID HDMI/DP,pcm=3D3 as /devices/pci0000:0=
0/0000:00:03.0/sound/card0/input11
[    7.812186] ALSA patch_realtek.c:418 SKU: Nid=3D0x1d sku_cfg=3D0x40738=
105
[    7.812189] ALSA patch_realtek.c:420 SKU: port_connectivity=3D0x1
[    7.812191] ALSA patch_realtek.c:421 SKU: enable_pcbeep=3D0x1
[    7.812193] ALSA patch_realtek.c:422 SKU: check_sum=3D0x00000003
[    7.812195] ALSA patch_realtek.c:423 SKU: customization=3D0x00000081
[    7.812197] ALSA patch_realtek.c:424 SKU: external_amp=3D0x0
[    7.812198] ALSA patch_realtek.c:425 SKU: platform_type=3D0x1
[    7.812200] ALSA patch_realtek.c:426 SKU: swap=3D0x0
[    7.812201] ALSA patch_realtek.c:427 SKU: override=3D0x1
[    7.812502] ALSA hda_auto_parser.c:393 autoconfig: line_outs=3D1 (0x14=
/0x0/0x0/0x0/0x0) type:speaker
[    7.812505] ALSA hda_auto_parser.c:397    speaker_outs=3D0 (0x0/0x0/0x=
0/0x0/0x0)
[    7.812507] ALSA hda_auto_parser.c:401    hp_outs=3D2 (0x15/0x1b/0x0/0=
x0/0x0)
[    7.812509] ALSA hda_auto_parser.c:402    mono: mono_out=3D0x0
[    7.812511] ALSA hda_auto_parser.c:406    inputs:
[    7.812513] ALSA hda_auto_parser.c:410      Dock Mic=3D0x19
[    7.812515] ALSA hda_auto_parser.c:410      Mic=3D0x1a
[    7.812517] ALSA hda_auto_parser.c:410      Internal Mic=3D0x12
[    7.812519] ALSA patch_realtek.c:490 realtek: No valid SSID, checking =
pincfg 0x40738105 for NID 0x1d
[    7.812522] ALSA patch_realtek.c:506 realtek: Enabling init ASM_ID=3D0=
x8105 CODEC_ID=3D10ec0292
[    7.814230] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1=
b.0/input/input12
[    7.816856] input: HDA Intel PCH Dock Headphone as /devices/pci0000:00=
/0000:00:1b.0/sound/card1/input13
[    7.816903] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000=
:00:1b.0/sound/card1/input14
[    7.816936] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1b=
=2E0/sound/card1/input15
[    7.816969] input: HDA Intel PCH Dock Mic as /devices/pci0000:00/0000:=
00:1b.0/sound/card1/input16
[    7.849209] iwlwifi 0000:03:00.0: loaded firmware version 22.0.7.0 op_=
mode iwlmvm
--
[ 5144.776425] NETDEV WATCHDOG: eth1 (ipheth): transmit queue 0 timed out=

[ 5144.776430] Modules linked in: ipheth fuse rfcomm vboxpci(O) vboxnetad=
p(O) vboxnetflt(O) bnep af_packet uvcvideo videobuf2_core videodev videob=
uf2_vmalloc videobuf2_memops btusb bluetooth xt_tcpudp xt_pkttype xt_LOG =
xt_limit vboxdrv(O) rpcsec_gss_krb5 auth_rpcgss oid_registry nfs fscache =
lockd sunrpc ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_raw ip=
t_REJECT iptable_raw xt_CT iptable_filter ip6table_mangle nf_conntrack_ne=
tbios_ns nf_conntrack_broadcast nf_conntrack_ipv4 nf_defrag_ipv4 ip_table=
s xt_conntrack nf_conntrack ip6table_filter ip6_tables x_tables arc4 iwlm=
vm mac80211 snd_hda_codec_realtek rtsx_pci_ms snd_hda_codec_hdmi rtsx_pci=
_sdmmc iwlwifi mmc_core memstick iTCO_wdt cfg80211 iTCO_vendor_support rt=
sx_pci x86_pkg_temp_thermal coretemp kvm_intel kvm crc32_pclmul crc32c_in=
tel ghash_clmulni_intel
[ 5144.776542]  aesni_intel ablk_helper cryptd lrw gf128mul glue_helper a=
es_x86_64 snd_hda_intel snd_hda_codec snd_hwdep snd_pcm joydev serio_raw =
i2c_i801 thinkpad_acpi pcspkr rfkill lpc_ich mfd_core snd_seq shpchp e100=
0e ptp pps_core mei_me mei snd_page_alloc snd_timer snd_seq_device wmi sn=
d tpm_tis soundcore battery ac tpm tpm_bios intel_smartconnect acpi_cpufr=
eq mperf sg autofs4 linear i915 drm_kms_helper drm xhci_hcd i2c_algo_bit =
thermal video button processor thermal_sys scsi_dh_emc scsi_dh_alua scsi_=
dh_rdac scsi_dh_hp_sw scsi_dh dm_snapshot dm_mirror dm_region_hash dm_log=
 dm_mod
[ 5144.776630] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           O 3.11.=
10-7-desktop #1
--
[ 8378.620756] i915 0000:00:02.0: setting latency timer to 64
[ 8378.620840] snd_hda_intel 0000:00:03.0: irq 61 for MSI/MSI-X
[ 8378.620875] xhci_hcd 0000:00:14.0: setting latency timer to 64
--
[ 8378.620915] e1000e 0000:00:19.0: irq 63 for MSI/MSI-X
[ 8378.620966] snd_hda_intel 0000:00:1b.0: irq 64 for MSI/MSI-X
[ 8378.621157] ahci 0000:00:1f.2: setting latency timer to 64
--
[ 8757.568411] xhci_hcd 0000:00:14.0: irq 62 for MSI/MSI-X
[ 8757.568633] snd_hda_intel 0000:00:03.0: irq 63 for MSI/MSI-X
[ 8757.568858] snd_hda_intel 0000:00:1b.0: irq 64 for MSI/MSI-X
[ 8757.568881] ehci-pci 0000:00:1d.0: setting latency timer to 64
--
[ 8774.275937] i915 0000:00:02.0: setting latency timer to 64
[ 8774.276021] snd_hda_intel 0000:00:03.0: irq 59 for MSI/MSI-X
[ 8774.277074] xhci_hcd 0000:00:14.0: setting latency timer to 64
--
[ 8774.277256] xhci_hcd 0000:00:14.0: irq 63 for MSI/MSI-X
[ 8774.277373] snd_hda_intel 0000:00:1b.0: irq 64 for MSI/MSI-X
[ 8774.277428] ahci 0000:00:1f.2: setting latency timer to 64
--
[ 8783.545898] cfg80211:   (57240000 KHz - 65880000 KHz @ 2160000 KHz), (=
N/A, 4000 mBm)
[10813.125362] ALSA hda_codec.c:570 hda_codec: invalid CONNECT_LIST verb =
5[1]:0
[10813.125606] ALSA hda_codec.c:570 hda_codec: invalid CONNECT_LIST verb =
6[1]:0
[10813.125860] ALSA hda_codec.c:570 hda_codec: invalid CONNECT_LIST verb =
7[1]:0



--------------020206090606030603070106--

--------------ms060401050503060403010406
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
MDUwMjA4MTYxMFowIwYJKoZIhvcNAQkEMRYEFIIAP+W1M5/u1sVmEnkqANzkhkJ2MGwGCSqG
SIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggq
hkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwegYJ
KwYBBAGCNxAEMW0wazBgMQswCQYDVQQGEwJERTEpMCcGA1UEChMgVGVjaG5pc2NoZSBVbml2
ZXJzaXRhZXQgTXVlbmNoZW4xJjAkBgNVBAMTHVplcnRpZml6aWVydW5nc3N0ZWxsZSBkZXIg
VFVNAgcWcetffSz0MHwGCyqGSIb3DQEJEAILMW2gazBgMQswCQYDVQQGEwJERTEpMCcGA1UE
ChMgVGVjaG5pc2NoZSBVbml2ZXJzaXRhZXQgTXVlbmNoZW4xJjAkBgNVBAMTHVplcnRpZml6
aWVydW5nc3N0ZWxsZSBkZXIgVFVNAgcWcetffSz0MA0GCSqGSIb3DQEBAQUABIIBAFeFF9Kp
P52BVKzEb3IAIH92op66yGiDH6mt64rk/WgbKW7gIdcjYf0jUr43caR9lJ3mvzZUG5bxCP+3
01RRm2ApCQINBSeARN0NZ8U9UfCW+N/8fdbsSkWUK3QDYwmVpAH0Bx+6KdUAXwcRwCiWjgKr
CQITq2cvCrrd3omvCyCpTPJuLZTSosK+/2uo67EJbZx5sLQ4wELvgcLD+gterYRi2bklYMTN
73aVAqCmHlYgUSp2a0bXQV5869CKK8Fx1FLKqQ3zNoeNdkIlqI9uyI8MHxEDlMg+V/WcHjCh
wMCjo+DYoIidcm0Txec4jSAjzL7KHBwu8/OT1+x7gR1NabkAAAAAAAA=
--------------ms060401050503060403010406--

--===============8994910342765501218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8994910342765501218==--
