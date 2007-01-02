From: Tobin Davis <tdavis@dsl-only.net>
Subject: Add support for Sigmatel STAC9202/9250/9251 codecs.
Date: Tue, 02 Jan 2007 11:31:39 -0800
Message-ID: <1167766299.31371.131.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-2QOmahuSd+bIwIhxqyEe"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-2QOmahuSd+bIwIhxqyEe
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Summary:  Add support for Sigmatel STAC9202/9250/9251 codecs.

        This patch adds support for Gateway laptops based on the
        Sigmatel STAC9250 codecs, as well as basic support for
        STAC9202/9250/9251 codecs.  Some Gateway systems require
        probe_mask=1 to work.  More work to be done prior to alsa 1.0.14
        final.


Signed off by Tobin Davis <tdavis@dsl-only.net>

--=-2QOmahuSd+bIwIhxqyEe
Content-Disposition: attachment; filename=gateway.patch
Content-Type: text/x-patch; name=gateway.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 9998aa91f5da Documentation/ALSA-Configuration.txt
--- a/Documentation/ALSA-Configuration.txt	Fri Dec 22 12:44:25 2006 +0100
+++ b/Documentation/ALSA-Configuration.txt	Tue Jan 02 11:27:11 2007 -0800
@@ -814,8 +814,9 @@ Prior to version 0.9.0rc4 options had a 
 
 	ALC882/885
 	  3stack-dig	3-jack with SPDIF I/O
-	  6stck-dig	6-jack digital with SPDIF I/O
+	  6stack-dig	6-jack digital with SPDIF I/O
 	  arima		Arima W820Di1
+	  macpro	MacPro support
 	  auto		auto-config reading BIOS (default)
 
 	ALC883/888
@@ -888,6 +889,11 @@ Prior to version 0.9.0rc4 options had a 
 	  ref		Reference board
 	  3stack	D945 3stack
 	  5stack	D945 5stack + SPDIF
+
+	STAC9202/9250/9251
+	  ref		Reference board, base config
+	  m2-2		Some Gateway MX series laptops
+	  m6		Some Gateway NX series laptops
 
 	STAC9227/9228/9229/927x
 	  ref		Reference board
diff -r 9998aa91f5da pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Fri Dec 22 12:44:25 2006 +0100
+++ b/pci/hda/patch_sigmatel.c	Mon Jan 01 22:48:14 2007 -0800
@@ -48,6 +48,13 @@ enum {
 };
 
 enum {
+	STAC_925x_REF,
+	STAC_M2_2,
+	STAC_MA6,
+	STAC_925x_MODELS
+};
+
+enum {
 	STAC_D945_REF,
 	STAC_D945GTP3,
 	STAC_D945GTP5,
@@ -129,6 +136,18 @@ static hda_nid_t stac9200_dac_nids[1] = 
         0x02,
 };
 
+static hda_nid_t stac925x_adc_nids[1] = {
+        0x03,
+};
+
+static hda_nid_t stac925x_mux_nids[1] = {
+        0x0f,
+};
+
+static hda_nid_t stac925x_dac_nids[1] = {
+        0x02,
+};
+
 static hda_nid_t stac922x_adc_nids[2] = {
         0x06, 0x07,
 };
@@ -160,6 +179,11 @@ static hda_nid_t stac9200_pin_nids[8] = 
 static hda_nid_t stac9200_pin_nids[8] = {
 	0x08, 0x09, 0x0d, 0x0e, 
 	0x0f, 0x10, 0x11, 0x12,
+};
+
+static hda_nid_t stac925x_pin_nids[8] = {
+	0x07, 0x08, 0x0a, 0x0b, 
+	0x0c, 0x0d, 0x10, 0x11,
 };
 
 static hda_nid_t stac922x_pin_nids[10] = {
@@ -238,6 +262,12 @@ static struct hda_verb stac9200_core_ini
 static struct hda_verb stac9200_core_init[] = {
 	/* set dac0mux for dac converter */
 	{ 0x07, AC_VERB_SET_CONNECT_SEL, 0x00},
+	{}
+};
+
+static struct hda_verb stac925x_core_init[] = {
+	/* set dac0mux for dac converter */
+	{ 0x06, AC_VERB_SET_CONNECT_SEL, 0x00},
 	{}
 };
 
@@ -283,6 +313,23 @@ static struct snd_kcontrol_new stac9200_
 	HDA_CODEC_VOLUME("Capture Volume", 0x0a, 0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x0a, 0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Capture Mux Volume", 0x0c, 0, HDA_OUTPUT),
+	{ } /* end */
+};
+
+static struct snd_kcontrol_new stac925x_mixer[] = {
+	HDA_CODEC_VOLUME("Master Playback Volume", 0xe, 0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Master Playback Switch", 0xe, 0, HDA_OUTPUT),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input Source",
+		.count = 1,
+		.info = stac92xx_mux_enum_info,
+		.get = stac92xx_mux_enum_get,
+		.put = stac92xx_mux_enum_put,
+	},
+	HDA_CODEC_VOLUME("Capture Volume", 0x09, 0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Capture Switch", 0x09, 0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Capture Mux Volume", 0x0f, 0, HDA_OUTPUT),
 	{ } /* end */
 };
 
@@ -408,6 +455,43 @@ static struct snd_pci_quirk stac9200_cfg
 		      "Dell Latitude D620", STAC_REF),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x01cb,
 		      "Dell Latitude 120L", STAC_REF),
