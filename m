From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: Re: [PATCH] hda: 92HDxxxx PCI Quirks
Date: Wed, 20 Feb 2008 21:14:28 -0500
Message-ID: <47BCDE84.4020608@embeddedalley.com>
References: <47BCADE6.9010904@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp108.biz.mail.re2.yahoo.com (smtp108.biz.mail.re2.yahoo.com
	[206.190.52.47]) by alsa0.perex.cz (Postfix) with SMTP id CC78424597
	for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2008 03:14:56 +0100 (CET)
In-Reply-To: <47BCADE6.9010904@embeddedalley.com>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Matthew Ranostay wrote:
> Added PCI_QUIRKS for laptop that have the 92HDxxx family of codecs.
> 
> Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
> ---
> diff -r 6b53fa114faa pci/hda/patch_sigmatel.c
> --- a/pci/hda/patch_sigmatel.c	Tue Feb 19 15:03:57 2008 +0100
> +++ b/pci/hda/patch_sigmatel.c	Wed Feb 20 17:18:15 2008 -0500
> @@ -64,11 +64,14 @@ enum {
>  
>  enum {
>  	STAC_92HD73XX_REF,
> +	STAC_DELL_M6_5ST,
>  	STAC_92HD73XX_MODELS
>  };
>  
>  enum {
>  	STAC_92HD71BXX_REF,
> +	STAC_DELL_M4_5ST,
> +	STAC_DELL_M4_6ST,
>  	STAC_92HD71BXX_MODELS
>  };
>  
> @@ -334,10 +337,10 @@ static hda_nid_t stac922x_pin_nids[10] =
>  	0x0f, 0x10, 0x11, 0x15, 0x1b,
>  };
>  
> -static hda_nid_t stac92hd73xx_pin_nids[12] = {
> +static hda_nid_t stac92hd73xx_pin_nids[13] = {
>  	0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
>  	0x0f, 0x10, 0x11, 0x12, 0x13,
> -	0x14, 0x22
> +	0x14, 0x1e, 0x22
>  };
>  
>  static hda_nid_t stac92hd71bxx_pin_nids[10] = {
> @@ -1220,24 +1223,48 @@ static struct snd_pci_quirk stac925x_cfg
>  	{} /* terminator */
>  };
>  
> -static unsigned int ref92hd73xx_pin_configs[12] = {
> +static unsigned int ref92hd73xx_pin_configs[13] = {
>  	0x02214030, 0x02a19040, 0x01a19020, 0x02214030,
>  	0x0181302e, 0x01014010, 0x01014020, 0x01014030,
>  	0x02319040, 0x90a000f0, 0x90a000f0, 0x01452050,
> +	0x01452050,
> +};
> +
> +static unsigned int dell_m6_5st_pin_configs[13] = {
> +	0x0321101f, 0x4f00000f, 0x4f0000f0, 0x90170110,
> +	0x03a11020, 0x03011050, 0x4f0000f0, 0x4f0000f0,
> +	0x4f0000f0, 0x90a60160, 0x4f0000f0, 0x4f0000f0,
> +	0x4f0000f0,
>  };
>  
>  static unsigned int *stac92hd73xx_brd_tbl[STAC_92HD73XX_MODELS] = {
> -	[STAC_92HD73XX_REF] = ref92hd73xx_pin_configs,
> +	[STAC_92HD73XX_REF]	= ref92hd73xx_pin_configs,
> +	[STAC_DELL_M6_5ST]	= dell_m6_5st_pin_configs,
>  };
>  
>  static const char *stac92hd73xx_models[STAC_92HD73XX_MODELS] = {
>  	[STAC_92HD73XX_REF] = "ref",
> +	[STAC_DELL_M6_5ST] = "dell-m6-5stack",
>  };
>  
>  static struct snd_pci_quirk stac92hd73xx_cfg_tbl[] = {
>  	/* SigmaTel reference board */
>  	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668,
> -		      "DFI LanParty", STAC_92HD73XX_REF),
> +				"DFI LanParty", STAC_92HD73XX_REF),
> +	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0254,
> +				"unknown Dell", STAC_DELL_M6_5ST),
> +	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0255,
> +				"unknown Dell", STAC_DELL_M6_5ST),
> +	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0256,
> +				"unknown Dell", STAC_DELL_M6_5ST),
> +	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0257,
> +				"unknown Dell", STAC_DELL_M6_5ST),
> +	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x025e,
> +				"unknown Dell", STAC_DELL_M6_5ST),
> +	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x025f,
> +				"unknown Dell", STAC_DELL_M6_5ST),
> +	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0271,
> +				"unknown Dell", STAC_DELL_M6_5ST),
>  	{} /* terminator */
>  };
>  
> @@ -1247,18 +1274,56 @@ static unsigned int ref92hd71bxx_pin_con
>  	0x90a000f0, 0x01452050,
>  };
>  
> +static unsigned int dell_m4_5st_pin_configs[13] = {
> +	0x0421101f, 0x04a11221, 0x40f000f0, 0x90170110,
> +	0x23a1902e, 0x23014250, 0x40f000f0, 0x4f0000f0,
> +	0x40f000f0, 0x4f0000f0,
> +};
> +
> +static unsigned int dell_m4_6st_pin_configs[13] = {
> +	0x0421101f, 0x04a11221, 0x90a70330, 0x90170110,
> +	0x23a1902e, 0x23014250, 0x40f000f0, 0x40f000f0,
> +	0x40f000f0, 0x044413b0,
> +};
> +
>  static unsigned int *stac92hd71bxx_brd_tbl[STAC_92HD71BXX_MODELS] = {
>  	[STAC_92HD71BXX_REF] = ref92hd71bxx_pin_configs,
> +	[STAC_DELL_M4_5ST]	= dell_m4_5st_pin_configs,
> +	[STAC_DELL_M4_6ST]	= dell_m4_6st_pin_configs,
>  };
>  
>  static const char *stac92hd71bxx_models[STAC_92HD71BXX_MODELS] = {
>  	[STAC_92HD71BXX_REF] = "ref",
> +	[STAC_DELL_M4_5ST] = "dell-m4-5stack",
> +	[STAC_DELL_M4_6ST] = "dell-m4-6stack",
>  };
>  
>  static struct snd_pci_quirk stac92hd71bxx_cfg_tbl[] = {
>  	/* SigmaTel reference board */
>  	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668,
>  		      "DFI LanParty", STAC_92HD71BXX_REF),
> +	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0233,
> +				"unknown Dell", STAC_DELL_M4_5ST),
> +	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0234,
> +				"unknown Dell", STAC_DELL_M4_5ST),
> +	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0250,
> +				"unknown Dell", STAC_DELL_M4_5ST),
> +	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x024f,
> +				"unknown Dell", STAC_DELL_M4_5ST),
> +	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x024d,
> +				"unknown Dell", STAC_DELL_M4_5ST),
> +	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0251,
> +				"unknown Dell", STAC_DELL_M4_5ST),
> +	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0277,
> +				"unknown Dell", STAC_DELL_M4_5ST),
> +	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0263,
> +				"unknown Dell", STAC_DELL_M4_6ST),
> +	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0265,
> +				"unknown Dell", STAC_DELL_M4_6ST),
> +	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0262,
> +				"unknown Dell", STAC_DELL_M4_6ST),
> +	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0264,
> +				"unknown Dell", STAC_DELL_M4_6ST),
>  	{} /* terminator */
>  };
>  
> @@ -3355,12 +3420,38 @@ again:
>  
>  	spec->num_muxes = ARRAY_SIZE(stac92hd73xx_mux_nids);
>  	spec->num_adcs = ARRAY_SIZE(stac92hd73xx_adc_nids);
> -	spec->num_dmics = STAC92HD73XX_NUM_DMICS;
>  	spec->num_dmuxes = ARRAY_SIZE(stac92hd73xx_dmux_nids);
>  	spec->dinput_mux = &stac92hd73xx_dmux;
>  	/* GPIO0 High = Enable EAPD */
>  	spec->gpio_mask = spec->gpio_dir = 0x1;
>  	spec->gpio_data = 0x01;
> +
> +	switch (spec->board_config) {
> +	case STAC_DELL_M6_5ST:
> +		switch (codec->subsystem_id) {
> +		case 0x1028025e: /* Analog Mics */
> +		case 0x1028025f:
> +			stac92xx_set_config_reg(codec, 0x0b, 0x90A70170);
> +			spec->num_dmics = 0;
> +			break;
> +		case 0x10280254: /* Digital Mics */
> +		case 0x10280255:
> +		case 0x10280271:
> +		case 0x10280272:
> +			stac92xx_set_config_reg(codec, 0x13, 0x90A60160);
> +			spec->num_dmics = 1;
> +			break;
> +		case 0x10280256: /* Both */
> +		case 0x10280057:
> +			stac92xx_set_config_reg(codec, 0x0b, 0x90A70170);
> +			stac92xx_set_config_reg(codec, 0x13, 0x90A60160);
> +			spec->num_dmics = 1;
> +			break;
> +		}
> +		break;
> +	default:
> +		spec->num_dmics = STAC92HD73XX_NUM_DMICS;
> +	}
>  
>  	spec->num_pwrs = ARRAY_SIZE(stac92hd73xx_pwr_nids);
>  	spec->pwr_nids = stac92hd73xx_pwr_nids;
> 

