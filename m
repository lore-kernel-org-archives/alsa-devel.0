From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Fix missing module loading
	with model=generic option
Date: Wed, 20 Jan 2016 15:59:18 +0100
Message-ID: <1453301958-5483-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A54EB2605F1
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2016 15:59:19 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 9DC9CADC1
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2016 14:59:18 +0000 (UTC)
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

When the generic codec driver is specified via model option or such,
the hda driver doesn't try to load the generic driver module but still
loads the codec-specific driver, and this ends up with the binding
failure.

This patch fixes it by moving the generic module request in the common
helper code.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=111021
Cc: <stable@vger.kernel.org> # v4.4+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_bind.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index 70671ad65d24..6efadbfb3fe3 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -174,14 +174,40 @@ static inline bool codec_probed(struct hda_codec *codec)
 	return device_attach(hda_codec_dev(codec)) > 0 && codec->preset;
 }
 
-/* try to auto-load and bind the codec module */
-static void codec_bind_module(struct hda_codec *codec)
+/* try to auto-load codec module */
+static void request_codec_module(struct hda_codec *codec)
 {
 #ifdef MODULE
 	char modalias[32];
+	const char *mod = NULL;
+
+	switch (codec->probe_id) {
+	case HDA_CODEC_ID_GENERIC_HDMI:
+#if IS_MODULE(CONFIG_SND_HDA_CODEC_HDMI)
+		mod = "snd-hda-codec-hdmi";
+#endif
+		break;
+	case HDA_CODEC_ID_GENERIC:
+#if IS_MODULE(CONFIG_SND_HDA_GENERIC)
+		mod = "snd-hda-codec-generic";
+#endif
+		break;
+	default:
+		snd_hdac_codec_modalias(&codec->core, modalias, sizeof(modalias));
+		mod = modalias;
+		break;
+	}
+
+	if (mod)
+		request_module(mod);
+#endif /* MODULE */
+}
 
-	snd_hdac_codec_modalias(&codec->core, modalias, sizeof(modalias));
-	request_module(modalias);
+/* try to auto-load and bind the codec module */
+static void codec_bind_module(struct hda_codec *codec)
+{
+#ifdef MODULE
+	request_codec_module(codec);
 	if (codec_probed(codec))
 		return;
 #endif
@@ -218,17 +244,13 @@ static int codec_bind_generic(struct hda_codec *codec)
 
 	if (is_likely_hdmi_codec(codec)) {
 		codec->probe_id = HDA_CODEC_ID_GENERIC_HDMI;
-#if IS_MODULE(CONFIG_SND_HDA_CODEC_HDMI)
-		request_module("snd-hda-codec-hdmi");
-#endif
+		request_codec_module(codec);
 		if (codec_probed(codec))
 			return 0;
 	}
 
 	codec->probe_id = HDA_CODEC_ID_GENERIC;
-#if IS_MODULE(CONFIG_SND_HDA_GENERIC)
-	request_module("snd-hda-codec-generic");
-#endif
+	request_codec_module(codec);
 	if (codec_probed(codec))
 		return 0;
 	return -ENODEV;
-- 
2.7.0
