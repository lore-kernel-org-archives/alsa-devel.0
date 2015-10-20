From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/3] ASoC: dapm: Add startup & shutdown for
	dai_links
Date: Tue, 20 Oct 2015 21:08:51 +0530
Message-ID: <1445355532-28310-3-git-send-email-vinod.koul@intel.com>
References: <1445355532-28310-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id ED20C2665CA
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 17:36:03 +0200 (CEST)
In-Reply-To: <1445355532-28310-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

For DAI link events, DSPs would like to get notified for startup
and shutdown event as well apart for existing hw_params. This
helps managing DSP resource allocation and freeup on these events
So add support for startup and shutdown for
snd_soc_dai_link_event()

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/soc-dapm.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 746800380eb7..ef8064df2678 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3481,11 +3481,29 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
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
@@ -3505,6 +3523,18 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
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
1.9.1
