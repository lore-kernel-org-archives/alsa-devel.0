From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/5] ASoC: Add MODULE_ALIAS to Samsung DAI
	drivers
Date: Thu, 12 Aug 2010 11:02:19 +0100
Message-ID: <1281607342-13127-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1281607342-13127-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EA6F81038D1
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
 sound/soc/s3c24xx/s3c-ac97.c       |    1 +
 sound/soc/s3c24xx/s3c-dma.c        |    1 +
 sound/soc/s3c24xx/s3c-pcm.c        |    1 +
 sound/soc/s3c24xx/s3c2412-i2s.c    |    1 +
 sound/soc/s3c24xx/s3c24xx-i2s.c    |    1 +
 sound/soc/s3c24xx/s3c64xx-i2s-v4.c |    1 +
 sound/soc/s3c24xx/s3c64xx-i2s.c    |    1 +
 7 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c-ac97.c b/sound/soc/s3c24xx/s3c-ac97.c
index 86f4a9b..26f4ed9 100644
--- a/sound/soc/s3c24xx/s3c-ac97.c
+++ b/sound/soc/s3c24xx/s3c-ac97.c
@@ -513,3 +513,4 @@ module_exit(s3c_ac97_exit);
 MODULE_AUTHOR("Jaswinder Singh, <jassi.brar@samsung.com>");
 MODULE_DESCRIPTION("AC97 driver for the Samsung SoC");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:s3c-ac97");
diff --git a/sound/soc/s3c24xx/s3c-dma.c b/sound/soc/s3c24xx/s3c-dma.c
index 4f8b498..bb8ba07 100644
--- a/sound/soc/s3c24xx/s3c-dma.c
+++ b/sound/soc/s3c24xx/s3c-dma.c
@@ -500,3 +500,4 @@ module_exit(snd_s3c24xx_pcm_exit);
 MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
 MODULE_DESCRIPTION("Samsung S3C Audio DMA module");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:s3c24xx-pcm-audio");
diff --git a/sound/soc/s3c24xx/s3c-pcm.c b/sound/soc/s3c24xx/s3c-pcm.c
index 653ffa2..6174e26 100644
--- a/sound/soc/s3c24xx/s3c-pcm.c
+++ b/sound/soc/s3c24xx/s3c-pcm.c
@@ -543,3 +543,4 @@ module_exit(s3c_pcm_exit);
 MODULE_AUTHOR("Jaswinder Singh, <jassi.brar@samsung.com>");
 MODULE_DESCRIPTION("S3C PCM Controller Driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:samsung-pcm-audio");
diff --git a/sound/soc/s3c24xx/s3c2412-i2s.c b/sound/soc/s3c24xx/s3c2412-i2s.c
index acd0096..4a861cf 100644
--- a/sound/soc/s3c24xx/s3c2412-i2s.c
+++ b/sound/soc/s3c24xx/s3c2412-i2s.c
@@ -209,3 +209,4 @@ module_exit(s3c2412_i2s_exit);
 MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
 MODULE_DESCRIPTION("S3C2412 I2S SoC Interface");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:s3c2412-iis");
diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/s3c24xx/s3c24xx-i2s.c
index 1d0bade..e060daa 100644
--- a/sound/soc/s3c24xx/s3c24xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c24xx-i2s.c
@@ -516,3 +516,4 @@ module_exit(s3c24xx_i2s_exit);
 MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
 MODULE_DESCRIPTION("s3c24xx I2S SoC Interface");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:s3c24xx-iis");
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s-v4.c b/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
index 7cab4fc..a13415a 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
@@ -216,3 +216,4 @@ module_exit(s3c64xx_i2sv4_exit);
 MODULE_AUTHOR("Jaswinder Singh, <jassi.brar@samsung.com>");
 MODULE_DESCRIPTION("S3C64XX I2Sv4 SoC Interface");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:s3c64xx-iis-v4");
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index a1d0b25..ae7acb6 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -239,3 +239,4 @@ module_exit(s3c64xx_i2s_exit);
 MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
 MODULE_DESCRIPTION("S3C64XX I2S SoC Interface");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:s3c64xx-iis");
-- 
1.7.1
