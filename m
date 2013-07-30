From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH v6 3/8] Documentation: DT: update atmel SSC
	with DMA binding
Date: Tue, 30 Jul 2013 12:32:04 +0200
Message-ID: <1375180329-4860-4-git-send-email-richard.genoud@gmail.com>
References: <1375180329-4860-1-git-send-email-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
 [209.85.212.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 75BE5261B1E
 for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2013 12:32:34 +0200 (CEST)
Received: by mail-wi0-f180.google.com with SMTP id f14so1919225wiw.1
 for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2013 03:32:34 -0700 (PDT)
In-Reply-To: <1375180329-4860-1-git-send-email-richard.genoud@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Richard Genoud <richard.genoud@gmail.com>, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

As atmel-ssc can be used with DMA, the documentation should be updated.
Also, a configuration DMA example is given.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 .../devicetree/bindings/misc/atmel-ssc.txt         |   23 +++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/misc/atmel-ssc.txt b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
index 38e51ad..a45ae08 100644
--- a/Documentation/devicetree/bindings/misc/atmel-ssc.txt
+++ b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
@@ -7,9 +7,30 @@ Required properties:
 - reg: Should contain SSC registers location and length
 - interrupts: Should contain SSC interrupt
 
-Example:
+
+Required properties for devices compatible with "atmel,at91sam9g45-ssc":
+- dmas: DMA specifier, consisting of a phandle to DMA controller node,
+  the memory interface and SSC DMA channel ID (for tx and rx).
+  See Documentation/devicetree/bindings/dma/atmel-dma.txt for details.
+- dma-names: Must be "tx", "rx".
+
+Examples:
+- PDC transfer:
 ssc0: ssc@fffbc000 {
 	compatible = "atmel,at91rm9200-ssc";
 	reg = <0xfffbc000 0x4000>;
 	interrupts = <14 4 5>;
 };
+
+- DMA transfer:
+ssc0: ssc@f0010000 {
+      compatible = "atmel,at91sam9g45-ssc";
+      reg = <0xf0010000 0x4000>;
+      interrupts = <28 4 5>;
+      dmas = <&dma0 1 13>,
+	     <&dma0 1 14>;
+      dma-names = "tx", "rx";
+      pinctrl-names = "default";
+      pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
+      status = "disabled";
+};
-- 
1.7.10.4
