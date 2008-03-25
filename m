From: <Mario_Limonciello@Dell.com>
Subject: Re: [PATCH] hda: Add 5.1 support for second headphone
	jack
Date: Tue, 25 Mar 2008 15:41:57 -0500
Message-ID: <1206477717.10969.4.camel@mlimonciello>
References: <47E93D09.6000904@embeddedalley.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3642513847562746101=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com
	[143.166.85.207])
	by alsa0.perex.cz (Postfix) with ESMTP id 74F30244B4
	for <alsa-devel@alsa-project.org>; Tue, 25 Mar 2008 21:42:08 +0100 (CET)
Content-class: urn:content-classes:message
In-Reply-To: <47E93D09.6000904@embeddedalley.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: mranostay@embeddedalley.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Jose_De_La_Rosa@Dell.com
List-Id: alsa-devel@alsa-project.org


--===============3642513847562746101==
Content-Type: multipart/signed;
	protocol="application/pgp-signature";
	micalg=pgp-sha1;
	boundary="=-o0Yz2L9FKMlWYeexpdLS"
Content-class: urn:content-classes:message


--=-o0Yz2L9FKMlWYeexpdLS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Matthew,

I just tested this patch.  It appears the second headphone jack works,
but that switch's functionality doesn't act like "Headphone as Line
Out".  Instead, it acts as "Turn on speakers when headphones are plugged
into the second jack".

Regards,

On Tue, 2008-03-25 at 13:57 -0400, Matthew Ranostay wrote:

