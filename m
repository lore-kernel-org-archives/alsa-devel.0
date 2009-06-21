From: Denis Kup <dener.kup@gmail.com>
Subject: Acer 7730G support for ALSA.
Date: Sun, 21 Jun 2009 22:27:30 +0400
Message-ID: <376f0d430906211127n6fa79433qdd670ea3be4e6428@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f226.google.com (mail-fx0-f226.google.com
	[209.85.220.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 550642452B
	for <alsa-devel@alsa-project.org>;
	Sun, 21 Jun 2009 20:27:32 +0200 (CEST)
Received: by fxm26 with SMTP id 26so2103915fxm.32
	for <alsa-devel@alsa-project.org>; Sun, 21 Jun 2009 11:27:31 -0700 (PDT)
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

Hey, when i first installed alsa to my laptop, there no sound from
subwoofer, jacks were map very strange (2 surrounds for ex.). I try
all models from the list, but all don't support my subwoofer. After a
weak of hard work i made a patch that enables ACER_ASPIRE_7730G model
for my laptop. It have ALC888S, 3 jacks, 6 channels, stereo internal
frontal speakers and internal subwoofer.You can see acer.com for more
info about hardware and jacks.

It's the changes i made to /alsa-kernel/pci/hda/patch_realtek.c:

> enum {
> ...................
> =A0=A0=A0 ALC888_ACER_ASPIRE_7730G,
> ...................
> };
> //////////////////////////////////////////////////////////////
> static struct hda_verb alc888_acer_aspire_7730G_verbs[] =3D {
> =A0=A0=A0 {0x15, AC_VERB_SET_CONNECT_SEL, 0x00}, /*CHANGE=A0 DIRECT FRONT=
 TO BLACK JACK*/
> =A0=A0=A0 {0x17, AC_VERB_SET_CONNECT_SEL, 0x02}, /* CHANGE: ENABLES SUBWO=
OFER ON 7730*/
> =A0=A0=A0 {0x15, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT | AC_USR=
SP_EN}, //CHANGE FOR AUTOMUTE
> =A0=A0=A0 { } /* end */
> };
>
> /*CHANGE ENABLE AUTOMUTING ON ACER 7730G
> //////////////////////////////////////////////////////
> //////////////////////////////////////////////////////*/
>
> static void alc888_acer_aspire_7730G_front_automute(struct hda_codec *cod=
ec)
> {
> =A0=A0=A0=A0 unsigned int present;
>
> =A0=A0=A0=A0 present =3D snd_hda_codec_read(codec, 0x15, 0,
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0 AC_VERB_GET_PIN_SENS=
E, 0) & 0x80000000;
> =A0=A0=A0 snd_hda_codec_amp_stereo(codec, 0x14, HDA_OUTPUT, 0,
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0HDA_AMP_MUTE, present ? HDA_AM=
P_MUTE : 0);
> =A0=A0=A0 snd_hda_codec_amp_stereo(codec, 0x17, HDA_OUTPUT, 0,
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0HDA_AMP_MUTE, present ? HDA_AM=
P_MUTE : 0);
> }
>
> static void alc888_acer_aspire_7730G_unsol_event(struct hda_codec *codec,
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0 unsigned int res)
> {
> =A0=A0=A0 if ((res >> 26) =3D=3D ALC880_HP_EVENT)
> =A0=A0=A0 =A0=A0=A0 alc888_acer_aspire_7730G_front_automute(codec);
> }
>
> /*////////////////////////////////////////////////////
> //////////////////////////////////////////////////
> //////////////////////////////////////////////////////*/
> static struct alc_config_preset alc883_presets[] =3D {
>
> =A0=A0=A0 [ALC888_ACER_ASPIRE_7730G] =3D {
> =A0=A0=A0 =A0=A0=A0 .mixers =3D { alc883_3ST_6ch_mixer, alc883_chmode_mix=
er },
> =A0=A0=A0 =A0=A0=A0 .init_verbs =3D { alc883_init_verbs, alc888_acer_aspi=
re_7730G_verbs },
> =A0=A0=A0 =A0=A0=A0 .num_dacs =3D ARRAY_SIZE(alc883_dac_nids),
> =A0=A0=A0 =A0=A0=A0 .dac_nids =3D alc883_dac_nids,
> =A0=A0=A0 =A0=A0=A0 .dig_out_nid =3D ALC883_DIGOUT_NID,
> =A0=A0=A0 =A0=A0=A0 .dig_in_nid =3D ALC883_DIGIN_NID,
> =A0=A0=A0 =A0=A0=A0 .num_channel_mode =3D ARRAY_SIZE(alc883_3ST_6ch_modes=
),
> =A0=A0=A0 =A0=A0=A0 .channel_mode =3D alc883_3ST_6ch_modes,
> =A0=A0=A0 =A0=A0=A0 .need_dac_fix =3D 1,
> =A0=A0=A0 =A0=A0=A0 .input_mux =3D &alc883_capture_source,
> =A0=A0=A0 =A0=A0=A0 .unsol_event =3D alc888_acer_aspire_7730G_unsol_event=
, /* CHANGE AUTOMUTE DECLARATION*/
> =A0=A0=A0 =A0=A0=A0 .init_hook =3D alc888_acer_aspire_7730G_front_automut=
e,
> =A0=A0=A0 },
>
> ///////////////////////////////////////////////////////////////
>
> static const char *alc883_models[ALC883_MODEL_LAST] =3D {
> .................................
> =A0=A0=A0 [ALC888_ACER_ASPIRE_7730G]=A0=A0=A0 =3D "acer-aspire-7730g",
> .........................
>
> ////////////////////////////////
> static struct snd_pci_quirk alc883_cfg_tbl[] =3D {
> ......................................
> =A0=A0=A0 SND_PCI_QUIRK(0x1025, 0x0142, "Acer Aspire 7730G", ALC888_ACER_=
ASPIRE_7730G),
> ..........................................

After changing file i install driver, and it automatically detect its
model (maybe there are old settings from previous install, so i dont
100% sure that it was detected). With this settings subwoofer works
perfect, internal stereo and subwoofer mute when headphone are plugged
all works, except 1 thing: subwoofer uses center channel instead LFE.
To fix it i use such asound.conf file:


> pcm.upmix_20to51 {
> =A0=A0=A0 type plug
> =A0=A0=A0 slave.pcm lowpass_21to21
> =A0=A0=A0 slave.channels 3
> =A0=A0=A0 ttable {
> =A0=A0=A0=A0=A0=A0=A0 0.0 1 # left channel
> =A0=A0=A0=A0=A0=A0=A0 1.1 1 # right channel
> =A0=A0=A0=A0=A0=A0=A0 0.2 1 # mix left and right ...
> =A0=A0=A0=A0=A0=A0=A0 1.2 1 # ... channel for subwoofer
> =A0=A0=A0 }
> }
> pcm.lowpass_21to21 {
> =A0=A0=A0 type ladspa
> =A0=A0=A0 slave.pcm upmix_21to51
> =A0=A0=A0 path "/usr/lib/ladspa"
> =A0=A0=A0 channels 3
> =A0=A0=A0 plugins {
> =A0=A0=A0=A0=A0=A0=A0 0 {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 id 1098 # Identity (Audio) (1098/identi=
ty_audio)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 policy duplicate
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 input.bindings.0 "Input";
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 output.bindings.0 "Output";
> =A0=A0=A0=A0=A0=A0=A0 }
> =A0=A0=A0=A0=A0=A0=A0 1 {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 id 1671 # 4 Pole Low-Pass Filter with R=
esonance (FCRCIA) (1672/lp4pole_fcrcia_oa)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 policy none
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 input.bindings.2 "Input";
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 output.bindings.2 "Output";
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 input {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 controls [ 1000 2 ]
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> =A0=A0=A0=A0=A0=A0=A0 }
> =A0=A0=A0 }
> }
> pcm.upmix_21to51 {
> =A0=A0=A0 type plug
> =A0=A0=A0 slave.pcm surround51
> =A0=A0=A0 slave.channels 6
> =A0=A0=A0 ttable {
> =A0=A0=A0=A0=A0=A0=A0 0.0 1 # front left
> =A0=A0=A0=A0=A0=A0=A0 1.1 1 # front right
> =A0=A0=A0=A0=A0=A0=A0 0.2 1 # rear left
> =A0=A0=A0=A0=A0=A0=A0 1.3 1 # rear right
> =A0=A0=A0=A0=A0=A0=A0 0.5 0.5 # swap channels
> =A0=A0=A0=A0=A0=A0=A0 1.5 0.5
> =A0=A0=A0=A0=A0=A0=A0 2.4 1
> =A0=A0=A0 }
> }
>
> pcm.swapCLFE_51 {
> =A0=A0=A0 type plug
> =A0=A0=A0 slave.pcm surround51
> =A0=A0=A0 slave.channels 6
> =A0=A0=A0 ttable {
> =A0=A0=A0=A0=A0=A0=A0 0.0 1 # front left
> =A0=A0=A0=A0=A0=A0=A0 1.1 1 # front right
> =A0=A0=A0=A0=A0=A0=A0 2.2 1 # rear left
> =A0=A0=A0=A0=A0=A0=A0 3.3 1 # rear right
> =A0=A0=A0=A0=A0=A0=A0 4.5 1 # swap channels
> =A0=A0=A0=A0=A0=A0=A0 5.4 1
> =A0=A0=A0 }
> }

I use upmix_21to51 and swapCLFE_51 devices in Amarok settings.

Is there any chance to swap Center and LFE in patch_realtek.c? And can
my 7730g config be used in future version of alsa? And how can I
detect params for snd_pci_quirk alc883_cfg_tbl ?

And some config settings for my laptop, if needed:

> linux-wpg9:/home/dener # cat /proc/asound/card0/codec*
> Codec: Realtek ALC888
> Address: 0
> Function Id: 0x1
> Vendor Id: 0x10ec0888
> Subsystem Id: 0x10250142
> Revision Id: 0x100202
> No Modem Function Group found
> Default PCM:
> =A0=A0=A0 rates [0x560]: 44100 48000 96000 192000
> =A0=A0=A0 bits [0xe]: 16 20 24
> =A0=A0=A0 formats [0x1]: PCM
> Default Amp-In caps: N/A
> Default Amp-Out caps: N/A
> GPIO: io=3D2, o=3D0, i=3D0, unsolicited=3D1, wake=3D1
> =A0 IO[0]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
> =A0 IO[1]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D0
> Node 0x02 [Audio Output] wcaps 0x411: Stereo
> =A0 Converter: stream=3D5, channel=3D0
> =A0 PCM:
> =A0=A0=A0 rates [0x560]: 44100 48000 96000 192000
> =A0=A0=A0 bits [0xe]: 16 20 24
> =A0=A0=A0 formats [0x1]: PCM
> =A0 Power: setting=3DD0, actual=3DD0
> Node 0x03 [Audio Output] wcaps 0x411: Stereo
> =A0 Converter: stream=3D5, channel=3D0
> =A0 PCM:
> =A0=A0=A0 rates [0x560]: 44100 48000 96000 192000
> =A0=A0=A0 bits [0xe]: 16 20 24
> =A0=A0=A0 formats [0x1]: PCM
> =A0 Power: setting=3DD0, actual=3DD0
> Node 0x04 [Audio Output] wcaps 0x411: Stereo
> =A0 Converter: stream=3D5, channel=3D0
> =A0 PCM:
> =A0=A0=A0 rates [0x560]: 44100 48000 96000 192000
> =A0=A0=A0 bits [0xe]: 16 20 24
> =A0=A0=A0 formats [0x1]: PCM
> =A0 Power: setting=3DD0, actual=3DD0
> Node 0x05 [Audio Output] wcaps 0x411: Stereo
> =A0 Converter: stream=3D0, channel=3D0
> =A0 PCM:
> =A0=A0=A0 rates [0x560]: 44100 48000 96000 192000
> =A0=A0=A0 bits [0xe]: 16 20 24
> =A0=A0=A0 formats [0x1]: PCM
> =A0 Power: setting=3DD0, actual=3DD0
> Node 0x06 [Audio Output] wcaps 0x611: Stereo Digital
> =A0 Converter: stream=3D0, channel=3D0
> =A0 Digital: Enabled GenLevel
> =A0 Digital category: 0x2
> =A0 PCM:
> =A0=A0=A0 rates [0x5e0]: 44100 48000 88200 96000 192000
> =A0=A0=A0 bits [0xe]: 16 20 24
> =A0=A0=A0 formats [0x1]: PCM
> =A0 Power: setting=3DD0, actual=3DD0
> Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x08 [Audio Input] wcaps 0x10051b: Stereo Amp-In
> =A0 Amp-In caps: ofs=3D0x0b, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
> =A0 Amp-In vals:=A0 [0x16 0x16]
> =A0 Converter: stream=3D0, channel=3D0
> =A0 SDI-Select: 0
> =A0 PCM:
> =A0=A0=A0 rates [0x560]: 44100 48000 96000 192000
> =A0=A0=A0 bits [0xe]: 16 20 24
> =A0=A0=A0 formats [0x1]: PCM
> =A0 Power: setting=3DD0, actual=3DD0
> =A0 Connection: 1
> =A0=A0=A0=A0 0x23
> Node 0x09 [Audio Input] wcaps 0x10051b: Stereo Amp-In
> =A0 Amp-In caps: ofs=3D0x0b, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
> =A0 Amp-In vals:=A0 [0x9f 0x9f]
> =A0 Converter: stream=3D0, channel=3D0
> =A0 SDI-Select: 0
> =A0 PCM:
> =A0=A0=A0 rates [0x560]: 44100 48000 96000 192000
> =A0=A0=A0 bits [0xe]: 16 20 24
> =A0=A0=A0 formats [0x1]: PCM
> =A0 Power: setting=3DD0, actual=3DD0
> =A0 Connection: 1
> =A0=A0=A0=A0 0x22
> Node 0x0a [Audio Input] wcaps 0x100711: Stereo Digital
> =A0 Converter: stream=3D0, channel=3D0
> =A0 SDI-Select: 0
> =A0 Digital:
> =A0 Digital category: 0x0
> =A0 PCM:
> =A0=A0=A0 rates [0x560]: 44100 48000 96000 192000
> =A0=A0=A0 bits [0xe]: 16 20 24
> =A0=A0=A0 formats [0x1]: PCM
> =A0 Power: setting=3DD0, actual=3DD0
> =A0 Connection: 1
> =A0=A0=A0=A0 0x1f
> Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
> =A0 Amp-In caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
> =A0 Amp-In vals:=A0 [0x80 0x80] [0x1f 0x1f] [0x00 0x00] [0x80 0x80] [0x17=
 0x17] [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
> =A0 Connection: 10
> =A0=A0=A0=A0 0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17
> Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
> =A0 Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
> =A0 Amp-In vals:=A0 [0x00 0x00] [0x00 0x00]
> =A0 Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05, mute=3D0
> =A0 Amp-Out vals:=A0 [0x12 0x12]
> =A0 Connection: 2
> =A0=A0=A0=A0 0x02 0x0b
> Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
> =A0 Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
> =A0 Amp-In vals:=A0 [0x00 0x00] [0x00 0x00]
> =A0 Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05, mute=3D0
> =A0 Amp-Out vals:=A0 [0x15 0x15]
> =A0 Connection: 2
> =A0=A0=A0=A0 0x03 0x0b
> Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
> =A0 Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
> =A0 Amp-In vals:=A0 [0x00 0x00] [0x00 0x00]
> =A0 Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05, mute=3D0
> =A0 Amp-Out vals:=A0 [0x15 0x15]
> =A0 Connection: 2
> =A0=A0=A0=A0 0x04 0x0b
> Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
> =A0 Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
> =A0 Amp-In vals:=A0 [0x80 0x80] [0x80 0x80]
> =A0 Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05, mute=3D0
> =A0 Amp-Out vals:=A0 [0x00 0x00]
> =A0 Connection: 2
> =A0=A0=A0=A0 0x05 0x0b
> Node 0x10 [Audio Output] wcaps 0x611: Stereo Digital
> =A0 Converter: stream=3D0, channel=3D0
> =A0 Digital:
> =A0 Digital category: 0x0
> =A0 PCM:
> =A0=A0=A0 rates [0x5e0]: 44100 48000 88200 96000 192000
> =A0=A0=A0 bits [0xe]: 16 20 24
> =A0=A0=A0 formats [0x1]: PCM
> =A0 Power: setting=3DD0, actual=3DD0
> Node 0x11 [Pin Complex] wcaps 0x400780: Mono Digital
> =A0 Pincap 0x00000014: OUT Detect
> =A0 Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
> =A0=A0=A0 Conn =3D 1/8, Color =3D Black
> =A0=A0=A0 DefAssociation =3D 0xf, Sequence =3D 0x0
> =A0=A0=A0 Misc =3D NO_PRESENCE
> =A0 Pin-ctls: 0x40: OUT
> =A0 Unsolicited: tag=3D00, enabled=3D0
> =A0 Power: setting=3DD0, actual=3DD0
> =A0 Connection: 1
> =A0=A0=A0=A0 0x10
> Node 0x12 [Pin Complex] wcaps 0x400401: Stereo
> =A0 Pincap 0x00000020: IN
> =A0 Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
> =A0=A0=A0 Conn =3D 1/8, Color =3D Black
> =A0=A0=A0 DefAssociation =3D 0xf, Sequence =3D 0x0
> =A0=A0=A0 Misc =3D NO_PRESENCE
> =A0 Pin-ctls: 0x00:
> =A0 Power: setting=3DD0, actual=3DD0
> Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x14 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
> =A0 Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
> =A0 Amp-In vals:=A0 [0x00 0x00]
> =A0 Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
> =A0 Amp-Out vals:=A0 [0x00 0x00]
> =A0 Pincap 0x0001003e: IN OUT HP EAPD Detect Trigger
> =A0 EAPD 0x0:
> =A0 Pin Default 0x99130110: [Fixed] Speaker at Int ATAPI
> =A0=A0=A0 Conn =3D ATAPI, Color =3D Unknown
> =A0=A0=A0 DefAssociation =3D 0x1, Sequence =3D 0x0
> =A0=A0=A0 Misc =3D NO_PRESENCE
> =A0 Pin-ctls: 0x40: OUT
> =A0 Unsolicited: tag=3D00, enabled=3D0
> =A0 Power: setting=3DD0, actual=3DD0
> =A0 Connection: 5
> =A0=A0=A0=A0 0x0c* 0x0d 0x0e 0x0f 0x26
> Node 0x15 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
> =A0 Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
> =A0 Amp-In vals:=A0 [0x00 0x00]
> =A0 Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
> =A0 Amp-Out vals:=A0 [0x00 0x00]
> =A0 Pincap 0x0001003e: IN OUT HP EAPD Detect Trigger
> =A0 EAPD 0x0:
> =A0 Pin Default 0x0221101f: [Jack] HP Out at Ext Front
> =A0=A0=A0 Conn =3D 1/8, Color =3D Black
> =A0=A0=A0 DefAssociation =3D 0x1, Sequence =3D 0xf
> =A0 Pin-ctls: 0x40: OUT
> =A0 Unsolicited: tag=3D04, enabled=3D1
> =A0 Power: setting=3DD0, actual=3DD0
> =A0 Connection: 5
> =A0=A0=A0=A0 0x0c* 0x0d 0x0e 0x0f 0x26
> Node 0x16 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
> =A0 Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
> =A0 Amp-In vals:=A0 [0x00 0x00]
> =A0 Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
> =A0 Amp-Out vals:=A0 [0x00 0x00]
> =A0 Pincap 0x00000036: IN OUT Detect Trigger
> =A0 Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
> =A0=A0=A0 Conn =3D 1/8, Color =3D Black
> =A0=A0=A0 DefAssociation =3D 0xf, Sequence =3D 0x0
> =A0=A0=A0 Misc =3D NO_PRESENCE
> =A0 Pin-ctls: 0x40: OUT
> =A0 Unsolicited: tag=3D00, enabled=3D0
> =A0 Power: setting=3DD0, actual=3DD0
> =A0 Connection: 5
> =A0=A0=A0=A0 0x0c 0x0d 0x0e* 0x0f 0x26
> Node 0x17 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
> =A0 Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
> =A0 Amp-In vals:=A0 [0x00 0x00]
> =A0 Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
> =A0 Amp-Out vals:=A0 [0x00 0x00]
> =A0 Pincap 0x00000036: IN OUT Detect Trigger
> =A0 Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
> =A0=A0=A0 Conn =3D 1/8, Color =3D Black
> =A0=A0=A0 DefAssociation =3D 0xf, Sequence =3D 0x0
> =A0=A0=A0 Misc =3D NO_PRESENCE
> =A0 Pin-ctls: 0x40: OUT
> =A0 Unsolicited: tag=3D00, enabled=3D0
> =A0 Power: setting=3DD0, actual=3DD0
> =A0 Connection: 5
> =A0=A0=A0=A0 0x0c 0x0d 0x0e* 0x0f 0x26
> Node 0x18 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
> =A0 Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
> =A0 Amp-In vals:=A0 [0x00 0x00]
> =A0 Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
> =A0 Amp-Out vals:=A0 [0x00 0x00]
> =A0 Pincap 0x0000373e: IN OUT HP Detect Trigger
> =A0=A0=A0 Vref caps: HIZ 50 GRD 80 100
> =A0 Pin Default 0x02a19c30: [Jack] Mic at Ext Front
> =A0=A0=A0 Conn =3D 1/8, Color =3D Pink
> =A0=A0=A0 DefAssociation =3D 0x3, Sequence =3D 0x0
> =A0 Pin-ctls: 0x40: OUT VREF_HIZ
> =A0 Unsolicited: tag=3D00, enabled=3D0
> =A0 Power: setting=3DD0, actual=3DD0
> =A0 Connection: 5
> =A0=A0=A0=A0 0x0c 0x0d 0x0e* 0x0f 0x26
> Node 0x19 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
> =A0 Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
> =A0 Amp-In vals:=A0 [0x00 0x00]
> =A0 Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
> =A0 Amp-Out vals:=A0 [0x80 0x80]
> =A0 Pincap 0x0000373e: IN OUT HP Detect Trigger
> =A0=A0=A0 Vref caps: HIZ 50 GRD 80 100
> =A0 Pin Default 0x99a30931: [Fixed] Mic at Int ATAPI
> =A0=A0=A0 Conn =3D ATAPI, Color =3D Unknown
> =A0=A0=A0 DefAssociation =3D 0x3, Sequence =3D 0x1
> =A0=A0=A0 Misc =3D NO_PRESENCE
> =A0 Pin-ctls: 0x24: IN VREF_80
> =A0 Unsolicited: tag=3D00, enabled=3D0
> =A0 Power: setting=3DD0, actual=3DD0
> =A0 Connection: 5
> =A0=A0=A0=A0 0x0c* 0x0d 0x0e 0x0f 0x26
> Node 0x1a [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
> =A0 Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
> =A0 Amp-In vals:=A0 [0x00 0x00]
> =A0 Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
> =A0 Amp-Out vals:=A0 [0x00 0x00]
> =A0 Pincap 0x0000373e: IN OUT HP Detect Trigger
> =A0=A0=A0 Vref caps: HIZ 50 GRD 80 100
> =A0 Pin Default 0x0281343f: [Jack] Line In at Ext Front
> =A0=A0=A0 Conn =3D 1/8, Color =3D Blue
> =A0=A0=A0 DefAssociation =3D 0x3, Sequence =3D 0xf
> =A0 Pin-ctls: 0x40: OUT VREF_HIZ
> =A0 Unsolicited: tag=3D00, enabled=3D0
> =A0 Power: setting=3DD0, actual=3DD0
> =A0 Connection: 5
> =A0=A0=A0=A0 0x0c 0x0d* 0x0e 0x0f 0x26
> Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
> =A0 Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
> =A0 Amp-In vals:=A0 [0x00 0x00]
> =A0 Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
> =A0 Amp-Out vals:=A0 [0x00 0x00]
> =A0 Pincap 0x0000373e: IN OUT HP Detect Trigger
> =A0=A0=A0 Vref caps: HIZ 50 GRD 80 100
> =A0 Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
> =A0=A0=A0 Conn =3D 1/8, Color =3D Black
> =A0=A0=A0 DefAssociation =3D 0xf, Sequence =3D 0x0
> =A0=A0=A0 Misc =3D NO_PRESENCE
> =A0 Pin-ctls: 0xc0: OUT HP VREF_HIZ
> =A0 Unsolicited: tag=3D00, enabled=3D0
> =A0 Power: setting=3DD0, actual=3DD0
> =A0 Connection: 5
> =A0=A0=A0=A0 0x0c* 0x0d 0x0e 0x0f 0x26
> Node 0x1c [Pin Complex] wcaps 0x400481: Stereo
> =A0 Pincap 0x00000024: IN Detect
> =A0 Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
> =A0=A0=A0 Conn =3D 1/8, Color =3D Black
> =A0=A0=A0 DefAssociation =3D 0xf, Sequence =3D 0x0
> =A0=A0=A0 Misc =3D NO_PRESENCE
> =A0 Pin-ctls: 0x20: IN
> =A0 Unsolicited: tag=3D00, enabled=3D0
> =A0 Power: setting=3DD0, actual=3DD0
> Node 0x1d [Pin Complex] wcaps 0x400400: Mono
> =A0 Pincap 0x00000020: IN
> =A0 Pin Default 0x4016852d: [N/A] Speaker at Ext N/A
> =A0=A0=A0 Conn =3D Digital, Color =3D Purple
> =A0=A0=A0 DefAssociation =3D 0x2, Sequence =3D 0xd
> =A0=A0=A0 Misc =3D NO_PRESENCE
> =A0 Pin-ctls: 0x20: IN
> =A0 Power: setting=3DD0, actual=3DD0
> Node 0x1e [Pin Complex] wcaps 0x400780: Mono Digital
> =A0 Pincap 0x00000014: OUT Detect
> =A0 Pin Default 0x02451120: [Jack] SPDIF Out at Ext Front
> =A0=A0=A0 Conn =3D Optical, Color =3D Black
> =A0=A0=A0 DefAssociation =3D 0x2, Sequence =3D 0x0
> =A0=A0=A0 Misc =3D NO_PRESENCE
> =A0 Pin-ctls: 0x40: OUT
> =A0 Unsolicited: tag=3D00, enabled=3D0
> =A0 Power: setting=3DD0, actual=3DD0
> =A0 Connection: 1
> =A0=A0=A0=A0 0x06
> Node 0x1f [Pin Complex] wcaps 0x400680: Mono Digital
> =A0 Pincap 0x00000024: IN Detect
> =A0 Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
> =A0=A0=A0 Conn =3D 1/8, Color =3D Black
> =A0=A0=A0 DefAssociation =3D 0xf, Sequence =3D 0x0
> =A0=A0=A0 Misc =3D NO_PRESENCE
> =A0 Pin-ctls: 0x20: IN
> =A0 Unsolicited: tag=3D00, enabled=3D0
> =A0 Power: setting=3DD0, actual=3DD0
> Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
> =A0 Processing caps: benign=3D0, ncoeff=3D25
> =A0 Processing Coefficient: 0x00
> =A0 Coefficient Index: 0x09
> Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x22 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
> =A0 Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
> =A0 Amp-In vals:=A0 [0x80 0x80] [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80=
 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x=
80] [0x80 0x80]
> =A0 Connection: 12
> =A0=A0=A0=A0 0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b 0x12
> Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
> =A0 Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
> =A0 Amp-In vals:=A0 [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80=
 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x=
80]
> =A0 Connection: 11
> =A0=A0=A0=A0 0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
> Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x25 [Audio Output] wcaps 0x411: Stereo
> =A0 Converter: stream=3D0, channel=3D0
> =A0 PCM:
> =A0=A0=A0 rates [0x560]: 44100 48000 96000 192000
> =A0=A0=A0 bits [0xe]: 16 20 24
> =A0=A0=A0 formats [0x1]: PCM
> =A0 Power: setting=3DD0, actual=3DD0
> Node 0x26 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
> =A0 Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
> =A0 Amp-In vals:=A0 [0x00 0x00] [0x80 0x80]
> =A0 Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05, mute=3D0
> =A0 Amp-Out vals:=A0 [0x00 0x00]
> =A0 Connection: 2
> =A0=A0=A0=A0 0x25 0x0b
> Codec: LSI ID 1040
> Address: 1
> Function Id: 0x2
> Vendor Id: 0x11c11040
> Subsystem Id: 0x1025013d
> Revision Id: 0x100200
> Modem Function Group: 0x1
> Codec: Nvidia MCP78 HDMI
> Address: 3
> Function Id: 0x1
> Vendor Id: 0x10de0006
> Subsystem Id: 0x10de0101
> Revision Id: 0x100000
> No Modem Function Group found
> Default PCM:
> =A0=A0=A0 rates [0x0]:
> =A0=A0=A0 bits [0x0]:
> =A0=A0=A0 formats [0x0]:
> Default Amp-In caps: N/A
> Default Amp-Out caps: N/A
> GPIO: io=3D0, o=3D0, i=3D0, unsolicited=3D0, wake=3D0
> Node 0x04 [Audio Output] wcaps 0x211: Stereo Digital
> =A0 Converter: stream=3D0, channel=3D0
> =A0 Digital: Enabled
> =A0 Digital category: 0x0
> =A0 PCM:
> =A0=A0=A0 rates [0xc0]: 48000 88200
> =A0=A0=A0 bits [0xf]: 8 16 20 24
> =A0=A0=A0 formats [0x1]: PCM
> Node 0x05 [Pin Complex] wcaps 0x400381: Stereo Digital
> =A0 Pincap 0x00000014: OUT Detect
> =A0 Pin Default 0x18560110: [Jack] Digital Out at Int HDMI
> =A0=A0=A0 Conn =3D Digital, Color =3D Unknown
> =A0=A0=A0 DefAssociation =3D 0x1, Sequence =3D 0x0
> =A0=A0=A0 Misc =3D NO_PRESENCE
> =A0 Pin-ctls: 0x40: OUT
> =A0 Unsolicited: tag=3D00, enabled=3D0
> =A0 Connection: 1
> =A0=A0=A0=A0 0x04
> Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
> =A0 Converter: stream=3D0, channel=3D0
> =A0 Digital:
> =A0 Digital category: 0x0
> =A0 PCM:
> =A0=A0=A0 rates [0xc0]: 48000 88200
> =A0=A0=A0 bits [0xf]: 8 16 20 24
> =A0=A0=A0 formats [0x1]: PCM
> Node 0x07 [Pin Complex] wcaps 0x400381: Stereo Digital
> =A0 Pincap 0x00000014: OUT Detect
> =A0 Pin Default 0x58560121: [N/A] Digital Out at Int HDMI
> =A0=A0=A0 Conn =3D Digital, Color =3D Unknown
> =A0=A0=A0 DefAssociation =3D 0x2, Sequence =3D 0x1
> =A0=A0=A0 Misc =3D NO_PRESENCE
> =A0 Pin-ctls: 0x00:
> =A0 Unsolicited: tag=3D00, enabled=3D0
> =A0 Connection: 1
> =A0=A0=A0=A0 0x06
> Node 0x08 [Audio Output] wcaps 0x211: Stereo Digital
> =A0 Converter: stream=3D0, channel=3D0
> =A0 Digital:
> =A0 Digital category: 0x0
> =A0 PCM:
> =A0=A0=A0 rates [0xc0]: 48000 88200
> =A0=A0=A0 bits [0xf]: 8 16 20 24
> =A0=A0=A0 formats [0x1]: PCM
> Node 0x09 [Pin Complex] wcaps 0x400381: Stereo Digital
> =A0 Pincap 0x00000014: OUT Detect
> =A0 Pin Default 0x58560122: [N/A] Digital Out at Int HDMI
> =A0=A0=A0 Conn =3D Digital, Color =3D Unknown
> =A0=A0=A0 DefAssociation =3D 0x2, Sequence =3D 0x2
> =A0=A0=A0 Misc =3D NO_PRESENCE
> =A0 Pin-ctls: 0x00:
> =A0 Unsolicited: tag=3D00, enabled=3D0
> =A0 Connection: 1
> =A0=A0=A0=A0 0x08
> Node 0x0a [Audio Output] wcaps 0x211: Stereo Digital
> =A0 Converter: stream=3D0, channel=3D0
> =A0 Digital:
> =A0 Digital category: 0x0
> =A0 PCM:
> =A0=A0=A0 rates [0xc0]: 48000 88200
> =A0=A0=A0 bits [0xf]: 8 16 20 24
> =A0=A0=A0 formats [0x1]: PCM
> Node 0x0b [Pin Complex] wcaps 0x400381: Stereo Digital
> =A0 Pincap 0x00000014: OUT Detect
> =A0 Pin Default 0x58560123: [N/A] Digital Out at Int HDMI
> =A0=A0=A0 Conn =3D Digital, Color =3D Unknown
> =A0=A0=A0 DefAssociation =3D 0x2, Sequence =3D 0x3
> =A0=A0=A0 Misc =3D NO_PRESENCE
> =A0 Pin-ctls: 0x00:
> =A0 Unsolicited: tag=3D00, enabled=3D0
> =A0 Connection: 1
> =A0=A0=A0=A0 0x0a
> Node 0x0c [Audio Output] wcaps 0x211: Stereo Digital
> =A0 Converter: stream=3D0, channel=3D0
> =A0 Digital:
> =A0 Digital category: 0x0
> =A0 PCM:
> =A0=A0=A0 rates [0xc0]: 48000 88200
> =A0=A0=A0 bits [0xf]: 8 16 20 24
> =A0=A0=A0 formats [0x1]: PCM
> Node 0x0d [Pin Complex] wcaps 0x400381: Stereo Digital
> =A0 Pincap 0x00000014: OUT Detect
> =A0 Pin Default 0x58560124: [N/A] Digital Out at Int HDMI
> =A0=A0=A0 Conn =3D Digital, Color =3D Unknown
> =A0=A0=A0 DefAssociation =3D 0x2, Sequence =3D 0x4
> =A0=A0=A0 Misc =3D NO_PRESENCE
> =A0 Pin-ctls: 0x00:
> =A0 Unsolicited: tag=3D00, enabled=3D0
> =A0 Connection: 1
> =A0=A0=A0=A0 0x0c
>
> linux-wpg9:/home/dener # cat /proc/asound/version
> Advanced Linux Sound Architecture Driver Version 1.0.20.
> Compiled on Jun 14 2009 for kernel 2.6.27.23-0.1-pae (SMP).
>
> cat /proc/asound/devices
> =A0 0: [ 0]=A0=A0 : control
> =A0 1:=A0=A0=A0=A0=A0=A0=A0 : sequencer
> =A0 4: [ 0- 0]: hardware dependent
> =A0 5: [ 0- 1]: hardware dependent
> =A0 7: [ 0- 3]: hardware dependent
> =A016: [ 0- 0]: digital audio playback
> =A017: [ 0- 1]: digital audio playback
> =A019: [ 0- 3]: digital audio playback
> =A024: [ 0- 0]: digital audio capture
> =A025: [ 0- 1]: digital audio capture
> =A026: [ 0- 2]: digital audio capture
> =A033:=A0=A0=A0=A0=A0=A0=A0 : timer
>
> cat /proc/asound/pcm
> 00-00: ALC888 Analog : ALC888 Analog : playback 1 : capture 1
> 00-01: ALC888 Digital : ALC888 Digital : playback 1 : capture 1
> 00-02: ALC888 Analog : ALC888 Analog : capture 1
> 00-03: NVIDIA HDMI : NVIDIA HDMI : playback 1
>
> lspci | grep -i audio
> 00:1b.0 Audio device: Intel Corporation 82801I (ICH9 Family) HD Audio Con=
troller (rev 03)
>



=A0I have 1.0.20 alsa version and OpenSUSE 11.1 distributive. I hope my
materials are usefull

PS I am from Russia, sorry for my bad English :)
