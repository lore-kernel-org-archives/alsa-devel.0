From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ARM: S3C64XX: Fix fallthrough bug in i2sv3
	gpio configuration, improve logging
Date: Thu, 26 Aug 2010 16:07:23 +0100
Message-ID: <1282835243-20493-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7B3902498C
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Aug 2010 17:07:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

If the platform device id is 1, the code will fallthrough the
case and incorrectly return -EINVAL. Add a break to avoid fallthrough.

Make logging slightly more verbose by including the device id.

This is a fix for a change in ASoC multi-component as well.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/dev-audio.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/dev-audio.c b/arch/arm/mach-s3c64xx/dev-audio.c
index f094258..3838335 100644
--- a/arch/arm/mach-s3c64xx/dev-audio.c
+++ b/arch/arm/mach-s3c64xx/dev-audio.c
@@ -43,8 +43,10 @@ static int s3c64xx_i2sv3_cfg_gpio(struct platform_device *pdev)
 		s3c_gpio_cfgpin(S3C64XX_GPE(2), S3C64XX_GPE2_I2S1_LRCLK);
 		s3c_gpio_cfgpin(S3C64XX_GPE(3), S3C64XX_GPE3_I2S1_DI);
 		s3c_gpio_cfgpin(S3C64XX_GPE(4), S3C64XX_GPE4_I2S1_D0);
+		break;
 	default:
-		printk(KERN_DEBUG "Invalid I2S Controller number!");
+		printk(KERN_DEBUG "Invalid I2S Controller number: %d\n",
+			pdev->id);
 		return -EINVAL;
 	}
 
@@ -184,7 +186,8 @@ static int s3c64xx_pcm_cfg_gpio(struct platform_device *pdev)
 		s3c_gpio_cfgpin(S3C64XX_GPE(4), S3C64XX_GPE4_PCM1_SOUT);
 		break;
 	default:
-		printk(KERN_DEBUG "Invalid PCM Controller number!");
+		printk(KERN_DEBUG "Invalid PCM Controller number: %d\n",
+			pdev->id);
 		return -EINVAL;
 	}
 
-- 
1.7.2.2
