From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5663: Update the calibration
	funciton" to the asoc tree
Date: Fri, 07 Jul 2017 13:52:43 +0100
Message-ID: <E1dTSkV-0002rg-Mq@finisterre>
References: <1499417939-319-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F02D82671E3
 for <alsa-devel@alsa-project.org>; Fri,  7 Jul 2017 14:52:52 +0200 (CEST)
In-Reply-To: <1499417939-319-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, lgirdwood@gmail.com, albertchen@realtek.com, broonie@kernel.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5663: Update the calibration funciton

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

>From 1a425dbf1a1014742312123a04e3fc6ed646c738 Mon Sep 17 00:00:00 2001
From: "oder_chiou@realtek.com" <oder_chiou@realtek.com>
Date: Fri, 7 Jul 2017 16:58:57 +0800
Subject: [PATCH] ASoC: rt5663: Update the calibration funciton

The patch updates the calibration funciton for getting the correct DC
offset of headphone output.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5663.c | 100 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 79 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index a33202affeb1..18b3b526b7c5 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -2986,47 +2986,75 @@ static void rt5663_calibrate(struct rt5663_priv *rt5663)
 {
 	int value, count;
 
-	regmap_write(rt5663->regmap, RT5663_RC_CLK, 0x0280);
+	regmap_write(rt5663->regmap, RT5663_RESET, 0x0000);
+	msleep(20);
+	regmap_write(rt5663->regmap, RT5663_ANA_BIAS_CUR_4, 0x00a1);
+	regmap_write(rt5663->regmap, RT5663_RC_CLK, 0x0380);
 	regmap_write(rt5663->regmap, RT5663_GLB_CLK, 0x8000);
-	regmap_write(rt5663->regmap, RT5663_DIG_MISC, 0x8001);
+	regmap_write(rt5663->regmap, RT5663_ADDA_CLK_1, 0x1000);
 	regmap_write(rt5663->regmap, RT5663_VREF_RECMIX, 0x0032);
-	regmap_write(rt5663->regmap, RT5663_PWR_ANLG_1, 0xa2be);
-	msleep(20);
-	regmap_write(rt5663->regmap, RT5663_PWR_ANLG_1, 0xf2be);
-	regmap_write(rt5663->regmap, RT5663_PWR_DIG_2, 0x8400);
-	regmap_write(rt5663->regmap, RT5663_CHOP_ADC, 0x3000);
-	regmap_write(rt5663->regmap, RT5663_DEPOP_1, 0x003b);
-	regmap_write(rt5663->regmap, RT5663_PWR_DIG_1, 0x8df8);
-	regmap_write(rt5663->regmap, RT5663_PWR_ANLG_2, 0x0003);
-	regmap_write(rt5663->regmap, RT5663_PWR_ANLG_3, 0x018c);
-	regmap_write(rt5663->regmap, RT5663_ADDA_CLK_1, 0x1111);
+	regmap_write(rt5663->regmap, RT5663_HP_IMP_SEN_19, 0x000c);
+	regmap_write(rt5663->regmap, RT5663_DUMMY_1, 0x0324);
+	regmap_write(rt5663->regmap, RT5663_DIG_MISC, 0x8001);
+	regmap_write(rt5663->regmap, RT5663_PWR_ANLG_1, 0xa23b);
+	msleep(30);
+	regmap_write(rt5663->regmap, RT5663_PWR_ANLG_1, 0xf23b);
+	regmap_write(rt5663->regmap, RT5663_PWR_ANLG_2, 0x8000);
+	regmap_write(rt5663->regmap, RT5663_PWR_ANLG_3, 0x0008);
 	regmap_write(rt5663->regmap, RT5663_PRE_DIV_GATING_1, 0xffff);
 	regmap_write(rt5663->regmap, RT5663_PRE_DIV_GATING_2, 0xffff);
+	regmap_write(rt5663->regmap, RT5663_CBJ_1, 0x8c10);
+	regmap_write(rt5663->regmap, RT5663_IL_CMD_2, 0x00c1);
+	regmap_write(rt5663->regmap, RT5663_EM_JACK_TYPE_1, 0xb880);
+	regmap_write(rt5663->regmap, RT5663_EM_JACK_TYPE_2, 0x4110);
+	regmap_write(rt5663->regmap, RT5663_EM_JACK_TYPE_2, 0x4118);
+
+	count = 0;
+	while (true) {
+		regmap_read(rt5663->regmap, RT5663_INT_ST_2, &value);
+		if (!(value & 0x80))
+			usleep_range(10000, 10005);
+		else
+			break;
+
+		if (count > 200)
+			break;
+	}
+
+	regmap_write(rt5663->regmap, RT5663_HP_IMP_SEN_19, 0x0000);
 	regmap_write(rt5663->regmap, RT5663_DEPOP_2, 0x3003);
+	regmap_write(rt5663->regmap, RT5663_DEPOP_1, 0x0038);
 	regmap_write(rt5663->regmap, RT5663_DEPOP_1, 0x003b);
+	regmap_write(rt5663->regmap, RT5663_PWR_DIG_2, 0x8400);
+	regmap_write(rt5663->regmap, RT5663_PWR_DIG_1, 0x8df8);
+	regmap_write(rt5663->regmap, RT5663_PWR_ANLG_2, 0x8003);
+	regmap_write(rt5663->regmap, RT5663_PWR_ANLG_3, 0x018c);
 	regmap_write(rt5663->regmap, RT5663_HP_CHARGE_PUMP_1, 0x1e32);
-	regmap_write(rt5663->regmap, RT5663_HP_CHARGE_PUMP_2, 0x1371);
 	regmap_write(rt5663->regmap, RT5663_DACREF_LDO, 0x3b0b);
-	regmap_write(rt5663->regmap, RT5663_STO_DAC_MIXER, 0x2080);
+	regmap_write(rt5663->regmap, RT5663_STO_DAC_MIXER, 0x0000);
 	regmap_write(rt5663->regmap, RT5663_BYPASS_STO_DAC, 0x000c);
-	regmap_write(rt5663->regmap, RT5663_HP_BIAS, 0xabba);
+	regmap_write(rt5663->regmap, RT5663_HP_BIAS, 0xafaa);
 	regmap_write(rt5663->regmap, RT5663_CHARGE_PUMP_1, 0x2224);
 	regmap_write(rt5663->regmap, RT5663_HP_OUT_EN, 0x8088);
 	regmap_write(rt5663->regmap, RT5663_STO_DRE_9, 0x0017);
 	regmap_write(rt5663->regmap, RT5663_STO_DRE_10, 0x0017);
 	regmap_write(rt5663->regmap, RT5663_STO1_ADC_MIXER, 0x4040);
+	regmap_write(rt5663->regmap, RT5663_CHOP_ADC, 0x3000);
 	regmap_write(rt5663->regmap, RT5663_RECMIX, 0x0005);
 	regmap_write(rt5663->regmap, RT5663_ADDA_RST, 0xc000);
 	regmap_write(rt5663->regmap, RT5663_STO1_HPF_ADJ1, 0x3320);
 	regmap_write(rt5663->regmap, RT5663_HP_CALIB_2, 0x00c9);
 	regmap_write(rt5663->regmap, RT5663_DUMMY_1, 0x004c);
-	regmap_write(rt5663->regmap, RT5663_ANA_BIAS_CUR_1, 0x7766);
-	regmap_write(rt5663->regmap, RT5663_BIAS_CUR_8, 0x4702);
-	msleep(200);
+	regmap_write(rt5663->regmap, RT5663_ANA_BIAS_CUR_1, 0x1111);
+	regmap_write(rt5663->regmap, RT5663_BIAS_CUR_8, 0x4402);
+	regmap_write(rt5663->regmap, RT5663_CHARGE_PUMP_2, 0x3311);
 	regmap_write(rt5663->regmap, RT5663_HP_CALIB_1, 0x0069);
-	regmap_write(rt5663->regmap, RT5663_HP_CALIB_3, 0x06c2);
-	regmap_write(rt5663->regmap, RT5663_HP_CALIB_1_1, 0x7b00);
-	regmap_write(rt5663->regmap, RT5663_HP_CALIB_1_1, 0xfb00);
+	regmap_write(rt5663->regmap, RT5663_HP_CALIB_3, 0x06ce);
+	regmap_write(rt5663->regmap, RT5663_HP_CALIB_1_1, 0x6800);
+	regmap_write(rt5663->regmap, RT5663_CHARGE_PUMP_2, 0x1100);
+	regmap_write(rt5663->regmap, RT5663_HP_CALIB_7, 0x0057);
+	regmap_write(rt5663->regmap, RT5663_HP_CALIB_1_1, 0xe800);
+
 	count = 0;
 	while (true) {
 		regmap_read(rt5663->regmap, RT5663_HP_CALIB_1_1, &value);
@@ -3039,6 +3067,36 @@ static void rt5663_calibrate(struct rt5663_priv *rt5663)
 			return;
 		count++;
 	}
+
+	regmap_write(rt5663->regmap, RT5663_HP_CALIB_1_1, 0x6200);
+	regmap_write(rt5663->regmap, RT5663_HP_CALIB_7, 0x0059);
+	regmap_write(rt5663->regmap, RT5663_HP_CALIB_1_1, 0xe200);
+
+	count = 0;
+	while (true) {
+		regmap_read(rt5663->regmap, RT5663_HP_CALIB_1_1, &value);
+		if (value & 0x8000)
+			usleep_range(10000, 10005);
+		else
+			break;
+
+		if (count > 200)
+			return;
+		count++;
+	}
+
+	regmap_write(rt5663->regmap, RT5663_EM_JACK_TYPE_1, 0xb8e0);
+	usleep_range(10000, 10005);
+	regmap_write(rt5663->regmap, RT5663_PWR_ANLG_1, 0x003b);
+	usleep_range(10000, 10005);
+	regmap_write(rt5663->regmap, RT5663_PWR_DIG_1, 0x0000);
+	usleep_range(10000, 10005);
+	regmap_write(rt5663->regmap, RT5663_DEPOP_1, 0x000b);
+	usleep_range(10000, 10005);
+	regmap_write(rt5663->regmap, RT5663_DEPOP_1, 0x0008);
+	usleep_range(10000, 10005);
+	regmap_write(rt5663->regmap, RT5663_PWR_ANLG_2, 0x0000);
+	usleep_range(10000, 10005);
 }
 
 static int rt5663_i2c_probe(struct i2c_client *i2c,
-- 
2.13.2
