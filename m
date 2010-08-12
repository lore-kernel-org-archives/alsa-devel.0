From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/5] ASoC: Fix indentiation in S3C DMA driver
Date: Thu, 12 Aug 2010 11:02:22 +0100
Message-ID: <1281607342-13127-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1281607342-13127-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0A2A21038D4
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Aug 2010 12:02:28 +0200 (CEST)
In-Reply-To: <1281607342-13127-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c-dma.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c-dma.c b/sound/soc/s3c24xx/s3c-dma.c
index bb8ba07..54bff83 100644
--- a/sound/soc/s3c24xx/s3c-dma.c
+++ b/sound/soc/s3c24xx/s3c-dma.c
@@ -477,8 +477,8 @@ static int __devexit s3c24xx_soc_platform_remove(struct platform_device *pdev)
 
 static struct platform_driver s3c24xx_pcm_driver = {
 	.driver = {
-			.name = "s3c24xx-pcm-audio",
-			.owner = THIS_MODULE,
+		.name = "s3c24xx-pcm-audio",
+		.owner = THIS_MODULE,
 	},
 
 	.probe = s3c24xx_soc_platform_probe,
-- 
1.7.1
