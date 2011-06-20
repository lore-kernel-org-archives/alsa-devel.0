From: alex dot baldacchino dot alsasub at gmail dot com
	<alex.baldacchino.alsasub@gmail.com>
Subject: Re: Via VT2020: issues with kernel 2.6.38.{2,
 3} (alsa 1.0.23) - working with 2.6.33.2 (alsa 1.0.21)
Date: Mon, 20 Jun 2011 03:19:49 +0200
Message-ID: <BANLkTi=t6--XhAwBBQ7saOj=qswbiOj+cQ@mail.gmail.com>
References: <BANLkTi=9d5A+oa6Bh+fis4+WY=xNbbnkYw@mail.gmail.com>
	<BANLkTi=i+3CJLtY-1OtkFnvrzWz4+=d=VA@mail.gmail.com>
	<BANLkTimUVPCHzyASs3s0MtNV1DNKS0BfzA@mail.gmail.com>
	<BANLkTikcUZESFMF-Y30jLJ889nCLEBwNhA@mail.gmail.com>
	<BANLkTikxTsM6FUSQcZjwzcMAveJd_uS68g@mail.gmail.com>
	<BANLkTi=vxO-9KqP158AtkQozOjfqzVp_EA@mail.gmail.com>
	<BANLkTimR1_tT57o7iLbv4_QdirNbUORbfA@mail.gmail.com>
	<BANLkTi=tKPpmn0D8-Bj1NYbXSkcOveO99g@mail.gmail.com>
	<BANLkTi=-dE0hvTN96yCvdNzsM59MY=csfA@mail.gmail.com>
	<BANLkTinwNT_bbvSkd5Q106c9SoEmPURzng@mail.gmail.com>
	<BANLkTimJb-UMD5Nk3d+_GW-b9Cir13PjMw@mail.gmail.com>
	<BANLkTindBqVQhAVJukt6Ekbfwu+9pUYhdg@mail.gmail.com>
	<BANLkTime=EgRduJaUYpDB=E08=e7Zn+rMg@mail.gmail.com>
	<BANLkTi=e2L+XDj51KQCaBGH4r+_0ST5r+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A2B210381A
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 03:19:50 +0200 (CEST)
Received: by wyb40 with SMTP id 40so275006wyb.38
	for <alsa-devel@alsa-project.org>; Sun, 19 Jun 2011 18:19:49 -0700 (PDT)
In-Reply-To: <BANLkTi=e2L+XDj51KQCaBGH4r+_0ST5r+A@mail.gmail.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/6/19 Raymond Yau <superquad.vortex2@gmail.com>:
> 2011/6/12 alex dot baldacchino dot alsasub at gmail dot com
> <alex.baldacchino.alsasub@gmail.com>:
>> IMPORTANT UPDATE!!!!!
>>
>> Node 0x0b can drive HP! The problem was function
>> set_widgets_power_state_vt1718S() not updating power state for the
>> correct nid, solved as follows:
>>
>>
>> static void set_widgets_power_state_vt1718S(struct hda_codec *codec)
>> {
>> ...
>> =A0 =A0 =A0 =A0if (spec->hp_independent_mode) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* PW4 (28h), MW3 (1bh), MUX1(34h), AOW4 (=
ch) */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* PW4 (28h), MW3 (1bh), MUX1(34h), AOW4 (=
ch) of AOW3 (bh) */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0parm =3D AC_PWRST_D3;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_pin_power_state(codec, 0x28, &parm);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_hda_codec_write(codec, 0x1b, 0,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0A=
C_VERB_SET_POWER_STATE, parm);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_hda_codec_write(codec, 0x34, 0,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0A=
C_VERB_SET_POWER_STATE, parm);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_hda_codec_write(codec, 0xc, 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_hda_codec_write(codec, spec->multiout.=
hp_nid, 0,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0A=
C_VERB_SET_POWER_STATE, parm);
>> =A0 =A0 =A0 =A0}
>>
>
> Can your hear the same signal from black and orange jack when you
> playing stereo to hw:0,0,0 ?
>
> if you look at snd_hda_multi_out_analog_prepare() in hda_codec.c,
>
> if mout->no_share_stream=3D0 ,it seem that there is "upmix" feature when
> mout->num_dacs is 4 for those 5 jacks/6 jacks motherboard
>
> i.e. the black and orange jacks can have the same signal as the green jack
>
> =A0 =A0 =A0 =A0/* front */
> =A0 =A0 =A0 =A0snd_hda_codec_setup_stream(codec, nids[HDA_FRONT], stream_=
tag,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0, fo=
rmat);
> =A0 =A0 =A0 =A0if (!mout->no_share_stream &&
> =A0 =A0 =A0 =A0 =A0 =A0mout->hp_nid && mout->hp_nid !=3D nids[HDA_FRONT])
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* headphone out will just decode front le=
ft/right (stereo) */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_hda_codec_setup_stream(codec, mout->hp=
_nid, stream_tag,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 0, format);
> =A0 =A0 =A0 =A0/* extra outputs copied from front */
> =A0 =A0 =A0 =A0for (i =3D 0; i < ARRAY_SIZE(mout->extra_out_nid); i++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!mout->no_share_stream && mout->extra_=
out_nid[i])
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_hda_codec_setup_stream=
(codec,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 mout->extra_out_nid[i],
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 stream_tag, 0, format);
>
> =A0 =A0 =A0 =A0/* surrounds */
> =A0 =A0 =A0 =A0for (i =3D 1; i < mout->num_dacs; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (chs >=3D (i + 1) * 2) /* independent o=
ut */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_hda_codec_setup_stream=
(codec, nids[i], stream_tag,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 i * 2, format);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else if (!mout->no_share_stream) /* copy f=
ront */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_hda_codec_setup_stream=
(codec, nids[i], stream_tag,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 0, format);
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return 0;
> }
>


I fear I cannot test it the best way (I've got a 5.1 system, but have
some 'logistic' problems using it). I've made an attempt by using two
headphones, connected as follows:

1) one to (rear) green jack, one to orange,
2) one to green, one to black,
3) one to orange, one to black,

