From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec2codec: run callbacks in order" to the asoc tree
Date: Thu, 25 Jul 2019 18:43:39 +0100 (BST)
Message-ID: <20190725174339.F005E2742B63@ypsilon.sirena.org.uk>
References: <20190725165949.29699-2-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725165949.29699-2-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec2codec: run callbacks in order

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

>From 68c907f10cd816cad2287167a1a1d77914a6d466 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 25 Jul 2019 18:59:44 +0200
Subject: [PATCH] ASoC: codec2codec: run callbacks in order

When handling dai_link events on codec to codec links, run all .startup()
callbacks on sinks and sources before running any .hw_params(). Same goes
for hw_free() and shutdown(). This is closer to the behavior of regular
dai links

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20190725165949.29699-2-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 1d04612601ad..034b31fd2ecb 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3835,11 +3835,6 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 				goto out;
 			}
 			source->active++;
-			ret = snd_soc_dai_hw_params(source, &substream, params);
-			if (ret < 0)
-				goto out;
-
-			dapm_update_dai_unlocked(&substream, params, source);
 		}
 
 		substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
@@ -3853,6 +3848,23 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 				goto out;
 			}
 			sink->active++;
+		}
+
+		substream.stream = SNDRV_PCM_STREAM_CAPTURE;
+		snd_soc_dapm_widget_for_each_source_path(w, path) {
+			source = path->source->priv;
+
+			ret = snd_soc_dai_hw_params(source, &substream, params);
+			if (ret < 0)
+				goto out;
+
+			dapm_update_dai_unlocked(&substream, params, source);
+		}
+
+		substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
+		snd_soc_dapm_widget_for_each_sink_path(w, path) {
+			sink = path->sink->priv;
+
 			ret = snd_soc_dai_hw_params(sink, &substream, params);
 			if (ret < 0)
 				goto out;
@@ -3889,9 +3901,18 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 		substream.stream = SNDRV_PCM_STREAM_CAPTURE;
 		snd_soc_dapm_widget_for_each_source_path(w, path) {
 			source = path->source->priv;
-
 			snd_soc_dai_hw_free(source, &substream);
+		}
+
+		substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
+		snd_soc_dapm_widget_for_each_sink_path(w, path) {
+			sink = path->sink->priv;
+			snd_soc_dai_hw_free(sink, &substream);
+		}
 
+		substream.stream = SNDRV_PCM_STREAM_CAPTURE;
+		snd_soc_dapm_widget_for_each_source_path(w, path) {
+			source = path->source->priv;
 			source->active--;
 			snd_soc_dai_shutdown(source, &substream);
 		}
@@ -3899,9 +3920,6 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 		substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
 		snd_soc_dapm_widget_for_each_sink_path(w, path) {
 			sink = path->sink->priv;
-
-			snd_soc_dai_hw_free(sink, &substream);
-
 			sink->active--;
 			snd_soc_dai_shutdown(sink, &substream);
 		}
-- 
2.20.1
