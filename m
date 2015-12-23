From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Add support for opening a
	compressed stream" to the asoc tree
Date: Wed, 23 Dec 2015 00:23:20 +0000
Message-ID: <E1aBXD6-0000Wq-Ud@debutante>
References: <1449590917-21170-9-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9811E26609B
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 01:23:27 +0100 (CET)
In-Reply-To: <1449590917-21170-9-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Add support for opening a compressed stream

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 406abc95a0397e10eb6edcfe824b1a8bf6578a0b Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 15 Dec 2015 11:29:45 +0000
Subject: [PATCH] ASoC: wm_adsp: Add support for opening a compressed stream

Allow user-space to open a compressed stream, although no data will be
passed yet, as part of this adding the ability to define supported
capabilities per firmware and check these match the stream being opened.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm5110.c  |  23 ++++++
 sound/soc/codecs/wm_adsp.c | 194 ++++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/wm_adsp.h |  13 +++
 3 files changed, 227 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 67d56511699a..8c0fd9106be0 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2158,6 +2158,25 @@ static struct snd_soc_dai_driver wm5110_dai[] = {
 	},
 };
 
+static int wm5110_open(struct snd_compr_stream *stream)
+{
+	struct snd_soc_pcm_runtime *rtd = stream->private_data;
+	struct wm5110_priv *priv = snd_soc_codec_get_drvdata(rtd->codec);
+	struct arizona *arizona = priv->core.arizona;
+	int n_adsp;
+
+	if (strcmp(rtd->codec_dai->name, "wm5110-dsp-voicectrl") == 0) {
+		n_adsp = 2;
+	} else {
+		dev_err(arizona->dev,
+			"No suitable compressed stream for DAI '%s'\n",
+			rtd->codec_dai->name);
+		return -EINVAL;
+	}
+
+	return wm_adsp_compr_open(&priv->core.adsp[n_adsp], stream);
+}
+
 static int wm5110_codec_probe(struct snd_soc_codec *codec)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