+	{} /* terminator */
+};
+
+static unsigned int ref925x_pin_configs[8] = {
+	0x40c003f0, 0x424503f2, 0x01813022, 0x02a19021,
+	0x90a70320, 0x02214210, 0x400003f1, 0x9033032e,
+};
+
+static unsigned int stac925x_MA6_pin_configs[8] = {
+	0x40c003f0, 0x424503f2, 0x01813022, 0x02a19021,
+	0x90a70320, 0x90100211, 0x400003f1, 0x9033032e,
+};
+
+static unsigned int stac925xM2_2_pin_configs[8] = {
+	0x40c003f3, 0x424503f2, 0x041800f4, 0x02a19020,
+	0x50a103F0, 0x90100210, 0x400003f1, 0x9033032e,
+};
+
+static unsigned int *stac925x_brd_tbl[STAC_925x_MODELS] = {
+	[STAC_REF] = ref925x_pin_configs,
+	[STAC_M2_2] = stac925xM2_2_pin_configs,
+	[STAC_MA6] = stac925x_MA6_pin_configs,
+};
+
+static const char *stac925x_models[STAC_925x_MODELS] = {
+	[STAC_REF] = "ref",
+	[STAC_M2_2] = "m2-2",
+	[STAC_MA6] = "m6",
+};
+
+static struct snd_pci_quirk stac925x_cfg_tbl[] = {
+	/* SigmaTel reference board */
+	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668, "DFI LanParty", STAC_REF),
+	SND_PCI_QUIRK(0x107b, 0x0316, "Gateway M255", STAC_REF),
+	SND_PCI_QUIRK(0x107b, 0x0366, "Gateway MP6954", STAC_REF),
+	SND_PCI_QUIRK(0x107b, 0x0461, "Gateway NX560XL", STAC_MA6),
+	SND_PCI_QUIRK(0x1002, 0x437b, "Gateway MX6453", STAC_M2_2),
 	{} /* terminator */
 };
 
@@ -1699,6 +1783,56 @@ static int patch_stac9200(struct hda_cod
 	return 0;
 }
 
+static int patch_stac925x(struct hda_codec *codec)
+{
+	struct sigmatel_spec *spec;
+	int err;
+
+	spec  = kzalloc(sizeof(*spec), GFP_KERNEL);
+	if (spec == NULL)
+		return -ENOMEM;
+
+	codec->spec = spec;
+	spec->num_pins = 8;
+	spec->pin_nids = stac925x_pin_nids;
+	spec->board_config = snd_hda_check_board_config(codec, STAC_925x_MODELS,
+							stac925x_models,
+							stac925x_cfg_tbl);
+	if (spec->board_config < 0) {
+		snd_printdd(KERN_INFO "hda_codec: Unknown model for STAC925x, using BIOS defaults\n");
+		err = stac92xx_save_bios_config_regs(codec);
+		if (err < 0) {
+			stac92xx_free(codec);
+			return err;
+		}
+		spec->pin_configs = spec->bios_pin_configs;
+	} else if (stac925x_brd_tbl[spec->board_config] != NULL){
+		spec->pin_configs = stac925x_brd_tbl[spec->board_config];
+		stac92xx_set_config_regs(codec);
+	}
+
+	spec->multiout.max_channels = 2;
+	spec->multiout.num_dacs = 1;
+	spec->multiout.dac_nids = stac925x_dac_nids;
+	spec->adc_nids = stac925x_adc_nids;
+	spec->mux_nids = stac925x_mux_nids;
+	spec->num_muxes = 1;
+	spec->num_dmics = 0;
+
+	spec->init = stac925x_core_init;
+	spec->mixer = stac925x_mixer;
+
+	err = stac92xx_parse_auto_config(codec, 0x8, 0x7);
+	if (err < 0) {
+		stac92xx_free(codec);
+		return err;
+	}
+
+	codec->patch_ops = stac92xx_patch_ops;
+
+	return 0;
+}
+
 static int patch_stac922x(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec;
@@ -2149,6 +2283,12 @@ struct hda_codec_preset snd_hda_preset_s
  	{ .id = 0x83847627, .name = "STAC9271D", .patch = patch_stac927x },
  	{ .id = 0x83847628, .name = "STAC9274X5NH", .patch = patch_stac927x },
  	{ .id = 0x83847629, .name = "STAC9274D5NH", .patch = patch_stac927x },
+	{ .id = 0x83847632, .name = "STAC9202",  .patch = patch_stac925x },
+	{ .id = 0x83847633, .name = "STAC9202D", .patch = patch_stac925x },
+	{ .id = 0x83847634, .name = "STAC9250", .patch = patch_stac925x },
+	{ .id = 0x83847635, .name = "STAC9250D", .patch = patch_stac925x },
+	{ .id = 0x83847636, .name = "STAC9251", .patch = patch_stac925x },
+	{ .id = 0x83847637, .name = "STAC9250D", .patch = patch_stac925x },
  	/* The following does not take into account .id=0x83847661 when subsys =
  	 * 104D0C00 which is STAC9225s. Because of this, some SZ Notebooks are
  	 * currently not fully supported.

--=-2QOmahuSd+bIwIhxqyEe
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-2QOmahuSd+bIwIhxqyEe
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-2QOmahuSd+bIwIhxqyEe--
