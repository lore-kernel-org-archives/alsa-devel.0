From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/8] ALSA: hda - Use generic codec parser for
	C-Media codecs
Date: Tue,  8 Jan 2013 12:50:43 +0100
Message-ID: <1357645849-8181-3-git-send-email-tiwai@suse.de>
References: <1357645849-8181-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 808B8265F7C
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:50:59 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 650A5A4FFA
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:50:59 +0100 (CET)
In-Reply-To: <1357645849-8181-1-git-send-email-tiwai@suse.de>
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

Replace the old parser code for C-Media auto-parser with the latest
generic parser.  For compatibility reason, the static bindings are
still left, but they could be cleaned up in future.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/Kconfig        |   1 +
 sound/pci/hda/patch_cmedia.c | 164 ++++++++++++-------------------------------
 2 files changed, 47 insertions(+), 118 deletions(-)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 93404d7..d3d7287 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -201,6 +201,7 @@ config SND_HDA_CODEC_CA0132
 config SND_HDA_CODEC_CMEDIA
 	bool "Build C-Media HD-audio codec support"
 	default y
+	select SND_HDA_GENERIC
 	help
 	  Say Y here to include C-Media HD-audio codec support in
 	  snd-hda-intel driver, such as CMI9880.
diff --git a/sound/pci/hda/patch_cmedia.c b/sound/pci/hda/patch_cmedia.c
index c8fdaae..04dd3b6 100644
--- a/sound/pci/hda/patch_cmedia.c
+++ b/sound/pci/hda/patch_cmedia.c
@@ -30,6 +30,9 @@
 #include "hda_codec.h"
 #include "hda_local.h"
 #include "hda_auto_parser.h"
+#include "hda_jack.h"
+#include "hda_generic.h"
+
 #define NUM_PINS	11
 
 
@@ -45,6 +48,10 @@ enum {
 };
 
 struct cmi_spec {
+	struct hda_gen_spec gen;
+
+	/* below are only for static models */
+
 	int board_config;
 	unsigned int no_line_in: 1;	/* no line-in (5-jack) */
 	unsigned int front_panel: 1;	/* has front-panel 2-jack */
@@ -356,77 +363,6 @@ static int cmi9880_build_controls(struct hda_codec *codec)
 	return 0;
 }
 
-/* fill in the multi_dac_nids table, which will decide
-   which audio widget to use for each channel */
-static int cmi9880_fill_multi_dac_nids(struct hda_codec *codec, const struct auto_pin_cfg *cfg)
-{
-	struct cmi_spec *spec = codec->spec;
-	hda_nid_t nid;
-	int assigned[4];
-	int i, j;
-
-	/* clear the table, only one c-media dac assumed here */
-	memset(spec->dac_nids, 0, sizeof(spec->dac_nids));
-	memset(assigned, 0, sizeof(assigned));
-	/* check the pins we found */
-	for (i = 0; i < cfg->line_outs; i++) {
-		nid = cfg->line_out_pins[i];
-		/* nid 0x0b~0x0e is hardwired to audio widget 0x3~0x6 */
-		if (nid >= 0x0b && nid <= 0x0e) {
-			spec->dac_nids[i] = (nid - 0x0b) + 0x03;
-			assigned[nid - 0x0b] = 1;
-		}
-	}
-	/* left pin can be connect to any audio widget */
-	for (i = 0; i < cfg->line_outs; i++) {
-		nid = cfg->line_out_pins[i];
-		if (nid <= 0x0e)
-			continue;
-		/* search for an empty channel */
-		for (j = 0; j < cfg->line_outs; j++) {
-			if (! assigned[j]) {
-				spec->dac_nids[i] = j + 0x03;
-				assigned[j] = 1;
-				break;
-			}
-		}
-	}
-	spec->num_dacs = cfg->line_outs;
-	return 0;
-}
-
-/* create multi_init table, which is used for multichannel initialization */
-static int cmi9880_fill_multi_init(struct hda_codec *codec, const struct auto_pin_cfg *cfg)
-{
-	struct cmi_spec *spec = codec->spec;
-	hda_nid_t nid;
-	int i, j, k;
-
-	/* clear the table, only one c-media dac assumed here */
-	memset(spec->multi_init, 0, sizeof(spec->multi_init));
-	for (j = 0, i = 0; i < cfg->line_outs; i++) {
-		nid = cfg->line_out_pins[i];
-		/* set as output */
-		spec->multi_init[j].nid = nid;
-		spec->multi_init[j].verb = AC_VERB_SET_PIN_WIDGET_CONTROL;
-		spec->multi_init[j].param = PIN_OUT;
-		j++;
-		if (nid > 0x0e) {
-			/* set connection */
-			spec->multi_init[j].nid = nid;
-			spec->multi_init[j].verb = AC_VERB_SET_CONNECT_SEL;
-			spec->multi_init[j].param = 0;
-			/* find the index in connect list */
-			k = snd_hda_get_conn_index(codec, nid,
-						   spec->dac_nids[i], 0);
-			if (k >= 0)
-				spec->multi_init[j].param = k;
-			j++;
-		}
-	}
-	return 0;
-}
-
 static int cmi9880_init(struct hda_codec *codec)
 {
 	struct cmi_spec *spec = codec->spec;
@@ -632,6 +568,35 @@ static const struct hda_codec_ops cmi9880_patch_ops = {
 	.free = cmi9880_free,
 };
 
+/*
+ * stuff for auto-parser
+ */
+static const struct hda_codec_ops cmi_auto_patch_ops = {
+	.build_controls = snd_hda_gen_build_controls,
+	.build_pcms = snd_hda_gen_build_pcms,
+	.init = snd_hda_gen_init,
+	.free = snd_hda_gen_free,
+};
+
+static int cmi_parse_auto_config(struct hda_codec *codec)
+{
+	struct cmi_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->gen.autocfg;
+	int err;
+
+	snd_hda_gen_spec_init(&spec->gen);
+
+	err = snd_hda_parse_pin_defcfg(codec, cfg, NULL, 0);
+	if (err < 0)
+		return err;
+	err = snd_hda_gen_parse_auto_config(codec, cfg);
+	if (err < 0)
+		return err;
+
+	codec->patch_ops = cmi_auto_patch_ops;
+	return 0;
+}
+
 static int patch_cmi9880(struct hda_codec *codec)
 {
 	struct cmi_spec *spec;
@@ -650,6 +615,15 @@ static int patch_cmi9880(struct hda_codec *codec)
 		spec->board_config = CMI_AUTO; /* try everything */
 	}
 
+	if (spec->board_config == CMI_AUTO) {
+		int err = cmi_parse_auto_config(codec);
+		if (err < 0) {
+			snd_hda_gen_free(codec);
+			return err;
+		}
+		return 0;
+	}
+
 	/* copy default DAC NIDs */
 	memcpy(spec->dac_nids, cmi9880_dac_nids, sizeof(spec->dac_nids));
 	spec->num_dacs = 4;
@@ -678,59 +652,13 @@ static int patch_cmi9880(struct hda_codec *codec)
 		}
 		break;
 	case CMI_ALLOUT:
