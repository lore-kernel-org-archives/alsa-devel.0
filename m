From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 4/6] ALSA: hda: Separate generic and
	non-generic implementations
Date: Wed,  1 Jun 2011 11:14:19 -0600
Message-ID: <1306948461-2402-5-git-send-email-swarren@nvidia.com>
References: <1306948461-2402-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id B24AC1038B8
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jun 2011 19:14:53 +0200 (CEST)
In-Reply-To: <1306948461-2402-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz, wfg@linux.intel.com
Cc: wni@nvidia.com, Stephen Warren <swarren@nvidia.com>, ndaga@nvidia.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

A future change will significantly rework the generic implementation
in order to support codecs with a different number of pins and
converters. Isolate the more custom codec variants from this change by
duplicating the small portions of generic code they share. This
simplifies the later rework of that previously shared code, since we
don't have to consider the more custom codecs, and also prevents
support for those codecs from regressing.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/pci/hda/patch_hdmi.c |   75 ++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 66 insertions(+), 9 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 13ee444..92fb105 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1164,6 +1164,63 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 }
 
 /*
+ * Shared non-generic implementations
+ */
+
+static int simple_playback_build_pcms(struct hda_codec *codec)
+{
+	struct hdmi_spec *spec = codec->spec;
+	struct hda_pcm *info = spec->pcm_rec;
+	int i;
+
+	codec->num_pcms = spec->num_cvts;
+	codec->pcm_info = info;
+
+	for (i = 0; i < codec->num_pcms; i++, info++) {
+		unsigned int chans;
+		struct hda_pcm_stream *pstr;
+
+		chans = get_wcaps(codec, spec->cvt[i]);
+		chans = get_wcaps_channels(chans);
+
+		info->name = generic_hdmi_pcm_names[i];
+		info->pcm_type = HDA_PCM_TYPE_HDMI;
+		pstr = &info->stream[SNDRV_PCM_STREAM_PLAYBACK];
+		snd_BUG_ON(!spec->pcm_playback);
+		*pstr = *spec->pcm_playback;
+		pstr->nid = spec->cvt[i];
+		if (pstr->channels_max <= 2 && chans && chans <= 16)
+			pstr->channels_max = chans;
+	}
+
+	return 0;
+}
+
+static int simple_playback_build_controls(struct hda_codec *codec)
+{
+	struct hdmi_spec *spec = codec->spec;
+	int err;
+	int i;
+
+	for (i = 0; i < codec->num_pcms; i++) {
+		err = snd_hda_create_spdif_out_ctls(codec,
+						    spec->cvt[i],
+						    spec->cvt[i]);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+static void simple_playback_free(struct hda_codec *codec)
+{
+	struct hdmi_spec *spec = codec->spec;
+
+	kfree(spec);
+}
+
+/*
  * Nvidia specific implementations
  */
 
@@ -1475,17 +1532,17 @@ static const struct hda_pcm_stream nvhdmi_pcm_playback_2ch = {
 };
 
 static const struct hda_codec_ops nvhdmi_patch_ops_8ch_7x = {
-	.build_controls = generic_hdmi_build_controls,
-	.build_pcms = generic_hdmi_build_pcms,
+	.build_controls = simple_playback_build_controls,
+	.build_pcms = simple_playback_build_pcms,
 	.init = nvhdmi_7x_init,
-	.free = generic_hdmi_free,
+	.free = simple_playback_free,
 };
 
 static const struct hda_codec_ops nvhdmi_patch_ops_2ch = {
-	.build_controls = generic_hdmi_build_controls,
-	.build_pcms = generic_hdmi_build_pcms,
+	.build_controls = simple_playback_build_controls,
+	.build_pcms = simple_playback_build_pcms,
 	.init = nvhdmi_7x_init,
-	.free = generic_hdmi_free,
+	.free = simple_playback_free,
 };
 
 static int patch_nvhdmi_2ch(struct hda_codec *codec)
@@ -1596,10 +1653,10 @@ static int atihdmi_init(struct hda_codec *codec)
 }
 
 static const struct hda_codec_ops atihdmi_patch_ops = {
-	.build_controls = generic_hdmi_build_controls,
-	.build_pcms = generic_hdmi_build_pcms,
+	.build_controls = simple_playback_build_controls,
+	.build_pcms = simple_playback_build_pcms,
 	.init = atihdmi_init,
-	.free = generic_hdmi_free,
+	.free = simple_playback_free,
 };
 
 
-- 
1.7.0.4
