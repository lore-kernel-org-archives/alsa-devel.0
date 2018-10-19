From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Add support for hw_free on CODEC
	to CODEC links" to the asoc tree
Date: Fri, 19 Oct 2018 13:34:22 +0100 (BST)
Message-ID: <20181019123422.A28891122548@debutante.sirena.org.uk>
References: <20181011162831.26351-2-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 556F8267A71
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2018 14:34:23 +0200 (CEST)
In-Reply-To: <20181011162831.26351-2-ckeepax@opensource.cirrus.com>
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

   ASoC: dapm: Add support for hw_free on CODEC to CODEC links

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

>From 3c01b0e129e9486c8004e43eba3a70de7393f645 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Thu, 11 Oct 2018 17:28:28 +0100
Subject: [PATCH] ASoC: dapm: Add support for hw_free on CODEC to CODEC links

Currently, on power down for a CODEC to CODEC DAI link we only call
digital_mute and shutdown. Provide a little more flexibility for drivers
by adding a call to hw_free as well.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 8c5b065c8880..a5178845065b 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3737,25 +3737,30 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 			ret = 0;
 		}
 
+		substream.stream = SNDRV_PCM_STREAM_CAPTURE;
 		snd_soc_dapm_widget_for_each_source_path(w, path) {
 			source = path->source->priv;
 
+			if (source->driver->ops->hw_free)
+				source->driver->ops->hw_free(&substream,
+							     source);
+
 			source->active--;
-			if (source->driver->ops->shutdown) {
-				substream.stream = SNDRV_PCM_STREAM_CAPTURE;
+			if (source->driver->ops->shutdown)
 				source->driver->ops->shutdown(&substream,
 							      source);
-			}
 		}
 
+		substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
 		snd_soc_dapm_widget_for_each_sink_path(w, path) {
 			sink = path->sink->priv;
 
+			if (sink->driver->ops->hw_free)
+				sink->driver->ops->hw_free(&substream, sink);
+
 			sink->active--;
-			if (sink->driver->ops->shutdown) {
-				substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
+			if (sink->driver->ops->shutdown)
 				sink->driver->ops->shutdown(&substream, sink);
-			}
 		}
 		break;
 
-- 
2.19.0.rc2
