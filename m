From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: Add GPIO mute support to STAC9205
Date: Mon, 28 Jan 2008 09:48:00 -0500
Message-ID: <479DEB20.70302@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp102.biz.mail.re2.yahoo.com (smtp102.biz.mail.re2.yahoo.com
	[68.142.229.216]) by alsa0.perex.cz (Postfix) with SMTP id 3CF2524628
	for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2008 15:48:04 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, "Tellman, Steven" <Steven.Tellman@idt.com>, Matt Porter <mporter@embeddedalley.com>
List-Id: alsa-devel@alsa-project.org

Support added for detecting HP jack presence via GPIO on several laptop docks.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---
diff -r b0d97ac73e0f pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Fri Jan 25 15:24:50 2008 +0100
+++ b/pci/hda/patch_sigmatel.c	Mon Jan 28 09:34:16 2008 -0500
@@ -122,7 +122,9 @@ struct sigmatel_spec {
 	unsigned int alt_switch: 1;
 	unsigned int hp_detect: 1;
 
-	unsigned int gpio_mask, gpio_data;
+	unsigned int gpio_en_mask, gpio_dir_mask;
+	unsigned int gpio_data;
+	unsigned int gpio_mute;
 	unsigned char aloopback_mask;
 	unsigned char aloopback_shift;
 
@@ -2801,22 +2803,22 @@ static int stac9200_parse_auto_config(st
  * funky external mute control using GPIO pins.
  */
 
-static void stac_gpio_set(struct hda_codec *codec, unsigned int mask,
-			  unsigned int data)
+static void stac_gpio_set(struct hda_codec *codec, unsigned int en_mask,
+			  unsigned int dir_mask, unsigned int data)
 {
 	unsigned int gpiostate, gpiomask, gpiodir;
 
 	gpiostate = snd_hda_codec_read(codec, codec->afg, 0,
 				       AC_VERB_GET_GPIO_DATA, 0);
-	gpiostate = (gpiostate & ~mask) | (data & mask);
+	gpiostate = (gpiostate & ~dir_mask) | (data & dir_mask);
 
 	gpiomask = snd_hda_codec_read(codec, codec->afg, 0,
 				      AC_VERB_GET_GPIO_MASK, 0);
-	gpiomask |= mask;
+	gpiomask |= en_mask;
 
 	gpiodir = snd_hda_codec_read(codec, codec->afg, 0,
 				     AC_VERB_GET_GPIO_DIRECTION, 0);
-	gpiodir |= mask;
+	gpiodir |= dir_mask;
 
 	/* Configure GPIOx as CMOS */
 	snd_hda_codec_write(codec, codec->afg, 0, 0x7e7, 0);
@@ -2911,7 +2913,8 @@ static int stac92xx_init(struct hda_code
 		stac92xx_auto_set_pinctl(codec, cfg->dig_in_pin,
 					 AC_PINCTL_IN_EN);
 
-	stac_gpio_set(codec, spec->gpio_mask, spec->gpio_data);
+	stac_gpio_set(codec, spec->gpio_en_mask,
+					spec->gpio_dir_mask, spec->gpio_data);
 
 	return 0;
 }
@@ -3001,10 +3004,14 @@ static void stac92xx_hp_detect(struct hd
 	int i, presence;
 
 	presence = 0;
+	if (spec->gpio_mute)
+		presence = !(snd_hda_codec_read(codec, codec->afg, 0,
+			AC_VERB_GET_GPIO_DATA, 0) & spec->gpio_mute);
+
 	for (i = 0; i < cfg->hp_outs; i++) {
-		presence = get_hp_pin_presence(codec, cfg->hp_pins[i]);
 		if (presence)
 			break;
+		presence = get_hp_pin_presence(codec, cfg->hp_pins[i]);
 	}
 
 	if (presence) {
@@ -3067,7 +3074,8 @@ static int stac92xx_resume(struct hda_co
 
 	stac92xx_set_config_regs(codec);
 	snd_hda_sequence_write(codec, spec->init);
-	stac_gpio_set(codec, spec->gpio_mask, spec->gpio_data);
+	stac_gpio_set(codec, spec->gpio_en_mask,
+		spec->gpio_dir_mask, spec->gpio_data);
 	snd_hda_codec_resume_amp(codec);
 	snd_hda_codec_resume_cache(codec);
 	/* invoke unsolicited event to reset the HP state */
@@ -3301,7 +3309,8 @@ again:
 	spec->num_dmuxes = ARRAY_SIZE(stac92hd73xx_dmux_nids);
 	spec->dinput_mux = &stac92hd73xx_dmux;
 	/* GPIO0 High = Enable EAPD */
-	spec->gpio_mask = spec->gpio_data = 0x000001;
+	spec->gpio_en_mask = spec->gpio_dir_mask = 0x1;
+	spec->gpio_data = 0x01;
 
 	spec->num_pwrs = ARRAY_SIZE(stac92hd73xx_pwr_nids);
 	spec->pwr_nids = stac92hd73xx_pwr_nids;
@@ -3375,7 +3384,8 @@ again:
 	spec->aloopback_mask = 0x20;
 	spec->aloopback_shift = 0;
 
-	spec->gpio_mask = spec->gpio_data = 0x00000001; /* GPIO0 High = EAPD */
+	/* GPIO0 High = EAPD */
+	spec->gpio_en_mask = spec->gpio_dir_mask = spec->gpio_data = 0x1;
 
 	spec->mux_nids = stac92hd71bxx_mux_nids;
 	spec->adc_nids = stac92hd71bxx_adc_nids;
@@ -3431,7 +3441,8 @@ static int patch_stac922x(struct hda_cod
 							stac922x_models,
 							stac922x_cfg_tbl);
 	if (spec->board_config == STAC_INTEL_MAC_V3) {
-		spec->gpio_mask = spec->gpio_data = 0x03;
+		spec->gpio_en_mask = spec->gpio_dir_mask = 0x03;
+		spec->gpio_data = 0x03;
 		/* Intel Macs have all same PCI SSID, so we need to check
 		 * codec SSID to distinguish the exact models
 		 */
@@ -3559,7 +3570,8 @@ static int patch_stac927x(struct hda_cod
 	case STAC_D965_3ST:
 	case STAC_D965_5ST:
 		/* GPIO0 High = Enable EAPD */
-		spec->gpio_mask = spec->gpio_data = 0x00000001;
+		spec->gpio_en_mask = spec->gpio_dir_mask = 0x01;
+		spec->gpio_data = 0x01;
 		spec->num_dmics = 0;
 
 		spec->init = d965_core_init;
@@ -3573,7 +3585,8 @@ static int patch_stac927x(struct hda_cod
 		/* fallthru */
 	case STAC_DELL_3ST:
 		/* GPIO2 High = Enable EAPD */
-		spec->gpio_mask = spec->gpio_data = 0x00000004;
+		spec->gpio_en_mask = spec->gpio_dir_mask = 0x04;
+		spec->gpio_data = 0x04;
 		spec->dmic_nids = stac927x_dmic_nids;
 		spec->num_dmics = STAC927X_NUM_DMICS;
 
@@ -3584,7 +3597,8 @@ static int patch_stac927x(struct hda_cod
 		break;
 	default:
 		/* GPIO0 High = Enable EAPD */
-		spec->gpio_mask = spec->gpio_data = 0x00000001;
+		spec->gpio_en_mask = spec->gpio_dir_mask = 0x1;
+		spec->gpio_data = 0x01;
 		spec->num_dmics = 0;
 
 		spec->init = stac927x_core_init;
@@ -3679,15 +3693,25 @@ static int patch_stac9205(struct hda_cod
 		stac92xx_set_config_reg(codec, 0x1f, 0x01441030);
 		stac92xx_set_config_reg(codec, 0x20, 0x1c410030);
 
-		spec->gpio_mask = 0x0000000b;
+		/* Enable unsol response for GPIO4/Dock HP connection */
+		snd_hda_codec_write(codec, codec->afg, 0,
+			AC_VERB_SET_GPIO_UNSOLICITED_RSP_MASK, 0x10);
+		snd_hda_codec_write_cache(codec, codec->afg, 0,
+					  AC_VERB_SET_UNSOLICITED_ENABLE,
+					  (AC_USRSP_EN | STAC_HP_EVENT));
+
+		spec->gpio_dir_mask = 0x0b;
+		spec->gpio_en_mask = 0x1b;
+		spec->gpio_mute = 0x10;
 		/* GPIO0 High = EAPD, GPIO1 Low = Headphone Mute,
-		 * GPIO3 High = DRM
+		 * GPIO3 Low = DRM
 		 */
-		spec->gpio_data = 0x00000009;
+		spec->gpio_data = 0x01;
 		break;
 	default:
 		/* GPIO0 High = EAPD */
-		spec->gpio_mask = spec->gpio_data = 0x00000001;
+		spec->gpio_en_mask = spec->gpio_dir_mask = 0x1;
+		spec->gpio_data = 0x01;
 		break;
 	}
