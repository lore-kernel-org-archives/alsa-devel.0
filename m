From: Xing Zheng <zhengxing@rock-chips.com>
Subject: [PATCH v2] ASoC: da7219: software reset codec at probe
Date: Wed, 14 Sep 2016 22:25:40 +0800
Message-ID: <1473863140-13678-1-git-send-email-zhengxing@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-rockchip@lists.infradead.org, Adam.Thomson.Opensource@diasemi.com
Cc: cychiang@google.com, heiko@sntech.de, smbarber@google.com, hychao@google.com, dianders@google.com, Hsin-Yu Chao <hychao@chromium.org>, Xing Zheng <zhengxing@rock-chips.com>, Support Opensource <support.opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Hsin-Yu Chao <hychao@chromium.org>

Da7219 does not trigger interrupt to report jack status
when system boots from warm reset because its power
remains on during warm reset.
Doing software reset at probe to handle this.

Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

Changes in v2:
- change the commit message for more clear explain

 sound/soc/codecs/da7219.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 737e914..9d08c11 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1941,6 +1941,14 @@ static int da7219_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	/* Software reset codec. */
+	regmap_write_bits(da7219->regmap, DA7219_ACCDET_CONFIG_1,
+			  DA7219_ACCDET_EN_MASK, 0);
+	regmap_write_bits(da7219->regmap, DA7219_CIF_CTRL,
+			  DA7219_CIF_REG_SOFT_RESET_MASK, 0);
+	regmap_write_bits(da7219->regmap, DA7219_SYSTEM_ACTIVE,
+			  DA7219_SYSTEM_ACTIVE_MASK, 0);
+
 	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_da7219,
 				     &da7219_dai, 1);
 	if (ret < 0) {
-- 
1.9.1
