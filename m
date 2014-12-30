From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: davinci-mcasp: Support for combined
	tx/rx interrupt line
Date: Tue, 30 Dec 2014 16:10:32 +0200
Message-ID: <1419948632-18352-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 2898626062F
 for <alsa-devel@alsa-project.org>; Tue, 30 Dec 2014 15:10:38 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, daniel@zonque.org
List-Id: alsa-devel@alsa-project.org

Some SoC, like da850/OMAP-L138 uses one common interrupt request for TX/RX
events.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 30b94d4f9c5d..95eef582331b 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -364,6 +364,20 @@ static irqreturn_t davinci_mcasp_rx_irq_handler(int irq, void *data)
 	return IRQ_RETVAL(handled_mask);
 }
 
+static irqreturn_t davinci_mcasp_common_irq_handler(int irq, void *data)
+{
+	struct davinci_mcasp *mcasp = (struct davinci_mcasp *)data;
+	irqreturn_t ret = IRQ_NONE;
+
+	if (mcasp->substreams[SNDRV_PCM_STREAM_PLAYBACK])
+		ret = davinci_mcasp_tx_irq_handler(irq, data);
+
+	if (mcasp->substreams[SNDRV_PCM_STREAM_CAPTURE])
+		ret |= davinci_mcasp_rx_irq_handler(irq, data);
+
+	return ret;
+}
+
 static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 					 unsigned int fmt)
 {
@@ -1441,6 +1455,22 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 
 	mcasp->dev = &pdev->dev;
 
+	irq = platform_get_irq_byname(pdev, "common");
+	if (irq >= 0) {
+		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_common\n",
+					  dev_name(&pdev->dev));
+		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+						davinci_mcasp_common_irq_handler,
+						IRQF_ONESHOT, irq_name, mcasp);
+		if (ret) {
+			dev_err(&pdev->dev, "common IRQ request failed\n");
+			goto err;
+		}
+
+		mcasp->irq_request[SNDRV_PCM_STREAM_PLAYBACK] = XUNDRN;
+		mcasp->irq_request[SNDRV_PCM_STREAM_CAPTURE] = ROVRN;
+	}
+
 	irq = platform_get_irq_byname(pdev, "rx");
 	if (irq >= 0) {
 		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_rx\n",
-- 
2.2.1
