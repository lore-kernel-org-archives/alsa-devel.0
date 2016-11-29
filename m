From: Florian Vaussard <florian.vaussard@gmail.com>
Subject: [PATCH] ASoC: cs42l56: Fix misuse of regmap_update_bits
Date: Tue, 29 Nov 2016 18:10:49 +0100
Message-ID: <1480439449-15975-1-git-send-email-florian.vaussard@heig-vd.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Florian Vaussard <florian.vaussard@heig-vd.ch>
List-Id: alsa-devel@alsa-project.org

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
---
 sound/soc/codecs/cs42l56.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index 3e2c046..cb6ca85 100644
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
2.5.5
