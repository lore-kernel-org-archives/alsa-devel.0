From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: Enable SPDIF in/out on some stac9205
	boards
Date: Mon, 16 Jul 2007 17:05:20 -0400
Message-ID: <469BDD90.3060509@embeddedalley.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080803050207000306080707"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp100.biz.mail.re2.yahoo.com (smtp100.biz.mail.re2.yahoo.com
	[206.190.52.46]) by alsa0.perex.cz (Postfix) with SMTP id 5DBCF103818
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jul 2007 23:05:21 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: "Tellman, Steven" <Steven.Tellman@idt.com>, Matt Porter <mporter@embeddedalley.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080803050207000306080707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Added support for some boards with SPDIF in/out, and cleaned up the GPIO 
enable function.
---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

--------------080803050207000306080707
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="stac_m43xx_gpio_spdif.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stac_m43xx_gpio_spdif.patch"

diff -r 631a50e624df pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Mon Jul 16 11:01:30 2007 +0200
+++ b/pci/hda/patch_sigmatel.c	Mon Jul 16 16:34:46 2007 -0400
@@ -44,6 +44,7 @@ enum {
 
 enum {
 	STAC_9205_REF,
+	STAC_M43xx,
 	STAC_9205_MODELS
 };
 
@@ -218,7 +219,6 @@ static hda_nid_t stac9205_pin_nids[12] =
 	0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
 	0x0f, 0x14, 0x16, 0x17, 0x18,
 	0x21, 0x22,
-	
 };
 
 static int stac92xx_dmux_enum_info(struct snd_kcontrol *kcontrol,
@@ -773,7 +773,8 @@ static unsigned int ref9205_pin_configs[
 };
 
 static unsigned int *stac9205_brd_tbl[STAC_9205_MODELS] = {
-	ref9205_pin_configs,
+	[STAC_REF] = ref9205_pin_configs,
+	[STAC_M43xx] = NULL,
 };
 
 static const char *stac9205_models[STAC_9205_MODELS] = {
@@ -784,6 +785,10 @@ static struct snd_pci_quirk stac9205_cfg
 	/* SigmaTel reference board */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668,
 		      "DFI LanParty", STAC_9205_REF),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x01f8,
+              "Dell Precision", STAC_M43xx),
+    SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x01ff,
+              "Dell Precision", STAC_M43xx), 
 	{} /* terminator */
 };
 
@@ -813,48 +818,52 @@ static int stac92xx_save_bios_config_reg
 	return 0;
 }
 
