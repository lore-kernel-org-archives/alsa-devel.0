From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: Re: [PATCH] hda: Added STAC92HD73 support.
Date: Thu, 13 Dec 2007 10:31:28 -0500
Message-ID: <47615050.9080704@embeddedalley.com>
References: <4755A86C.7000803@embeddedalley.com> <s5h63z28zfw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp108.biz.mail.re2.yahoo.com (smtp108.biz.mail.re2.yahoo.com
	[206.190.52.47]) by alsa0.perex.cz (Postfix) with SMTP id 2D762103867
	for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2007 16:31:55 +0100 (CET)
In-Reply-To: <s5h63z28zfw.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
> At Tue, 04 Dec 2007 14:20:12 -0500,
> Matthew Ranostay wrote:
>   
>> Added support for new STAC92HD73 family of codecs. Additionally added 
>> features for multiple analog loopbacks, and multiple dmux mixers.
>> Regression testing for the analog loopback changes for STAC9205 and 
>> STAC9274D completed with any issues, as well for the dmux changes.
>> ---
>> Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
>>     
>
> Thanks for the patch.
> Just looking at the patch, the handling of aloopback looks fishy.
>
> The below is the revised patch.  Could you check whether it works for
> you?
>
>
> Takashi
>
> diff -r 16431c1939eb pci/hda/patch_sigmatel.c
> --- a/pci/hda/patch_sigmatel.c	Thu Dec 13 13:13:31 2007 +0100
> +++ b/pci/hda/patch_sigmatel.c	Thu Dec 13 16:11:52 2007 +0100
> @@ -62,6 +62,11 @@ enum {
>  };
>  
>  enum {
> +	STAC_92HD73XX_REF,
> +	STAC_92HD73XX_MODELS
> +};
> +
> +enum {
>  	STAC_92HD71BXX_REF,
>  	STAC_92HD71BXX_MODELS
>  };
> @@ -118,6 +123,8 @@ struct sigmatel_spec {
>  	unsigned int gpio_mute: 1;
>  
>  	unsigned int gpio_mask, gpio_data;
> +	unsigned char aloopback_mask;
> +	unsigned char aloopback_shift;
>  
>  	/* playback */
>  	struct hda_multi_out multiout;
> @@ -130,7 +137,7 @@ struct sigmatel_spec {
>  	unsigned int num_muxes;
>  	hda_nid_t *dmic_nids;
>  	unsigned int num_dmics;
> -	hda_nid_t dmux_nid;
> +	hda_nid_t *dmux_nids;
>  	hda_nid_t dig_in_nid;
>  
>  	/* pin widgets */
> @@ -145,7 +152,7 @@ struct sigmatel_spec {
>  
>  	/* capture source */
>  	struct hda_input_mux *dinput_mux;
> -	unsigned int cur_dmux;
> +	unsigned int cur_dmux[2];
>  	struct hda_input_mux *input_mux;
>  	unsigned int cur_mux[3];
>  
> @@ -176,12 +183,38 @@ static hda_nid_t stac9200_dac_nids[1] = 
>          0x02,
>  };
>  
> +static hda_nid_t stac92hd73xx_adc_nids[2] = {
> +	0x1a, 0x1b
> +};
> +
> +#define STAC92HD73XX_NUM_DMICS	2
> +static hda_nid_t stac92hd73xx_dmic_nids[STAC92HD73XX_NUM_DMICS + 1] = {
> +	0x13, 0x14, 0
> +};
> +
> +#define STAC92HD73_DAC_COUNT 5
> +static hda_nid_t stac92hd73xx_dac_nids[STAC92HD73_DAC_COUNT] = {
> +	0x15, 0x16, 0x17, 0x18, 0x19,
> +};
> +
> +static hda_nid_t stac92hd73xx_mux_nids[4] = {
> +	0x28, 0x29, 0x2a, 0x2b,
> +};
> +
> +static hda_nid_t stac92hd73xx_dmux_nids[2] = {
> +	0x20, 0x21,
> +};
> +
>  static hda_nid_t stac92hd71bxx_adc_nids[2] = {
>  	0x12, 0x13,
>  };
>  
>  static hda_nid_t stac92hd71bxx_mux_nids[2] = {
>  	0x1a, 0x1b
> +};
> +
> +static hda_nid_t stac92hd71bxx_dmux_nids[1] = {
> +	0x1c,
>  };
>  
>  static hda_nid_t stac92hd71bxx_dac_nids[2] = {
> @@ -226,6 +259,10 @@ static hda_nid_t stac927x_mux_nids[3] = 
>          0x15, 0x16, 0x17
>  };
>  
> +static hda_nid_t stac927x_dmux_nids[1] = {
> +	0x1b,
> +};
> +
>  #define STAC927X_NUM_DMICS 2
>  static hda_nid_t stac927x_dmic_nids[STAC927X_NUM_DMICS + 1] = {
>  	0x13, 0x14, 0
> @@ -237,6 +274,10 @@ static hda_nid_t stac9205_adc_nids[2] = 
>  
>  static hda_nid_t stac9205_mux_nids[2] = {
>          0x19, 0x1a
> +};
> +
> +static hda_nid_t stac9205_dmux_nids[1] = {
> +		0x1d,
>  };
>  
>  #define STAC9205_NUM_DMICS	2
> @@ -257,6 +298,12 @@ static hda_nid_t stac922x_pin_nids[10] =
>  static hda_nid_t stac922x_pin_nids[10] = {
>  	0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
>  	0x0f, 0x10, 0x11, 0x15, 0x1b,
> +};
> +
> +static hda_nid_t stac92hd73xx_pin_nids[12] = {
> +	0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
> +	0x0f, 0x10, 0x11, 0x12, 0x13,
> +	0x14, 0x22
>  };
>  
>  static hda_nid_t stac92hd71bxx_pin_nids[10] = {
> @@ -289,8 +336,9 @@ static int stac92xx_dmux_enum_get(struct
>  {
>  	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
>  	struct sigmatel_spec *spec = codec->spec;
> +	unsigned int dmux_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
>  
> -	ucontrol->value.enumerated.item[0] = spec->cur_dmux;
> +	ucontrol->value.enumerated.item[0] = spec->cur_dmux[dmux_idx];
>  	return 0;
>  }
>  
> @@ -299,9 +347,10 @@ static int stac92xx_dmux_enum_put(struct
>  {
>  	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
>  	struct sigmatel_spec *spec = codec->spec;
> +	unsigned int dmux_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
>  
>  	return snd_hda_input_mux_put(codec, spec->dinput_mux, ucontrol,
> -				     spec->dmux_nid, &spec->cur_dmux);
> +			spec->dmux_nids[dmux_idx], &spec->cur_dmux[dmux_idx]);
>  }
>  
>  static int stac92xx_mux_enum_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
> @@ -337,9 +386,11 @@ static int stac92xx_aloopback_get(struct
>  	struct snd_ctl_elem_value *ucontrol)
>  {
>  	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
> +	unsigned int idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
>  	struct sigmatel_spec *spec = codec->spec;
>  
> -	ucontrol->value.integer.value[0] = spec->aloopback;
> +	ucontrol->value.integer.value[0] = !!(spec->aloopback &
> +					      (spec->aloopback_mask << idx));
>  	return 0;
>  }
>  
> @@ -348,24 +399,33 @@ static int stac92xx_aloopback_put(struct
>  {
>  	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
>  	struct sigmatel_spec *spec = codec->spec;
> +	unsigned int idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
>  	unsigned int dac_mode;
> -	unsigned int val;
> +	unsigned int val, idx_val;
>  
> -	val = !!ucontrol->value.integer.value[0];
> +	idx_val = spec->aloopback_mask << idx;
> +	if (ucontrol->value.integer.value[0])
> +		val = spec->aloopback | idx_val;
> +	else
> +		val = spec->aloopback & ~idx_val;
>  	if (spec->aloopback == val)
>  		return 0;
>  
>  	spec->aloopback = val;
>  
> +	/* Only return the bits defined by the shift value of the
> +	 * first two bytes of the mask
> +	 */
>  	dac_mode = snd_hda_codec_read(codec, codec->afg, 0,
> -		kcontrol->private_value & 0xFFFF, 0x0);
> +				      kcontrol->private_value & 0xFFFF, 0x0);
> +	dac_mode >>= spec->aloopback_shift;
>  
> -	if (spec->aloopback) {
> +	if (spec->aloopback & idx_val) {
>  		snd_hda_power_up(codec);
> -		dac_mode |= 0x40;
> +		dac_mode |= idx_val;
>  	} else {
>  		snd_hda_power_down(codec);
> -		dac_mode &= ~0x40;
> +		dac_mode &= ~idx_val;
>  	}
>  
>  	snd_hda_codec_write_cache(codec, codec->afg, 0,
> @@ -384,6 +444,86 @@ static struct hda_verb stac9200_eapd_ini
>  	/* set dac0mux for dac converter */
>  	{0x07, AC_VERB_SET_CONNECT_SEL, 0x00},
>  	{0x08, AC_VERB_SET_EAPD_BTLENABLE, 0x02},
> +	{}
> +};
> +
> +static struct hda_verb stac92hd73xx_6ch_core_init[] = {
> +	/* set master volume and direct control */
> +	{ 0x1f, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
> +	/* setup audio connections */
> +	{ 0x0f, AC_VERB_SET_CONNECT_SEL, 0x00},
> +	{ 0x10, AC_VERB_SET_CONNECT_SEL, 0x01},
> +	{ 0x11, AC_VERB_SET_CONNECT_SEL, 0x02},
> +	/* setup adcs to point to mixer */
> +	{ 0x20, AC_VERB_SET_CONNECT_SEL, 0x0b},
> +	{ 0x21, AC_VERB_SET_CONNECT_SEL, 0x0b},
> +	{ 0x0b, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80}, /* Front Mic */
> +	{ 0x0c, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80}, /* Mic */
> +	{ 0x0e, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80}, /* Line In */
> +	{ 0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
> +	{ 0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
> +	{ 0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
> +	/* setup import muxs */
> +	{ 0x28, AC_VERB_SET_CONNECT_SEL, 0x01},
> +	{ 0x29, AC_VERB_SET_CONNECT_SEL, 0x01},
> +	{ 0x2a, AC_VERB_SET_CONNECT_SEL, 0x01},
> +	{ 0x2b, AC_VERB_SET_CONNECT_SEL, 0x00},
> +	{}
> +};
> +
> +static struct hda_verb stac92hd73xx_8ch_core_init[] = {
> +	/* set master volume and direct control */
> +	{ 0x1f, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
> +	/* setup audio connections */
> +	{ 0x0f, AC_VERB_SET_CONNECT_SEL, 0x00},
> +	{ 0x10, AC_VERB_SET_CONNECT_SEL, 0x01},
> +	{ 0x11, AC_VERB_SET_CONNECT_SEL, 0x02},
> +	/* connect hp ports to dac3 */
> +	{ 0x0a, AC_VERB_SET_CONNECT_SEL, 0x03},
> +	{ 0x0d, AC_VERB_SET_CONNECT_SEL, 0x03},
> +	/* setup adcs to point to mixer */
> +	{ 0x20, AC_VERB_SET_CONNECT_SEL, 0x0b},
> +	{ 0x21, AC_VERB_SET_CONNECT_SEL, 0x0b},
> +	{ 0x0b, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80}, /* Front Mic */
> +	{ 0x0c, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80}, /* Mic */
> +	{ 0x0e, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80}, /* Line In */
> +	{ 0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
> +	{ 0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
> +	{ 0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
> +	/* setup import muxs */
> +	{ 0x28, AC_VERB_SET_CONNECT_SEL, 0x01},
> +	{ 0x29, AC_VERB_SET_CONNECT_SEL, 0x01},
> +	{ 0x2a, AC_VERB_SET_CONNECT_SEL, 0x01},
> +	{ 0x2b, AC_VERB_SET_CONNECT_SEL, 0x03},
> +	{}
> +};
> +
> +static struct hda_verb stac92hd73xx_10ch_core_init[] = {
> +	/* set master volume and direct control */
> +	{ 0x1f, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
> +	/* setup audio connections */
> +	{ 0x0f, AC_VERB_SET_CONNECT_SEL, 0x00 },
> +	{ 0x10, AC_VERB_SET_CONNECT_SEL, 0x01 },
> +	{ 0x11, AC_VERB_SET_CONNECT_SEL, 0x02 },
> +	/* dac3 is connected to import3 mux */
> +	{ 0x18, AC_VERB_SET_AMP_GAIN_MUTE, 0xb07f},
> +	/* connect hp ports to dac4 */
> +	{ 0x0a, AC_VERB_SET_CONNECT_SEL, 0x04},
> +	{ 0x0d, AC_VERB_SET_CONNECT_SEL, 0x04},
> +	/* setup adcs to point to mixer */
> +	{ 0x20, AC_VERB_SET_CONNECT_SEL, 0x0b},
> +	{ 0x21, AC_VERB_SET_CONNECT_SEL, 0x0b},
> +	{ 0x0b, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80}, /* Front Mic */
> +	{ 0x0c, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80}, /* Mic */
> +	{ 0x0e, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80}, /* Line In */
> +	{ 0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
> +	{ 0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
> +	{ 0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
> +	/* setup import muxs */
> +	{ 0x28, AC_VERB_SET_CONNECT_SEL, 0x01},
> +	{ 0x29, AC_VERB_SET_CONNECT_SEL, 0x01},
> +	{ 0x2a, AC_VERB_SET_CONNECT_SEL, 0x01},
> +	{ 0x2b, AC_VERB_SET_CONNECT_SEL, 0x03},
>  	{}
>  };
>  
> @@ -460,11 +600,11 @@ static struct hda_verb stac9205_core_ini
>  		.put = stac92xx_mux_enum_put, \
>  	}
>  
> -#define STAC_ANALOG_LOOPBACK(verb_read,verb_write) \
> +#define STAC_ANALOG_LOOPBACK(verb_read, verb_write, cnt) \
>  	{ \
>  		.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
>  		.name  = "Analog Loopback", \
> -		.count = 1, \
> +		.count = cnt, \
>  		.info  = stac92xx_aloopback_info, \
>  		.get   = stac92xx_aloopback_get, \
>  		.put   = stac92xx_aloopback_put, \
> @@ -478,6 +618,99 @@ static struct snd_kcontrol_new stac9200_
>  	HDA_CODEC_VOLUME("Capture Volume", 0x0a, 0, HDA_OUTPUT),
>  	HDA_CODEC_MUTE("Capture Switch", 0x0a, 0, HDA_OUTPUT),
>  	HDA_CODEC_VOLUME("Capture Mux Volume", 0x0c, 0, HDA_OUTPUT),
> +	{ } /* end */
> +};
> +
> +static struct snd_kcontrol_new stac92hd73xx_6ch_mixer[] = {
> +	STAC_DIGITAL_INPUT_SOURCE(2),
> +	STAC_ANALOG_LOOPBACK(0xFA0, 0x7A1, 3),
> +
> +	/* hardware gain controls */
> +	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x0, 0x13, 0x0, HDA_OUTPUT),
> +	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x1, 0x14, 0x0, HDA_OUTPUT),
> +
> +	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x20, 0x0, HDA_OUTPUT),
> +	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x20, 0x0, HDA_OUTPUT),
> +
> +	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x1, 0x21, 0x0, HDA_OUTPUT),
> +	HDA_CODEC_MUTE_IDX("Capture Switch", 0x1, 0x21, 0x0, HDA_OUTPUT),
> +
> +	HDA_CODEC_VOLUME("Front Mic Mixer Capture Volume", 0x1d, 0, HDA_INPUT),
> +	HDA_CODEC_MUTE("Front Mic Mixer Capture Switch", 0x1d, 0, HDA_INPUT),
> +
> +	HDA_CODEC_VOLUME("Mic Mixer Capture Volume", 0x1d, 0x1, HDA_INPUT),
> +	HDA_CODEC_MUTE("Mic Mixer Capture Switch", 0x1d, 0x1, HDA_INPUT),
> +
> +	HDA_CODEC_VOLUME("Line In Mixer Capture Volume", 0x1d, 0x2, HDA_INPUT),
> +	HDA_CODEC_MUTE("Line In Mixer Capture Switch", 0x1d, 0x2, HDA_INPUT),
> +
> +	HDA_CODEC_VOLUME("DAC Mixer Capture Volume", 0x1d, 0x3, HDA_INPUT),
> +	HDA_CODEC_MUTE("DAC Mixer Capture Switch", 0x1d, 0x3, HDA_INPUT),
> +
> +	HDA_CODEC_VOLUME("CD Mixer Capture Volume", 0x1d, 0x4, HDA_INPUT),
> +	HDA_CODEC_MUTE("CD Mixer Capture Switch", 0x1d, 0x4, HDA_INPUT),
> +	{ } /* end */
> +};
> +
> +static struct snd_kcontrol_new stac92hd73xx_8ch_mixer[] = {
> +	STAC_DIGITAL_INPUT_SOURCE(2),
> +	STAC_ANALOG_LOOPBACK(0xFA0, 0x7A1, 4),
> +
> +	/* hardware gain controls */
> +	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x0, 0x13, 0x0, HDA_OUTPUT),
> +	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x1, 0x14, 0x0, HDA_OUTPUT),
> +
> +	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x20, 0x0, HDA_OUTPUT),
> +	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x20, 0x0, HDA_OUTPUT),
> +
> +	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x1, 0x21, 0x0, HDA_OUTPUT),
> +	HDA_CODEC_MUTE_IDX("Capture Switch", 0x1, 0x21, 0x0, HDA_OUTPUT),
> +
> +	HDA_CODEC_VOLUME("Front Mic Mixer Capture Volume", 0x1d, 0, HDA_INPUT),
> +	HDA_CODEC_MUTE("Front Mic Mixer Capture Switch", 0x1d, 0, HDA_INPUT),
> +
> +	HDA_CODEC_VOLUME("Mic Mixer Capture Volume", 0x1d, 0x1, HDA_INPUT),
> +	HDA_CODEC_MUTE("Mic Mixer Capture Switch", 0x1d, 0x1, HDA_INPUT),
> +
> +	HDA_CODEC_VOLUME("Line In Mixer Capture Volume", 0x1d, 0x2, HDA_INPUT),
> +	HDA_CODEC_MUTE("Line In Mixer Capture Switch", 0x1d, 0x2, HDA_INPUT),
> +
> +	HDA_CODEC_VOLUME("DAC Mixer Capture Volume", 0x1d, 0x3, HDA_INPUT),
> +	HDA_CODEC_MUTE("DAC Mixer Capture Switch", 0x1d, 0x3, HDA_INPUT),
> +
> +	HDA_CODEC_VOLUME("CD Mixer Capture Volume", 0x1d, 0x4, HDA_INPUT),
> +	HDA_CODEC_MUTE("CD Mixer Capture Switch", 0x1d, 0x4, HDA_INPUT),
> +	{ } /* end */
> +};
> +
> +static struct snd_kcontrol_new stac92hd73xx_10ch_mixer[] = {
> +	STAC_DIGITAL_INPUT_SOURCE(2),
> +	STAC_ANALOG_LOOPBACK(0xFA0, 0x7A1, 5),
> +
> +	/* hardware gain controls */
> +	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x0, 0x13, 0x0, HDA_OUTPUT),
> +	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x1, 0x14, 0x0, HDA_OUTPUT),
> +
> +	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x20, 0x0, HDA_OUTPUT),
> +	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x20, 0x0, HDA_OUTPUT),
> +
> +	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x1, 0x21, 0x0, HDA_OUTPUT),
> +	HDA_CODEC_MUTE_IDX("Capture Switch", 0x1, 0x21, 0x0, HDA_OUTPUT),
> +
> +	HDA_CODEC_VOLUME("Front Mic Mixer Capture Volume", 0x1d, 0, HDA_INPUT),
> +	HDA_CODEC_MUTE("Front Mic Mixer Capture Switch", 0x1d, 0, HDA_INPUT),
> +
> +	HDA_CODEC_VOLUME("Mic Mixer Capture Volume", 0x1d, 0x1, HDA_INPUT),
> +	HDA_CODEC_MUTE("Mic Mixer Capture Switch", 0x1d, 0x1, HDA_INPUT),
> +
> +	HDA_CODEC_VOLUME("Line In Mixer Capture Volume", 0x1d, 0x2, HDA_INPUT),
> +	HDA_CODEC_MUTE("Line In Mixer Capture Switch", 0x1d, 0x2, HDA_INPUT),
> +
> +	HDA_CODEC_VOLUME("DAC Mixer Capture Volume", 0x1d, 0x3, HDA_INPUT),
> +	HDA_CODEC_MUTE("DAC Mixer Capture Switch", 0x1d, 0x3, HDA_INPUT),
> +
> +	HDA_CODEC_VOLUME("CD Mixer Capture Volume", 0x1d, 0x4, HDA_INPUT),
> +	HDA_CODEC_MUTE("CD Mixer Capture Switch", 0x1d, 0x4, HDA_INPUT),
>  	{ } /* end */
>  };
>  
> @@ -513,7 +746,7 @@ static struct snd_kcontrol_new stac9205_
>  static struct snd_kcontrol_new stac9205_mixer[] = {
>  	STAC_DIGITAL_INPUT_SOURCE(1),
>  	STAC_INPUT_SOURCE(2),
> -	STAC_ANALOG_LOOPBACK(0xFE0, 0x7E0),
> +	STAC_ANALOG_LOOPBACK(0xFE0, 0x7E0, 1),
>  
>  	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x1b, 0x0, HDA_INPUT),
>  	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x1d, 0x0, HDA_OUTPUT),
> @@ -543,7 +776,7 @@ static struct snd_kcontrol_new stac927x_
>  static struct snd_kcontrol_new stac927x_mixer[] = {
>  	STAC_DIGITAL_INPUT_SOURCE(1),
>  	STAC_INPUT_SOURCE(3),
> -	STAC_ANALOG_LOOPBACK(0xFEB, 0x7EB),
> +	STAC_ANALOG_LOOPBACK(0xFEB, 0x7EB, 1),
>  
>  	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x18, 0x0, HDA_INPUT),
>  	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x1b, 0x0, HDA_OUTPUT),
> @@ -851,6 +1084,27 @@ static struct snd_pci_quirk stac925x_cfg
>  	SND_PCI_QUIRK(0x107b, 0x0461, "Gateway NX560XL", STAC_MA6),
>  	SND_PCI_QUIRK(0x107b, 0x0681, "Gateway NX860", STAC_PA6),
>  	SND_PCI_QUIRK(0x1002, 0x437b, "Gateway MX6453", STAC_M2_2),
> +	{} /* terminator */
> +};
> +
> +static unsigned int ref92hd73xx_pin_configs[12] = {
> +	0x02214030, 0x02a19040, 0x01a19020, 0x02214030,
> +	0x0181302e, 0x01014010, 0x01014020, 0x01014030,
> +	0x02319040, 0x90a000f0, 0x90a000f0, 0x01452050,
> +};
> +
> +static unsigned int *stac92hd73xx_brd_tbl[STAC_92HD73XX_MODELS] = {
> +	[STAC_92HD73XX_REF] = ref92hd73xx_pin_configs,
> +};
> +
> +static const char *stac92hd73xx_models[STAC_92HD73XX_MODELS] = {
> +	[STAC_92HD73XX_REF] = "ref",
> +};
> +
> +static struct snd_pci_quirk stac92hd73xx_cfg_tbl[] = {
> +	/* SigmaTel reference board */
> +	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668,
> +		      "DFI LanParty", STAC_92HD73XX_REF),
>  	{} /* terminator */
>  };
>  
> @@ -2030,7 +2284,7 @@ static int stac92xx_auto_create_dmic_inp
>  			continue;
>  
>  		num_cons = snd_hda_get_connections(codec,
> -				spec->dmux_nid,
> +				spec->dmux_nids[0],
>  				con_lst,
>  				HDA_MAX_NUM_INPUTS);
>  		for (j = 0; j < num_cons; j++)
> @@ -2211,7 +2465,8 @@ static int stac92xx_parse_auto_config(st
>  		spec->mixers[spec->num_mixers++] = spec->kctl_alloc;
>  
>  	spec->input_mux = &spec->private_imux;
> -	spec->dinput_mux = &spec->private_dimux;
> +	if (!spec->dinput_mux)
> +		spec->dinput_mux = &spec->private_dimux;
>  
>  	return 1;
>  }
> @@ -2696,6 +2951,112 @@ static int patch_stac925x(struct hda_cod
>  	return 0;
>  }
>  
> +static struct hda_input_mux stac92hd73xx_dmux = {
> +	.num_items = 4,
> +	.items = {
> +		{ "Analog Inputs", 0x0b },
> +		{ "CD", 0x08 },
> +		{ "Digital Mic 1", 0x09 },
> +		{ "Digital Mic 2", 0x0a },
> +	}
> +};
> +
> +static int patch_stac92hd73xx(struct hda_codec *codec)
> +{
> +	struct sigmatel_spec *spec;
> +	hda_nid_t conn[STAC92HD73_DAC_COUNT + 2];
> +	int err = 0;
> +
> +	spec  = kzalloc(sizeof(*spec), GFP_KERNEL);
> +	if (spec == NULL)
> +		return -ENOMEM;
> +
> +	codec->spec = spec;
> +	spec->num_pins = ARRAY_SIZE(stac92hd73xx_pin_nids);
> +	spec->pin_nids = stac92hd73xx_pin_nids;
> +	spec->board_config = snd_hda_check_board_config(codec,
> +							STAC_92HD73XX_MODELS,
> +							stac92hd73xx_models,
> +							stac92hd73xx_cfg_tbl);
> +again:
> +	if (spec->board_config < 0) {
> +		snd_printdd(KERN_INFO "hda_codec: Unknown model for"
> +			" STAC92HD73XX, using BIOS defaults\n");
> +		err = stac92xx_save_bios_config_regs(codec);
> +		if (err < 0) {
> +			stac92xx_free(codec);
> +			return err;
> +		}
> +		spec->pin_configs = spec->bios_pin_configs;
> +	} else {
> +		spec->pin_configs = stac92hd73xx_brd_tbl[spec->board_config];
> +		stac92xx_set_config_regs(codec);
> +	}
> +
> +	spec->multiout.num_dacs = snd_hda_get_connections(codec, 0x0a,
> +			conn, STAC92HD73_DAC_COUNT + 2) - 1;
> +
> +	if (spec->multiout.num_dacs < 0) {
> +		printk(KERN_WARNING "hda_codec: Could not determine "
> +		       "number of channels defaulting to DAC count\n");
> +		spec->multiout.num_dacs = STAC92HD73_DAC_COUNT;
> +	}
> +
> +	switch (spec->multiout.num_dacs) {
> +	case 0x3: /* 6 Channel */
> +		spec->mixer = stac92hd73xx_6ch_mixer;
> +		spec->init = stac92hd73xx_6ch_core_init;
> +		break;
> +	case 0x4: /* 8 Channel */
> +		spec->multiout.hp_nid = 0x18;
> +		spec->mixer = stac92hd73xx_8ch_mixer;
> +		spec->init = stac92hd73xx_8ch_core_init;
> +		break;
> +	case 0x5: /* 10 Channel */
> +		spec->multiout.hp_nid = 0x19;
> +		spec->mixer = stac92hd73xx_10ch_mixer;
> +		spec->init = stac92hd73xx_10ch_core_init;
> +	};
> +
> +	spec->multiout.dac_nids = stac92hd73xx_dac_nids;
> +	spec->aloopback_mask = 0x01;
> +	spec->aloopback_shift = 8;
> +
> +	spec->mux_nids = stac92hd73xx_mux_nids;
> +	spec->adc_nids = stac92hd73xx_adc_nids;
> +	spec->dmic_nids = stac92hd73xx_dmic_nids;
> +	spec->dmux_nids = stac92hd73xx_dmux_nids;
> +
> +	spec->num_muxes = ARRAY_SIZE(stac92hd73xx_mux_nids);
> +	spec->num_adcs = ARRAY_SIZE(stac92hd73xx_adc_nids);
> +	spec->num_dmics = STAC92HD73XX_NUM_DMICS;
> +	spec->dinput_mux = &stac92hd73xx_dmux;
> +	/* GPIO0 High = Enable EAPD */
> +	spec->gpio_mask = spec->gpio_data = 0x000001;
> +	stac92xx_enable_gpio_mask(codec);
> +
> +	err = stac92xx_parse_auto_config(codec, 0x22, 0x24);
> +
> +	if (!err) {
> +		if (spec->board_config < 0) {
> +			printk(KERN_WARNING "hda_codec: No auto-config is "
> +			       "available, default to model=ref\n");
> +			spec->board_config = STAC_92HD73XX_REF;
> +			goto again;
> +		}
> +		err = -EINVAL;
> +	}
> +
> +	if (err < 0) {
> +		stac92xx_free(codec);
> +		return err;
> +	}
> +
> +	codec->patch_ops = stac92xx_patch_ops;
> +
> +	return 0;
> +}
> +
>  static int patch_stac92hd71bxx(struct hda_codec *codec)
>  {
>  	struct sigmatel_spec *spec;
> @@ -2736,7 +3097,7 @@ again:
>  	spec->mux_nids = stac92hd71bxx_mux_nids;
>  	spec->adc_nids = stac92hd71bxx_adc_nids;
>  	spec->dmic_nids = stac92hd71bxx_dmic_nids;
> -	spec->dmux_nid = 0x1c;
> +	spec->dmux_nids = stac92hd71bxx_dmux_nids;
>  
>  	spec->num_muxes = ARRAY_SIZE(stac92hd71bxx_mux_nids);
>  	spec->num_adcs = ARRAY_SIZE(stac92hd71bxx_adc_nids);
> @@ -2931,7 +3292,7 @@ static int patch_stac927x(struct hda_cod
>  	case 0x10280209:
>  		spec->dmic_nids = stac927x_dmic_nids;
>  		spec->num_dmics = STAC927X_NUM_DMICS;
> -		spec->dmux_nid = 0x1b;
> +		spec->dmux_nids = stac927x_dmux_nids;
>  
>  		/* Enable DMIC0 */
>  		stac92xx_set_config_reg(codec, 0x13, 0x90a60040);
> @@ -2947,6 +3308,8 @@ static int patch_stac927x(struct hda_cod
>  	}
>  
>  	spec->multiout.dac_nids = spec->dac_nids;
> +	spec->aloopback_mask = 0x40;
> +	spec->aloopback_shift = 0;
>  	stac92xx_enable_gpio_mask(codec); 
>  	
>  	err = stac92xx_parse_auto_config(codec, 0x1e, 0x20);
> @@ -3004,11 +3367,13 @@ static int patch_stac9205(struct hda_cod
>  	spec->num_muxes = ARRAY_SIZE(stac9205_mux_nids);
>  	spec->dmic_nids = stac9205_dmic_nids;
>  	spec->num_dmics = STAC9205_NUM_DMICS;
> -	spec->dmux_nid = 0x1d;
> +	spec->dmux_nids = stac9205_dmux_nids;
>  
>  	spec->init = stac9205_core_init;
>  	spec->mixer = stac9205_mixer;
>  
> +	spec->aloopback_mask = 0x40;
> +	spec->aloopback_shift = 0;
>  	spec->multiout.dac_nids = spec->dac_nids;
>  	
>  	switch (spec->board_config){
> @@ -3337,6 +3702,8 @@ struct hda_codec_preset snd_hda_preset_s
>   	{ .id = 0x838476a5, .name = "STAC9255D", .patch = patch_stac9205 },
>   	{ .id = 0x838476a6, .name = "STAC9254", .patch = patch_stac9205 },
>   	{ .id = 0x838476a7, .name = "STAC9254D", .patch = patch_stac9205 },
> +	{ .id = 0x111d7676, .name = "92HD73E1X5", .patch = patch_stac92hd73xx },
> +	{ .id = 0x111d7675, .name = "92HD73D1X5", .patch = patch_stac92hd73xx },
>  	{ .id = 0x111d76b0, .name = "92HD71BXX", .patch = patch_stac92hd71bxx },
>  	{} /* terminator */
>  };
>
>   
Works fine for me.

Thanks,

Matt Ranostay
