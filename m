From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 4/7] ASoC: omap-dmic: Use core to set the
	msbits constraint
Date: Wed, 18 Jan 2012 10:44:52 +0100
Message-ID: <1326879895-2973-5-git-send-email-peter.ujfalusi@ti.com>
References: <1326879895-2973-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id F3BAF103AA3
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 10:45:44 +0100 (CET)
Received: by yenl5 with SMTP id l5so52603yen.17
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 01:45:43 -0800 (PST)
In-Reply-To: <1326879895-2973-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Core can set the msbits constraint in behalf of the dai.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-dmic.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
index 0855c1c..4dcb5a7 100644
--- a/sound/soc/omap/omap-dmic.c
+++ b/sound/soc/omap/omap-dmic.c
@@ -113,12 +113,10 @@ static int omap_dmic_dai_startup(struct snd_pcm_substream *substream,
 
 	mutex_lock(&dmic->mutex);
 
-	if (!dai->active) {
-		snd_pcm_hw_constraint_msbits(substream->runtime, 0, 32, 24);
+	if (!dai->active)
 		dmic->active = 1;
-	} else {
+	else
 		ret = -EBUSY;
-	}
 
 	mutex_unlock(&dmic->mutex);
 
@@ -445,6 +443,7 @@ static struct snd_soc_dai_driver omap_dmic_dai = {
 		.channels_max = 6,
 		.rates = SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_192000,
 		.formats = SNDRV_PCM_FMTBIT_S32_LE,
+		.sig_bits = 24,
 	},
 	.ops = &omap_dmic_dai_ops,
 };
-- 
1.7.8.3
