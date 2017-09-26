From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add null_snd_soc_ops and reduce NULL
	ops check" to the asoc tree
Date: Tue, 26 Sep 2017 17:37:45 +0100 (BST)
Message-ID: <20170926163746.08EDF440053@finisterre.ee.mobilebroadband>
References: <87poaeb8ow.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 425CB267140
 for <alsa-devel@alsa-project.org>; Tue, 26 Sep 2017 18:38:21 +0200 (CEST)
In-Reply-To: <87poaeb8ow.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: add null_snd_soc_ops and reduce NULL ops check

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

>From 75ab9eb6f15bad78b3ce274c699c27dc98ab13ce Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 26 Sep 2017 00:40:42 +0000
Subject: [PATCH] ASoC: add null_snd_soc_ops and reduce NULL ops check

Double NULL pointer check for ops and ops->func is difficult to read
and might be forget to check it if new func was add.
This patch adds new null_snd_soc_ops and use it if rtd->dai_link didn't
have it to avoid NULL ops, and reduces ops NULL check.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c |  5 +++++
 sound/soc/soc-pcm.c  | 16 ++++++++--------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e16220600e51..1b5b51952718 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -614,6 +614,8 @@ struct snd_pcm_substream *snd_soc_get_dai_substream(struct snd_soc_card *card,
 }
 EXPORT_SYMBOL_GPL(snd_soc_get_dai_substream);
 
+static const struct snd_soc_ops null_snd_soc_ops;
+
 static struct snd_soc_pcm_runtime *soc_new_pcm_runtime(
 	struct snd_soc_card *card, struct snd_soc_dai_link *dai_link)
 {
@@ -626,6 +628,9 @@ static struct snd_soc_pcm_runtime *soc_new_pcm_runtime(
 	INIT_LIST_HEAD(&rtd->component_list);
 	rtd->card = card;
 	rtd->dai_link = dai_link;
+	if (!rtd->dai_link->ops)
+		rtd->dai_link->ops = &null_snd_soc_ops;
+
 	rtd->codec_dais = kzalloc(sizeof(struct snd_soc_dai *) *
 					dai_link->num_codecs,
 					GFP_KERNEL);
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 983edd0e6e8f..23c251a6c587 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -511,7 +511,7 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 			codec_dai->rx_mask = 0;
 	}
 
-	if (rtd->dai_link->ops && rtd->dai_link->ops->startup) {
+	if (rtd->dai_link->ops->startup) {
 		ret = rtd->dai_link->ops->startup(substream);
 		if (ret < 0) {
 			pr_err("ASoC: %s startup failed: %d\n",
@@ -585,7 +585,7 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	return 0;
 
 config_err:
-	if (rtd->dai_link->ops && rtd->dai_link->ops->shutdown)
+	if (rtd->dai_link->ops->shutdown)
 		rtd->dai_link->ops->shutdown(substream);
 
 machine_err:
@@ -692,7 +692,7 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 			codec_dai->driver->ops->shutdown(substream, codec_dai);
 	}
 
-	if (rtd->dai_link->ops && rtd->dai_link->ops->shutdown)
+	if (rtd->dai_link->ops->shutdown)
 		rtd->dai_link->ops->shutdown(substream);
 
 	if (platform->driver->ops && platform->driver->ops->close)
@@ -751,7 +751,7 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
-	if (rtd->dai_link->ops && rtd->dai_link->ops->prepare) {
+	if (rtd->dai_link->ops->prepare) {
 		ret = rtd->dai_link->ops->prepare(substream);
 		if (ret < 0) {
 			dev_err(rtd->card->dev, "ASoC: machine prepare error:"
@@ -855,7 +855,7 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	int i, ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
-	if (rtd->dai_link->ops && rtd->dai_link->ops->hw_params) {
+	if (rtd->dai_link->ops->hw_params) {
 		ret = rtd->dai_link->ops->hw_params(substream, params);
 		if (ret < 0) {
 			dev_err(rtd->card->dev, "ASoC: machine hw_params"
@@ -948,7 +948,7 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 		codec_dai->rate = 0;
 	}
 
-	if (rtd->dai_link->ops && rtd->dai_link->ops->hw_free)
+	if (rtd->dai_link->ops->hw_free)
 		rtd->dai_link->ops->hw_free(substream);
 
 	mutex_unlock(&rtd->pcm_mutex);
@@ -994,7 +994,7 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 	}
 
 	/* free any machine hw params */
-	if (rtd->dai_link->ops && rtd->dai_link->ops->hw_free)
+	if (rtd->dai_link->ops->hw_free)
 		rtd->dai_link->ops->hw_free(substream);
 
 	/* free any DMA resources */
@@ -1045,7 +1045,7 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 			return ret;
 	}
 
-	if (rtd->dai_link->ops && rtd->dai_link->ops->trigger) {
+	if (rtd->dai_link->ops->trigger) {
 		ret = rtd->dai_link->ops->trigger(substream, cmd);
 		if (ret < 0)
 			return ret;
-- 
2.14.1
