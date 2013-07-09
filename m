From: Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 3/7] Documentation: DT: update atmel SSC with DMA binding
Date: Tue,  9 Jul 2013 16:25:29 +0200
Message-ID: <1373379933-32749-4-git-send-email-richard.genoud@gmail.com>
References: <1373372929-17800-1-git-send-email-richard.genoud@gmail.com>
 <1373379933-32749-1-git-send-email-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1373379933-32749-1-git-send-email-richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

As atmel-ssc can be used with DMA, the documentation should be updated.
Also, a configuration DMA example is given.

Signed-off-by: Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 .../devicetree/bindings/misc/atmel-ssc.txt         |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/misc/atmel-ssc.txt b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
index 38e51ad..7c320da 100644
--- a/Documentation/devicetree/bindings/misc/atmel-ssc.txt
+++ b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
@@ -6,10 +6,28 @@ Required properties:
 	- atmel,at91sam9g45-ssc: support dma transfer
 - reg: Should contain SSC registers location and length
 - interrupts: Should contain SSC interrupt
+For dma transfer:
+- dmas: DMA specifier, consisting of a phandle to DMA controller node,
+  the memory interface and SSC DMA channel ID (for tx and rx).
+  See Documentation/devicetree/bindings/dma/atmel-dma.txt for details.
+- dma-names: Must be "tx", "rx".
 
-Example:
+Examples:
 ssc0: ssc@fffbc000 {
 	compatible = "atmel,at91rm9200-ssc";
 	reg = <0xfffbc000 0x4000>;
 	interrupts = <14 4 5>;
 };
+
+
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
