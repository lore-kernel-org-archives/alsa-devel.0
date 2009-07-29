From: "Christian Steffen" <c-steffen@web.de>
Subject: Re: clicking noise with Sigmatel STAC9202
Date: Wed, 29 Jul 2009 20:06:23 +0200
Message-ID: <001f01ca1077$487ec2a0$d97c47e0$@de>
References: <000501ca104d$533e2bb0$f9ba8310$@de>	<s5htz0vvce3.wl%tiwai@suse.de>	<001301ca105b$5ec704d0$1c550e70$@de>	<s5hhbwvv8wd.wl%tiwai@suse.de>	<000301ca105e$d355b460$7a011d20$@de>
	<s5hd47jbj48.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0020_01CA1088.0C0792A0"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate03.web.de (fmmailgate03.web.de [217.72.192.234])
	by alsa0.perex.cz (Postfix) with ESMTP id 480881038BB
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jul 2009 20:06:23 +0200 (CEST)
In-Reply-To: <s5hd47jbj48.wl%tiwai@suse.de>
Content-Language: de
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------=_NextPart_000_0020_01CA1088.0C0792A0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Here I send the two also-info files as attachments.

Initial problem was:
Under kernel 2.6.30, Sound is working, but has constant clicking noise =
in
the background, also if the sound is completely muted.
First I thought this sound would come from some hdd or whatever, but the
device has no mechanical parts. But this is what it sounds like - =
Irregular
clicking noise.

This noise immediately starts during boot up as soon as the module is =
loaded
and before X11 has started.
I already tried options like "position_fix=3D1 or 2" and different
"model=3D"-options with no success.
"position_fix" didn't do anything at all and different model-options =
have
muted the device completely.

Kernel 2.6.24 with the same files has no issues.

