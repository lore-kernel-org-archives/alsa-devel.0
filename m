From: Icenowy Zheng <icenowy@aosc.xyz>
Subject: [PATCH 5/9] dmaengine: sun6i: support V3s SoC variant
Date: Sat, 25 Feb 2017 20:30:25 +0800
Message-ID: <20170225123029.55939-5-icenowy@aosc.xyz>
References: <20170225123029.55939-1-icenowy@aosc.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward7p.cmail.yandex.net (forward7p.cmail.yandex.net
 [87.250.241.192])
 by alsa0.perex.cz (Postfix) with ESMTP id B861726713F
 for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2017 13:32:18 +0100 (CET)
In-Reply-To: <20170225123029.55939-1-icenowy@aosc.xyz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.xyz>, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Allwinner V3s has a DMA engine similar to the ones from A31, but with
fewer channels and DRQs.

Add support for it.

As it also needs the special gate bit, make the gate bit generic.

According to BSP source code, SUN8IW6 (A83T) also needs the bit, so it
have also been specified gate_needed property.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 Documentation/devicetree/bindings/dma/sun6i-dma.txt |  1 +
 drivers/dma/sun6i-dma.c                             | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/sun6i-dma.txt b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
index 6b267045f522..98fbe1a5c6dd 100644
--- a/Documentation/devicetree/bindings/dma/sun6i-dma.txt
+++ b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
@@ -9,6 +9,7 @@ Required properties:
 		  "allwinner,sun8i-a23-dma"
 		  "allwinner,sun8i-a83t-dma"
 		  "allwinner,sun8i-h3-dma"
+		  "allwinner,sun8i-v3s-dma"
 - reg:		Should contain the registers base address and length
 - interrupts:	Should contain a reference to the interrupt used by this device
 - clocks:	Should contain a reference to the parent AHB clock
diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index a2358780ab2c..1f38424c1b14 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -101,6 +101,7 @@ struct sun6i_dma_config {
 	u32 nr_max_channels;
 	u32 nr_max_requests;
 	u32 nr_max_vchans;
+	bool gate_needed;
 };
 
 /*
@@ -1009,12 +1010,14 @@ static struct sun6i_dma_config sun8i_a23_dma_cfg = {
 	.nr_max_channels = 8,
 	.nr_max_requests = 24,
 	.nr_max_vchans   = 37,
+	.gate_needed	 = true,
 };
 
 static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
 	.nr_max_channels = 8,
 	.nr_max_requests = 28,
 	.nr_max_vchans   = 39,
+	.gate_needed	 = true,
 };
 
 /*
@@ -1028,11 +1031,19 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg = {
 	.nr_max_vchans   = 34,
 };
 
+static struct sun6i_dma_config sun8i_v3s_dma_cfg = {
+	.nr_max_channels = 8,
+	.nr_max_requests = 23,
+	.nr_max_vchans   = 24,
+	.gate_needed	 = true,
+};
+
 static const struct of_device_id sun6i_dma_match[] = {
 	{ .compatible = "allwinner,sun6i-a31-dma", .data = &sun6i_a31_dma_cfg },
 	{ .compatible = "allwinner,sun8i-a23-dma", .data = &sun8i_a23_dma_cfg },
 	{ .compatible = "allwinner,sun8i-a83t-dma", .data = &sun8i_a83t_dma_cfg },
 	{ .compatible = "allwinner,sun8i-h3-dma", .data = &sun8i_h3_dma_cfg },
+	{ .compatible = "allwinner,sun8i-v3s-dma", .data = &sun8i_v3s_dma_cfg },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun6i_dma_match);
@@ -1177,10 +1188,10 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 	/*
 	 * sun8i variant requires us to toggle a dma gating register,
 	 * as seen in Allwinner's SDK. This register is not documented
-	 * in the A23 user manual.
+	 * in the A23 user manual, but documented at least in V3s user
+	 * manual.
 	 */
-	if (of_device_is_compatible(pdev->dev.of_node,
-				    "allwinner,sun8i-a23-dma"))
+	if (sdc->cfg->gate_needed)
 		writel(SUN8I_DMA_GATE_ENABLE, sdc->base + SUN8I_DMA_GATE);
 
 	return 0;
-- 
2.11.1
