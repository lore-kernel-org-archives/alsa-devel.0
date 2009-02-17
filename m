From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [PATCH] hda: Add logic to force HP mixer creation
Date: Tue, 17 Feb 2009 12:02:22 -0600
Message-ID: <499AFBAE.3050003@dell.com>
References: <49983C3D.2000309@embeddedalley.com> <s5hiqnaiwa1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3577860733818723265=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ausc60pc101.us.dell.com (ausc60pc101.us.dell.com
	[143.166.85.206])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A956103862
	for <alsa-devel@alsa-project.org>; Tue, 17 Feb 2009 19:02:25 +0100 (CET)
In-Reply-To: <s5hiqnaiwa1.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Matthew Ranostay <mranostay@embeddedalley.com>
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============3577860733818723265==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD3823CC22FB6CC7425227B3E"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD3823CC22FB6CC7425227B3E
Content-Type: multipart/mixed;
 boundary="------------040702030801030609010908"

This is a multi-part message in MIME format.
--------------040702030801030609010908
Content-Type: multipart/alternative;
 boundary="------------030708060003020400060908"


--------------030708060003020400060908
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

I've tested the patch, and it does greatly aid userfriendliness. the
"Surround" mixer no longer has a function, but it's clear that you need
to turn up the Headphone mixer to make headphones work.

Here's the alsa-info.sh output with that patch applied and the other s14
patch applied to the latest git snapshot from today. I thought you
mentioned the s14 patch was applied to git, but I didn't see it in the
snapshot for some reason.

