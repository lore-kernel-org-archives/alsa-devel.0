From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Subject: [RFC PATCH V2 2/2] ASoC: mediatek: add documents for
	btcvsd driver
Date: Wed, 30 Jan 2019 14:47:11 +0800
Message-ID: <1548830831-17387-3-git-send-email-kaichieh.chuang@mediatek.com>
References: <1548830831-17387-1-git-send-email-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 571E12674EF
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2019 07:47:26 +0100 (CET)
In-Reply-To: <1548830831-17387-1-git-send-email-kaichieh.chuang@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, garlic.tseng@mediatek.com, linux-mediatek@lists.infradead.org, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

document for btcvsd driver

Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
---
 .../bindings/sound/mtk-btcvsd-snd.txt         | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mtk-btcvsd-snd.txt

diff --git a/Documentation/devicetree/bindings/sound/mtk-btcvsd-snd.txt b/Documentation/devicetree/bindings/sound/mtk-btcvsd-snd.txt
new file mode 100644
index 000000000000..679e44839b48
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
