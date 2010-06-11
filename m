From: Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ASoC: DaVinci: Fix McASP hardware FIFO configuration
Date: Fri, 11 Jun 2010 19:24:51 +0530
Message-ID: <1276264491-4942-1-git-send-email-sudhakar.raj@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
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

Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org>
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
