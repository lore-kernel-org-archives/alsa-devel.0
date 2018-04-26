From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: compress: Only call free for components
	which have been opened" to the asoc tree
Date: Thu, 26 Apr 2018 12:49:44 +0100
Message-ID: <E1fBfPE-0007Ey-FR@debutante>
References: <20180424153903.7693-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 432D826784B
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 13:49:49 +0200 (CEST)
In-Reply-To: <20180424153903.7693-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, vinod.koul@intel.com, patches@opensource.cirrus.com, lgirdwood@gmail.com, Vinod Koul <vkoul@kernel.org>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: compress: Only call free for components which have been opened

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

>From 572e6c8dd174bc6fc7ba5d9b6935e9ec8d2660f5 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Tue, 24 Apr 2018 16:39:01 +0100
Subject: [PATCH] ASoC: compress: Only call free for components which have been
 opened

The core should only call free on a component if said component has
already had open called on it. This is not presently the case and most
compressed drivers in the kernel assume it will be. This causes null
pointer dereferences in the drivers as they attempt clean up for stuff
that was never put in place.

This is fixed by aborting calling open callbacks once a failure is
encountered and then during clean up only iterating through the
component list to that point.

This is a fairly quick fix to the issue, to allow backporting. There
is more refactoring to follow to tidy the code up a little.

Fixes: 9e7e3738ab0e ("ASoC: snd_soc_component_driver has snd_compr_ops")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-compress.c | 52 +++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 82402688bd8e..948505f74229 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -33,7 +33,7 @@ static int soc_compr_open(struct snd_compr_stream *cstream)
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	int ret = 0, __ret;
+	int ret;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -68,16 +68,15 @@ static int soc_compr_open(struct snd_compr_stream *cstream)
 		    !component->driver->compr_ops->open)
 			continue;
 
-		__ret = component->driver->compr_ops->open(cstream);
-		if (__ret < 0) {
+		ret = component->driver->compr_ops->open(cstream);
+		if (ret < 0) {
 			dev_err(component->dev,
 				"Compress ASoC: can't open platform %s: %d\n",
-				component->name, __ret);
-			ret = __ret;
+				component->name, ret);
+			goto machine_err;
 		}
 	}
-	if (ret < 0)
-		goto machine_err;
+	component = NULL;
 
 	if (rtd->dai_link->compr_ops && rtd->dai_link->compr_ops->startup) {
 		ret = rtd->dai_link->compr_ops->startup(cstream);
@@ -97,17 +96,20 @@ static int soc_compr_open(struct snd_compr_stream *cstream)
 
 machine_err:
 	for_each_rtdcom(rtd, rtdcom) {
-		component = rtdcom->component;
+		struct snd_soc_component *err_comp = rtdcom->component;
+
+		if (err_comp == component)
+			break;
 
 		/* ignore duplication for now */
-		if (platform && (component == &platform->component))
+		if (platform && (err_comp == &platform->component))
 			continue;
 
-		if (!component->driver->compr_ops ||
-		    !component->driver->compr_ops->free)
+		if (!err_comp->driver->compr_ops ||
+		    !err_comp->driver->compr_ops->free)
 			continue;
 
-		component->driver->compr_ops->free(cstream);
+		err_comp->driver->compr_ops->free(cstream);
 	}
 
 	if (platform && platform->driver->compr_ops && platform->driver->compr_ops->free)
@@ -132,7 +134,7 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 	struct snd_soc_dpcm *dpcm;
 	struct snd_soc_dapm_widget_list *list;
 	int stream;
-	int ret = 0, __ret;
+	int ret;
 
 	if (cstream->direction == SND_COMPRESS_PLAYBACK)
 		stream = SNDRV_PCM_STREAM_PLAYBACK;
@@ -172,16 +174,15 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 		    !component->driver->compr_ops->open)
 			continue;
 
-		__ret = component->driver->compr_ops->open(cstream);
-		if (__ret < 0) {
+		ret = component->driver->compr_ops->open(cstream);
+		if (ret < 0) {
 			dev_err(component->dev,
 				"Compress ASoC: can't open platform %s: %d\n",
-				component->name, __ret);
-			ret = __ret;
+				component->name, ret);
+			goto machine_err;
 		}
 	}
-	if (ret < 0)
-		goto machine_err;
+	component = NULL;
 
 	if (fe->dai_link->compr_ops && fe->dai_link->compr_ops->startup) {
 		ret = fe->dai_link->compr_ops->startup(cstream);
@@ -236,17 +237,20 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 		fe->dai_link->compr_ops->shutdown(cstream);
 machine_err:
 	for_each_rtdcom(fe, rtdcom) {
-		component = rtdcom->component;
+		struct snd_soc_component *err_comp = rtdcom->component;
+
+		if (err_comp == component)
+			break;
 
 		/* ignore duplication for now */
-		if (platform && (component == &platform->component))
+		if (platform && (err_comp == &platform->component))
 			continue;
 
-		if (!component->driver->compr_ops ||
-		    !component->driver->compr_ops->free)
+		if (!err_comp->driver->compr_ops ||
+		    !err_comp->driver->compr_ops->free)
 			continue;
 
-		component->driver->compr_ops->free(cstream);
+		err_comp->driver->compr_ops->free(cstream);
 	}
 
 	if (platform && platform->driver->compr_ops && platform->driver->compr_ops->free)
-- 
2.17.0
