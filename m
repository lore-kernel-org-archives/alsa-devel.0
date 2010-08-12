From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/5] S3C64XX: Add missing S3C64XX DMA device
Date: Thu, 12 Aug 2010 11:02:20 +0100
Message-ID: <1281607342-13127-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1281607342-13127-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6B1351038B1
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Aug 2010 12:02:27 +0200 (CEST)
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
 arch/arm/mach-s3c64xx/dev-audio.c         |   13 +++++++++++++
 arch/arm/plat-samsung/include/plat/devs.h |    2 ++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/dev-audio.c b/arch/arm/mach-s3c64xx/dev-audio.c
index c3e9e73..55ae1b0 100644
--- a/arch/arm/mach-s3c64xx/dev-audio.c
+++ b/arch/arm/mach-s3c64xx/dev-audio.c
@@ -333,3 +333,16 @@ void __init s3c64xx_ac97_setup_gpio(int num)
 	else
 		s3c_ac97_pdata.cfg_gpio = s3c64xx_ac97_cfg_gpe;
 }
+
+static u64 s3c_device_audio_dmamask = 0xffffffffUL;
+
+struct platform_device s3c_device_pcm = {
+	.name		  = "s3c24xx-pcm-audio",
+	.id		  = -1,
+	.dev              = {
+		.dma_mask = &s3c_device_audio_dmamask,
+		.coherent_dma_mask = 0xffffffffUL
+	}
+};
+EXPORT_SYMBOL(s3c_device_pcm);
+
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index e6144e4..9ea6786 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -32,6 +32,8 @@ extern struct platform_device s3c64xx_device_iisv4;
 extern struct platform_device s3c64xx_device_spi0;
 extern struct platform_device s3c64xx_device_spi1;
 
+extern struct platform_device s3c_device_pcm;
+
 extern struct platform_device s3c64xx_device_pcm0;
 extern struct platform_device s3c64xx_device_pcm1;
 
-- 
1.7.1
