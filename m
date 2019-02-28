From: Pengcheng Li <lipengcheng8@huawei.com>
Subject: [PATCH 2/3] ASoC: add hikey960-i2s DT bindings
Date: Thu, 28 Feb 2019 21:57:41 +0800
Message-ID: <1551362261-99422-1-git-send-email-lipengcheng8@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, john.stultz@linaro.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: lipengcheng8@huawei.com, suzhuangluan@hisilicon.com, kongfei@hisilicon.com, liyuequan@hisilicon.com, cash.qianli@hisilicon.com, huangli295@hisilicon.com, hantanglei@huawei.com, wangyoulin1@hisilicon.com, ninggaoyu@hisilicon.com, xuwei5@huawei.com
List-Id: alsa-devel@alsa-project.org

From: Youlin Wang <wangyoulin1@hisilicon.com>

Adds DT bindings documentation for
the hikey960-i2s driver and audio card device.

Signed-off-by: Youlin Wang <wangyoulin1@hisilicon.com>
Signed-off-by: Tanglei Han <hantanglei@huawei.com>
Signed-off-by: Guangke Ji <jiguangke@huawei.com>
Signed-off-by: Feng Chen <puck.chen@hisilicon.com>
Signed-off-by: Kaihua Zhong <zhongkaihua@huawei.com>
Signed-off-by: Jun Chen <chenjun14@huawei.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Yiping Xu <xuyiping@hisilicon.com>
Signed-off-by: Pengcheng Li <lipengcheng8@huawei.com>
---
 .../bindings/sound/hisilicon,hi3660-i2s.txt        | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/hisilicon,hi3660-i2s.txt

diff --git a/Documentation/devicetree/bindings/sound/hisilicon,hi3660-i2s.txt b/Documentation/devicetree/bindings/sound/hisilicon,hi3660-i2s.txt
new file mode 100644
index 0000000..654c234
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/hisilicon,hi3660-i2s.txt
@@ -0,0 +1,49 @@
+* Hisilicon 6210 i2s controller
+
+Required properties:
+
+- compatible: should be one of the following:
+   - "hisilicon,hi3660-i2s-1.0"
+- reg: physical base address of the i2s controller unit and length of
+   memory mapped region.
+- interrupts: should contain the i2s interrupt.
+- clocks: a list of phandle + clock-specifier pairs, one for each entry
+  in clock-names.
+- clock-names: should contain following:
+   - "dacodec"
+   - "i2s-base"
+- dmas: DMA specifiers for tx dma. See the DMA client binding,
+  Documentation/devicetree/bindings/dma/dma.txt
+- dma-names: should be "tx" and "rx"
+- hisilicon,sysctrl-syscon: phandle to sysctrl syscon
+- #sound-dai-cells: Should be set to 1 (for multi-dai)
+
+Example for the hi3660 i2s controller:
+
+	i2s2: hisi_i2s {
+		compatible = "hisilicon,hi3660-i2s-1.0";
+		reg = <0x0 0xe804f800 0x0 0x400>,
+			  <0x0 0xe804e000 0x0 0x400>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s2_pmx_func &i2s2_cfg_func>;
+		dmas = <&asp_dmac 18 &asp_dmac 19>;
+		dma-names = "rx", "tx";
+		#sound-dai-cells = <0>;
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "hikey-hdmi";
+		simple-audio-card,format = "i2s";
+
+		simple-audio-card,bitclock-master = <&sound_master>;
+		simple-audio-card,frame-master = <&sound_master>;
+
+		sound_master: simple-audio-card,cpu {
+			sound-dai = <&i2s2>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&adv7533>;
+		};
+	};
-- 
2.8.0
