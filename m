From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 02/11] ASoC: samsung: s3c24xx: Handle return value of clk_prepare_enable.
Date: Tue, 25 Jul 2017 15:44:29 +0530
Message-ID: <1500977674-27960-3-git-send-email-arvind.yadav.cs@gmail.com>
References: <1500977674-27960-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500977674-27960-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, broonie@kernel.org, krzk@kernel.org, sbkim73@samsung.com, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/soc/samsung/s3c24xx-i2s.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
index 91e6871..8d58d02 100644
--- a/sound/soc/samsung/s3c24xx-i2s.c
+++ b/sound/soc/samsung/s3c24xx-i2s.c
@@ -340,6 +340,7 @@ u32 s3c24xx_i2s_get_clockrate(void)
 
 static int s3c24xx_i2s_probe(struct snd_soc_dai *dai)
 {
+	int ret;
 	snd_soc_dai_init_dma_data(dai, &s3c24xx_i2s_pcm_stereo_out,
 					&s3c24xx_i2s_pcm_stereo_in);
 
@@ -348,7 +349,9 @@ static int s3c24xx_i2s_probe(struct snd_soc_dai *dai)
 		pr_err("failed to get iis_clock\n");
 		return PTR_ERR(s3c24xx_i2s.iis_clk);
 	}
-	clk_prepare_enable(s3c24xx_i2s.iis_clk);
+	ret = clk_prepare_enable(s3c24xx_i2s.iis_clk);
+	if (ret)
+		return ret;
 
 	/* Configure the I2S pins (GPE0...GPE4) in correct mode */
 	s3c_gpio_cfgall_range(S3C2410_GPE(0), 5, S3C_GPIO_SFN(2),
@@ -377,7 +380,11 @@ static int s3c24xx_i2s_suspend(struct snd_soc_dai *cpu_dai)
 
 static int s3c24xx_i2s_resume(struct snd_soc_dai *cpu_dai)
 {
-	clk_prepare_enable(s3c24xx_i2s.iis_clk);
+	int ret;
+
+	ret = clk_prepare_enable(s3c24xx_i2s.iis_clk);
+	if (ret)
+		return ret;
 
 	writel(s3c24xx_i2s.iiscon, s3c24xx_i2s.regs + S3C2410_IISCON);
 	writel(s3c24xx_i2s.iismod, s3c24xx_i2s.regs + S3C2410_IISMOD);
-- 
1.9.1