@@ -2249,6 +2268,10 @@ static struct snd_soc_codec_driver soc_codec_dev_wm5110 = {
 };
 
 static struct snd_compr_ops wm5110_compr_ops = {
+	.open = wm5110_open,
+	.free = wm_adsp_compr_free,
+	.set_params = wm_adsp_compr_set_params,
+	.get_caps = wm_adsp_compr_get_caps,
 };
 
 static struct snd_soc_platform_driver wm5110_compr_platform = {
diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 27abad9c6e73..d81ed218918e 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -229,8 +229,42 @@ static const char *wm_adsp_fw_text[WM_ADSP_NUM_FW] = {
 	[WM_ADSP_FW_MISC] =     "Misc",
 };
 
-static struct {
+struct wm_adsp_compr {
+	struct wm_adsp *dsp;
+
+	struct snd_compr_stream *stream;
+	struct snd_compressed_buffer size;
+};
+
+#define WM_ADSP_DATA_WORD_SIZE         3
+
+#define WM_ADSP_MIN_FRAGMENTS          1
+#define WM_ADSP_MAX_FRAGMENTS          256
+#define WM_ADSP_MIN_FRAGMENT_SIZE      (64 * WM_ADSP_DATA_WORD_SIZE)
+#define WM_ADSP_MAX_FRAGMENT_SIZE      (4096 * WM_ADSP_DATA_WORD_SIZE)
+
+struct wm_adsp_fw_caps {
+	u32 id;
+	struct snd_codec_desc desc;
+};
+
+static const struct wm_adsp_fw_caps ez2control_caps[] = {
+	{
+		.id = SND_AUDIOCODEC_BESPOKE,
+		.desc = {
+			.max_ch = 1,
+			.sample_rates = { 16000 },
+			.num_sample_rates = 1,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+	},
+};
+
+static const struct {
 	const char *file;
+	int compr_direction;
+	int num_caps;
+	const struct wm_adsp_fw_caps *caps;
 } wm_adsp_fw[WM_ADSP_NUM_FW] = {
 	[WM_ADSP_FW_MBC_VSS] =  { .file = "mbc-vss" },
 	[WM_ADSP_FW_HIFI] =     { .file = "hifi" },
@@ -238,7 +272,12 @@ static struct {
 	[WM_ADSP_FW_TX_SPK] =   { .file = "tx-spk" },
 	[WM_ADSP_FW_RX] =       { .file = "rx" },
 	[WM_ADSP_FW_RX_ANC] =   { .file = "rx-anc" },
-	[WM_ADSP_FW_CTRL] =     { .file = "ctrl" },
+	[WM_ADSP_FW_CTRL] =     {
+		.file = "ctrl",
+		.compr_direction = SND_COMPRESS_CAPTURE,
+		.num_caps = ARRAY_SIZE(ez2control_caps),
+		.caps = ez2control_caps,
+	},
 	[WM_ADSP_FW_ASR] =      { .file = "asr" },
 	[WM_ADSP_FW_TRACE] =    { .file = "trace" },
 	[WM_ADSP_FW_SPK_PROT] = { .file = "spk-prot" },
@@ -461,7 +500,7 @@ static int wm_adsp_fw_put(struct snd_kcontrol *kcontrol,
 
 	mutex_lock(&dsp[e->shift_l].pwr_lock);
 
-	if (dsp[e->shift_l].running)
+	if (dsp[e->shift_l].running || dsp[e->shift_l].compr)
 		ret = -EBUSY;
 	else
 		dsp[e->shift_l].fw = ucontrol->value.integer.value[0];
@@ -2178,4 +2217,153 @@ int wm_adsp2_init(struct wm_adsp *dsp)
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_init);
 
+int wm_adsp_compr_open(struct wm_adsp *dsp, struct snd_compr_stream *stream)
+{
+	struct wm_adsp_compr *compr;
+	int ret = 0;
+
+	mutex_lock(&dsp->pwr_lock);
+
+	if (wm_adsp_fw[dsp->fw].num_caps == 0) {
+		adsp_err(dsp, "Firmware does not support compressed API\n");
+		ret = -ENXIO;
+		goto out;
+	}
+
+	if (wm_adsp_fw[dsp->fw].compr_direction != stream->direction) {
+		adsp_err(dsp, "Firmware does not support stream direction\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	compr = kzalloc(sizeof(*compr), GFP_KERNEL);
+	if (!compr) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	compr->dsp = dsp;
+	compr->stream = stream;
+
+	dsp->compr = compr;
+
+	stream->runtime->private_data = compr;
+
+out:
+	mutex_unlock(&dsp->pwr_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(wm_adsp_compr_open);
+
+int wm_adsp_compr_free(struct snd_compr_stream *stream)
+{
+	struct wm_adsp_compr *compr = stream->runtime->private_data;
+	struct wm_adsp *dsp = compr->dsp;
+
+	mutex_lock(&dsp->pwr_lock);
+
+	dsp->compr = NULL;
+
+	kfree(compr);
+
+	mutex_unlock(&dsp->pwr_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wm_adsp_compr_free);
+
+static int wm_adsp_compr_check_params(struct snd_compr_stream *stream,
+				      struct snd_compr_params *params)
+{
+	struct wm_adsp_compr *compr = stream->runtime->private_data;
+	struct wm_adsp *dsp = compr->dsp;
+	const struct wm_adsp_fw_caps *caps;
+	const struct snd_codec_desc *desc;
+	int i, j;
+
+	if (params->buffer.fragment_size < WM_ADSP_MIN_FRAGMENT_SIZE ||
+	    params->buffer.fragment_size > WM_ADSP_MAX_FRAGMENT_SIZE ||
+	    params->buffer.fragments < WM_ADSP_MIN_FRAGMENTS ||
+	    params->buffer.fragments > WM_ADSP_MAX_FRAGMENTS ||
+	    params->buffer.fragment_size % WM_ADSP_DATA_WORD_SIZE) {
+		adsp_err(dsp, "Invalid buffer fragsize=%d fragments=%d\n",
+			 params->buffer.fragment_size,
+			 params->buffer.fragments);
+
+		return -EINVAL;
+	}
+
+	for (i = 0; i < wm_adsp_fw[dsp->fw].num_caps; i++) {
+		caps = &wm_adsp_fw[dsp->fw].caps[i];
+		desc = &caps->desc;
+
+		if (caps->id != params->codec.id)
+			continue;
+
+		if (stream->direction == SND_COMPRESS_PLAYBACK) {
+			if (desc->max_ch < params->codec.ch_out)
+				continue;
+		} else {
+			if (desc->max_ch < params->codec.ch_in)
+				continue;
+		}
+
+		if (!(desc->formats & (1 << params->codec.format)))
+			continue;
+
+		for (j = 0; j < desc->num_sample_rates; ++j)
+			if (desc->sample_rates[j] == params->codec.sample_rate)
+				return 0;
+	}
+
+	adsp_err(dsp, "Invalid params id=%u ch=%u,%u rate=%u fmt=%u\n",
+		 params->codec.id, params->codec.ch_in, params->codec.ch_out,
+		 params->codec.sample_rate, params->codec.format);
+	return -EINVAL;
+}
+
+int wm_adsp_compr_set_params(struct snd_compr_stream *stream,
+			     struct snd_compr_params *params)
+{
+	struct wm_adsp_compr *compr = stream->runtime->private_data;
+	int ret;
+
+	ret = wm_adsp_compr_check_params(stream, params);
+	if (ret)
+		return ret;
+
+	compr->size = params->buffer;
+
+	adsp_dbg(compr->dsp, "fragment_size=%d fragments=%d\n",
+		 compr->size.fragment_size, compr->size.fragments);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wm_adsp_compr_set_params);
+
+int wm_adsp_compr_get_caps(struct snd_compr_stream *stream,
+			   struct snd_compr_caps *caps)
+{
+	struct wm_adsp_compr *compr = stream->runtime->private_data;
+	int fw = compr->dsp->fw;
+	int i;
+
+	if (wm_adsp_fw[fw].caps) {
+		for (i = 0; i < wm_adsp_fw[fw].num_caps; i++)
+			caps->codecs[i] = wm_adsp_fw[fw].caps[i].id;
+
+		caps->num_codecs = i;
+		caps->direction = wm_adsp_fw[fw].compr_direction;
+
+		caps->min_fragment_size = WM_ADSP_MIN_FRAGMENT_SIZE;
+		caps->max_fragment_size = WM_ADSP_MAX_FRAGMENT_SIZE;
+		caps->min_fragments = WM_ADSP_MIN_FRAGMENTS;
+		caps->max_fragments = WM_ADSP_MAX_FRAGMENTS;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wm_adsp_compr_get_caps);
+
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index d2a8c78ed50b..33c9b5283d26 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -15,6 +15,7 @@
 
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
+#include <sound/compress_driver.h>
 
 #include "wmfw.h"
 
@@ -30,6 +31,8 @@ struct wm_adsp_alg_region {
 	unsigned int base;
 };
 
+struct wm_adsp_compr;
+
 struct wm_adsp {
 	const char *part;
 	int num;
@@ -59,6 +62,8 @@ struct wm_adsp {
 
 	struct work_struct boot_work;
 
+	struct wm_adsp_compr *compr;
+
 	struct mutex pwr_lock;
 
 #ifdef CONFIG_DEBUG_FS
@@ -97,4 +102,12 @@ int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
 int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol, int event);
 
+extern int wm_adsp_compr_open(struct wm_adsp *dsp,
+			      struct snd_compr_stream *stream);
+extern int wm_adsp_compr_free(struct snd_compr_stream *stream);
+extern int wm_adsp_compr_set_params(struct snd_compr_stream *stream,
+				    struct snd_compr_params *params);
+extern int wm_adsp_compr_get_caps(struct snd_compr_stream *stream,
+				  struct snd_compr_caps *caps);
+
 #endif
-- 
2.6.2