and played a short two-channels file with aplay -Dhw:0,0,0 stereo.wav
a few times, in each case I was able to here (same) sound from both
headsets.

However, it would seem to me that snd_hda_multi_out_analog_prepare()
is not used by VIA Codecs, instead, some pcm operations are defined
within patch_via.c and used by each codec, e.g.


static const struct hda_pcm_stream vt1718S_pcm_analog_playback =3D {
	.substreams =3D 2,
	.channels_min =3D 2,
	.channels_max =3D 10,
	.nid =3D 0x8, /* NID to query formats and rates */
	.ops =3D {
		.open =3D via_playback_pcm_open,
		.prepare =3D via_playback_multi_pcm_prepare,
		.cleanup =3D via_playback_multi_pcm_cleanup,
		.close =3D via_pcm_open_close,
	},
};


(not all codec use via_pcm_open_close, actually)

None of them calls snd_hda_multi_out_analog_{prepare, cleanup}() for
analog stuff, instead, part of the code in those (general) functions
is reused and modified, and spec->multiout.no_share_stream isn't used,
nor initialized (AFAICT).

By the way, my modification to set_widgets_power_state_vt1718S you've
quoted is due to 0x0b being set to D3 because side is missing:


	/* outputs */
	/* PW3 (27h), MW2 (1ah), AOW3 (bh) */
	parm =3D AC_PWRST_D3;
	set_pin_power_state(codec, 0x27, &parm);
	snd_hda_codec_write(codec, 0x1a, 0, AC_VERB_SET_POWER_STATE, parm);
	snd_hda_codec_write(codec, 0xb, 0, AC_VERB_SET_POWER_STATE, parm);


Since 0x27 is not present, parm is not changed  in
set_pin_power_state() and 0x0b is 'turned off'. Therefore, if 0x0b
must/can be used for independent hp, power state cannot be changed for
a fixed nid, but current value for spec->multiout.hp_nid have to be
used.


By the way, since via_playback_pcm_open() calls
snd_hda_multi_out_analog_open(), which is the last one touching
runtime->hw.channels_max, the problem you pointed out in your previous
mail to report the right number of max channels for a substream,
perhaps, could be solved the following way:

in file hda_codec.c:


/**
-* snd_hda_multi_out_analog_open - open analog outputs
+* snd_hda_multiout_analog_open_set - open analog outputs
 *
 * Open analog outputs and set up the hw-constraints.
 * If the digital outputs can be opened as slave, open the digital
 * outputs, too.
 */
