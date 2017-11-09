From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH] ASoC: sun8i-codec: Add a comment on the LRCK
	inversion
Date: Thu,  9 Nov 2017 10:40:46 +0100
Message-ID: <20171109094046.13483-1-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id EA0702674B5
 for <alsa-devel@alsa-project.org>; Thu,  9 Nov 2017 10:40:58 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: alsa-devel@alsa-project.org, Mylene Josserand <mylene.josserand@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The current code might be a bit intriguing without having experienced the
issue before, and might come up as a mistake.

Make explicit what's going on by adding a comment.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 sound/soc/sunxi/sun8i-codec.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 7a312168f864..3dd183be08a4 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -198,6 +198,17 @@ static int sun8i_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
 			   BIT(SUN8I_AIF1CLK_CTRL_AIF1_BCLK_INV),
 			   value << SUN8I_AIF1CLK_CTRL_AIF1_BCLK_INV);
+
+	/*
+	 * It appears that the DAI and the codec don't share the same
+	 * polarity for the LRCK signal when they mean 'normal' and
+	 * 'inverted' in the datasheet.
+	 *
+	 * Since the DAI here is our regular i2s driver that have been
+	 * tested with way more codecs than just this one, it means
+	 * that the codec probably gets it backward, and we have to
+	 * invert the value here.
+	 */
 	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
 			   BIT(SUN8I_AIF1CLK_CTRL_AIF1_LRCK_INV),
 			   !value << SUN8I_AIF1CLK_CTRL_AIF1_LRCK_INV);
-- 
2.14.3
