From: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH v3 01/12] ASoC: sun4i-i2s: Extend quirks scope
Date: Sat, 29 Jul 2017 16:17:42 +0200
Message-ID: <20170729141753.20174-2-codekipper@gmail.com>
References: <20170729141753.20174-1-codekipper@gmail.com>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCHNXO4F7MHBBFNS6LFQKGQELIML7YY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170729141753.20174-1-codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org, Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

In preparation for the changes required to support newer SoCs then
quirks has been moved and also added to the device structure.

Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 62b307b0c846..d7ee7a443e4e 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -90,6 +90,15 @@
 #define SUN4I_I2S_RX_CHAN_SEL_REG	0x38
 #define SUN4I_I2S_RX_CHAN_MAP_REG	0x3c
 
+/**
+ * struct sun4i_i2s_quirks - Differences between SoC variants.
+ *
+ * @has_reset: SoC needs reset deasserted.
+ */
+struct sun4i_i2s_quirks {
+	bool				has_reset;
+};
+
 struct sun4i_i2s {
 	struct clk	*bus_clk;
 	struct clk	*mod_clk;
@@ -100,6 +109,8 @@ struct sun4i_i2s {
 
 	struct snd_dmaengine_dai_dma_data	capture_dma_data;
 	struct snd_dmaengine_dai_dma_data	playback_dma_data;
+
+	const struct sun4i_i2s_quirks	*variant;
 };
 
 struct sun4i_i2s_clk_div {
@@ -654,10 +665,6 @@ static int sun4i_i2s_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-struct sun4i_i2s_quirks {
-	bool has_reset;
-};
-
 static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
 	.has_reset	= false,
 };
@@ -669,7 +676,6 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
 static int sun4i_i2s_probe(struct platform_device *pdev)
 {
 	struct sun4i_i2s *i2s;
-	const struct sun4i_i2s_quirks *quirks;
 	struct resource *res;
 	void __iomem *regs;
 	int irq, ret;
@@ -690,8 +696,8 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 		return irq;
 	}
 
-	quirks = of_device_get_match_data(&pdev->dev);
-	if (!quirks) {
+	i2s->variant = of_device_get_match_data(&pdev->dev);
+	if (!i2s->variant) {
 		dev_err(&pdev->dev, "Failed to determine the quirks to use\n");
 		return -ENODEV;
 	}
@@ -715,7 +721,7 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 		return PTR_ERR(i2s->mod_clk);
 	}
 
-	if (quirks->has_reset) {
+	if (i2s->variant->has_reset) {
 		i2s->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 		if (IS_ERR(i2s->rst)) {
 			dev_err(&pdev->dev, "Failed to get reset control\n");
-- 
2.13.3
