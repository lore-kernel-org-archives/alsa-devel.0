From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: STAC927x DMIC Cleanup
Date: Fri, 14 Dec 2007 15:02:40 -0500
Message-ID: <4762E160.1060009@embeddedalley.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080603080406090606020902"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp106.biz.mail.mud.yahoo.com (smtp106.biz.mail.mud.yahoo.com
	[68.142.200.254])
	by alsa0.perex.cz (Postfix) with SMTP id C5A34103809
	for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2007 21:02:45 +0100 (CET)
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
Cc: tawai@suse.de
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080603080406090606020902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Cleaned up STAC927x and added several subsystem id's for more laptops.
---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

--------------080603080406090606020902
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="stac927x_dmic_cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stac927x_dmic_cleanup.patch"

diff -r 4a204306b295 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Fri Dec 14 14:42:41 2007 +0100
+++ b/pci/hda/patch_sigmatel.c	Fri Dec 14 12:37:16 2007 -0700
@@ -107,6 +107,7 @@ enum {
 	STAC_D965_3ST,
 	STAC_D965_5ST,
 	STAC_DELL_3ST,
+	STAC_DELL_BIOS,
 	STAC_927X_MODELS
 };
 
@@ -1408,22 +1409,24 @@ static unsigned int dell_3st_pin_configs
 static unsigned int dell_3st_pin_configs[14] = {
 	0x02211230, 0x02a11220, 0x01a19040, 0x01114210,
 	0x01111212, 0x01116211, 0x01813050, 0x01112214,
-	0x403003fa, 0x40000100, 0x40000100, 0x404003fb,
+	0x403003fa, 0x90a60040, 0x90a60040, 0x404003fb,
 	0x40c003fc, 0x40000100
 };
 
 static unsigned int *stac927x_brd_tbl[STAC_927X_MODELS] = {
-	[STAC_D965_REF] = ref927x_pin_configs,
-	[STAC_D965_3ST] = d965_3st_pin_configs,
-	[STAC_D965_5ST] = d965_5st_pin_configs,
-	[STAC_DELL_3ST] = dell_3st_pin_configs,
+	[STAC_D965_REF]  = ref927x_pin_configs,
+	[STAC_D965_3ST]  = d965_3st_pin_configs,
+	[STAC_D965_5ST]  = d965_5st_pin_configs,
+	[STAC_DELL_3ST]  = dell_3st_pin_configs,
+	[STAC_DELL_BIOS] = NULL,
 };
 
 static const char *stac927x_models[STAC_927X_MODELS] = {
-	[STAC_D965_REF]	= "ref",
-	[STAC_D965_3ST]	= "3stack",
-	[STAC_D965_5ST] = "5stack",
-	[STAC_DELL_3ST]	= "dell-3stack",
+	[STAC_D965_REF]		= "ref",
+	[STAC_D965_3ST]		= "3stack",
+	[STAC_D965_5ST]		= "5stack",
+	[STAC_DELL_3ST]		= "dell-3stack",
+	[STAC_DELL_BIOS]	= "dell-bios",
 };
 
 static struct snd_pci_quirk stac927x_cfg_tbl[] = {
@@ -1450,13 +1453,21 @@ static struct snd_pci_quirk stac927x_cfg
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2003, "Intel D965", STAC_D965_3ST),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2002, "Intel D965", STAC_D965_3ST),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2001, "Intel D965", STAC_D965_3ST),
-	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x01f3, "Dell Inspiron 1420", STAC_D965_3ST),
 	/* Dell 3 stack systems */
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x01f3, "Dell Inspiron 1420", STAC_DELL_3ST),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x01f7, "Dell XPS M1730", STAC_DELL_3ST),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x01dd, "Dell Dimension E520", STAC_DELL_3ST),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x01ed, "Dell     ", STAC_DELL_3ST),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x01f4, "Dell     ", STAC_DELL_3ST),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x0227, "Dell Vostro 1400  ", STAC_DELL_3ST),
+	/* Dell 3 stack systems with verb table in BIOS */
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x022f, "Dell     ", STAC_DELL_BIOS),
+    SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x022e, "Dell     ", STAC_DELL_BIOS),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x0242, "Dell     ", STAC_DELL_BIOS),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x0243, "Dell     ", STAC_DELL_BIOS),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x02ff, "Dell     ", STAC_DELL_BIOS),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x0209, "Dell XPS 1330", STAC_DELL_BIOS),
 	/* 965 based 5 stack systems */
