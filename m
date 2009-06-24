From: Denis Kup <dener.kup@gmail.com>
Subject: Acer Aspire 7730G support
Date: Wed, 24 Jun 2009 16:09:58 +0400
Message-ID: <376f0d430906240509w7b8e23d4m92e3fc99fabd528@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159])
	by alsa0.perex.cz (Postfix) with ESMTP id 3834310382B
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Jun 2009 14:09:59 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id e21so36165fga.21
	for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2009 05:09:58 -0700 (PDT)
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
>     ALC888_ACER_ASPIRE_7730G,
> ...................
> };
> //////////////////////////////////////////////////////////////
> static struct hda_verb alc888_acer_aspire_7730G_verbs[] = {
>     {0x15, AC_VERB_SET_CONNECT_SEL, 0x00}, /*CHANGE  DIRECT FRONT TO BLACK JACK*/
>     {0x17, AC_VERB_SET_CONNECT_SEL, 0x02}, /* CHANGE: ENABLES SUBWOOFER ON 7730*/
>     {0x15, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT | AC_USRSP_EN}, //CHANGE FOR AUTOMUTE
>     { } /* end */
> };
>
> /*CHANGE ENABLE AUTOMUTING ON ACER 7730G
> //////////////////////////////////////////////////////
> //////////////////////////////////////////////////////*/
>
> static void alc888_acer_aspire_7730G_front_automute(struct hda_codec *codec)
> {
>      unsigned int present;
>
>      present = snd_hda_codec_read(codec, 0x15, 0,
>                      AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
>     snd_hda_codec_amp_stereo(codec, 0x14, HDA_OUTPUT, 0,
>                  HDA_AMP_MUTE, present ? HDA_AMP_MUTE : 0);
>     snd_hda_codec_amp_stereo(codec, 0x17, HDA_OUTPUT, 0,
>                  HDA_AMP_MUTE, present ? HDA_AMP_MUTE : 0);
> }
>
> static void alc888_acer_aspire_7730G_unsol_event(struct hda_codec *codec,
>                        unsigned int res)
> {
>     if ((res >> 26) == ALC880_HP_EVENT)
>         alc888_acer_aspire_7730G_front_automute(codec);
> }
>
> /*////////////////////////////////////////////////////
> //////////////////////////////////////////////////
> //////////////////////////////////////////////////////*/
> static struct alc_config_preset alc883_presets[] = {
>
>     [ALC888_ACER_ASPIRE_7730G] = {
>         .mixers = { alc883_3ST_6ch_mixer, alc883_chmode_mixer },
>         .init_verbs = { alc883_init_verbs, alc888_acer_aspire_7730G_verbs },
>         .num_dacs = ARRAY_SIZE(alc883_dac_nids),
>         .dac_nids = alc883_dac_nids,
>         .dig_out_nid = ALC883_DIGOUT_NID,
>         .dig_in_nid = ALC883_DIGIN_NID,
>         .num_channel_mode = ARRAY_SIZE(alc883_3ST_6ch_modes),
>         .channel_mode = alc883_3ST_6ch_modes,
>         .need_dac_fix = 1,
>         .input_mux = &alc883_capture_source,
>         .unsol_event = alc888_acer_aspire_7730G_unsol_event, /* CHANGE AUTOMUTE DECLARATION*/
>         .init_hook = alc888_acer_aspire_7730G_front_automute,
>     },
>
> ///////////////////////////////////////////////////////////////
>
> static const char *alc883_models[ALC883_MODEL_LAST] = {
> .................................
>     [ALC888_ACER_ASPIRE_7730G]    = "acer-aspire-7730g",
> .........................
>
> ////////////////////////////////
> static struct snd_pci_quirk alc883_cfg_tbl[] = {
> ......................................
>     SND_PCI_QUIRK(0x1025, 0x0142, "Acer Aspire 7730G", ALC888_ACER_ASPIRE_7730G),
> ..........................................

After changing file i install driver, and it automatically detect its
model (maybe there are old settings from previous install, so i dont
100% sure that it was detected). With this settings subwoofer works
perfect, internal stereo and subwoofer mute when headphone are plugged
all works, except 1 thing: subwoofer uses center channel instead LFE.
To fix it i use such asound.conf file:


> pcm.upmix_20to51 {
>     type plug
>     slave.pcm lowpass_21to21
>     slave.channels 3
>     ttable {
>         0.0 1 # left channel
>         1.1 1 # right channel
>         0.2 1 # mix left and right ...
>         1.2 1 # ... channel for subwoofer
>     }
> }
> pcm.lowpass_21to21 {
>     type ladspa
>     slave.pcm upmix_21to51
>     path "/usr/lib/ladspa"
>     channels 3
>     plugins {
>         0 {
>             id 1098 # Identity (Audio) (1098/identity_audio)
>             policy duplicate
>             input.bindings.0 "Input";
>             output.bindings.0 "Output";
>         }
>         1 {
>             id 1671 # 4 Pole Low-Pass Filter with Resonance (FCRCIA) (1672/lp4pole_fcrcia_oa)
>             policy none
>             input.bindings.2 "Input";
>             output.bindings.2 "Output";
>             input {
>                 controls [ 1000 2 ]
>             }
>         }
>     }
> }
> pcm.upmix_21to51 {
>     type plug
>     slave.pcm surround51
>     slave.channels 6
>     ttable {
>         0.0 1 # front left
>         1.1 1 # front right
>         0.2 1 # rear left
>         1.3 1 # rear right
>         0.5 0.5 # swap channels
>         1.5 0.5
>         2.4 1
>     }
> }
>
> pcm.swapCLFE_51 {
>     type plug
>     slave.pcm surround51
>     slave.channels 6
>     ttable {
>         0.0 1 # front left
>         1.1 1 # front right
>         2.2 1 # rear left
>         3.3 1 # rear right
>         4.5 1 # swap channels
>         5.4 1
>     }
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
>     rates [0x560]: 44100 48000 96000 192000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
> Default Amp-In caps: N/A
> Default Amp-Out caps: N/A
> GPIO: io=2, o=0, i=0, unsolicited=1, wake=1
>   IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>   IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
> Node 0x02 [Audio Output] wcaps 0x411: Stereo
>   Converter: stream=5, channel=0
>   PCM:
>     rates [0x560]: 44100 48000 96000 192000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
>   Power: setting=D0, actual=D0
> Node 0x03 [Audio Output] wcaps 0x411: Stereo
>   Converter: stream=5, channel=0
>   PCM:
>     rates [0x560]: 44100 48000 96000 192000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
>   Power: setting=D0, actual=D0
> Node 0x04 [Audio Output] wcaps 0x411: Stereo
>   Converter: stream=5, channel=0
>   PCM:
>     rates [0x560]: 44100 48000 96000 192000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
>   Power: setting=D0, actual=D0
> Node 0x05 [Audio Output] wcaps 0x411: Stereo
>   Converter: stream=0, channel=0
>   PCM:
>     rates [0x560]: 44100 48000 96000 192000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
>   Power: setting=D0, actual=D0
> Node 0x06 [Audio Output] wcaps 0x611: Stereo Digital
>   Converter: stream=0, channel=0
>   Digital: Enabled GenLevel
>   Digital category: 0x2
>   PCM:
>     rates [0x5e0]: 44100 48000 88200 96000 192000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
>   Power: setting=D0, actual=D0
> Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x08 [Audio Input] wcaps 0x10051b: Stereo Amp-In
>   Amp-In caps: ofs=0x0b, nsteps=0x1f, stepsize=0x05, mute=1
>   Amp-In vals:  [0x16 0x16]
>   Converter: stream=0, channel=0
>   SDI-Select: 0
>   PCM:
>     rates [0x560]: 44100 48000 96000 192000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
>   Power: setting=D0, actual=D0
>   Connection: 1
>      0x23
> Node 0x09 [Audio Input] wcaps 0x10051b: Stereo Amp-In
>   Amp-In caps: ofs=0x0b, nsteps=0x1f, stepsize=0x05, mute=1
>   Amp-In vals:  [0x9f 0x9f]
>   Converter: stream=0, channel=0
>   SDI-Select: 0
>   PCM:
>     rates [0x560]: 44100 48000 96000 192000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
>   Power: setting=D0, actual=D0
>   Connection: 1
>      0x22
> Node 0x0a [Audio Input] wcaps 0x100711: Stereo Digital
>   Converter: stream=0, channel=0
>   SDI-Select: 0
>   Digital:
>   Digital category: 0x0
>   PCM:
>     rates [0x560]: 44100 48000 96000 192000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
>   Power: setting=D0, actual=D0
>   Connection: 1
>      0x1f
> Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>   Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
>   Amp-In vals:  [0x80 0x80] [0x1f 0x1f] [0x00 0x00] [0x80 0x80] [0x17 0x17] [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
>   Connection: 10
>      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17
> Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
>   Amp-Out vals:  [0x12 0x12]
>   Connection: 2
>      0x02 0x0b
> Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
>   Amp-Out vals:  [0x15 0x15]
>   Connection: 2
>      0x03 0x0b
> Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x00 0x00]
>   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
>   Amp-Out vals:  [0x15 0x15]
>   Connection: 2
>      0x04 0x0b
> Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x80 0x80] [0x80 0x80]
>   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
>   Amp-Out vals:  [0x00 0x00]
>   Connection: 2
>      0x05 0x0b
> Node 0x10 [Audio Output] wcaps 0x611: Stereo Digital
>   Converter: stream=0, channel=0
>   Digital:
>   Digital category: 0x0
>   PCM:
>     rates [0x5e0]: 44100 48000 88200 96000 192000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
>   Power: setting=D0, actual=D0
> Node 0x11 [Pin Complex] wcaps 0x400780: Mono Digital
>   Pincap 0x00000014: OUT Detect
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>     DefAssociation = 0xf, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x40: OUT
>   Unsolicited: tag=00, enabled=0
>   Power: setting=D0, actual=D0
>   Connection: 1
>      0x10
> Node 0x12 [Pin Complex] wcaps 0x400401: Stereo
>   Pincap 0x00000020: IN
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>     DefAssociation = 0xf, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x00:
>   Power: setting=D0, actual=D0
> Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x14 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x0001003e: IN OUT HP EAPD Detect Trigger
>   EAPD 0x0:
>   Pin Default 0x99130110: [Fixed] Speaker at Int ATAPI
>     Conn = ATAPI, Color = Unknown
>     DefAssociation = 0x1, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x40: OUT
>   Unsolicited: tag=00, enabled=0
>   Power: setting=D0, actual=D0
>   Connection: 5
>      0x0c* 0x0d 0x0e 0x0f 0x26
> Node 0x15 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x0001003e: IN OUT HP EAPD Detect Trigger
>   EAPD 0x0:
>   Pin Default 0x0221101f: [Jack] HP Out at Ext Front
>     Conn = 1/8, Color = Black
>     DefAssociation = 0x1, Sequence = 0xf
>   Pin-ctls: 0x40: OUT
>   Unsolicited: tag=04, enabled=1
>   Power: setting=D0, actual=D0
>   Connection: 5
>      0x0c* 0x0d 0x0e 0x0f 0x26
> Node 0x16 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x00000036: IN OUT Detect Trigger
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>     DefAssociation = 0xf, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x40: OUT
>   Unsolicited: tag=00, enabled=0
>   Power: setting=D0, actual=D0
>   Connection: 5
>      0x0c 0x0d 0x0e* 0x0f 0x26
> Node 0x17 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x00000036: IN OUT Detect Trigger
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>     DefAssociation = 0xf, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x40: OUT
>   Unsolicited: tag=00, enabled=0
>   Power: setting=D0, actual=D0
>   Connection: 5
>      0x0c 0x0d 0x0e* 0x0f 0x26
> Node 0x18 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x0000373e: IN OUT HP Detect Trigger
>     Vref caps: HIZ 50 GRD 80 100
>   Pin Default 0x02a19c30: [Jack] Mic at Ext Front
>     Conn = 1/8, Color = Pink
>     DefAssociation = 0x3, Sequence = 0x0
>   Pin-ctls: 0x40: OUT VREF_HIZ
>   Unsolicited: tag=00, enabled=0
>   Power: setting=D0, actual=D0
>   Connection: 5
>      0x0c 0x0d 0x0e* 0x0f 0x26
> Node 0x19 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x80 0x80]
>   Pincap 0x0000373e: IN OUT HP Detect Trigger
>     Vref caps: HIZ 50 GRD 80 100
>   Pin Default 0x99a30931: [Fixed] Mic at Int ATAPI
>     Conn = ATAPI, Color = Unknown
>     DefAssociation = 0x3, Sequence = 0x1
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x24: IN VREF_80
>   Unsolicited: tag=00, enabled=0
>   Power: setting=D0, actual=D0
>   Connection: 5
>      0x0c* 0x0d 0x0e 0x0f 0x26
> Node 0x1a [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x0000373e: IN OUT HP Detect Trigger
>     Vref caps: HIZ 50 GRD 80 100
>   Pin Default 0x0281343f: [Jack] Line In at Ext Front
>     Conn = 1/8, Color = Blue
>     DefAssociation = 0x3, Sequence = 0xf
>   Pin-ctls: 0x40: OUT VREF_HIZ
>   Unsolicited: tag=00, enabled=0
>   Power: setting=D0, actual=D0
>   Connection: 5
>      0x0c 0x0d* 0x0e 0x0f 0x26
> Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>   Amp-In vals:  [0x00 0x00]
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x00 0x00]
>   Pincap 0x0000373e: IN OUT HP Detect Trigger
>     Vref caps: HIZ 50 GRD 80 100
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>     DefAssociation = 0xf, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0xc0: OUT HP VREF_HIZ
>   Unsolicited: tag=00, enabled=0
>   Power: setting=D0, actual=D0
>   Connection: 5
>      0x0c* 0x0d 0x0e 0x0f 0x26
> Node 0x1c [Pin Complex] wcaps 0x400481: Stereo
>   Pincap 0x00000024: IN Detect
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>     DefAssociation = 0xf, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x20: IN
>   Unsolicited: tag=00, enabled=0
>   Power: setting=D0, actual=D0
> Node 0x1d [Pin Complex] wcaps 0x400400: Mono
>   Pincap 0x00000020: IN
>   Pin Default 0x4016852d: [N/A] Speaker at Ext N/A
>     Conn = Digital, Color = Purple
>     DefAssociation = 0x2, Sequence = 0xd
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x20: IN
>   Power: setting=D0, actual=D0
> Node 0x1e [Pin Complex] wcaps 0x400780: Mono Digital
>   Pincap 0x00000014: OUT Detect
>   Pin Default 0x02451120: [Jack] SPDIF Out at Ext Front
>     Conn = Optical, Color = Black
>     DefAssociation = 0x2, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x40: OUT
>   Unsolicited: tag=00, enabled=0
>   Power: setting=D0, actual=D0
>   Connection: 1
>      0x06
> Node 0x1f [Pin Complex] wcaps 0x400680: Mono Digital
>   Pincap 0x00000024: IN Detect
>   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
>     Conn = 1/8, Color = Black
>     DefAssociation = 0xf, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x20: IN
>   Unsolicited: tag=00, enabled=0
>   Power: setting=D0, actual=D0
> Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
>   Processing caps: benign=0, ncoeff=25
>   Processing Coefficient: 0x00
>   Coefficient Index: 0x09
> Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x22 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
>   Connection: 12
>      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b 0x12
> Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
>   Connection: 11
>      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
> Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono
> Node 0x25 [Audio Output] wcaps 0x411: Stereo
>   Converter: stream=0, channel=0
>   PCM:
>     rates [0x560]: 44100 48000 96000 192000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
>   Power: setting=D0, actual=D0
> Node 0x26 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
>   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-In vals:  [0x00 0x00] [0x80 0x80]
>   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
>   Amp-Out vals:  [0x00 0x00]
>   Connection: 2
>      0x25 0x0b
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
>     rates [0x0]:
>     bits [0x0]:
>     formats [0x0]:
> Default Amp-In caps: N/A
> Default Amp-Out caps: N/A
> GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
> Node 0x04 [Audio Output] wcaps 0x211: Stereo Digital
>   Converter: stream=0, channel=0
>   Digital: Enabled
>   Digital category: 0x0
>   PCM:
>     rates [0xc0]: 48000 88200
>     bits [0xf]: 8 16 20 24
>     formats [0x1]: PCM
> Node 0x05 [Pin Complex] wcaps 0x400381: Stereo Digital
>   Pincap 0x00000014: OUT Detect
>   Pin Default 0x18560110: [Jack] Digital Out at Int HDMI
>     Conn = Digital, Color = Unknown
>     DefAssociation = 0x1, Sequence = 0x0
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x40: OUT
>   Unsolicited: tag=00, enabled=0
>   Connection: 1
>      0x04
> Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
>   Converter: stream=0, channel=0
>   Digital:
>   Digital category: 0x0
>   PCM:
>     rates [0xc0]: 48000 88200
>     bits [0xf]: 8 16 20 24
>     formats [0x1]: PCM
> Node 0x07 [Pin Complex] wcaps 0x400381: Stereo Digital
>   Pincap 0x00000014: OUT Detect
>   Pin Default 0x58560121: [N/A] Digital Out at Int HDMI
>     Conn = Digital, Color = Unknown
>     DefAssociation = 0x2, Sequence = 0x1
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x00:
>   Unsolicited: tag=00, enabled=0
>   Connection: 1
>      0x06
> Node 0x08 [Audio Output] wcaps 0x211: Stereo Digital
>   Converter: stream=0, channel=0
>   Digital:
>   Digital category: 0x0
>   PCM:
>     rates [0xc0]: 48000 88200
>     bits [0xf]: 8 16 20 24
>     formats [0x1]: PCM
> Node 0x09 [Pin Complex] wcaps 0x400381: Stereo Digital
>   Pincap 0x00000014: OUT Detect
>   Pin Default 0x58560122: [N/A] Digital Out at Int HDMI
>     Conn = Digital, Color = Unknown
>     DefAssociation = 0x2, Sequence = 0x2
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x00:
>   Unsolicited: tag=00, enabled=0
>   Connection: 1
>      0x08
> Node 0x0a [Audio Output] wcaps 0x211: Stereo Digital
>   Converter: stream=0, channel=0
>   Digital:
>   Digital category: 0x0
>   PCM:
>     rates [0xc0]: 48000 88200
>     bits [0xf]: 8 16 20 24
>     formats [0x1]: PCM
> Node 0x0b [Pin Complex] wcaps 0x400381: Stereo Digital
>   Pincap 0x00000014: OUT Detect
>   Pin Default 0x58560123: [N/A] Digital Out at Int HDMI
>     Conn = Digital, Color = Unknown
>     DefAssociation = 0x2, Sequence = 0x3
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x00:
>   Unsolicited: tag=00, enabled=0
>   Connection: 1
>      0x0a
> Node 0x0c [Audio Output] wcaps 0x211: Stereo Digital
>   Converter: stream=0, channel=0
>   Digital:
>   Digital category: 0x0
>   PCM:
>     rates [0xc0]: 48000 88200
>     bits [0xf]: 8 16 20 24
>     formats [0x1]: PCM
> Node 0x0d [Pin Complex] wcaps 0x400381: Stereo Digital
>   Pincap 0x00000014: OUT Detect
>   Pin Default 0x58560124: [N/A] Digital Out at Int HDMI
>     Conn = Digital, Color = Unknown
>     DefAssociation = 0x2, Sequence = 0x4
>     Misc = NO_PRESENCE
>   Pin-ctls: 0x00:
>   Unsolicited: tag=00, enabled=0
>   Connection: 1
>      0x0c
>
> linux-wpg9:/home/dener # cat /proc/asound/version
> Advanced Linux Sound Architecture Driver Version 1.0.20.
> Compiled on Jun 14 2009 for kernel 2.6.27.23-0.1-pae (SMP).
>
> cat /proc/asound/devices
>   0: [ 0]   : control
>   1:        : sequencer
>   4: [ 0- 0]: hardware dependent
>   5: [ 0- 1]: hardware dependent
>   7: [ 0- 3]: hardware dependent
>  16: [ 0- 0]: digital audio playback
>  17: [ 0- 1]: digital audio playback
>  19: [ 0- 3]: digital audio playback
>  24: [ 0- 0]: digital audio capture
>  25: [ 0- 1]: digital audio capture
>  26: [ 0- 2]: digital audio capture
>  33:        : timer
>
> cat /proc/asound/pcm
> 00-00: ALC888 Analog : ALC888 Analog : playback 1 : capture 1
> 00-01: ALC888 Digital : ALC888 Digital : playback 1 : capture 1
> 00-02: ALC888 Analog : ALC888 Analog : capture 1
> 00-03: NVIDIA HDMI : NVIDIA HDMI : playback 1
>
> lspci | grep -i audio
> 00:1b.0 Audio device: Intel Corporation 82801I (ICH9 Family) HD Audio Controller (rev 03)
>



 I have 1.0.20 alsa version and OpenSUSE 11.1 distributive. I hope my
materials are usefull

PS I am from Russia, sorry for my bad English :)
