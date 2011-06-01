From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 5/6] ALSA: hda: hdmi_eld_update_pcm_info:
	update a stream in place
Date: Wed,  1 Jun 2011 11:14:20 -0600
Message-ID: <1306948461-2402-6-git-send-email-swarren@nvidia.com>
References: <1306948461-2402-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 472E11038A5
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jun 2011 19:14:58 +0200 (CEST)
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

A future change won't store an entire hda_pcm_stream just to represent
the capabilities of a codec; a custom data-structure will be used. To
ease that transition, modify hdmi_eld_update_pcm_info to expect the
hda_pcm_stream to be pre-initialized with the codec's capabilities, and
to update those capabilities in-place based on the ELD.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/pci/hda/hda_eld.c    |   46 ++++++++++++++++++++++---------------------
 sound/pci/hda/hda_local.h  |    4 +-
 sound/pci/hda/patch_hdmi.c |   18 +++++++++-------
 3 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
index b05f7be..473cfa1 100644
--- a/sound/pci/hda/hda_eld.c
+++ b/sound/pci/hda/hda_eld.c
@@ -580,43 +580,45 @@ void snd_hda_eld_proc_free(struct hda_codec *codec, struct hdmi_eld *eld)
 #endif /* CONFIG_PROC_FS */
 
 /* update PCM info based on ELD */
-void hdmi_eld_update_pcm_info(struct hdmi_eld *eld, struct hda_pcm_stream *pcm,
-			      struct hda_pcm_stream *codec_pars)
+void snd_hdmi_eld_update_pcm_info(struct hdmi_eld *eld,
+			      struct hda_pcm_stream *hinfo)
 {
+	u32 rates;
+	u64 formats;
+	unsigned int maxbps;
+	unsigned int channels_max;
 	int i;
 
 	/* assume basic audio support (the basic audio flag is not in ELD;
 	 * however, all audio capable sinks are required to support basic
 	 * audio) */
-	pcm->rates = SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000;
-	pcm->formats = SNDRV_PCM_FMTBIT_S16_LE;
-	pcm->maxbps = 16;
-	pcm->channels_max = 2;
+	rates = SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |
+		SNDRV_PCM_RATE_48000;
+	formats = SNDRV_PCM_FMTBIT_S16_LE;
+	maxbps = 16;
+	channels_max = 2;
 	for (i = 0; i < eld->sad_count; i++) {
 		struct cea_sad *a = &eld->sad[i];
-		pcm->rates |= a->rates;
-		if (a->channels > pcm->channels_max)
-			pcm->channels_max = a->channels;
+		rates |= a->rates;
+		if (a->channels > channels_max)
+			channels_max = a->channels;
 		if (a->format == AUDIO_CODING_TYPE_LPCM) {
 			if (a->sample_bits & AC_SUPPCM_BITS_20) {
-				pcm->formats |= SNDRV_PCM_FMTBIT_S32_LE;
-				if (pcm->maxbps < 20)
-					pcm->maxbps = 20;
+				formats |= SNDRV_PCM_FMTBIT_S32_LE;
+				if (maxbps < 20)
+					maxbps = 20;
 			}
 			if (a->sample_bits & AC_SUPPCM_BITS_24) {
-				pcm->formats |= SNDRV_PCM_FMTBIT_S32_LE;
-				if (pcm->maxbps < 24)
-					pcm->maxbps = 24;
+				formats |= SNDRV_PCM_FMTBIT_S32_LE;
+				if (maxbps < 24)
+					maxbps = 24;
 			}
 		}
 	}
 
-	if (!codec_pars)
-		return;
-
 	/* restrict the parameters by the values the codec provides */
-	pcm->rates &= codec_pars->rates;
-	pcm->formats &= codec_pars->formats;
-	pcm->channels_max = min(pcm->channels_max, codec_pars->channels_max);
-	pcm->maxbps = min(pcm->maxbps, codec_pars->maxbps);
+	hinfo->rates &= rates;
+	hinfo->formats &= formats;
+	hinfo->maxbps = min(hinfo->maxbps, maxbps);
+	hinfo->channels_max = min(hinfo->channels_max, channels_max);
 }
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 8b88c92..b333bf4 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -641,8 +641,8 @@ struct hdmi_eld {
 int snd_hdmi_get_eld_size(struct hda_codec *codec, hda_nid_t nid);
 int snd_hdmi_get_eld(struct hdmi_eld *, struct hda_codec *, hda_nid_t);
 void snd_hdmi_show_eld(struct hdmi_eld *eld);
-void hdmi_eld_update_pcm_info(struct hdmi_eld *eld, struct hda_pcm_stream *pcm,
-			      struct hda_pcm_stream *codec_pars);
+void snd_hdmi_eld_update_pcm_info(struct hdmi_eld *eld,
+			      struct hda_pcm_stream *hinfo);
 
 #ifdef CONFIG_PROC_FS
 int snd_hda_eld_proc_new(struct hda_codec *codec, struct hdmi_eld *eld,
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 92fb105..3385465 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -815,20 +815,22 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
 	if (!codec_pars->rates)
 		*codec_pars = *hinfo;
 
+	/* Initially set the converter's capabilities */
+	hinfo->channels_min = codec_pars->channels_min;
+	hinfo->channels_max = codec_pars->channels_max;
+	hinfo->rates = codec_pars->rates;
+	hinfo->formats = codec_pars->formats;
+	hinfo->maxbps = codec_pars->maxbps;
+
 	eld = &spec->sink_eld[idx];
 	if (!static_hdmi_pcm && eld->eld_valid) {
-		hdmi_eld_update_pcm_info(eld, hinfo, codec_pars);
+		snd_hdmi_eld_update_pcm_info(eld, hinfo);
 		if (hinfo->channels_min > hinfo->channels_max ||
 		    !hinfo->rates || !hinfo->formats)
 			return -ENODEV;
-	} else {
-		/* fallback to the codec default */
-		hinfo->channels_max = codec_pars->channels_max;
-		hinfo->rates = codec_pars->rates;
-		hinfo->formats = codec_pars->formats;
-		hinfo->maxbps = codec_pars->maxbps;
 	}
-	/* store the updated parameters */
+
+	/* Store the updated parameters */
 	runtime->hw.channels_min = hinfo->channels_min;
 	runtime->hw.channels_max = hinfo->channels_max;
 	runtime->hw.formats = hinfo->formats;
-- 
1.7.0.4
