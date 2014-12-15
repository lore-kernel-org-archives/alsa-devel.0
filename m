From: Yakir Yang <ykk@rock-chips.com>
Subject: [PATCH 5/6] dt-bindings: Add documentation for Rockchip hdmi-audio
Date: Mon, 15 Dec 2014 10:55:14 +0800
Message-ID: <1418612114-19692-1-git-send-email-ykk@rock-chips.com>
References: <1418609494-15820-1-git-send-email-ykk@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1418609494-15820-1-git-send-email-ykk@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ykk@rock-chips.com
Cc: Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Liam Girdwood <lgirdwood@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Bard Liao <bardliao@realtek.com>, Lars-Peter Clausen <lars@metafoo.de>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.de>, linux-rockchip@lists.infradead.org, Grant Likely <grant.likely@linaro.org>, Dylan Reid <dgreid@chromium.org>, Xu Jianqun <jay.xu@rock-chips.com>, Oder Chiou <oder_chiou@realtek.com>, Zubair.Kakakhel@imgtec.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jyri Sarha <jsarha@ti.com>, Ben Zhang <benzh@chromium.org>, Rob Herring <robh+dt@kernel.org>, Daniel Kurtz <djkurtz@chromium.org>, =?UTF-8?q?St=A8=A6phane=
List-Id: alsa-devel@alsa-project.org

Required properties:
- compatible: platform specific
- cpu-of-node: the device node of cpu_dai
- codec-name: the dw-hdmi codec's device name
- codec-dai-name: the dw-hdmi codec's dai name

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---

 .../bindings/sound/rockchip,rockchip-hdmi-audio.txt      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rockchip-hdmi-audio.txt

diff --git a/Documentation/devicetree/bindings/sound/rockchip,rockchip-hdmi-audio.txt b/Documentation/devicetree/bindings/sound/rockchip,rockchip-hdmi-audio.txt
new file mode 100644
index 0000000..674cff0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rockchip,rockchip-hdmi-audio.txt
@@ -0,0 +1,16 @@
+Rockchip hdmi audio bindings
+
+Required properties:
+- compatible: platform specific
+- cpu-of-node: the device node of cpu_dai
+- codec-name: the dw-hdmi codec's device name
+- codec-dai-name: the dw-hdmi codec's dai name
+
+Example:
+
+sound {
+	compatible = "rockchip,rk3288-hdmi-audio";
+	cpu-of-node = <&i2s>;
+	codec-name = "dw-hdmi-audio";
+	codec-dai-name = "dw-hdmi-hifi";
+};
-- 
2.1.2
