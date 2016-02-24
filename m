From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt298: enable IRQ for jack detection"
	to the asoc tree
Date: Wed, 24 Feb 2016 17:43:01 +0900
Message-ID: <E1aYV2D-0002xt-1g@finisterre>
References: <1455613956-14287-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BF173266880
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2016 09:43:09 +0100 (CET)
In-Reply-To: <1455613956-14287-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt298: enable IRQ for jack detection

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

>From 4b2fe3822ae16436ed0aba379c500558f7846ce1 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Wed, 24 Feb 2016 15:51:26 +0800
Subject: [PATCH] ASoC: rt298: enable IRQ for jack detection

There are some registers needed for enabling rt298 IRQ missed on
current driver.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt298.c | 6 ++++++
 sound/soc/codecs/rt298.h | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index 30c6de62ae6c..e67ef5f8d4f3 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -1225,6 +1225,12 @@ static int rt298_i2c_probe(struct i2c_client *i2c,
 	regmap_update_bits(rt298->regmap,
 				RT298_WIND_FILTER_CTRL, 0x0082, 0x0082);
 	regmap_update_bits(rt298->regmap, RT298_IRQ_CTRL, 0x2, 0x2);
+
+	regmap_write(rt298->regmap, RT298_UNSOLICITED_INLINE_CMD, 0x81);
+	regmap_write(rt298->regmap, RT298_UNSOLICITED_HP_OUT, 0x82);
+	regmap_write(rt298->regmap, RT298_UNSOLICITED_MIC1, 0x84);
+	regmap_update_bits(rt298->regmap, RT298_IRQ_FLAG_CTRL, 0x2, 0x2);
+
 	rt298->is_hp_in = -1;
 
 	if (rt298->i2c->irq) {
diff --git a/sound/soc/codecs/rt298.h b/sound/soc/codecs/rt298.h
index 31da16265f2b..d66f8847b676 100644
--- a/sound/soc/codecs/rt298.h
+++ b/sound/soc/codecs/rt298.h
@@ -34,6 +34,7 @@
 #define RT298_HP_OUT					0x21
 #define RT298_MIXER_IN1					0x22
 #define RT298_MIXER_IN2					0x23
+#define RT298_INLINE_CMD				0x55
 
 #define RT298_SET_PIN_SFT				6
 #define RT298_SET_PIN_ENABLE				0x40
@@ -124,6 +125,12 @@
 	VERB_CMD(AC_VERB_SET_COEF_INDEX, RT298_VENDOR_REGISTERS, 0)
 #define RT298_PROC_COEF\
 	VERB_CMD(AC_VERB_SET_PROC_COEF, RT298_VENDOR_REGISTERS, 0)
+#define RT298_UNSOLICITED_INLINE_CMD\
+	VERB_CMD(AC_VERB_SET_UNSOLICITED_ENABLE, RT298_INLINE_CMD, 0)
+#define RT298_UNSOLICITED_HP_OUT\
+	VERB_CMD(AC_VERB_SET_UNSOLICITED_ENABLE, RT298_HP_OUT, 0)
+#define RT298_UNSOLICITED_MIC1\
+	VERB_CMD(AC_VERB_SET_UNSOLICITED_ENABLE, RT298_MIC1, 0)
 
 /* Index registers */
 #define RT298_A_BIAS_CTRL1	0x01
@@ -148,6 +155,7 @@
 #define RT298_DEPOP_CTRL2	0x67
 #define RT298_DEPOP_CTRL3	0x68
 #define RT298_DEPOP_CTRL4	0x69
+#define RT298_IRQ_FLAG_CTRL	0x7c
 
 /* SPDIF (0x06) */
 #define RT298_SPDIF_SEL_SFT	0
-- 
2.7.0
