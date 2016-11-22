From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm_adsp: Firmware controls should be added as codec controls
Date: Tue, 22 Nov 2016 16:58:57 +0000
Message-ID: <1479833937-5238-2-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1479833937-5238-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479833937-5238-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

We were adding firmware controls as card controls (using
snd_soc_add_codec_controls). The DSP is part of a specific codec so
we should be adding them as codec controls. Adding as codec controls
also means that if the codec has a name_prefix it will be added to
the control name, which won't happen when adding as a card control.

As that was the only use of the card pointer in struct wm_adsp it can
be removed.

For ADSP2 codecs a wm_adsp2_codec_probe() was added since the original
control handling was written, and that's the logical place to store a
pointer to the codec rather than delaying it until the codec is
powered-up.

For ADSP1 we don't use a codec_probe() stage so the codec pointer
initialization replaces the original card pointer initialization in
wm_adsp1_event().

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 8 ++++----
 sound/soc/codecs/wm_adsp.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 7698273..6e6b9d8 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1131,7 +1131,7 @@ static int wmfw_add_ctl(struct wm_adsp *dsp, struct wm_coeff_ctl *ctl)
 		break;
 	}
 
-	ret = snd_soc_add_card_controls(dsp->card, kcontrol, 1);
+	ret = snd_soc_add_codec_controls(dsp->codec, kcontrol, 1);
 	if (ret < 0)
 		goto err_kcontrol;
 
@@ -2298,7 +2298,7 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 	int ret;
 	unsigned int val;
 
-	dsp->card = codec->component.card;
+	dsp->codec = codec;
 
 	mutex_lock(&dsp->pwr_lock);
 
@@ -2509,8 +2509,6 @@ int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
 	struct wm_adsp *dsp = &dsps[w->shift];
 	struct wm_coeff_ctl *ctl;
 
-	dsp->card = codec->component.card;
-
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		wm_adsp2_set_dspclk(dsp, freq);
@@ -2628,6 +2626,8 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 
 int wm_adsp2_codec_probe(struct wm_adsp *dsp, struct snd_soc_codec *codec)
 {
+	dsp->codec = codec;
+
 	wm_adsp2_init_debugfs(dsp, codec);
 
 	return snd_soc_add_codec_controls(codec,
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 362dd7c..3f7c8ee 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -44,7 +44,7 @@ struct wm_adsp {
 	int type;
 	struct device *dev;
 	struct regmap *regmap;
-	struct snd_soc_card *card;
+	struct snd_soc_codec *codec;
 
 	int base;
 	int sysclk_reg;
-- 
1.9.1
