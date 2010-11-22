From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCHv4 05/18] ASoC: Samsung: Rename AC97 platform
	device
Date: Mon, 22 Nov 2010 15:36:00 +0900
Message-ID: <1290407760-29158-1-git-send-email-jassisinghbrar@gmail.com>
References: <1290407690-28917-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D8B2103874
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 07:51:02 +0100 (CET)
In-Reply-To: <1290407690-28917-1-git-send-email-jassisinghbrar@gmail.com>
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
Cc: kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, broonie@opensource.wolfsonmicro.com, june.bae@samsung.com, lrg@slimlogic.co.uk, sw.youn@samsung.com
List-Id: alsa-devel@alsa-project.org

From: Jassi Brar <jassi.brar@samsung.com>

Call the AC97 controller devices found in S3C, S5P and newer
SoCs as 'samsung-ac97' rather than 's3c-ac97'.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s3c64xx/dev-audio.c    |    2 +-
 arch/arm/mach-s5pc100/dev-audio.c    |    2 +-
 arch/arm/mach-s5pv210/dev-audio.c    |    2 +-
 arch/arm/plat-s3c24xx/devs.c         |    2 +-
 sound/soc/s3c24xx/ln2440sbc_alc650.c |    2 +-
 sound/soc/s3c24xx/s3c-ac97.c         |    4 ++--
 sound/soc/s3c24xx/smdk2443_wm9710.c  |    2 +-
 sound/soc/s3c24xx/smdk_wm9713.c      |    2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/dev-audio.c b/arch/arm/mach-s3c64xx/dev-audio.c
