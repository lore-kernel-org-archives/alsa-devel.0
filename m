From: Jassi Brar <jassi.brar@samsung.com>
Subject: [PATCH 05/20] ASoC: S3C: I2Sv2: Unify clock source IDs
Date: Wed, 10 Mar 2010 16:48:54 +0900
Message-ID: <1268207349-9979-5-git-send-email-jassi.brar@samsung.com>
References: <1268207349-9979-1-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-2-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-3-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-4-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 93EA22434C
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 08:58:03 +0100 (CET)
In-Reply-To: <1268207349-9979-4-git-send-email-jassi.brar@samsung.com>
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
Cc: broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

Rather than having the multiple definitions of the same clocks,
define them in one common place and refer by SoC specific names.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/s3c-i2s-v2.h  |    4 ++++
 sound/soc/s3c24xx/s3c2412-i2s.h |    4 ++--
 sound/soc/s3c24xx/s3c64xx-i2s.h |    6 +++---
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.h b/sound/soc/s3c24xx/s3c-i2s-v2.h
index ecf8eaa..b094d3c 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.h
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.h
@@ -25,6 +25,10 @@
 #define S3C_I2SV2_DIV_RCLK	(2)
 #define S3C_I2SV2_DIV_PRESCALER	(3)
 
+#define S3C_I2SV2_CLKSRC_PCLK		0
+#define S3C_I2SV2_CLKSRC_AUDIOBUS	1
+#define S3C_I2SV2_CLKSRC_CDCLK		2
+
 /**
  * struct s3c_i2sv2_info - S3C I2S-V2 information
  * @dev: The parent device passed to use from the probe.
diff --git a/sound/soc/s3c24xx/s3c2412-i2s.h b/sound/soc/s3c24xx/s3c2412-i2s.h
index 92848e5..60cac00 100644
--- a/sound/soc/s3c24xx/s3c2412-i2s.h
+++ b/sound/soc/s3c24xx/s3c2412-i2s.h
@@ -21,8 +21,8 @@
 #define S3C2412_DIV_RCLK	S3C_I2SV2_DIV_RCLK
 #define S3C2412_DIV_PRESCALER	S3C_I2SV2_DIV_PRESCALER
 
-#define S3C2412_CLKSRC_PCLK	(0)
-#define S3C2412_CLKSRC_I2SCLK	(1)
+#define S3C2412_CLKSRC_PCLK	S3C_I2SV2_CLKSRC_PCLK
+#define S3C2412_CLKSRC_I2SCLK	S3C_I2SV2_CLKSRC_AUDIOBUS
 
 extern struct clk *s3c2412_get_iisclk(void);
 
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.h b/sound/soc/s3c24xx/s3c64xx-i2s.h
index abe7253..e350d28 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.h
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.h
@@ -23,9 +23,9 @@ struct clk;
 #define S3C64XX_DIV_RCLK	S3C_I2SV2_DIV_RCLK
 #define S3C64XX_DIV_PRESCALER	S3C_I2SV2_DIV_PRESCALER
 
-#define S3C64XX_CLKSRC_PCLK	(0)
-#define S3C64XX_CLKSRC_MUX	(1)
-#define S3C64XX_CLKSRC_CDCLK    (2)
+#define S3C64XX_CLKSRC_PCLK	S3C_I2SV2_CLKSRC_PCLK
+#define S3C64XX_CLKSRC_MUX	S3C_I2SV2_CLKSRC_AUDIOBUS
+#define S3C64XX_CLKSRC_CDCLK    S3C_I2SV2_CLKSRC_CDCLK
 
 extern struct snd_soc_dai s3c64xx_i2s_dai[];
 
-- 
1.6.2.5
