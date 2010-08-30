From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH RESEND v6 3/3] ARM: S3C24XX: I2S
	multi-component-related fixes
Date: Mon, 30 Aug 2010 11:28:09 +0300
Message-ID: <1283156889-5544-4-git-send-email-anarsoul@gmail.com>
References: <1283156889-5544-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D8A3D243AD
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Aug 2010 10:28:52 +0200 (CEST)
Received: by mail-ey0-f179.google.com with SMTP id 9so2929756eyd.38
	for <alsa-devel@alsa-project.org>; Mon, 30 Aug 2010 01:28:52 -0700 (PDT)
In-Reply-To: <1283156889-5544-1-git-send-email-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel <alsa-devel@alsa-project.org>, Philipp Zabel <philipp.zabel@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>, marek.vasut
List-Id: alsa-devel@alsa-project.org

Export s3c_device_pcm for all S3C24xx-devices, not
only for S3C2440;
Fix device name for s3c_device_iis;

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/plat-s3c24xx/devs.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/devs.c b/arch/arm/plat-s3c24xx/devs.c
index 9f8ee5e..2f91057 100644
--- a/arch/arm/plat-s3c24xx/devs.c
+++ b/arch/arm/plat-s3c24xx/devs.c
@@ -247,7 +247,7 @@ static struct resource s3c_iis_resource[] = {
 static u64 s3c_device_iis_dmamask = 0xffffffffUL;
 
 struct platform_device s3c_device_iis = {
-	.name		  = "s3c2410-iis",
+	.name		  = "s3c24xx-iis",
 	.id		  = -1,
 	.num_resources	  = ARRAY_SIZE(s3c_iis_resource),
 	.resource	  = s3c_iis_resource,
@@ -259,6 +259,21 @@ struct platform_device s3c_device_iis = {
 
 EXPORT_SYMBOL(s3c_device_iis);
 
+/* ASoC PCM DMA */
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
+
+EXPORT_SYMBOL(s3c_device_pcm);
+
 /* RTC */
 
 static struct resource s3c_rtc_resource[] = {
@@ -481,8 +496,6 @@ static struct resource s3c_ac97_resource[] = {
 	},
 };
 
-static u64 s3c_device_audio_dmamask = 0xffffffffUL;
-
 struct platform_device s3c_device_ac97 = {
 	.name		  = "s3c-ac97",
 	.id		  = -1,
@@ -496,19 +509,6 @@ struct platform_device s3c_device_ac97 = {
 
 EXPORT_SYMBOL(s3c_device_ac97);
 
-/* ASoC PCM DMA */
-
-struct platform_device s3c_device_pcm = {
-	.name		  = "s3c24xx-pcm-audio",
-	.id		  = -1,
-	.dev              = {
-		.dma_mask = &s3c_device_audio_dmamask,
-		.coherent_dma_mask = 0xffffffffUL
-	}
-};
-
-EXPORT_SYMBOL(s3c_device_pcm);
-
 /* ASoC I2S */
 
 struct platform_device s3c2412_device_iis = {
-- 
1.7.2
