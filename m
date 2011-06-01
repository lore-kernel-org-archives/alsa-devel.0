From: alex dot baldacchino dot alsasub at gmail dot com
	<alex.baldacchino.alsasub@gmail.com>
Subject: Re: Via VT2020: issues with kernel 2.6.38.{2,
 3} (alsa 1.0.23) - working with 2.6.33.2 (alsa 1.0.21)
Date: Wed, 1 Jun 2011 18:16:04 +0200
Message-ID: <BANLkTi=-dE0hvTN96yCvdNzsM59MY=csfA@mail.gmail.com>
References: <BANLkTi=9d5A+oa6Bh+fis4+WY=xNbbnkYw@mail.gmail.com>
	<BANLkTi=i+3CJLtY-1OtkFnvrzWz4+=d=VA@mail.gmail.com>
	<BANLkTimUVPCHzyASs3s0MtNV1DNKS0BfzA@mail.gmail.com>
	<BANLkTikcUZESFMF-Y30jLJ889nCLEBwNhA@mail.gmail.com>
	<BANLkTikxTsM6FUSQcZjwzcMAveJd_uS68g@mail.gmail.com>
	<BANLkTi=vxO-9KqP158AtkQozOjfqzVp_EA@mail.gmail.com>
	<BANLkTimR1_tT57o7iLbv4_QdirNbUORbfA@mail.gmail.com>
	<BANLkTi=tKPpmn0D8-Bj1NYbXSkcOveO99g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7EFE6103828
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jun 2011 18:16:06 +0200 (CEST)
Received: by wyg36 with SMTP id 36so4757486wyg.38
	for <alsa-devel@alsa-project.org>; Wed, 01 Jun 2011 09:16:06 -0700 (PDT)
In-Reply-To: <BANLkTi=tKPpmn0D8-Bj1NYbXSkcOveO99g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/5/31 Raymond Yau <superquad.vortex2@gmail.com>:
> 2011/5/27 alex dot baldacchino dot alsasub at gmail dot com
> <alex.baldacchino.alsasub@gmail.com>:
>>>
>>>
>>
>> Must these controls be always coupled? Is it a specification
>> constraint? What if via_hp_build() didn't execute
>>
>> knew =3D via_clone_control(spec, &via_hp_mixer[1]);
>>
>> when side_mute_status() returned '0' ?
>>
>
> If you disabled "Front Audio Panel" in BIOS,
> vt1718s_auto_create_hp_ctls() =A0won't build any controls related to HP
>

Yes, that's something I had noticed in my tests: front panel disabled
in bios -> no hp controls; front panel enabled in bios BUT not
connected to the motherboard-> misc: no_presence for both 0x28 and
0x29.

But I was also asking for the following code:

> static const struct snd_kcontrol_new via_hp_mixer[2] =3D {
>        {
>                .iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,
>                .name =3D "Independent HP",
>                .info =3D via_independent_hp_info,
>                .get =3D via_independent_hp_get,
>                .put =3D via_independent_hp_put,
>        },
>        {
>                .iface =3D NID_MAPPING,
>                .name =3D "Independent HP",
>        },
> };
>

Must there be always two "Independent HP" controls in all via codecs,
or there could be just one? In the latter case via_hp_mixer[1] could
be ignored in some cases.


>>
>> The last part is interesting. If vt2020 works the same way, the
>> 8-channel setup should disallow the "Independent HP" function, that is
>> it should be automatically turned off and 0x28 should be either muted,
>> or used as a 'duplicate' for 0x0c (same sound of blue jack) or 0x08
>> (same sound as rear green jack, as in 'redirected audio' ). If I'm not
>> misunderstanding everything, of course.
>
> static const struct hda_pcm_stream vt1718S_pcm_analog_playback =3D {
> =A0 =A0 =A0 =A0.substreams =3D 2,
> =A0 =A0 =A0 =A0.channels_min =3D 2,
> =A0 =A0 =A0 =A0.channels_max =3D 10,
> =A0 =A0 =A0 =A0.nid =3D 0x8, /* NID to query formats and rates */
>
> This look like vt1718s support 10 channels and 10 channels allow
> independent HP and surround71 at the same time
>

If this part of the driver is correct, you're definitely right. That
also means admin's answer at

http://www.viaarena.com/forums/showthread.php?t=3D41015

is mistaken when he says

"Please note that the =93Independent Headphone=94 function requires two
channels. Therefore, only six
channels will be available if =93Independent Headphone=94 is being used."

On the other hand, the picture of via's configuration panel seems to
give him right: in "Independent HP" mode ("Auricular independiente" in
the picture) the two side speakers for surround effects are grayed out
as to mean they're disabled, whereas in 'Redirected Ouptut"
("Auricular redirigido" in the picture) those ones seem to be enabled.
Though, there could be a lack of support for all ten channels in the
motherboard implementation and/or a limitation in that particular
version of via's driver/mixer (if possible at all, I'm just
guessing...)


