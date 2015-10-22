From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Add startup & shutdown for
	dai_links" to the asoc tree
Date: Fri, 23 Oct 2015 08:09:07 +0900
Message-ID: <E1ZpOyp-0008M4-SA@finisterre>
References: <1445355532-28310-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 42B30266AE4
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:09:18 +0200 (CEST)
In-Reply-To: <1445355532-28310-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Add startup & shutdown for dai_links

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

>From 9b8ef9f6b3fcccc2b6ce4bb59d8ab55b36a8b8f0 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Tue, 20 Oct 2015 22:30:07 +0530
Subject: [PATCH] ASoC: dapm: Add startup & shutdown for dai_links

For DAI link events, DSPs would like to get notified for startup
and shutdown event as well apart for existing hw_params. This
helps managing DSP resource allocation and freeup on these events
So add support for startup and shutdown for
snd_soc_dai_link_event()

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 9762ac4..a28d6a1 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3478,11 +3478,29 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		substream.stream = SNDRV_PCM_STREAM_CAPTURE;
+		if (source->driver->ops && source->driver->ops->startup) {
+			ret = source->driver->ops->startup(&substream, source);
+			if (ret < 0) {
+				dev_err(source->dev,
+					"ASoC: startup() failed: %d\n", ret);
+				goto out;
+			}
+			source->active++;
+		}
 		ret = soc_dai_hw_params(&substream, params, source);
 		if (ret < 0)
 			goto out;
 
 		substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
+		if (sink->driver->ops && sink->driver->ops->startup) {
+			ret = sink->driver->ops->startup(&substream, sink);
+			if (ret < 0) {
+				dev_err(sink->dev,
+					"ASoC: startup() failed: %d\n", ret);
+				goto out;
+			}
+			sink->active++;
+		}
 		ret = soc_dai_hw_params(&substream, params, sink);
 		if (ret < 0)
 			goto out;
@@ -3502,6 +3520,18 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 		if (ret != 0 && ret != -ENOTSUPP)
 			dev_warn(sink->dev, "ASoC: Failed to mute: %d\n", ret);
 		ret = 0;
+
+		source->active--;
+		if (source->driver->ops && source->driver->ops->shutdown) {
+			substream.stream = SNDRV_PCM_STREAM_CAPTURE;
+			source->driver->ops->shutdown(&substream, source);
+		}
+
+		sink->active--;
+		if (sink->driver->ops && sink->driver->ops->shutdown) {
+			substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
+			sink->driver->ops->shutdown(&substream, sink);
+		}
 		break;
 
 	default:
-- 
2.6.1
