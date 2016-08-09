From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: lpass-platform: don't use snd_soc_pcm_set_drvdata()" to the asoc tree
Date: Tue, 09 Aug 2016 13:44:06 +0100
Message-ID: <E1bX6O6-0003b8-Av@debutante>
References: <87invl9gbq.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87invl9gbq.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.orgalsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: lpass-platform: don't use snd_soc_pcm_set_drvdata()

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

>From 6adcbdcd4b6e8301c3a4c61284e701f87de9a409 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 1 Aug 2016 06:10:54 +0000
Subject: [PATCH] ASoC: lpass-platform: don't use snd_soc_pcm_set_drvdata()

snd_soc_pcm_set_drvdata() will set driver data to rtd->dev,
but driver data of rtd->dev is already used as "rtd" on
soc_post_component_init().

	static int soc_post_component_init(xxx)
	{
		...
		dev_set_drvdata(rtd->dev, rtd);
		...
	}

To remove confusion, snd_soc_pcm_set/get_drvdata() should be
removed soon. This patch is for it.

qcom/lpass-platform.c sets struct lpass_pcm_data to rtd->dev today,
but we can replace it to struct lpass_data :: private_data.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/lpass-platform.c | 14 +++++++-------
 sound/soc/qcom/lpass.h          |  2 ++
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index db000c6987a1..a144c14c7169 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -84,9 +84,9 @@ static int lpass_platform_pcmops_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
-	struct lpass_pcm_data *pcm_data = snd_soc_pcm_get_drvdata(soc_runtime);
 	struct lpass_data *drvdata =
 		snd_soc_platform_get_drvdata(soc_runtime->platform);
+	struct lpass_pcm_data *pcm_data = drvdata->private_data;
 	struct lpass_variant *v = drvdata->variant;
 	snd_pcm_format_t format = params_format(params);
 	unsigned int channels = params_channels(params);
@@ -177,9 +177,9 @@ static int lpass_platform_pcmops_hw_params(struct snd_pcm_substream *substream,
 static int lpass_platform_pcmops_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
-	struct lpass_pcm_data *pcm_data = snd_soc_pcm_get_drvdata(soc_runtime);
 	struct lpass_data *drvdata =
 		snd_soc_platform_get_drvdata(soc_runtime->platform);
+	struct lpass_pcm_data *pcm_data = drvdata->private_data;
 	struct lpass_variant *v = drvdata->variant;
 	unsigned int reg;
 	int ret;
@@ -201,9 +201,9 @@ static int lpass_platform_pcmops_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
-	struct lpass_pcm_data *pcm_data = snd_soc_pcm_get_drvdata(soc_runtime);
 	struct lpass_data *drvdata =
 		snd_soc_platform_get_drvdata(soc_runtime->platform);
+	struct lpass_pcm_data *pcm_data = drvdata->private_data;
 	struct lpass_variant *v = drvdata->variant;
 	int ret, ch, dir = substream->stream;
 
@@ -255,9 +255,9 @@ static int lpass_platform_pcmops_trigger(struct snd_pcm_substream *substream,
 		int cmd)
 {
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
-	struct lpass_pcm_data *pcm_data = snd_soc_pcm_get_drvdata(soc_runtime);
 	struct lpass_data *drvdata =
 		snd_soc_platform_get_drvdata(soc_runtime->platform);
+	struct lpass_pcm_data *pcm_data = drvdata->private_data;
 	struct lpass_variant *v = drvdata->variant;
 	int ret, ch, dir = substream->stream;
 
@@ -331,9 +331,9 @@ static snd_pcm_uframes_t lpass_platform_pcmops_pointer(
 		struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
-	struct lpass_pcm_data *pcm_data = snd_soc_pcm_get_drvdata(soc_runtime);
 	struct lpass_data *drvdata =
 			snd_soc_platform_get_drvdata(soc_runtime->platform);
+	struct lpass_pcm_data *pcm_data = drvdata->private_data;
 	struct lpass_variant *v = drvdata->variant;
 	unsigned int base_addr, curr_addr;
 	int ret, ch, dir = substream->stream;
@@ -483,7 +483,7 @@ static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 		return -ENOMEM;
 
 	data->i2s_port = cpu_dai->driver->id;
-	snd_soc_pcm_set_drvdata(soc_runtime, data);
+	drvdata->private_data = data;
 
 	psubstream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
 	if (psubstream) {
@@ -570,8 +570,8 @@ static void lpass_platform_pcm_free(struct snd_pcm *pcm)
 		substream = pcm->streams[i].substream;
 		if (substream) {
 			rt = substream->private_data;
-			data = snd_soc_pcm_get_drvdata(rt);
 			drvdata = snd_soc_platform_get_drvdata(rt->platform);
+			data = drvdata->private_data;
 
 			ch = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 				? data->rdma_ch
diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index 30714ad1e138..35b3cea8207d 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -58,6 +58,8 @@ struct lpass_data {
 	/* 8016 specific */
 	struct clk *pcnoc_mport_clk;
 	struct clk *pcnoc_sway_clk;
+
+	void *private_data;
 };
 
 /* Vairant data per each SOC */
-- 
2.8.1
