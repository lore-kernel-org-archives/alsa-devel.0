From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic32x4: Restructure
	set_dai_sysclk" to the asoc tree
Date: Mon, 25 Mar 2019 16:11:27 +0000 (GMT)
Message-ID: <20190325161127.C178111288F1@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BBEABF801D9
 for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2019 17:11:28 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Annaliese McDermond <nh6z@nh6z.net>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic32x4: Restructure set_dai_sysclk

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From aa6a60f7be925210d5156f0e8025f3afe1f4f54d Mon Sep 17 00:00:00 2001
From: Annaliese McDermond <nh6z@nh6z.net>
Date: Thu, 21 Mar 2019 17:58:52 -0700
Subject: [PATCH] ASoC: tlv320aic32x4: Restructure set_dai_sysclk

The sysclk is now managed by the CCF.  Change this function
to merely find the system clock and set it using
clk_set_rate.

Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 625528500f8d..289bf411e60e 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -49,7 +49,6 @@
 
 struct aic32x4_priv {
 	struct regmap *regmap;
-	u32 sysclk;
 	u32 power_cfg;
 	u32 micpga_routing;
 	bool swapdacs;
@@ -567,17 +566,13 @@ static int aic32x4_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 				  int clk_id, unsigned int freq, int dir)
 {
 	struct snd_soc_component *component = codec_dai->component;
-	struct aic32x4_priv *aic32x4 = snd_soc_component_get_drvdata(component);
+	struct clk *mclk;
+	struct clk *pll;
 
-	switch (freq) {
-	case 12000000:
-	case 24000000:
-	case 25000000:
-		aic32x4->sysclk = freq;
-		return 0;
-	}
-	printk(KERN_ERR "aic32x4: invalid frequency to set DAI system clock\n");
-	return -EINVAL;
+	pll = devm_clk_get(component->dev, "pll");
+	mclk = clk_get_parent(pll);
+
+	return clk_set_rate(mclk, freq);
 }
 
 static int aic32x4_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
-- 
2.20.1
