From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Via VT2020: issues with kernel 2.6.38.{2,
 3} (alsa 1.0.23) - working with 2.6.33.2 (alsa 1.0.21)
Date: Tue, 31 May 2011 21:34:01 +0800
Message-ID: <BANLkTi=tKPpmn0D8-Bj1NYbXSkcOveO99g@mail.gmail.com>
References: <BANLkTi=9d5A+oa6Bh+fis4+WY=xNbbnkYw@mail.gmail.com>
	<BANLkTi=i+3CJLtY-1OtkFnvrzWz4+=d=VA@mail.gmail.com>
	<BANLkTimUVPCHzyASs3s0MtNV1DNKS0BfzA@mail.gmail.com>
	<BANLkTikcUZESFMF-Y30jLJ889nCLEBwNhA@mail.gmail.com>
	<BANLkTikxTsM6FUSQcZjwzcMAveJd_uS68g@mail.gmail.com>
	<BANLkTi=vxO-9KqP158AtkQozOjfqzVp_EA@mail.gmail.com>
	<BANLkTimR1_tT57o7iLbv4_QdirNbUORbfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6AD7E10380C
	for <alsa-devel@alsa-project.org>;
	Tue, 31 May 2011 15:34:03 +0200 (CEST)
Received: by fxm5 with SMTP id 5so3395706fxm.38
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2011 06:34:01 -0700 (PDT)
In-Reply-To: <BANLkTimR1_tT57o7iLbv4_QdirNbUORbfA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/5/27 alex dot baldacchino dot alsasub at gmail dot com
<alex.baldacchino.alsasub@gmail.com>:
>>
>>
>
> Must these controls be always coupled? Is it a specification
> constraint? What if via_hp_build() didn't execute
>
> knew = via_clone_control(spec, &via_hp_mixer[1]);
>
> when side_mute_status() returned '0' ?
>

If you disabled "Front Audio Panel" in BIOS,
vt1718s_auto_create_hp_ctls()  won't build any controls related to HP

>>>
>>> Given actual implementation, those should be at least compatible to
>>> some extent; in case there were differences between nids in different
>>> 'flavours' of vt1718s ( for the sake of side_mute_channel(struct
>>> via_spec *spec) ), it should be possible to check
>>> spec->codec->vendor_id within the switch statement when
>>> spec->codec_type is VT1718S - the problem is finding the right nid
>>


>
> The last part is interesting. If vt2020 works the same way, the
> 8-channel setup should disallow the "Independent HP" function, that is
> it should be automatically turned off and 0x28 should be either muted,
> or used as a 'duplicate' for 0x0c (same sound of blue jack) or 0x08
> (same sound as rear green jack, as in 'redirected audio' ). If I'm not
> misunderstanding everything, of course.

