From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add Component level pcm_new/pcm_free"
	to the asoc tree
Date: Thu, 15 Dec 2016 18:28:29 +0000
Message-ID: <E1cHalZ-00005I-Nz@debutante>
References: <87oa0dh9gb.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 761F226705B
 for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2016 19:28:44 +0100 (CET)
In-Reply-To: <87oa0dh9gb.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Lars-Peter <lars@metafoo.de>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: add Component level pcm_new/pcm_free

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

>From 99b04f4c4051f71bc0665a66e11b8fbed17c8958 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 15 Dec 2016 08:41:38 +0000
Subject: [PATCH] ASoC: add Component level pcm_new/pcm_free

In current ALSA SoC, Platform only has pcm_new/pcm_free feature,
but it should be supported on Component level. This patch adds it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  6 ++++++
 sound/soc/soc-core.c | 21 +++++++++++++++++++++
 sound/soc/soc-pcm.c  | 32 +++++++++++++++++++++++---------
 3 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 2b502f6cc6d0..e580a675ea77 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -785,6 +785,10 @@ struct snd_soc_component_driver {
 	int (*suspend)(struct snd_soc_component *);
 	int (*resume)(struct snd_soc_component *);
 
+	/* pcm creation and destruction */
+	int (*pcm_new)(struct snd_soc_pcm_runtime *);
+	void (*pcm_free)(struct snd_pcm *);
+
 	/* DT */
 	int (*of_xlate_dai_name)(struct snd_soc_component *component,
 				 struct of_phandle_args *args,
@@ -858,6 +862,8 @@ struct snd_soc_component {
 	void (*remove)(struct snd_soc_component *);
 	int (*suspend)(struct snd_soc_component *);
 	int (*resume)(struct snd_soc_component *);
+	int (*pcm_new)(struct snd_soc_pcm_runtime *);
+	void (*pcm_free)(struct snd_pcm *);
 
 	/* machine specific init */
 	int (*init)(struct snd_soc_component *component);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f1901bb1466e..981443e444d1 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2976,6 +2976,8 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 	component->remove = component->driver->remove;
 	component->suspend = component->driver->suspend;
 	component->resume = component->driver->resume;
+	component->pcm_new = component->driver->pcm_new;
+	component->pcm_free= component->driver->pcm_free;
 
 	dapm = &component->dapm;
 	dapm->dev = dev;
@@ -3158,6 +3160,21 @@ static void snd_soc_platform_drv_remove(struct snd_soc_component *component)
 	platform->driver->remove(platform);
 }
 
+static int snd_soc_platform_drv_pcm_new(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_platform *platform = rtd->platform;
+
+	return platform->driver->pcm_new(rtd);
+}
+
+static void snd_soc_platform_drv_pcm_free(struct snd_pcm *pcm)
+{
+	struct snd_soc_pcm_runtime *rtd = pcm->private_data;
+	struct snd_soc_platform *platform = rtd->platform;
+
+	platform->driver->pcm_free(pcm);
+}
+
 /**
  * snd_soc_add_platform - Add a platform to the ASoC core
  * @dev: The parent device for the platform
@@ -3181,6 +3198,10 @@ int snd_soc_add_platform(struct device *dev, struct snd_soc_platform *platform,
 		platform->component.probe = snd_soc_platform_drv_probe;
 	if (platform_drv->remove)
 		platform->component.remove = snd_soc_platform_drv_remove;
+	if (platform_drv->pcm_new)
+		platform->component.pcm_new = snd_soc_platform_drv_pcm_new;
+	if (platform_drv->pcm_free)
+		platform->component.pcm_free = snd_soc_platform_drv_pcm_free;
 
 #ifdef CONFIG_DEBUG_FS
 	platform->component.debugfs_prefix = "platform";
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index e7a1eaa2772f..a9ef8ae20e44 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2640,12 +2640,25 @@ static int dpcm_fe_dai_close(struct snd_pcm_substream *fe_substream)
 	return ret;
 }
 
+static void soc_pcm_free(struct snd_pcm *pcm)
+{
+	struct snd_soc_pcm_runtime *rtd = pcm->private_data;
+	struct snd_soc_component *component;
+
+	list_for_each_entry(component, &rtd->card->component_dev_list,
+			    card_list) {
+		if (component->pcm_free)
+			component->pcm_free(pcm);
+	}
+}
+
 /* create a new pcm */
 int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 {
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_component *component;
 	struct snd_pcm *pcm;
 	char new_name[64];
 	int ret = 0, playback = 0, capture = 0;
@@ -2754,17 +2767,18 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 	if (capture)
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &rtd->ops);
 
-	if (platform->driver->pcm_new) {
-		ret = platform->driver->pcm_new(rtd);
-		if (ret < 0) {
-			dev_err(platform->dev,
-				"ASoC: pcm constructor failed: %d\n",
-				ret);
-			return ret;
+	list_for_each_entry(component, &rtd->card->component_dev_list, card_list) {
+		if (component->pcm_new) {
+			ret = component->pcm_new(rtd);
+			if (ret < 0) {
+				dev_err(component->dev,
+					"ASoC: pcm constructor failed: %d\n",
+					ret);
+				return ret;
+			}
 		}
 	}
-
-	pcm->private_free = platform->driver->pcm_free;
+	pcm->private_free = soc_pcm_free;
 out:
 	dev_info(rtd->card->dev, "%s <-> %s mapping ok\n",
 		 (rtd->num_codecs > 1) ? "multicodec" : rtd->codec_dai->name,
-- 
2.11.0
