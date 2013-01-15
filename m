From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 05/12] ALSA: hda - Use standard fixup table for
	STAC922x
Date: Tue, 15 Jan 2013 12:09:42 +0100
Message-ID: <1358248189-14166-6-git-send-email-tiwai@suse.de>
References: <1358248189-14166-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AC8FB265D71
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:09:52 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 89923A5212
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

Rather straightforward conversion, except for ones for Intel Mac.
As Intel Mac have only unique codec SSIDs, we need to remap the fixup
again for the codec SSID and call the new fixup there.

Also, we can reduce model enums like STAC_MACMINI, which are model
aliases for backward compatibility, since they can be pointed directly
via hda_model_fixup table.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_sigmatel.c | 483 ++++++++++++++++++++++++++---------------
 1 file changed, 312 insertions(+), 171 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index f66c7d1..60d43dd 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -134,7 +134,6 @@ enum {
 };
 
 enum {
-	STAC_922X_AUTO,
 	STAC_D945_REF,
 	STAC_D945GTP3,
 	STAC_D945GTP5,
@@ -143,21 +142,13 @@ enum {
 	STAC_INTEL_MAC_V3,
 	STAC_INTEL_MAC_V4,
 	STAC_INTEL_MAC_V5,
-	STAC_INTEL_MAC_AUTO, /* This model is selected if no module parameter
-			      * is given, one of the above models will be
-			      * chosen according to the subsystem id. */
-	/* for backward compatibility */
-	STAC_MACMINI,
-	STAC_MACBOOK,
-	STAC_MACBOOK_PRO_V1,
-	STAC_MACBOOK_PRO_V2,
-	STAC_IMAC_INTEL,
-	STAC_IMAC_INTEL_20,
+	STAC_INTEL_MAC_AUTO,
 	STAC_ECS_202,
 	STAC_922X_DELL_D81,
 	STAC_922X_DELL_D82,
 	STAC_922X_DELL_M81,
 	STAC_922X_DELL_M82,
+	STAC_922X_INTEL_MAC_GPIO,
 	STAC_922X_MODELS
 };
 
@@ -2136,10 +2127,18 @@ static const struct snd_pci_quirk stac92hd71bxx_cfg_tbl[] = {
 	{} /* terminator */
 };
 
-static const unsigned int ref922x_pin_configs[10] = {
-	0x01014010, 0x01016011, 0x01012012, 0x0221401f,
-	0x01813122, 0x01011014, 0x01441030, 0x01c41030,
-	0x40000100, 0x40000100,
+static const struct hda_pintbl ref922x_pin_configs[] = {
+	{ 0x0a, 0x01014010 },
+	{ 0x0b, 0x01016011 },
+	{ 0x0c, 0x01012012 },
+	{ 0x0d, 0x0221401f },
+	{ 0x0e, 0x01813122 },
+	{ 0x0f, 0x01011014 },
+	{ 0x10, 0x01441030 },
+	{ 0x11, 0x01c41030 },
+	{ 0x15, 0x40000100 },
+	{ 0x1b, 0x40000100 },
+	{}
 };
 
 /*
@@ -2150,10 +2149,18 @@ static const unsigned int ref922x_pin_configs[10] = {
     102801D1
     102801D2
 */
-static const unsigned int dell_922x_d81_pin_configs[10] = {
-	0x02214030, 0x01a19021, 0x01111012, 0x01114010,
-	0x02a19020, 0x01117011, 0x400001f0, 0x400001f1,
-	0x01813122, 0x400001f2,
+static const struct hda_pintbl dell_922x_d81_pin_configs[] = {
+	{ 0x0a, 0x02214030 },
+	{ 0x0b, 0x01a19021 },
+	{ 0x0c, 0x01111012 },
+	{ 0x0d, 0x01114010 },
+	{ 0x0e, 0x02a19020 },
+	{ 0x0f, 0x01117011 },
+	{ 0x10, 0x400001f0 },
+	{ 0x11, 0x400001f1 },
+	{ 0x15, 0x01813122 },
+	{ 0x1b, 0x400001f2 },
+	{}
 };
 
 /*
@@ -2161,130 +2168,311 @@ static const unsigned int dell_922x_d81_pin_configs[10] = {
     102801AC
     102801D0
 */
-static const unsigned int dell_922x_d82_pin_configs[10] = {
-	0x02214030, 0x01a19021, 0x01111012, 0x01114010,
-	0x02a19020, 0x01117011, 0x01451140, 0x400001f0,
-	0x01813122, 0x400001f1,
+static const struct hda_pintbl dell_922x_d82_pin_configs[] = {
+	{ 0x0a, 0x02214030 },
+	{ 0x0b, 0x01a19021 },
+	{ 0x0c, 0x01111012 },
+	{ 0x0d, 0x01114010 },
+	{ 0x0e, 0x02a19020 },
+	{ 0x0f, 0x01117011 },
+	{ 0x10, 0x01451140 },
+	{ 0x11, 0x400001f0 },
+	{ 0x15, 0x01813122 },
+	{ 0x1b, 0x400001f1 },
+	{}
 };
 
 /*
     STAC 922X pin configs for
     102801BF
 */
-static const unsigned int dell_922x_m81_pin_configs[10] = {
-	0x0321101f, 0x01112024, 0x01111222, 0x91174220,
-	0x03a11050, 0x01116221, 0x90a70330, 0x01452340, 
-	0x40C003f1, 0x405003f0,
+static const struct hda_pintbl dell_922x_m81_pin_configs[] = {
+	{ 0x0a, 0x0321101f },
+	{ 0x0b, 0x01112024 },
+	{ 0x0c, 0x01111222 },
+	{ 0x0d, 0x91174220 },
+	{ 0x0e, 0x03a11050 },
+	{ 0x0f, 0x01116221 },
+	{ 0x10, 0x90a70330 },
+	{ 0x11, 0x01452340 },
+	{ 0x15, 0x40C003f1 },
+	{ 0x1b, 0x405003f0 },
+	{}
 };
 
 /*
     STAC 9221 A1 pin configs for
     102801D7 (Dell XPS M1210)
 */
-static const unsigned int dell_922x_m82_pin_configs[10] = {
-	0x02211211, 0x408103ff, 0x02a1123e, 0x90100310, 
-	0x408003f1, 0x0221121f, 0x03451340, 0x40c003f2, 
-	0x508003f3, 0x405003f4, 
+static const struct hda_pintbl dell_922x_m82_pin_configs[] = {
+	{ 0x0a, 0x02211211 },
+	{ 0x0b, 0x408103ff },
+	{ 0x0c, 0x02a1123e },
+	{ 0x0d, 0x90100310 },
+	{ 0x0e, 0x408003f1 },
+	{ 0x0f, 0x0221121f },
+	{ 0x10, 0x03451340 },
+	{ 0x11, 0x40c003f2 },
+	{ 0x15, 0x508003f3 },
+	{ 0x1b, 0x405003f4 },
+	{}
 };
 
-static const unsigned int d945gtp3_pin_configs[10] = {
-	0x0221401f, 0x01a19022, 0x01813021, 0x01014010,
-	0x40000100, 0x40000100, 0x40000100, 0x40000100,
-	0x02a19120, 0x40000100,
+static const struct hda_pintbl d945gtp3_pin_configs[] = {
+	{ 0x0a, 0x0221401f },
+	{ 0x0b, 0x01a19022 },
+	{ 0x0c, 0x01813021 },
+	{ 0x0d, 0x01014010 },
+	{ 0x0e, 0x40000100 },
+	{ 0x0f, 0x40000100 },
+	{ 0x10, 0x40000100 },
+	{ 0x11, 0x40000100 },
+	{ 0x15, 0x02a19120 },
+	{ 0x1b, 0x40000100 },
+	{}
+};
+
+static const struct hda_pintbl d945gtp5_pin_configs[] = {
+	{ 0x0a, 0x0221401f },
+	{ 0x0b, 0x01011012 },
+	{ 0x0c, 0x01813024 },
+	{ 0x0d, 0x01014010 },
+	{ 0x0e, 0x01a19021 },
+	{ 0x0f, 0x01016011 },
+	{ 0x10, 0x01452130 },
+	{ 0x11, 0x40000100 },
+	{ 0x15, 0x02a19320 },
+	{ 0x1b, 0x40000100 },
+	{}
 };
 
-static const unsigned int d945gtp5_pin_configs[10] = {
-	0x0221401f, 0x01011012, 0x01813024, 0x01014010,
-	0x01a19021, 0x01016011, 0x01452130, 0x40000100,
-	0x02a19320, 0x40000100,
+static const struct hda_pintbl intel_mac_v1_pin_configs[] = {
+	{ 0x0a, 0x0121e21f },
+	{ 0x0b, 0x400000ff },
+	{ 0x0c, 0x9017e110 },
+	{ 0x0d, 0x400000fd },
+	{ 0x0e, 0x400000fe },
+	{ 0x0f, 0x0181e020 },
+	{ 0x10, 0x1145e030 },
+	{ 0x11, 0x11c5e240 },
+	{ 0x15, 0x400000fc },
+	{ 0x1b, 0x400000fb },
+	{}
 };
 
-static const unsigned int intel_mac_v1_pin_configs[10] = {
-	0x0121e21f, 0x400000ff, 0x9017e110, 0x400000fd,
-	0x400000fe, 0x0181e020, 0x1145e030, 0x11c5e240,
-	0x400000fc, 0x400000fb,
+static const struct hda_pintbl intel_mac_v2_pin_configs[] = {
+	{ 0x0a, 0x0121e21f },
+	{ 0x0b, 0x90a7012e },
+	{ 0x0c, 0x9017e110 },
+	{ 0x0d, 0x400000fd },
+	{ 0x0e, 0x400000fe },
+	{ 0x0f, 0x0181e020 },
+	{ 0x10, 0x1145e230 },
+	{ 0x11, 0x500000fa },
+	{ 0x15, 0x400000fc },
+	{ 0x1b, 0x400000fb },
+	{}
 };
 
-static const unsigned int intel_mac_v2_pin_configs[10] = {
-	0x0121e21f, 0x90a7012e, 0x9017e110, 0x400000fd,
-	0x400000fe, 0x0181e020, 0x1145e230, 0x500000fa,
-	0x400000fc, 0x400000fb,
+static const struct hda_pintbl intel_mac_v3_pin_configs[] = {
+	{ 0x0a, 0x0121e21f },
+	{ 0x0b, 0x90a7012e },
+	{ 0x0c, 0x9017e110 },
+	{ 0x0d, 0x400000fd },
+	{ 0x0e, 0x400000fe },
+	{ 0x0f, 0x0181e020 },
+	{ 0x10, 0x1145e230 },
+	{ 0x11, 0x11c5e240 },
+	{ 0x15, 0x400000fc },
+	{ 0x1b, 0x400000fb },
+	{}
 };
 
-static const unsigned int intel_mac_v3_pin_configs[10] = {
-	0x0121e21f, 0x90a7012e, 0x9017e110, 0x400000fd,
-	0x400000fe, 0x0181e020, 0x1145e230, 0x11c5e240,
-	0x400000fc, 0x400000fb,
+static const struct hda_pintbl intel_mac_v4_pin_configs[] = {
+	{ 0x0a, 0x0321e21f },
+	{ 0x0b, 0x03a1e02e },
+	{ 0x0c, 0x9017e110 },
+	{ 0x0d, 0x9017e11f },
+	{ 0x0e, 0x400000fe },
+	{ 0x0f, 0x0381e020 },
+	{ 0x10, 0x1345e230 },
+	{ 0x11, 0x13c5e240 },
+	{ 0x15, 0x400000fc },
+	{ 0x1b, 0x400000fb },
+	{}
 };
 
-static const unsigned int intel_mac_v4_pin_configs[10] = {
-	0x0321e21f, 0x03a1e02e, 0x9017e110, 0x9017e11f,
-	0x400000fe, 0x0381e020, 0x1345e230, 0x13c5e240,
-	0x400000fc, 0x400000fb,
+static const struct hda_pintbl intel_mac_v5_pin_configs[] = {
+	{ 0x0a, 0x0321e21f },
+	{ 0x0b, 0x03a1e02e },
+	{ 0x0c, 0x9017e110 },
+	{ 0x0d, 0x9017e11f },
+	{ 0x0e, 0x400000fe },
+	{ 0x0f, 0x0381e020 },
+	{ 0x10, 0x1345e230 },
+	{ 0x11, 0x13c5e240 },
+	{ 0x15, 0x400000fc },
+	{ 0x1b, 0x400000fb },
+	{}
 };
 
-static const unsigned int intel_mac_v5_pin_configs[10] = {
-	0x0321e21f, 0x03a1e02e, 0x9017e110, 0x9017e11f,
-	0x400000fe, 0x0381e020, 0x1345e230, 0x13c5e240,
-	0x400000fc, 0x400000fb,
+static const struct hda_pintbl ecs202_pin_configs[] = {
+	{ 0x0a, 0x0221401f },
+	{ 0x0b, 0x02a19020 },
+	{ 0x0c, 0x01a19020 },
+	{ 0x0d, 0x01114010 },
+	{ 0x0e, 0x408000f0 },
+	{ 0x0f, 0x01813022 },
+	{ 0x10, 0x074510a0 },
+	{ 0x11, 0x40c400f1 },
+	{ 0x15, 0x9037012e },
+	{ 0x1b, 0x40e000f2 },
+	{}
 };
 
-static const unsigned int ecs202_pin_configs[10] = {
-	0x0221401f, 0x02a19020, 0x01a19020, 0x01114010,
-	0x408000f0, 0x01813022, 0x074510a0, 0x40c400f1,
-	0x9037012e, 0x40e000f2,
+/* codec SSIDs for Intel Mac sharing the same PCI SSID 8384:7680 */
+static const struct snd_pci_quirk stac922x_intel_mac_fixup_tbl[] = {
+	SND_PCI_QUIRK(0x106b, 0x0800, "Mac", STAC_INTEL_MAC_V1),
+	SND_PCI_QUIRK(0x106b, 0x0600, "Mac", STAC_INTEL_MAC_V2),
+	SND_PCI_QUIRK(0x106b, 0x0700, "Mac", STAC_INTEL_MAC_V2),
+	SND_PCI_QUIRK(0x106b, 0x0e00, "Mac", STAC_INTEL_MAC_V3),
+	SND_PCI_QUIRK(0x106b, 0x0f00, "Mac", STAC_INTEL_MAC_V3),
+	SND_PCI_QUIRK(0x106b, 0x1600, "Mac", STAC_INTEL_MAC_V3),
+	SND_PCI_QUIRK(0x106b, 0x1700, "Mac", STAC_INTEL_MAC_V3),
+	SND_PCI_QUIRK(0x106b, 0x0200, "Mac", STAC_INTEL_MAC_V3),
+	SND_PCI_QUIRK(0x106b, 0x1e00, "Mac", STAC_INTEL_MAC_V3),
+	SND_PCI_QUIRK(0x106b, 0x1a00, "Mac", STAC_INTEL_MAC_V4),
+	SND_PCI_QUIRK(0x106b, 0x0a00, "Mac", STAC_INTEL_MAC_V5),
+	SND_PCI_QUIRK(0x106b, 0x2200, "Mac", STAC_INTEL_MAC_V5),
+	{}
 };
 
-static const unsigned int *stac922x_brd_tbl[STAC_922X_MODELS] = {
-	[STAC_D945_REF] = ref922x_pin_configs,
-	[STAC_D945GTP3] = d945gtp3_pin_configs,
-	[STAC_D945GTP5] = d945gtp5_pin_configs,
-	[STAC_INTEL_MAC_V1] = intel_mac_v1_pin_configs,
-	[STAC_INTEL_MAC_V2] = intel_mac_v2_pin_configs,
-	[STAC_INTEL_MAC_V3] = intel_mac_v3_pin_configs,
-	[STAC_INTEL_MAC_V4] = intel_mac_v4_pin_configs,
-	[STAC_INTEL_MAC_V5] = intel_mac_v5_pin_configs,
-	[STAC_INTEL_MAC_AUTO] = intel_mac_v3_pin_configs,
-	/* for backward compatibility */
-	[STAC_MACMINI] = intel_mac_v3_pin_configs,
-	[STAC_MACBOOK] = intel_mac_v5_pin_configs,
-	[STAC_MACBOOK_PRO_V1] = intel_mac_v3_pin_configs,
-	[STAC_MACBOOK_PRO_V2] = intel_mac_v3_pin_configs,
-	[STAC_IMAC_INTEL] = intel_mac_v2_pin_configs,
-	[STAC_IMAC_INTEL_20] = intel_mac_v3_pin_configs,
-	[STAC_ECS_202] = ecs202_pin_configs,
-	[STAC_922X_DELL_D81] = dell_922x_d81_pin_configs,
-	[STAC_922X_DELL_D82] = dell_922x_d82_pin_configs,	
-	[STAC_922X_DELL_M81] = dell_922x_m81_pin_configs,
-	[STAC_922X_DELL_M82] = dell_922x_m82_pin_configs,	
-};
-
-static const char * const stac922x_models[STAC_922X_MODELS] = {
-	[STAC_922X_AUTO] = "auto",
-	[STAC_D945_REF]	= "ref",
-	[STAC_D945GTP5]	= "5stack",
-	[STAC_D945GTP3]	= "3stack",
-	[STAC_INTEL_MAC_V1] = "intel-mac-v1",
-	[STAC_INTEL_MAC_V2] = "intel-mac-v2",
-	[STAC_INTEL_MAC_V3] = "intel-mac-v3",
-	[STAC_INTEL_MAC_V4] = "intel-mac-v4",
-	[STAC_INTEL_MAC_V5] = "intel-mac-v5",
-	[STAC_INTEL_MAC_AUTO] = "intel-mac-auto",
+static const struct hda_fixup stac922x_fixups[];
+
+/* remap the fixup from codec SSID and apply it */
+static void stac922x_fixup_intel_mac_auto(struct hda_codec *codec,
+					  const struct hda_fixup *fix,
+					  int action)
+{
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+	snd_hda_pick_fixup(codec, NULL, stac922x_intel_mac_fixup_tbl,
+			   stac922x_fixups);
+	if (codec->fixup_id != STAC_INTEL_MAC_AUTO)
+		snd_hda_apply_fixup(codec, action);
+}
+
+static void stac922x_fixup_intel_mac_gpio(struct hda_codec *codec,
+					  const struct hda_fixup *fix,
+					  int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->gpio_mask = spec->gpio_dir = 0x03;
+		spec->gpio_data = 0x03;
+	}
+}
+
+static const struct hda_fixup stac922x_fixups[] = {
+	[STAC_D945_REF] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = ref922x_pin_configs,
+	},
+	[STAC_D945GTP3] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = d945gtp3_pin_configs,
+	},
+	[STAC_D945GTP5] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = d945gtp5_pin_configs,
+	},
+	[STAC_INTEL_MAC_AUTO] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac922x_fixup_intel_mac_auto,
+	},
+	[STAC_INTEL_MAC_V1] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = intel_mac_v1_pin_configs,
+		.chained = true,
+		.chain_id = STAC_922X_INTEL_MAC_GPIO,
+	},
+	[STAC_INTEL_MAC_V2] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = intel_mac_v2_pin_configs,
+		.chained = true,
+		.chain_id = STAC_922X_INTEL_MAC_GPIO,
+	},
+	[STAC_INTEL_MAC_V3] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = intel_mac_v3_pin_configs,
+		.chained = true,
+		.chain_id = STAC_922X_INTEL_MAC_GPIO,
+	},
+	[STAC_INTEL_MAC_V4] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = intel_mac_v4_pin_configs,
+		.chained = true,
+		.chain_id = STAC_922X_INTEL_MAC_GPIO,
+	},
+	[STAC_INTEL_MAC_V5] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = intel_mac_v5_pin_configs,
+		.chained = true,
+		.chain_id = STAC_922X_INTEL_MAC_GPIO,
+	},
+	[STAC_922X_INTEL_MAC_GPIO] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac922x_fixup_intel_mac_gpio,
+	},
+	[STAC_ECS_202] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = ecs202_pin_configs,
+	},
+	[STAC_922X_DELL_D81] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = dell_922x_d81_pin_configs,
+	},
+	[STAC_922X_DELL_D82] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = dell_922x_d82_pin_configs,
+	},
+	[STAC_922X_DELL_M81] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = dell_922x_m81_pin_configs,
+	},
+	[STAC_922X_DELL_M82] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = dell_922x_m82_pin_configs,
+	},
+};
+
+static const struct hda_model_fixup stac922x_models[] = {
+	{ .id = STAC_D945_REF, .name = "ref" },
+	{ .id = STAC_D945GTP5, .name = "5stack" },
+	{ .id = STAC_D945GTP3, .name = "3stack" },
+	{ .id = STAC_INTEL_MAC_V1, .name = "intel-mac-v1" },
+	{ .id = STAC_INTEL_MAC_V2, .name = "intel-mac-v2" },
+	{ .id = STAC_INTEL_MAC_V3, .name = "intel-mac-v3" },
+	{ .id = STAC_INTEL_MAC_V4, .name = "intel-mac-v4" },
+	{ .id = STAC_INTEL_MAC_V5, .name = "intel-mac-v5" },
+	{ .id = STAC_INTEL_MAC_AUTO, .name = "intel-mac-auto" },
+	{ .id = STAC_ECS_202, .name = "ecs202" },
+	{ .id = STAC_922X_DELL_D81, .name = "dell-d81" },
+	{ .id = STAC_922X_DELL_D82, .name = "dell-d82" },
+	{ .id = STAC_922X_DELL_M81, .name = "dell-m81" },
+	{ .id = STAC_922X_DELL_M82, .name = "dell-m82" },
 	/* for backward compatibility */
-	[STAC_MACMINI]	= "macmini",
-	[STAC_MACBOOK]	= "macbook",
-	[STAC_MACBOOK_PRO_V1]	= "macbook-pro-v1",
-	[STAC_MACBOOK_PRO_V2]	= "macbook-pro",
-	[STAC_IMAC_INTEL] = "imac-intel",
-	[STAC_IMAC_INTEL_20] = "imac-intel-20",
-	[STAC_ECS_202] = "ecs202",
-	[STAC_922X_DELL_D81] = "dell-d81",
-	[STAC_922X_DELL_D82] = "dell-d82",
-	[STAC_922X_DELL_M81] = "dell-m81",
-	[STAC_922X_DELL_M82] = "dell-m82",
-};
-
-static const struct snd_pci_quirk stac922x_cfg_tbl[] = {
+	{ .id = STAC_INTEL_MAC_V3, .name = "macmini" },
+	{ .id = STAC_INTEL_MAC_V5, .name = "macbook" },
+	{ .id = STAC_INTEL_MAC_V3, .name = "macbook-pro-v1" },
+	{ .id = STAC_INTEL_MAC_V3, .name = "macbook-pro" },
+	{ .id = STAC_INTEL_MAC_V2, .name = "imac-intel" },
+	{ .id = STAC_INTEL_MAC_V3, .name = "imac-intel-20" },
+	{}
+};
+
+static const struct snd_pci_quirk stac922x_fixup_tbl[] = {
 	/* SigmaTel reference board */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668,
 		      "DFI LanParty", STAC_D945_REF),
