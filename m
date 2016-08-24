From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH] ASoC: rt5659: Enable IRQ output for GPIO1 pin
Date: Wed, 24 Aug 2016 12:03:39 -0700
Message-ID: <1472065419-22058-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, bardliao@realtek.com, oder_chiou@realtek.com
Cc: lgirdwood@gmail.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Since it's possible to have an IRQ without enabling JD3, the
GPIO1 pin then would remain its default GPIO function which
is set as an input direction (seeing from rt5659). Meanwhile,
CPU would also listen this connection via its own GPIO input:
      [input]          [input]
    CPU GPIO <--------> RT5659 GPIO1

The result for the IRQ on the CPU side will be unexpectable.

So this patch enables the IRQ output for GPIO1 pin any way
as long as there's an IRQ assigned from platform data or DT:
      [input]          [IRQ output]
    CPU GPIO <--------< RT5659 GPIO1

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/codecs/rt5659.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index 4c0d2b8..db54550 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -4189,6 +4189,9 @@ static int rt5659_i2c_probe(struct i2c_client *i2c,
 		if (ret)
 			dev_err(&i2c->dev, "Failed to reguest IRQ: %d\n", ret);
 
+		/* Enable IRQ output for GPIO1 pin any way */
+		regmap_update_bits(rt5659->regmap, RT5659_GPIO_CTRL_1,
+				   RT5659_GP1_PIN_MASK, RT5659_GP1_PIN_IRQ);
 	}
 
 	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5659,
-- 
2.1.4
