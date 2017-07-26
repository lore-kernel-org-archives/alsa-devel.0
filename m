From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: s3c24xx: Handle return value
	of clk_prepare_enable." to the asoc tree
Date: Wed, 26 Jul 2017 15:17:09 +0100
Message-ID: <E1daN7d-0003YF-9Y@debutante>
References: <1500977674-27960-3-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CA97267497
 for <alsa-devel@alsa-project.org>; Wed, 26 Jul 2017 16:17:29 +0200 (CEST)
In-Reply-To: <1500977674-27960-3-git-send-email-arvind.yadav.cs@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: alsa-devel@alsa-project.org, sbkim73@samsung.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, krzk@kernel.org, tiwai@suse.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: s3c24xx: Handle return value of clk_prepare_enable.

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 8698475a94d0b7eb21efaa346d507dc4932f2032 Mon Sep 17 00:00:00 2001
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Tue, 25 Jul 2017 15:44:29 +0530
Subject: [PATCH] ASoC: samsung: s3c24xx: Handle return value of
 clk_prepare_enable.

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/s3c24xx-i2s.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
index 91e6871e5413..8d58d02183bf 100644
--- a/sound/soc/samsung/s3c24xx-i2s.c
+++ b/sound/soc/samsung/s3c24xx-i2s.c
@@ -340,6 +340,7 @@ EXPORT_SYMBOL_GPL(s3c24xx_i2s_get_clockrate);
 
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
2.13.2
