From: Javier Martin <javier.martin@vista-silicon.com>
Subject: [PATCH v2 2/4] ASoC: Fix burstsize and DSP_B format
	problems in imx-ssi.
Date: Tue,  1 Mar 2011 15:02:06 +0100
Message-ID: <1298988128-11520-3-git-send-email-javier.martin@vista-silicon.com>
References: <1298988128-11520-1-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 855E81038F0
	for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2011 15:02:31 +0100 (CET)
Received: by mail-ew0-f51.google.com with SMTP id 19so1550700ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 01 Mar 2011 06:02:31 -0800 (PST)
In-Reply-To: <1298988128-11520-1-git-send-email-javier.martin@vista-silicon.com>
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
Cc: s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, b32542@freescale.com, linux-arm-kernel@lists.infradead.org, Javier Martin <javier.martin@vista-silicon.com>
List-Id: alsa-devel@alsa-project.org

When choosing IMX_DMA flag, burtsizes are set to its default
value (0) which leads to driver malfunction. Change them to 4.

DSP_B interface needs additional flag to match DSP_B formats
as described in several codecs as wm8741 and aic3205.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 sound/soc/imx/imx-ssi.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
index 390b6ff..971d3db 100644
--- a/sound/soc/imx/imx-ssi.c
+++ b/sound/soc/imx/imx-ssi.c
@@ -108,7 +108,7 @@ static int imx_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 		break;
 	case SND_SOC_DAIFMT_DSP_B:
 		/* data on rising edge of bclk, frame high with data */
-		strcr |= SSI_STCR_TFSL;
+		strcr |= SSI_STCR_TFSL | SSI_STCR_TXBIT0;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
 		/* data on rising edge of bclk, frame high 1clk before data */
@@ -656,6 +656,9 @@ static int imx_ssi_probe(struct platform_device *pdev)
 	ssi->dma_params_rx.dma_addr = res->start + SSI_SRX0;
 	ssi->dma_params_tx.dma_addr = res->start + SSI_STX0;
 
+	ssi->dma_params_tx.burstsize = 4;
+	ssi->dma_params_rx.burstsize = 4;
+
 	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx0");
 	if (res)
 		ssi->dma_params_tx.dma = res->start;
-- 
1.7.0.4