>> Then give as attachments later (and don't forget Cc to alsa-devel ML)
>> these two files, not URL.  It's important because ML is archived
>> while pastebin can be removed at any time.

Thanks,
Christian Steffen



-----Urspr=FCngliche Nachricht-----
Von: Takashi Iwai [mailto:tiwai@suse.de]=20
Gesendet: Mittwoch, 29. Juli 2009 17:32
An: Christian Steffen
Cc: 'Takashi Iwai'
Betreff: Re: AW: [alsa-devel] clicking noise with Sigmatel STAC9202

At Wed, 29 Jul 2009 17:11:18 +0200,
Christian Steffen wrote:
>=20
> Thanks,
>=20
> >> Well, then at least, the contents of /proc/asound/card0/codec#*,
> >> /sys/class/sound/hwC0D*/*_pin_configs files (if present), and the =
file
> >> generated via "alsactl -f somefile store".  These are the most
> >> important information.
>=20
> There is no pinconfig file and there is also no alsactl tool present.
> I could obtain the output from the codec stuff:
>=20
> http://pastebin.com/m1b81f47d (old kernel 2.6.24, only the codec info)
> http://pastebin.com/m5baeca9a (new 2.6.30)
>=20
> that's all I could get for the older kernel as I only have access =
using
> telnet.

Then give as attachments later (and don't forget Cc to alsa-devel ML)
these two files, not URL.  It's important because ML is archived
while pastebin can be removed at any time.


Takashi

=20

------=_NextPart_000_0020_01CA1088.0C0792A0
Content-Type: text/plain;
	name="alsa_info_2_6_24.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="alsa_info_2_6_24.txt"

#
!!HDA-Intel Codec information
#
!!---------------------------
#


Codec: SigmaTel STAC9202
Address: 0
Vendor Id: 0x83847632
Subsystem Id: 0x100
Revision Id: 0x100101
No Modem Function Group found
Default PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
Node 0x02 [Audio Output] wcaps 0xd0401: Stereo
  Power: 0x0
Node 0x03 [Audio Input] wcaps 0x1d0541: Stereo
  Power: 0x0
  Connection: 1
     0x14
Node 0x04 [Audio Input] wcaps 0x140311: Stereo Digital
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Connection: 1
     0x07
Node 0x05 [Audio Output] wcaps 0x40211: Stereo Digital
  PCM:
    rates [0x1e0]: 44100 48000 88200 96000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
Node 0x06 [Audio Selector] wcaps 0x300901: Stereo
  Connection: 3
     0x02* 0x07 0x14
Node 0x07 [Pin Complex] wcaps 0x430681: Stereo Digital
  Pincap 0x0810024: IN EAPD Detect
  Pin Default 0x01110014: [Jack] Speaker at Ext Rear
    Conn = 1/8, Color = Unknown
  Pin-ctls: 0x00:
  Power: 0x0
Node 0x08 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x01410013: [Jack] SPDIF Out at Ext Rear
    Conn = 1/8, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 2
     0x05* 0x14
Node 0x09 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x07 0x07]
  Connection: 1
     0x0f
Node 0x0a [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x083f: IN OUT HP Detect
  Pin Default 0x02111011: [Jack] Speaker at Ext Front
    Conn = 1/8, Color = Black
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0e
Node 0x0b [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x081737: IN OUT Detect
  Pin Default 0x01a10021: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Unknown
  Pin-ctls: 0x24: IN
  Connection: 1
     0x0e
Node 0x0c [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x081737: IN OUT Detect
  Pin Default 0x01810022: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Unknown
  Pin-ctls: 0x20: IN
  Connection: 1
     0x0e
Node 0x0d [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x083f: IN OUT HP Detect
  Pin Default 0x02214012: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
  Pin-ctls: 0xc0: OUT HP
  Connection: 1
     0x0e
Node 0x0e [Audio Selector] wcaps 0x300105: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x0d 0x0d]
  Connection: 1
     0x06
Node 0x0f [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 5
     0x0b* 0x0c 0x0d 0x0a 0x11
Node 0x10 [Pin Complex] wcaps 0x400104: Mono Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x00]
  Pincap 0x0810: OUT
  Pin Default 0x01010031: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x12
Node 0x11 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x01310023: [Jack] CD at Ext Rear
    Conn = 1/8, Color = Unknown
  Pin-ctls: 0x20: IN
Node 0x12 [Audio Mixer] wcaps 0x200100: Mono
  Connection: 1
     0x06
Node 0x13 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=1
  Amp-Out vals:  [0x00]
Node 0x14 [Audio Selector] wcaps 0x30090d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x09* 0x15
Node 0x15 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x01d10024: [Jack] Digitial In at Ext Rear
    Conn = 1/8, Color = Unknown
  Pin-ctls: 0x20: IN

------=_NextPart_000_0020_01CA1088.0C0792A0
Content-Type: text/plain;
	name="alsa_info_2_6_30.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="alsa_info_2_6_30.txt"

name=3Duser&type=3D33&description=3D/tmp/alsa-info.txt&expiry=3D&s=3DSubm=
it+Post&content=3D
!!################################
!!ALSA Information Script v 0.4.57
!!################################

!!Script ran on: Sun May  7 11:54:21 UTC 1905


!!Linux Distribution
!!------------------




!!DMI Information
!!---------------

Manufacturer:     =20
Product Name:     =20


!!Kernel Information
!!------------------

Kernel release:    2.6.30
Operating System:  GNU/Linux
Architecture:      i686
Processor:         unknown
SMP Enabled:       No


!!ALSA Version
!!------------

Driver version:     1.0.20
Library version:    1.0.18
Utilities version:  1.0.18


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Sound Servers on this system
!!----------------------------


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [MID            ]: HDA-Intel - HDA Intel MID
                      HDA Intel MID at 0xd01c0000 irq 16


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation System Controller Hub (SCH =
Poulsbo) HD Audio Controller (rev 07)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:1b.0 0403: 8086:811b (rev 07)
	Subsystem: 8086:8119


!!Modprobe options (Sound related)
!!--------------------------------

snd-atiixp-modem: index=3D-2
snd-intel8x0m: index=3D-2
snd-via82xx-modem: index=3D-2
snd-usb-audio: index=3D-2
snd-usb-us122l: index=3D-2
snd-usb-usx2y: index=3D-2
snd-usb-caiaq: index=3D-2
snd-cmipci: mpu_port=3D0x330 fm_port=3D0x388
snd-pcsp: index=3D-2
snd-hda-intel: position_fix=3D1


!!Loaded sound module options
!!--------------------------

!!Module: snd_hda_intel
-ne =09
bdl_pos_adj : 32,-1,-1,-1,-1,-1,-1,-1
-ne =09
enable : Y,Y,Y,Y,Y,Y,Y,Y
-ne =09
enable_msi : 0
-ne =09
id : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
-ne =09
index : -1,-1,-1,-1,-1,-1,-1,-1
-ne =09
model : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
-ne =09
position_fix : 1,0,0,0,0,0,0,0
-ne =09
probe_mask : -1,-1,-1,-1,-1,-1,-1,-1
-ne =09
probe_only : N,N,N,N,N,N,N,N
-ne =09
single_cmd : N


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: SigmaTel STAC9202
Address: 0
Function Id: 0x1
Vendor Id: 0x83847632
Subsystem Id: 0x00000100
Revision Id: 0x100101
No Modem Function Group found
Default PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05, =
mute=3D1
GPIO: io=3D4, o=3D0, i=3D0, unsolicited=3D1, wake=3D1
  IO[0]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
  IO[1]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
  IO[2]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
  IO[3]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
Node 0x02 [Audio Output] wcaps 0xd0401: Stereo
  Converter: stream=3D0, channel=3D0
  Power: setting=3DD0, actual=3DD0
  Delay: 13 samples
Node 0x03 [Audio Input] wcaps 0x1d0541: Stereo
  Converter: stream=3D0, channel=3D0
  SDI-Select: 0
  Power: setting=3DD0, actual=3DD0
  Delay: 13 samples
  Connection: 1
     0x14
  Processing caps: benign=3D0, ncoeff=3D0
Node 0x04 [Audio Input] wcaps 0x140311: Stereo Digital
  Converter: stream=3D0, channel=3D0
  SDI-Select: 0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Delay: 4 samples
  Connection: 1
     0x07
Node 0x05 [Audio Output] wcaps 0x40211: Stereo Digital
  Converter: stream=3D0, channel=3D0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x1e0]: 44100 48000 88200 96000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Delay: 4 samples
Node 0x06 [Audio Selector] wcaps 0x300901: Stereo R/L
  Connection: 3
     0x02* 0x07 0x14
Node 0x07 [Pin Complex] wcaps 0x430681: Stereo Digital
  Pincap 0x00010024: IN EAPD Detect
  EAPD 0x0:
  Pin Default 0x01c5e150: [Jack] SPDIF In at Ext Rear
    Conn =3D Optical, Color =3D White
    DefAssociation =3D 0x5, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x20: IN
  Unsolicited: tag=3D00, enabled=3D0
  Power: setting=3DD0, actual=3DD0
  Delay: 3 samples
Node 0x08 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x01451130: [Jack] SPDIF Out at Ext Rear
    Conn =3D Optical, Color =3D Black
    DefAssociation =3D 0x3, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 2
     0x05* 0x14
Node 0x09 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x0f, stepsize=3D0x05, mute=3D0
  Amp-Out vals:  [0x00 0x00]
  Connection: 1
     0x0f
Node 0x0a [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0000003f: IN OUT HP Detect Trigger ImpSense
  Pin Default 0x0221401f: [Jack] HP Out at Ext Front
    Conn =3D 1/8, Color =3D Green
    DefAssociation =3D 0x1, Sequence =3D 0xf
  Pin-ctls: 0x00:
  Unsolicited: tag=3D01, enabled=3D1
  Connection: 1
     0x0e
Node 0x0b [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x00001737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x02a19020: [Jack] Mic at Ext Front
    Conn =3D 1/8, Color =3D Pink
    DefAssociation =3D 0x2, Sequence =3D 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=3D02, enabled=3D1
  Connection: 1
     0x0e
Node 0x0c [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x00001737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x01813021: [Jack] Line In at Ext Rear
    Conn =3D 1/8, Color =3D Blue
    DefAssociation =3D 0x2, Sequence =3D 0x1
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=3D03, enabled=3D1
  Connection: 1
     0x0e
Node 0x0d [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0000003f: IN OUT HP Detect Trigger ImpSense
  Pin Default 0x01014010: [Jack] Line Out at Ext Rear
    Conn =3D 1/8, Color =3D Green
    DefAssociation =3D 0x1, Sequence =3D 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 1
     0x0e
Node 0x0e [Audio Selector] wcaps 0x300105: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x95 0x95]
  Connection: 1
     0x06
Node 0x0f [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x04, stepsize=3D0x27, mute=3D0
  Amp-Out vals:  [0x00 0x00]
  Connection: 5
     0x0b 0x0c 0x0d 0x0a 0x11*
Node 0x10 [Pin Complex] wcaps 0x400104: Mono Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x00]
  Pincap 0x00000010: OUT
  Pin Default 0x500701f0: [N/A] Line Out at Int N/A
    Conn =3D Analog, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x00:
  Connection: 1
     0x12
Node 0x11 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x90330122: [Fixed] CD at Int N/A
    Conn =3D ATAPI, Color =3D Unknown
    DefAssociation =3D 0x2, Sequence =3D 0x2
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x12 [Audio Mixer] wcaps 0x200100: Mono
  Connection: 1
     0x06
Node 0x13 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=3D0x03, nsteps=3D0x03, stepsize=3D0x17, mute=3D1
  Amp-Out vals:  [0x00]
Node 0x14 [Audio Selector] wcaps 0x30090d: Stereo Amp-Out R/L
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Connection: 2
     0x09* 0x15
Node 0x15 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x50a001f1: [N/A] Mic at Int N/A
    Conn =3D Unknown, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0x1
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x20: IN
--endcollapse--
------=_NextPart_000_0020_01CA1088.0C0792A0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_NextPart_000_0020_01CA1088.0C0792A0--
