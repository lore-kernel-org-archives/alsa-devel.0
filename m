From: renidragsemaj@yahoo.com
Subject: [[ALSA] Patch for HP dv4-1222nr laptop 1/1] Addition
	for HP dv4-1222nr laptop.
Date: Sun,  3 May 2009 04:00:44 -0400
Message-ID: <1241337644-8550-1-git-send-email-renidragsemaj@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: James Gardiner <renidragsemaj@yahoo.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: James Gardiner <renidragsemaj@yahoo.com>


Signed-off-by: James Gardiner <renidragsemaj@yahoo.com>

diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index 917bc5d..27bc568 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -100,6 +100,7 @@ enum {
 	STAC_HP_M4,
 	STAC_HP_DV5,
 	STAC_HP_HDX,
+	STAC_HP_DV4_1222NR,
 	STAC_92HD71BXX_MODELS
 };
 
@@ -1836,6 +1837,7 @@ static unsigned int *stac92hd71bxx_brd_tbl[STAC_92HD71BXX_MODELS] = {
 	[STAC_HP_M4]		= NULL,
 	[STAC_HP_DV5]		= NULL,
 	[STAC_HP_HDX]           = NULL,
+	[STAC_HP_DV4_1222NR]	= NULL,
 };
 
 static const char *stac92hd71bxx_models[STAC_92HD71BXX_MODELS] = {
@@ -1847,6 +1849,7 @@ static const char *stac92hd71bxx_models[STAC_92HD71BXX_MODELS] = {
 	[STAC_HP_M4] = "hp-m4",
 	[STAC_HP_DV5] = "hp-dv5",
 	[STAC_HP_HDX] = "hp-hdx",
+	[STAC_HP_DV4_1222NR] = "hp-dv4-1222nr",
 };
 
 static struct snd_pci_quirk stac92hd71bxx_cfg_tbl[] = {
@@ -1855,6 +1858,8 @@ static struct snd_pci_quirk stac92hd71bxx_cfg_tbl[] = {
 		      "DFI LanParty", STAC_92HD71BXX_REF),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DFI, 0x3101,
 		      "DFI LanParty", STAC_92HD71BXX_REF),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30fb,
+		      "HP dv4-1222nr", STAC_HP_DV4_1222NR),
 	SND_PCI_QUIRK_MASK(PCI_VENDOR_ID_HP, 0xfff0, 0x3080,
 		      "HP", STAC_HP_DV5),
 	SND_PCI_QUIRK_MASK(PCI_VENDOR_ID_HP, 0xfff0, 0x30f0,
@@ -4520,27 +4525,38 @@ static int stac92xx_resume(struct hda_codec *codec)
 	return 0;
 }
 
-
 /*
- * using power check for controlling mute led of HP HDX notebooks
+ * using power check for controlling mute led of HP notebooks
  * check for mute state only on Speakers (nid = 0x10)
  *
  * For this feature CONFIG_SND_HDA_POWER_SAVE is needed, otherwise
  * the LED is NOT working properly !
+ *
+ * Changed name to reflect that it now works for any designated
+ * model, not just HP HDX.
  */
 
 #ifdef CONFIG_SND_HDA_POWER_SAVE
-static int stac92xx_hp_hdx_check_power_status(struct hda_codec *codec,
+static int stac92xx_hp_check_power_status(struct hda_codec *codec,
 					      hda_nid_t nid)
 {
 	struct sigmatel_spec *spec = codec->spec;
+	unsigned int gpio_bit = 0; /* gets rid of compiler warning */
+
+	switch (spec->board_config) {
+	case STAC_HP_DV4_1222NR:
+		gpio_bit = 0x01;
+		break;
+	case STAC_HP_HDX:
+		gpio_bit = 0x08;
+	}
 
 	if (nid == 0x10) {
 		if (snd_hda_codec_amp_read(codec, nid, 0, HDA_OUTPUT, 0) &
 		    HDA_AMP_MUTE)
-			spec->gpio_data &= ~0x08;  /* orange */
+			spec->gpio_data &= ~gpio_bit;  /* orange */
 		else
-			spec->gpio_data |= 0x08;   /* white */
+			spec->gpio_data |= gpio_bit;   /* white */
 
 		stac_gpio_set(codec, spec->gpio_mask,
 			      spec->gpio_dir,
@@ -5219,6 +5235,22 @@ again:
 		spec->num_smuxes = 0;
 		spec->num_dmuxes = 1;
 		break;
+	case STAC_HP_DV4_1222NR:
+		spec->num_dmics = 1;
+		/* I don't know if it needs 1 or 2 smuxes - will wait for
+		 * bug reports to fix if needed
+		 */
+		spec->num_smuxes = 1;
+		spec->num_dmuxes = 1;
+#ifdef CONFIG_SND_HDA_POWER_SAVE
+		/* This controls MUTE LED */
+		spec->gpio_mask |= 0x01;
+		spec->gpio_dir  |= 0x01;
+		spec->gpio_data |= 0x01;
+		codec->patch_ops.check_power_status =
+		    stac92xx_hp_check_power_status;
+#endif
+		/* fallthrough */
 	case STAC_HP_DV5:
 		snd_hda_codec_set_pincfg(codec, 0x0d, 0x90170010);
 		stac92xx_auto_set_pinctl(codec, 0x0d, AC_PINCTL_OUT_EN);
@@ -5239,7 +5271,7 @@ again:
 
 		/* register check_power_status callback. */
 		codec->patch_ops.check_power_status =
-		    stac92xx_hp_hdx_check_power_status;
+		    stac92xx_hp_check_power_status;
 #endif	
 		break;
 	};
-- 
1.5.6.3
