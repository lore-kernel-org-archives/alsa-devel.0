From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 4/4] ASoC: omap-mcpdm: Do not use core to set
	msbit constraint
Date: Thu, 19 Jan 2012 19:24:16 +0100
Message-ID: <1326997456-16296-5-git-send-email-peter.ujfalusi@ti.com>
References: <1326997456-16296-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog111.obsmtp.com (na3sys009aog111.obsmtp.com
	[74.125.149.205])
	by alsa0.perex.cz (Postfix) with ESMTP id 650D32439F
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 19:24:44 +0100 (CET)
Received: by mail-gy0-f177.google.com with SMTP id r17so200423ghr.8
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 10:24:43 -0800 (PST)
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
Set the 24msbits constraint in the omap-mcpdm driver for 32
bit samples.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcpdm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index 3970556..50d758a 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -265,6 +265,8 @@ static int omap_mcpdm_dai_startup(struct snd_pcm_substream *substream,
 
 	mutex_lock(&mcpdm->mutex);
 
+	snd_pcm_hw_constraint_msbits(substream->runtime, 0, 32, 24);
+
 	if (!dai->active) {
 		/* Enable watch dog for ES above ES 1.0 to avoid saturation */
 		if (omap_rev() != OMAP4430_REV_ES1_0) {
@@ -419,14 +421,12 @@ static struct snd_soc_dai_driver omap_mcpdm_dai = {
 		.channels_max = 5,
 		.rates = OMAP_MCPDM_RATES,
 		.formats = OMAP_MCPDM_FORMATS,
-		.sig_bits = 24,
 	},
 	.capture = {
 		.channels_min = 1,
 		.channels_max = 3,
 		.rates = OMAP_MCPDM_RATES,
 		.formats = OMAP_MCPDM_FORMATS,
-		.sig_bits = 24,
 	},
 	.ops = &omap_mcpdm_dai_ops,
 };
-- 
1.7.8.3
