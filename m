From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 03/25] ASoC: Samsung: Rename DMA device
Date: Tue, 19 Oct 2010 16:05:16 +0900
Message-ID: <1287471916-25850-1-git-send-email-jassisinghbrar@gmail.com>
References: <1P85Z9-0007a6-27>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id B735C103933
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 09:12:40 +0200 (CEST)
In-Reply-To: <1P85Z9-0007a6-27>
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
Cc: kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, broonie@opensource.wolfsonmicro.com, ben-linux@fluff.org, june.bae@samsung.com, lrg@slimlogic.co.uk, sw.youn@samsung.com
List-Id: alsa-devel@alsa-project.org

From: Jassi Brar <jassi.brar@samsung.com>

Some Samsung SoCs have a PCM(DSP) controller. So the name
s3c24xx-pcm-audio for DMA driver is not very appropraite.
This patch moves :-
	s3c24xx-pcm-audio -> samsung-audio

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s3c64xx/dev-audio.c              |    2 +-
 arch/arm/plat-s3c24xx/devs.c                   |    2 +-
 sound/soc/s3c24xx/goni_wm8994.c                |    4 ++--
 sound/soc/s3c24xx/jive_wm8750.c                |    2 +-
 sound/soc/s3c24xx/ln2440sbc_alc650.c           |    2 +-
 sound/soc/s3c24xx/neo1973_gta02_wm8753.c       |    4 ++--
 sound/soc/s3c24xx/neo1973_wm8753.c             |    4 ++--
 sound/soc/s3c24xx/rx1950_uda1380.c             |    2 +-
 sound/soc/s3c24xx/s3c-dma.c                    |    4 ++--
 sound/soc/s3c24xx/s3c24xx_simtec_hermes.c      |    2 +-
 sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c |    2 +-
 sound/soc/s3c24xx/s3c24xx_uda134x.c            |    2 +-
 sound/soc/s3c24xx/smartq_wm8987.c              |    2 +-
 sound/soc/s3c24xx/smdk2443_wm9710.c            |    2 +-
 sound/soc/s3c24xx/smdk64xx_wm8580.c            |    4 ++--
 sound/soc/s3c24xx/smdk_spdif.c                 |    2 +-
 sound/soc/s3c24xx/smdk_wm9713.c                |    2 +-
 17 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/dev-audio.c b/arch/arm/mach-s3c64xx/dev-audio.c