@@ -2347,9 +2535,10 @@ static const struct snd_pci_quirk stac922x_cfg_tbl[] = {
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x0204,
 		      "Intel D945", STAC_D945_REF),
 	/* other systems  */
+
 	/* Apple Intel Mac (Mac Mini, MacBook, MacBook Pro...) */
-	SND_PCI_QUIRK(0x8384, 0x7680,
-		      "Mac", STAC_INTEL_MAC_AUTO),
+	SND_PCI_QUIRK(0x8384, 0x7680, "Mac", STAC_INTEL_MAC_AUTO),
+
 	/* Dell systems  */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x01a7,
 		      "unknown Dell", STAC_922X_DELL_D81),
@@ -6357,54 +6546,9 @@ static int patch_stac922x(struct hda_codec *codec)
 
 	spec = codec->spec;
 	spec->linear_tone_beep = 1;
-	spec->board_config = snd_hda_check_board_config(codec, STAC_922X_MODELS,
-							stac922x_models,
-							stac922x_cfg_tbl);
-	if (spec->board_config == STAC_INTEL_MAC_AUTO) {
-		spec->gpio_mask = spec->gpio_dir = 0x03;
-		spec->gpio_data = 0x03;
-		/* Intel Macs have all same PCI SSID, so we need to check
-		 * codec SSID to distinguish the exact models
-		 */
-		printk(KERN_INFO "hda_codec: STAC922x, Apple subsys_id=%x\n", codec->subsystem_id);
-		switch (codec->subsystem_id) {
 
-		case 0x106b0800:
-			spec->board_config = STAC_INTEL_MAC_V1;
-			break;
-		case 0x106b0600:
-		case 0x106b0700:
-			spec->board_config = STAC_INTEL_MAC_V2;
-			break;
-		case 0x106b0e00:
-		case 0x106b0f00:
-		case 0x106b1600:
-		case 0x106b1700:
-		case 0x106b0200:
-		case 0x106b1e00:
-			spec->board_config = STAC_INTEL_MAC_V3;
-			break;
-		case 0x106b1a00:
-		case 0x00000100:
-			spec->board_config = STAC_INTEL_MAC_V4;
-			break;
-		case 0x106b0a00:
-		case 0x106b2200:
-			spec->board_config = STAC_INTEL_MAC_V5;
-			break;
-		default:
-			spec->board_config = STAC_INTEL_MAC_V3;
-			break;
-		}
-	}
-
- again:
-	if (spec->board_config < 0)
-		snd_printdd(KERN_INFO "hda_codec: %s: BIOS auto-probing.\n",
-			    codec->chip_name);
-	else
-		stac92xx_set_config_regs(codec,
-				stac922x_brd_tbl[spec->board_config]);
+	snd_hda_pick_fixup(codec, stac922x_models, stac922x_fixup_tbl,
+			   stac922x_fixups);
 
 	spec->adc_nids = stac922x_adc_nids;
 	spec->mux_nids = stac922x_mux_nids;
