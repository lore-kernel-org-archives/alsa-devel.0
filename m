From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: sun4i-i2s: Use PTR_ERR_OR_ZERO in sun4i_i2s_init_regmap_fields()
Date: Thu, 22 Aug 2019 06:52:52 +0000
Message-ID: <20190822065252.74028-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Marcus Cooper <codekipper@gmail.com>, Vasily Khoruzhick <anarsoul@gmail.com>
Cc: YueHaibing <yuehaibing@huawei.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 9e691baee1e8..2071c54265f3 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1095,10 +1095,7 @@ static int sun4i_i2s_init_regmap_fields(struct device *dev,
 	i2s->field_fmt_sr =
 			devm_regmap_field_alloc(dev, i2s->regmap,
 						i2s->variant->field_fmt_sr);
-	if (IS_ERR(i2s->field_fmt_sr))
-		return PTR_ERR(i2s->field_fmt_sr);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(i2s->field_fmt_sr);
 }
 
 static int sun4i_i2s_probe(struct platform_device *pdev)