>>
>> BTW, 0x2a is connected to (gets input from) 0x09, which is labeled
>> 'Surround Playback Volume' and is also an input for 0x25 ('Surround
>> Playback Switch', black jack, rear speaker according to manual)
>> throughout 0x19; 0x27 (missing gray jack) would be connected to 0x0b
>> throughout 0x1a...
>>
>>>
>>> In alsa,
>>>
>>> when independent HP is on,
>>>
>>> The HP jack is supposed to connected to [Audio Output] which is not
>>> used by the rear panel jacks (i.e. 0x25) and application has to use
>>> sudevice 1
>>>
>>> you can use aplay -Dhw:0,0,1 stereo.wav
>>
>> Tested: it works. I can get different streams out of rear (front
>> playback) and front (hp) line out jacks (used mplayer on the 'default'
>> rear channel(s) and aplay as above on the front panel)
>>
>
>
>
> so you can check whether 0xb can be used instead of 0xc for headphone

Before testing your code:

>
> static int via_independent_hp_put(struct snd_kcontrol *kcontrol,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct=
 snd_ctl_elem_value *ucontrol)
> {
> =A0 =A0 =A0 =A0struct hda_codec *codec =3D snd_kcontrol_chip(kcontrol);
> =A0 =A0 =A0 =A0struct via_spec *spec =3D codec->spec;
> =A0 =A0 =A0 =A0hda_nid_t nid =3D kcontrol->private_value;
> =A0 =A0 =A0 =A0unsigned int pinsel =3D ucontrol->value.enumerated.item[0];
> =A0 =A0 =A0 =A0/* Get Independent Mode index of headphone pin widget */
> =A0 =A0 =A0 =A0spec->hp_independent_mode =3D spec->hp_independent_mode_in=
dex =3D=3D pinsel
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0? 1 : 0;
> =A0 =A0 =A0 =A0if (spec->codec_type =3D=3D VT1718S)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_hda_codec_write(codec, nid, 0,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AC_=
VERB_SET_CONNECT_SEL, pinsel ? 2 : 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AC_=
VERB_SET_CONNECT_SEL, pinsel ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spe=
c->hp_independent_mode_index : 0);
>
>


This is to select entry at index #1 (which should be 0x0b) in the
connection list of node 0x34 (the Audio Selector driving node 0x28)
when Independent HP is selected, right?


>
>[...cut...]
>
> static const struct hda_verb vt1718S_volume_init_verbs[] =3D {
>
> - =A0 =A0 =A0 {0x34, AC_VERB_SET_CONNECT_SEL, 0x2},
> + =A0 =A0 =A0 {0x34, AC_VERB_SET_CONNECT_SEL, 0x0},
> =A0 =A0 =A0 =A0{0x35, AC_VERB_SET_CONNECT_SEL, 0x1},
>
>


What's the param field's meaning here? Is it the index of a connection
list to be selected? In this case, entry #0 for 0x34 should be 0x08,
is it to start with Independent HP turned off?

For the rest of your code (6/8 channels mode selection and retasking
part), shall I apply that altogether with the 0x0b selection part, or
should I rather test if 0x0b is usable for headphone in place of 0x0c
first?

>>
>> I haven't got an 8-channel system to test it; according to the manual,
>> line in should be used to create an 8 channel setup. As I understand
>> it, line-in (blue jack) should be a replacement for the gray jack when
>> retasked.
>>
>
>
> struct via_spec {
>
> ...
> =A0 =A0 =A0 =A0/* channel model */
> =A0 =A0 =A0 =A0const struct hda_channel_mode *channel_mode;
> =A0 =A0 =A0 =A0int num_channel_mode;
> =A0 =A0 =A0 =A0int const_channel_count;
> =A0 =A0 =A0 =A0int ext_channel_count;
>
>
>
>
> /*
> =A0* channel mode setting
> =A0*/
> static int via_ch_mode_info(struct snd_kcontrol *kcontrol,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_ctl_ele=
m_info *uinfo)
> {
> =A0 =A0 =A0 =A0struct hda_codec *codec =3D snd_kcontrol_chip(kcontrol);
> =A0 =A0 =A0 =A0struct via_spec *spec =3D codec->spec;
> =A0 =A0 =A0 =A0return snd_hda_ch_mode_info(codec, uinfo, spec->channel_mo=
de,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sp=
ec->num_channel_mode);
> }
>
> static int via_ch_mode_get(struct snd_kcontrol *kcontrol,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_ctl_elem_v=
alue *ucontrol)
> {
> =A0 =A0 =A0 =A0struct hda_codec *codec =3D snd_kcontrol_chip(kcontrol);
> =A0 =A0 =A0 =A0struct via_spec *spec =3D codec->spec;
> =A0 =A0 =A0 =A0return snd_hda_ch_mode_get(codec, ucontrol, spec->channel_=
mode,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec-=
>num_channel_mode,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec-=
>ext_channel_count);
> }
>
> static int via_ch_mode_put(struct snd_kcontrol *kcontrol,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_ctl_elem_v=
alue *ucontrol)
> {
> =A0 =A0 =A0 =A0struct hda_codec *codec =3D snd_kcontrol_chip(kcontrol);
> =A0 =A0 =A0 =A0struct via_spec *spec =3D codec->spec;
> =A0 =A0 =A0 =A0int err =3D snd_hda_ch_mode_put(codec, ucontrol, spec->cha=
nnel_mode,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0spec->num_channel_mode,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0&spec->ext_channel_count);
> =A0 =A0 =A0 =A0if (err >=3D 0 && !spec->const_channel_count) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spec->multiout.max_channels =3D spec->ext_=
channel_count;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0activate_ctl(spec->codec, "Side Playback Volume",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spec->multiout.max_channel=
s =3D=3D 8);
> =A0 =A0 =A0 =A0activate_ctl(spec->codec, "Side Playback Switch",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spec->multiout.max_channel=
s =3D=3D 8);
> =A0 =A0 =A0 =A0return err;
> }
>
> static const struct hda_verb vt1718S_6ch_init[] =3D {
> =A0 =A0 =A0 =A0{ 0x2a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN },
> =A0 =A0 =A0 =A0{ } /* end */
> };
>
> static const struct hda_verb vt1718S_8ch_init[] =3D {
> =A0 =A0 =A0 =A0{ 0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)},
> =A0 =A0 =A0 =A0{ 0x2a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
> =A0 =A0 =A0 =A0{ 0x2a, AC_VERB_SET_CONNECT_SEL, 0x01 },
> =A0 =A0 =A0 =A0{ } /* end */
> };
>
> static const struct hda_channel_mode vt1718S_modes[2] =3D {
> =A0 =A0 =A0 =A0{ 6, vt1718S_6ch_init },
> =A0 =A0 =A0 =A0{ 8, vt1718S_8ch_init },
> };
>
> static const struct snd_kcontrol_new vt1718S_chmode_mixer[] =3D {
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "Channel Mode",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.info =3D via_ch_mode_info,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.get =3D via_ch_mode_get,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.put =3D via_ch_mode_put,
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0{ }
> };
>
>
>
>
>
> /* add playback controls from the parsed DAC table */
> static int vt1718S_auto_create_multi_out_ctls(struct via_spec *spec,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 const struct auto_pin_cfg *cfg)
> {
>
>
> ...
> =A0 =A0 =A0 =A0if (spec->autocfg.line_outs =3D=3D 3) { =A0/* and 0x2a can=
 be retask as output pin */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0nid_vol =3D 0xc;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0nid_mute =3D 0x2a;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D via_add_control(
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spec, VIA_CTL_WIDGET_VOL, =
"Side Playback Volume",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0HDA_COMPOSE_AMP_VAL(nid_vo=
l, 3, 0, HDA_OUTPUT));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D via_add_control(
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spec, VIA_CTL_WIDGET_MUTE,=
 "Side Playback Switch",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0HDA_COMPOSE_AMP_VAL(nid_mu=
te, 3, 0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0HDA_OUTPUT));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spec->private_dac_nids[AUTO_SEQ_SIDE] =3D =
nid_vol;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spec->const_channel_count =3D 6;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spec->channel_mode =3D vt1718S_modes;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spec->num_channel_mode =3D ARRAY_SIZE(vt17=
18S_modes);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spec->mixers[spec->num_mixers] =3D vt1718S=
_chmode_mixer;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spec->num_mixers++;
> =A0 =A0 =A0 =A0}
> }
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
