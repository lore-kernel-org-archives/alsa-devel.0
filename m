From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/12] ALSA: hda - Use standard fixup table for
	STAC9200
Date: Tue, 15 Jan 2013 12:09:38 +0100
Message-ID: <1358248189-14166-2-git-send-email-tiwai@suse.de>
References: <1358248189-14166-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D1A96265D75
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:09:52 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 8CC61A522C
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:09:52 +0100 (CET)
In-Reply-To: <1358248189-14166-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Convert patch_stac9200() to use the standard fixup table instead of
manual switch-case with board_config.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_sigmatel.c | 369 +++++++++++++++++++++++++++++------------
 1 file changed, 265 insertions(+), 104 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 9cc4cb9..e5dffd2 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -50,7 +50,6 @@ enum {
 };
 
 enum {
-	STAC_AUTO,
 	STAC_REF,
 	STAC_9200_OQO,
 	STAC_9200_DELL_D21,
@@ -66,6 +65,7 @@ enum {
 	STAC_9200_M4,
 	STAC_9200_M4_2,
 	STAC_9200_PANASONIC,
+	STAC_9200_EAPD_INIT,
 	STAC_9200_MODELS
 };
 
@@ -1197,18 +1197,40 @@ static int stac92xx_build_controls(struct hda_codec *codec)
 	return 0;	
 }
 
