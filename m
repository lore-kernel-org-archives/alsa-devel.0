From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix undefined symbol due to
	builtin/module mixup
Date: Mon, 10 Feb 2014 11:53:01 +0100
Message-ID: <1392029581-32641-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 42B6126072A
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2014 11:53:01 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 2587AABEE
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2014 10:53:01 +0000 (UTC)
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

Even after the fix for leftover kconfig handling (commit f8f1becf),
the current code still doesn't handle properly the builtin/module
mixup case between the core snd-hda-codec and other codec drivers.
For example, when CONFIG_SND_HDA_INTEL=y and
CONFIG_SND_HDA_CODEC_HDMI=m, it'll end up with an unresolved symbol
snd_hda_parse_hdmi_codec.  This patch fixes the issue.

Now codec->parser points to the parser object *only* when a module
(either generic or HDMI parser) is loaded and bound.  When a builtin
symbol is used, codec->parser still points to NULL.  This is the
difference from the previous versions.

Fixes: f8f1becfa4ac ('ALSA: hda - Fix leftover ifdef checks after modularization')
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 69acbf758bbb..dafcf82139e2 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1339,23 +1339,15 @@ get_hda_cvt_setup(struct hda_codec *codec, hda_nid_t nid)
 /*
  * Dynamic symbol binding for the codec parsers
  */
-#ifdef MODULE
-#define load_parser_sym(sym)		((int (*)(struct hda_codec *))symbol_request(sym))
-#define unload_parser_addr(addr)	symbol_put_addr(addr)
-#else
-#define load_parser_sym(sym)		(sym)
-#define unload_parser_addr(addr)	do {} while (0)
-#endif
 
 #define load_parser(codec, sym) \
-	((codec)->parser = load_parser_sym(sym))
+	((codec)->parser = (int (*)(struct hda_codec *))symbol_request(sym))
 
 static void unload_parser(struct hda_codec *codec)
 {
-	if (codec->parser) {
-		unload_parser_addr(codec->parser);
-		codec->parser = NULL;
-	}
+	if (codec->parser)
+		symbol_put_addr(codec->parser);
+	codec->parser = NULL;
 }
 
 /*
@@ -1620,12 +1612,20 @@ int snd_hda_codec_configure(struct hda_codec *codec)
 		patch = codec->preset->patch;
 	if (!patch) {
 		unload_parser(codec); /* to be sure */
-		if (is_likely_hdmi_codec(codec))
+		if (is_likely_hdmi_codec(codec)) {
+#if IS_MODULE(CONFIG_SND_HDA_CODEC_HDMI)
 			patch = load_parser(codec, snd_hda_parse_hdmi_codec);
-#if IS_ENABLED(CONFIG_SND_HDA_GENERIC)
-		if (!patch)
+#elif IS_BUILTIN(CONFIG_SND_HDA_CODEC_HDMI)
+			patch = snd_hda_parse_hdmi_codec;
+#endif
+		}
+		if (!patch) {
+#if IS_MODULE(CONFIG_SND_HDA_GENERIC)
 			patch = load_parser(codec, snd_hda_parse_generic_codec);
+#elif IS_BUILTIN(CONFIG_SND_HDA_GENERIC)
+			patch = snd_hda_parse_generic_codec;
 #endif
+		}
 		if (!patch) {
 			printk(KERN_ERR "hda-codec: No codec parser is available\n");
 			return -ENODEV;
-- 
1.8.5.2
