From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add Component level suspend/resume" to
	the asoc tree
Date: Thu, 01 Dec 2016 21:46:04 +0000
Message-ID: <E1cCZB6-0007cP-7t@debutante>
References: <87twbq399f.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A3DD2665CC
 for <alsa-devel@alsa-project.org>; Thu,  1 Dec 2016 22:46:16 +0100 (CET)
In-Reply-To: <87twbq399f.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: add Component level suspend/resume

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

>From 9178feb4538e055bf22be44c38b90cc31d2baf99 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 30 Nov 2016 06:23:13 +0000
Subject: [PATCH] ASoC: add Component level suspend/resume

In current ALSA SoC, Codec only has suspend/resume feature,
but it should be supported on Component level. This patch adds it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  6 ++++-
 sound/soc/soc-core.c | 63 ++++++++++++++++++++++++++++++----------------------
 2 files changed, 42 insertions(+), 27 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 0bd57b77d010..13cc64e5bb77 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -782,6 +782,8 @@ struct snd_soc_component_driver {
 
 	int (*probe)(struct snd_soc_component *);
 	void (*remove)(struct snd_soc_component *);
+	int (*suspend)(struct snd_soc_component *);
+	int (*resume)(struct snd_soc_component *);
 
 	/* DT */
 	int (*of_xlate_dai_name)(struct snd_soc_component *component,
@@ -808,6 +810,7 @@ struct snd_soc_component {
 	unsigned int ignore_pmdown_time:1; /* pmdown_time is ignored at stop */
 	unsigned int registered_as_component:1;
 	unsigned int auxiliary:1; /* for auxiliary component of the card */
+	unsigned int suspended:1; /* is in suspend PM state */
 
 	struct list_head list;
 	struct list_head card_list;
@@ -853,6 +856,8 @@ struct snd_soc_component {
 
 	int (*probe)(struct snd_soc_component *);
 	void (*remove)(struct snd_soc_component *);
+	int (*suspend)(struct snd_soc_component *);
+	int (*resume)(struct snd_soc_component *);
 
 	/* machine specific init */
 	int (*init)(struct snd_soc_component *component);
@@ -872,7 +877,6 @@ struct snd_soc_codec {
 
 	/* runtime */
 	unsigned int cache_bypass:1; /* Suppress access to the cache */
-	unsigned int suspended:1; /* Codec is in suspend PM state */
 	unsigned int cache_init:1; /* codec cache has been initialized */
 
 	/* codec IO */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ba8e000faaf1..f35ec5bf3b78 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -702,43 +702,39 @@ int snd_soc_suspend(struct device *dev)
 	dapm_mark_endpoints_dirty(card);
 	snd_soc_dapm_sync(&card->dapm);
 
-	/* suspend all CODECs */
+	/* suspend all COMPONENTs */
 	list_for_each_entry(component, &card->component_dev_list, card_list) {
 		struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
-		struct snd_soc_codec *codec = snd_soc_component_to_codec(component);
 
-		if (!codec)
-			continue;
-
-		/* If there are paths active then the CODEC will be held with
+		/* If there are paths active then the COMPONENT will be held with
 		 * bias _ON and should not be suspended. */
-		if (!codec->suspended) {
+		if (!component->suspended) {
 			switch (snd_soc_dapm_get_bias_level(dapm)) {
 			case SND_SOC_BIAS_STANDBY:
 				/*
-				 * If the CODEC is capable of idle
+				 * If the COMPONENT is capable of idle
 				 * bias off then being in STANDBY
 				 * means it's doing something,
 				 * otherwise fall through.
 				 */
 				if (dapm->idle_bias_off) {
-					dev_dbg(codec->dev,
+					dev_dbg(component->dev,
 						"ASoC: idle_bias_off CODEC on over suspend\n");
 					break;
 				}
 
 			case SND_SOC_BIAS_OFF:
-				if (codec->driver->suspend)
-					codec->driver->suspend(codec);
-				codec->suspended = 1;
-				if (codec->component.regmap)
-					regcache_mark_dirty(codec->component.regmap);
+				if (component->suspend)
+					component->suspend(component);
+				component->suspended = 1;
+				if (component->regmap)
+					regcache_mark_dirty(component->regmap);
 				/* deactivate pins to sleep state */
-				pinctrl_pm_select_sleep_state(codec->dev);
+				pinctrl_pm_select_sleep_state(component->dev);
 				break;
 			default:
-				dev_dbg(codec->dev,
-					"ASoC: CODEC is on over suspend\n");
+				dev_dbg(component->dev,
+					"ASoC: COMPONENT is on over suspend\n");
 				break;
 			}
 		}
@@ -799,15 +795,10 @@ static void soc_resume_deferred(struct work_struct *work)
 	}
 
 	list_for_each_entry(component, &card->component_dev_list, card_list) {
-		struct snd_soc_codec *codec = snd_soc_component_to_codec(component);
-
-		if (!codec)
-			continue;
-
-		if (codec->suspended) {
-			if (codec->driver->resume)
-				codec->driver->resume(codec);
-			codec->suspended = 0;
+		if (component->suspended) {
+			if (component->resume)
+				component->resume(component);
+			component->suspended = 0;
 		}
 	}
 
@@ -2937,6 +2928,8 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 	component->driver = driver;
 	component->probe = component->driver->probe;
 	component->remove = component->driver->remove;
+	component->suspend = component->driver->suspend;
+	component->resume = component->driver->resume;
 
 	dapm = &component->dapm;
 	dapm->dev = dev;
@@ -3286,6 +3279,20 @@ static void snd_soc_codec_drv_remove(struct snd_soc_component *component)
 	codec->driver->remove(codec);
 }
 
+static int snd_soc_codec_drv_suspend(struct snd_soc_component *component)
+{
+	struct snd_soc_codec *codec = snd_soc_component_to_codec(component);
+
+	return codec->driver->suspend(codec);
+}
+
+static int snd_soc_codec_drv_resume(struct snd_soc_component *component)
+{
+	struct snd_soc_codec *codec = snd_soc_component_to_codec(component);
+
+	return codec->driver->resume(codec);
+}
+
 static int snd_soc_codec_drv_write(struct snd_soc_component *component,
 	unsigned int reg, unsigned int val)
 {
@@ -3347,6 +3354,10 @@ int snd_soc_register_codec(struct device *dev,
 		codec->component.probe = snd_soc_codec_drv_probe;
 	if (codec_drv->remove)
 		codec->component.remove = snd_soc_codec_drv_remove;
+	if (codec_drv->suspend)
+		codec->component.suspend = snd_soc_codec_drv_suspend;
+	if (codec_drv->resume)
+		codec->component.resume = snd_soc_codec_drv_resume;
 	if (codec_drv->write)
 		codec->component.write = snd_soc_codec_drv_write;
 	if (codec_drv->read)
-- 
2.10.2
