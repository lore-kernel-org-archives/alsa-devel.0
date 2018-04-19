From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 61/61] ASoC: atmel: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:06:31 +0200
Message-ID: <20180419140641.27926-62-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 58E832675CD
 for <alsa-devel@alsa-project.org>; Thu, 19 Apr 2018 16:07:16 +0200 (CEST)
In-Reply-To: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy. Please apply individually.

 sound/soc/atmel/atmel_ssc_dai.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index a1e2c5682dcd..4a0275a6505d 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -1002,8 +1002,7 @@ static const struct snd_soc_component_driver atmel_ssc_component = {
 
 static int asoc_ssc_init(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct ssc_device *ssc = platform_get_drvdata(pdev);
+	struct ssc_device *ssc = dev_get_drvdata(dev);
 	int ret;
 
 	ret = snd_soc_register_component(dev, &atmel_ssc_component,
@@ -1033,8 +1032,7 @@ static int asoc_ssc_init(struct device *dev)
 
 static void asoc_ssc_exit(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct ssc_device *ssc = platform_get_drvdata(pdev);
+	struct ssc_device *ssc = dev_get_drvdata(dev);
 
 	if (ssc->pdata->use_dma)
 		atmel_pcm_dma_platform_unregister(dev);
-- 
2.11.0
