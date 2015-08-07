From: Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: [PATCH v3 1/4] ASoC: dt-bindings: add rockchip tranceiver bindings
Date: Fri,  7 Aug 2015 13:44:11 +0200
Message-ID: <1438947854-3743-2-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1438947854-3743-1-git-send-email-sjoerd.simons@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1438947854-3743-1-git-send-email-sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Add devicetree bindings for the spdif tranceiver found on
found on rk3066, rk3188 and rk3288 SoCs

Signed-off-by: Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
---

Changes in v3: None
Changes in v2: None

 .../devicetree/bindings/sound/rockchip-spdif.txt   | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip-spdif.txt

diff --git a/Documentation/devicetree/bindings/sound/rockchip-spdif.txt b/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
new file mode 100644
index 0000000..2da8a09
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
@@ -0,0 +1,41 @@
+* Rockchip SPDIF transceiver
+
+The S/PDIF audio block is a stereo transceiver that allows the
+processor to receive and transmit digital audio via an coaxial cable or
+a fibre cable.
+
+Required properties:
+
+- compatible: should be one of the following:
+   - "rockchip,rk3066-spdif": for rk3066
+   - "rockchip,rk3188-spdif", "rockchip,rk3066-spdif": for rk3188
+   - "rockchip,rk3288-spdif", "rockchip,rk3066-spdif": for rk3288
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: should contain the SPDIF interrupt.
+- #address-cells: should be 1.
+- #size-cells: should be 0.
+- dmas: DMA specifiers for tx dma. See the DMA client binding,
+  Documentation/devicetree/bindings/dma/dma.txt
+- dma-names: should be "tx"
+- clocks: a list of phandle + clock-specifier pairs, one for each entry
+  in clock-names.
+- clock-names: should contain following:
+   - "spdif_hclk": clock for SPPIF controller
+   - "spdif_clk" : clock for SPDIF bus
+
+Example for the rk3188 SPDIF controller:
+
+spdif: spdif@0x1011e000 {
+	compatible = "rockchip,rk3188-spdif", "rockchip,rk3066-spdif";
+	reg = <0x1011e000 0x2000>;
+	interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	dmas = <&dmac1_s 8>;
+	dma-names = "tx";
+	clock-names = "spdif_hclk", "spdif_clk";
+	clocks = <&cru HCLK_SPDIF>, <&cru SCLK_SPDIF>;
+	status = "disabled";
+	#sound-dai-cells = <0>;
+};
-- 
2.5.0
