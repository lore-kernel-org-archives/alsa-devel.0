From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: Re: [PATCH] hda: SPDIF mux controls
Date: Sun, 07 Sep 2008 11:17:47 -0400
Message-ID: <48C3F09B.8030802@embeddedalley.com>
References: <48C18086.8030307@embeddedalley.com> <s5habekjlu4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id CEDFD245D0
	for <alsa-devel@alsa-project.org>;
	Sun,  7 Sep 2008 17:18:03 +0200 (CEST)
In-Reply-To: <s5habekjlu4.wl%tiwai@suse.de>
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Takashi Iwai wrote:
> At Fri, 05 Sep 2008 14:55:02 -0400,
> Matthew Ranostay wrote:
> Dynamically create mux controls for SPDIF outs on certain IDT/Sigmatel codecs.
> 
> ---
> Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
> 
>> Thanks, applied.
> 
>> One concern is whether "IEC958 Mux" is the right name for this.
>> Maybe something like "IEC958 Capture Source" would be more intuitive.
Ah but it isn't a capture source mux it's actually for the output SPDIF's.

- - Matt

>> However, note that "Capture Source" name is often problematic for
>> multiple instances due to a bug (or a feature) of alsa-lib mixer
>> abstraction.  (That's why "Input Source" is used in many HD-audio
>> codes.)
> 
> 
>> Takashi
> 
> diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
> index 9968ee4..4637d76 100644
> --- a/pci/hda/patch_sigmatel.c
> +++ b/pci/hda/patch_sigmatel.c
> @@ -173,6 +173,9 @@ struct sigmatel_spec {
>  	unsigned int num_dmics;
>  	hda_nid_t *dmux_nids;
>  	unsigned int num_dmuxes;
> +	hda_nid_t *smux_nids;
> +	unsigned int num_smuxes;
> +
>  	hda_nid_t dig_in_nid;
>  	hda_nid_t mono_nid;
>  	hda_nid_t anabeep_nid;
> @@ -193,6 +196,8 @@ struct sigmatel_spec {
>  	unsigned int cur_dmux[2];
>  	struct hda_input_mux *input_mux;
>  	unsigned int cur_mux[3];
> +	struct hda_input_mux *sinput_mux;
> +	unsigned int cur_smux[2];
>  	unsigned int powerdown_adcs;
> 
>  	/* i/o switches */
> @@ -209,6 +214,7 @@ struct sigmatel_spec {
>  	struct snd_kcontrol_new *kctl_alloc;
>  	struct hda_input_mux private_dimux;
>  	struct hda_input_mux private_imux;
> +	struct hda_input_mux private_smux;
>  	struct hda_input_mux private_mono_mux;
>  };
> 
> @@ -251,6 +257,10 @@ static hda_nid_t stac92hd73xx_dmux_nids[2] = {
>  	0x20, 0x21,
>  };
> 
> +static hda_nid_t stac92hd73xx_smux_nids[2] = {
> +	0x22, 0x23,
> +};
> +
>  #define STAC92HD83XXX_NUM_DMICS	2
>  static hda_nid_t stac92hd83xxx_dmic_nids[STAC92HD83XXX_NUM_DMICS + 1] = {
>  	0x11, 0x12, 0
> @@ -294,6 +304,10 @@ static hda_nid_t stac92hd71bxx_dmux_nids[1] = {
>  	0x1c,
>  };
> 
> +static hda_nid_t stac92hd71bxx_smux_nids[2] = {
> +	0x24, 0x25,
> +};
> +
>  static hda_nid_t stac92hd71bxx_dac_nids[1] = {
>  	0x10, /*0x11, */
>  };
> @@ -340,6 +354,10 @@ static hda_nid_t stac927x_mux_nids[3] = {
>          0x15, 0x16, 0x17
>  };
> 
> +static hda_nid_t stac927x_smux_nids[1] = {
> +	0x21,
> +};
> +
>  static hda_nid_t stac927x_dac_nids[6] = {
>  	0x02, 0x03, 0x04, 0x05, 0x06, 0
>  };
> @@ -365,6 +383,10 @@ static hda_nid_t stac9205_dmux_nids[1] = {
>  	0x1d,
>  };
> 
> +static hda_nid_t stac9205_smux_nids[1] = {
> +	0x21,
> +};
> +
>  #define STAC9205_NUM_DMICS	2
>  static hda_nid_t stac9205_dmic_nids[STAC9205_NUM_DMICS + 1] = {
>          0x17, 0x18, 0
> @@ -388,7 +410,7 @@ static hda_nid_t stac922x_pin_nids[10] = {
>  static hda_nid_t stac92hd73xx_pin_nids[13] = {
>  	0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
>  	0x0f, 0x10, 0x11, 0x12, 0x13,
> -	0x14, 0x1e, 0x22
> +	0x14, 0x22, 0x23
>  };
> 
>  static hda_nid_t stac92hd83xxx_pin_nids[14] = {
> @@ -443,6 +465,36 @@ static int stac92xx_dmux_enum_put(struct snd_kcontrol *kcontrol,
>  			spec->dmux_nids[dmux_idx], &spec->cur_dmux[dmux_idx]);
>  }
> 
> +static int stac92xx_smux_enum_info(struct snd_kcontrol *kcontrol,
> +				   struct snd_ctl_elem_info *uinfo)
> +{
> +	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
> +	struct sigmatel_spec *spec = codec->spec;
> +	return snd_hda_input_mux_info(spec->sinput_mux, uinfo);
> +}
> +
> +static int stac92xx_smux_enum_get(struct snd_kcontrol *kcontrol,
> +				  struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
> +	struct sigmatel_spec *spec = codec->spec;
> +	unsigned int smux_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
> +
> +	ucontrol->value.enumerated.item[0] = spec->cur_smux[smux_idx];
> +	return 0;
> +}
> +
> +static int stac92xx_smux_enum_put(struct snd_kcontrol *kcontrol,
> +				  struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
> +	struct sigmatel_spec *spec = codec->spec;
> +	unsigned int smux_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
> +
> +	return snd_hda_input_mux_put(codec, spec->sinput_mux, ucontrol,
> +			spec->smux_nids[smux_idx], &spec->cur_smux[smux_idx]);
> +}
> +
>  static int stac92xx_mux_enum_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
>  {
>  	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
> @@ -993,6 +1045,15 @@ static struct snd_kcontrol_new stac_dmux_mixer = {
>  	.put = stac92xx_dmux_enum_put,
>  };
> 
> +static struct snd_kcontrol_new stac_smux_mixer = {
> +	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> +	.name = "IEC958 Mux",
> +	/* count set later */
> +	.info = stac92xx_smux_enum_info,
> +	.get = stac92xx_smux_enum_get,
> +	.put = stac92xx_smux_enum_put,
> +};
> +
>  static const char *slave_vols[] = {
>  	"Front Playback Volume",
>  	"Surround Playback Volume",
> @@ -1044,6 +1105,13 @@ static int stac92xx_build_controls(struct hda_codec *codec)
>  		if (err < 0)
>  			return err;
>  	}
> +	if (spec->num_smuxes > 0) {
> +		stac_smux_mixer.count = spec->num_smuxes;
> +		err = snd_ctl_add(codec->bus->card,
> +				  snd_ctl_new1(&stac_smux_mixer, codec));
> +		if (err < 0)
> +			return err;
> +	}
> 
>  	if (spec->multiout.dig_out_nid) {
>  		err = snd_hda_create_spdif_out_ctls(codec, spec->multiout.dig_out_nid);
> @@ -2811,6 +2879,34 @@ static int stac92xx_auto_create_mux_input_ctls(struct hda_codec *codec)
>  	return 0;
>  };
> 
> +static const char *stac92xx_spdif_labels[3] = {
> +	"Digital Playback", "Analog Mux 1", "Analog Mux 2"
> +};
> +
> +static int stac92xx_auto_create_spdif_mux_ctls(struct hda_codec *codec)
> +{
> +	struct sigmatel_spec *spec = codec->spec;
> +	struct hda_input_mux *spdif_mux = &spec->private_smux;
> +	int i, num_cons;
> +	hda_nid_t con_lst[ARRAY_SIZE(stac92xx_spdif_labels)];
> +
> +	num_cons = snd_hda_get_connections(codec,
> +				spec->smux_nids[0],
> +				con_lst,
> +				HDA_MAX_NUM_INPUTS);
> +	if (!num_cons || num_cons > ARRAY_SIZE(stac92xx_spdif_labels))
> +		return -EINVAL;
> +
> +	for (i = 0; i < num_cons; i++) {
> +		spdif_mux->items[spdif_mux->num_items].label =
> +					stac92xx_spdif_labels[i];
> +		spdif_mux->items[spdif_mux->num_items].index = i;
> +		spdif_mux->num_items++;
> +	}
> +
> +	return 0;
> +}
> +
>  /* labels for dmic mux inputs */
>  static const char *stac92xx_dmic_labels[5] = {
>  	"Analog Inputs", "Digital Mic 1", "Digital Mic 2",
> @@ -3114,6 +3210,11 @@ static int stac92xx_parse_auto_config(struct hda_codec *codec, hda_nid_t dig_out
>  		if (err < 0)
>  			return err;
>  	}
> +	if (spec->num_smuxes > 0) {
> +		err = stac92xx_auto_create_spdif_mux_ctls(codec);
> +		if (err < 0)
> +			return err;
> +	}
> 
>  	spec->multiout.max_channels = spec->multiout.num_dacs * 2;
>  	if (spec->multiout.max_channels > 2)
> @@ -3130,6 +3231,7 @@ static int stac92xx_parse_auto_config(struct hda_codec *codec, hda_nid_t dig_out
>  	spec->input_mux = &spec->private_imux;
>  	if (!spec->dinput_mux)
>  		spec->dinput_mux = &spec->private_dimux;
> +	spec->sinput_mux = &spec->private_smux;
>  	spec->mono_mux = &spec->private_mono_mux;
> 
>  	return 1;
> @@ -3800,10 +3902,12 @@ again:
>  	spec->adc_nids = stac92hd73xx_adc_nids;
>  	spec->dmic_nids = stac92hd73xx_dmic_nids;
>  	spec->dmux_nids = stac92hd73xx_dmux_nids;
> +	spec->smux_nids = stac92hd73xx_smux_nids;
> 
>  	spec->num_muxes = ARRAY_SIZE(stac92hd73xx_mux_nids);
>  	spec->num_adcs = ARRAY_SIZE(stac92hd73xx_adc_nids);
>  	spec->num_dmuxes = ARRAY_SIZE(stac92hd73xx_dmux_nids);
> +	spec->num_smuxes = ARRAY_SIZE(stac92hd73xx_smux_nids);
>  	spec->dinput_mux = &stac92hd73xx_dmux;
>  	/* GPIO0 High = Enable EAPD */
>  	spec->eapd_mask = spec->gpio_mask = spec->gpio_dir = 0x1;
> @@ -3842,7 +3946,7 @@ again:
>  	spec->num_pwrs = ARRAY_SIZE(stac92hd73xx_pwr_nids);
>  	spec->pwr_nids = stac92hd73xx_pwr_nids;
> 
> -	err = stac92xx_parse_auto_config(codec, 0x22, 0x24);
> +	err = stac92xx_parse_auto_config(codec, 0x25, 0x27);
> 
>  	if (!err) {
>  		if (spec->board_config < 0) {
> @@ -4081,11 +4185,13 @@ again:
>  	spec->adc_nids = stac92hd71bxx_adc_nids;
>  	spec->dmic_nids = stac92hd71bxx_dmic_nids;
>  	spec->dmux_nids = stac92hd71bxx_dmux_nids;
> +	spec->smux_nids = stac92hd71bxx_smux_nids;
>  	spec->pwr_nids = stac92hd71bxx_pwr_nids;
> 
>  	spec->num_muxes = ARRAY_SIZE(stac92hd71bxx_mux_nids);
>  	spec->num_adcs = ARRAY_SIZE(stac92hd71bxx_adc_nids);
>  	spec->num_dmics = STAC92HD71BXX_NUM_DMICS;
> +	spec->num_smuxes = ARRAY_SIZE(stac92hd71bxx_smux_nids);
>  	spec->num_dmuxes = ARRAY_SIZE(stac92hd71bxx_dmux_nids);
> 
>  	spec->multiout.num_dacs = 1;
> @@ -4254,6 +4360,8 @@ static int patch_stac927x(struct hda_codec *codec)
>  	spec->num_adcs = ARRAY_SIZE(stac927x_adc_nids);
>  	spec->mux_nids = stac927x_mux_nids;
>  	spec->num_muxes = ARRAY_SIZE(stac927x_mux_nids);
> +	spec->smux_nids = stac927x_smux_nids;
> +	spec->num_smuxes = ARRAY_SIZE(stac927x_smux_nids);
>  	spec->dac_list = stac927x_dac_nids;
>  	spec->multiout.dac_nids = spec->dac_nids;
> 
> @@ -4375,6 +4483,8 @@ static int patch_stac9205(struct hda_codec *codec)
>  	spec->num_adcs = ARRAY_SIZE(stac9205_adc_nids);
>  	spec->mux_nids = stac9205_mux_nids;
>  	spec->num_muxes = ARRAY_SIZE(stac9205_mux_nids);
> +	spec->smux_nids = stac9205_smux_nids;
> +	spec->num_smuxes = ARRAY_SIZE(stac9205_smux_nids);
>  	spec->dmic_nids = stac9205_dmic_nids;
>  	spec->num_dmics = STAC9205_NUM_DMICS;
>  	spec->dmux_nids = stac9205_dmux_nids;
>>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkjD8JsACgkQ7s2wy7nhBHXdBQCfUiU4xhBYTMONOMoOzYaQiu7E
84YAnR4W8wbOJKgcOSRWUqefri7buPN0
=Hnl6
-----END PGP SIGNATURE-----
