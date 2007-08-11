From: Tobin Davis <tdavis@dsl-only.net>
Subject: HDA - Add support for more Dell systems
Date: Sat, 11 Aug 2007 15:01:45 -0700
Message-ID: <1186869705.5512.129.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-HN8/tpaXDCu/ipULFxHr"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id C04DE10381C
	for <alsa-devel@alsa-project.org>;
	Sun, 12 Aug 2007 00:01:47 +0200 (CEST)
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


--=-HN8/tpaXDCu/ipULFxHr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds more support for Dell systems with Stac9205 codecs.
Tested against a couple of different systems (with different pin
configs), but the others should also work.  Also cleaned up some of the
9205 patch code.



Signed off by Tobin Davis <tdavis@dsl-only.net>

--=-HN8/tpaXDCu/ipULFxHr
Content-Disposition: attachment; filename=Dell-Inspiron.patch
Content-Type: text/x-patch; name=Dell-Inspiron.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 06f49905b2d5 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Sat Aug 11 11:06:09 2007 +0200
+++ b/pci/hda/patch_sigmatel.c	Sat Aug 11 12:05:44 2007 -0700
@@ -44,7 +44,9 @@ enum {
 
 enum {
 	STAC_9205_REF,
-	STAC_M43xx,
+	STAC_9205_DELL_M43,
+	STAC_9205_DELL_M44,
+	STAC_9205_M43xx,
 	STAC_9205_MODELS
 };
 
@@ -788,13 +790,30 @@ static unsigned int ref9205_pin_configs[
 	0x90a000f0, 0x90a000f0, 0x01441030, 0x01c41030
 };
 
+static unsigned int dell_m43_9205_pin_configs[12] = {
+	0x0321101f, 0x03a11020, 0x90a70330, 0x90170310,
+	0x400000fe, 0x400000ff, 0x400000fd, 0x40f000f9,
+	0x400000fa, 0x400000fc, 0x0144131f, 0x40c003f8,
+};
+
+static unsigned int dell_m44_9205_pin_configs[12] = {
+	0x0421101f, 0x04a11020, 0x400003fa, 0x90170310,
+	0x400003fb, 0x400003fc, 0x400003fd, 0x400003f9,
+	0x90a60330, 0x400003ff, 0x01441340, 0x40c003fe,
+};
+
+
 static unsigned int *stac9205_brd_tbl[STAC_9205_MODELS] = {
-	[STAC_REF] = ref9205_pin_configs,
-	[STAC_M43xx] = NULL,
+	[STAC_9205_REF] = ref9205_pin_configs,
+	[STAC_9205_DELL_M43] = dell_m43_9205_pin_configs,
+	[STAC_9205_DELL_M44] = dell_m44_9205_pin_configs,
+	[STAC_9205_M43xx] = NULL,
 };
 
 static const char *stac9205_models[STAC_9205_MODELS] = {
 	[STAC_9205_REF] = "ref",
+	[STAC_9205_DELL_M43] = "dell-m43",
+	[STAC_9205_DELL_M44] = "dell-m44",
 };
 
 static struct snd_pci_quirk stac9205_cfg_tbl[] = {
@@ -802,9 +821,13 @@ static struct snd_pci_quirk stac9205_cfg
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668,
 		      "DFI LanParty", STAC_9205_REF),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x01f8,
-		      "Dell Precision", STAC_M43xx),
+		      "Dell Precision", STAC_9205_M43xx),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x01f9,
+		      "Dell Precision", STAC_9205_DELL_M43),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x01ff,
-		      "Dell Precision", STAC_M43xx),
+		      "Dell Precision", STAC_9205_M43xx),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x01fd,
+		      "Dell Inspiron 1721", STAC_9205_DELL_M44),
 	{} /* terminator */
 };
 
@@ -2312,7 +2335,9 @@ static int patch_stac9205(struct hda_cod
 
 	spec->multiout.dac_nids = spec->dac_nids;
 	
-	if (spec->board_config == STAC_M43xx) {
+	switch (spec->board_config){
+	case STAC_9205_M43xx:
+	case STAC_9205_DELL_M43:
 		/* Enable SPDIF in/out */
 		stac92xx_set_config_reg(codec, 0x1f, 0x01441030);
 		stac92xx_set_config_reg(codec, 0x20, 0x1c410030);
@@ -2322,9 +2347,12 @@ static int patch_stac9205(struct hda_cod
 		 * GPIO2 High = Headphone Mute
 		 */
 		spec->gpio_data = 0x00000005;
-	} else
-		spec->gpio_mask = spec->gpio_data =
-			0x00000001; /* GPIO0 High = EAPD */
+		break;
+	default:
+		/* GPIO0 High = EAPD */
+		spec->gpio_mask = spec->gpio_data = 0x00000001; 
+		break;
+	}
 
 	stac92xx_enable_gpio_mask(codec);
 	err = stac92xx_parse_auto_config(codec, 0x1f, 0x20);

--=-HN8/tpaXDCu/ipULFxHr
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-HN8/tpaXDCu/ipULFxHr--
