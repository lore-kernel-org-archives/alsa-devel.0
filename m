From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] ASoC: Wrong variable returned on error
Date: Tue, 08 Dec 2009 01:34:22 +0100
Message-ID: <4B1D9F0E.4010009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f221.google.com (mail-ew0-f221.google.com
	[209.85.219.221])
	by alsa0.perex.cz (Postfix) with ESMTP id 091E5244C4
	for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2009 01:33:13 +0100 (CET)
Received: by ewy21 with SMTP id 21so2773573ewy.22
	for <alsa-devel@alsa-project.org>; Mon, 07 Dec 2009 16:33:12 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: javier.martin@vista-silicon.com, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundati>
List-Id: alsa-devel@alsa-project.org

The wrong variable was returned in the case of an error

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 sound/soc/imx/mx1_mx2-pcm.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/imx/mx1_mx2-pcm.c b/sound/soc/imx/mx1_mx2-pcm.c
index b838665..bffffcd 100644
--- a/sound/soc/imx/mx1_mx2-pcm.c
+++ b/sound/soc/imx/mx1_mx2-pcm.c
@@ -322,12 +322,12 @@ static int mx1_mx2_pcm_open(struct snd_pcm_substream *substream)
 
 	pr_debug("%s: Requesting dma channel (%s)\n", __func__,
 						prtd->dma_params->name);
-	prtd->dma_ch = imx_dma_request_by_prio(prtd->dma_params->name,
-						DMA_PRIO_HIGH);
-	if (prtd->dma_ch < 0) {
+	ret = imx_dma_request_by_prio(prtd->dma_params->name, DMA_PRIO_HIGH);
+	if (ret < 0) {
 		printk(KERN_ERR "Error %d requesting dma channel\n", ret);
 		return ret;
 	}
+	prtd->dma_ch = ret;
 	imx_dma_config_burstlen(prtd->dma_ch,
 				prtd->dma_params->watermark_level);