+static void stac92xx_set_config_reg(struct hda_codec *codec, hda_nid_t pin_nid, unsigned int pin_config)
+{
+    int i;
+ 	snd_hda_codec_write(codec, pin_nid, 0,
+ 			AC_VERB_SET_CONFIG_DEFAULT_BYTES_0,
+ 			pin_config & 0x000000ff);
+ 	snd_hda_codec_write(codec, pin_nid, 0,
+ 			AC_VERB_SET_CONFIG_DEFAULT_BYTES_1,
+ 			(pin_config & 0x0000ff00) >> 8);
+ 	snd_hda_codec_write(codec, pin_nid, 0,
+ 			AC_VERB_SET_CONFIG_DEFAULT_BYTES_2,
+ 			(pin_config & 0x00ff0000) >> 16);
+ 	snd_hda_codec_write(codec, pin_nid, 0,
+ 			AC_VERB_SET_CONFIG_DEFAULT_BYTES_3,
+ 			pin_config >> 24);
+ 	i = snd_hda_codec_read(codec, pin_nid, 0,
+ 			AC_VERB_GET_CONFIG_DEFAULT,
+ 			0x00);	
+ 	snd_printdd(KERN_INFO "hda_codec: pin nid %2.2x pin config %8.8x\n", pin_nid, i);
+} 
+
 static void stac92xx_set_config_regs(struct hda_codec *codec)
 {
 	int i;
 	struct sigmatel_spec *spec = codec->spec;
-	unsigned int pin_cfg;
-
-	if (! spec->pin_nids || ! spec->pin_configs)
-		return;
-
-	for (i = 0; i < spec->num_pins; i++) {
-		snd_hda_codec_write(codec, spec->pin_nids[i], 0,
-				    AC_VERB_SET_CONFIG_DEFAULT_BYTES_0,
-				    spec->pin_configs[i] & 0x000000ff);
-		snd_hda_codec_write(codec, spec->pin_nids[i], 0,
-				    AC_VERB_SET_CONFIG_DEFAULT_BYTES_1,
-				    (spec->pin_configs[i] & 0x0000ff00) >> 8);
-		snd_hda_codec_write(codec, spec->pin_nids[i], 0,
-				    AC_VERB_SET_CONFIG_DEFAULT_BYTES_2,
-				    (spec->pin_configs[i] & 0x00ff0000) >> 16);
-		snd_hda_codec_write(codec, spec->pin_nids[i], 0,
-				    AC_VERB_SET_CONFIG_DEFAULT_BYTES_3,
-				    spec->pin_configs[i] >> 24);
-		pin_cfg = snd_hda_codec_read(codec, spec->pin_nids[i], 0,
-					     AC_VERB_GET_CONFIG_DEFAULT,
-					     0x00);	
-		snd_printdd(KERN_INFO "hda_codec: pin nid %2.2x pin config %8.8x\n", spec->pin_nids[i], pin_cfg);
-	}
-}
-
-static void stac92xx_enable_eapd(struct hda_codec *codec)
-{
-	/* Configure GPIO0 as output */
+ 	if (!spec->pin_configs)
+ 		return;
+ 
+ 	for (i=0; i < spec->num_pins; i++)
+ 		stac92xx_set_config_reg(codec, spec->pin_nids[i],
+ 					spec->pin_configs[i]);
+}
+
+static void stac92xx_enable_gpio_mask(struct hda_codec *codec,int gpio_mask,int gpio_data)
+{
+	/* Configure GPIOx as output */
 	snd_hda_codec_write(codec, codec->afg, 0,
-			    AC_VERB_SET_GPIO_DIRECTION, 0x00000001);
-	/* Configure GPIO0 as CMOS */
+			    AC_VERB_SET_GPIO_DIRECTION, gpio_mask);
+	/* Configure GPIOx as CMOS */
 	snd_hda_codec_write(codec, codec->afg, 0, 0x7e7, 0x00000000);
-	/* Assert GPIO0 high */
+	/* Assert GPIOx */
 	snd_hda_codec_write(codec, codec->afg, 0,
-			    AC_VERB_SET_GPIO_DATA, 0x00000001);
-	/* Enable GPIO0 */
+			    AC_VERB_SET_GPIO_DATA, gpio_data);
+	/* Enable GPIOx */
 	snd_hda_codec_write(codec, codec->afg, 0,
-			    AC_VERB_SET_GPIO_MASK, 0x00000001);
+			    AC_VERB_SET_GPIO_MASK, gpio_mask);
 }
 
 /*
@@ -2233,7 +2242,7 @@ static int patch_stac927x(struct hda_cod
 	}
 
 	spec->multiout.dac_nids = spec->dac_nids;
-	stac92xx_enable_eapd(codec);
+	stac92xx_enable_gpio_mask(codec, 0x00000001, 0x00000001); /* GPIO0 High = Enable EAPD */
 	
 	err = stac92xx_parse_auto_config(codec, 0x1e, 0x20);
 	if (!err) {
@@ -2258,7 +2267,7 @@ static int patch_stac9205(struct hda_cod
 static int patch_stac9205(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec;
-	int err;
+	int err, gpio_mask, gpio_data;
 
 	spec  = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (spec == NULL)
@@ -2295,8 +2304,19 @@ static int patch_stac9205(struct hda_cod
 	spec->mixer = stac9205_mixer;
 
 	spec->multiout.dac_nids = spec->dac_nids;
-	stac92xx_enable_eapd(codec);
-
+	
+	if (spec->board_config == STAC_M43xx) {
+		/* Enable SPDIF in/out */
+		stac92xx_set_config_reg(codec, 0x1f, 0x01441030);
+		stac92xx_set_config_reg(codec, 0x20, 0x1c410030);
+
+		gpio_mask = 0x00000007; /* GPIO0-2 */
+		gpio_data = 0x00000005; /* GPIO0 High = EAPD, GPIO1 Low = DRM, GPIO2 High = Headphone Mute */
+	}
+	else
+		gpio_mask = gpio_data = 0x00000001; /* GPIO0 High = EAPD */
+
+	stac92xx_enable_gpio_mask(codec, gpio_mask, gpio_data);
 	err = stac92xx_parse_auto_config(codec, 0x1f, 0x20);
 	if (!err) {
 		if (spec->board_config < 0) {

--------------080803050207000306080707
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080803050207000306080707--
