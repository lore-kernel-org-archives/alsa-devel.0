From: h00249924 <hutenghui@huawei.com>
Subject: [PATCH 1/2] arm64: dts: hi3660: Add i2s & sound device
Date: Fri, 28 Dec 2018 14:30:45 +0800
Message-ID: <1545978646-124051-1-git-send-email-hutenghui@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: suzhuangluan@hisilicon.com, kongfei@hisilicon.com, liyuequan@hisilicon.com, cash.qianli@hisilicon.com, huangli295@hisilicon.com, hantanglei@huawei.com, wangyoulin1@hisilicon.com, ninggaoyu@hisilicon.com, Youlin Wang <wwx575822@notesmail.huawei.com>, John Stultz <john.stultz@linaro.org>, Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: alsa-devel@alsa-project.org

From: Youlin Wang <wwx575822@notesmail.huawei.com>

Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Youlin Wang <wwx575822@notesmail.huawei.com>
Signed-off-by: Tanglei Han <hantanglei@huawei.com>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 5223e36..ae535da 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -1136,5 +1136,33 @@
 			interrupt-names = "asp_dma_irq";
 			status = "ok";
 		};
+
+		i2s2: hisi_i2s {
+			compatible = "hisilicon,hisi-i2s";
+			reg = <0x0 0xe804f800 0x0 0x400>,
+			      <0x0 0xe804e000 0x0 0x400>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2s2_pmx_func &i2s2_cfg_func>;
+			dmas = <&asp_dmac 18 &asp_dmac 19>;
+			dma-names = "rx", "tx";
+			#sound-dai-cells = <0>;
+		};
+
+		sound {
+			compatible = "simple-audio-card";
+			simple-audio-card,name = "hikey-hdmi";
+			simple-audio-card,format = "i2s";
+
+			simple-audio-card,bitclock-master = <&sound_master>;
+			simple-audio-card,frame-master = <&sound_master>;
+
+			sound_master: simple-audio-card,cpu {
+				sound-dai = <&i2s2>;
+			};
+
+			simple-audio-card,codec {
+				sound-dai = <&adv7533>;
+			};
+		};
 	};
 };
-- 
1.9.1