index 3838335..c45cc37 100644
--- a/arch/arm/mach-s3c64xx/dev-audio.c
+++ b/arch/arm/mach-s3c64xx/dev-audio.c
@@ -340,7 +340,7 @@ void __init s3c64xx_ac97_setup_gpio(int num)
 static u64 s3c_device_audio_dmamask = 0xffffffffUL;
 
 struct platform_device s3c_device_pcm = {
-	.name		  = "s3c24xx-pcm-audio",
+	.name		  = "samsung-audio",
 	.id		  = -1,
 	.dev              = {
 		.dma_mask = &s3c_device_audio_dmamask,
diff --git a/arch/arm/plat-s3c24xx/devs.c b/arch/arm/plat-s3c24xx/devs.c
index 2f91057..4bf0b39 100644
--- a/arch/arm/plat-s3c24xx/devs.c
+++ b/arch/arm/plat-s3c24xx/devs.c
@@ -264,7 +264,7 @@ EXPORT_SYMBOL(s3c_device_iis);
 static u64 s3c_device_audio_dmamask = 0xffffffffUL;
 
 struct platform_device s3c_device_pcm = {
-	.name		  = "s3c24xx-pcm-audio",
+	.name		  = "samsung-audio",
 	.id		  = -1,
 	.dev              = {
 		.dma_mask = &s3c_device_audio_dmamask,
diff --git a/sound/soc/s3c24xx/goni_wm8994.c b/sound/soc/s3c24xx/goni_wm8994.c
index ef22f14..c568f69 100644
--- a/sound/soc/s3c24xx/goni_wm8994.c
+++ b/sound/soc/s3c24xx/goni_wm8994.c
@@ -251,7 +251,7 @@ static struct snd_soc_dai_link goni_dai[] = {
 	.stream_name = "WM8994 HiFi",
 	.cpu_dai_name = "s3c64xx-i2s-v4",
 	.codec_dai_name = "wm8994-hifi",
-	.platform_name = "s3c24xx-pcm-audio",
+	.platform_name = "samsung-audio",
 	.codec_name = "wm8994-codec.0-0x1a",
 	.init = goni_wm8994_init,
 	.ops = &goni_hifi_ops,
@@ -260,7 +260,7 @@ static struct snd_soc_dai_link goni_dai[] = {
 	.stream_name = "Voice",
 	.cpu_dai_name = "goni-voice-dai",
 	.codec_dai_name = "wm8994-voice",
-	.platform_name = "s3c24xx-pcm-audio",
+	.platform_name = "samsung-audio",
 	.codec_name = "wm8994-codec.0-0x1a",
 	.ops = &goni_voice_ops,
 },
diff --git a/sound/soc/s3c24xx/jive_wm8750.c b/sound/soc/s3c24xx/jive_wm8750.c
index 49605cd..7a6b0fa 100644
--- a/sound/soc/s3c24xx/jive_wm8750.c
+++ b/sound/soc/s3c24xx/jive_wm8750.c
@@ -141,7 +141,7 @@ static struct snd_soc_dai_link jive_dai = {
 	.stream_name	= "WM8750",
 	.cpu_dai_name	= "s3c2412-i2s",
 	.codec_dai_name = "wm8750-hifi",
-	.platform_name	= "s3c24xx-pcm-audio",
+	.platform_name	= "samsung-audio",
 	.codec_name	= "wm8750-codec.0-0x1a",
 	.init		= jive_wm8750_init,
 	.ops		= &jive_ops,
diff --git a/sound/soc/s3c24xx/ln2440sbc_alc650.c b/sound/soc/s3c24xx/ln2440sbc_alc650.c
index abe64ab..6b7bb38 100644
--- a/sound/soc/s3c24xx/ln2440sbc_alc650.c
+++ b/sound/soc/s3c24xx/ln2440sbc_alc650.c
@@ -35,7 +35,7 @@ static struct snd_soc_dai_link ln2440sbc_dai[] = {
 	.cpu_dai_name = "s3c-ac97",
 	.codec_dai_name = "ac97-hifi",
 	.codec_name = "ac97-codec",
-	.platform_name = "s3c24xx-pcm-audio",
+	.platform_name = "samsung-audio",
 },
 };
 
diff --git a/sound/soc/s3c24xx/neo1973_gta02_wm8753.c b/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
index c457bfd..a9a4bbb 100644
--- a/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
@@ -400,7 +400,7 @@ static struct snd_soc_dai_link neo1973_gta02_dai[] = {
 	.cpu_dai_name = "s3c24xx-i2s",
 	.codec_dai_name = "wm8753-hifi",
 	.init = neo1973_gta02_wm8753_init,
-	.platform_name = "s3c24xx-pcm-audio",
+	.platform_name = "samsung-audio",
 	.codec_name = "wm8753-codec.0-0x1a",
 	.ops = &neo1973_gta02_hifi_ops,
 },
@@ -411,7 +411,7 @@ static struct snd_soc_dai_link neo1973_gta02_dai[] = {
 	.codec_dai_name = "wm8753-voice",
 	.ops = &neo1973_gta02_voice_ops,
 	.codec_name = "wm8753-codec.0-0x1a",
-	.platform_name = "s3c24xx-pcm-audio",
+	.platform_name = "samsung-audio",
 },
 };
 
diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
index d7a39a0..d5e4148 100644
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -556,7 +556,7 @@ static struct snd_soc_dai_link neo1973_dai[] = {
 { /* Hifi Playback - for similatious use with voice below */
 	.name = "WM8753",
 	.stream_name = "WM8753 HiFi",
-	.platform_name = "s3c24xx-pcm-audio",
+	.platform_name = "samsung-audio",
 	.cpu_dai_name = "s3c24xx-i2s",
 	.codec_dai_name = "wm8753-hifi",
 	.codec_name = "wm8753-codec.0-0x1a",
@@ -566,7 +566,7 @@ static struct snd_soc_dai_link neo1973_dai[] = {
 { /* Voice via BT */
 	.name = "Bluetooth",
 	.stream_name = "Voice",
-	.platform_name = "s3c24xx-pcm-audio",
+	.platform_name = "samsung-audio",
 	.cpu_dai_name = "bluetooth-dai",
 	.codec_dai_name = "wm8753-voice",
 	.codec_name = "wm8753-codec.0-0x1a",
diff --git a/sound/soc/s3c24xx/rx1950_uda1380.c b/sound/soc/s3c24xx/rx1950_uda1380.c
index ffd5cf2..99bb86e 100644
--- a/sound/soc/s3c24xx/rx1950_uda1380.c
+++ b/sound/soc/s3c24xx/rx1950_uda1380.c
@@ -96,7 +96,7 @@ static struct snd_soc_dai_link rx1950_uda1380_dai[] = {
 		.cpu_dai_name	= "s3c24xx-iis",
 		.codec_dai_name	= "uda1380-hifi",
 		.init		= rx1950_uda1380_init,
-		.platform_name	= "s3c24xx-pcm-audio",
+		.platform_name	= "samsung-audio",
 		.codec_name	= "uda1380-codec.0-001a",
 		.ops		= &rx1950_ops,
 	},
diff --git a/sound/soc/s3c24xx/s3c-dma.c b/sound/soc/s3c24xx/s3c-dma.c
index 54bff83..0c1cd6c 100644
--- a/sound/soc/s3c24xx/s3c-dma.c
+++ b/sound/soc/s3c24xx/s3c-dma.c
@@ -477,7 +477,7 @@ static int __devexit s3c24xx_soc_platform_remove(struct platform_device *pdev)
 
 static struct platform_driver s3c24xx_pcm_driver = {
 	.driver = {
-		.name = "s3c24xx-pcm-audio",
+		.name = "samsung-audio",
 		.owner = THIS_MODULE,
 	},
 
@@ -500,4 +500,4 @@ module_exit(snd_s3c24xx_pcm_exit);
 MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
 MODULE_DESCRIPTION("Samsung S3C Audio DMA module");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:s3c24xx-pcm-audio");
+MODULE_ALIAS("platform:samsung-audio");
diff --git a/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c b/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
index f884537..5180c2a 100644
--- a/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
+++ b/sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
@@ -99,7 +99,7 @@ static struct snd_soc_dai_link simtec_dai_aic33 = {
 	.codec_name	= "tlv320aic3x-codec.0-0x1a",
 	.cpu_dai_name	= "s3c24xx-i2s",
 	.codec_dai_name = "tlv320aic3x-hifi",
-	.platform_name	= "s3c24xx-pcm-audio",
+	.platform_name	= "samsung-audio",
 	.init		= simtec_hermes_init,
 };
 
diff --git a/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c b/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
index c096759..7a7bb53 100644
--- a/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
+++ b/sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
@@ -88,7 +88,7 @@ static struct snd_soc_dai_link simtec_dai_aic23 = {
 	.codec_name	= "tlv320aic3x-codec.0-0x1a",
 	.cpu_dai_name	= "s3c24xx-i2s",
 	.codec_dai_name = "tlv320aic3x-hifi",
-	.platform_name	= "s3c24xx-pcm-audio",
+	.platform_name	= "samsung-audio",
 	.init		= simtec_tlv320aic23_init,
 };
 
diff --git a/sound/soc/s3c24xx/s3c24xx_uda134x.c b/sound/soc/s3c24xx/s3c24xx_uda134x.c
index bd48ffb..50d44fa 100644
--- a/sound/soc/s3c24xx/s3c24xx_uda134x.c
+++ b/sound/soc/s3c24xx/s3c24xx_uda134x.c
@@ -231,7 +231,7 @@ static struct snd_soc_dai_link s3c24xx_uda134x_dai_link = {
 	.codec_dai_name = "uda134x-hifi",
 	.cpu_dai_name = "s3c24xx-i2s",
 	.ops = &s3c24xx_uda134x_ops,
-	.platform_name	= "s3c24xx-pcm-audio",
+	.platform_name	= "samsung-audio",
 };
 
 static struct snd_soc_card snd_soc_s3c24xx_uda134x = {
diff --git a/sound/soc/s3c24xx/smartq_wm8987.c b/sound/soc/s3c24xx/smartq_wm8987.c
index dd20ca7..863631a 100644
--- a/sound/soc/s3c24xx/smartq_wm8987.c
+++ b/sound/soc/s3c24xx/smartq_wm8987.c
@@ -213,7 +213,7 @@ static struct snd_soc_dai_link smartq_dai[] = {
 		.stream_name	= "SmartQ Hi-Fi",
 		.cpu_dai_name	= "s3c64xx-i2s.0",
 		.codec_dai_name	= "wm8750-hifi",
-		.platform_name	= "s3c24xx-pcm-audio",
+		.platform_name	= "samsung-audio",
 		.codec_name	= "wm8750-codec.0-0x1a",
 		.init		= smartq_wm8987_init,
 		.ops		= &smartq_hifi_ops,
diff --git a/sound/soc/s3c24xx/smdk2443_wm9710.c b/sound/soc/s3c24xx/smdk2443_wm9710.c
index 4613288..911bb60 100644
--- a/sound/soc/s3c24xx/smdk2443_wm9710.c
+++ b/sound/soc/s3c24xx/smdk2443_wm9710.c
@@ -31,7 +31,7 @@ static struct snd_soc_dai_link smdk2443_dai[] = {
 	.cpu_dai_name = "s3c-ac97",
 	.codec_dai_name = "ac97-hifi",
 	.codec_name = "ac97-codec",
-	.platform_name = "s3c24xx-pcm-audio",
+	.platform_name = "samsung-audio",
 },
 };
 
diff --git a/sound/soc/s3c24xx/smdk64xx_wm8580.c b/sound/soc/s3c24xx/smdk64xx_wm8580.c
index 052e499..7e75c8d 100644
--- a/sound/soc/s3c24xx/smdk64xx_wm8580.c
+++ b/sound/soc/s3c24xx/smdk64xx_wm8580.c
@@ -224,7 +224,7 @@ static struct snd_soc_dai_link smdk64xx_dai[] = {
 	.stream_name = "Playback",
 	.cpu_dai_name = "s3c64xx-iis-v4",
 	.codec_dai_name = "wm8580-hifi-playback",
-	.platform_name = "s3c24xx-pcm-audio",
+	.platform_name = "samsung-audio",
 	.codec_name = "wm8580-codec.0-001b",
 	.init = smdk64xx_wm8580_init_paifrx,
 	.ops = &smdk64xx_ops,
@@ -234,7 +234,7 @@ static struct snd_soc_dai_link smdk64xx_dai[] = {
 	.stream_name = "Capture",
 	.cpu_dai_name = "s3c64xx-iis-v4",
 	.codec_dai_name = "wm8580-hifi-capture",
-	.platform_name = "s3c24xx-pcm-audio",
+	.platform_name = "samsung-audio",
 	.codec_name = "wm8580-codec.0-001b",
 	.init = smdk64xx_wm8580_init_paiftx,
 	.ops = &smdk64xx_ops,
diff --git a/sound/soc/s3c24xx/smdk_spdif.c b/sound/soc/s3c24xx/smdk_spdif.c
index f31d22a..082b88d 100644
--- a/sound/soc/s3c24xx/smdk_spdif.c
+++ b/sound/soc/s3c24xx/smdk_spdif.c
@@ -157,7 +157,7 @@ static struct snd_soc_card smdk;
 static struct snd_soc_dai_link smdk_dai = {
 	.name = "S/PDIF",
 	.stream_name = "S/PDIF PCM Playback",
-	.platform_name = "s3c24xx-pcm-audio",
+	.platform_name = "samsung-audio",
 	.cpu_dai_name = "samsung-spdif",
 	.codec_dai_name = "dit-hifi",
 	.codec_name = "spdif-dit",
diff --git a/sound/soc/s3c24xx/smdk_wm9713.c b/sound/soc/s3c24xx/smdk_wm9713.c
index 33ba8fd..ea96a51 100644
--- a/sound/soc/s3c24xx/smdk_wm9713.c
+++ b/sound/soc/s3c24xx/smdk_wm9713.c
@@ -45,7 +45,7 @@ static struct snd_soc_card smdk;
 static struct snd_soc_dai_link smdk_dai = {
 	.name = "AC97",
 	.stream_name = "AC97 PCM",
-	.platform_name = "s3c24xx-pcm-audio",
+	.platform_name = "samsung-audio",
 	.cpu_dai_name = "s3c-ac97",
 	.codec_dai_name = "wm9713-hifi",
 	.codec_name = "wm9713-codec",
-- 
1.6.2.5
