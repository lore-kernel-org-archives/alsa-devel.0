From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] soc - s3c24xx - Declare suspend and resume
	static
Date: Tue, 22 Apr 2008 16:12:52 +0100
Message-ID: <1208877172-16537-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1208877172-16537-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208877172-16537-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4D199245C8
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Apr 2008 17:12:54 +0200 (CEST)
In-Reply-To: <1208877172-16537-2-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/s3c24xx/s3c24xx-i2s.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/s3c24xx/s3c24xx-i2s.c
index df71c9d..0de211c 100644
--- a/sound/soc/s3c24xx/s3c24xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c24xx-i2s.c
@@ -412,7 +412,7 @@ static int s3c24xx_i2s_probe(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM
-int s3c24xx_i2s_suspend(struct platform_device *pdev,
+static int s3c24xx_i2s_suspend(struct platform_device *pdev,
 		struct snd_soc_cpu_dai *cpu_dai)
 {
 	DBG("Entered %s\n", __func__);
@@ -427,7 +427,7 @@ int s3c24xx_i2s_suspend(struct platform_device *pdev,
 	return 0;
 }
 
-int s3c24xx_i2s_resume(struct platform_device *pdev,
+static int s3c24xx_i2s_resume(struct platform_device *pdev,
 		struct snd_soc_cpu_dai *cpu_dai)
 {
 	DBG("Entered %s\n", __func__);
-- 
1.5.5
