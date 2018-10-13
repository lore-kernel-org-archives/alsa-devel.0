From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 02/10] ASoC: sun8i-codec: Don't hardcode BCLK /
	LRCK ratio
Date: Fri, 12 Oct 2018 20:32:22 -0700
Message-ID: <20181013033230.6506-3-anarsoul@gmail.com>
References: <20181013033230.6506-1-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 01B222678CA
 for <alsa-devel@alsa-project.org>; Sat, 13 Oct 2018 05:32:47 +0200 (CEST)
Received: by mail-pf1-f195.google.com with SMTP id g21-v6so96691pfi.7
 for <alsa-devel@alsa-project.org>; Fri, 12 Oct 2018 20:32:47 -0700 (PDT)
In-Reply-To: <20181013033230.6506-1-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Marcus Cooper <codekipper@gmail.com>, Mylene JOSSERAND <mylene.josserand@free-electrons.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
List-Id: alsa-devel@alsa-project.org

BCLK / LRCK ratio should be sample size * channels, but it was
hardcoded to 32 (0x1 is 32 as per A33 and A64 datasheets).

Calculate it basing on sample size and number of channels.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/soc/sunxi/sun8i-codec.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index fb37dd927e33..e681e194ad4c 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -52,7 +52,6 @@
 #define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_INV		13
 #define SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV		9
 #define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV		6
-#define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_16		(1 << 6)
 #define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ		4
 #define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_16		(1 << 4)
 #define SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT		2
@@ -257,8 +256,8 @@ static int sun8i_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 }
 
 struct sun8i_codec_clk_div {
-	u8	div;
-	u8	val;
+	unsigned int	div;
+	u8		val;
 };
 
 static const struct sun8i_codec_clk_div sun8i_codec_bclk_div[] = {
@@ -300,12 +299,33 @@ static u8 sun8i_codec_get_bclk_div(struct sun8i_codec *scodec,
 	return best_val;
 }
 
+static const struct sun8i_codec_clk_div sun8i_codec_lrck_div[] = {
+	{ .div = 16,	.val = 0 },
+	{ .div = 32,	.val = 1 },
+	{ .div = 64,	.val = 2 },
+	{ .div = 128,	.val = 3 },
+	{ .div = 256,	.val = 4 },
+};
+
+static int sun8i_codec_get_lrck_div(unsigned int channels,
+				    unsigned int word_size)
+{
+	unsigned int div = word_size * channels;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sun8i_codec_lrck_div); i++)
+		if (sun8i_codec_lrck_div[i].div == div)
+			return sun8i_codec_lrck_div[i].val;
+
+	return -EINVAL;
+}
+
 static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *dai)
 {
 	struct sun8i_codec *scodec = snd_soc_component_get_drvdata(dai->component);
-	int sample_rate;
+	int sample_rate, lrck_div;
 	u8 bclk_div;
 
 	/*
@@ -321,9 +341,14 @@ static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
 			   SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK,
 			   bclk_div << SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV);
 
+	lrck_div = sun8i_codec_get_lrck_div(params_channels(params),
+					    params_physical_width(params));
+	if (lrck_div < 0)
+		return lrck_div;
+
 	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
 			   SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_MASK,
-			   SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_16);
+			   lrck_div << SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV);
 
 	sample_rate = sun8i_codec_get_hw_rate(params);
 	if (sample_rate < 0)
-- 
2.19.0
