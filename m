From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: add DAC1 soft volume func
	control" to the asoc tree
Date: Thu, 07 Jul 2016 14:24:11 +0200
Message-ID: <E1bL8Lj-00028t-H0@finisterre>
References: <1467888991-27697-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 23973265232
 for <alsa-devel@alsa-project.org>; Thu,  7 Jul 2016 14:24:51 +0200 (CEST)
In-Reply-To: <1467888991-27697-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, koro.chen@mediatek.com, broonie@kernel.org, PC.Liao@mediatek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: add DAC1 soft volume func control

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

>From 467b147982bb063369a1222523fa503e0c077c30 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Thu, 7 Jul 2016 18:56:31 +0800
Subject: [PATCH] ASoC: rt5645: add DAC1 soft volume func control

This patch add an alsa control for DAC1 digital volume control function
selection. The options are:
0: Gain update immediately
1: Gain update when a zero crossing
2: Gain update when a zero crossing with a soft ramp

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 11 +++++++++++
 sound/soc/codecs/rt5645.h |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 97bf96e2c57b..dbf05600b5ff 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -741,6 +741,14 @@ static int rt5645_spk_put_volsw(struct snd_kcontrol *kcontrol,
 	return ret;
 }
 
+static const char * const rt5645_dac1_vol_ctrl_mode_text[] = {
+	"immediately", "zero crossing", "soft ramp"
+};
+
+static SOC_ENUM_SINGLE_DECL(
+	rt5645_dac1_vol_ctrl_mode, RT5645_PR_BASE,
+	RT5645_DA1_ZDET_SFT, rt5645_dac1_vol_ctrl_mode_text);
+
 static const struct snd_kcontrol_new rt5645_snd_controls[] = {
 	/* Speaker Output Volume */
 	SOC_DOUBLE("Speaker Channel Switch", RT5645_SPK_VOL,
@@ -807,6 +815,9 @@ static const struct snd_kcontrol_new rt5645_snd_controls[] = {
 	SOC_SINGLE("I2S2 Func Switch", RT5645_GPIO_CTRL1, RT5645_I2S2_SEL_SFT,
 		1, 1),
 	RT5645_HWEQ("Speaker HWEQ"),
+
+	/* Digital Soft Volume Control */
+	SOC_ENUM("DAC1 Digital Volume Control Func", rt5645_dac1_vol_ctrl_mode),
 };
 
 /**
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index 205e0715c99a..cfc5f97549eb 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -2018,6 +2018,9 @@
 
 
 /* Codec Private Register definition */
+/* DAC ADC Digital Volume (0x00) */
+#define RT5645_DA1_ZDET_SFT			6
+
 /* 3D Speaker Control (0x63) */
 #define RT5645_3D_SPK_MASK			(0x1 << 15)
 #define RT5645_3D_SPK_SFT			15
-- 
2.8.1
