From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: soc-compress: Add missing brackets
	around else
Date: Thu, 24 Jan 2013 09:44:28 +0000
Message-ID: <1359020670-25684-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 12EB02615D0
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 10:46:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: vinod.koul@linux.intel.com, tiwai@suse.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/soc-compress.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 5fbfb06..80040f0 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -112,10 +112,11 @@ static int soc_compr_free(struct snd_compr_stream *cstream)
 			snd_soc_dapm_stream_event(rtd,
 					SNDRV_PCM_STREAM_PLAYBACK,
 					SND_SOC_DAPM_STREAM_STOP);
-		} else
+		} else {
 			rtd->pop_wait = 1;
 			schedule_delayed_work(&rtd->delayed_work,
 				msecs_to_jiffies(rtd->pmdown_time));
+		}
 	} else {
 		/* capture streams can be powered down now */
 		snd_soc_dapm_stream_event(rtd,
-- 
1.7.2.5