-static const unsigned int ref9200_pin_configs[8] = {
-	0x01c47010, 0x01447010, 0x0221401f, 0x01114010,
-	0x02a19020, 0x01a19021, 0x90100140, 0x01813122,
+static const struct hda_pintbl ref9200_pin_configs[] = {
+	{ 0x08, 0x01c47010 },
+	{ 0x09, 0x01447010 },
+	{ 0x0d, 0x0221401f },
+	{ 0x0e, 0x01114010 },
+	{ 0x0f, 0x02a19020 },
+	{ 0x10, 0x01a19021 },
+	{ 0x11, 0x90100140 },
+	{ 0x12, 0x01813122 },
+	{}
 };
 
-static const unsigned int gateway9200_m4_pin_configs[8] = {
-	0x400000fe, 0x404500f4, 0x400100f0, 0x90110010,
-	0x400100f1, 0x02a1902e, 0x500000f2, 0x500000f3,
+static const struct hda_pintbl gateway9200_m4_pin_configs[] = {
+	{ 0x08, 0x400000fe },
+	{ 0x09, 0x404500f4 },
+	{ 0x0d, 0x400100f0 },
+	{ 0x0e, 0x90110010 },
+	{ 0x0f, 0x400100f1 },
+	{ 0x10, 0x02a1902e },
+	{ 0x11, 0x500000f2 },
+	{ 0x12, 0x500000f3 },
+	{}
 };
-static const unsigned int gateway9200_m4_2_pin_configs[8] = {
-	0x400000fe, 0x404500f4, 0x400100f0, 0x90110010,
-	0x400100f1, 0x02a1902e, 0x500000f2, 0x500000f3,
+
+static const struct hda_pintbl gateway9200_m4_2_pin_configs[] = {
+	{ 0x08, 0x400000fe },
+	{ 0x09, 0x404500f4 },
+	{ 0x0d, 0x400100f0 },
+	{ 0x0e, 0x90110010 },
+	{ 0x0f, 0x400100f1 },
+	{ 0x10, 0x02a1902e },
+	{ 0x11, 0x500000f2 },
+	{ 0x12, 0x500000f3 },
+	{}
 };
 
 /*
@@ -1217,9 +1239,16 @@ static const unsigned int gateway9200_m4_2_pin_configs[8] = {
     102801DE
     102801E8
 */
-static const unsigned int dell9200_d21_pin_configs[8] = {
-	0x400001f0, 0x400001f1, 0x02214030, 0x01014010, 
-	0x02a19020, 0x01a19021, 0x90100140, 0x01813122,
+static const struct hda_pintbl dell9200_d21_pin_configs[] = {
+	{ 0x08, 0x400001f0 },
+	{ 0x09, 0x400001f1 },
+	{ 0x0d, 0x02214030 },
+	{ 0x0e, 0x01014010 },
+	{ 0x0f, 0x02a19020 },
+	{ 0x10, 0x01a19021 },
+	{ 0x11, 0x90100140 },
+	{ 0x12, 0x01813122 },
+	{}
 };
 
 /* 
@@ -1227,9 +1256,16 @@ static const unsigned int dell9200_d21_pin_configs[8] = {
     102801C0
     102801C1
 */
-static const unsigned int dell9200_d22_pin_configs[8] = {
-	0x400001f0, 0x400001f1, 0x0221401f, 0x01014010, 
-	0x01813020, 0x02a19021, 0x90100140, 0x400001f2,
+static const struct hda_pintbl dell9200_d22_pin_configs[] = {
+	{ 0x08, 0x400001f0 },
+	{ 0x09, 0x400001f1 },
+	{ 0x0d, 0x0221401f },
+	{ 0x0e, 0x01014010 },
+	{ 0x0f, 0x01813020 },
+	{ 0x10, 0x02a19021 },
+	{ 0x11, 0x90100140 },
+	{ 0x12, 0x400001f2 },
+	{}
 };
 
 /* 
@@ -1241,9 +1277,16 @@ static const unsigned int dell9200_d22_pin_configs[8] = {
     102801DA
     102801E3
 */
-static const unsigned int dell9200_d23_pin_configs[8] = {
-	0x400001f0, 0x400001f1, 0x0221401f, 0x01014010, 
-	0x01813020, 0x01a19021, 0x90100140, 0x400001f2, 
+static const struct hda_pintbl dell9200_d23_pin_configs[] = {
+	{ 0x08, 0x400001f0 },
+	{ 0x09, 0x400001f1 },
+	{ 0x0d, 0x0221401f },
+	{ 0x0e, 0x01014010 },
+	{ 0x0f, 0x01813020 },
+	{ 0x10, 0x01a19021 },
+	{ 0x11, 0x90100140 },
+	{ 0x12, 0x400001f2 },
+	{}
 };
 
 
@@ -1252,9 +1295,16 @@ static const unsigned int dell9200_d23_pin_configs[8] = {
     102801B5 (Dell Inspiron 630m)
     102801D8 (Dell Inspiron 640m)
 */
-static const unsigned int dell9200_m21_pin_configs[8] = {
-	0x40c003fa, 0x03441340, 0x0321121f, 0x90170310,
-	0x408003fb, 0x03a11020, 0x401003fc, 0x403003fd,
+static const struct hda_pintbl dell9200_m21_pin_configs[] = {
+	{ 0x08, 0x40c003fa },
+	{ 0x09, 0x03441340 },
+	{ 0x0d, 0x0321121f },
+	{ 0x0e, 0x90170310 },
+	{ 0x0f, 0x408003fb },
+	{ 0x10, 0x03a11020 },
+	{ 0x11, 0x401003fc },
+	{ 0x12, 0x403003fd },
+	{}
 };
 
 /* 
@@ -1265,9 +1315,16 @@ static const unsigned int dell9200_m21_pin_configs[8] = {
     102801D4 
     102801D6 
 */
-static const unsigned int dell9200_m22_pin_configs[8] = {
-	0x40c003fa, 0x0144131f, 0x0321121f, 0x90170310, 
-	0x90a70321, 0x03a11020, 0x401003fb, 0x40f000fc,
+static const struct hda_pintbl dell9200_m22_pin_configs[] = {
+	{ 0x08, 0x40c003fa },
+	{ 0x09, 0x0144131f },
+	{ 0x0d, 0x0321121f },
+	{ 0x0e, 0x90170310 },
+	{ 0x0f, 0x90a70321 },
+	{ 0x10, 0x03a11020 },
+	{ 0x11, 0x401003fb },
+	{ 0x12, 0x40f000fc },
+	{}
 };
 
 /* 
@@ -1275,9 +1332,16 @@ static const unsigned int dell9200_m22_pin_configs[8] = {
     102801CE (Dell XPS M1710)
     102801CF (Dell Precision M90)
 */
-static const unsigned int dell9200_m23_pin_configs[8] = {
-	0x40c003fa, 0x01441340, 0x0421421f, 0x90170310,
-	0x408003fb, 0x04a1102e, 0x90170311, 0x403003fc,
+static const struct hda_pintbl dell9200_m23_pin_configs[] = {
+	{ 0x08, 0x40c003fa },
+	{ 0x09, 0x01441340 },
+	{ 0x0d, 0x0421421f },
+	{ 0x0e, 0x90170310 },
+	{ 0x0f, 0x408003fb },
+	{ 0x10, 0x04a1102e },
+	{ 0x11, 0x90170311 },
+	{ 0x12, 0x403003fc },
+	{}
 };
 
 /*
@@ -1287,9 +1351,16 @@ static const unsigned int dell9200_m23_pin_configs[8] = {
     102801CB (Dell Latitude 120L)
     102801D3
 */
-static const unsigned int dell9200_m24_pin_configs[8] = {
-	0x40c003fa, 0x404003fb, 0x0321121f, 0x90170310, 
-	0x408003fc, 0x03a11020, 0x401003fd, 0x403003fe, 
+static const struct hda_pintbl dell9200_m24_pin_configs[] = {
+	{ 0x08, 0x40c003fa },
+	{ 0x09, 0x404003fb },
+	{ 0x0d, 0x0321121f },
+	{ 0x0e, 0x90170310 },
+	{ 0x0f, 0x408003fc },
+	{ 0x10, 0x03a11020 },
+	{ 0x11, 0x401003fd },
+	{ 0x12, 0x403003fe },
+	{}
 };
 
 /*
@@ -1298,9 +1369,16 @@ static const unsigned int dell9200_m24_pin_configs[8] = {
     102801EE
     102801EF
 */
-static const unsigned int dell9200_m25_pin_configs[8] = {
-	0x40c003fa, 0x01441340, 0x0421121f, 0x90170310, 
-	0x408003fb, 0x04a11020, 0x401003fc, 0x403003fd,
+static const struct hda_pintbl dell9200_m25_pin_configs[] = {
+	{ 0x08, 0x40c003fa },
+	{ 0x09, 0x01441340 },
+	{ 0x0d, 0x0421121f },
+	{ 0x0e, 0x90170310 },
+	{ 0x0f, 0x408003fb },
+	{ 0x10, 0x04a11020 },
+	{ 0x11, 0x401003fc },
+	{ 0x12, 0x403003fd },
+	{}
 };
 
 /*
@@ -1308,64 +1386,163 @@ static const unsigned int dell9200_m25_pin_configs[8] = {
     102801F5 (Dell Inspiron 1501)
     102801F6
 */
-static const unsigned int dell9200_m26_pin_configs[8] = {
-	0x40c003fa, 0x404003fb, 0x0421121f, 0x90170310, 
-	0x408003fc, 0x04a11020, 0x401003fd, 0x403003fe,
+static const struct hda_pintbl dell9200_m26_pin_configs[] = {
+	{ 0x08, 0x40c003fa },
+	{ 0x09, 0x404003fb },
+	{ 0x0d, 0x0421121f },
+	{ 0x0e, 0x90170310 },
+	{ 0x0f, 0x408003fc },
+	{ 0x10, 0x04a11020 },
+	{ 0x11, 0x401003fd },
+	{ 0x12, 0x403003fe },
+	{}
 };
 
 /*
     STAC 9200-32
     102801CD (Dell Inspiron E1705/9400)
 */
-static const unsigned int dell9200_m27_pin_configs[8] = {
-	0x40c003fa, 0x01441340, 0x0421121f, 0x90170310,
-	0x90170310, 0x04a11020, 0x90170310, 0x40f003fc,
+static const struct hda_pintbl dell9200_m27_pin_configs[] = {
+	{ 0x08, 0x40c003fa },
+	{ 0x09, 0x01441340 },
+	{ 0x0d, 0x0421121f },
+	{ 0x0e, 0x90170310 },
+	{ 0x0f, 0x90170310 },
+	{ 0x10, 0x04a11020 },
+	{ 0x11, 0x90170310 },
+	{ 0x12, 0x40f003fc },
+	{}
 };
 
-static const unsigned int oqo9200_pin_configs[8] = {
-	0x40c000f0, 0x404000f1, 0x0221121f, 0x02211210,
-	0x90170111, 0x90a70120, 0x400000f2, 0x400000f3,
+static const struct hda_pintbl oqo9200_pin_configs[] = {
+	{ 0x08, 0x40c000f0 },
+	{ 0x09, 0x404000f1 },
+	{ 0x0d, 0x0221121f },
+	{ 0x0e, 0x02211210 },
+	{ 0x0f, 0x90170111 },
+	{ 0x10, 0x90a70120 },
+	{ 0x11, 0x400000f2 },
+	{ 0x12, 0x400000f3 },
+	{}
 };
 
 
-static const unsigned int *stac9200_brd_tbl[STAC_9200_MODELS] = {
-	[STAC_REF] = ref9200_pin_configs,
-	[STAC_9200_OQO] = oqo9200_pin_configs,
-	[STAC_9200_DELL_D21] = dell9200_d21_pin_configs,
-	[STAC_9200_DELL_D22] = dell9200_d22_pin_configs,
-	[STAC_9200_DELL_D23] = dell9200_d23_pin_configs,
-	[STAC_9200_DELL_M21] = dell9200_m21_pin_configs,
-	[STAC_9200_DELL_M22] = dell9200_m22_pin_configs,
-	[STAC_9200_DELL_M23] = dell9200_m23_pin_configs,
-	[STAC_9200_DELL_M24] = dell9200_m24_pin_configs,
-	[STAC_9200_DELL_M25] = dell9200_m25_pin_configs,
-	[STAC_9200_DELL_M26] = dell9200_m26_pin_configs,
-	[STAC_9200_DELL_M27] = dell9200_m27_pin_configs,
-	[STAC_9200_M4] = gateway9200_m4_pin_configs,
-	[STAC_9200_M4_2] = gateway9200_m4_2_pin_configs,
-	[STAC_9200_PANASONIC] = ref9200_pin_configs,
+static void stac9200_fixup_panasonic(struct hda_codec *codec,
+				     const struct hda_fixup *fix, int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		spec->gpio_mask = spec->gpio_dir = 0x09;
+		spec->gpio_data = 0x00;
+		break;
+	case HDA_FIXUP_ACT_PROBE:
+		/* CF-74 has no headphone detection, and the driver should *NOT*
+		 * do detection and HP/speaker toggle because the hardware does it.
+		 */
+		spec->hp_detect = 0;
+		break;
+	}
+}
+
+
+static const struct hda_fixup stac9200_fixups[] = {
+	[STAC_REF] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = ref9200_pin_configs,
+	},
+	[STAC_9200_OQO] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = oqo9200_pin_configs,
+		.chained = true,
+		.chain_id = STAC_9200_EAPD_INIT,
+	},
+	[STAC_9200_DELL_D21] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = dell9200_d21_pin_configs,
+	},
+	[STAC_9200_DELL_D22] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = dell9200_d22_pin_configs,
+	},
+	[STAC_9200_DELL_D23] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = dell9200_d23_pin_configs,
+	},
+	[STAC_9200_DELL_M21] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = dell9200_m21_pin_configs,
+	},
+	[STAC_9200_DELL_M22] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = dell9200_m22_pin_configs,
+	},
+	[STAC_9200_DELL_M23] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = dell9200_m23_pin_configs,
+	},
+	[STAC_9200_DELL_M24] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = dell9200_m24_pin_configs,
+	},
+	[STAC_9200_DELL_M25] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = dell9200_m25_pin_configs,
+	},
+	[STAC_9200_DELL_M26] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = dell9200_m26_pin_configs,
+	},
+	[STAC_9200_DELL_M27] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = dell9200_m27_pin_configs,
+	},
+	[STAC_9200_M4] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = gateway9200_m4_pin_configs,
+		.chained = true,
+		.chain_id = STAC_9200_EAPD_INIT,
+	},
+	[STAC_9200_M4_2] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = gateway9200_m4_2_pin_configs,
+		.chained = true,
+		.chain_id = STAC_9200_EAPD_INIT,
+	},
+	[STAC_9200_PANASONIC] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac9200_fixup_panasonic,
+	},
+	[STAC_9200_EAPD_INIT] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			{0x08, AC_VERB_SET_EAPD_BTLENABLE, 0x02},
+			{}
+		},
+	},
 };
 
