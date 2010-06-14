From: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
Subject: [PATCH] ASoC: DaVinci: Fix McASP hardware FIFO
	configuration
Date: Mon, 14 Jun 2010 11:44:26 +0530
Message-ID: <1276496066-4489-1-git-send-email-sudhakar.raj@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id A008524620
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jun 2010 08:23:05 +0200 (CEST)
Received: from dflp53.itg.ti.com ([128.247.5.6])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o5E6N4kZ008849
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Mon, 14 Jun 2010 01:23:04 -0500
Received: from tidmzi-ftp.india.ext.ti.com (localhost [127.0.0.1])
	by dflp53.itg.ti.com (8.13.8/8.13.8) with SMTP id o5E6N2n8029745
	for <alsa-devel@alsa-project.org>; Mon, 14 Jun 2010 01:23:03 -0500 (CDT)
Received: from symphonyindia.ti.com (symphony-ftp [192.168.247.11])
	by tidmzi-ftp.india.ext.ti.com (Postfix) with SMTP id F1AB638874
	for <alsa-devel@alsa-project.org>; Mon, 14 Jun 2010 11:49:23 +0530 (IST)
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
Cc: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
List-Id: alsa-devel@alsa-project.org

On DA830/OMAP-L137 and DA850/OMAP-L138 SoCs, the McASP peripheral
has FIFO support. This FIFO provides additional data buffering. It
also provides tolerance to variation in host/DMA controller response
times. More details of the FIFO operation can be found at

http://focus.ti.com/general/docs/lit/getliterature.tsp?literatureNumber=sprufm1&fileType=pdf

Existing sequence of steps for audio playback/capture are:
a. DMA configuration
b. McASP configuration (configures and enables FIFO)
c. Start DMA
d. Start McASP (enables FIFO)

During McASP configuration, while FIFO was being configured, FIFO
was being enabled in davinci_hw_common_param() function of
sound/soc/davinci/davinci-mcasp.c file. This generated a transmit
DMA event, which gets serviced when DMA is started.

https://patchwork.kernel.org/patch/84611/ patch clears the DMA
events before starting DMA, which is the right thing to do. But
this resulted in a state where DMA was waiting for an event from
McASP (after step c above), but the event which was already there,
has got cleared (because of step b above).

The fix is not to enable the FIFO during McASP configuration as
FIFO was being enabled as part of McASP start.

Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
---
Applies to latest of Linus's tree.

 sound/soc/davinci/davinci-mcasp.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 79f0f4a..d395509 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -612,7 +612,6 @@ static void davinci_hw_common_param(struct davinci_audio_dev *dev, int stream)
 								NUMDMA_MASK);
 		mcasp_mod_bits(dev->base + DAVINCI_MCASP_WFIFOCTL,
 				((dev->txnumevt * tx_ser) << 8), NUMEVT_MASK);
-		mcasp_set_bits(dev->base + DAVINCI_MCASP_WFIFOCTL, FIFO_ENABLE);
 	}
 
 	if (dev->rxnumevt && stream == SNDRV_PCM_STREAM_CAPTURE) {
@@ -623,7 +622,6 @@ static void davinci_hw_common_param(struct davinci_audio_dev *dev, int stream)
 								NUMDMA_MASK);
 		mcasp_mod_bits(dev->base + DAVINCI_MCASP_RFIFOCTL,
 				((dev->rxnumevt * rx_ser) << 8), NUMEVT_MASK);
-		mcasp_set_bits(dev->base + DAVINCI_MCASP_RFIFOCTL, FIFO_ENABLE);
 	}
 }
 
-- 
1.5.6
