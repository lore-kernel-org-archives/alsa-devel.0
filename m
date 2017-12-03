From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 6/9] ASoC: sun8i-codec-analog: Add component driver field to
 quirks structure
Date: Sun,  3 Dec 2017 12:41:54 -0800
Message-ID: <20171203204157.20829-7-anarsoul@gmail.com>
References: <20171203204157.20829-1-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171203204157.20829-1-anarsoul@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Marcus Cooper <codekipper@gmail.com>, =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
List-Id: alsa-devel@alsa-project.org

This is necessary for upcoming addition of A64 support. A64 uses
the same DAPM routes, but slightly different widgets. Use approach from
sun4i-codec driver and pass appropriate component driver through quirks.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/soc/sunxi/sun8i-codec-analog.c | 57 +++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec-analog.c b/sound/soc/sunxi/sun8i-codec-analog.c
index 384f582b6f69..4e39d2668286 100644
--- a/sound/soc/sunxi/sun8i-codec-analog.c
+++ b/sound/soc/sunxi/sun8i-codec-analog.c
@@ -759,24 +759,6 @@ struct sun8i_codec_analog_quirks {
 	int (*add_lineout)(struct snd_soc_component *cmpnt);
 };
 
-static const struct sun8i_codec_analog_quirks sun8i_a23_quirks = {
-	.has_headphone	= true,
-	.has_hmic	= true,
-	.has_linein	= true,
-	.has_mbias	= true,
-	.has_mic2	= true,
-	.add_headphone	= sun8i_a23_codec_add_headphone,
-};
-
-static const struct sun8i_codec_analog_quirks sun8i_h3_quirks = {
-	.has_linein	= true,
-	.has_lineout	= true,
-	.has_mbias	= true,
-	.has_mic2	= true,
-	.add_lineout	= sun8i_h3_codec_add_lineout,
-};
-
-
 static int sun8i_codec_analog_add_mixer(struct snd_soc_component *cmpnt,
 					const struct sun8i_codec_analog_quirks *quirks)
 {
@@ -819,11 +801,6 @@ static int sun8i_codec_analog_add_mixer(struct snd_soc_component *cmpnt,
 	return 0;
 }
 
-static const struct sun8i_codec_analog_quirks sun8i_v3s_quirks = {
-	.has_headphone	= true,
-	.has_hmic	= true,
-};
-
 static int sun8i_codec_analog_cmpnt_probe(struct snd_soc_component *cmpnt)
 {
 	struct device *dev = cmpnt->dev;
@@ -891,6 +868,31 @@ static const struct snd_soc_component_driver sun8i_codec_analog_cmpnt_drv = {
 	.probe			= sun8i_codec_analog_cmpnt_probe,
 };
 
+static const struct sun8i_codec_analog_quirks sun8i_a23_quirks = {
+	.has_headphone	= true,
+	.has_hmic	= true,
+	.has_linein	= true,
+	.has_mbias	= true,
+	.has_mic2	= true,
+	.add_headphone	= sun8i_a23_codec_add_headphone,
+	.cmpnt_drv	= &sun8i_codec_analog_cmpnt_drv,
+};
+
+static const struct sun8i_codec_analog_quirks sun8i_h3_quirks = {
+	.has_linein	= true,
+	.has_lineout	= true,
+	.has_mbias	= true,
+	.has_mic2	= true,
+	.add_lineout	= sun8i_h3_codec_add_lineout,
+	.cmpnt_drv	= &sun8i_codec_analog_cmpnt_drv,
+};
+
+static const struct sun8i_codec_analog_quirks sun8i_v3s_quirks = {
+	.has_headphone	= true,
+	.has_hmic	= true,
+	.cmpnt_drv	= &sun8i_codec_analog_cmpnt_drv,
+};
+
 static const struct of_device_id sun8i_codec_analog_of_match[] = {
 	{
 		.compatible = "allwinner,sun8i-a23-codec-analog",
@@ -913,6 +915,13 @@ static int sun8i_codec_analog_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct regmap *regmap;
 	void __iomem *base;
+	const struct sun8i_codec_analog_quirks *quirks;
+
+	quirks = of_device_get_match_data(&pdev->dev);
+	if (quirks == NULL) {
+		dev_err(&pdev->dev, "Failed to determine the quirks to use\n");
+		return -ENODEV;
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
@@ -928,7 +937,7 @@ static int sun8i_codec_analog_probe(struct platform_device *pdev)
 	}
 
 	return devm_snd_soc_register_component(&pdev->dev,
-					       &sun8i_codec_analog_cmpnt_drv,
+					       quirks->cmpnt_drv,
 					       NULL, 0);
 }
 
-- 
2.15.0
