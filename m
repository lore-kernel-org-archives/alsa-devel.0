From: Mark Brown <broonie@kernel.org>
Subject: Applied "dt-bindings: sound: sun4i-spdif: Document that the RX
 channel can be missing" to the asoc tree
Date: Thu, 16 May 2019 19:02:59 +0100 (BST)
Message-ID: <20190516180259.13F28112929C@debutante.sirena.org.uk>
References: <a0558cf83011d21c4f44fecc078dff1e67cdbe9d.1557993523.git-series.maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <a0558cf83011d21c4f44fecc078dff1e67cdbe9d.1557993523.git-series.maxime.ripard@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   dt-bindings: sound: sun4i-spdif: Document that the RX channel can be missing

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From b1f35dfd7c2f509b0736f1ff02c314130b6b773e Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@bootlin.com>
Date: Thu, 16 May 2019 09:59:26 +0200
Subject: [PATCH] dt-bindings: sound: sun4i-spdif: Document that the RX channel
 can be missing

The H3 and compatibles controllers don't have any reception capabilities,
even though it was never documented as such in the binding before.

Therefore, on those controllers, we don't have the option to set an RX DMA
channel.

This was already done in the DTSI, but the binding itself was never
updated. Let's add a special case in the schemas.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../sound/allwinner,sun4i-a10-spdif.yaml      | 38 ++++++++++++++-----
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml
index 5d72d48e923e..a49ef2294a74 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-spdif.yaml
@@ -44,19 +44,11 @@ properties:
       - const: apb
       - const: spdif
 
-  dmas:
-    items:
-      - description: RX DMA Channel
-      - description: TX DMA Channel
-
-  dma-names:
-    items:
-      - const: rx
-      - const: tx
-
   # Even though it only applies to subschemas under the conditionals,
   # not listing them here will trigger a warning because of the
   # additionalsProperties set to false.
+  dmas: true
+  dma-names: true
   resets:
     maxItems: 1
 
@@ -73,6 +65,32 @@ allOf:
       required:
         - resets
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: allwinner,sun8i-h3-spdif
+
+    then:
+      properties:
+        dmas:
+          description: TX DMA Channel
+
+        dma-names:
+          const: tx
+
+    else:
+      properties:
+        dmas:
+          items:
+            - description: RX DMA Channel
+            - description: TX DMA Channel
+
+        dma-names:
+          items:
+            - const: rx
+            - const: tx
+
 required:
   - "#sound-dai-cells"
   - compatible
-- 
2.20.1
