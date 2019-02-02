From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: add documents for btcvsd
	driver" to the asoc tree
Date: Sat,  2 Feb 2019 16:18:11 +0000 (GMT)
Message-ID: <20190202161811.CD035440082@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A3532674CB
 for <alsa-devel@alsa-project.org>; Sat,  2 Feb 2019 17:18:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: add documents for btcvsd driver

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 425da20a98e0ab6ba6b37ff00ab50519d7dd7740 Mon Sep 17 00:00:00 2001
From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Date: Wed, 30 Jan 2019 14:47:11 +0800
Subject: [PATCH] ASoC: mediatek: add documents for btcvsd driver

document for btcvsd driver

Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1
