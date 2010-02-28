From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] ALSA: ASoC: pxa-pcm-lib: initialize DMA
	channel to -1
Date: Sun, 28 Feb 2010 10:42:38 +0800
Message-ID: <1267324958-25103-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 134B624566
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2010 17:26:49 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Nicolas Pitre <nico@marvell.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

This fixes a warning ("pxa_free_dma: trying to free channel 0 which is
already freed") when a device was opened but the hw_params() call
failed.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Nicolas Pitre <nico@marvell.com>
---
 sound/arm/pxa2xx-pcm-lib.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/arm/pxa2xx-pcm-lib.c b/sound/arm/pxa2xx-pcm-lib.c
index 743ac6a..fd51fa8 100644
--- a/sound/arm/pxa2xx-pcm-lib.c
+++ b/sound/arm/pxa2xx-pcm-lib.c
@@ -205,6 +205,7 @@ int __pxa2xx_pcm_open(struct snd_pcm_substream *substream)
 	if (!rtd->dma_desc_array)
 		goto err1;
 
+	rtd->dma_ch = -1;
 	runtime->private_data = rtd;
 	return 0;
 
-- 
1.6.3.3
