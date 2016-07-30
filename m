From: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH v2 2/2] ASoC: sunxi: compatibility for sun6i to SPDIF
Date: Sat, 30 Jul 2016 17:56:38 +0200
Message-ID: <20160730155638.24455-3-codekipper@gmail.com>
References: <20160730155638.24455-1-codekipper@gmail.com>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCHNXO4F7MHBBPE46O6AKGQEYX55TLY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160730155638.24455-1-codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

The A31 SoC uses the same SPDIF block as found in earlier SoCs, but its
reset is controlled via a separate reset controller.

The DMA also complains when the maxburst is set to 4 so it's been adjusted
to 8 which suites both the older and newer SoCs.

Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 sound/soc/sunxi/sun4i-spdif.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index 0b04fb0..88fbb3a 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -29,6 +29,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include <sound/dmaengine_pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -162,6 +163,7 @@ struct sun4i_spdif_dev {
 	struct platform_device *pdev;
 	struct clk *spdif_clk;
 	struct clk *apb_clk;
+	struct reset_control *rst;
 	struct snd_soc_dai_driver cpu_dai_drv;
 	struct regmap *regmap;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
@@ -411,6 +413,7 @@ static const struct snd_soc_dapm_route dit_routes[] = {
 
 static const struct of_device_id sun4i_spdif_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-spdif", },
+	{ .compatible = "allwinner,sun6i-a31-spdif", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_spdif_of_match);
@@ -482,11 +485,23 @@ static int sun4i_spdif_probe(struct platform_device *pdev)
 	}
 
 	host->dma_params_tx.addr = res->start + SUN4I_SPDIF_TXFIFO;
-	host->dma_params_tx.maxburst = 4;
+	host->dma_params_tx.maxburst = 8;
 	host->dma_params_tx.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 
 	platform_set_drvdata(pdev, host);
 
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "allwinner,sun6i-a31-spdif")) {
+		host->rst = devm_reset_control_get_optional(&pdev->dev, NULL);
+		if (IS_ERR(host->rst) && PTR_ERR(host->rst) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			dev_err(&pdev->dev, "Failed to get reset: %d\n", ret);
+			goto err_disable_apb_clk;
+		}
+		if (!IS_ERR(host->rst))
+			reset_control_deassert(host->rst);
+	}
+
 	ret = devm_snd_soc_register_component(&pdev->dev,
 				&sun4i_spdif_component, &sun4i_spdif_dai, 1);
 	if (ret)
-- 
2.9.2
