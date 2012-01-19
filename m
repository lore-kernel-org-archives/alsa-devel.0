From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/4] Revert "ASoC: omap-dmic: Use core to set
	the msbits constraint"
Date: Thu, 19 Jan 2012 19:24:15 +0100
Message-ID: <1326997456-16296-4-git-send-email-peter.ujfalusi@ti.com>
References: <1326997456-16296-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog112.obsmtp.com (na3sys009aog112.obsmtp.com
	[74.125.149.207])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D94A103C5D
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 19:24:42 +0100 (CET)
Received: by mail-yw0-f44.google.com with SMTP id n12so166611yhn.31
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 10:24:41 -0800 (PST)
In-Reply-To: <1326997456-16296-1-git-send-email-peter.ujfalusi@ti.com>
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

The core implementation applies the msbits constraint to samples
where it should not.
Do not ask core to do this, the original code does the right thing.

This reverts commit c50851684cf09444a77f59432f97bbdfb2617908.
---
 sound/soc/omap/omap-dmic.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
index 4dcb5a7..0855c1c 100644
--- a/sound/soc/omap/omap-dmic.c
+++ b/sound/soc/omap/omap-dmic.c
@@ -113,10 +113,12 @@ static int omap_dmic_dai_startup(struct snd_pcm_substream *substream,
 
 	mutex_lock(&dmic->mutex);
 
-	if (!dai->active)
+	if (!dai->active) {
+		snd_pcm_hw_constraint_msbits(substream->runtime, 0, 32, 24);
 		dmic->active = 1;
-	else
+	} else {
 		ret = -EBUSY;
+	}
 
 	mutex_unlock(&dmic->mutex);
 
@@ -443,7 +445,6 @@ static struct snd_soc_dai_driver omap_dmic_dai = {
 		.channels_max = 6,
 		.rates = SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_192000,
 		.formats = SNDRV_PCM_FMTBIT_S32_LE,
-		.sig_bits = 24,
 	},
 	.ops = &omap_dmic_dai_ops,
 };
-- 
1.7.8.3
