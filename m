From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: [PATCH v2 8/9] snd-atmel-ac97c: replace bus_id with
	dev_name()
Date: Thu,  2 Apr 2009 08:21:17 +0200
Message-ID: <1238653278-2546-8-git-send-email-hans-christian.egtvedt@atmel.com>
References: <1238653278-2546-1-git-send-email-hans-christian.egtvedt@atmel.com>
	<1238653278-2546-2-git-send-email-hans-christian.egtvedt@atmel.com>
	<1238653278-2546-3-git-send-email-hans-christian.egtvedt@atmel.com>
	<1238653278-2546-4-git-send-email-hans-christian.egtvedt@atmel.com>
	<1238653278-2546-5-git-send-email-hans-christian.egtvedt@atmel.com>
	<1238653278-2546-6-git-send-email-hans-christian.egtvedt@atmel.com>
	<1238653278-2546-7-git-send-email-hans-christian.egtvedt@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (relay.atmel.no [80.232.32.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F3E324435
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 08:21:19 +0200 (CEST)
In-Reply-To: <1238653278-2546-7-git-send-email-hans-christian.egtvedt@atmel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
List-Id: alsa-devel@alsa-project.org

This patch replaces the references to bus_id to the new dev_name() API.

Signed-off-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
---
 sound/atmel/ac97c.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index 4df9ca4..0c0f877 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -856,7 +856,7 @@ static int __devinit atmel_ac97c_probe(struct platform_device *pdev)
 		chip->dma.rx_chan = dma_request_channel(mask, filter, dws);
 
 		dev_info(&chip->pdev->dev, "using %s for DMA RX\n",
-					chip->dma.rx_chan->dev->device.bus_id);
+				dev_name(&chip->dma.rx_chan->dev->device));
 		set_bit(DMA_RX_CHAN_PRESENT, &chip->flags);
 	}
 
@@ -872,7 +872,7 @@ static int __devinit atmel_ac97c_probe(struct platform_device *pdev)
 		chip->dma.tx_chan = dma_request_channel(mask, filter, dws);
 
 		dev_info(&chip->pdev->dev, "using %s for DMA TX\n",
-					chip->dma.tx_chan->dev->device.bus_id);
+				dev_name(&chip->dma.tx_chan->dev->device));
 		set_bit(DMA_TX_CHAN_PRESENT, &chip->flags);
 	}
 
-- 
1.5.6.3
