From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 3/5] ASoC: omap-mcpdm: Set 24msbits
	constraint
Date: Wed, 18 Jan 2012 12:18:24 +0100
Message-ID: <1326885506-6140-4-git-send-email-peter.ujfalusi@ti.com>
References: <1326885506-6140-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog117.obsmtp.com (na3sys009aog117.obsmtp.com
	[74.125.149.242])
	by alsa0.perex.cz (Postfix) with ESMTP id A9BA0103B3F
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 12:18:48 +0100 (CET)
Received: by mail-yx0-f169.google.com with SMTP id m10so2663204yen.14
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 03:18:47 -0800 (PST)
In-Reply-To: <1326885506-6140-1-git-send-email-peter.ujfalusi@ti.com>
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

McPDM internal FIFO is 24 bit wide. From the 32 bit sample
8 bit is discarded. Let application know about this
via msbits constraint.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcpdm.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index 0e25df4..3970556 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -419,12 +419,14 @@ static struct snd_soc_dai_driver omap_mcpdm_dai = {
 		.channels_max = 5,
 		.rates = OMAP_MCPDM_RATES,
 		.formats = OMAP_MCPDM_FORMATS,
+		.sig_bits = 24,
 	},
 	.capture = {
 		.channels_min = 1,
 		.channels_max = 3,
 		.rates = OMAP_MCPDM_RATES,
 		.formats = OMAP_MCPDM_FORMATS,
+		.sig_bits = 24,
 	},
 	.ops = &omap_mcpdm_dai_ops,
 };
-- 
1.7.8.3
