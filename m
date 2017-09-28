From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5670: add set_bclk_ratio in dai ops"
	to the asoc tree
Date: Thu, 28 Sep 2017 19:58:42 +0100 (BST)
Message-ID: <20170928185842.CFC0A440055@finisterre.ee.mobilebroadband>
References: <1505285417-15211-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E23442672B1
 for <alsa-devel@alsa-project.org>; Thu, 28 Sep 2017 20:59:20 +0200 (CEST)
In-Reply-To: <1505285417-15211-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5670: add set_bclk_ratio in dai ops

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

>From d0817657f615ecdf1c7beceade20c7d368003875 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Wed, 13 Sep 2017 14:50:17 +0800
Subject: [PATCH] ASoC: rt5670: add set_bclk_ratio in dai ops

We need to set a specific bit for 50 bclk rate. So add set_bclk_ratio
function to set the bit.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5670.c | 19 +++++++++++++++++++
 sound/soc/codecs/rt5670.h |  4 ++++
 2 files changed, 23 insertions(+)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index be945b345b43..c5094b4399e2 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -2600,6 +2600,24 @@ static int rt5670_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 	return 0;
 }
 
+static int rt5670_set_bclk_ratio(struct snd_soc_dai *dai, unsigned int ratio)
+{
+	struct snd_soc_codec *codec = dai->codec;
+
+	dev_dbg(codec->dev, "%s ratio=%d\n", __func__, ratio);
+	if (dai->id != RT5670_AIF1)
+		return 0;
+
+	if ((ratio % 50) == 0)
+		snd_soc_update_bits(codec, RT5670_GEN_CTRL3,
+			RT5670_TDM_DATA_MODE_SEL, RT5670_TDM_DATA_MODE_50FS);
+	else
+		snd_soc_update_bits(codec, RT5670_GEN_CTRL3,
+			RT5670_TDM_DATA_MODE_SEL, RT5670_TDM_DATA_MODE_NOR);
+
+	return 0;
+}
+
 static int rt5670_set_bias_level(struct snd_soc_codec *codec,
 			enum snd_soc_bias_level level)
 {
@@ -2730,6 +2748,7 @@ static const struct snd_soc_dai_ops rt5670_aif_dai_ops = {
 	.set_fmt = rt5670_set_dai_fmt,
 	.set_tdm_slot = rt5670_set_tdm_slot,
 	.set_pll = rt5670_set_dai_pll,
+	.set_bclk_ratio = rt5670_set_bclk_ratio,
 };
 
 static struct snd_soc_dai_driver rt5670_dai[] = {
diff --git a/sound/soc/codecs/rt5670.h b/sound/soc/codecs/rt5670.h
index 5ba485cae4e6..265df80d504e 100644
--- a/sound/soc/codecs/rt5670.h
+++ b/sound/soc/codecs/rt5670.h
@@ -1816,6 +1816,10 @@
 #define RT5670_ZCD_HP_DIS			(0x0 << 15)
 #define RT5670_ZCD_HP_EN			(0x1 << 15)
 
+/* General Control 3 (0xfc) */
+#define RT5670_TDM_DATA_MODE_SEL		(0x1 << 11)
+#define RT5670_TDM_DATA_MODE_NOR		(0x0 << 11)
+#define RT5670_TDM_DATA_MODE_50FS		(0x1 << 11)
 
 /* Codec Private Register definition */
 /* 3D Speaker Control (0x63) */
-- 
2.14.1
