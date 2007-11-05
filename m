From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: Re: [PATCH] hda: Added new IDT codec family
Date: Mon, 05 Nov 2007 12:10:44 -0500
Message-ID: <472F4E94.8020407@embeddedalley.com>
References: <472F3191.2040004@embeddedalley.com> <s5h3avknacw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090603090306010105010603"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp103.biz.mail.re2.yahoo.com (smtp103.biz.mail.re2.yahoo.com
	[68.142.229.217]) by alsa0.perex.cz (Postfix) with SMTP id C5346246E7
	for <alsa-devel@alsa-project.org>; Mon,  5 Nov 2007 18:10:39 +0100 (CET)
In-Reply-To: <s5h3avknacw.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090603090306010105010603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> At Mon, 05 Nov 2007 10:06:57 -0500,
> Matthew Ranostay wrote:
>   
>> diff -r 3e1a17f8baca pci/hda/hda_codec.h
>> --- a/pci/hda/hda_codec.h	Wed Oct 31 17:36:20 2007 +0100
>> +++ b/pci/hda/hda_codec.h	Sat Nov 03 22:55:14 2007 -0500
>> @@ -92,6 +92,8 @@ enum {
>>   */
>>  #define AC_VERB_SET_STREAM_FORMAT		0x200
>>  #define AC_VERB_SET_AMP_GAIN_MUTE		0x300
>> +#define AC_VERB_SET_RIGHT_AMP_IN_MUTE	0x350
>> +#define AC_VERB_SET_LEFT_AMP_IN_MUTE	0x360
>>     
>
> Usually we pass the values for left or right bits in the parameter
> value (AC_AMP_SET_LEFT and AC_AMP_SET_RIGHT) instead of the verb
> value.  So, no need to redefine them.
>
>   
>>  #define AC_VERB_SET_PROC_COEF			0x400
>>  #define AC_VERB_SET_COEF_INDEX			0x500
>>  #define AC_VERB_SET_CONNECT_SEL			0x701
>>
>> diff -r 3e1a17f8baca pci/hda/patch_sigmatel.c
>> --- a/pci/hda/patch_sigmatel.c	Wed Oct 31 17:36:20 2007 +0100
>> +++ b/pci/hda/patch_sigmatel.c	Mon Nov 05 09:34:05 2007 -0500
>> @@ -62,6 +62,11 @@ enum {
>>  };
>>  
>>  enum {
>> +	STAC_92HD71BXX_REF,
>> +	STAC_92HD71BXX_MODELS
>> +};
>> +
>> +enum {
>>  	STAC_925x_REF,
>>  	STAC_M2_2,
>>  	STAC_MA6,
>> @@ -172,6 +177,23 @@ static hda_nid_t stac9200_dac_nids[1] = 
>>          0x02,
>>  };
>>  
>> +static hda_nid_t stac92hd71bxx_adc_nids[2] = {
>> +		0x12, 0x13,
>> +};
>> +
>> +static hda_nid_t stac92hd71bxx_mux_nids[2] = {
>> +		0x1a, 0x1b
>> +};
>> +
>> +static hda_nid_t stac92hd71bxx_dac_nids[2] = {
>> +		0x10, /*0x11, */
>> +};
>> +
>> +#define STAC92HD71BXX_NUM_DMICS	2
>> +static hda_nid_t stac92hd71bxx_dmic_nids[STAC92HD71BXX_NUM_DMICS + 1] = {
>> +		0x18, 0x19, 0
>> +};
>>     
>
> Wrong indentations.
> Try to run $linux_kernel/scripts/checkpatch.pl.  You'll find other
> minor coding-style issues.
>
>   
>> +
>>  static hda_nid_t stac925x_adc_nids[1] = {
>>          0x03,
>>  };
>> @@ -236,6 +258,11 @@ static hda_nid_t stac922x_pin_nids[10] =
>>  static hda_nid_t stac922x_pin_nids[10] = {
>>  	0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
>>  	0x0f, 0x10, 0x11, 0x15, 0x1b,
>> +};
>> +
>> +static hda_nid_t stac92hd71bxx_pin_nids[10] = {
>> +	0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
>> +	0x0f, 0x14, 0x18, 0x19, 0x1e,
>>  };
>>  
>>  static hda_nid_t stac927x_pin_nids[14] = {
>> @@ -393,6 +420,25 @@ static struct hda_verb stac9200_eapd_ini
>>  	/* set dac0mux for dac converter */
>>  	{0x07, AC_VERB_SET_CONNECT_SEL, 0x00},
>>  	{0x08, AC_VERB_SET_EAPD_BTLENABLE, 0x02},
>> +	{}
>> +};
>> +
>> +static struct hda_verb stac92hd71bxx_core_init[] = {
>> +	/* set master volume and direct control */
>> +	{ 0x28, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
>> +	/* unmute right and left channels for node 0x0a */
>> +	{ 0x0a, AC_VERB_SET_LEFT_AMP_IN_MUTE, 0x0},
>> +	{ 0x0a, AC_VERB_SET_RIGHT_AMP_IN_MUTE, 0x0},
>>     
>
> The below would do the same job with a single line:
>     { 0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0) }
>
>
>   
>> +	/* connect headphone jack to dac1 */
>> +	{ 0x0a, AC_VERB_SET_CONNECT_SEL, 0x01},
>> +	/* unmute right and left channels for node 0x0d */
>> +	{ 0x0d, AC_VERB_SET_LEFT_AMP_IN_MUTE, 0x0},
>> +	{ 0x0d, AC_VERB_SET_RIGHT_AMP_IN_MUTE, 0x0},
>> +	/* unmute right and left channels for node 0x0f */
>> +	{ 0x0f, AC_VERB_SET_LEFT_AMP_IN_MUTE, 0x0},
>> +	{ 0x0f, AC_VERB_SET_RIGHT_AMP_IN_MUTE, 0x0},
>> +	/* unmute mono out node */
>> +	{ 0x14, AC_VERB_SET_LEFT_AMP_IN_MUTE, 0x0},
>>  	{}
>>  };
>>     
>
> Ditto.
>
>
> Thanks,
>
> Takashi
>   
Hello Takashi,

Here is an updated and cleanup version of the last patch.
Thanks for pointing out the cruft in the previous patch.

Matt Ranstasy

--------------090603090306010105010603
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="stac92hd71bxx_update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stac92hd71bxx_update.patch"

diff -r b7f98e64be95 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Mon Nov 05 15:48:36 2007 +0100
+++ b/pci/hda/patch_sigmatel.c	Mon Nov 05 12:02:49 2007 -0500
@@ -62,6 +62,11 @@ enum {
 };
 
 enum {
+	STAC_92HD71BXX_REF,
+	STAC_92HD71BXX_MODELS
+};
+
+enum {
 	STAC_925x_REF,
 	STAC_M2_2,
 	STAC_MA6,
@@ -172,6 +177,23 @@ static hda_nid_t stac9200_dac_nids[1] = 
         0x02,
 };
 
+static hda_nid_t stac92hd71bxx_adc_nids[2] = {
+		0x12, 0x13,
+};
+
+static hda_nid_t stac92hd71bxx_mux_nids[2] = {
+		0x1a, 0x1b
+};
+
+static hda_nid_t stac92hd71bxx_dac_nids[2] = {
+		0x10, /*0x11, */
+};
+
+#define STAC92HD71BXX_NUM_DMICS	2
+static hda_nid_t stac92hd71bxx_dmic_nids[STAC92HD71BXX_NUM_DMICS + 1] = {
+		0x18, 0x19, 0
+};
+
 static hda_nid_t stac925x_adc_nids[1] = {
         0x03,
 };
@@ -236,6 +258,11 @@ static hda_nid_t stac922x_pin_nids[10] =
 static hda_nid_t stac922x_pin_nids[10] = {
 	0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
 	0x0f, 0x10, 0x11, 0x15, 0x1b,
+};
+
+static hda_nid_t stac92hd71bxx_pin_nids[10] = {
+	0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
+	0x0f, 0x14, 0x18, 0x19, 0x1e,
 };
 
 static hda_nid_t stac927x_pin_nids[14] = {
@@ -393,6 +420,20 @@ static struct hda_verb stac9200_eapd_ini
 	/* set dac0mux for dac converter */
 	{0x07, AC_VERB_SET_CONNECT_SEL, 0x00},
 	{0x08, AC_VERB_SET_EAPD_BTLENABLE, 0x02},
+	{}
+};
+
+static struct hda_verb stac92hd71bxx_core_init[] = {
+	/* set master volume and direct control */
+	{ 0x28, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
+	/* connect headphone jack to dac1 */
+	{ 0x0a, AC_VERB_SET_CONNECT_SEL, 0x01},
+	/* unmute right and left channels for nodes 0x0a, 0xd, 0x0f */
+	{ 0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{ 0x0d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{ 0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	/* unmute mono out node */
+	{ 0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 	{}
 };
 
@@ -480,6 +521,21 @@ static struct snd_kcontrol_new stac9200_
 	HDA_CODEC_VOLUME("Capture Volume", 0x0a, 0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x0a, 0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Capture Mux Volume", 0x0c, 0, HDA_OUTPUT),
+	{ } /* end */
+};
+
+static struct snd_kcontrol_new stac92hd71bxx_mixer[] = {
+	STAC_DIGITAL_INPUT_SOURCE(1),
+	STAC_INPUT_SOURCE(2),
+	STAC_VOLKNOB(0x28),
+
+	/* hardware gain controls */
+	HDA_CODEC_VOLUME("Digital Mic 1 Volume", 0x18, 0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Digital Mic 2 Volume", 0x19, 0, HDA_OUTPUT),
+
+	HDA_CODEC_VOLUME("Capture Volume", 0x1c, 0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Capture Switch", 0x1c, 0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Capture Mux Volume", 0x1a, 0, HDA_OUTPUT),
 	{ } /* end */
 };
 
@@ -835,6 +891,27 @@ static struct snd_pci_quirk stac925x_cfg
 	SND_PCI_QUIRK(0x107b, 0x0461, "Gateway NX560XL", STAC_MA6),
 	SND_PCI_QUIRK(0x107b, 0x0681, "Gateway NX860", STAC_PA6),
 	SND_PCI_QUIRK(0x1002, 0x437b, "Gateway MX6453", STAC_M2_2),
+	{} /* terminator */
+};
+
+static unsigned int ref92hd71bxx_pin_configs[10] = {
+	0x02214030, 0x02a19040, 0x01a19020, 0x01014010,
+	0x0181302e, 0x01114010, 0x01a19020, 0x90a000f0,
+	0x90a000f0, 0x01452050,
+};
+
+static unsigned int *stac92hd71bxx_brd_tbl[STAC_92HD71BXX_MODELS] = {
+	[STAC_92HD71BXX_REF] = ref92hd71bxx_pin_configs,
+};
+
+static const char *stac92hd71bxx_models[STAC_92HD71BXX_MODELS] = {
+	[STAC_92HD71BXX_REF] = "ref",
+};
+
+static struct snd_pci_quirk stac92hd71bxx_cfg_tbl[] = {
+	/* SigmaTel reference board */
+	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668,
+		      "DFI LanParty", STAC_92HD71BXX_REF),
 	{} /* terminator */
 };
 
@@ -2615,6 +2692,77 @@ static int patch_stac925x(struct hda_cod
 	return 0;
 }
 
+static int patch_stac92hd71bxx(struct hda_codec *codec)
+{
+	struct sigmatel_spec *spec;
+	int err = 0;
+
+	spec  = kzalloc(sizeof(*spec), GFP_KERNEL);
+	if (spec == NULL)
+		return -ENOMEM;
+
+	codec->spec = spec;
+	spec->num_pins = ARRAY_SIZE(stac92hd71bxx_pin_nids);
+	spec->pin_nids = stac92hd71bxx_pin_nids;
+	spec->board_config = snd_hda_check_board_config(codec,
+							STAC_92HD71BXX_MODELS,
+							stac92hd71bxx_models,
+							stac92hd71bxx_cfg_tbl);
+again:
+	if (spec->board_config < 0) {
+		snd_printdd(KERN_INFO "hda_codec: Unknown model for"
+			" STAC92HD71BXX, using BIOS defaults\n");
+		err = stac92xx_save_bios_config_regs(codec);
+		if (err < 0) {
+			stac92xx_free(codec);
+			return err;
+		}
+		spec->pin_configs = spec->bios_pin_configs;
+	} else {
+		spec->pin_configs = stac92hd71bxx_brd_tbl[spec->board_config];
+		stac92xx_set_config_regs(codec);
+	}
+
+	spec->gpio_mask = spec->gpio_data = 0x00000001; /* GPIO0 High = EAPD */
+	stac92xx_enable_gpio_mask(codec);
+
+	spec->init = stac92hd71bxx_core_init;
+	spec->mixer = stac92hd71bxx_mixer;
+
+	spec->mux_nids = stac92hd71bxx_mux_nids;
+	spec->adc_nids = stac92hd71bxx_adc_nids;
+	spec->dmic_nids = stac92hd71bxx_dmic_nids;
+	spec->dmux_nid = 0x1c;
+
+	spec->num_muxes = ARRAY_SIZE(stac92hd71bxx_mux_nids);
+	spec->num_adcs = ARRAY_SIZE(stac92hd71bxx_adc_nids);
+	spec->num_dmics = STAC92HD71BXX_NUM_DMICS;
+
+	spec->multiout.num_dacs = 2;
+	spec->multiout.hp_nid = 0x11;
+	spec->multiout.dac_nids = stac92hd71bxx_dac_nids;
+
+	err = stac92xx_parse_auto_config(codec, 0x21, 0x23);
+	if (!err) {
+		if (spec->board_config < 0) {
+			printk(KERN_WARNING "hda_codec: No auto-config is "
+			       "available, default to model=ref\n");
+			spec->board_config = STAC_92HD71BXX_REF;
+			goto again;
+		}
+		err = -EINVAL;
+	}
+
+	if (err < 0) {
+		stac92xx_free(codec);
+		return err;
+	}
+
+	codec->patch_ops = stac92xx_patch_ops;
+
+	return 0;
+};
+
 static int patch_stac922x(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec;
@@ -3183,5 +3331,6 @@ struct hda_codec_preset snd_hda_preset_s
  	{ .id = 0x838476a5, .name = "STAC9255D", .patch = patch_stac9205 },
  	{ .id = 0x838476a6, .name = "STAC9254", .patch = patch_stac9205 },
  	{ .id = 0x838476a7, .name = "STAC9254D", .patch = patch_stac9205 },
+	{ .id = 0x111d76b0, .name = "92HD71BXX", .patch = patch_stac92hd71bxx },
 	{} /* terminator */
 };

--------------090603090306010105010603
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------090603090306010105010603--
