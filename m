From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 10/11] ASoC: dapm: Remove DAI DAPM context
Date: Mon, 16 Jun 2014 18:13:10 +0200
Message-ID: <1402935191-18398-11-git-send-email-lars@metafoo.de>
References: <1402935191-18398-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-035.synserver.de (smtp-out-035.synserver.de
 [212.40.185.35])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AE5426549F
 for <alsa-devel@alsa-project.org>; Mon, 16 Jun 2014 18:13:29 +0200 (CEST)
In-Reply-To: <1402935191-18398-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The DAI DAPM context was added in commit be09ad90 ("ASoC: core: Add platform DAI
widget mapping") and the only user was removed again in commit ae10e7e8f ("ASoC:
core: Only add platform DAI widgets once."). Now that we have a per component
DAPM context it is unlikely that we'll need the DAI DAPM context again.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dai.h |  1 -
 sound/soc/soc-core.c    | 12 +-----------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 688f2ba..031be2a 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -257,7 +257,6 @@ struct snd_soc_dai {
 
 	struct snd_soc_dapm_widget *playback_widget;
 	struct snd_soc_dapm_widget *capture_widget;
-	struct snd_soc_dapm_context dapm;
 
 	/* DAI DMA data */
 	void *playback_dma_data;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a414689..19dfa80 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1048,11 +1048,8 @@ static void soc_remove_link_dais(struct snd_soc_card *card, int num, int order)
 					cpu_dai->name, err);
 		}
 		cpu_dai->probed = 0;
-
-		if (!cpu_dai->codec) {
-			snd_soc_dapm_free(&cpu_dai->dapm);
+		if (!cpu_dai->codec)
 			module_put(cpu_dai->dev->driver->owner);
-		}
 	}
 }
 
@@ -1510,11 +1507,8 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 	if (!cpu_dai->probed &&
 			cpu_dai->driver->probe_order == order) {
 		if (!cpu_dai->codec) {
-			cpu_dai->dapm.card = card;
 			if (!try_module_get(cpu_dai->dev->driver->owner))
 				return -ENODEV;
-
-			list_add(&cpu_dai->dapm.list, &card->dapm_list);
 		}
 
 		if (cpu_dai->driver->probe) {
@@ -3975,13 +3969,9 @@ static int snd_soc_register_dais(struct snd_soc_component *component,
 		dai->component = component;
 		dai->dev = dev;
 		dai->driver = &dai_drv[i];
-		dai->dapm.dev = dev;
 		if (!dai->driver->ops)
 			dai->driver->ops = &null_dai_ops;
 
-		if (!dai->codec)
-			dai->dapm.idle_bias_off = 1;
-
 		list_add(&dai->list, &component->dai_list);
 
 		dev_dbg(dev, "ASoC: Registered DAI '%s'\n", dai->name);
-- 
1.8.0
