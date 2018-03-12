From: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH v2 6/6] ASoC: sun4i-i2s: Add support for loopback
Date: Mon, 12 Mar 2018 16:57:53 +0100
Message-ID: <20180312155753.9478-7-codekipper@gmail.com>
References: <20180312155753.9478-1-codekipper@gmail.com>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCHNXO4F7MHBBDGHTLKQKGQEAHJ2RTY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20180312155753.9478-1-codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org, Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

The DAI has a loopback register which can be set and therefore routes
the transmit fifo to receive fifo. This is useful for testing the block
without the need for any external hardware.

Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/sun4i-i2s.txt |  3 +++
 sound/soc/sunxi/sun4i-i2s.c                           | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
index 3f966ac61b9e..325e3d4571f1 100644
--- a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
@@ -32,6 +32,9 @@ Optional properties:
 - allwinner,slot-width-override:if this property is present then the dai is
 				configured to extend the slot width to the
 				value specified. Min 8, Max 32.
+- loopback:	if this property is present then the dai is configured in
+		loopback mode where the output fifo is redirected to the input
+		fifo.
 
 - allwinner,playback-channels:  if this property is present then the number
 				of available channels is extended and the
diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 7cf4dfe440de..a3c33814d33e 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -31,6 +31,7 @@
 #define SUN4I_I2S_CTRL_MODE_MASK		BIT(5)
 #define SUN4I_I2S_CTRL_MODE_SLAVE			(1 << 5)
 #define SUN4I_I2S_CTRL_MODE_MASTER			(0 << 5)
+#define SUN4I_I2S_CTRL_LOOP			BIT(3)
 #define SUN4I_I2S_CTRL_TX_EN			BIT(2)
 #define SUN4I_I2S_CTRL_RX_EN			BIT(1)
 #define SUN4I_I2S_CTRL_GL_EN			BIT(0)
@@ -195,6 +196,8 @@ struct sun4i_i2s {
 
 	const struct sun4i_i2s_quirks	*variant;
 
+	bool loopback;
+
 	unsigned int	slot_width;
 };
 
@@ -639,6 +642,11 @@ static void sun4i_i2s_start_capture(struct sun4i_i2s *i2s)
 	regmap_update_bits(i2s->regmap, SUN4I_I2S_DMA_INT_CTRL_REG,
 			   SUN4I_I2S_DMA_INT_CTRL_RX_DRQ_EN,
 			   SUN4I_I2S_DMA_INT_CTRL_RX_DRQ_EN);
+
+	/* Debugging without codec */
+	if (i2s->loopback)
+		regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
+				   SUN4I_I2S_CTRL_LOOP, SUN4I_I2S_CTRL_LOOP);
 }
 
 static void sun4i_i2s_start_playback(struct sun4i_i2s *i2s)
@@ -1204,6 +1212,9 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 			soc_dai->playback.channels_max = val;
 	}
 
+	if (of_property_read_bool(pdev->dev.of_node, "loopback"))
+		i2s->loopback = true;
+
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev)) {
 		ret = sun4i_i2s_runtime_resume(&pdev->dev);
-- 
2.16.2
