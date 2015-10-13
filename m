From: Shunqian Zheng <zhengsq@rock-chips.com>
Subject: [PATCH v1 4/4] ASoC: RK3036: Add binding doc for audio machine driver
Date: Tue, 13 Oct 2015 09:01:09 +0800
Message-ID: <1444698070-4191-5-git-send-email-zhengsq@rock-chips.com>
References: <1444698070-4191-1-git-send-email-zhengsq@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444698070-4191-1-git-send-email-zhengsq@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, heiko@sntech.de, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, benzh@chromium.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org, ZhengShunQian <zhengsq@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

From: ZhengShunQian <zhengsq@rock-chips.com>

This patch add binding document for RK3036 SoC audio
machine driver.

Signed-off-by: ZhengShunQian <zhengsq@rock-chips.com>
---
 .../devicetree/bindings/sound/rockchip-rk3036.txt          | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip-rk3036.txt

diff --git a/Documentation/devicetree/bindings/sound/rockchip-rk3036.txt b/Documentation/devicetree/bindings/sound/rockchip-rk3036.txt
new file mode 100644
index 0000000..53d5738
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rockchip-rk3036.txt
@@ -0,0 +1,14 @@
+RK3036 SoC with Inno audio codec integrated
+
+Required properties:
+- compatible: Should be "rockchip,rk3036-audio".
+- rockchip,i2s-controller: The phandle of the Rockchip I2S controller.
+- rockchip,audio-codec: The phandle of the Inno-rk3036 audio codec.
+
+Example:
+
+	sound {
+		compatible = "rockchip,rk3036-audio";
+		rockchip,i2s-controller = <&i2s>;
+		rockchip,audio-codec = <&acodec>;
+	};
-- 
1.9.1
