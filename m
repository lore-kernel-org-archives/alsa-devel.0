From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: EAPD power management
Date: Sun, 13 Apr 2008 13:51:26 -0400
Message-ID: <4802481E.6010507@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp102.biz.mail.re2.yahoo.com (smtp102.biz.mail.re2.yahoo.com
	[68.142.229.216]) by alsa0.perex.cz (Postfix) with SMTP id 89D542481B
	for <alsa-devel@alsa-project.org>;
	Sun, 13 Apr 2008 19:51:25 +0200 (CEST)
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

Power management support for EAPD enabled laptops, when headphones
are sensed it pulls the EAPD GPIO line low to power it down.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---
diff -r 0dd2b6cb1506 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Wed Apr 09 08:16:33 2008 +0200
+++ b/pci/hda/patch_sigmatel.c	Fri Apr 11 15:09:39 2008 -0400
@@ -129,6 +129,7 @@ struct sigmatel_spec {
 	unsigned int hp_detect: 1;
 
 	/* gpio lines */
+	unsigned int eapd_mask;
 	unsigned int gpio_mask;
 	unsigned int gpio_dir;
 	unsigned int gpio_data;
@@ -3183,6 +3184,10 @@ static void stac92xx_hp_detect(struct hd
 		for (i = 0; i < cfg->speaker_outs; i++)
 			stac92xx_reset_pinctl(codec, cfg->speaker_pins[i],
 						AC_PINCTL_OUT_EN);
+		if (spec->eapd_mask)
+			stac_gpio_set(codec, spec->gpio_mask,
+				spec->gpio_dir, spec->gpio_data &
+				~spec->eapd_mask);
 	} else {
 		/* enable lineouts, disable hp */
 		for (i = 0; i < cfg->line_outs; i++)
@@ -3191,6 +3196,10 @@ static void stac92xx_hp_detect(struct hd
 		for (i = 0; i < cfg->speaker_outs; i++)
 			stac92xx_set_pinctl(codec, cfg->speaker_pins[i],
 						AC_PINCTL_OUT_EN);
+		if (spec->eapd_mask)
+			stac_gpio_set(codec, spec->gpio_mask,
+				spec->gpio_dir, spec->gpio_data |
+				spec->eapd_mask);
 	}
 } 
 
@@ -3478,7 +3487,7 @@ again:
 	spec->num_dmuxes = ARRAY_SIZE(stac92hd73xx_dmux_nids);
 	spec->dinput_mux = &stac92hd73xx_dmux;
 	/* GPIO0 High = Enable EAPD */
-	spec->gpio_mask = spec->gpio_dir = 0x1;
+	spec->eapd_mask = spec->gpio_mask = spec->gpio_dir = 0x1;
 	spec->gpio_data = 0x01;
 
 	switch (spec->board_config) {
@@ -3584,7 +3593,10 @@ again:
 	spec->aloopback_shift = 0;
 
 	/* GPIO0 High = EAPD */
-	spec->gpio_mask = spec->gpio_dir = spec->gpio_data = 0x1;
+	spec->gpio_mask = 0x01;
+	spec->gpio_dir = 0x01;
+	spec->gpio_mask = 0x01;
+	spec->gpio_data = 0x01;
 
 	spec->mux_nids = stac92hd71bxx_mux_nids;
 	spec->adc_nids = stac92hd71bxx_adc_nids;
@@ -3770,7 +3782,7 @@ static int patch_stac927x(struct hda_cod
 	case STAC_D965_3ST:
 	case STAC_D965_5ST:
 		/* GPIO0 High = Enable EAPD */
-		spec->gpio_mask = spec->gpio_dir = 0x01;
+		spec->eapd_mask = spec->gpio_mask = spec->gpio_dir = 0x01;
 		spec->gpio_data = 0x01;
 		spec->num_dmics = 0;
 
@@ -3787,7 +3799,7 @@ static int patch_stac927x(struct hda_cod
 		/* fallthru */
 	case STAC_DELL_3ST:
 		/* GPIO2 High = Enable EAPD */
-		spec->gpio_mask = spec->gpio_dir = 0x04;
+		spec->eapd_mask = spec->gpio_mask = spec->gpio_dir = 0x04;
 		spec->gpio_data = 0x04;
 		spec->dmic_nids = stac927x_dmic_nids;
 		spec->num_dmics = STAC927X_NUM_DMICS;
@@ -3799,7 +3811,7 @@ static int patch_stac927x(struct hda_cod
 		break;
 	default:
 		/* GPIO0 High = Enable EAPD */
-		spec->gpio_mask = spec->gpio_dir = 0x1;
+		spec->eapd_mask = spec->gpio_mask = spec->gpio_dir = 0x1;
 		spec->gpio_data = 0x01;
 		spec->num_dmics = 0;
 
@@ -3903,6 +3915,7 @@ static int patch_stac9205(struct hda_cod
 					  (AC_USRSP_EN | STAC_HP_EVENT));
 
 		spec->gpio_dir = 0x0b;
+		spec->eapd_mask = 0x01;
 		spec->gpio_mask = 0x1b;
 		spec->gpio_mute = 0x10;
 		/* GPIO0 High = EAPD, GPIO1 Low = Headphone Mute,
@@ -3912,7 +3925,7 @@ static int patch_stac9205(struct hda_cod
 		break;
 	default:
 		/* GPIO0 High = EAPD */
-		spec->gpio_mask = spec->gpio_dir = 0x1;
+		spec->eapd_mask = spec->gpio_mask = spec->gpio_dir = 0x1;
 		spec->gpio_data = 0x01;
 		break;
 	}
