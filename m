From: Pengcheng Li <lipengcheng8@huawei.com>
Subject: [PATCH 3/3] arm64: dts: hi3660-hikey960: Add i2s & sound device
Date: Thu, 28 Feb 2019 22:08:13 +0800
Message-ID: <1551362893-100023-1-git-send-email-lipengcheng8@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: xuwei5@hisilicon.com, robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, john.stultz@linaro.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: lipengcheng8@huawei.com, suzhuangluan@hisilicon.com, kongfei@hisilicon.com, liyuequan@hisilicon.com, cash.qianli@hisilicon.com, huangli295@hisilicon.com, hantanglei@huawei.com, wangyoulin1@hisilicon.com, ninggaoyu@hisilicon.com, xuwei5@huawei.com
List-Id: alsa-devel@alsa-project.org

From: Youlin Wang <wangyoulin1@hisilicon.com>

Signed-off-by: Youlin Wang <wangyoulin1@hisilicon.com>
Signed-off-by: Tanglei Han <hantanglei@huawei.com>
Signed-off-by: Guangke Ji <jiguangke@huawei.com>
Signed-off-by: Feng Chen <puck.chen@hisilicon.com>
Signed-off-by: Kaihua Zhong <zhongkaihua@huawei.com>
Signed-off-by: Jun Chen <chenjun14@huawei.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Yiping Xu <xuyiping@hisilicon.com>
Signed-off-by: Pengcheng Li <lipengcheng8@huawei.com>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 29 +++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index 186251f..457cebc 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -27,6 +27,35 @@
 		/* rewrite this at bootloader */
 		reg = <0x0 0x0 0x0 0x0>;
 	};
+
+	i2s2: hi3660_i2s {
+		compatible = "hisilicon,hi3660-i2s-1.0";
+		reg = <0x0 0xe804f800 0x0 0x400>,
+			<0x0 0xe804e000 0x0 0x400>;
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
+
 };
 
 &uart5 {
-- 
2.8.0
