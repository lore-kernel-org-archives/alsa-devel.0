From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/5] ALSA: hda - Split the generic parser as an
	individual module
Date: Tue, 26 Nov 2013 09:29:09 +0100
Message-ID: <1385454553-12000-2-git-send-email-tiwai@suse.de>
References: <1385454553-12000-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CB82526158B
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 09:29:26 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A2DA7A7B63
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 09:29:26 +0100 (CET)
In-Reply-To: <1385454553-12000-1-git-send-email-tiwai@suse.de>
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

Drop the hard dependency on the generic parser code and load / unload
the generic parser code dynamically if built as a module.  This allows
us to avoid the generic parser if only HDMI/DP codecs are found.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/Makefile      |  5 +++-
 sound/pci/hda/hda_codec.c   | 67 +++++++++++++++++++++++++++++++++------------
 sound/pci/hda/hda_codec.h   |  1 +
 sound/pci/hda/hda_generic.c |  4 +++
 sound/pci/hda/hda_local.h   |  7 -----
 5 files changed, 58 insertions(+), 26 deletions(-)

diff --git a/sound/pci/hda/Makefile b/sound/pci/hda/Makefile
index c091438286a3..5a40c652df41 100644
--- a/sound/pci/hda/Makefile
+++ b/sound/pci/hda/Makefile
@@ -3,7 +3,6 @@ snd-hda-intel-objs := hda_intel.o
 snd-hda-intel-$(CONFIG_SND_HDA_I915) +=	hda_i915.o
 
 snd-hda-codec-y := hda_codec.o hda_jack.o hda_auto_parser.o
-snd-hda-codec-$(CONFIG_SND_HDA_GENERIC) += hda_generic.o
 snd-hda-codec-$(CONFIG_PROC_FS) += hda_proc.o
 snd-hda-codec-$(CONFIG_SND_HDA_HWDEP) += hda_hwdep.o
 snd-hda-codec-$(CONFIG_SND_HDA_INPUT_BEEP) += hda_beep.o
@@ -12,6 +11,7 @@ snd-hda-codec-$(CONFIG_SND_HDA_INPUT_BEEP) += hda_beep.o
 CFLAGS_hda_codec.o := -I$(src)
 CFLAGS_hda_intel.o := -I$(src)
 
+snd-hda-codec-generic-objs :=	hda_generic.o
 snd-hda-codec-realtek-objs :=	patch_realtek.o
 snd-hda-codec-cmedia-objs :=	patch_cmedia.o
 snd-hda-codec-analog-objs :=	patch_analog.o
@@ -28,6 +28,9 @@ snd-hda-codec-hdmi-objs :=	patch_hdmi.o hda_eld.o
 obj-$(CONFIG_SND_HDA_INTEL) := snd-hda-codec.o
 
 # codec drivers (note: CONFIG_SND_HDA_CODEC_XXX are booleans)
+ifdef CONFIG_SND_HDA_GENERIC
+obj-$(CONFIG_SND_HDA_INTEL) += snd-hda-codec-generic.o
+endif
 ifdef CONFIG_SND_HDA_CODEC_REALTEK
 obj-$(CONFIG_SND_HDA_INTEL) += snd-hda-codec-realtek.o
 endif
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 69178c4f4113..4d3f46329eb5 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -945,9 +945,6 @@ find_codec_preset(struct hda_codec *codec)
 	const struct hda_codec_preset *preset;
 	unsigned int mod_requested = 0;
 
-	if (is_generic_config(codec))
-		return NULL; /* use the generic parser */
-
  again:
 	mutex_lock(&preset_mutex);
 	list_for_each_entry(tbl, &hda_preset_tables, list) {
@@ -1330,6 +1327,28 @@ get_hda_cvt_setup(struct hda_codec *codec, hda_nid_t nid)
 }
 
 /*
+ * Dynamic symbol binding for the codec parsers
+ */
+#ifdef MODULE
+#define load_parser_sym(sym)		((int (*)(struct hda_codec *))symbol_request(sym))
+#define unload_parser_addr(addr)	symbol_put_addr(addr)
+#else
+#define load_parser_sym(sym)		(sym)
+#define unload_parser_addr(addr)	do {} while (0)
+#endif
+
+#define load_parser(codec, sym) \
+	((codec)->parser = load_parser_sym(sym))
+
+static void unload_parser(struct hda_codec *codec)
+{
+	if (codec->parser) {
+		unload_parser_addr(codec->parser);
+		codec->parser = NULL;
+	}
+}
+
+/*
  * codec destructor
  */
 static void snd_hda_codec_free(struct hda_codec *codec)
