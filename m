From: Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH 1/2] ASoC: max9892x: Add documentation for reset-gpio support
Date: Wed, 12 Sep 2018 20:19:54 +0800
Message-ID: <20180912121955.33048-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, ryans.lee@maximintegrated.com, alsa-devel@alsa-project.org, dgreid@chromium.org, Cheng-Yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org

max98927 codec driver will support reset-gpio binding so it can toggle
reset line in its probe function.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 Documentation/devicetree/bindings/sound/max9892x.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/max9892x.txt b/Documentation/devicetree/bindings/sound/max9892x.txt
index f6171591ddc61..8bf30483eedcd 100644
--- a/Documentation/devicetree/bindings/sound/max9892x.txt
+++ b/Documentation/devicetree/bindings/sound/max9892x.txt
@@ -29,6 +29,8 @@ Required properties:
                    Range : 0 (off), 1 (on),  Default : 0
 
   - reg : the I2C address of the device for I2C
+  - reset-gpio: reset gpio the chip is connected to. This is supported
+                on max98927.
 
 Example:
 
@@ -38,4 +40,5 @@ codec: max98927@3a {
    imon-slot-no = <1>;
    interleave-mode = <0>;
    reg = <0x3a>;
+   reset-gpio = <&tlmm 75 GPIO_ACTIVE_LOW>;
 };
-- 
2.16.4
