From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/5] ALSA: hda - Bind with HDMI codec parser
	automatically
Date: Tue, 26 Nov 2013 09:29:10 +0100
Message-ID: <1385454553-12000-3-git-send-email-tiwai@suse.de>
References: <1385454553-12000-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C9BF92610D7
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 09:29:26 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A3C23A7B64
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

If a codec contains only the digital outputs, it's very likely a
HDMI/DP codec, which isn't supported by the generic parser but via
HDMI codec parser code.  Detect such a case and bind with the proper
parser object if available.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c  | 27 +++++++++++++++++++++++++++
 sound/pci/hda/hda_local.h  |  1 +
 sound/pci/hda/patch_hdmi.c |  9 +++++++++
 3 files changed, 37 insertions(+)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 4d3f46329eb5..bada677df8a7 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1557,6 +1557,31 @@ int snd_hda_codec_update_widgets(struct hda_codec *codec)
 EXPORT_SYMBOL_HDA(snd_hda_codec_update_widgets);
 
 
+#ifdef CONFIG_SND_HDA_CODEC_HDMI
+/* if all audio out widgets are digital, let's assume the codec as a HDMI/DP */
+static bool is_likely_hdmi_codec(struct hda_codec *codec)
+{
+	hda_nid_t nid = codec->start_nid;
+	int i;
+
+	for (i = 0; i < codec->num_nodes; i++, nid++) {
+		unsigned int wcaps = get_wcaps(codec, nid);
+		switch (get_wcaps_type(wcaps)) {
+		case AC_WID_AUD_IN:
+			return false; /* HDMI parser supports only HDMI out */
+		case AC_WID_AUD_OUT:
+			if (!(wcaps & AC_WCAP_DIGITAL))
+				return false;
+			break;
+		}
+	}
+	return true;
+}
+#else
+/* no HDMI codec parser support */
+#define is_likely_hdmi_codec(codec)	false
+#endif /* CONFIG_SND_HDA_CODEC_HDMI */
+
 /**
  * snd_hda_codec_configure - (Re-)configure the HD-audio codec
  * @codec: the HDA codec
@@ -1582,6 +1607,8 @@ int snd_hda_codec_configure(struct hda_codec *codec)
 		patch = codec->preset->patch;
 	if (!patch) {
 		unload_parser(codec); /* to be sure */
+		if (is_likely_hdmi_codec(codec))
+			patch = load_parser(codec, snd_hda_parse_hdmi_codec);
 #ifdef CONFIG_SND_HDA_GENERIC
 		if (!patch)
 			patch = load_parser(codec, snd_hda_parse_generic_codec);
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 4d571a6d9230..da80c5bd7fd4 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -353,6 +353,7 @@ int snd_hda_multi_out_analog_cleanup(struct hda_codec *codec,
  * generic codec parser
  */
 int snd_hda_parse_generic_codec(struct hda_codec *codec);
+int snd_hda_parse_hdmi_codec(struct hda_codec *codec);
 
 /*
  * generic proc interface
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 08407bed093e..a6081ed34b88 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -3214,6 +3214,15 @@ static int patch_via_hdmi(struct hda_codec *codec)
 }
 
 /*
+ * called from hda_codec.c for generic HDMI support
+ */
+int snd_hda_parse_hdmi_codec(struct hda_codec *codec)
+{
+	return patch_generic_hdmi(codec);
+}
+EXPORT_SYMBOL_HDA(snd_hda_parse_hdmi_codec);
+
+/*
  * patch entries
  */
 static const struct hda_codec_preset snd_hda_preset_hdmi[] = {
-- 
1.8.4.3
