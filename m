From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 03/11] soc - s3c24xx-i2s - Add missing spaces
Date: Wed, 23 Apr 2008 13:07:57 +0100
Message-ID: <1208952485-20385-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1208952485-20385-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D52F6244CC
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Apr 2008 14:08:07 +0200 (CEST)
In-Reply-To: <1208952485-20385-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c24xx-i2s.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/s3c24xx/s3c24xx-i2s.c
index 36de130..b433297 100644
--- a/sound/soc/s3c24xx/s3c24xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c24xx-i2s.c
@@ -388,7 +388,7 @@ static int s3c24xx_i2s_probe(struct platform_device *pdev)
 	if (s3c24xx_i2s.regs == NULL)
 		return -ENXIO;
 
-	s3c24xx_i2s.iis_clk=clk_get(&pdev->dev, "iis");
+	s3c24xx_i2s.iis_clk = clk_get(&pdev->dev, "iis");
 	if (s3c24xx_i2s.iis_clk == NULL) {
 		DBG("failed to get iis_clock\n");
 		iounmap(s3c24xx_i2s.regs);
-- 
1.5.5.1
