From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH 4/5] ASoC: dpcm: Add bespoke trigger()
Date: Wed, 25 Apr 2012 12:12:52 +0100
Message-ID: <1335352373-5237-4-git-send-email-lrg@ti.com>
References: <1335352373-5237-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog114.obsmtp.com (na3sys009aog114.obsmtp.com
	[74.125.149.211])
	by alsa0.perex.cz (Postfix) with ESMTP id AE1741048AC
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2012 13:13:50 +0200 (CEST)
Received: by wibhj13 with SMTP id hj13so1493377wib.6
	for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2012 04:13:48 -0700 (PDT)
In-Reply-To: <1335352373-5237-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Some on SoC DSP HW is very tightly coupled with DMA and DAI drivers. It's
necessary to allow some flexability wrt to PCM operations here so that we
can define a bespoke DPCM trigger() PCM operation for such HW.

A bespoke DPCM trigger() allows exact ordering and timing of component
triggering by allowing a component driver to manage the final enable
and disable configurations without adding extra complexity to other
component drivers. e.g. The McPDM DAI and ABE are tightly coupled on
OMAP4 so we have a bespoke trigger to manage the trigger to improve
performance and reduce complexity when triggering new McPDM BEs.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc-dai.h  |    2 +
 include/sound/soc-dpcm.h |    1 +
 include/sound/soc.h      |    4 ++
 sound/soc/soc-pcm.c      |   99 +++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 96 insertions(+), 10 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 3248fbc..bb245f1 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -173,6 +173,8 @@ struct snd_soc_dai_ops {
 		struct snd_soc_dai *);
 	int (*trigger)(struct snd_pcm_substream *, int,
 		struct snd_soc_dai *);
+	int (*bespoke_trigger)(struct snd_pcm_substream *, int,
+		struct snd_soc_dai *);
 	/*
 	 * For hardware based FIFO caused delay reporting.
 	 * Optional.
diff --git a/include/sound/soc-dpcm.h b/include/sound/soc-dpcm.h
index d1a4b50..04598f1 100644
--- a/include/sound/soc-dpcm.h
+++ b/include/sound/soc-dpcm.h
@@ -60,6 +60,7 @@ enum snd_soc_dpcm_state {
 enum snd_soc_dpcm_trigger {
 	SND_SOC_DPCM_TRIGGER_PRE		= 0,
 	SND_SOC_DPCM_TRIGGER_POST,
+	SND_SOC_DPCM_TRIGGER_BESPOKE,
 };
 
 /*
diff --git a/include/sound/soc.h b/include/sound/soc.h
index c48d89d..a7f62d5 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -359,6 +359,9 @@ int snd_soc_params_to_bclk(struct snd_pcm_hw_params *parms);
 int snd_soc_set_runtime_hwparams(struct snd_pcm_substream *substream,
 	const struct snd_pcm_hardware *hw);
 
+int snd_soc_platform_trigger(struct snd_pcm_substream *substream,
+		int cmd, struct snd_soc_platform *platform);
+
 /* Jack reporting */
 int snd_soc_jack_new(struct snd_soc_codec *codec, const char *id, int type,
 		     struct snd_soc_jack *jack);
@@ -726,6 +729,7 @@ struct snd_soc_platform_driver {
 	/* platform IO - used for platform DAPM */
 	unsigned int (*read)(struct snd_soc_platform *, unsigned int);
 	int (*write)(struct snd_soc_platform *, unsigned int, unsigned int);
+	int (*bespoke_trigger)(struct snd_pcm_substream *, int);
 };
 
 struct snd_soc_platform {
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index ca36fd6..5bd8270 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -632,6 +632,33 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	return 0;
 }
 