index 4a4b8a5..cad6702 100644
--- a/arch/arm/mach-s3c64xx/dev-audio.c
+++ b/arch/arm/mach-s3c64xx/dev-audio.c
@@ -296,7 +296,7 @@ static struct s3c_audio_pdata s3c_ac97_pdata;
 static u64 s3c64xx_ac97_dmamask = DMA_BIT_MASK(32);
 
 struct platform_device s3c64xx_device_ac97 = {
-	.name		  = "s3c-ac97",
+	.name		  = "samsung-ac97",
 	.id		  = -1,
 	.num_resources	  = ARRAY_SIZE(s3c64xx_ac97_resource),
 	.resource	  = s3c64xx_ac97_resource,
diff --git a/arch/arm/mach-s5pc100/dev-audio.c b/arch/arm/mach-s5pc100/dev-audio.c
index 10ab275..ab2d271 100644
--- a/arch/arm/mach-s5pc100/dev-audio.c
+++ b/arch/arm/mach-s5pc100/dev-audio.c
@@ -281,7 +281,7 @@ static struct s3c_audio_pdata s3c_ac97_pdata = {
 static u64 s5pc100_ac97_dmamask = DMA_BIT_MASK(32);
 
 struct platform_device s5pc100_device_ac97 = {
-	.name		  = "s3c-ac97",
+	.name		  = "samsung-ac97",
 	.id		  = -1,
 	.num_resources	  = ARRAY_SIZE(s5pc100_ac97_resource),
 	.resource	  = s5pc100_ac97_resource,
diff --git a/arch/arm/mach-s5pv210/dev-audio.c b/arch/arm/mach-s5pv210/dev-audio.c
index ddd2704..8d58f19 100644
--- a/arch/arm/mach-s5pv210/dev-audio.c
+++ b/arch/arm/mach-s5pv210/dev-audio.c
@@ -311,7 +311,7 @@ static struct s3c_audio_pdata s3c_ac97_pdata = {
 static u64 s5pv210_ac97_dmamask = DMA_BIT_MASK(32);
 
 struct platform_device s5pv210_device_ac97 = {
-	.name		  = "s3c-ac97",
+	.name		  = "samsung-ac97",
 	.id		  = -1,
 	.num_resources	  = ARRAY_SIZE(s5pv210_ac97_resource),
 	.resource	  = s5pv210_ac97_resource,
diff --git a/arch/arm/plat-s3c24xx/devs.c b/arch/arm/plat-s3c24xx/devs.c
index 5987f94..8a42bc4 100644
--- a/arch/arm/plat-s3c24xx/devs.c
+++ b/arch/arm/plat-s3c24xx/devs.c
@@ -484,7 +484,7 @@ static struct resource s3c_ac97_resource[] = {
 static u64 s3c_device_audio_dmamask = 0xffffffffUL;
 
 struct platform_device s3c_device_ac97 = {
-	.name		  = "s3c-ac97",
+	.name		  = "samsung-ac97",
 	.id		  = -1,
 	.num_resources	  = ARRAY_SIZE(s3c_ac97_resource),
 	.resource	  = s3c_ac97_resource,
diff --git a/sound/soc/s3c24xx/ln2440sbc_alc650.c b/sound/soc/s3c24xx/ln2440sbc_alc650.c
index 36e7e85..dda11ac 100644
--- a/sound/soc/s3c24xx/ln2440sbc_alc650.c
+++ b/sound/soc/s3c24xx/ln2440sbc_alc650.c
@@ -32,7 +32,7 @@ static struct snd_soc_dai_link ln2440sbc_dai[] = {
 {
 	.name = "AC97",
 	.stream_name = "AC97 HiFi",
-	.cpu_dai_name = "s3c-ac97",
+	.cpu_dai_name = "samsung-ac97",
 	.codec_dai_name = "ac97-hifi",
 	.codec_name = "ac97-codec",
 	.platform_name = "samsung-audio",
diff --git a/sound/soc/s3c24xx/s3c-ac97.c b/sound/soc/s3c24xx/s3c-ac97.c
index 408f9c9..5352cac 100644
--- a/sound/soc/s3c24xx/s3c-ac97.c
+++ b/sound/soc/s3c24xx/s3c-ac97.c
@@ -497,7 +497,7 @@ static struct platform_driver s3c_ac97_driver = {
 	.probe  = s3c_ac97_probe,
 	.remove = s3c_ac97_remove,
 	.driver = {
-		.name = "s3c-ac97",
+		.name = "samsung-ac97",
 		.owner = THIS_MODULE,
 	},
 };
@@ -517,4 +517,4 @@ module_exit(s3c_ac97_exit);
 MODULE_AUTHOR("Jaswinder Singh, <jassi.brar@samsung.com>");
 MODULE_DESCRIPTION("AC97 driver for the Samsung SoC");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:s3c-ac97");
+MODULE_ALIAS("platform:samsung-ac97");
diff --git a/sound/soc/s3c24xx/smdk2443_wm9710.c b/sound/soc/s3c24xx/smdk2443_wm9710.c
index c50d19c..0205138 100644
--- a/sound/soc/s3c24xx/smdk2443_wm9710.c
+++ b/sound/soc/s3c24xx/smdk2443_wm9710.c
@@ -28,7 +28,7 @@ static struct snd_soc_dai_link smdk2443_dai[] = {
 {
 	.name = "AC97",
 	.stream_name = "AC97 HiFi",
-	.cpu_dai_name = "s3c-ac97",
+	.cpu_dai_name = "samsung-ac97",
 	.codec_dai_name = "ac97-hifi",
 	.codec_name = "ac97-codec",
 	.platform_name = "samsung-audio",
diff --git a/sound/soc/s3c24xx/smdk_wm9713.c b/sound/soc/s3c24xx/smdk_wm9713.c
index 80f2aef..56b448d 100644
--- a/sound/soc/s3c24xx/smdk_wm9713.c
+++ b/sound/soc/s3c24xx/smdk_wm9713.c
@@ -46,7 +46,7 @@ static struct snd_soc_dai_link smdk_dai = {
 	.name = "AC97",
 	.stream_name = "AC97 PCM",
 	.platform_name = "samsung-audio",
-	.cpu_dai_name = "s3c-ac97",
+	.cpu_dai_name = "samsung-ac97",
 	.codec_dai_name = "wm9713-hifi",
 	.codec_name = "wm9713-codec",
 };
-- 
1.6.2.5
