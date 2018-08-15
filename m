From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Fix NULL pointer deference on
	CODEC to CODEC DAIs" to the asoc tree
Date: Wed, 15 Aug 2018 15:52:42 +0100 (BST)
Message-ID: <20180815145242.AC38C1124437@debutante.sirena.org.uk>
References: <20180815121135.2543-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7066F26782A
 for <alsa-devel@alsa-project.org>; Wed, 15 Aug 2018 16:52:46 +0200 (CEST)
In-Reply-To: <20180815121135.2543-1-ckeepax@opensource.cirrus.com>
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
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Fix NULL pointer deference on CODEC to CODEC DAIs

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

>From 249dc49576fc953a7378b916c6a6d47ea81e4da2 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Wed, 15 Aug 2018 13:11:35 +0100
Subject: [PATCH] ASoC: dapm: Fix NULL pointer deference on CODEC to CODEC DAIs

Commit a655de808cbde ("ASoC: core: Allow topology to override
machine driver FE DAI link config.") caused soc_dai_hw_params to
be come dependent on the substream private_data being set with
a pointer to the snd_soc_pcm_runtime. Currently, CODEC to CODEC
links don't set this, which causes a NULL pointer dereference:

[<4069de54>] (soc_dai_hw_params) from
[<40694b68>] (snd_soc_dai_link_event+0x1a0/0x380)

Since the ASoC core in general assumes that the substream
private_data will be set to a pointer to the snd_soc_pcm_runtime,
update the CODEC to CODEC links to respect this.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dapm.h | 1 +
 sound/soc/soc-core.c     | 4 ++--
 sound/soc/soc-dapm.c     | 4 ++++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index af9ef16cc34d..fdaaafdc7a00 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -407,6 +407,7 @@ int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card);
 void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card);
 int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
+			 struct snd_soc_pcm_runtime *rtd,
 			 const struct snd_soc_pcm_stream *params,
 			 unsigned int num_params,
 			 struct snd_soc_dapm_widget *source,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 9cfe10d8040c..473eefe8658e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1447,7 +1447,7 @@ static int soc_link_dai_widgets(struct snd_soc_card *card,
 	sink = codec_dai->playback_widget;
 	source = cpu_dai->capture_widget;
 	if (sink && source) {
-		ret = snd_soc_dapm_new_pcm(card, dai_link->params,
+		ret = snd_soc_dapm_new_pcm(card, rtd, dai_link->params,
 					   dai_link->num_params,
 					   source, sink);
 		if (ret != 0) {
@@ -1460,7 +1460,7 @@ static int soc_link_dai_widgets(struct snd_soc_card *card,
 	sink = cpu_dai->playback_widget;
 	source = codec_dai->capture_widget;
 	if (sink && source) {
-		ret = snd_soc_dapm_new_pcm(card, dai_link->params,
+		ret = snd_soc_dapm_new_pcm(card, rtd, dai_link->params,
 					   dai_link->num_params,
 					   source, sink);
 		if (ret != 0) {
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 7e96793050c9..461d951917c0 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3652,6 +3652,7 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_dapm_path *source_p, *sink_p;
 	struct snd_soc_dai *source, *sink;
+	struct snd_soc_pcm_runtime *rtd = w->priv;
 	const struct snd_soc_pcm_stream *config = w->params + w->params_select;
 	struct snd_pcm_substream substream;
 	struct snd_pcm_hw_params *params = NULL;
@@ -3711,6 +3712,7 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 		goto out;
 	}
 	substream.runtime = runtime;
+	substream.private_data = rtd;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -3895,6 +3897,7 @@ snd_soc_dapm_alloc_kcontrol(struct snd_soc_card *card,
 }
 
 int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
+			 struct snd_soc_pcm_runtime *rtd,
 			 const struct snd_soc_pcm_stream *params,
 			 unsigned int num_params,
 			 struct snd_soc_dapm_widget *source,
@@ -3963,6 +3966,7 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 
 	w->params = params;
 	w->num_params = num_params;
+	w->priv = rtd;
 
 	ret = snd_soc_dapm_add_path(&card->dapm, source, w, NULL, NULL);
 	if (ret)
-- 
2.18.0
