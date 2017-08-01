From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5663: Add the delay time to correct
	the calibration" to the asoc tree
Date: Tue, 01 Aug 2017 15:16:49 +0100
Message-ID: <E1dcXyb-0008Rn-BW@debutante>
References: <1501586042-15589-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CE340267198
 for <alsa-devel@alsa-project.org>; Tue,  1 Aug 2017 16:16:57 +0200 (CEST)
In-Reply-To: <1501586042-15589-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5663: Add the delay time to correct the calibration

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

>From c1bbaff6d7dd55314ee453df8dfe00befd7ce1b2 Mon Sep 17 00:00:00 2001
From: "oder_chiou@realtek.com" <oder_chiou@realtek.com>
Date: Tue, 1 Aug 2017 19:14:02 +0800
Subject: [PATCH] ASoC: rt5663: Add the delay time to correct the calibration

The patch adds the delay time to correct the calibration.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5663.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index 45f8a9888f7d..c1f0a72c0133 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -3058,6 +3058,7 @@ static void rt5663_calibrate(struct rt5663_priv *rt5663)
 	regmap_write(rt5663->regmap, RT5663_PWR_ANLG_3, 0x018c);
 	regmap_write(rt5663->regmap, RT5663_HP_CHARGE_PUMP_1, 0x1e32);
 	regmap_write(rt5663->regmap, RT5663_DACREF_LDO, 0x3b0b);
+	msleep(40);
 	regmap_write(rt5663->regmap, RT5663_STO_DAC_MIXER, 0x0000);
 	regmap_write(rt5663->regmap, RT5663_BYPASS_STO_DAC, 0x000c);
 	regmap_write(rt5663->regmap, RT5663_HP_BIAS, 0xafaa);
-- 
2.13.2
