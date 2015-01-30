From: Yakir Yang <ykk@rock-chips.com>
Subject: [PATCH v2 12/12] dt-bindings: Add documentation for Rockchip dw-hdmi-audio
Date: Fri, 30 Jan 2015 06:44:13 -0500
Message-ID: <1422618253-27312-1-git-send-email-ykk@rock-chips.com>
References: <1422617031-25098-1-git-send-email-ykk@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422617031-25098-1-git-send-email-ykk@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Brian Austin <brian.austin@cirrus.com>, Bard Liao <bardliao@realtek.com>, Max Filippov <jcmvbkbc@gmail.com>, Oder Chiou <oder_chiou@realtek.com>, Arnd Bergmann <arnd@arndb.de>, Sean Cross <xobs@kosagi.com>, Jyri Sarha <jsarha@ti.com>, Ben Zhang <benzh@chromium.org>, Yakir Yang <ykk@rock-chips.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, djkurtz@chromium.org, dbehr@chromoum.org, mmind00@googlemail.com, dianders@chromium.org, marcheu@chromium.org, mark.yao@rock-chips.com, rockchip-discuss@chromium.org
List-Id: alsa-devel@alsa-project.org

Required properties:
- compatible: platform specific
- cpu-of-node: the device node of cpu_dai

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v2:
- remove codec-name and codec-dai-name
- rename rockchip,rockchip-hdmi-audio.txt to rockchip,rockchip-dw-hdmi-audio.txt

 .../bindings/sound/rockchip,rockchip-dw-hdmi-audio.txt       | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rockchip-dw-hdmi-audio.txt

diff --git a/Documentation/devicetree/bindings/sound/rockchip,rockchip-dw-hdmi-audio.txt b/Documentation/devicetree/bindings/sound/rockchip,rockchip-dw-hdmi-audio.txt
new file mode 100644
index 0000000..5b86eed
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rockchip,rockchip-dw-hdmi-audio.txt
@@ -0,0 +1,12 @@
+Rockchip hdmi audio bindings
+
+Required properties:
+- compatible: platform specific
+- cpu-of-node: the device node of cpu_dai
+
+Example:
+
+sound {
+	compatible = "rockchip,rk3288-hdmi-audio";
+	cpu-of-node = <&i2s>;
+};
-- 
2.1.2
