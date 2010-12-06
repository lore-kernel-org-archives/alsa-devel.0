From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCH 2/2] ASoC: omap: Stop DMA re enabling in self
	linkage mode
Date: Mon, 6 Dec 2010 16:34:47 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCEA4C52E81@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id EAD55103902
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2010 23:34:49 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Hari Nagalla <hnagalla@ti.com>

While using self linking, there is a chance that the DMA
has re-enabled the channel just after disabling it.

This patch stops the OMAP4 DMA re-enabling after stoping the
DMA channel.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
---
 sound/soc/omap/omap-pcm.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 6a21447..afe91ad 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -234,6 +234,13 @@ static int omap_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		prtd->period_index = -1;
 		omap_stop_dma(prtd->dma_ch);
+		/*
+		 * Since we are using self linking, there is a
+		 * chance that the DMA as re-enabled the channel
+		 * just after disabling it.
+		 */
+		while (omap_get_dma_active_status(prtd->dma_ch))
+			omap_stop_dma(prtd->dma_ch);
 		break;
 	default:
 		ret = -EINVAL;
-- 
1.7.0.4