Hello Takashi,

Please disregard my last patch I got the naming scheme totally wrong
for the pin configs. Here is the correct method below.

---
Added PCI_QUIRKS for laptop that have the 92HDxxx family of codecs.
 
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---
diff -r 6b53fa114faa pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Tue Feb 19 15:03:57 2008 +0100
+++ b/pci/hda/patch_sigmatel.c	Wed Feb 20 20:58:23 2008 -0500
@@ -64,11 +64,14 @@ enum {
 
 enum {
 	STAC_92HD73XX_REF,
+	STAC_DELL_M6,
 	STAC_92HD73XX_MODELS
 };
 
 enum {
 	STAC_92HD71BXX_REF,
+	STAC_DELL_M4_1,
+	STAC_DELL_M4_2,
 	STAC_92HD71BXX_MODELS
 };
 
@@ -334,10 +337,10 @@ static hda_nid_t stac922x_pin_nids[10] =
 	0x0f, 0x10, 0x11, 0x15, 0x1b,
 };
 
-static hda_nid_t stac92hd73xx_pin_nids[12] = {
+static hda_nid_t stac92hd73xx_pin_nids[13] = {
 	0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
 	0x0f, 0x10, 0x11, 0x12, 0x13,
-	0x14, 0x22
+	0x14, 0x1e, 0x22
 };
 
 static hda_nid_t stac92hd71bxx_pin_nids[10] = {
@@ -1220,24 +1223,48 @@ static struct snd_pci_quirk stac925x_cfg
 	{} /* terminator */
 };
 
-static unsigned int ref92hd73xx_pin_configs[12] = {
+static unsigned int ref92hd73xx_pin_configs[13] = {
 	0x02214030, 0x02a19040, 0x01a19020, 0x02214030,
 	0x0181302e, 0x01014010, 0x01014020, 0x01014030,
 	0x02319040, 0x90a000f0, 0x90a000f0, 0x01452050,
+	0x01452050,
+};
+
+static unsigned int dell_m6_pin_configs[13] = {
+	0x0321101f, 0x4f00000f, 0x4f0000f0, 0x90170110,
+	0x03a11020, 0x03011050, 0x4f0000f0, 0x4f0000f0,
+	0x4f0000f0, 0x90a60160, 0x4f0000f0, 0x4f0000f0,
+	0x4f0000f0,
 };
 
 static unsigned int *stac92hd73xx_brd_tbl[STAC_92HD73XX_MODELS] = {
-	[STAC_92HD73XX_REF] = ref92hd73xx_pin_configs,
+	[STAC_92HD73XX_REF]	= ref92hd73xx_pin_configs,
+	[STAC_DELL_M6]	= dell_m6_pin_configs,
 };
 
 static const char *stac92hd73xx_models[STAC_92HD73XX_MODELS] = {
 	[STAC_92HD73XX_REF] = "ref",
+	[STAC_DELL_M6] = "dell-m6",
 };
 
 static struct snd_pci_quirk stac92hd73xx_cfg_tbl[] = {
 	/* SigmaTel reference board */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668,
-		      "DFI LanParty", STAC_92HD73XX_REF),
+				"DFI LanParty", STAC_92HD73XX_REF),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0254,
+				"unknown Dell", STAC_DELL_M6),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0255,
+				"unknown Dell", STAC_DELL_M6),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0256,
+				"unknown Dell", STAC_DELL_M6),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0257,
+				"unknown Dell", STAC_DELL_M6),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x025e,
+				"unknown Dell", STAC_DELL_M6),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x025f,
+				"unknown Dell", STAC_DELL_M6),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0271,
+				"unknown Dell", STAC_DELL_M6),
 	{} /* terminator */
 };
 
