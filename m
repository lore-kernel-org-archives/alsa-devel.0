From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 4/9] ASoC: sun8i-codec: Add support for A64 SoC
Date: Sun,  3 Dec 2017 12:41:52 -0800
Message-ID: <20171203204157.20829-5-anarsoul@gmail.com>
References: <20171203204157.20829-1-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
 [209.85.192.196])
 by alsa0.perex.cz (Postfix) with ESMTP id E8C7E26710B
 for <alsa-devel@alsa-project.org>; Sun,  3 Dec 2017 21:42:06 +0100 (CET)
Received: by mail-pf0-f196.google.com with SMTP id y89so6994264pfk.0
 for <alsa-devel@alsa-project.org>; Sun, 03 Dec 2017 12:42:06 -0800 (PST)
In-Reply-To: <20171203204157.20829-1-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Marcus Cooper <codekipper@gmail.com>, =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
List-Id: alsa-devel@alsa-project.org

Digital part of audio codec block in the A64 is very similar to what
is used by the A33(sun8i) devices. However, it uses different LRCK
divider.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../bindings/sound/{sun8i-a33-codec.txt => sun8i-codec.txt}      | 6 ++++--
 sound/soc/sunxi/sun8i-codec.c                                    | 9 +++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/sound/{sun8i-a33-codec.txt => sun8i-codec.txt} (91%)

diff --git a/Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt b/Documentation/devicetree/bindings/sound/sun8i-codec.txt
similarity index 91%
rename from Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt
rename to Documentation/devicetree/bindings/sound/sun8i-codec.txt
index 2ca3d138528e..ffcf9079a67c 100644
--- a/Documentation/devicetree/bindings/sound/sun8i-a33-codec.txt
+++ b/Documentation/devicetree/bindings/sound/sun8i-codec.txt
@@ -1,7 +1,7 @@
 Allwinner SUN8I audio codec
 ------------------------------------
 
-On Sun8i-A33 SoCs, the audio is separated in different parts:
+On Sun8i-A33 and Sun50i-A64 SoCs, the audio is separated in different parts:
 	  - A DAI driver. It uses the "sun4i-i2s" driver which is
 	  documented here:
 	  Documentation/devicetree/bindings/sound/sun4i-i2s.txt
@@ -16,7 +16,9 @@ On Sun8i-A33 SoCs, the audio is separated in different parts:
 This bindings documentation exposes Sun8i codec (digital part).
 
 Required properties:
-- compatible: must be "allwinner,sun8i-a33-codec"
+- compatible: should be one of the following:
+   - "allwinner,sun8i-a33-codec"
+   - "allwinner,sun50i-a64-codec"
 - reg: must contain the registers location and length
 - interrupts: must contain the codec interrupt
 - clocks: a list of phandle + clock-specifer pairs, one for each entry
diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 054201d1de03..0e2a5adcfb96 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -52,6 +52,7 @@
 #define SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV		9
 #define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV		6
 #define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_16		(1 << 6)
+#define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_64		(2 << 6)
 #define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ		4
 #define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_16		(1 << 4)
 #define SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT		2
@@ -456,6 +457,10 @@ static const struct sun8i_codec_quirks sun8i_a33_codec_quirks = {
 	.aif1_lrck_div	= SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_16,
 };
 
+static const struct sun8i_codec_quirks sun50i_a64_codec_quirks = {
+	.aif1_lrck_div	= SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_64,
+};
+
 static int sun8i_codec_probe(struct platform_device *pdev)
 {
 	struct resource *res_base;
@@ -551,6 +556,10 @@ static const struct of_device_id sun8i_codec_of_match[] = {
 		.compatible = "allwinner,sun8i-a33-codec",
 		.data = &sun8i_a33_codec_quirks,
 	},
+	{
+		.compatible = "allwinner,sun50i-a64-codec",
+		.data = &sun50i_a64_codec_quirks,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sun8i_codec_of_match);
-- 
2.15.0
