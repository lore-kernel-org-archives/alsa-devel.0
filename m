From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: 92xx S/PDIF In support
Date: Fri, 26 Sep 2008 10:06:40 -0400
Message-ID: <48DCEC70.6050907@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 4C2082414D
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Sep 2008 16:06:51 +0200 (CEST)
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

Add support for S/PDIF IN on reference boards quirks. Also disable the
IEC958 capture switch on boards with GPIO0 enabled.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index b5c1449..128b8a1 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -1245,7 +1245,7 @@ static int stac92xx_build_controls(struct hda_codec *codec)
 			return err;
 		spec->multiout.share_spdif = 1;
 	}
-	if (spec->dig_in_nid) {
+	if (spec->dig_in_nid && (!spec->gpio_dir & 0x01)) {
 		err = snd_hda_create_spdif_in_ctls(codec, spec->dig_in_nid);
 		if (err < 0)
 			return err;
@@ -4075,10 +4075,6 @@ again:
 	memcpy(&spec->private_dimux, &stac92hd73xx_dmux,
 			sizeof(stac92hd73xx_dmux));

-	/* GPIO0 High = Enable EAPD */
-	spec->eapd_mask = spec->gpio_mask = spec->gpio_dir = 0x1;
-	spec->gpio_data = 0x01;
-
 	switch (spec->board_config) {
 	case STAC_DELL_M6:
 		spec->init = dell_eq_core_init;
@@ -4118,6 +4114,11 @@ again:
 		spec->num_dmics = STAC92HD73XX_NUM_DMICS;
 		spec->num_smuxes = ARRAY_SIZE(stac92hd73xx_smux_nids);
 	}
+	if (spec->board_config > STAC_92HD73XX_REF) {
+		/* GPIO0 High = Enable EAPD */
+		spec->eapd_mask = spec->gpio_mask = spec->gpio_dir = 0x1;
+		spec->gpio_data = 0x01;
+	}
 	spec->dinput_mux = &spec->private_dimux;

 	spec->num_pwrs = ARRAY_SIZE(stac92hd73xx_pwr_nids);
@@ -4354,10 +4355,12 @@ again:
 	spec->aloopback_mask = 0x20;
 	spec->aloopback_shift = 0;

-	/* GPIO0 High = EAPD */
-	spec->gpio_mask = 0x01;
-	spec->gpio_dir = 0x01;
-	spec->gpio_data = 0x01;
+	if (spec->board_config > STAC_92HD71BXX_REF) {
+		/* GPIO0 = EAPD */
+		spec->gpio_mask = 0x01;
+		spec->gpio_dir = 0x01;
+		spec->gpio_data = 0x01;
+	}

 	spec->powerdown_adcs = 1;
 	spec->digbeep_nid = 0x26;
@@ -4599,9 +4602,11 @@ static int patch_stac927x(struct hda_codec *codec)
 		spec->num_dmuxes = ARRAY_SIZE(stac927x_dmux_nids);
 		break;
 	default:
-		/* GPIO0 High = Enable EAPD */
-		spec->eapd_mask = spec->gpio_mask = spec->gpio_dir = 0x1;
-		spec->gpio_data = 0x01;
+		if (spec->board_config > STAC_D965_REF) {
+			/* GPIO0 High = Enable EAPD */
+			spec->eapd_mask = spec->gpio_mask = 0x01;
+			spec->gpio_dir = spec->gpio_data = 0x01;
+		}
 		spec->num_dmics = 0;

 		spec->init = stac927x_core_init;
@@ -4715,6 +4720,9 @@ static int patch_stac9205(struct hda_codec *codec)
 		 */
 		spec->gpio_data = 0x01;
 		break;
+	case STAC_9205_REF:
+		/* SPDIF-In enabled */
+		break;
 	default:
 		/* GPIO0 High = EAPD */
 		spec->eapd_mask = spec->gpio_mask = spec->gpio_dir = 0x1;
