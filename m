From: Matt Porter <mporter@embeddedalley.com>
Subject: [PATCH] hda: sigmatel 9205 family support
Date: Fri, 28 Jul 2006 18:32:14 -0400
Message-ID: <20060728223214.GC5578@matthew-porters-computer.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: tiwai@suse.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Adds support for the "9205 family" which includes some other
part numbers but 9205 is the first one. These are 4 channel
codecs, some have digital mic capability. Support for the digital
mic feature will come later.

Signed-off-by: Matt Porter <mporter@embeddedalley.com>

diff -r 8ecbc09a24dd pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Fri Jul 28 14:47:34 2006 +0200
+++ b/pci/hda/patch_sigmatel.c	Fri Jul 28 14:27:32 2006 -0700
@@ -136,6 +136,14 @@ static hda_nid_t stac927x_mux_nids[3] = 
         0x15, 0x16, 0x17
 };
 
+static hda_nid_t stac9205_adc_nids[2] = {
+        0x12, 0x13
+};
+
+static hda_nid_t stac9205_mux_nids[2] = {
+        0x19, 0x1a
+};
+
 static hda_nid_t stac9200_pin_nids[8] = {
 	0x08, 0x09, 0x0d, 0x0e, 0x0f, 0x10, 0x11, 0x12,
 };
@@ -149,6 +157,13 @@ static hda_nid_t stac927x_pin_nids[14] =
 	0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
 	0x0f, 0x10, 0x11, 0x12, 0x13,
 	0x14, 0x21, 0x22, 0x23,
+};
+
+static hda_nid_t stac9205_pin_nids[12] = {
+	0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
+	0x0f, 0x14, 0x16, 0x17, 0x18,
+	0x21, 0x22,
+	
 };
 
 static int stac92xx_mux_enum_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
@@ -209,6 +224,12 @@ static struct hda_verb d965_2112_core_in
 };
 
 static struct hda_verb stac927x_core_init[] = {
+	/* set master volume and direct control */	
+	{ 0x24, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
+	{}
+};
+
+static struct hda_verb stac9205_core_init[] = {
 	/* set master volume and direct control */	
 	{ 0x24, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
 	{}
@@ -274,6 +295,21 @@ static snd_kcontrol_new_t stac927x_mixer
 	HDA_CODEC_VOLUME("InMux Capture Volume", 0x15, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("InVol Capture Volume", 0x18, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("ADCMux Capture Switch", 0x1b, 0x0, HDA_OUTPUT),
+	{ } /* end */
+};
+
+static snd_kcontrol_new_t stac9205_mixer[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input Source",
+		.count = 1,
+		.info = stac92xx_mux_enum_info,
+		.get = stac92xx_mux_enum_get,
+		.put = stac92xx_mux_enum_put,
+	},
+	HDA_CODEC_VOLUME("InMux Capture Volume", 0x19, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("InVol Capture Volume", 0x1b, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("ADCMux Capture Switch", 0x1d, 0x0, HDA_OUTPUT),
 	{ } /* end */
 };
 
@@ -415,6 +451,24 @@ static struct hda_board_config stac927x_
 	{} /* terminator */
 };
 
+static unsigned int ref9205_pin_configs[12] = {
+	0x40000100, 0x40000100, 0x01016011, 0x01014010,
+	0x01813122, 0x01a19021, 0x40000100, 0x40000100, 
+	0x40000100, 0x40000100, 0x01441030, 0x01c41030
+};
+
+static unsigned int *stac9205_brd_tbl[] = {
+	ref9205_pin_configs,
+};
+
+static struct hda_board_config stac9205_cfg_tbl[] = {
+	{ .modelname = "ref",
+	  .pci_subvendor = PCI_VENDOR_ID_INTEL,
+	  .pci_subdevice = 0x2668,	/* DFI LanParty */
+	  .config = STAC_REF },		/* SigmaTel reference board */
+	{} /* terminator */
+};
+
 static void stac92xx_set_config_regs(struct hda_codec *codec)
 {
 	int i;
@@ -1354,6 +1408,46 @@ static int patch_stac927x(struct hda_cod
 	return 0;
 }
 
+static int patch_stac9205(struct hda_codec *codec)
+{
+	struct sigmatel_spec *spec;
+	int err;
+
+	spec  = kzalloc(sizeof(*spec), GFP_KERNEL);
+	if (spec == NULL)
+		return -ENOMEM;
+
+	codec->spec = spec;
+	spec->board_config = snd_hda_check_board_config(codec, stac9205_cfg_tbl);
+	if (spec->board_config < 0)
+                snd_printdd(KERN_INFO "hda_codec: Unknown model for STAC9205, using BIOS defaults\n");
+	else {
+		spec->num_pins = 14;
+		spec->pin_nids = stac9205_pin_nids;
+		spec->pin_configs = stac9205_brd_tbl[spec->board_config];
+		stac92xx_set_config_regs(codec);
+	}
+
+	spec->adc_nids = stac9205_adc_nids;
+	spec->mux_nids = stac9205_mux_nids;
+	spec->num_muxes = 3;
+
+	spec->init = stac9205_core_init;
+	spec->mixer = stac9205_mixer;
+
+	spec->multiout.dac_nids = spec->dac_nids;
+
+	err = stac92xx_parse_auto_config(codec, 0x1f, 0x20);
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
 /*
  * STAC 7661(?) hack
  */
@@ -1542,5 +1636,13 @@ struct hda_codec_preset snd_hda_preset_s
  	{ .id = 0x83847628, .name = "STAC9274X5NH", .patch = patch_stac927x },
  	{ .id = 0x83847629, .name = "STAC9274D5NH", .patch = patch_stac927x },
  	{ .id = 0x83847661, .name = "STAC7661", .patch = patch_stac7661 },
+ 	{ .id = 0x838476a0, .name = "STAC9205", .patch = patch_stac9205 },
+ 	{ .id = 0x838476a1, .name = "STAC9205D", .patch = patch_stac9205 },
+ 	{ .id = 0x838476a2, .name = "STAC9204", .patch = patch_stac9205 },
+ 	{ .id = 0x838476a3, .name = "STAC9204D", .patch = patch_stac9205 },
+ 	{ .id = 0x838476a4, .name = "STAC9255", .patch = patch_stac9205 },
+ 	{ .id = 0x838476a5, .name = "STAC9255D", .patch = patch_stac9205 },
+ 	{ .id = 0x838476a6, .name = "STAC9254", .patch = patch_stac9205 },
+ 	{ .id = 0x838476a7, .name = "STAC9254D", .patch = patch_stac9205 },
 	{} /* terminator */
 };

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