@@ -1247,18 +1274,56 @@ static unsigned int ref92hd71bxx_pin_con
 	0x90a000f0, 0x01452050,
 };
 
+static unsigned int dell_m4_1_pin_configs[13] = {
+	0x0421101f, 0x04a11221, 0x40f000f0, 0x90170110,
+	0x23a1902e, 0x23014250, 0x40f000f0, 0x4f0000f0,
+	0x40f000f0, 0x4f0000f0,
+};
+
+static unsigned int dell_m4_2_pin_configs[13] = {
+	0x0421101f, 0x04a11221, 0x90a70330, 0x90170110,
+	0x23a1902e, 0x23014250, 0x40f000f0, 0x40f000f0,
+	0x40f000f0, 0x044413b0,
+};
+
 static unsigned int *stac92hd71bxx_brd_tbl[STAC_92HD71BXX_MODELS] = {
 	[STAC_92HD71BXX_REF] = ref92hd71bxx_pin_configs,
+	[STAC_DELL_M4_1]	= dell_m4_1_pin_configs,
+	[STAC_DELL_M4_2]	= dell_m4_2_pin_configs,
 };
 
 static const char *stac92hd71bxx_models[STAC_92HD71BXX_MODELS] = {
 	[STAC_92HD71BXX_REF] = "ref",
+	[STAC_DELL_M4_1] = "dell-m4-1",
+	[STAC_DELL_M4_2] = "dell-m4-2",
 };
 
 static struct snd_pci_quirk stac92hd71bxx_cfg_tbl[] = {
 	/* SigmaTel reference board */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668,
 		      "DFI LanParty", STAC_92HD71BXX_REF),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0233,