-int snd_hda_multi_out_analog_open(struct hda_codec *codec,
+int snd_hda_multiout_analog_open_set(struct hda_codec *codec,
				  struct hda_multi_out *mout,
				  struct snd_pcm_substream *substream,
-				  struct hda_pcm_stream *hinfo)
+				  struct hda_pcm_stream *hinfo, int max_channels)
{
	struct snd_pcm_runtime *runtime =3D substream->runtime;
-	runtime->hw.channels_max =3D mout->max_channels;
+	if( max_channels > 0 && max_channels <=3D mout->max_channels)
+		runtime->hw.channels_max =3D max_channels;
+	else
+		runtime->hw.channels_max =3D mout->max_channels;
	if (mout->dig_out_nid) {
....

-EXPORT_SYMBOL_HDA(snd_hda_multi_out_analog_open);
+EXPORT_SYMBOL_HDA(snd_hda_multiout_analog_open_set);


+/**
+ * snd_hda_multi_out_analog_open - open analog outputs
+ *
+ * Open analog outputs and set up the hw-constraints.
+ * If the digital outputs can be opened as slave, open the digital
+ * outputs, too.
+ */
+int snd_hda_multi_out_analog_open(struct hda_codec *codec,
+				  struct hda_multi_out *mout,
+				  struct snd_pcm_substream *substream,
+				  struct hda_pcm_stream *hinfo)
+{
+	snd_hda_multiout_analog_open_set( codec, mout, substream, hinfo, 0 );
+}
+EXPORT_SYMBOL_HDA(snd_hda_multi_out_analog_open);


(to avoid breaking compatibility)

in file patch_via.c:


static int via_playback_pcm_open(struct hda_pcm_stream *hinfo,
				 struct hda_codec *codec,
				 struct snd_pcm_substream *substream)
{
	struct via_spec *spec =3D codec->spec;
	int idle =3D substream->pstr->substream_opened =3D=3D 1
		&& substream->ref_count =3D=3D 0;
	analog_low_current_mode(codec, idle);
-	return snd_hda_multi_out_analog_open(codec, &spec->multiout, substream,
-					     hinfo);
+	return snd_hda_multiout_analog_open_set( codec, &spec->multiout, substrea=
m,
+					hinfo, ( substream->number =3D=3D 1 ? 2
+					: spec->multiout.max_channels ) );
}


(substream->number is the same as subdevice, because their matching is
tested in snd_pcm_attach_substream())

However, since the question is more general, and could affect other
hda (and non-hda) codecs/drivers, a careful discussion on the general
design could be needed.


>> but in via_independent_hp_put():
>>
>>
>> =A0 =A0 =A0 =A0unsigned int pinsel =3D ucontrol->value.enumerated.item[0=
];
>> =A0 =A0 =A0 =A0/* Get Independent Mode index of headphone pin widget */
>> =A0 =A0 =A0 =A0spec->hp_independent_mode =3D spec->hp_independent_mode_i=
ndex =3D=3D pinsel
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0? 1 : 0; /* <- TROUBLES! */
>>
>>
>> When turning on Independent HP mode for codec VT1718S, pinsel is 1,
>> when turning it off that's 0, thus, if spec->hp_independent_mode_index
>> is 2, spec->hp_independent_mode is always 0 (condition
>> spec->hp_independent_mode_index =3D=3D pinsel alwyas fails) and
>> corresponding controls can't be activated:
>>
>>
>> =A0 =A0 =A0 =A0/* update HP volume/swtich active state */
>> =A0 =A0 =A0 =A0if (spec->codec_type =3D=3D VT1708S
>> =A0 =A0 =A0 =A0 =A0 =A0|| spec->codec_type =3D=3D VT1702
>> =A0 =A0 =A0 =A0 =A0 =A0|| spec->codec_type =3D=3D VT1718S
>> =A0 =A0 =A0 =A0 =A0 =A0|| spec->codec_type =3D=3D VT1716S
>> =A0 =A0 =A0 =A0 =A0 =A0|| VT2002P_COMPATIBLE(spec)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0activate_ctl(codec, "Headphone Playback V=
olume",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->hp_indepen=
dent_mode);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0activate_ctl(codec, "Headphone Playback S=
witch",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->hp_indepen=
dent_mode);
>> =A0 =A0 =A0 =A0}
>>
>
> if the hp jack can also use "copy front" mode for "redirected headphone"
>
> the driver don't need to disable "Headphone Playback Volume" for those
> 10 channels codecs or change the connection in
> via_independent_hp_put()

But if hp_independent_mode is always 0 because pinsel can never match
hp_independent_mode_index, those controls will _never_ be activated,
at least not by via_independent_hp_put, and, what's worse (as I
think), once via_independent_hp_put is called they'll become inactive,
even if setting the right connection for the "independent mode":


static void activate_ctl(struct hda_codec *codec, const char *name, int act=
ive)
{
	struct snd_kcontrol *ctl =3D snd_hda_find_mixer_ctl(codec, name);
	if (ctl) {
		ctl->vd[0].access &=3D ~SNDRV_CTL_ELEM_ACCESS_INACTIVE;
		ctl->vd[0].access |=3D active
			? 0 : SNDRV_CTL_ELEM_ACCESS_INACTIVE;
		snd_ctl_notify(codec->bus->card,
			       SNDRV_CTL_EVENT_MASK_VALUE, &ctl->id);
	}
}


(active, as passed in by via_independent_hp_put is
spec->hp_independent_mode, which is always set to 0 if
spec->hp_independent_mode_index is 2, therefore the need to set
hp_independent_mode more properly)

Moreover, hp_independent_mode is used by other functions, such as
set_widgets_power_state_vtXXXX(), via_playback_multi_pcm_prepare(),
playback_multi_pcm_prep_0(), via_playback_multi_pcm_cleanup(),
therefore I think that's safer to set it properly, to avoid the risk
of breaking those algorithms counting on its value.

>
> For those 3 jacks motherobard, "channel mode" 6-8 or "Use HP as Side"
> switch may just need tot switch the connection to use 0x0b or 0x0c if
> 0b has =A0"Side Playback Volume" and 0x0c has "Headphone Playback
> Volume"


By the way, if there are 3 line-outs only, I'm selecting 0x0b as
multiout.hp_nid (as suggested by you), and also attaching control
"Headphone Playback Volume" to it:


static int vt1718S_auto_create_hp_ctls(struct via_spec *spec, hda_nid_t pin)
{
...
	err =3D via_add_control(spec, VIA_CTL_WIDGET_VOL,
			      "Headphone Playback Volume",
			   HDA_COMPOSE_AMP_VAL(spec->multiout.hp_nid, 3, 0, HDA_OUTPUT));

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
