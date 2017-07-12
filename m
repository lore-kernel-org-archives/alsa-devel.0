From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/2] ASoC: fix pcm-creation regression
Date: Wed, 12 Jul 2017 17:55:29 +0200
Message-ID: <20170712155530.17765-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f66.google.com (mail-lf0-f66.google.com
 [209.85.215.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E0B5266FFD
 for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2017 17:57:19 +0200 (CEST)
Received: by mail-lf0-f66.google.com with SMTP id f28so3460617lfi.3
 for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2017 08:57:19 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linus Walleij <linus.walleij@linaro.org>, Brian Norris <briannorris@chromium.org>, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Johan Hovold <johan@kernel.org>
List-Id: alsa-devel@alsa-project.org

This reverts commit 99b04f4c4051 ("ASoC: add Component level
pcm_new/pcm_free"), which started calling the pcm_new callback for every
component in a *card* when creating a new pcm, something which does not
seem to make any sense.

This specifically led to memory leaks in systems with more than one
platform component and where DMA memory is allocated in the
platform-driver callback. For example, when both mcasp devices are being
used on an am335x board, DMA memory would be allocated twice for every
DAI link during probe.

When CONFIG_SND_VERBOSE_PROCFS was set this fortunately also led to
warnings such as:

WARNING: CPU: 0 PID: 565 at ../fs/proc/generic.c:346 proc_register+0x110/0x154
proc_dir_entry 'sub0/prealloc' already registered

Since there seems to be no users of the new component callbacks, and the
current implementation introduced a regression, let's revert the
offending commit for now.

Fixes: 99b04f4c4051 ("ASoC: add Component level pcm_new/pcm_free")
Cc: stable <stable@vger.kernel.org>	# 4.10
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Brian Norris <briannorris@chromium.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 include/sound/soc.h  |  6 ------
 sound/soc/soc-core.c | 25 -------------------------
 sound/soc/soc-pcm.c  | 32 +++++++++-----------------------
 3 files changed, 9 insertions(+), 54 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 9c94b97c17f8..c4a8b1947566 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -795,10 +795,6 @@ struct snd_soc_component_driver {
 	int (*suspend)(struct snd_soc_component *);
 	int (*resume)(struct snd_soc_component *);
 
-	/* pcm creation and destruction */
-	int (*pcm_new)(struct snd_soc_pcm_runtime *);
-	void (*pcm_free)(struct snd_pcm *);
-
 	/* DT */
 	int (*of_xlate_dai_name)(struct snd_soc_component *component,
 				 struct of_phandle_args *args,
@@ -874,8 +870,6 @@ struct snd_soc_component {
 	void (*remove)(struct snd_soc_component *);
 	int (*suspend)(struct snd_soc_component *);
 	int (*resume)(struct snd_soc_component *);
-	int (*pcm_new)(struct snd_soc_pcm_runtime *);
-	void (*pcm_free)(struct snd_pcm *);
 
 	/* machine specific init */
 	int (*init)(struct snd_soc_component *component);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 921622a01944..c240e13ba057 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3171,8 +3171,6 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 	component->remove = component->driver->remove;
 	component->suspend = component->driver->suspend;
 	component->resume = component->driver->resume;
-	component->pcm_new = component->driver->pcm_new;
-	component->pcm_free = component->driver->pcm_free;
 
 	dapm = &component->dapm;
 	dapm->dev = dev;
@@ -3360,25 +3358,6 @@ static void snd_soc_platform_drv_remove(struct snd_soc_component *component)
 	platform->driver->remove(platform);
 }
 
-static int snd_soc_platform_drv_pcm_new(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_platform *platform = rtd->platform;
-
-	if (platform->driver->pcm_new)
-		return platform->driver->pcm_new(rtd);
-	else
-		return 0;
-}
-
-static void snd_soc_platform_drv_pcm_free(struct snd_pcm *pcm)
-{
-	struct snd_soc_pcm_runtime *rtd = pcm->private_data;
-	struct snd_soc_platform *platform = rtd->platform;
-
-	if (platform->driver->pcm_free)
-		platform->driver->pcm_free(pcm);
-}
-
 /**
  * snd_soc_add_platform - Add a platform to the ASoC core
  * @dev: The parent device for the platform
@@ -3402,10 +3381,6 @@ int snd_soc_add_platform(struct device *dev, struct snd_soc_platform *platform,
 		platform->component.probe = snd_soc_platform_drv_probe;
 	if (platform_drv->remove)
 		platform->component.remove = snd_soc_platform_drv_remove;
-	if (platform_drv->pcm_new)
-		platform->component.pcm_new = snd_soc_platform_drv_pcm_new;
-	if (platform_drv->pcm_free)
-		platform->component.pcm_free = snd_soc_platform_drv_pcm_free;
 
 #ifdef CONFIG_DEBUG_FS
 	platform->component.debugfs_prefix = "platform";
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index dcc5ece08668..553f7a76743c 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2628,25 +2628,12 @@ static int dpcm_fe_dai_close(struct snd_pcm_substream *fe_substream)
 	return ret;
 }
 
-static void soc_pcm_free(struct snd_pcm *pcm)
-{
-	struct snd_soc_pcm_runtime *rtd = pcm->private_data;
-	struct snd_soc_component *component;
-
-	list_for_each_entry(component, &rtd->card->component_dev_list,
-			    card_list) {
-		if (component->pcm_free)
-			component->pcm_free(pcm);
-	}
-}
-
 /* create a new pcm */
 int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 {
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_component *component;
 	struct snd_pcm *pcm;
 	char new_name[64];
 	int ret = 0, playback = 0, capture = 0;
@@ -2756,18 +2743,17 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 	if (capture)
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &rtd->ops);
 
-	list_for_each_entry(component, &rtd->card->component_dev_list, card_list) {
-		if (component->pcm_new) {
-			ret = component->pcm_new(rtd);
-			if (ret < 0) {
-				dev_err(component->dev,
-					"ASoC: pcm constructor failed: %d\n",
-					ret);
-				return ret;
-			}
+	if (platform->driver->pcm_new) {
+		ret = platform->driver->pcm_new(rtd);
+		if (ret < 0) {
+			dev_err(platform->dev,
+				"ASoC: pcm constructor failed: %d\n",
+				ret);
+			return ret;
 		}
 	}
-	pcm->private_free = soc_pcm_free;
+
+	pcm->private_free = platform->driver->pcm_free;
 out:
 	dev_info(rtd->card->dev, "%s <-> %s mapping ok\n",
 		 (rtd->num_codecs > 1) ? "multicodec" : rtd->codec_dai->name,
-- 
2.13.2
