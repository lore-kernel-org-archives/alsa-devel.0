From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ASoC: compress: Add support for compress dai
	ops
Date: Sun, 13 Nov 2016 12:10:02 +0530
Message-ID: <1479019202-18692-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 646A12667A9
 for <alsa-devel@alsa-project.org>; Sun, 13 Nov 2016 07:30:50 +0100 (CET)
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
Cc: Lars-Peter Clausen <lars@metafoo.de>, patches.audio@intel.com, Patrick <plai@quicinc.com>, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

ASoC Compress ops have only platform ops and no DAI ops unlike PCM device
where we have both platform ops as well as DAI ops.

So add compress dai ops and add this new structure to the ASoC core to make
compressed devices a first class ASoC citizen

Again like PCM ops, drivers are free to implement either or both of
these ops based on device needs.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---

This was raised on hallway track at LPC by Lars & Patrick, so time to fix it
up

 include/sound/soc-dai.h  | 25 ++++++++++++
 sound/soc/soc-compress.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 121 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 964b7de1a1cc..756ee1b78ffc 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -207,6 +207,30 @@ struct snd_soc_dai_ops {
 		struct snd_soc_dai *);
 };
 
+struct snd_soc_cdai_ops {
+	/*
+	 * for compress ops
+	 */
+	int (*startup)(struct snd_compr_stream *,
+			struct snd_soc_dai *);
+	int (*shutdown)(struct snd_compr_stream *,
+			struct snd_soc_dai *);
+	int (*set_params)(struct snd_compr_stream *,
+			struct snd_compr_params *, struct snd_soc_dai *);
+	int (*get_params)(struct snd_compr_stream *,
+			struct snd_codec *, struct snd_soc_dai *);
+	int (*set_metadata)(struct snd_compr_stream *,
+			struct snd_compr_metadata *, struct snd_soc_dai *);
+	int (*get_metadata)(struct snd_compr_stream *,
+			struct snd_compr_metadata *, struct snd_soc_dai *);
+	int (*trigger)(struct snd_compr_stream *, int,
+			struct snd_soc_dai *);
+	int (*pointer)(struct snd_compr_stream *,
+			struct snd_compr_tstamp *, struct snd_soc_dai *);
+	int (*ack)(struct snd_compr_stream *, size_t,
+			struct snd_soc_dai *);
+};
+
 /*
  * Digital Audio Interface Driver.
  *
@@ -236,6 +260,7 @@ struct snd_soc_dai_driver {
 
 	/* ops */
 	const struct snd_soc_dai_ops *ops;
+	const struct snd_soc_cdai_ops *cops;
 
 	/* DAI capabilities */
 	struct snd_soc_pcm_stream capture;
diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index bf7b52fce597..bfd71b873ca2 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -30,16 +30,26 @@ static int soc_compr_open(struct snd_compr_stream *cstream)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
+	if (cpu_dai->driver->cops && cpu_dai->driver->cops->startup) {
+		ret = cpu_dai->driver->cops->startup(cstream, cpu_dai);
+		if (ret < 0) {
+			dev_err(cpu_dai->dev, "Compress ASoC: can't open interface %s: %d\n",
+				cpu_dai->name, ret);
+			goto out;
+		}
+	}
+
 	if (platform->driver->compr_ops && platform->driver->compr_ops->open) {
 		ret = platform->driver->compr_ops->open(cstream);
 		if (ret < 0) {
 			pr_err("compress asoc: can't open platform %s\n",
 				platform->component.name);
-			goto out;
+			goto plat_err;
 		}
 	}
 
@@ -60,6 +70,9 @@ static int soc_compr_open(struct snd_compr_stream *cstream)
 machine_err:
 	if (platform->driver->compr_ops && platform->driver->compr_ops->free)
 		platform->driver->compr_ops->free(cstream);
+plat_err:
+	if (cpu_dai->driver->cops && cpu_dai->driver->cops->shutdown)
+		cpu_dai->driver->cops->shutdown(cstream, cpu_dai);
 out:
 	mutex_unlock(&rtd->pcm_mutex);
 	return ret;
@@ -70,6 +83,7 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 	struct snd_soc_pcm_runtime *fe = cstream->private_data;
 	struct snd_pcm_substream *fe_substream = fe->pcm->streams[0].substream;
 	struct snd_soc_platform *platform = fe->platform;
+	struct snd_soc_dai *cpu_dai = fe->cpu_dai;
 	struct snd_soc_dpcm *dpcm;
 	struct snd_soc_dapm_widget_list *list;
 	int stream;
