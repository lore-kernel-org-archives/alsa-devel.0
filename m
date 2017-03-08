From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5665: enhance jack type detection
	function" to the asoc tree
Date: Wed, 08 Mar 2017 14:22:53 +0100
Message-ID: <E1clbYL-0000Fd-0s@finisterre>
References: <1488971136-19100-2-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DC08F267190
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 14:23:11 +0100 (CET)
In-Reply-To: <1488971136-19100-2-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, xiaoxiang@pinecone.net, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5665: enhance jack type detection function

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

>From 39841944c651f2e019d6e77aceb349a2695d8e2d Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Wed, 8 Mar 2017 19:05:30 +0800
Subject: [PATCH] ASoC: rt5665: enhance jack type detection function

Use manual mode for jack detection function to increase accuracy.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5665.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index b8c50ed72396..1baa9ce2648a 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -1193,10 +1193,13 @@ static int rt5665_headset_detect(struct snd_soc_codec *codec, int jack_insert)
 		}
 
 		regmap_update_bits(rt5665->regmap, RT5665_EJD_CTRL_1,
-			0x180, 0x180);
+			0x1a0, 0x120);
 		regmap_write(rt5665->regmap, RT5665_EJD_CTRL_3, 0x3424);
+		regmap_write(rt5665->regmap, RT5665_IL_CMD_1, 0x0048);
 		regmap_write(rt5665->regmap, RT5665_SAR_IL_CMD_1, 0xa291);
 
+		usleep_range(10000, 15000);
+
 		rt5665->sar_adc_value = snd_soc_read(rt5665->codec,
 			RT5665_SAR_IL_CMD_4) & 0x7ff;
 
@@ -4788,7 +4791,7 @@ static int rt5665_i2c_probe(struct i2c_client *i2c,
 
 	regmap_write(rt5665->regmap, RT5665_HP_LOGIC_CTRL_2, 0x0002);
 	regmap_update_bits(rt5665->regmap, RT5665_EJD_CTRL_1,
-		0xf000 | RT5665_VREF_POW_MASK, 0xd000 | RT5665_VREF_POW_REG);
+		0xf000 | RT5665_VREF_POW_MASK, 0xe000 | RT5665_VREF_POW_REG);
 	/* Work around for pow_pump */
 	regmap_update_bits(rt5665->regmap, RT5665_STO1_DAC_SIL_DET,
 		RT5665_DEB_STO_DAC_MASK, RT5665_DEB_80_MS);
-- 
2.11.0
