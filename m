From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Fix a typo in s3c24xx_simtec_tlv320aic23
	driver
Date: Wed, 07 Dec 2011 18:04:10 +0800
Message-ID: <1323252250.27710.7.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 32A5B103862
	for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2011 11:04:20 +0100 (CET)
Received: by ghbg15 with SMTP id g15so303145ghb.38
	for <alsa-devel@alsa-project.org>; Wed, 07 Dec 2011 02:04:17 -0800 (PST)
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
Cc: Sangbeom Kim <sbkim73@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Ben Dooks <ben-linux@fluff.org>
List-Id: alsa-devel@alsa-project.org

Fix a typo introduced by commit e00c3f55
"ASoC: Convert Samsung directory to module_platform_driver".

This fixes the build error:
  CC      sound/soc/samsung/s3c24xx_simtec_tlv320aic23.o
sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c: In function 'simtec_audio_tlv320aic32_driver_init':
sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c:105: error: 'simtec_audio_tlv320aic32_driver' undeclared (first use in this function)
sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c:105: error: (Each undeclared identifier is reported only once
sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c:105: error: for each function it appears in.)
sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c: In function 'simtec_audio_tlv320aic32_driver_exit':
sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c:105: error: 'simtec_audio_tlv320aic32_driver' undeclared (first use in this function)
make[3]: *** [sound/soc/samsung/s3c24xx_simtec_tlv320aic23.o] Error 1
make[2]: *** [sound/soc/samsung] Error 2
make[1]: *** [sound/soc] Error 2
make: *** [sound] Error 2

I think we had better naming it with *driver, thus I change
it to simtec_audio_tlv320aic23_driver.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c b/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
index 7324609..89b57b5 100644
--- a/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
+++ b/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
@@ -92,7 +92,7 @@ static int __devinit simtec_audio_tlv320aic23_probe(struct platform_device *pd)
 	return simtec_audio_core_probe(pd, &snd_soc_machine_simtec_aic23);
 }
 
-static struct platform_driver simtec_audio_tlv320aic23_platdrv = {
+static struct platform_driver simtec_audio_tlv320aic23_driver = {
 	.driver	= {
 		.owner	= THIS_MODULE,
 		.name	= "s3c24xx-simtec-tlv320aic23",
@@ -102,7 +102,7 @@ static struct platform_driver simtec_audio_tlv320aic23_platdrv = {
 	.remove	= __devexit_p(simtec_audio_remove),
 };
 
-module_platform_driver(simtec_audio_tlv320aic32_driver);
+module_platform_driver(simtec_audio_tlv320aic23_driver);
 
 MODULE_ALIAS("platform:s3c24xx-simtec-tlv320aic23");
 MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
-- 
1.7.5.4
