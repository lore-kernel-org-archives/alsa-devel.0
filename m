From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5682: Update calibration function" to
	the asoc tree
Date: Tue, 18 Sep 2018 18:45:18 +0100 (BST)
Message-ID: <20180918174518.80EA4440078@finisterre.ee.mobilebroadband>
References: <1537271438-5540-1-git-send-email-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A6EC2678AC
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2018 19:45:21 +0200 (CEST)
In-Reply-To: <1537271438-5540-1-git-send-email-shumingf@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shuming Fan <shumingf@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, albertchen@realtek.com, broonie@kernel.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5682: Update calibration function

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

>From afd603e4ded0fad9e3102d514020af8494da1604 Mon Sep 17 00:00:00 2001
From: Shuming Fan <shumingf@realtek.com>
Date: Tue, 18 Sep 2018 19:50:38 +0800
Subject: [PATCH] ASoC: rt5682: Update calibration function

The ADC/DAC path should open while calibration process.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5682.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 7213b1cfb18a..2725eb72fb1b 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -2468,17 +2468,22 @@ static void rt5682_calibrate(struct rt5682_priv *rt5682)
 	mutex_lock(&rt5682->calibrate_mutex);
 
 	rt5682_reset(rt5682->regmap);
-	regmap_write(rt5682->regmap, RT5682_PWR_ANLG_1, 0xa2bf);
+	regmap_write(rt5682->regmap, RT5682_PWR_ANLG_1, 0xa2af);
 	usleep_range(15000, 20000);
-	regmap_write(rt5682->regmap, RT5682_PWR_ANLG_1, 0xf2bf);
+	regmap_write(rt5682->regmap, RT5682_PWR_ANLG_1, 0xf2af);
 	regmap_write(rt5682->regmap, RT5682_MICBIAS_2, 0x0300);
 	regmap_write(rt5682->regmap, RT5682_GLB_CLK, 0x8000);
 	regmap_write(rt5682->regmap, RT5682_PWR_DIG_1, 0x0100);
+	regmap_write(rt5682->regmap, RT5682_HP_IMP_SENS_CTRL_19, 0x3800);
 	regmap_write(rt5682->regmap, RT5682_CHOP_DAC, 0x3000);
+	regmap_write(rt5682->regmap, RT5682_CALIB_ADC_CTRL, 0x7005);
+	regmap_write(rt5682->regmap, RT5682_STO1_ADC_MIXER, 0x686c);
+	regmap_write(rt5682->regmap, RT5682_CAL_REC, 0x0d0d);
 	regmap_write(rt5682->regmap, RT5682_HP_CALIB_CTRL_2, 0x0321);
 	regmap_write(rt5682->regmap, RT5682_HP_LOGIC_CTRL_2, 0x0004);
 	regmap_write(rt5682->regmap, RT5682_HP_CALIB_CTRL_1, 0x7c00);
 	regmap_write(rt5682->regmap, RT5682_HP_CALIB_CTRL_3, 0x06a1);
+	regmap_write(rt5682->regmap, RT5682_A_DAC1_MUX, 0x0311);
 	regmap_write(rt5682->regmap, RT5682_HP_CALIB_CTRL_1, 0x7c00);
 
 	regmap_write(rt5682->regmap, RT5682_HP_CALIB_CTRL_1, 0xfc00);
@@ -2495,8 +2500,12 @@ static void rt5682_calibrate(struct rt5682_priv *rt5682)
 		pr_err("HP Calibration Failure\n");
 
 	/* restore settings */
+	regmap_write(rt5682->regmap, RT5682_PWR_ANLG_1, 0x02af);
+	regmap_write(rt5682->regmap, RT5682_MICBIAS_2, 0x0080);
 	regmap_write(rt5682->regmap, RT5682_GLB_CLK, 0x0000);
 	regmap_write(rt5682->regmap, RT5682_PWR_DIG_1, 0x0000);
+	regmap_write(rt5682->regmap, RT5682_CHOP_DAC, 0x2000);
+	regmap_write(rt5682->regmap, RT5682_CALIB_ADC_CTRL, 0x2005);
 
 	mutex_unlock(&rt5682->calibrate_mutex);
 
-- 
2.19.0