static const struct hda_pcm_stream vt1718S_pcm_analog_playback = {
	.substreams = 2,
	.channels_min = 2,
	.channels_max = 10,
	.nid = 0x8, /* NID to query formats and rates */

This look like vt1718s support 10 channels and 10 channels allow
independent HP and surround71 at the same time

>
> BTW, 0x2a is connected to (gets input from) 0x09, which is labeled
> 'Surround Playback Volume' and is also an input for 0x25 ('Surround
> Playback Switch', black jack, rear speaker according to manual)
> throughout 0x19; 0x27 (missing gray jack) would be connected to 0x0b
> throughout 0x1a...
>
>>
>> In alsa,
>>
>> when independent HP is on,
>>
>> The HP jack is supposed to connected to [Audio Output] which is not
>> used by the rear panel jacks (i.e. 0x25) and application has to use
>> sudevice 1
>>
>> you can use aplay -Dhw:0,0,1 stereo.wav
>
> Tested: it works. I can get different streams out of rear (front
> playback) and front (hp) line out jacks (used mplayer on the 'default'
> rear channel(s) and aplay as above on the front panel)
>



so you can check whether 0xb can be used instead of 0xc for headphone

static int via_independent_hp_put(struct snd_kcontrol *kcontrol,
				  struct snd_ctl_elem_value *ucontrol)
{
	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
	struct via_spec *spec = codec->spec;
	hda_nid_t nid = kcontrol->private_value;
	unsigned int pinsel = ucontrol->value.enumerated.item[0];
	/* Get Independent Mode index of headphone pin widget */
	spec->hp_independent_mode = spec->hp_independent_mode_index == pinsel
		? 1 : 0;
	if (spec->codec_type == VT1718S)
		snd_hda_codec_write(codec, nid, 0,
-				    AC_VERB_SET_CONNECT_SEL, pinsel ? 2 : 0);
+				    AC_VERB_SET_CONNECT_SEL, pinsel ?
+				    spec->hp_independent_mode_index : 0);


static int vt1718S_auto_create_hp_ctls(struct via_spec *spec, hda_nid_t pin)
{
	int err;

	if (!pin)
		return 0;
+   if (spec->autocfg.line_outs == 4) {
	spec->multiout.hp_nid = 0xc; /* AOW4 */
+	spec->hp_independent_mode_index = 2;
+   }
+   else {
+	spec->multiout.hp_nid = 0xb;
	spec->hp_independent_mode_index = 1;
+}



static const struct hda_verb vt1718S_volume_init_verbs[] = {

-	{0x34, AC_VERB_SET_CONNECT_SEL, 0x2},
+	{0x34, AC_VERB_SET_CONNECT_SEL, 0x0},
	{0x35, AC_VERB_SET_CONNECT_SEL, 0x1},


>
> I haven't got an 8-channel system to test it; according to the manual,
> line in should be used to create an 8 channel setup. As I understand
> it, line-in (blue jack) should be a replacement for the gray jack when
> retasked.
>


struct via_spec {

...
	/* channel model */
	const struct hda_channel_mode *channel_mode;
	int num_channel_mode;
	int const_channel_count;
	int ext_channel_count;




/*
 * channel mode setting
 */
static int via_ch_mode_info(struct snd_kcontrol *kcontrol,
			    struct snd_ctl_elem_info *uinfo)
{
	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
	struct via_spec *spec = codec->spec;
	return snd_hda_ch_mode_info(codec, uinfo, spec->channel_mode,
				    spec->num_channel_mode);
}

static int via_ch_mode_get(struct snd_kcontrol *kcontrol,
			   struct snd_ctl_elem_value *ucontrol)
{
	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
	struct via_spec *spec = codec->spec;
	return snd_hda_ch_mode_get(codec, ucontrol, spec->channel_mode,
				   spec->num_channel_mode,
				   spec->ext_channel_count);
}

static int via_ch_mode_put(struct snd_kcontrol *kcontrol,
			   struct snd_ctl_elem_value *ucontrol)
{
	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
	struct via_spec *spec = codec->spec;
	int err = snd_hda_ch_mode_put(codec, ucontrol, spec->channel_mode,
				      spec->num_channel_mode,
				      &spec->ext_channel_count);
	if (err >= 0 && !spec->const_channel_count) {
		spec->multiout.max_channels = spec->ext_channel_count;
	}
	activate_ctl(spec->codec, "Side Playback Volume",
			spec->multiout.max_channels == 8);
	activate_ctl(spec->codec, "Side Playback Switch",
			spec->multiout.max_channels == 8);
	return err;
}

static const struct hda_verb vt1718S_6ch_init[] = {
	{ 0x2a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN },
	{ } /* end */
};

static const struct hda_verb vt1718S_8ch_init[] = {
	{ 0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)},
	{ 0x2a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
	{ 0x2a, AC_VERB_SET_CONNECT_SEL, 0x01 },
	{ } /* end */
};

static const struct hda_channel_mode vt1718S_modes[2] = {
	{ 6, vt1718S_6ch_init },
	{ 8, vt1718S_8ch_init },
};

static const struct snd_kcontrol_new vt1718S_chmode_mixer[] = {
	{
		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
		.name = "Channel Mode",
		.info = via_ch_mode_info,
		.get = via_ch_mode_get,
		.put = via_ch_mode_put,
	},
	{ }
};





/* add playback controls from the parsed DAC table */
static int vt1718S_auto_create_multi_out_ctls(struct via_spec *spec,
					     const struct auto_pin_cfg *cfg)
{


...
	if (spec->autocfg.line_outs == 3) {  /* and 0x2a can be retask as output pin */
		nid_vol = 0xc;
		nid_mute = 0x2a;
		err = via_add_control(
			spec, VIA_CTL_WIDGET_VOL, "Side Playback Volume",
			HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0, HDA_OUTPUT));
		if (err < 0)
			return err;
		err = via_add_control(
			spec, VIA_CTL_WIDGET_MUTE, "Side Playback Switch",
			HDA_COMPOSE_AMP_VAL(nid_mute, 3, 0,
					    HDA_OUTPUT));
		if (err < 0)
			return err;

		spec->private_dac_nids[AUTO_SEQ_SIDE] = nid_vol;
		spec->const_channel_count = 6;
                spec->channel_mode = vt1718S_modes;
                spec->num_channel_mode = ARRAY_SIZE(vt1718S_modes);
		spec->mixers[spec->num_mixers] = vt1718S_chmode_mixer;
		spec->num_mixers++;
	}
}
