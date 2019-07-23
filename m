From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-dai: mv soc_dai_hw_params() to
	soc-dai" to the asoc tree
Date: Tue, 23 Jul 2019 18:18:53 +0100 (BST)
Message-ID: <20190723171853.345132742BAC@ypsilon.sirena.org.uk>
References: <87zhl6hn5b.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 496D3F8044A
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 19:18:54 +0200 (CEST)
In-Reply-To: <87zhl6hn5b.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-dai: mv soc_dai_hw_params() to soc-dai

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From aa6166c2ac28392d64f2d8b3acfb56c8fe657147 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 22 Jul 2019 10:33:04 +0900
Subject: [PATCH] ASoC: soc-dai: mv soc_dai_hw_params() to soc-dai

Sometimes ALSA SoC naming is very random.
Current soc_dai_hw_params() should use snd_soc_dai_xxx() style.
And then, 1st parameter should be dai. Otherwise it is confusable.
 - soc_dai_hw_params(..., dai);
 + snd_soc_dai_hw_params(dai, ...);

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87zhl6hn5b.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dai.h |  4 ++++
 include/sound/soc.h     |  4 ----
 sound/soc/soc-dai.c     | 30 ++++++++++++++++++++++++++++++
 sound/soc/soc-dapm.c    |  4 ++--
 sound/soc/soc-pcm.c     | 35 +++--------------------------------
 5 files changed, 39 insertions(+), 38 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index f5d70041108f..3773262a1b77 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -145,6 +145,10 @@ int snd_soc_dai_get_channel_map(struct snd_soc_dai *dai,
 
 int snd_soc_dai_is_dummy(struct snd_soc_dai *dai);
 
+int snd_soc_dai_hw_params(struct snd_soc_dai *dai,
+			  struct snd_pcm_substream *substream,
+			  struct snd_pcm_hw_params *params);
+
 struct snd_soc_dai_ops {
 	/*
 	 * DAI clocking configuration, all optional.
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4e8071269639..d770606732cd 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -505,10 +505,6 @@ int snd_soc_params_to_bclk(struct snd_pcm_hw_params *parms);
 int snd_soc_set_runtime_hwparams(struct snd_pcm_substream *substream,
 	const struct snd_pcm_hardware *hw);
 
-int soc_dai_hw_params(struct snd_pcm_substream *substream,
-		      struct snd_pcm_hw_params *params,
-		      struct snd_soc_dai *dai);
-
 /* Jack reporting */
 int snd_soc_card_jack_new(struct snd_soc_card *card, const char *id, int type,
 	struct snd_soc_jack *jack, struct snd_soc_jack_pin *pins,
diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
index a1009ead40de..f883d27d136f 100644
--- a/sound/soc/soc-dai.c
+++ b/sound/soc/soc-dai.c
@@ -252,3 +252,33 @@ int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute,
 		return -ENOTSUPP;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dai_digital_mute);
+
+int snd_soc_dai_hw_params(struct snd_soc_dai *dai,
+			  struct snd_pcm_substream *substream,
+			  struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	int ret;
+
+	/* perform any topology hw_params fixups before DAI  */
+	if (rtd->dai_link->be_hw_params_fixup) {
+		ret = rtd->dai_link->be_hw_params_fixup(rtd, params);
+		if (ret < 0) {
+			dev_err(rtd->dev,
+				"ASoC: hw_params topology fixup failed %d\n",
+				ret);
+			return ret;
+		}
+	}
+
+	if (dai->driver->ops->hw_params) {
+		ret = dai->driver->ops->hw_params(substream, params, dai);
+		if (ret < 0) {
+			dev_err(dai->dev, "ASoC: can't set %s hw params: %d\n",
+				dai->name, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index f013b24c050a..8fc6a01f5d8b 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3839,7 +3839,7 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 				}
 			}
 			source->active++;
-			ret = soc_dai_hw_params(&substream, params, source);
+			ret = snd_soc_dai_hw_params(source, &substream, params);
 			if (ret < 0)
 				goto out;
 
@@ -3861,7 +3861,7 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 				}
 			}
 			sink->active++;
-			ret = soc_dai_hw_params(&substream, params, sink);
+			ret = snd_soc_dai_hw_params(sink, &substream, params);
 			if (ret < 0)
 				goto out;
 
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 4878d22ebd8c..420cc94e0a46 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -877,36 +877,6 @@ static void soc_pcm_codec_params_fixup(struct snd_pcm_hw_params *params,
 	interval->max = channels;
 }
 
-int soc_dai_hw_params(struct snd_pcm_substream *substream,
-		      struct snd_pcm_hw_params *params,
-		      struct snd_soc_dai *dai)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	int ret;
-
-	/* perform any topology hw_params fixups before DAI  */
-	if (rtd->dai_link->be_hw_params_fixup) {
-		ret = rtd->dai_link->be_hw_params_fixup(rtd, params);
-		if (ret < 0) {
-			dev_err(rtd->dev,
-				"ASoC: hw_params topology fixup failed %d\n",
-				ret);
-			return ret;
-		}
-	}
-
-	if (dai->driver->ops->hw_params) {
-		ret = dai->driver->ops->hw_params(substream, params, dai);
-		if (ret < 0) {
-			dev_err(dai->dev, "ASoC: can't set %s hw params: %d\n",
-				dai->name, ret);
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
 static int soc_pcm_components_hw_free(struct snd_pcm_substream *substream,
 				      struct snd_soc_component *last)
 {
@@ -989,7 +959,8 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 			soc_pcm_codec_params_fixup(&codec_params,
 						   codec_dai->rx_mask);
 
-		ret = soc_dai_hw_params(substream, &codec_params, codec_dai);
+		ret = snd_soc_dai_hw_params(codec_dai, substream,
+					    &codec_params);
 		if(ret < 0)
 			goto codec_err;
 
@@ -1001,7 +972,7 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 		snd_soc_dapm_update_dai(substream, &codec_params, codec_dai);
 	}
 
-	ret = soc_dai_hw_params(substream, params, cpu_dai);
+	ret = snd_soc_dai_hw_params(cpu_dai, substream, params);
 	if (ret < 0)
 		goto interface_err;
 
-- 
2.20.1
