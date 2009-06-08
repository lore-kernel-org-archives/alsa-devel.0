From: chaithrika@ti.com
Subject: [PATCH] ARM: DaVinci: ASoc: Minor fixes to probe
	function
Date: Mon,  8 Jun 2009 06:49:41 -0400
Message-ID: <1244458181-19101-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F4E010383C
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 13:29:12 +0200 (CEST)
Received: from dflp53.itg.ti.com ([128.247.5.6])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n58BT6Dr009495
	for <alsa-devel@alsa-project.org>; Mon, 8 Jun 2009 06:29:11 -0500
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
Cc: Chaithrika U S <chaithrika@ti.com>, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

From: Chaithrika U S <chaithrika@ti.com>

Assign proper errors when platform resource claims fail.

Signed-off-by: Chaithrika U S <chaithrika@ti.com>
---
Applies to branch 'davinci' of:
	git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git

 sound/soc/davinci/davinci-i2s.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index 500d2f5..2f11970 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -469,7 +469,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 	struct snd_platform_data *pdata = pdev->dev.platform_data;
 	struct davinci_mcbsp_dev *dev;
 	struct resource *mem, *ioarea, *res;
-	int ret = 0;
+	int ret;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem) {
@@ -511,6 +511,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "no DMA resource\n");
+		ret = -ENXIO;
 		goto err_free_mem;
 	}
 	dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK]->channel = res->start;
@@ -518,6 +519,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
 	if (!res) {
 		dev_err(&pdev->dev, "no DMA resource\n");
+		ret = -ENXIO;
 		goto err_free_mem;
 	}
 	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE]->channel = res->start;
-- 
1.5.6