+				"unknown Dell", STAC_DELL_M4_1),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0234,
+				"unknown Dell", STAC_DELL_M4_1),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0250,
+				"unknown Dell", STAC_DELL_M4_1),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x024f,
+				"unknown Dell", STAC_DELL_M4_1),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x024d,
+				"unknown Dell", STAC_DELL_M4_1),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0251,
+				"unknown Dell", STAC_DELL_M4_1),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0277,
+				"unknown Dell", STAC_DELL_M4_1),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0263,
+				"unknown Dell", STAC_DELL_M4_2),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0265,
+				"unknown Dell", STAC_DELL_M4_2),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0262,
+				"unknown Dell", STAC_DELL_M4_2),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0264,
+				"unknown Dell", STAC_DELL_M4_2),
 	{} /* terminator */
 };
 
@@ -3355,12 +3420,38 @@ again:
 
 	spec->num_muxes = ARRAY_SIZE(stac92hd73xx_mux_nids);
 	spec->num_adcs = ARRAY_SIZE(stac92hd73xx_adc_nids);
-	spec->num_dmics = STAC92HD73XX_NUM_DMICS;
 	spec->num_dmuxes = ARRAY_SIZE(stac92hd73xx_dmux_nids);
 	spec->dinput_mux = &stac92hd73xx_dmux;
 	/* GPIO0 High = Enable EAPD */
 	spec->gpio_mask = spec->gpio_dir = 0x1;
 	spec->gpio_data = 0x01;
+
+	switch (spec->board_config) {
+	case STAC_DELL_M6:
+		switch (codec->subsystem_id) {
+		case 0x1028025e: /* Analog Mics */
+		case 0x1028025f:
+			stac92xx_set_config_reg(codec, 0x0b, 0x90A70170);
+			spec->num_dmics = 0;
+			break;
+		case 0x10280254: /* Digital Mics */
+		case 0x10280255:
+		case 0x10280271:
+		case 0x10280272:
+			stac92xx_set_config_reg(codec, 0x13, 0x90A60160);
+			spec->num_dmics = 1;
+			break;
+		case 0x10280256: /* Both */
+		case 0x10280057:
+			stac92xx_set_config_reg(codec, 0x0b, 0x90A70170);
+			stac92xx_set_config_reg(codec, 0x13, 0x90A60160);
+			spec->num_dmics = 1;
+			break;
+		}
+		break;
+	default:
+		spec->num_dmics = STAC92HD73XX_NUM_DMICS;
+	}
 
 	spec->num_pwrs = ARRAY_SIZE(stac92hd73xx_pwr_nids);
 	spec->pwr_nids = stac92hd73xx_pwr_nids;