@@ -82,12 +96,22 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 
 	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
 
+	if (cpu_dai->driver->cops && cpu_dai->driver->cops->startup) {
+		ret = cpu_dai->driver->cops->startup(cstream, cpu_dai);
+		if (ret < 0) {
+			dev_err(cpu_dai->dev, "Compress ASoC: can't open interface %s: %d\n",
+				cpu_dai->name, ret);
+			goto out;
+		}
+	}
+
+
 	if (platform->driver->compr_ops && platform->driver->compr_ops->open) {
 		ret = platform->driver->compr_ops->open(cstream);
 		if (ret < 0) {
 			pr_err("compress asoc: can't open platform %s\n",
 				platform->component.name);
-			goto out;
+			goto plat_err;
 		}
 	}
 
@@ -144,6 +168,9 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 machine_err:
 	if (platform->driver->compr_ops && platform->driver->compr_ops->free)
 		platform->driver->compr_ops->free(cstream);
+plat_err:
+	if (cpu_dai->driver->cops && cpu_dai->driver->cops->shutdown)
+		cpu_dai->driver->cops->shutdown(cstream, cpu_dai);
 out:
 	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_NO;
 	mutex_unlock(&fe->card->mutex);
@@ -210,6 +237,9 @@ static int soc_compr_free(struct snd_compr_stream *cstream)
 	if (platform->driver->compr_ops && platform->driver->compr_ops->free)
 		platform->driver->compr_ops->free(cstream);
 