+	default:
 		spec->front_panel = 1;
 		spec->multiout.max_channels = 8;
 		spec->no_line_in = 1;
 		spec->input_mux = &cmi9880_no_line_mux;
 		spec->multiout.dig_out_nid = CMI_DIG_OUT_NID;
 		break;
-	case CMI_AUTO:
-		{
-		unsigned int port_e, port_f, port_g, port_h;
-		unsigned int port_spdifi, port_spdifo;
-		struct auto_pin_cfg cfg;
-
-		/* collect pin default configuration */
-		port_e = snd_hda_codec_get_pincfg(codec, 0x0f);
-		port_f = snd_hda_codec_get_pincfg(codec, 0x10);
-		spec->front_panel = 1;
-		if (get_defcfg_connect(port_e) == AC_JACK_PORT_NONE ||
-		    get_defcfg_connect(port_f) == AC_JACK_PORT_NONE) {
-			port_g = snd_hda_codec_get_pincfg(codec, 0x1f);
-			port_h = snd_hda_codec_get_pincfg(codec, 0x20);
-			spec->channel_modes = cmi9880_channel_modes;
-			/* no front panel */
-			if (get_defcfg_connect(port_g) == AC_JACK_PORT_NONE ||
-			    get_defcfg_connect(port_h) == AC_JACK_PORT_NONE) {
-				/* no optional rear panel */
-				spec->board_config = CMI_MINIMAL;
-				spec->front_panel = 0;
-				spec->num_channel_modes = 2;
-			} else {
-				spec->board_config = CMI_MIN_FP;
-				spec->num_channel_modes = 3;
-			}
-			spec->input_mux = &cmi9880_basic_mux;
-			spec->multiout.max_channels = cmi9880_channel_modes[0].channels;
-		} else {
-			spec->input_mux = &cmi9880_basic_mux;
-			port_spdifi = snd_hda_codec_get_pincfg(codec, 0x13);
-			port_spdifo = snd_hda_codec_get_pincfg(codec, 0x12);
-			if (get_defcfg_connect(port_spdifo) != AC_JACK_PORT_NONE)
-				spec->multiout.dig_out_nid = CMI_DIG_OUT_NID;
-			if (get_defcfg_connect(port_spdifi) != AC_JACK_PORT_NONE)
-				spec->dig_in_nid = CMI_DIG_IN_NID;
-			spec->multiout.max_channels = 8;
-		}
-		snd_hda_parse_pin_def_config(codec, &cfg, NULL);
-		if (cfg.line_outs) {
-			spec->multiout.max_channels = cfg.line_outs * 2;
-			cmi9880_fill_multi_dac_nids(codec, &cfg);
-			cmi9880_fill_multi_init(codec, &cfg);
-		} else
-			snd_printd("patch_cmedia: cannot detect association in defcfg\n");
-		break;
-		}
 	}
 
 	spec->multiout.num_dacs = spec->num_dacs;
-- 
1.8.0.1
