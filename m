From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5663: Fix the IRQ issue" to the asoc
	tree
Date: Tue, 06 Jun 2017 20:06:17 +0100
Message-ID: <E1dIJo1-0007Hh-Ci@debutante>
References: <1496732394-21460-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 53AFF26733B
 for <alsa-devel@alsa-project.org>; Tue,  6 Jun 2017 21:06:26 +0200 (CEST)
In-Reply-To: <1496732394-21460-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, lgirdwood@gmail.com, albertchen@realtek.com, broonie@kernel.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5663: Fix the IRQ issue

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

>From af2728e4deb9f08721374f3adc06b1d3e7d133ec Mon Sep 17 00:00:00 2001
From: Oder Chiou <oder_chiou@realtek.com>
Date: Tue, 6 Jun 2017 14:59:54 +0800
Subject: [PATCH] ASoC: rt5663: Fix the IRQ issue

The patch fixed the IRQ issue.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5663.c | 2 +-
 sound/soc/codecs/rt5663.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index a32508d7dcfd..8569e8c7d894 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -3141,7 +3141,7 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 		regmap_update_bits(rt5663->regmap, RT5663_DIG_MISC,
 			RT5663_DIG_GATE_CTRL_MASK, RT5663_DIG_GATE_CTRL_EN);
 		regmap_update_bits(rt5663->regmap, RT5663_AUTO_1MRC_CLK,
-			RT5663_IRQ_POW_SAV_MASK, RT5663_IRQ_POW_SAV_EN);
+			RT5663_IRQ_MANUAL_MASK, RT5663_IRQ_MANUAL_EN);
 		regmap_update_bits(rt5663->regmap, RT5663_IRQ_1,
 			RT5663_EN_IRQ_JD1_MASK, RT5663_EN_IRQ_JD1_EN);
 		regmap_update_bits(rt5663->regmap, RT5663_GPIO_1,
diff --git a/sound/soc/codecs/rt5663.h b/sound/soc/codecs/rt5663.h
index d77fae619f2f..4621812c94d8 100644
--- a/sound/soc/codecs/rt5663.h
+++ b/sound/soc/codecs/rt5663.h
@@ -590,6 +590,10 @@
 #define RT5663_IRQ_POW_SAV_JD1_SHIFT		14
 #define RT5663_IRQ_POW_SAV_JD1_DIS		(0x0 << 14)
 #define RT5663_IRQ_POW_SAV_JD1_EN		(0x1 << 14)
+#define RT5663_IRQ_MANUAL_MASK			(0x1 << 8)
+#define RT5663_IRQ_MANUAL_SHIFT			8
+#define RT5663_IRQ_MANUAL_DIS			(0x0 << 8)
+#define RT5663_IRQ_MANUAL_EN			(0x1 << 8)
 
 /* IRQ Control 1 (0x00b6) */
 #define RT5663_EN_CB_JD_MASK			(0x1 << 3)
-- 
2.11.0
