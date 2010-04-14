From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: Re: [PATCH] ALSA: hda - via - fix master mute and
	automute with VT1812/VT2002P
Date: Wed, 14 Apr 2010 15:01:36 -0300
Message-ID: <201004141501.36930.herton@mandriva.com.br>
References: <201004131538.53860.herton@mandriva.com.br>
	<s5h633uyzln.wl%tiwai@suse.de> <s5hwrwaxic5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id A45992453C
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 20:01:41 +0200 (CEST)
In-Reply-To: <s5hwrwaxic5.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Em Qua 14 Abr 2010, =E0s 10:40:58, Takashi Iwai escreveu:
> At Wed, 14 Apr 2010 14:42:44 +0200,
> I wrote:
> > =

> > At Tue, 13 Apr 2010 15:38:53 -0300,
> > Herton Ronaldo Krzesinski wrote:
> > > =

> > > On VIA VT1812/VT2002P, the "Master Front Playback Switch" doesn't mute
> > > first line-out. This is an issue, for example I saw a laptop with VT1=
812
> > > and only one line-out (main speaker) that doesn't mute main speaker,
> > > because the master switch doesn't act on first line-out, and first
> > > line-out nid in array is assigned to speaker as expected by autoconfig
> > > code.
> > > =

> > > But there is one more issue also: main switches and automute code deal
> > > with mute on same Amp-Outs, which can cause conflicts, thus if you mu=
te
> > > "Master Front Playback Switch" and remove headphone for example, it w=
ill
> > > not respect the mixer setting. To solve it, we can change the pin type
> > > instead of muting Amp-Out, which is done here.
> > =

> > The problem is rather that "Master Front" is a misleading name.
> > "Master Front" volume control exists for other VIA codecs because there
> > is another "Front" volume that is assigned to a pin widget.
> > So, this "Master" isn't really a master control.
> > =

> > IMO, a better way would be to rename this "Master Front" to either a
> > pin-specific one ("Speaker", etc), and make a vmaster control to bind
> > both this and headphone controls, like other codecs.
> > =

> > I'm going to try to implement it...
> =

> Something like below.
> =

> BTW, I fixed another bugs in patch_via.c, which should go to 2.6.34.
> They are included in the latest sound git tree or alsa-driver
> snapshot.

Hi Takashi,

I was testing with 2.6.33. Now I built and tested latest sound-2.6 tree with
your patch below, but still the problem exists. It now creates virtual mast=
er
control, but it does nothing because it doesn't mute speaker pin. Also there
is still the problem that the automute code conflicts with master control. I
agree that it was needing the virtual master control, and should need create
control for speaker, which it now does, just the mute switch points to wrong
nid. I made following diff on top of yours to fix the issues:

diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index 0f1d221..c7bd441 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -300,8 +300,6 @@ static int analog_input_switch_put(struct snd_kcontrol =
*kcontrol,
 			.put =3D analog_input_switch_put,			\
 			.private_value =3D HDA_COMPOSE_AMP_VAL(0, 3, 0, 0) }
 =