@@ -6413,24 +6557,19 @@ static int patch_stac922x(struct hda_codec *codec)
 	spec->num_dmics = 0;
 	spec->num_pwrs = 0;
 
-	spec->init = stac922x_core_init;
-
 	spec->num_caps = STAC922X_NUM_CAPS;
 	spec->capvols = stac922x_capvols;
 	spec->capsws = stac922x_capsws;
 
 	spec->multiout.dac_nids = spec->dac_nids;
 	
+	snd_hda_add_verbs(codec, stac922x_core_init);
+
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
+
 	err = stac92xx_parse_auto_config(codec);
-	if (!err) {
-		if (spec->board_config < 0) {
-			printk(KERN_WARNING "hda_codec: No auto-config is "
-			       "available, default to model=ref\n");
-			spec->board_config = STAC_D945_REF;
-			goto again;
-		}
+	if (!err)
 		err = -EINVAL;
-	}
 	if (err < 0) {
 		stac92xx_free(codec);
 		return err;
@@ -6445,6 +6584,8 @@ static int patch_stac922x(struct hda_codec *codec)
 				  (0x27 << AC_AMPCAP_STEP_SIZE_SHIFT) |
 				  (0 << AC_AMPCAP_MUTE_SHIFT));
 
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
+
 	return 0;
 }
 
-- 
1.8.1
