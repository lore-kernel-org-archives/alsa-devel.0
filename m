From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5665: add clock sync control for
	master mode" to the asoc tree
Date: Thu, 20 Jul 2017 13:23:28 +0100
Message-ID: <E1dYAUK-00012a-R6@debutante>
References: <1500527271-11188-3-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 516E5266CC0
 for <alsa-devel@alsa-project.org>; Thu, 20 Jul 2017 14:23:47 +0200 (CEST)
In-Reply-To: <1500527271-11188-3-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5665: add clock sync control for master mode

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

>From 8bfa426845419d1fe895fc5668ab29b3a0c36c85 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Thu, 20 Jul 2017 13:07:51 +0800
Subject: [PATCH] ASoC: rt5665: add clock sync control for master mode

We can sleect the i2s clock source for each i2s bus in master mode.
The choice is depended on the HW design and the use case.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5665.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index ef27561c4993..7e64b25f8585 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -1381,6 +1381,16 @@ static void rt5665_jack_detect_handler(struct work_struct *work)
 	mutex_unlock(&rt5665->calibrate_mutex);
 }
 
+static const char * const rt5665_clk_sync[] = {
+	"I2S1_1", "I2S1_2", "I2S2", "I2S3", "IF2 Slave", "IF3 Slave"
+};
+
+static const struct soc_enum rt5665_enum[] = {
+	SOC_ENUM_SINGLE(RT5665_I2S1_SDP, 11, 5, rt5665_clk_sync),
+	SOC_ENUM_SINGLE(RT5665_I2S2_SDP, 11, 5, rt5665_clk_sync),
+	SOC_ENUM_SINGLE(RT5665_I2S3_SDP, 11, 5, rt5665_clk_sync),
+};
+
 static const struct snd_kcontrol_new rt5665_snd_controls[] = {
 	/* Headphone Output Volume */
 	SOC_DOUBLE_R_EXT_TLV("Headphone Playback Volume", RT5665_HPL_GAIN,
@@ -1446,6 +1456,11 @@ static const struct snd_kcontrol_new rt5665_snd_controls[] = {
 	SOC_DOUBLE_TLV("STO2 ADC Boost Gain Volume", RT5665_STO2_ADC_BOOST,
 		RT5665_STO2_ADC_L_BST_SFT, RT5665_STO2_ADC_R_BST_SFT,
 		3, 0, adc_bst_tlv),
+
+	/* I2S3 CLK Source */
+	SOC_ENUM("I2S1 Master Clk Sel", rt5665_enum[0]),
+	SOC_ENUM("I2S2 Master Clk Sel", rt5665_enum[1]),
+	SOC_ENUM("I2S3 Master Clk Sel", rt5665_enum[2]),
 };
 
 /**
-- 
2.13.2
