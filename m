From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] ASoC: omap-abe-mmap: Place constraint to
	buffer size as well
Date: Wed, 6 Feb 2013 16:10:09 +0100
Message-ID: <1360163409-25607-3-git-send-email-peter.ujfalusi@ti.com>
References: <CAAo96ZCNBTGBToLbKnvQ1k_eewJcg94KZBRKt7TKkE3T8xqsQw@mail.gmail.com>
 <1360163409-25607-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 52C20265237
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2013 16:10:17 +0100 (CET)
In-Reply-To: <1360163409-25607-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: brentweatherall@gmail.com
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, michael@amarulasolutions.com, clemens@ladisch.de, s-guiriec@ti.com
List-Id: alsa-devel@alsa-project.org

In this we can make sure that applications will figure out the correct
combination of period size and buffer size.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-abe-mmap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/omap/omap-abe-mmap.c b/sound/soc/omap/omap-abe-mmap.c
index e5654c9..0aea7ec 100644
--- a/sound/soc/omap/omap-abe-mmap.c
+++ b/sound/soc/omap/omap-abe-mmap.c
@@ -122,7 +122,7 @@ static int aess_open(struct snd_pcm_substream *substream)
 		break;
 	default:
 		/*
-		 * Period size must be aligned with the Audio Engine
+		 * Period and buffer size must be aligned with the Audio Engine
 		 * processing loop which is 250 us long
 		 */
 		ret = snd_pcm_hw_rule_add(substream->runtime, 0,
@@ -130,6 +130,11 @@ static int aess_open(struct snd_pcm_substream *substream)
 					omap_abe_hwrule_size_step,
 					NULL,
 					SNDRV_PCM_HW_PARAM_PERIOD_SIZE, -1);
+		ret = snd_pcm_hw_rule_add(substream->runtime, 0,
+					SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
+					omap_abe_hwrule_size_step,
+					NULL,
+					SNDRV_PCM_HW_PARAM_BUFFER_SIZE, -1);
 		break;
 	}
 
-- 
1.8.1.1