-static void via_hp_bind_automute(struct hda_codec *codec);
-
 static int bind_pin_switch_put(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
@@ -348,9 +346,6 @@ static int bind_pin_switch_put(struct snd_kcontrol *kco=
ntrol,
 			snd_hda_codec_amp_stereo(
 				codec, spec->autocfg.speaker_pins[i],
 				HDA_OUTPUT, 0, HDA_AMP_MUTE, 0);
-		/* unmute */
-		via_hp_bind_automute(codec);
-
 	} else {
 		if (lmute) {
 			/* Mute all left channels */
@@ -2190,18 +2185,18 @@ static void via_hp_bind_automute(struct hda_codec *=
codec)
 	if (!spec->hp_independent_mode) {
 		/* Mute Line-Outs */
 		for (i =3D 0; i < spec->autocfg.line_outs; i++)
-			snd_hda_codec_amp_stereo(
-				codec, spec->autocfg.line_out_pins[i],
-				HDA_OUTPUT, 0,
-				HDA_AMP_MUTE, hp_present ? HDA_AMP_MUTE : 0);
+			snd_hda_codec_write(codec,
+					    spec->autocfg.line_out_pins[i],
+					    0, AC_VERB_SET_PIN_WIDGET_CONTROL,
+					    hp_present ? 0 : PIN_OUT);
 		if (hp_present)
 			present =3D hp_present;
 	}
 	/* Speakers */
 	for (i =3D 0; i < spec->autocfg.speaker_outs; i++)
-		snd_hda_codec_amp_stereo(
-			codec, spec->autocfg.speaker_pins[i], HDA_OUTPUT, 0,
-			HDA_AMP_MUTE, present ? HDA_AMP_MUTE : 0);
+		snd_hda_codec_write(codec, spec->autocfg.speaker_pins[i], 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL,
+				    present ? 0 : PIN_OUT);
 }
 =

 =

@@ -4414,7 +4409,8 @@ static int vt1702_auto_create_line_out_ctls(struct vi=
a_spec *spec,
 		return err;
 	sprintf(name, "%s Playback Switch", get_line_out_label(cfg, 1));
 	err =3D via_add_control(spec, VIA_CTL_WIDGET_MUTE, name,
-			      HDA_COMPOSE_AMP_VAL(0x16, 3, 0, HDA_OUTPUT));
+			      HDA_COMPOSE_AMP_VAL(cfg->line_out_pins[0],
+						  3, 0, HDA_OUTPUT));
 	if (err < 0)
 		return err;
 =

@@ -5679,8 +5675,9 @@ static int vt2002P_auto_create_multi_out_ctls(struct =
via_spec *spec,
 	if (err < 0)
 		return err;
 	sprintf(name, "%s Playback Switch", get_line_out_label(cfg, 1));
-	err =3D via_add_control(spec, VIA_CTL_WIDGET_BIND_PIN_MUTE, name,
-			      HDA_COMPOSE_AMP_VAL(0x26, 3, 0, HDA_OUTPUT));
+	err =3D via_add_control(spec, VIA_CTL_WIDGET_MUTE, name,
+			      HDA_COMPOSE_AMP_VAL(cfg->line_out_pins[0],
+						  3, 0, HDA_OUTPUT));
 	if (err < 0)
 		return err;
 =

@@ -6032,8 +6029,9 @@ static int vt1812_auto_create_multi_out_ctls(struct v=
ia_spec *spec,
 	if (err < 0)
 		return err;
 	sprintf(name, "%s Playback Switch", get_line_out_label(cfg, 1));
-	err =3D via_add_control(spec, VIA_CTL_WIDGET_BIND_PIN_MUTE, name,
-			      HDA_COMPOSE_AMP_VAL(0x28, 3, 0, HDA_OUTPUT));
+	err =3D via_add_control(spec, VIA_CTL_WIDGET_MUTE, name,
+			      HDA_COMPOSE_AMP_VAL(cfg->line_out_pins[0],
+						  3, 0, HDA_OUTPUT));
 	if (err < 0)
 		return err;
 =

@@ -6050,6 +6048,7 @@ static int vt1812_auto_create_hp_ctls(struct via_spec=
 *spec, hda_nid_t pin)
 	spec->multiout.hp_nid =3D 0x9;
 	spec->hp_independent_mode_index =3D 1;
 =

+	/* FIXME: check that we really have hp pin connected to hp_nid */
 =

 	err =3D via_add_control(spec, VIA_CTL_WIDGET_VOL,
 			      "Headphone Playback Volume",


So, the following problems are fixed by above:
- Speaker mute switch pointing to wrong nid (via_add_control change on
*auto_create_multi_out_ctls, I changed for vt2002p/vt1702 also, which seems
to need same change
- switch to pin type switch for automute as mixer controls already deals wi=
th
same amp-outs and cause conflict
- Remove use of VIA_CTL_WIDGET_BIND_PIN_MUTE, replace to VIA_CTL_WIDGET_MUT=
E,
since it's uneeded now with virtual master control addition (otherwise when=
 you
mute speaker on mixer, instead of muting just speaker it mutes all outputs.=
..
because of bind_pin_switch_put function
I think we should remove VIA_CTL_WIDGET_BIND_PIN_MUTE and related code?)

And I noticed a problem with headphone volume mixer setting:
- TODO (FIXME comment I added): removal of independent hp missed code addit=
ion
for automatically make hp_nid to receive audio from Audio Output 0x9, we mu=
st
check in codec that audio selector before hp pin selects nid 0x09, by defau=
lt
it's 0x08 which is selected, and headphone volume slider doesn't have any
effect, as acts on 0x09 audio output.

Please comment on those.

> =

> Give it a try.
> =

> =

> thanks,
> =

> Takashi
> =

> ---
> diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
> index 7345381..0f1d221 100644
> --- a/sound/pci/hda/patch_via.c
> +++ b/sound/pci/hda/patch_via.c
> @@ -157,6 +157,11 @@ struct via_spec {
>  #ifdef CONFIG_SND_HDA_POWER_SAVE
>  	struct hda_loopback_check loopback;
>  #endif
> +
> +	/* for virtual master */
> +	hda_nid_t vmaster_nid;
> +	const char **slave_vols;
> +	const char **slave_sws;
>  };
>  =

>  static struct via_spec * via_new_spec(struct hda_codec *codec)
> @@ -1881,11 +1886,35 @@ static struct hda_pcm_stream vt1708_pcm_digital_c=
apture =3D {
>  	.channels_max =3D 2,
>  };
>  =

> +/*
> + * slave controls for virtual master
> + */
> +static const char *via_slave_vols[] =3D {
> +	"Front Playback Volume",
> +	"Surround Playback Volume",
> +	"Center Playback Volume",
> +	"LFE Playback Volume",
> +	"Side Playback Volume",
> +	"Headphone Playback Volume",
> +	NULL,
> +};
> +
> +static const char *via_slave_sws[] =3D {
> +	"Front Playback Switch",
> +	"Surround Playback Switch",
> +	"Center Playback Switch",
> +	"LFE Playback Switch",
> +	"Side Playback Switch",
> +	"Headphone Playback Switch",
> +	NULL,
> +};
> +
>  static int via_build_controls(struct hda_codec *codec)
>  {
>  	struct via_spec *spec =3D codec->spec;
>  	struct snd_kcontrol *kctl;
>  	struct snd_kcontrol_new *knew;
> +	const char **slave;
>  	int err, i;
>  =

>  	for (i =3D 0; i < spec->num_mixers; i++) {
> @@ -1911,6 +1940,31 @@ static int via_build_controls(struct hda_codec *co=
dec)
>  			return err;
>  	}
>  =

> +	/* if we have no master control, let's create it */
> +	if (!snd_hda_find_mixer_ctl(codec, "Master Playback Volume")) {
> +		unsigned int vmaster_tlv[4];
> +		snd_hda_set_vmaster_tlv(codec, spec->vmaster_nid,
> +					HDA_OUTPUT, vmaster_tlv);
> +		if (spec->slave_vols)
> +			slave =3D spec->slave_vols;
> +		else
> +			slave =3D via_slave_vols;
> +		err =3D snd_hda_add_vmaster(codec, "Master Playback Volume",
> +					  vmaster_tlv, slave);
> +		if (err < 0)
> +			return err;
> +	}
> +	if (!snd_hda_find_mixer_ctl(codec, "Master Playback Switch")) {
> +		if (spec->slave_vols)
> +			slave =3D spec->slave_sws;
> +		else
> +			slave =3D via_slave_sws;
> +		err =3D snd_hda_add_vmaster(codec, "Master Playback Switch",
> +					  NULL, slave);
> +		if (err < 0)
> +			return err;
> +	}
> +
>  	/* assign Capture Source enums to NID */
>  	kctl =3D snd_hda_find_mixer_ctl(codec, "Input Source");
>  	for (i =3D 0; kctl && i < kctl->count; i++) {
> @@ -2268,6 +2322,19 @@ static int vt1708_auto_fill_dac_nids(struct via_sp=
ec *spec,
>  	return 0;
>  }
>  =

> +static const char *get_line_out_label(const struct auto_pin_cfg *cfg,
> +				      int can_be_master)
> +{
> +	if (can_be_master && !cfg->speaker_pins[0] && !cfg->hp_pins[0])
> +		return "Master";
> +	else if (cfg->line_out_type =3D=3D AUTO_PIN_SPEAKER_OUT)
> +		return "Speaker";
> +	else if (cfg->line_out_type =3D=3D AUTO_PIN_HP_OUT)
> +		return "Headphone";
> +	else
> +		return "Line-Out";
> +}
> +
>  /* add playback controls from the parsed DAC table */
>  static int vt1708_auto_create_multi_out_ctls(struct via_spec *spec,
>  					     const struct auto_pin_cfg *cfg)
> @@ -2311,44 +2378,36 @@ static int vt1708_auto_create_multi_out_ctls(stru=
ct via_spec *spec,
>  								  HDA_OUTPUT));
>  			if (err < 0)
>  				return err;
> -		} else if (i =3D=3D AUTO_SEQ_FRONT) {
> -			/* add control to mixer index 0 */
> -			err =3D via_add_control(spec, VIA_CTL_WIDGET_VOL,
> -					      "Master Front Playback Volume",
> -					      HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
> -								  HDA_INPUT));
> -			if (err < 0)
> -				return err;
> -			err =3D via_add_control(spec, VIA_CTL_WIDGET_MUTE,
> -					      "Master Front Playback Switch",
> -					      HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
> -								  HDA_INPUT));
> -			if (err < 0)
> -				return err;
> -
> -			/* add control to PW3 */
> +		} else {
> +			if (!spec->vmaster_nid)
> +				spec->vmaster_nid =3D nid_vol;
>  			sprintf(name, "%s Playback Volume", chname[i]);
>  			err =3D via_add_control(spec, VIA_CTL_WIDGET_VOL, name,
> -					      HDA_COMPOSE_AMP_VAL(nid, 3, 0,
> +					      HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
>  								  HDA_OUTPUT));
>  			if (err < 0)
>  				return err;
>  			sprintf(name, "%s Playback Switch", chname[i]);
>  			err =3D via_add_control(spec, VIA_CTL_WIDGET_MUTE, name,
> -					      HDA_COMPOSE_AMP_VAL(nid, 3, 0,
> +					      HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
>  								  HDA_OUTPUT));
>  			if (err < 0)
>  				return err;
> -		} else {
> -			sprintf(name, "%s Playback Volume", chname[i]);
> +			if (i !=3D AUTO_SEQ_FRONT)
> +				continue;
> +
> +			/* add control to PW3 */
> +			sprintf(name, "%s Playback Volume",
> +				get_line_out_label(cfg, 0));
>  			err =3D via_add_control(spec, VIA_CTL_WIDGET_VOL, name,
> -					      HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
> +					      HDA_COMPOSE_AMP_VAL(nid, 3, 0,
>  								  HDA_OUTPUT));
>  			if (err < 0)
>  				return err;
> -			sprintf(name, "%s Playback Switch", chname[i]);
> +			sprintf(name, "%s Playback Switch",
> +				get_line_out_label(cfg, 0));
>  			err =3D via_add_control(spec, VIA_CTL_WIDGET_MUTE, name,
> -					      HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
> +					      HDA_COMPOSE_AMP_VAL(nid, 3, 0,
>  								  HDA_OUTPUT));
>  			if (err < 0)
>  				return err;
> @@ -2923,35 +2982,9 @@ static int vt1709_auto_create_multi_out_ctls(struc=
t via_spec *spec,
>  								  HDA_OUTPUT));
>  			if (err < 0)
>  				return err;
> -		} else if (i =3D=3D AUTO_SEQ_FRONT) {
> -			/* ADD control to mixer index 0 */
> -			err =3D via_add_control(spec, VIA_CTL_WIDGET_VOL,
> -					      "Master Front Playback Volume",
> -					      HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
> -								  HDA_INPUT));
> -			if (err < 0)
> -				return err;
> -			err =3D via_add_control(spec, VIA_CTL_WIDGET_MUTE,
> -					      "Master Front Playback Switch",
> -					      HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
> -								  HDA_INPUT));
> -			if (err < 0)
> -				return err;
> -
> -			/* add control to PW3 */
> -			sprintf(name, "%s Playback Volume", chname[i]);
> -			err =3D via_add_control(spec, VIA_CTL_WIDGET_VOL, name,
> -					      HDA_COMPOSE_AMP_VAL(nid, 3, 0,
> -								  HDA_OUTPUT));
> -			if (err < 0)
> -				return err;
> -			sprintf(name, "%s Playback Switch", chname[i]);
> -			err =3D via_add_control(spec, VIA_CTL_WIDGET_MUTE, name,
> -					      HDA_COMPOSE_AMP_VAL(nid, 3, 0,
> -								  HDA_OUTPUT));
> -			if (err < 0)
> -				return err;
> -		} else if (i =3D=3D AUTO_SEQ_SURROUND) {
> +		} else {
> +			if (!spec->vmaster_nid)
> +				spec->vmaster_nid =3D nid_vol;
>  			sprintf(name, "%s Playback Volume", chname[i]);
>  			err =3D via_add_control(spec, VIA_CTL_WIDGET_VOL, name,
>  					      HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
> @@ -2964,16 +2997,21 @@ static int vt1709_auto_create_multi_out_ctls(stru=
ct via_spec *spec,
>  								  HDA_OUTPUT));
>  			if (err < 0)
>  				return err;
> -		} else if (i =3D=3D AUTO_SEQ_SIDE) {
> -			sprintf(name, "%s Playback Volume", chname[i]);
> +			if (i !=3D AUTO_SEQ_FRONT)
> +				continue;
> +
> +			/* add control to PW3 */
> +			sprintf(name, "%s Playback Volume",
> +				get_line_out_label(cfg, 0));
>  			err =3D via_add_control(spec, VIA_CTL_WIDGET_VOL, name,
> -					      HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
> +					      HDA_COMPOSE_AMP_VAL(nid, 3, 0,
>  								  HDA_OUTPUT));
>  			if (err < 0)
>  				return err;
> -			sprintf(name, "%s Playback Switch", chname[i]);
> +			sprintf(name, "%s Playback Volume",
> +				get_line_out_label(cfg, 0));
>  			err =3D via_add_control(spec, VIA_CTL_WIDGET_MUTE, name,
> -					      HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
> +					      HDA_COMPOSE_AMP_VAL(nid, 3, 0,
>  								  HDA_OUTPUT));
>  			if (err < 0)
>  				return err;
> @@ -3504,44 +3542,36 @@ static int vt1708B_auto_create_multi_out_ctls(str=
uct via_spec *spec,
>  								  HDA_OUTPUT));
>  			if (err < 0)
>  				return err;
> -		} else if (i =3D=3D AUTO_SEQ_FRONT) {
> -			/* add control to mixer index 0 */
> -			err =3D via_add_control(spec, VIA_CTL_WIDGET_VOL,
> -					      "Master Front Playback Volume",
> -					      HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
> -								  HDA_INPUT));
> -			if (err < 0)
> -				return err;
> -			err =3D via_add_control(spec, VIA_CTL_WIDGET_MUTE,
> -					      "Master Front Playback Switch",
> -					      HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
> -								  HDA_INPUT));
> -			if (err < 0)
> -				return err;
> -
> -			/* add control to PW3 */
> +		} else {
> +			if (!spec->vmaster_nid)
> +				spec->vmaster_nid =3D nid_vol;
>  			sprintf(name, "%s Playback Volume", chname[i]);
>  			err =3D via_add_control(spec, VIA_CTL_WIDGET_VOL, name,
> -					      HDA_COMPOSE_AMP_VAL(nid, 3, 0,
> +					      HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
>  								  HDA_OUTPUT));
>  			if (err < 0)
>  				return err;
>  			sprintf(name, "%s Playback Switch", chname[i]);
>  			err =3D via_add_control(spec, VIA_CTL_WIDGET_MUTE, name,
> -					      HDA_COMPOSE_AMP_VAL(nid, 3, 0,
> +					      HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
>  								  HDA_OUTPUT));
>  			if (err < 0)
>  				return err;
> -		} else {
> -			sprintf(name, "%s Playback Volume", chname[i]);
> +			if (i !=3D AUTO_SEQ_FRONT)
> +				continue;
> +
> +			/* add control to PW3 */
> +			sprintf(name, "%s Playback Volume",
> +				get_line_out_label(cfg, 0));
>  			err =3D via_add_control(spec, VIA_CTL_WIDGET_VOL, name,
> -					      HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
> +					      HDA_COMPOSE_AMP_VAL(nid, 3, 0,
>  								  HDA_OUTPUT));
>  			if (err < 0)
>  				return err;
> -			sprintf(name, "%s Playback Switch", chname[i]);
> +			sprintf(name, "%s Playback Volume",
> +				get_line_out_label(cfg, 0));
>  			err =3D via_add_control(spec, VIA_CTL_WIDGET_MUTE, name,
> -					      HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
> +					      HDA_COMPOSE_AMP_VAL(nid, 3, 0,
>  								  HDA_OUTPUT));
>  			if (err < 0)
>  				return err;
> @@ -3966,22 +3996,9 @@ static int vt1708S_auto_create_multi_out_ctls(stru=
ct via_spec *spec,
>  								  HDA_OUTPUT));
>  			if (err < 0)
>  				return err;
> -		} else if (i =3D=3D AUTO_SEQ_FRONT) {
> -			/* add control to mixer index 0 */
> -			err =3D via_add_control(spec, VIA_CTL_WIDGET_VOL,
> -					      "Master Front Playback Volume",
> -					      HDA_COMPOSE_AMP_VAL(0x16, 3, 0,
> -								  HDA_INPUT));
> -			if (err < 0)
> -				return err;
> -			err =3D via_add_control(spec, VIA_CTL_WIDGET_MUTE,
> -					      "Master Front Playback Switch",
> -					      HDA_COMPOSE_AMP_VAL(0x16, 3, 0,
> -								  HDA_INPUT));
> -			if (err < 0)
> -				return err;
> -
> -			/* Front */
> +		} else {
> +			if (!spec->vmaster_nid)
> +				spec->vmaster_nid =3D nid_vol;
>  			sprintf(name, "%s Playback Volume", chname[i]);
>  			err =3D via_add_control(spec, VIA_CTL_WIDGET_VOL, name,
>  					      HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
> @@ -3995,14 +4012,18 @@ static int vt1708S_auto_create_multi_out_ctls(str=
uct via_spec *spec,
>  								  HDA_OUTPUT));
>  			if (err < 0)
>  				return err;
> -		} else {
> -			sprintf(name, "%s Playback Volume", chname[i]);
> +			if (i !=3D AUTO_SEQ_FRONT)
> +				continue;
> +
> +			sprintf(name, "%s Playback Volume",
> +				get_line_out_label(cfg, 0));
>  			err =3D via_add_control(spec, VIA_CTL_WIDGET_VOL, name,
>  					      HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0,
>  								  HDA_OUTPUT));
>  			if (err < 0)
>  				return err;
> -			sprintf(name, "%s Playback Switch", chname[i]);
> +			sprintf(name, "%s Playback Volume",
> +				get_line_out_label(cfg, 0));
>  			err =3D via_add_control(spec, VIA_CTL_WIDGET_MUTE, name,
>  					      HDA_COMPOSE_AMP_VAL(nid_mute,
>  								  3, 0,
> @@ -4366,31 +4387,33 @@ static int vt1702_auto_fill_dac_nids(struct via_s=
pec *spec,
>  static int vt1702_auto_create_line_out_ctls(struct via_spec *spec,
>  					     const struct auto_pin_cfg *cfg)
>  {
> +	char name[32];
>  	int err;
>  =

>  	if (!cfg->line_out_pins[0])
>  		return -1;
>  =

> +	spec->vmaster_nid =3D 0x1a;
>  	/* add control to mixer index 0 */
>  	err =3D via_add_control(spec, VIA_CTL_WIDGET_VOL,
> -			      "Master Front Playback Volume",
> +			      "Front Playback Volume",
>  			      HDA_COMPOSE_AMP_VAL(0x1A, 3, 0, HDA_INPUT));
>  	if (err < 0)
>  		return err;
>  	err =3D via_add_control(spec, VIA_CTL_WIDGET_MUTE,
> -			      "Master Front Playback Switch",
> +			      "Front Playback Switch",
>  			      HDA_COMPOSE_AMP_VAL(0x1A, 3, 0, HDA_INPUT));
>  	if (err < 0)
>  		return err;
>  =

>  	/* Front */
> -	err =3D via_add_control(spec, VIA_CTL_WIDGET_VOL,
> -			      "Front Playback Volume",
> +	sprintf(name, "%s Playback Volume", get_line_out_label(cfg, 1));
> +	err =3D via_add_control(spec, VIA_CTL_WIDGET_VOL, name,
>  			      HDA_COMPOSE_AMP_VAL(0x10, 3, 0, HDA_OUTPUT));
>  	if (err < 0)
>  		return err;
> -	err =3D via_add_control(spec, VIA_CTL_WIDGET_MUTE,
> -			      "Front Playback Switch",
> +	sprintf(name, "%s Playback Switch", get_line_out_label(cfg, 1));
> +	err =3D via_add_control(spec, VIA_CTL_WIDGET_MUTE, name,
>  			      HDA_COMPOSE_AMP_VAL(0x16, 3, 0, HDA_OUTPUT));
>  	if (err < 0)
>  		return err;
> @@ -4793,22 +4816,9 @@ static int vt1718S_auto_create_multi_out_ctls(stru=
ct via_spec *spec,
>  						    HDA_OUTPUT));
>  			if (err < 0)
>  				return err;
> -		} else if (i =3D=3D AUTO_SEQ_FRONT) {
> -			/* Front */
> -			sprintf(name, "%s Playback Volume", chname[i]);
> -			err =3D via_add_control(
> -				spec, VIA_CTL_WIDGET_VOL, name,
> -				HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0, HDA_OUTPUT));
> -			if (err < 0)
> -				return err;
> -			sprintf(name, "%s Playback Switch", chname[i]);
> -			err =3D via_add_control(
> -				spec, VIA_CTL_WIDGET_MUTE, name,
> -				HDA_COMPOSE_AMP_VAL(nid_mute, 3, 0,
> -						    HDA_OUTPUT));
> -			if (err < 0)
> -				return err;
>  		} else {
> +			if (!spec->vmaster_nid)
> +				spec->vmaster_nid =3D nid_vol;
>  			sprintf(name, "%s Playback Volume", chname[i]);
>  			err =3D via_add_control(
>  				spec, VIA_CTL_WIDGET_VOL, name,
> @@ -5279,21 +5289,9 @@ static int vt1716S_auto_create_multi_out_ctls(stru=
ct via_spec *spec,
>  						    HDA_OUTPUT));
>  			if (err < 0)
>  				return err;
> -		} else if (i =3D=3D AUTO_SEQ_FRONT) {
> -
> -			err =3D via_add_control(
> -				spec, VIA_CTL_WIDGET_VOL,
> -				"Master Front Playback Volume",
> -				HDA_COMPOSE_AMP_VAL(0x16, 3, 0, HDA_INPUT));
> -			if (err < 0)
> -				return err;
> -			err =3D via_add_control(
> -				spec, VIA_CTL_WIDGET_MUTE,
> -				"Master Front Playback Switch",
> -				HDA_COMPOSE_AMP_VAL(0x16, 3, 0, HDA_INPUT));
> -			if (err < 0)
> -				return err;
> -
> +		} else {
> +			if (!spec->vmaster_nid)
> +				spec->vmaster_nid =3D nid_vol;
>  			sprintf(name, "%s Playback Volume", chname[i]);
>  			err =3D via_add_control(
>  				spec, VIA_CTL_WIDGET_VOL, name,
> @@ -5307,18 +5305,19 @@ static int vt1716S_auto_create_multi_out_ctls(str=
uct via_spec *spec,
>  						    HDA_OUTPUT));
>  			if (err < 0)
>  				return err;
> -		} else {
> -			sprintf(name, "%s Playback Volume", chname[i]);
> -			err =3D via_add_control(
> -				spec, VIA_CTL_WIDGET_VOL, name,
> -				HDA_COMPOSE_AMP_VAL(nid_vol, 3, 0, HDA_OUTPUT));
> +			if (i !=3D AUTO_SEQ_FRONT)
> +				continue;
> +
> +			sprintf(name, "%s Playback Volume",
> +				get_line_out_label(cfg, 0));
> +			err =3D via_add_control(spec, VIA_CTL_WIDGET_VOL, name,
> +				HDA_COMPOSE_AMP_VAL(0x16, 3, 0, HDA_INPUT));
>  			if (err < 0)
>  				return err;
> -			sprintf(name, "%s Playback Switch", chname[i]);
> -			err =3D via_add_control(
> -				spec, VIA_CTL_WIDGET_MUTE, name,
> -				HDA_COMPOSE_AMP_VAL(nid_mute, 3, 0,
> -						    HDA_OUTPUT));
> +			sprintf(name, "%s Playback Switch",
> +				get_line_out_label(cfg, 0));
> +			err =3D via_add_control(spec, VIA_CTL_WIDGET_MUTE, name,
> +				HDA_COMPOSE_AMP_VAL(0x16, 3, 0, HDA_INPUT));
>  			if (err < 0)
>  				return err;
>  		}
> @@ -5646,24 +5645,41 @@ static int vt2002P_auto_fill_dac_nids(struct via_=
spec *spec,
>  	return 0;
>  }
>  =

> +static const char *vt2002_slave_vols[] =3D {
> +	"Headphone Playback Volume",
> +	"Speaker Playback Volume",
> +	"Line-Out Playback Volume",
> +	NULL,
> +};
> +
> +static const char *vt2002_slave_sws[] =3D {
> +	"Headphone Playback Switch",
> +	"Speaker Playback Switch",
> +	"Line-Out Playback Switch",
> +	NULL,
> +};
> +
>  /* add playback controls from the parsed DAC table */
>  static int vt2002P_auto_create_multi_out_ctls(struct via_spec *spec,
>  					     const struct auto_pin_cfg *cfg)
>  {
> +	char name[32];
>  	int err;
>  =

>  	if (!cfg->line_out_pins[0])
>  		return -1;
>  =

> -
> +	spec->vmaster_nid =3D 0x08;
> +	spec->slave_vols =3D vt2002_slave_vols;
> +	spec->slave_sws =3D vt2002_slave_sws;
>  	/* Line-Out: PortE */
> -	err =3D via_add_control(spec, VIA_CTL_WIDGET_VOL,
> -			      "Master Front Playback Volume",
> +	sprintf(name, "%s Playback Volume", get_line_out_label(cfg, 1));
> +	err =3D via_add_control(spec, VIA_CTL_WIDGET_VOL, name,
>  			      HDA_COMPOSE_AMP_VAL(0x8, 3, 0, HDA_OUTPUT));
>  	if (err < 0)
>  		return err;
> -	err =3D via_add_control(spec, VIA_CTL_WIDGET_BIND_PIN_MUTE,
> -			      "Master Front Playback Switch",
> +	sprintf(name, "%s Playback Switch", get_line_out_label(cfg, 1));
> +	err =3D via_add_control(spec, VIA_CTL_WIDGET_BIND_PIN_MUTE, name,
>  			      HDA_COMPOSE_AMP_VAL(0x26, 3, 0, HDA_OUTPUT));
>  	if (err < 0)
>  		return err;
> @@ -6000,19 +6016,23 @@ static int vt1812_auto_fill_dac_nids(struct via_s=
pec *spec,
>  static int vt1812_auto_create_multi_out_ctls(struct via_spec *spec,
>  					     const struct auto_pin_cfg *cfg)
>  {
> +	char name[32];
>  	int err;
>  =

>  	if (!cfg->line_out_pins[0])
>  		return -1;
>  =

> +	spec->vmaster_nid =3D 0x08;
> +	spec->slave_vols =3D vt2002_slave_vols;
> +	spec->slave_sws =3D vt2002_slave_sws;
>  	/* Line-Out: PortE */
> -	err =3D via_add_control(spec, VIA_CTL_WIDGET_VOL,
> -			      "Front Playback Volume",
> +	sprintf(name, "%s Playback Volume", get_line_out_label(cfg, 1));
> +	err =3D via_add_control(spec, VIA_CTL_WIDGET_VOL, name,
>  			      HDA_COMPOSE_AMP_VAL(0x8, 3, 0, HDA_OUTPUT));
>  	if (err < 0)
>  		return err;
> -	err =3D via_add_control(spec, VIA_CTL_WIDGET_BIND_PIN_MUTE,
> -			      "Front Playback Switch",
> +	sprintf(name, "%s Playback Switch", get_line_out_label(cfg, 1));
> +	err =3D via_add_control(spec, VIA_CTL_WIDGET_BIND_PIN_MUTE, name,
>  			      HDA_COMPOSE_AMP_VAL(0x28, 3, 0, HDA_OUTPUT));
>  	if (err < 0)
>  		return err;
> =


-- =

[]'s
Herton