+	if (cpu_dai->driver->cops && cpu_dai->driver->cops->shutdown)
+		cpu_dai->driver->cops->shutdown(cstream, cpu_dai);
+
 	if (cstream->direction == SND_COMPRESS_PLAYBACK) {
 		if (snd_soc_runtime_ignore_pmdown_time(rtd)) {
 			snd_soc_dapm_stream_event(rtd,
@@ -236,6 +266,7 @@ static int soc_compr_free_fe(struct snd_compr_stream *cstream)
 {
 	struct snd_soc_pcm_runtime *fe = cstream->private_data;
 	struct snd_soc_platform *platform = fe->platform;
+	struct snd_soc_dai *cpu_dai = fe->cpu_dai;
 	struct snd_soc_dpcm *dpcm;
 	int stream, ret;
 
@@ -275,6 +306,9 @@ static int soc_compr_free_fe(struct snd_compr_stream *cstream)
 	if (platform->driver->compr_ops && platform->driver->compr_ops->free)
 		platform->driver->compr_ops->free(cstream);
 
+	if (cpu_dai->driver->cops && cpu_dai->driver->cops->shutdown)
+		cpu_dai->driver->cops->shutdown(cstream, cpu_dai);
+
 	mutex_unlock(&fe->card->mutex);
 	return 0;
 }
@@ -285,6 +319,7 @@ static int soc_compr_trigger(struct snd_compr_stream *cstream, int cmd)
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
@@ -295,6 +330,10 @@ static int soc_compr_trigger(struct snd_compr_stream *cstream, int cmd)
 			goto out;
 	}
 
+	if (cpu_dai->driver->cops && cpu_dai->driver->cops->trigger)
+		cpu_dai->driver->cops->trigger(cstream, cmd, cpu_dai);
+
+
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		snd_soc_dai_digital_mute(codec_dai, 0, cstream->direction);
@@ -313,6 +352,7 @@ static int soc_compr_trigger_fe(struct snd_compr_stream *cstream, int cmd)
 {
 	struct snd_soc_pcm_runtime *fe = cstream->private_data;
 	struct snd_soc_platform *platform = fe->platform;
+	struct snd_soc_dai *cpu_dai = fe->cpu_dai;
 	int ret = 0, stream;
 
 	if (cmd == SND_COMPR_TRIGGER_PARTIAL_DRAIN ||
@@ -332,6 +372,12 @@ static int soc_compr_trigger_fe(struct snd_compr_stream *cstream, int cmd)
 
 	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
 
+	if (cpu_dai->driver->cops && cpu_dai->driver->cops->trigger) {
+		ret = cpu_dai->driver->cops->trigger(cstream, cmd, cpu_dai);
+		if (ret < 0)
+			goto out;
+	}
+
 	if (platform->driver->compr_ops && platform->driver->compr_ops->trigger) {
 		ret = platform->driver->compr_ops->trigger(cstream, cmd);
 		if (ret < 0)
@@ -368,6 +414,7 @@ static int soc_compr_set_params(struct snd_compr_stream *cstream,
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
@@ -378,6 +425,12 @@ static int soc_compr_set_params(struct snd_compr_stream *cstream,
 	 * expectation is that platform and machine will configure everything
 	 * for this compress path, like configuring pcm port for codec
 	 */
+	if (cpu_dai->driver->cops && cpu_dai->driver->cops->set_params) {
+		ret = cpu_dai->driver->cops->set_params(cstream, params, cpu_dai);
+		if (ret < 0)
+			goto err;
+	}
+
 	if (platform->driver->compr_ops && platform->driver->compr_ops->set_params) {
 		ret = platform->driver->compr_ops->set_params(cstream, params);
 		if (ret < 0)
@@ -416,6 +469,7 @@ static int soc_compr_set_params_fe(struct snd_compr_stream *cstream,
 	struct snd_soc_pcm_runtime *fe = cstream->private_data;
 	struct snd_pcm_substream *fe_substream = fe->pcm->streams[0].substream;
 	struct snd_soc_platform *platform = fe->platform;
+	struct snd_soc_dai *cpu_dai = fe->cpu_dai;
 	int ret = 0, stream;
 
 	if (cstream->direction == SND_COMPRESS_PLAYBACK)
@@ -425,6 +479,12 @@ static int soc_compr_set_params_fe(struct snd_compr_stream *cstream,
 
 	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
 
+	if (cpu_dai->driver->cops && cpu_dai->driver->cops->set_params) {
+		ret = cpu_dai->driver->cops->set_params(cstream, params, cpu_dai);
+		if (ret < 0)
+			goto out;
+	}
+
 	if (platform->driver->compr_ops && platform->driver->compr_ops->set_params) {
 		ret = platform->driver->compr_ops->set_params(cstream, params);
 		if (ret < 0)
@@ -469,13 +529,21 @@ static int soc_compr_get_params(struct snd_compr_stream *cstream,
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
+	if (cpu_dai->driver->cops && cpu_dai->driver->cops->get_params) {
+		ret = cpu_dai->driver->cops->get_params(cstream, params, cpu_dai);
+		if (ret < 0)
+			goto err;
+	}
+
 	if (platform->driver->compr_ops && platform->driver->compr_ops->get_params)
 		ret = platform->driver->compr_ops->get_params(cstream, params);
 
+err:
 	mutex_unlock(&rtd->pcm_mutex);
 	return ret;
 }
@@ -516,13 +584,21 @@ static int soc_compr_ack(struct snd_compr_stream *cstream, size_t bytes)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
+	if (cpu_dai->driver->cops && cpu_dai->driver->cops->ack) {
+		ret = cpu_dai->driver->cops->ack(cstream, bytes, cpu_dai);
+		if (ret < 0)
+			goto err;
+	}
+
 	if (platform->driver->compr_ops && platform->driver->compr_ops->ack)
 		ret = platform->driver->compr_ops->ack(cstream, bytes);
 
+err:
 	mutex_unlock(&rtd->pcm_mutex);
 	return ret;
 }
@@ -533,9 +609,13 @@ static int soc_compr_pointer(struct snd_compr_stream *cstream,
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
 	int ret = 0;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
+	if (cpu_dai->driver->cops && cpu_dai->driver->cops->pointer)
+		cpu_dai->driver->cops->pointer(cstream, tstamp, cpu_dai);
+
 	if (platform->driver->compr_ops && platform->driver->compr_ops->pointer)
 		ret = platform->driver->compr_ops->pointer(cstream, tstamp);
 
@@ -564,8 +644,15 @@ static int soc_compr_set_metadata(struct snd_compr_stream *cstream,
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret = 0;
 
+	if (cpu_dai->driver->cops && cpu_dai->driver->cops->set_metadata) {
+		ret = cpu_dai->driver->cops->set_metadata(cstream, metadata, cpu_dai);
+		if (ret < 0)
+			return ret;
+	}
+
 	if (platform->driver->compr_ops && platform->driver->compr_ops->set_metadata)
 		ret = platform->driver->compr_ops->set_metadata(cstream, metadata);
 
@@ -577,8 +664,15 @@ static int soc_compr_get_metadata(struct snd_compr_stream *cstream,
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret = 0;
 
+	if (cpu_dai->driver->cops && cpu_dai->driver->cops->get_metadata) {
+		ret = cpu_dai->driver->cops->get_metadata(cstream, metadata, cpu_dai);
+		if (ret < 0)
+			return ret;
+	}
+
 	if (platform->driver->compr_ops && platform->driver->compr_ops->get_metadata)
 		ret = platform->driver->compr_ops->get_metadata(cstream, metadata);
 
-- 
1.9.1
