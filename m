From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42l56: Fix misuse of regmap_update_bits" to the asoc tree
Date: Mon, 05 Dec 2016 13:53:43 +0000
Message-ID: <E1cDtiB-00066q-5w@finisterre>
References: <1480439449-15975-1-git-send-email-florian.vaussard@heig-vd.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480439449-15975-1-git-send-email-florian.vaussard@heig-vd.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Vaussard <florian.vaussard@gmail.com>
Cc: Florian Vaussard <florian.vaussard@heig-vd.ch>, Brian Austin <brian.austin@cirrus.com>, Mark Brown <broonie@kernel.org>Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.orgFlorian Vaussard <florian.vaussard@heig-vd.ch>, Takashi Iwai <tiwai@suse.com>Mark Brown <broonie@kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs42l56: Fix misuse of regmap_update_bits

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

>From 8c317fafdd4e3b988c44d986022c66cebf71fc41 Mon Sep 17 00:00:00 2001
From: Florian Vaussard <florian.vaussard@gmail.com>
Date: Tue, 29 Nov 2016 18:10:49 +0100
Subject: [PATCH] ASoC: cs42l56: Fix misuse of regmap_update_bits

Using regmap_update_bits(..., mask, 1) with 'mask' following (1 << k)
and k greater than 0 is wrong. Indeed, _regmap_update_bits will perform
(mask & 1), which results in 0 if LSB of mask is 0. Thus the call
regmap_update_bits(..., mask, 1) is in reality equivalent to
regmap_update_bits(..., mask, 0).

In such a case, the correct use is regmap_update_bits(..., mask, mask).

This driver is performing such a mistake with the CS42L56_AIN*_REF_MASK
masks, which equal 0x10, 0x20, 0x40 and 0x80. Fix the driver to make it
consistent with the API. Please note that this change is untested,
as I do not have this piece of hardware. Testers are welcome!

Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Acked-by: Brian Austin <brian.austin@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l56.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index 3e2c04642f1e..cb6ca85f1536 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -1277,19 +1277,23 @@ static int cs42l56_i2c_probe(struct i2c_client *i2c_client,
 
 	if (cs42l56->pdata.ain1a_ref_cfg)
 		regmap_update_bits(cs42l56->regmap, CS42L56_AIN_REFCFG_ADC_MUX,
-				   CS42L56_AIN1A_REF_MASK, 1);
+				   CS42L56_AIN1A_REF_MASK,
+				   CS42L56_AIN1A_REF_MASK);
 
 	if (cs42l56->pdata.ain1b_ref_cfg)
 		regmap_update_bits(cs42l56->regmap, CS42L56_AIN_REFCFG_ADC_MUX,
-				   CS42L56_AIN1B_REF_MASK, 1);
+				   CS42L56_AIN1B_REF_MASK,
+				   CS42L56_AIN1B_REF_MASK);
 
 	if (cs42l56->pdata.ain2a_ref_cfg)
 		regmap_update_bits(cs42l56->regmap, CS42L56_AIN_REFCFG_ADC_MUX,
-				   CS42L56_AIN2A_REF_MASK, 1);
+				   CS42L56_AIN2A_REF_MASK,
+				   CS42L56_AIN2A_REF_MASK);
 
 	if (cs42l56->pdata.ain2b_ref_cfg)
 		regmap_update_bits(cs42l56->regmap, CS42L56_AIN_REFCFG_ADC_MUX,
-				   CS42L56_AIN2B_REF_MASK, 1);
+				   CS42L56_AIN2B_REF_MASK,
+				   CS42L56_AIN2B_REF_MASK);
 
 	if (cs42l56->pdata.micbias_lvl)
 		regmap_update_bits(cs42l56->regmap, CS42L56_GAIN_BIAS_CTL,
-- 
2.10.2
