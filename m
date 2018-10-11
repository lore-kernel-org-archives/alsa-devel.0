From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [RFC PATCH 1/4] ASoC: dapm: Add support for hw_free on
	CODEC to CODEC links
Date: Thu, 11 Oct 2018 17:28:28 +0100
Message-ID: <20181011162831.26351-2-ckeepax@opensource.cirrus.com>
References: <20181011162831.26351-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 62C91267939
 for <alsa-devel@alsa-project.org>; Thu, 11 Oct 2018 18:28:36 +0200 (CEST)
In-Reply-To: <20181011162831.26351-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Currently, on power down for a CODEC to CODEC DAI link we only call
digital_mute and shutdown. Provide a little more flexibility for drivers
by adding a call to hw_free as well.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/soc-dapm.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 8c5b065c88806..a5178845065b3 100644
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
2.11.0
