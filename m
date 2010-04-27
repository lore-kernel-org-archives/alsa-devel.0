From: Jassi Brar <jassi.brar@samsung.com>
Subject: [PATCH 06/11] ASoC: S3C: I2Sv2: Unify i2s_get_clock
	callback
Date: Tue, 27 Apr 2010 15:56:45 +0900
Message-ID: <1272351405-3851-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 4734824836
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 09:00:24 +0200 (CEST)
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
Cc: broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Now that we have two callbacks s3c2412_i2s_get_clock & s3c64xx_i2s_get_clock
doing exactly the same thing, we can define one generic s3c_i2sv2_get_clock
and discard other two copies. Also, switch the users to make calls to the
newly defined and generic s3c_i2sv2_get_clock

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/jive_wm8750.c |    2 +-
 sound/soc/s3c24xx/s3c-i2s-v2.c  |   12 ++++++++++++
 sound/soc/s3c24xx/s3c-i2s-v2.h  |    2 ++
 sound/soc/s3c24xx/s3c2412-i2s.c |   13 -------------
 sound/soc/s3c24xx/s3c2412-i2s.h |    2 --
 sound/soc/s3c24xx/s3c64xx-i2s.c |   12 ------------
 sound/soc/s3c24xx/s3c64xx-i2s.h |    2 --
 7 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/sound/soc/s3c24xx/jive_wm8750.c b/sound/soc/s3c24xx/jive_wm8750.c
index 97d8ff3..8c108b1 100644
--- a/sound/soc/s3c24xx/jive_wm8750.c
+++ b/sound/soc/s3c24xx/jive_wm8750.c
@@ -70,7 +70,7 @@ static int jive_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	s3c_i2sv2_iis_calc_rate(&div, NULL, params_rate(params),
-				s3c2412_get_iisclk());
+				s3c_i2sv2_get_clock(cpu_dai));
 
 	/* set codec DAI configuration */
 	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
index b8803a1..ac153ca 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
@@ -516,6 +516,18 @@ static snd_pcm_sframes_t s3c2412_i2s_delay(struct snd_pcm_substream *substream,
 	return delay;
 }
 
+struct clk *s3c_i2sv2_get_clock(struct snd_soc_dai *cpu_dai)
+{
+	struct s3c_i2sv2_info *i2s = to_info(cpu_dai);
+	u32 iismod = readl(i2s->regs + S3C2412_IISMOD);
+
+	if (iismod & S3C2412_IISMOD_IMS_SYSMUX)
+		return i2s->iis_cclk;
+	else
+		return i2s->iis_pclk;
+}
+EXPORT_SYMBOL_GPL(s3c_i2sv2_get_clock);
+
 /* default table of all avaialable root fs divisors */
 static unsigned int iis_fs_tab[] = { 256, 512, 384, 768 };
 
diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.h b/sound/soc/s3c24xx/s3c-i2s-v2.h
index ea56467..39a6db6 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.h
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.h
@@ -60,6 +60,8 @@ struct s3c_i2sv2_info {
 	u32		 suspend_iispsr;
 };
 
+extern struct clk *s3c_i2sv2_get_clock(struct snd_soc_dai *cpu_dai);
+
 struct s3c_i2sv2_rate_calc {
 	unsigned int	clk_div;	/* for prescaler */
 	unsigned int	fs_div;		/* for root frame clock */
diff --git a/sound/soc/s3c24xx/s3c2412-i2s.c b/sound/soc/s3c24xx/s3c2412-i2s.c
index ce2daac..6b884d7 100644
--- a/sound/soc/s3c24xx/s3c2412-i2s.c
+++ b/sound/soc/s3c24xx/s3c2412-i2s.c
@@ -91,19 +91,6 @@ static int s3c2412_i2s_set_sysclk(struct snd_soc_dai *cpu_dai,
 	return 0;
 }
 
-
-struct clk *s3c2412_get_iisclk(void)
-{
-	struct s3c_i2sv2_info *i2s = &s3c2412_i2s;
-	u32 iismod = readl(i2s->regs + S3C2412_IISMOD);
-
-	if (iismod & S3C2412_IISMOD_IMS_SYSMUX)
-		return i2s->iis_cclk;
-	else
-		return i2s->iis_pclk;
-}
-EXPORT_SYMBOL_GPL(s3c2412_get_iisclk);
-
 static inline struct s3c_i2sv2_info *to_info(struct snd_soc_dai *cpu_dai)
 {
 	return cpu_dai->private_data;
diff --git a/sound/soc/s3c24xx/s3c2412-i2s.h b/sound/soc/s3c24xx/s3c2412-i2s.h
index 60cac00..0b5686b 100644
--- a/sound/soc/s3c24xx/s3c2412-i2s.h
+++ b/sound/soc/s3c24xx/s3c2412-i2s.h
@@ -24,8 +24,6 @@
 #define S3C2412_CLKSRC_PCLK	S3C_I2SV2_CLKSRC_PCLK
 #define S3C2412_CLKSRC_I2SCLK	S3C_I2SV2_CLKSRC_AUDIOBUS
 
-extern struct clk *s3c2412_get_iisclk(void);
-
 extern struct snd_soc_dai s3c2412_i2s_dai;
 
 #endif /* __SND_SOC_S3C24XX_S3C2412_I2S_H */
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index b7e951f..97327ef 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -91,18 +91,6 @@ static int s3c64xx_i2s_set_sysclk(struct snd_soc_dai *cpu_dai,
 	return 0;
 }
 
-struct clk *s3c64xx_i2s_get_clock(struct snd_soc_dai *dai)
-{
-	struct s3c_i2sv2_info *i2s = to_info(dai);
-	u32 iismod = readl(i2s->regs + S3C2412_IISMOD);
-
-	if (iismod & S3C64XX_IISMOD_IMS_SYSMUX)
-		return i2s->iis_cclk;
-	else
-		return i2s->iis_pclk;
-}
-EXPORT_SYMBOL_GPL(s3c64xx_i2s_get_clock);
-
 static int s3c64xx_i2s_probe(struct platform_device *pdev,
 			     struct snd_soc_dai *dai)
 {
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.h b/sound/soc/s3c24xx/s3c64xx-i2s.h
index 53d2a0a..f27ed50 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.h
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.h
@@ -38,6 +38,4 @@ struct clk;
 
 extern struct snd_soc_dai s3c64xx_i2s_dai[];
 
-extern struct clk *s3c64xx_i2s_get_clock(struct snd_soc_dai *dai);
-
 #endif /* __SND_SOC_S3C24XX_S3C64XX_I2S_H */
-- 
1.6.2.5
