From: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [RFC PATCH 2/2] ASoC: mediatek: add documents for btcvsd driver
Date: Thu, 24 Jan 2019 16:58:42 +0800
Message-ID: <20190124085842.24073-3-kaichieh.chuang@mediatek.com>
References: <20190124085842.24073-1-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190124085842.24073-1-kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, wsd_upstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

document for btcvsd driver

Signed-off-by: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 .../bindings/sound/mtk-btcvsd-snd.txt         | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mtk-btcvsd-snd.txt

diff --git a/Documentation/devicetree/bindings/sound/mtk-btcvsd-snd.txt b/Documentation/devicetree/bindings/sound/mtk-btcvsd-snd.txt
new file mode 100644
index 000000000000..5b16cbb70e64
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mtk-btcvsd-snd.txt
@@ -0,0 +1,24 @@
+Mediatek ALSA BT SCO CVSD/MSBC Driver
+
+Required properties:
+- compatible = "mediatek,mtk-btcvsd-snd";
+- reg: register location and size of PKV and SRAM_BANK2
+- interrupts: should contain BTSCO interrupt
+- mediatek,infracfg: the phandles of INFRASYS
+- mediatek,offset: Array contains of register offset and mask
+    infra_misc_offset,
+    infra_conn_bt_cvsd_mask,
+    cvsd_mcu_read_offset,
+    cvsd_mcu_write_offset,
+    cvsd_packet_indicator_offset
+
+Example:
+
+	mtk-btcvsd-snd@18000000 {
+		compatible = "mediatek,mtk-btcvsd-snd";
+		reg=<0 0x18000000 0 0x1000>,
+		    <0 0x18080000 0 0x8000>;
+		interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_LOW>;
+		mediatek,infracfg = <&infrasys>;
+		mediatek,offset = <0xf00 0x800 0xfd0 0xfd4 0xfd8>;
+	};
-- 
2.18.0
