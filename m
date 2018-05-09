From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: remove unneeded .pcm_new/free" to the
	asoc tree
Date: Wed,  9 May 2018 10:44:27 +0100 (BST)
Message-ID: <20180509094427.DC26044007C@finisterre.ee.mobilebroadband>
References: <87fu32rg5c.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C1582267742
 for <alsa-devel@alsa-project.org>; Wed,  9 May 2018 18:28:57 +0200 (CEST)
In-Reply-To: <87fu32rg5c.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: remove unneeded .pcm_new/free

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 11fb14f8c5b8f016ea0dae2237854331071cad42 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 8 May 2018 03:19:49 +0000
Subject: [PATCH] ASoC: remove unneeded .pcm_new/free

commit ef050bece1b55 ("ASoC: Remove platform code now everything is
componentised") removed platform code, but it didn't remove
.pcm_new/free which existed only for platform.
This patch remove these

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  2 --
 sound/soc/soc-core.c | 18 ------------------
 sound/soc/soc-pcm.c  |  8 ++++----
 3 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 309bb70bcb1e..131185563532 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -886,8 +886,6 @@ struct snd_soc_component {
 	void (*remove)(struct snd_soc_component *);
 	int (*suspend)(struct snd_soc_component *);
 	int (*resume)(struct snd_soc_component *);
-	int (*pcm_new)(struct snd_soc_component *, struct snd_soc_pcm_runtime *);
-	void (*pcm_free)(struct snd_soc_component *, struct snd_pcm *);
 
 	int (*set_sysclk)(struct snd_soc_component *component,
 			  int clk_id, int source, unsigned int freq, int dir);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e5af15aa1c28..3b78868969d5 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2943,22 +2943,6 @@ static int snd_soc_component_stream_event(struct snd_soc_dapm_context *dapm,
 	return component->driver->stream_event(component, event);
 }
 
-static int snd_soc_component_drv_pcm_new(struct snd_soc_component *component,
-					struct snd_soc_pcm_runtime *rtd)
-{
-	if (component->driver->pcm_new)
-		return component->driver->pcm_new(rtd);
-
-	return 0;
-}
-
-static void snd_soc_component_drv_pcm_free(struct snd_soc_component *component,
-					  struct snd_pcm *pcm)
-{
-	if (component->driver->pcm_free)
-		component->driver->pcm_free(pcm);
-}
-
 static int snd_soc_component_set_bias_level(struct snd_soc_dapm_context *dapm,
 					enum snd_soc_bias_level level)
 {
@@ -2987,8 +2971,6 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 	component->set_sysclk = component->driver->set_sysclk;
 	component->set_pll = component->driver->set_pll;
 	component->set_jack = component->driver->set_jack;
-	component->pcm_new = snd_soc_component_drv_pcm_new;
-	component->pcm_free = snd_soc_component_drv_pcm_free;
 
 	dapm = snd_soc_component_get_dapm(component);
 	dapm->dev = dev;
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index da5a2dcb6520..3f6375499102 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2745,8 +2745,8 @@ static void soc_pcm_private_free(struct snd_pcm *pcm)
 	for_each_rtdcom(rtd, rtdcom) {
 		component = rtdcom->component;
 
-		if (component->pcm_free)
-			component->pcm_free(component, pcm);
+		if (component->driver->pcm_free)
+			component->driver->pcm_free(pcm);
 	}
 }
 
@@ -3012,10 +3012,10 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 	for_each_rtdcom(rtd, rtdcom) {
 		component = rtdcom->component;
 
-		if (!component->pcm_new)
+		if (!component->driver->pcm_new)
 			continue;
 
-		ret = component->pcm_new(component, rtd);
+		ret = component->driver->pcm_new(rtd);
 		if (ret < 0) {
 			dev_err(component->dev,
 				"ASoC: pcm constructor failed: %d\n",
-- 
2.17.0