-	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL,  0x0209, "Dell XPS 1330", STAC_D965_5ST),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2301, "Intel D965", STAC_D965_5ST),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2302, "Intel D965", STAC_D965_5ST),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2303, "Intel D965", STAC_D965_5ST),
@@ -1992,6 +2003,7 @@ static int stac92xx_add_dyn_out_pins(str
 	for (i = 0; i < codec->num_nodes; i++) {
 		wcaps = codec->wcaps[i];
 		wtype = (wcaps & AC_WCAP_TYPE) >> AC_WCAP_TYPE_SHIFT;
+
 		if (wtype == AC_WID_AUD_OUT && !(wcaps & AC_WCAP_DIGITAL))
 			num_dacs++;
 	}
@@ -2079,7 +2091,6 @@ static int stac92xx_auto_fill_dac_nids(s
 			wcaps = snd_hda_param_read(codec, conn[j],
 						   AC_PAR_AUDIO_WIDGET_CAP);
 			wtype = (wcaps & AC_WCAP_TYPE) >> AC_WCAP_TYPE_SHIFT;
-
 			if (wtype != AC_WID_AUD_OUT ||
 			    (wcaps & AC_WCAP_DIGITAL))
 				continue;
@@ -3293,8 +3304,11 @@ static int patch_stac927x(struct hda_cod
 							stac927x_models,
 							stac927x_cfg_tbl);
  again:
-	if (spec->board_config < 0) {
-                snd_printdd(KERN_INFO "hda_codec: Unknown model for STAC927x, using BIOS defaults\n");
+	if (spec->board_config < 0 ||
+	    stac927x_brd_tbl[spec->board_config] != NULL) {
+		if (spec->board_config < 0)
+			snd_printdd(KERN_INFO "hda_codec: Unknown model for"
+						"STAC927x, using BIOS defaults\n");
 		err = stac92xx_save_bios_config_regs(codec);
 		if (err < 0) {
 			stac92xx_free(codec);
@@ -3306,59 +3320,46 @@ static int patch_stac927x(struct hda_cod
 		stac92xx_set_config_regs(codec);
 	}
 
+	spec->adc_nids = stac927x_adc_nids;
+	spec->mux_nids = stac927x_mux_nids;
+	spec->num_muxes = ARRAY_SIZE(stac927x_mux_nids);
+	spec->num_adcs = ARRAY_SIZE(stac927x_adc_nids);
+	spec->multiout.dac_nids = spec->dac_nids;
+
 	switch (spec->board_config) {
 	case STAC_D965_3ST:
-		spec->adc_nids = stac927x_adc_nids;
-		spec->mux_nids = stac927x_mux_nids;
-		spec->num_muxes = ARRAY_SIZE(stac927x_mux_nids);
-		spec->num_adcs = ARRAY_SIZE(stac927x_adc_nids);
+	case STAC_D965_5ST:
+		/* GPIO0 High = Enable EAPD */
+		spec->gpio_mask = spec->gpio_data = 0x00000001;
+		spec->num_dmics = 0;
+
 		spec->init = d965_core_init;
 		spec->mixer = stac927x_mixer;
 		break;
-	case STAC_D965_5ST:
-		spec->adc_nids = stac927x_adc_nids;
-		spec->mux_nids = stac927x_mux_nids;
-		spec->num_muxes = ARRAY_SIZE(stac927x_mux_nids);
-		spec->num_adcs = ARRAY_SIZE(stac927x_adc_nids);
+	case STAC_DELL_BIOS:
+	case STAC_DELL_3ST:
+		/* GPIO2 High = Enable EAPD */
+		spec->gpio_mask = spec->gpio_data = 0x00000004;
+		spec->dmic_nids = stac927x_dmic_nids;
+		spec->num_dmics = STAC927X_NUM_DMICS;
+
 		spec->init = d965_core_init;
 		spec->mixer = stac927x_mixer;
+		spec->dmux_nids = stac927x_dmux_nids;
 		break;
 	default:
-		spec->adc_nids = stac927x_adc_nids;
-		spec->mux_nids = stac927x_mux_nids;
-		spec->num_muxes = ARRAY_SIZE(stac927x_mux_nids);
-		spec->num_adcs = ARRAY_SIZE(stac927x_adc_nids);
+		/* GPIO0 High = Enable EAPD */
+		spec->gpio_mask = spec->gpio_data = 0x00000001;
+		spec->num_dmics = 0;
+
 		spec->init = stac927x_core_init;
 		spec->mixer = stac927x_mixer;
 	}
 
-	switch (codec->subsystem_id) {
-	case 0x10280242: /* STAC 9228 */
-	case 0x102801f3:
-	case 0x1028020A:
-	case 0x10280209:
-		spec->dmic_nids = stac927x_dmic_nids;
-		spec->num_dmics = STAC927X_NUM_DMICS;
-		spec->dmux_nids = stac927x_dmux_nids;
-
-		/* Enable DMIC0 */
-		stac92xx_set_config_reg(codec, 0x13, 0x90a60040);
-
-		/* GPIO2 High = Enable EAPD */
-		spec->gpio_mask = spec->gpio_data = 0x00000004;
-		break;
-	default:
-		spec->num_dmics = 0;
-
-		/* GPIO0 High = Enable EAPD */
-		spec->gpio_mask = spec->gpio_data = 0x00000001;
-	}
-
-	spec->multiout.dac_nids = spec->dac_nids;
 	spec->aloopback_mask = 0x40;
 	spec->aloopback_shift = 0;
+
 	stac92xx_enable_gpio_mask(codec); 
-	
 	err = stac92xx_parse_auto_config(codec, 0x1e, 0x20);
 	if (!err) {
 		if (spec->board_config < 0) {

--------------080603080406090606020902
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080603080406090606020902--
