From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v5 5/8] ASoC: rt5616: add mclk property for rt5616 document
Date: Tue,  2 Feb 2016 11:44:38 +0800
Message-ID: <1454384680-7197-1-git-send-email-wxt@rock-chips.com>
References: <1454384032-6794-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454384032-6794-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, bardliao@realtek.com
Cc: alsa-devel@alsa-project.org, oder_chiou@realtek.com, robh+dt@kernel.org, heiko@sntech.de, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, keescook@google.com, linux-kernel@vger.kernel.org, jeffy.chen@rock-chips.com, leozwang@google.com, Caesar Wang <wxt@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

This patch adds the mclk property for the CODEC driver,
since sometimes the CODEC driver needs the clock enabled.

The system clock of ALC5616 can be selected from MCLK,
That also makes the codec the master clock provider.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>

Cc:  alsa-devel@alsa-project.org
Cc:  Mark Brown <broonie@kernel.org>
Cc:  Bard Liao <bardliao@realtek.com>

---

Changes in v5:
- Fix the wrong word, as the Rob comments on
  https://patchwork.kernel.org/patch/8147731/.
- Cc the related alsa experts.

Changes in v4:
- Add this patch included in kylin series patches.

 Documentation/devicetree/bindings/sound/rt5616.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5616.txt b/Documentation/devicetree/bindings/sound/rt5616.txt
index efc48c6..e410858 100644
--- a/Documentation/devicetree/bindings/sound/rt5616.txt
+++ b/Documentation/devicetree/bindings/sound/rt5616.txt
@@ -8,6 +8,12 @@ Required properties:
 
 - reg : The I2C address of the device.
 
+Optional properties:
+
+- clocks: The phandle of the master clock to the CODEC.
+
+- clock-names: Should be "mclk".
+
 Pins on the device (for linking into audio routes) for RT5616:
 
   * IN1P
-- 
1.9.1
