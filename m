From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] ASoC: omap-abe-mmap: Make the hwrule
	function to be more generic
Date: Wed, 6 Feb 2013 16:10:08 +0100
Message-ID: <1360163409-25607-2-git-send-email-peter.ujfalusi@ti.com>
References: <CAAo96ZCNBTGBToLbKnvQ1k_eewJcg94KZBRKt7TKkE3T8xqsQw@mail.gmail.com>
 <1360163409-25607-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id F09B3265236
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2013 16:10:15 +0100 (CET)
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

Avoid using defines to get the snd_interval we are about to constrain.
rule->var holds the correct ID.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-abe-mmap.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/omap/omap-abe-mmap.c b/sound/soc/omap/omap-abe-mmap.c
index 92c240b..e5654c9 100644
--- a/sound/soc/omap/omap-abe-mmap.c
+++ b/sound/soc/omap/omap-abe-mmap.c
@@ -87,18 +87,17 @@ irqreturn_t abe_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int omap_abe_hwrule_period_step(struct snd_pcm_hw_params *params,
+static int omap_abe_hwrule_size_step(struct snd_pcm_hw_params *params,
 					struct snd_pcm_hw_rule *rule)
 {
-	struct snd_interval *period_size = hw_param_interval(params,
-				     SNDRV_PCM_HW_PARAM_PERIOD_SIZE);
 	unsigned int rate = params_rate(params);
 
 	/* 44.1kHz has the same iteration number as 48kHz */
 	rate = (rate == 44100) ? 48000 : rate;
 
 	/* ABE requires chunks of 250us worth of data */
-	return snd_interval_step(period_size, 0, rate / 4000);
+	return snd_interval_step(hw_param_interval(params, rule->var), 0,
+				 rate / 4000);
 }
 
 static int aess_open(struct snd_pcm_substream *substream)
@@ -128,7 +127,7 @@ static int aess_open(struct snd_pcm_substream *substream)
 		 */
 		ret = snd_pcm_hw_rule_add(substream->runtime, 0,
 					SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
-					omap_abe_hwrule_period_step,
+					omap_abe_hwrule_size_step,
 					NULL,
 					SNDRV_PCM_HW_PARAM_PERIOD_SIZE, -1);
 		break;
-- 
1.8.1.1