+int soc_pcm_bespoke_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int ret;
+
+	if (codec_dai->driver->ops->bespoke_trigger) {
+		ret = codec_dai->driver->ops->bespoke_trigger(substream, cmd, codec_dai);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (platform->driver->bespoke_trigger) {
+		ret = platform->driver->bespoke_trigger(substream, cmd);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (cpu_dai->driver->ops->bespoke_trigger) {
+		ret = cpu_dai->driver->ops->bespoke_trigger(substream, cmd, cpu_dai);
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
 /*
  * soc level wrapper for pointer callback
  * If cpu_dai, codec_dai, platform driver has the delay callback, than
@@ -1507,6 +1534,18 @@ int dpcm_fe_dai_trigger(struct snd_pcm_substream *substream, int cmd)
 
 		ret = soc_pcm_trigger(substream, cmd);
 		break;
+	case SND_SOC_DPCM_TRIGGER_BESPOKE:
+		/* bespoke trigger() - handles both FE and BEs */
+
+		dev_dbg(fe->dev, "dpcm: bespoke trigger FE %s cmd %d\n",
+				fe->dai_link->name, cmd);
+
+		ret = soc_pcm_bespoke_trigger(substream, cmd);
+		if (ret < 0) {
+			dev_err(fe->dev,"dpcm: trigger FE failed %d\n", ret);
+			goto out;
+		}
+		break;
 	default:
 		dev_err(fe->dev, "dpcm: invalid trigger cmd %d for %s\n", cmd,
 				fe->dai_link->name);
@@ -1610,14 +1649,30 @@ out:
 
 static int dpcm_run_update_shutdown(struct snd_soc_pcm_runtime *fe, int stream)
 {
+	struct snd_pcm_substream *substream =
+		snd_soc_dpcm_get_substream(fe, stream);
+	enum snd_soc_dpcm_trigger trigger = fe->dai_link->trigger[stream];
 	int err;
 
 	dev_dbg(fe->dev, "runtime %s close on FE %s\n",
 			stream ? "capture" : "playback", fe->dai_link->name);
 
-	err = dpcm_be_dai_trigger(fe, stream, SNDRV_PCM_TRIGGER_STOP);
-	if (err < 0)
-		dev_err(fe->dev,"dpcm: trigger FE failed %d\n", err);
+	if (trigger == SND_SOC_DPCM_TRIGGER_BESPOKE) {
+		/* call bespoke trigger - FE takes care of all BE triggers */
+		dev_dbg(fe->dev, "dpcm: bespoke trigger FE %s cmd stop\n",
+				fe->dai_link->name);
+
+		err = soc_pcm_bespoke_trigger(substream, SNDRV_PCM_TRIGGER_STOP);
+		if (err < 0)
+			dev_err(fe->dev,"dpcm: trigger FE failed %d\n", err);
+	} else {
+		dev_dbg(fe->dev, "dpcm: trigger FE %s cmd stop\n",
+			fe->dai_link->name);
+
+		err = dpcm_be_dai_trigger(fe, stream, SNDRV_PCM_TRIGGER_STOP);
+		if (err < 0)
+			dev_err(fe->dev,"dpcm: trigger FE failed %d\n", err);
+	}
 
 	err = dpcm_be_dai_hw_free(fe, stream);
 	if (err < 0)
@@ -1635,7 +1690,10 @@ static int dpcm_run_update_shutdown(struct snd_soc_pcm_runtime *fe, int stream)
 
 static int dpcm_run_update_startup(struct snd_soc_pcm_runtime *fe, int stream)
 {
+	struct snd_pcm_substream *substream =
+		snd_soc_dpcm_get_substream(fe, stream);
 	struct snd_soc_dpcm *dpcm;
+	enum snd_soc_dpcm_trigger trigger = fe->dai_link->trigger[stream];
 	int ret;
 
 	dev_dbg(fe->dev, "runtime %s open on FE %s\n",
@@ -1682,14 +1740,26 @@ static int dpcm_run_update_startup(struct snd_soc_pcm_runtime *fe, int stream)
 		fe->dpcm[stream].state == SND_SOC_DPCM_STATE_STOP)
 		return 0;
 
-	dev_dbg(fe->dev, "dpcm: trigger FE %s cmd start\n",
-		fe->dai_link->name);
+	if (trigger == SND_SOC_DPCM_TRIGGER_BESPOKE) {
+		/* call trigger on the frontend - FE takes care of all BE triggers */
+		dev_dbg(fe->dev, "dpcm: bespoke trigger FE %s cmd start\n",
+				fe->dai_link->name);
 
-	ret = dpcm_be_dai_trigger(fe, stream,
-			SNDRV_PCM_TRIGGER_START);
-	if (ret < 0) {
-		dev_err(fe->dev,"dpcm: trigger FE failed %d\n", ret);
-		goto hw_free;
+		ret = soc_pcm_bespoke_trigger(substream, SNDRV_PCM_TRIGGER_START);
+		if (ret < 0) {
+			dev_err(fe->dev,"dpcm: bespoke trigger FE failed %d\n", ret);
+			goto hw_free;
+		}
+	} else {
+		dev_dbg(fe->dev, "dpcm: trigger FE %s cmd start\n",
+			fe->dai_link->name);
+
+		ret = dpcm_be_dai_trigger(fe, stream,
+					SNDRV_PCM_TRIGGER_START);
+		if (ret < 0) {
+			dev_err(fe->dev,"dpcm: trigger FE failed %d\n", ret);
+			goto hw_free;
+		}
 	}
 
 	return 0;
@@ -2120,6 +2190,15 @@ int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dpcm_can_be_params);
 
+int snd_soc_platform_trigger(struct snd_pcm_substream *substream,
+		int cmd, struct snd_soc_platform *platform)
+{
+	if (platform->driver->ops->trigger)
+		return platform->driver->ops->trigger(substream, cmd);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_platform_trigger);
+
 #ifdef CONFIG_DEBUG_FS
 static char *dpcm_state_string(enum snd_soc_dpcm_state state)
 {
-- 
1.7.5.4