-static const char * const stac9200_models[STAC_9200_MODELS] = {
-	[STAC_AUTO] = "auto",
-	[STAC_REF] = "ref",
-	[STAC_9200_OQO] = "oqo",
-	[STAC_9200_DELL_D21] = "dell-d21",
-	[STAC_9200_DELL_D22] = "dell-d22",
-	[STAC_9200_DELL_D23] = "dell-d23",
-	[STAC_9200_DELL_M21] = "dell-m21",
-	[STAC_9200_DELL_M22] = "dell-m22",
-	[STAC_9200_DELL_M23] = "dell-m23",
-	[STAC_9200_DELL_M24] = "dell-m24",
-	[STAC_9200_DELL_M25] = "dell-m25",
-	[STAC_9200_DELL_M26] = "dell-m26",
-	[STAC_9200_DELL_M27] = "dell-m27",
-	[STAC_9200_M4] = "gateway-m4",
-	[STAC_9200_M4_2] = "gateway-m4-2",
-	[STAC_9200_PANASONIC] = "panasonic",
-};
-
-static const struct snd_pci_quirk stac9200_cfg_tbl[] = {
+static const struct hda_model_fixup stac9200_models[] = {
+	{ .id = STAC_REF, .name = "ref" },
+	{ .id = STAC_9200_OQO, .name = "oqo" },
+	{ .id = STAC_9200_DELL_D21, .name = "dell-d21" },
+	{ .id = STAC_9200_DELL_D22, .name = "dell-d22" },
+	{ .id = STAC_9200_DELL_D23, .name = "dell-d23" },
+	{ .id = STAC_9200_DELL_M21, .name = "dell-m21" },
+	{ .id = STAC_9200_DELL_M22, .name = "dell-m22" },
+	{ .id = STAC_9200_DELL_M23, .name = "dell-m23" },
+	{ .id = STAC_9200_DELL_M24, .name = "dell-m24" },
+	{ .id = STAC_9200_DELL_M25, .name = "dell-m25" },
+	{ .id = STAC_9200_DELL_M26, .name = "dell-m26" },
+	{ .id = STAC_9200_DELL_M27, .name = "dell-m27" },
+	{ .id = STAC_9200_M4, .name = "gateway-m4" },
+	{ .id = STAC_9200_M4_2, .name = "gateway-m4-2" },
+	{ .id = STAC_9200_PANASONIC, .name = "panasonic" },
+	{}
+};
+
+static const struct snd_pci_quirk stac9200_fixup_tbl[] = {
 	/* SigmaTel reference board */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668,
 		      "DFI LanParty", STAC_REF),
@@ -4358,6 +4535,8 @@ static int stac92xx_init(struct hda_codec *codec)
 	if (spec->init)
 		snd_hda_sequence_write(codec, spec->init);
 
+	snd_hda_apply_verbs(codec);
+
 	/* power down adcs initially */
 	if (spec->powerdown_adcs)
 		for (i = 0; i < spec->num_adcs; i++)
@@ -5177,15 +5356,9 @@ static int patch_stac9200(struct hda_codec *codec)
 
 	spec = codec->spec;
 	spec->linear_tone_beep = 1;
-	spec->board_config = snd_hda_check_board_config(codec, STAC_9200_MODELS,
-							stac9200_models,
-							stac9200_cfg_tbl);
-	if (spec->board_config < 0)
-		snd_printdd(KERN_INFO "hda_codec: %s: BIOS auto-probing.\n",
-			    codec->chip_name);
-	else
-		stac92xx_set_config_regs(codec,
-					 stac9200_brd_tbl[spec->board_config]);
+
+	snd_hda_pick_fixup(codec, stac9200_models, stac9200_fixup_tbl,
+			   stac9200_fixups);
 
 	spec->multiout.max_channels = 2;
 	spec->multiout.num_dacs = 1;
@@ -5196,19 +5369,11 @@ static int patch_stac9200(struct hda_codec *codec)
 	spec->num_dmics = 0;
 	spec->num_adcs = 1;
 	spec->num_pwrs = 0;
+	snd_hda_add_verbs(codec, stac9200_eapd_init);
 
-	if (spec->board_config == STAC_9200_M4 ||
-	    spec->board_config == STAC_9200_M4_2 ||
-	    spec->board_config == STAC_9200_OQO)
-		spec->init = stac9200_eapd_init;
-	else
-		spec->init = stac9200_core_init;
 	spec->mixer = stac9200_mixer;
 
-	if (spec->board_config == STAC_9200_PANASONIC) {
-		spec->gpio_mask = spec->gpio_dir = 0x09;
-		spec->gpio_data = 0x00;
-	}
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
 
 	err = stac9200_parse_auto_config(codec);
 	if (err < 0) {
@@ -5216,14 +5381,10 @@ static int patch_stac9200(struct hda_codec *codec)
 		return err;
 	}
 
-	/* CF-74 has no headphone detection, and the driver should *NOT*
-	 * do detection and HP/speaker toggle because the hardware does it.
-	 */
-	if (spec->board_config == STAC_9200_PANASONIC)
-		spec->hp_detect = 0;
-
 	codec->patch_ops = stac92xx_patch_ops;
 
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
+
 	return 0;
 }
 
-- 
1.8.1