> Several 92hd7xxx and STAC9228 laptops have multiple headphone jacks, the =
second headphone jack should
> be used for the 5.1 surround sound. Add support for 'Headphone as Line Ou=
t' switch, which allows it be used
> in 5.1 surround sound.
>=20
> Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
> ---
> diff -r 547e051a88b5 pci/hda/patch_sigmatel.c
> --- a/pci/hda/patch_sigmatel.c	Wed Mar 12 13:12:15 2008 +0100
> +++ b/pci/hda/patch_sigmatel.c	Tue Mar 18 10:45:08 2008 -0400
> @@ -179,6 +179,7 @@ struct sigmatel_spec {
>  	/* i/o switches */
>  	unsigned int io_switch[2];
>  	unsigned int clfe_swap;
> +	unsigned int hp_switch;
>  	unsigned int aloopback;
> =20
>  	struct hda_pcm pcm_rec[2];	/* PCM information */
> @@ -1251,7 +1252,7 @@ static unsigned int ref92hd73xx_pin_conf
> =20
>  static unsigned int dell_m6_pin_configs[13] =3D {
>  	0x0321101f, 0x4f00000f, 0x4f0000f0, 0x90170110,
> -	0x03a11020, 0x03011050, 0x4f0000f0, 0x4f0000f0,
> +	0x03a11020, 0x0321101f, 0x4f0000f0, 0x4f0000f0,
>  	0x4f0000f0, 0x90a60160, 0x4f0000f0, 0x4f0000f0,
>  	0x4f0000f0,
>  };
> @@ -2029,6 +2030,33 @@ static void stac92xx_auto_set_pinctl(str
>  				  AC_VERB_SET_PIN_WIDGET_CONTROL, pin_type);
>  }
> =20
> +#define stac92xx_hp_switch_info		snd_ctl_boolean_mono_info
> +
> +static int stac92xx_hp_switch_get(struct snd_kcontrol *kcontrol,
> +			struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct hda_codec *codec =3D snd_kcontrol_chip(kcontrol);
> +	struct sigmatel_spec *spec =3D codec->spec;
> +
> +	ucontrol->value.integer.value[0] =3D spec->hp_switch;
> +	return 0;
> +}
> +
> +static int stac92xx_hp_switch_put(struct snd_kcontrol *kcontrol,
> +			struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct hda_codec *codec =3D snd_kcontrol_chip(kcontrol);
> +	struct sigmatel_spec *spec =3D codec->spec;
> +
> +	spec->hp_switch =3D ucontrol->value.integer.value[0];
> +
> +	/* check to be sure that the ports are upto date with
> + 	 * switch changes */
> +	codec->patch_ops.unsol_event(codec, STAC_HP_EVENT << 26);
> +
> +	return 1;
> +}
> +
>  #define stac92xx_io_switch_info		snd_ctl_boolean_mono_info
> =20
>  static int stac92xx_io_switch_get(struct snd_kcontrol *kcontrol, struct =
snd_ctl_elem_value *ucontrol)
> @@ -2099,6 +2127,15 @@ static int stac92xx_clfe_switch_put(stru
> =20
>  	return 1;
>  }
> +
> +#define STAC_CODEC_HP_SWITCH(xname) \
> +	{ .iface =3D SNDRV_CTL_ELEM_IFACE_MIXER, \
> +	  .name =3D xname, \
> +	  .index =3D 0, \
> +          .info =3D stac92xx_hp_switch_info, \
> +          .get =3D stac92xx_hp_switch_get, \
> +          .put =3D stac92xx_hp_switch_put, \
> +	}
> =20
>  #define STAC_CODEC_IO_SWITCH(xname, xpval) \
>  	{ .iface =3D SNDRV_CTL_ELEM_IFACE_MIXER, \
> @@ -2124,6 +2161,7 @@ enum {
>  	STAC_CTL_WIDGET_VOL,
>  	STAC_CTL_WIDGET_MUTE,
>  	STAC_CTL_WIDGET_MONO_MUX,
> +	STAC_CTL_WIDGET_HP_SWITCH,
>  	STAC_CTL_WIDGET_IO_SWITCH,
>  	STAC_CTL_WIDGET_CLFE_SWITCH
>  };
> @@ -2132,6 +2170,7 @@ static struct snd_kcontrol_new stac92xx_
>  	HDA_CODEC_VOLUME(NULL, 0, 0, 0),
>  	HDA_CODEC_MUTE(NULL, 0, 0, 0),
>  	STAC_MONO_MUX,
> +	STAC_CODEC_HP_SWITCH(NULL),
>  	STAC_CODEC_IO_SWITCH(NULL, 0),
>  	STAC_CODEC_CLFE_SWITCH(NULL, 0),
>  };
> @@ -2396,6 +2435,14 @@ static int stac92xx_auto_create_multi_ou
>  		}
>  	}
> =20
> +	if (cfg->hp_outs > 1) {
> +		err =3D stac92xx_add_control(spec,
> +			STAC_CTL_WIDGET_HP_SWITCH,
> +			"Headphone as Line Out Switch", 0);
> +		if (err < 0)
> +			return err;
> +	}
> +
>  	if (spec->line_switch) {
>  		nid =3D cfg->input_pins[AUTO_PIN_LINE];
>  		pincap =3D snd_hda_param_read(codec, nid,
> @@ -3144,6 +3191,7 @@ static void stac92xx_hp_detect(struct hd
>  {
>  	struct sigmatel_spec *spec =3D codec->spec;
>  	struct auto_pin_cfg *cfg =3D &spec->autocfg;
> +	int nid =3D cfg->hp_pins[cfg->hp_outs - 1];
>  	int i, presence;
> =20
>  	presence =3D 0;
> @@ -3154,11 +3202,15 @@ static void stac92xx_hp_detect(struct hd
>  	for (i =3D 0; i < cfg->hp_outs; i++) {
>  		if (presence)
>  			break;
> +		if (spec->hp_switch && cfg->hp_pins[i] =3D=3D nid)
> +			break;
>  		presence =3D get_hp_pin_presence(codec, cfg->hp_pins[i]);
>  	}
> =20
>  	if (presence) {
>  		/* disable lineouts, enable hp */
> +		if (spec->hp_switch)
> +			stac92xx_reset_pinctl(codec, nid, AC_PINCTL_OUT_EN);
>  		for (i =3D 0; i < cfg->line_outs; i++)
>  			stac92xx_reset_pinctl(codec, cfg->line_out_pins[i],
>  						AC_PINCTL_OUT_EN);
> @@ -3167,6 +3219,8 @@ static void stac92xx_hp_detect(struct hd
>  						AC_PINCTL_OUT_EN);
>  	} else {
>  		/* enable lineouts, disable hp */
> +		if (spec->hp_switch)
> +			stac92xx_set_pinctl(codec, nid, AC_PINCTL_OUT_EN);
>  		for (i =3D 0; i < cfg->line_outs; i++)
>  			stac92xx_set_pinctl(codec, cfg->line_out_pins[i],
>  						AC_PINCTL_OUT_EN);
> @@ -3174,6 +3228,8 @@ static void stac92xx_hp_detect(struct hd
>  			stac92xx_set_pinctl(codec, cfg->speaker_pins[i],
>  						AC_PINCTL_OUT_EN);
>  	}
> +	if (!spec->hp_switch && cfg->hp_outs > 1 && presence)
> +		stac92xx_set_pinctl(codec, nid, AC_PINCTL_OUT_EN);
>  }=20
> =20
>  static void stac92xx_pin_sense(struct hda_codec *codec, int idx)
> @@ -3427,6 +3483,7 @@ again:
> =20
>  	switch (spec->multiout.num_dacs) {
>  	case 0x3: /* 6 Channel */
> +		spec->multiout.hp_nid =3D 0x17;
>  		spec->mixer =3D stac92hd73xx_6ch_mixer;
>  		spec->init =3D stac92hd73xx_6ch_core_init;
>  		break;
>=20

---
Mario Limonciello
Dell | Linux Engineering
Desk : (512) 723-0582
mario_limonciello@dell.com



--=-o0Yz2L9FKMlWYeexpdLS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH6WOV2CrZjkA73YsRAjpyAKCfDg4DHlQrUYPfBahxlBTEpJpsEgCfXJaA
Y6LjjifdWB+ph/+xYev3c7c=
=1Eo9
-----END PGP SIGNATURE-----

--=-o0Yz2L9FKMlWYeexpdLS--

--===============3642513847562746101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3642513847562746101==--