Takashi Iwai wrote:
> At Sun, 15 Feb 2009 11:01:01 -0500,
> Matthew Ranostay wrote:
>  =20
>> In some instances like a laptop PCI_QUIRK you may want to force a
>> headphone mixer otherwise a "Front" mixer would be in its place, this
>> is to aid user friendlyness.
>>
>> Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
>>    =20
>
> Well, the change looks a bit too ad hoc.
> Could you give alsa-info.sh output for this?
>
>
> thanks,
>
> Takashi
>
>  =20
>> ---
>>  sound/pci/hda/patch_sigmatel.c |   25 ++++++++++++++++++-------
>>  1 files changed, 18 insertions(+), 7 deletions(-)
>>
>> diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigm=
atel.c
>> index aeb5d21..e02a187 100644
>> --- a/sound/pci/hda/patch_sigmatel.c
>> +++ b/sound/pci/hda/patch_sigmatel.c
>> @@ -168,6 +168,7 @@ struct sigmatel_spec {
>>  	unsigned int surr_switch: 1;
>>  	unsigned int alt_switch: 1;
>>  	unsigned int hp_detect: 1;
>> +	unsigned int hp_mixer: 1;
>>  	unsigned int spdif_mute: 1;
>>  	unsigned int check_volume_offset:1;
>> =20
>> @@ -857,9 +858,9 @@ static struct hda_verb stac92hd73xx_10ch_core_init=
[] =3D {
>>  };
>> =20
>>  static struct hda_verb stac92hd83xxx_core_init[] =3D {
>> -	{ 0xa, AC_VERB_SET_CONNECT_SEL, 0x1},
>> -	{ 0xb, AC_VERB_SET_CONNECT_SEL, 0x1},
>> -	{ 0xd, AC_VERB_SET_CONNECT_SEL, 0x0},
>> +	{ 0xa, AC_VERB_SET_CONNECT_SEL, 0x0},
>> +	{ 0xb, AC_VERB_SET_CONNECT_SEL, 0x0},
>> +	{ 0xd, AC_VERB_SET_CONNECT_SEL, 0x1},
>> =20
>>  	/* power state controls amps */
>>  	{ 0x01, AC_VERB_SET_EAPD, 1 << 2},
>> @@ -3115,12 +3116,12 @@ static int stac92xx_auto_create_multi_out_ctls=
(struct hda_codec *codec,
>>  		"Front", "Surround", NULL /*CLFE*/, "Side"
>>  	};
>>  	hda_nid_t nid =3D 0;
>> -	int i, err;
>> +	int i, idx =3D 0, err;
>>  	unsigned int wid_caps;
>> =20
>>  	for (i =3D 0; i < cfg->line_outs && spec->multiout.dac_nids[i]; i++)=
 {
>>  		nid =3D spec->multiout.dac_nids[i];
>> -		if (i =3D=3D 2) {
>> +		if (idx =3D=3D 2) {
>>  			/* Center/LFE */
>>  			err =3D create_controls(codec, "Center", nid, 1);
>>  			if (err < 0)
>> @@ -3139,9 +3140,9 @@ static int stac92xx_auto_create_multi_out_ctls(s=
truct hda_codec *codec,
>>  				if (err < 0)
>>  					return err;
>>  			}
>> -
>> +			idx++;
>>  		} else {
>> -			const char *name =3D chname[i];
>> +			const char *name =3D chname[idx];
>>  			/* if it's a single DAC, assign a better name */
>>  			if (!i && is_unique_dac(spec, nid)) {
>>  				switch (cfg->line_out_type) {
>> @@ -3153,6 +3154,10 @@ static int stac92xx_auto_create_multi_out_ctls(=
struct hda_codec *codec,
>>  					break;
>>  				}
>>  			}
>> +			if (!i && spec->hp_mixer)
>> +				name =3D "Headphone";
>> +			else
>> +				idx++;
>>  			err =3D create_controls(codec, name, nid, 3);
>>  			if (err < 0)
>>  				return err;
>> @@ -4894,6 +4899,12 @@ again:
>>  		break;
>>  	}
>> =20
>> +	switch (spec->board_config) {
>> +	case STAC_DELL_S14:
>> +		spec->hp_mixer =3D 1;
>> +		break;
>> +	}
>> +
>>  	err =3D stac92xx_parse_auto_config(codec, 0x1d, 0);
>>  	if (!err) {
>>  		if (spec->board_config < 0) {
>> --=20
>> 1.5.6.3
>>
>>    =20

--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com

--------------030708060003020400060908
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"


--------------030708060003020400060908--

--------------040702030801030609010908
Content-Type: text/plain;
 name="1.0.19.11.g5fc41.195.g772ce+s14+headphone_logic.alsa-info.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename*0="1.0.19.11.g5fc41.195.g772ce+s14+headphone_logic.alsa-info.tx";
 filename*1="t"

upload=3Dtrue&script=3Dtrue&cardinfo=3D
!!################################
!!ALSA Information Script v 0.4.54
!!################################

!!Script ran on: Tue Feb 17 17:47:36 UTC 2009


!!Linux Distribution
!!------------------

Ubuntu jaunty (development branch) \n \l DISTRIB_ID=3DUbuntu DISTRIB_DESC=
RIPTION=3D"Ubuntu jaunty (development branch)"


!!Kernel Information
!!------------------

Kernel release:    2.6.28-7-generic
Operating System:  GNU/Linux
Architecture:      i686
Processor:         unknown
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.19.11.g5fc41.195.g772ce
Library version:   =20
Utilities version:  1.0.18


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Sound Servers on this system
!!----------------------------

Pulseaudio:
      Installed - Yes (/usr/bin/pulseaudio)
      Running - No

ESound Daemon:
      Installed - Yes (/usr/bin/esd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [NVidia         ]: HDA-Intel - HDA NVidia
                      HDA NVidia at 0xf0980000 irq 17


!!PCI Soundcards installed in the system
!!--------------------------------------

00:08.0 Audio device: nVidia Corporation MCP79 High Definition Audio (rev=
 b1)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:08.0 0403: 10de:0ac0 (rev b1)
	Subsystem: 1028:02ba


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


!!Loaded sound module options
!!--------------------------

!!Module: snd_hda_intel
bdl_pos_adj : 32,-1,-1,-1,-1,-1,-1,-1
enable : Y,Y,Y,Y,Y,Y,Y,Y
enable_msi : 0
id : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
index : -1,-1,-1,-1,-1,-1,-1,-1
model : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
position_fix : 0,0,0,0,0,0,0,0
power_save : 0
power_save_controller : Y
probe_mask : -1,-1,-1,-1,-1,-1,-1,-1
probe_only : N,N,N,N,N,N,N,N
single_cmd : N


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: IDT 92HD83C1X5
Address: 0
Vendor Id: 0x111d7604
Subsystem Id: 0x102802ba
Revision Id: 0x100302
No Modem Function Group found
Default PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0=

Default Amp-Out caps: ofs=3D0x7f, nsteps=3D0x7f, stepsize=3D0x02, mute=3D=
1
GPIO: io=3D3, o=3D0, i=3D0, unsolicited=3D1, wake=3D1
  IO[0]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
  IO[1]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
  IO[2]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
Power-Map: 0x00
Node 0x0a [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x0001001c: OUT HP EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x02214030: [Jack] HP Out at Ext Front
    Conn =3D 1/8, Color =3D Green
    DefAssociation =3D 0x3, Sequence =3D 0x0
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=3D02, enabled=3D1
  Power: setting=3DD0, actual=3DD0
  Connection: 4
     0x13 0x14* 0x1c 0x22
Node 0x0b [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x0001001c: OUT HP EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x02211010: [Jack] HP Out at Ext Front
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0x1, Sequence =3D 0x0
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=3D01, enabled=3D1
  Power: setting=3DD0, actual=3DD0
  Connection: 4
     0x13 0x14* 0x1c 0x22
Node 0x0c [Pin Complex] wcaps 0x400583: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00011734: IN OUT EAPD Detect
    Vref caps: HIZ 50 GRD 80
  EAPD 0x2: EAPD
  Pin Default 0x02a19020: [Jack] Mic at Ext Front
    Conn =3D 1/8, Color =3D Pink
    DefAssociation =3D 0x2, Sequence =3D 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=3D03, enabled=3D1
  Power: setting=3DD0, actual=3DD0
  Connection: 4
     0x13 0x14 0x1c 0x22*
Node 0x0d [Pin Complex] wcaps 0x400501: Stereo
  Pincap 0x00010050: OUT EAPD Balanced
  EAPD 0x2: EAPD
  Pin Default 0x01014050: [Jack] Line Out at Ext Rear
    Conn =3D 1/8, Color =3D Green
    DefAssociation =3D 0x5, Sequence =3D 0x0
  Pin-ctls: 0x40: OUT
  Power: setting=3DD0, actual=3DD0
  Connection: 4
     0x13* 0x14 0x1c 0x22
Node 0x0e [Pin Complex] wcaps 0x400583: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00010034: IN OUT EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x40f000f0: [N/A] Other at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=3D00, enabled=3D0
  Power: setting=3DD0, actual=3DD0
  Connection: 4
     0x13* 0x14 0x1c 0x22
Node 0x0f [Pin Complex] wcaps 0x400583: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00011734: IN OUT EAPD Detect
    Vref caps: HIZ 50 GRD 80
  EAPD 0x2: EAPD
  Pin Default 0x01819040: [Jack] Line In at Ext Rear
    Conn =3D 1/8, Color =3D Pink
    DefAssociation =3D 0x4, Sequence =3D 0x0
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=3D04, enabled=3D1
  Power: setting=3DD0, actual=3DD0
  Connection: 4
     0x13 0x14 0x1c 0x22*
Node 0x10 [Pin Complex] wcaps 0x400500: Mono
  Pincap 0x00000010: OUT
  Pin Default 0x40f000f0: [N/A] Other at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0x0
  Pin-ctls: 0x00:
  Power: setting=3DD0, actual=3DD0
  Connection: 1
     0x1a
Node 0x11 [Pin Complex] wcaps 0x400483: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000024: IN Detect
  Pin Default 0x90a60160: [Fixed] Mic at Int N/A
    Conn =3D Digital, Color =3D Unknown
    DefAssociation =3D 0x6, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x20: IN
  Unsolicited: tag=3D00, enabled=3D0
  Power: setting=3DD0, actual=3DD0
Node 0x12 [Vendor Defined Widget] wcaps 0xf00503: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Power: setting=3DD0, actual=3DD0
  Connection: 1
     0x20
Node 0x13 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0x77 0x77]
  Converter: stream=3D0, channel=3D0
  Power: setting=3DD0, actual=3DD0
  Delay: 13 samples
Node 0x14 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0x7a 0x7a]
  Converter: stream=3D0, channel=3D0
  Power: setting=3DD0, actual=3DD0
  Delay: 13 samples
Node 0x15 [Audio Input] wcaps 0x1d0541: Stereo
  Converter: stream=3D0, channel=3D0
  SDI-Select: 0
  Power: setting=3DD0, actual=3DD0
  Delay: 13 samples
  Connection: 1
     0x17
  Processing caps: benign=3D0, ncoeff=3D0
Node 0x16 [Audio Input] wcaps 0x1d0541: Stereo
  Converter: stream=3D0, channel=3D0
  SDI-Select: 0
  Power: setting=3DD0, actual=3DD0
  Delay: 13 samples
  Connection: 1
     0x18
  Processing caps: benign=3D0, ncoeff=3D0
Node 0x17 [Audio Selector] wcaps 0x300d0d: Stereo Amp-Out R/L
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x0f, stepsize=3D0x05, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Power: setting=3DD0, actual=3DD0
  Connection: 6
     0x0c 0x0e 0x0f 0x1b 0x11* 0x12
Node 0x18 [Audio Selector] wcaps 0x300d0d: Stereo Amp-Out R/L
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x0f, stepsize=3D0x05, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Power: setting=3DD0, actual=3DD0
  Connection: 6
     0x0c* 0x0e 0x0f 0x1b 0x11 0x12
Node 0x19 [Audio Selector] wcaps 0x300501: Stereo
  Power: setting=3DD0, actual=3DD0
  Connection: 4
     0x13* 0x14 0x1c 0x22
Node 0x1a [Audio Mixer] wcaps 0x200500: Mono
  Power: setting=3DD0, actual=3DD0
  Connection: 1
     0x19
Node 0x1b [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Amp-In caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
  Amp-In vals:  [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x9=
7]
  Power: setting=3DD0, actual=3DD0
  Connection: 5
     0x0c 0x0e 0x0f 0x13 0x14
Node 0x1c [Audio Selector] wcaps 0x30050d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
  Amp-Out vals:  [0x9f 0x9f]
  Power: setting=3DD0, actual=3DD0
  Connection: 1
     0x1b
Node 0x1d [Audio Output] wcaps 0x4061d: Stereo Digital Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Converter: stream=3D0, channel=3D0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Power: setting=3DD0, actual=3DD0
  Delay: 4 samples
Node 0x1e [Audio Output] wcaps 0x4061d: Stereo Digital Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Converter: stream=3D0, channel=3D0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Power: setting=3DD0, actual=3DD0
  Delay: 4 samples
Node 0x1f [Pin Complex] wcaps 0x400781: Stereo Digital
  Pincap 0x00000014: OUT Detect
  Pin Default 0x40f000f0: [N/A] Other at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=3D00, enabled=3D0
  Power: setting=3DD0, actual=3DD0
  Connection: 1
     0x1d
Node 0x20 [Pin Complex] wcaps 0x400781: Stereo Digital
  Pincap 0x00000034: IN OUT Detect
  Pin Default 0x40f000f0: [N/A] Other at Ext N/A
    Conn =3D Unknown, Color =3D Unknown
    DefAssociation =3D 0xf, Sequence =3D 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=3D00, enabled=3D0
  Power: setting=3DD0, actual=3DD0
  Connection: 1
     0x1e
Node 0x21 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=3D0x03, nsteps=3D0x03, stepsize=3D0x17, mute=3D1
  Amp-Out vals:  [0x00]
Node 0x22 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0xfa 0xfa]
  Converter: stream=3D0, channel=3D0
  Power: setting=3DD0, actual=3DD0
  Delay: 13 samples
Codec: Nvidia MCP7A HDMI
Address: 3
Vendor Id: 0x10de0007
Subsystem Id: 0x102802ba
Revision Id: 0x100100
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=3D0, o=3D0, i=3D0, unsolicited=3D0, wake=3D0
Node 0x04 [Audio Output] wcaps 0x211: Stereo Digital
  Converter: stream=3D0, channel=3D0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0xc0]: 48000 88200
    bits [0xf]: 8 16 20 24
    formats [0x1]: PCM
Node 0x05 [Pin Complex] wcaps 0x400381: Stereo Digital
  Pincap 0x00000014: OUT Detect
  Pin Default 0x18560110: [Jack] Digital Out at Int HDMI
    Conn =3D Digital, Color =3D Unknown
    DefAssociation =3D 0x1, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 1
     0x04
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
  Converter: stream=3D0, channel=3D0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0xc0]: 48000 88200
    bits [0xf]: 8 16 20 24
    formats [0x1]: PCM
Node 0x07 [Pin Complex] wcaps 0x400381: Stereo Digital
  Pincap 0x00000014: OUT Detect
  Pin Default 0x58560121: [N/A] Digital Out at Int HDMI
    Conn =3D Digital, Color =3D Unknown
    DefAssociation =3D 0x2, Sequence =3D 0x1
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x00:
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 1
     0x06
Node 0x08 [Audio Output] wcaps 0x211: Stereo Digital
  Converter: stream=3D0, channel=3D0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0xc0]: 48000 88200
    bits [0xf]: 8 16 20 24
    formats [0x1]: PCM
Node 0x09 [Pin Complex] wcaps 0x400381: Stereo Digital
  Pincap 0x00000014: OUT Detect
  Pin Default 0x58560122: [N/A] Digital Out at Int HDMI
    Conn =3D Digital, Color =3D Unknown
    DefAssociation =3D 0x2, Sequence =3D 0x2
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x00:
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 1
     0x08
Node 0x0a [Audio Output] wcaps 0x211: Stereo Digital
  Converter: stream=3D0, channel=3D0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0xc0]: 48000 88200
    bits [0xf]: 8 16 20 24
    formats [0x1]: PCM
Node 0x0b [Pin Complex] wcaps 0x400381: Stereo Digital
  Pincap 0x00000014: OUT Detect
  Pin Default 0x58560123: [N/A] Digital Out at Int HDMI
    Conn =3D Digital, Color =3D Unknown
    DefAssociation =3D 0x2, Sequence =3D 0x3
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x00:
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 1
     0x0a
Node 0x0c [Audio Output] wcaps 0x211: Stereo Digital
  Converter: stream=3D0, channel=3D0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0xc0]: 48000 88200
    bits [0xf]: 8 16 20 24
    formats [0x1]: PCM
Node 0x0d [Pin Complex] wcaps 0x400381: Stereo Digital
  Pincap 0x00000014: OUT Detect
  Pin Default 0x58560124: [N/A] Digital Out at Int HDMI
    Conn =3D Digital, Color =3D Unknown
    DefAssociation =3D 0x2, Sequence =3D 0x4
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x00:
  Unsolicited: tag=3D00, enabled=3D0
  Connection: 1
     0x0c
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116,  0 Feb 17 12:44 /dev/snd/controlC0
crw-rw----+ 1 root audio 116,  4 Feb 17 12:44 /dev/snd/hwC0D0
crw-rw----+ 1 root audio 116,  7 Feb 17 12:44 /dev/snd/hwC0D3
crw-rw----+ 1 root audio 116, 24 Feb 17 12:45 /dev/snd/pcmC0D0c
crw-rw----+ 1 root audio 116, 16 Feb 17 12:46 /dev/snd/pcmC0D0p
crw-rw----+ 1 root audio 116, 19 Feb 17 12:44 /dev/snd/pcmC0D3p
crw-rw----+ 1 root audio 116,  1 Feb 17 12:44 /dev/snd/seq
crw-rw----+ 1 root audio 116, 33 Feb 17 12:44 /dev/snd/timer


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: NVidia [HDA NVidia], device 0: STAC92xx Analog [STAC92xx Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: NVidia [HDA NVidia], device 3: NVIDIA HDMI [NVIDIA HDMI]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: NVidia [HDA NVidia], device 0: STAC92xx Analog [STAC92xx Analog]
  Subdevices: 2/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [NVidia]

Card hw:0 'NVidia'/'HDA NVidia at 0xf0980000 irq 17'
  Mixer name	: 'Nvidia MCP7A HDMI'
  Components	: 'HDA:111d7604,102802ba,00100302 HDA:10de0007,102802ba,0010=
0100'
  Controls      : 37
  Simple ctrls  : 22
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 59 [92%] [-3.75dB] [on]
Simple mixer control 'Headphone as Line Out',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 255 [100%] [0.00dB]
  Front Right: Playback 255 [100%] [0.00dB]
Simple mixer control 'Front',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 61 [95%] [-2.25dB] [on]
  Front Right: Playback 61 [95%] [-2.25dB] [on]
Simple mixer control 'Front Mic',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 23 [74%] [0.00dB] [off]
  Front Right: Capture 23 [74%] [0.00dB] [off]
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 64 [100%] [0.00dB] [on]
  Front Right: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 64 [100%] [0.00dB] [off]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 64 [100%] [0.00dB] [off]
Simple mixer control 'Line In',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 23 [74%] [0.00dB] [off]
  Front Right: Capture 23 [74%] [0.00dB] [off]
Simple mixer control 'Line In as Output',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Mic as Output',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Mono Mux',0
  Capabilities: enum
  Items: 'DAC0' 'DAC1' 'Mixer' 'DAC2'
  Item0: 'DAC0'
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 0 [0%] [0.00dB] [off]
  Front Right: Capture 0 [0%] [0.00dB] [off]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 0 [0%] [0.00dB] [off]
  Front Right: Capture 0 [0%] [0.00dB] [off]
Simple mixer control 'Amp',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 3
  Front Left: Capture 0 [0%] [0.00dB]
  Front Right: Capture 0 [0%] [0.00dB]
Simple mixer control 'DAC0',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 23 [74%] [0.00dB] [off]
  Front Right: Capture 23 [74%] [0.00dB] [off]
Simple mixer control 'DAC1',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 23 [74%] [0.00dB] [off]
  Front Right: Capture 23 [74%] [0.00dB] [off]
Simple mixer control 'Digital Input Source',0
  Capabilities: enum
  Items: 'Analog Inputs' 'Digital Mic 1' 'Digital Mic 2'
  Item0: 'Digital Mic 1'
Simple mixer control 'Digital Input Source',1
  Capabilities: enum
  Items: 'Analog Inputs' 'Digital Mic 1' 'Digital Mic 2'
  Item0: 'Analog Inputs'
Simple mixer control 'PC Beep',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 3
  Mono: Playback 1 [33%] [-12.00dB] [off]
Simple mixer control 'Swap Center/LFE',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]


!!Alsactl output
!!-------------

--startcollapse--
state.NVidia {
	control.1 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 15'
		comment.dbmin 0
		comment.dbmax 2250
		iface MIXER
		name 'Capture Volume'
		value.0 0
		value.1 0
	}
	control.2 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		value.0 false
		value.1 false
	}
	control.3 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 15'
		comment.dbmin 0
		comment.dbmax 2250
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 0
		value.1 0
	}
	control.4 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		index 1
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
		name 'DAC0 Capture Volume'
		value.0 23
		value.1 23
	}
	control.6 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'DAC0 Capture Switch'
		value.0 false
		value.1 false
	}
	control.7 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'DAC1 Capture Volume'
		value.0 23
		value.1 23
	}
	control.8 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'DAC1 Capture Switch'
		value.0 false
		value.1 false
	}
	control.9 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'Front Mic Capture Volume'
		value.0 23
		value.1 23
	}
	control.10 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Front Mic Capture Switch'
		value.0 false
		value.1 false
	}
	control.11 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'Line In Capture Volume'
		value.0 23
		value.1 23
	}
	control.12 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Line In Capture Switch'
		value.0 false
		value.1 false
	}
	control.13 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 64'
		comment.dbmin -4800
		comment.dbmax 0
		iface MIXER
		name 'Front Playback Volume'
		value.0 61
		value.1 61
	}
	control.14 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Front Playback Switch'
		value.0 true
		value.1 true
	}
	control.15 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 64'
		comment.dbmin -4800
		comment.dbmax 0
		iface MIXER
		name 'Surround Playback Volume'
		value.0 64
		value.1 64
	}
	control.16 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Surround Playback Switch'
		value.0 true
		value.1 true
	}
	control.17 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 64'
		comment.dbmin -4800
		comment.dbmax 0
		iface MIXER
		name 'Center Playback Volume'
		value 64
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Center Playback Switch'
		value false
	}
	control.19 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 64'
		comment.dbmin -4800
		comment.dbmax 0
		iface MIXER
		name 'LFE Playback Volume'
		value 64
	}
	control.20 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'LFE Playback Switch'
		value false
	}
	control.21 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Swap Center/LFE Playback Switch'
		value false
	}
	control.22 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Headphone as Line Out Switch'
		value false
	}
	control.23 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Line In as Output Switch'
		value false
	}
	control.24 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Mic as Output Switch'
		value false
	}
	control.25 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'PC Beep Playback Switch'
		value false
	}
	control.26 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 3'
		comment.dbmin -1800
		comment.dbmax 0
		iface MIXER
		name 'PC Beep Playback Volume'
		value 1
	}
	control.27 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 DAC0
		comment.item.1 DAC1
		comment.item.2 Mixer
		comment.item.3 DAC2
		iface MIXER
		name 'Mono Mux'
		value DAC0
	}
	control.28 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 3'
		comment.dbmin 0
		comment.dbmax 3000
		iface MIXER
		name 'Amp Capture Volume'
		value.0 0
		value.1 0
	}
	control.29 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'Analog Inputs'
		comment.item.1 'Digital Mic 1'
		comment.item.2 'Digital Mic 2'
		iface MIXER
		name 'Digital Input Source'
		value 'Digital Mic 1'
	}
	control.30 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'Analog Inputs'
		comment.item.1 'Digital Mic 1'
		comment.item.2 'Digital Mic 2'
		iface MIXER
		name 'Digital Input Source'
		index 1
		value 'Analog Inputs'
	}
	control.31 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 64'
		comment.dbmin -4800
		comment.dbmax 0
		iface MIXER
		name 'Master Playback Volume'
		value 59
	}
	control.32 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
	control.33 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.34 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.35 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.36 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
	}
	control.37 {
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
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
binfmt_misc
bridge
stp
bnep
video
output
input_polldev
ppdev
parport_pc
lp
parport
snd_hda_codec_nvhdmi
joydev
snd_hda_codec_idt
snd_hda_intel
snd_hda_codec
snd_hwdep
snd_pcm_oss
snd_mixer_oss
snd_pcm
snd_seq_dummy
snd_seq_oss
psmouse
nvidia
pcspkr
dcdbas
serio_raw
snd_seq_midi
agpgart
snd_rawmidi
ieee80211_crypt_tkip
snd_seq_midi_event
wl
ieee80211_crypt
snd_seq
shpchp
uvcvideo
compat_ioctl32
snd_timer
snd_seq_device
videodev
v4l1_compat
snd
soundcore
snd_page_alloc
ohci1394
ieee1394
r8169
mii
ehci_hcd
ohci_hcd
fbcon
tileblit
font
bitblit
softcursor
fuse



--------------040702030801030609010908--

--------------enigD3823CC22FB6CC7425227B3E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkma+64ACgkQ2CrZjkA73YsfcgCgkCIH6Dfz8e0ZvxzlZMxwbSxW
ySIAn3/tkLfy9fHS/75lIM5+xOjnilBD
=gjsR
-----END PGP SIGNATURE-----

--------------enigD3823CC22FB6CC7425227B3E--

--===============3577860733818723265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3577860733818723265==--
