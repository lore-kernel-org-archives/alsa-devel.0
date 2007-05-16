From: Tobin Davis <tdavis@dsl-only.net>
Subject: HDA:  Add support for Gateway NX860
Date: Wed, 16 May 2007 11:33:26 -0700
Message-ID: <1179340406.4415.227.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-bfDhKz15MNEsM/UpuncG"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 69EC32438A
	for <alsa-devel@alsa-project.org>;
	Wed, 16 May 2007 20:33:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Developers <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--=-bfDhKz15MNEsM/UpuncG
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds support for the Gateway NX860 system.


Signed off by Tobin Davis <tdavis@dsl-only.net>

--=-bfDhKz15MNEsM/UpuncG
Content-Disposition: attachment; filename=Gateway-NX860.patch
Content-Type: text/x-patch; name=Gateway-NX860.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 5bd948503866 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Tue May 15 11:47:48 2007 +0200
+++ b/pci/hda/patch_sigmatel.c	Wed May 16 11:33:17 2007 -0700
@@ -51,6 +51,7 @@ enum {
 	STAC_925x_REF,
 	STAC_M2_2,
 	STAC_MA6,
+	STAC_PA6,
 	STAC_925x_MODELS
 };
 
@@ -150,6 +151,10 @@ static hda_nid_t stac925x_mux_nids[1] = 
 
 static hda_nid_t stac925x_dac_nids[1] = {
         0x02,
+};
+
+static hda_nid_t stac925x_dmic_nids[1] = {
+        0x15, 
 };
 
 static hda_nid_t stac922x_adc_nids[2] = {
@@ -482,6 +487,11 @@ static unsigned int stac925x_MA6_pin_con
 	0x90a70320, 0x90100211, 0x400003f1, 0x9033032e,
 };
 
+static unsigned int stac925x_PA6_pin_configs[8] = {
+	0x40c003f0, 0x424503f2, 0x01813022, 0x02a19021,
+	0x50a103f0, 0x90100211, 0x400003f1, 0x9033032e,
+};
+
 static unsigned int stac925xM2_2_pin_configs[8] = {
 	0x40c003f3, 0x424503f2, 0x041800f4, 0x02a19020,
 	0x50a103F0, 0x90100210, 0x400003f1, 0x9033032e,
@@ -491,20 +501,24 @@ static unsigned int *stac925x_brd_tbl[ST
 	[STAC_REF] = ref925x_pin_configs,
 	[STAC_M2_2] = stac925xM2_2_pin_configs,
 	[STAC_MA6] = stac925x_MA6_pin_configs,
+	[STAC_PA6] = stac925x_PA6_pin_configs,
 };
 
 static const char *stac925x_models[STAC_925x_MODELS] = {
 	[STAC_REF] = "ref",
 	[STAC_M2_2] = "m2-2",
 	[STAC_MA6] = "m6",
+	[STAC_PA6] = "pa6",
 };
 
 static struct snd_pci_quirk stac925x_cfg_tbl[] = {
 	/* SigmaTel reference board */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668, "DFI LanParty", STAC_REF),
+	SND_PCI_QUIRK(0x8384, 0x7632, "Stac9202 Reference Board", STAC_REF),
 	SND_PCI_QUIRK(0x107b, 0x0316, "Gateway M255", STAC_REF),
 	SND_PCI_QUIRK(0x107b, 0x0366, "Gateway MP6954", STAC_REF),
 	SND_PCI_QUIRK(0x107b, 0x0461, "Gateway NX560XL", STAC_MA6),
+	SND_PCI_QUIRK(0x107b, 0x0681, "Gateway NX860", STAC_PA6),
 	SND_PCI_QUIRK(0x1002, 0x437b, "Gateway MX6453", STAC_M2_2),
 	{} /* terminator */
 };
@@ -1911,7 +1925,8 @@ static int patch_stac925x(struct hda_cod
 							stac925x_cfg_tbl);
  again:
 	if (spec->board_config < 0) {
-		snd_printdd(KERN_INFO "hda_codec: Unknown model for STAC925x, using BIOS defaults\n");
+		snd_printdd(KERN_INFO "hda_codec: Unknown model for STAC925x," 
+				      "using BIOS defaults\n");
 		err = stac92xx_save_bios_config_regs(codec);
 		if (err < 0) {
 			stac92xx_free(codec);
@@ -1929,7 +1944,17 @@ static int patch_stac925x(struct hda_cod
 	spec->adc_nids = stac925x_adc_nids;
 	spec->mux_nids = stac925x_mux_nids;
 	spec->num_muxes = 1;
-	spec->num_dmics = 0;
+	switch (codec->vendor_id) {
+	case 0x83847632: /* STAC9202  */
+	case 0x83847633: /* STAC9202D */
+	case 0x83847636: /* STAC9251  */
+	case 0x83847637: /* STAC9251D */
+		spec->num_dmics = 1;
+		spec->dmic_nids = stac925x_dmic_nids;
+		break;
+	default:
+		spec->num_dmics = 0;
+	}
 
 	spec->init = stac925x_core_init;
 	spec->mixer = stac925x_mixer;

--=-bfDhKz15MNEsM/UpuncG
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-bfDhKz15MNEsM/UpuncG--