@@ -1356,6 +1375,7 @@ static void snd_hda_codec_free(struct hda_codec *codec)
 	if (!codec->pm_down_notified) /* cancel leftover refcounts */
 		hda_call_pm_notify(codec->bus, false);
 #endif
+	unload_parser(codec);
 	module_put(codec->owner);
 	free_hda_cache(&codec->amp_cache);
 	free_hda_cache(&codec->cmd_cache);
@@ -1548,6 +1568,7 @@ EXPORT_SYMBOL_HDA(snd_hda_codec_update_widgets);
  */
 int snd_hda_codec_configure(struct hda_codec *codec)
 {
+	int (*patch)(struct hda_codec *) = NULL;
 	int err;
 
 	codec->preset = find_codec_preset(codec);
@@ -1557,29 +1578,38 @@ int snd_hda_codec_configure(struct hda_codec *codec)
 			return err;
 	}
 
-	if (is_generic_config(codec)) {
-		err = snd_hda_parse_generic_codec(codec);
-		goto patched;
-	}
-	if (codec->preset && codec->preset->patch) {
-		err = codec->preset->patch(codec);
-		goto patched;
+	if (!is_generic_config(codec) && codec->preset)
+		patch = codec->preset->patch;
+	if (!patch) {
+		unload_parser(codec); /* to be sure */
+#ifdef CONFIG_SND_HDA_GENERIC
+		if (!patch)
+			patch = load_parser(codec, snd_hda_parse_generic_codec);
+#endif
+		if (!patch) {
+			printk(KERN_ERR "hda-codec: No codec parser is available\n");
+			return -ENODEV;
+		}
 	}
 
-	/* call the default parser */
-	err = snd_hda_parse_generic_codec(codec);
-	if (err < 0)
-		printk(KERN_ERR "hda-codec: No codec parser is available\n");
+	err = patch(codec);
+	if (err < 0) {
+		unload_parser(codec);
+		return err;
+	}
 
- patched:
-	if (!err && codec->patch_ops.unsol_event)
+	if (codec->patch_ops.unsol_event) {
 		err = init_unsol_queue(codec->bus);
+		if (err < 0)
+			return err;
+	}
+
 	/* audio codec should override the mixer name */
-	if (!err && (codec->afg || !*codec->bus->card->mixername))
+	if (codec->afg || !*codec->bus->card->mixername)
 		snprintf(codec->bus->card->mixername,
 			 sizeof(codec->bus->card->mixername),
 			 "%s %s", codec->vendor_name, codec->chip_name);
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL_HDA(snd_hda_codec_configure);
 
@@ -2610,6 +2640,7 @@ int snd_hda_codec_reset(struct hda_codec *codec)
 	codec->preset = NULL;
 	codec->slave_dig_outs = NULL;
 	codec->spdif_status_reset = 0;
+	unload_parser(codec);
 	module_put(codec->owner);
 	codec->owner = NULL;
 
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 77db69480c19..a45eaeebb4ec 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -835,6 +835,7 @@ struct hda_codec {
 	/* detected preset */
 	const struct hda_codec_preset *preset;
 	struct module *owner;
+	int (*parser)(struct hda_codec *codec);
 	const char *vendor_name;	/* codec vendor name */
 	const char *chip_name;		/* codec chip name */
 	const char *modelname;	/* model name for preset */
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 3067ed4fe3b2..9b251456f2a0 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -28,6 +28,7 @@
 #include <linux/ctype.h>
 #include <linux/string.h>
 #include <linux/bitops.h>
+#include <linux/module.h>
 #include <sound/core.h>
 #include <sound/jack.h>
 #include "hda_codec.h"
@@ -5291,3 +5292,6 @@ error:
 	return err;
 }
 EXPORT_SYMBOL_HDA(snd_hda_parse_generic_codec);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Generic HD-audio codec parser");
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index d398b648bb5d..4d571a6d9230 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -352,14 +352,7 @@ int snd_hda_multi_out_analog_cleanup(struct hda_codec *codec,
 /*
  * generic codec parser
  */
-#ifdef CONFIG_SND_HDA_GENERIC
 int snd_hda_parse_generic_codec(struct hda_codec *codec);
-#else
-static inline int snd_hda_parse_generic_codec(struct hda_codec *codec)
-{
-	return -ENODEV;
-}
-#endif
 
 /*
  * generic proc interface
-- 
1.8.4.3
