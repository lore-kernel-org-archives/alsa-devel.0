From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5616: add the mclk for the codec
	driver" to the asoc tree
Date: Thu, 28 Jan 2016 23:51:57 +0100
Message-ID: <E1aOvPx-00045M-Cc@finisterre>
References: <1453970618-4383-9-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 50CBA2659A4
 for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2016 23:52:11 +0100 (CET)
In-Reply-To: <1453970618-4383-9-git-send-email-wxt@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caesar Wang <wxt@rock-chips.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5616: add the mclk for the codec driver

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

>From 76d3204eaa9364a662f0fe0f075dfe61e6bd14fe Mon Sep 17 00:00:00 2001
From: Caesar Wang <wxt@rock-chips.com>
Date: Thu, 28 Jan 2016 16:43:37 +0800
Subject: [PATCH] ASoC: rt5616: add the mclk for the codec driver

This patch adds the code to enable the clock to the CODEC driver
if it needs the clock enabled.

In some case, We need to claim the clock which is driving the codec
so that when we enable clock gating, we continue to clock the codec
when needed.

if mclk provided, to enable and disable the clock source.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5616.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/sound/soc/codecs/rt5616.c b/sound/soc/codecs/rt5616.c
index d4bdf9f..fdca636 100644
--- a/sound/soc/codecs/rt5616.c
+++ b/sound/soc/codecs/rt5616.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
@@ -144,6 +145,7 @@ struct rt5616_priv {
 	struct snd_soc_codec *codec;
 	struct delayed_work patch_work;
 	struct regmap *regmap;
+	struct clk *mclk;
 
 	int sysclk;
 	int sysclk_src;
@@ -1159,7 +1161,34 @@ static int rt5616_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
 static int rt5616_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
+	struct rt5616_priv *rt5616 = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
 	switch (level) {
+
+	case SND_SOC_BIAS_ON:
+		break;
+
+	case SND_SOC_BIAS_PREPARE:
+		/*
+		 * SND_SOC_BIAS_PREPARE is called while preparing for a
+		 * transition to ON or away from ON. If current bias_level
+		 * is SND_SOC_BIAS_ON, then it is preparing for a transition
+		 * away from ON. Disable the clock in that case, otherwise
+		 * enable it.
+		 */
+		if (IS_ERR(rt5616->mclk))
+			break;
+
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_ON) {
+			clk_disable_unprepare(rt5616->mclk);
+		} else {
+			ret = clk_prepare_enable(rt5616->mclk);
+			if (ret)
+				return ret;
+		}
+		break;
+
 	case SND_SOC_BIAS_STANDBY:
 		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
 			snd_soc_update_bits(codec, RT5616_PWR_ANLG1,
@@ -1198,6 +1227,11 @@ static int rt5616_probe(struct snd_soc_codec *codec)
 {
 	struct rt5616_priv *rt5616 = snd_soc_codec_get_drvdata(codec);
 
+	/* Check if MCLK provided */
+	rt5616->mclk = devm_clk_get(codec->dev, "mclk");
+	if (PTR_ERR(rt5616->mclk) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
 	rt5616->codec = codec;
 
 	return 0;
-- 
2.6.4
