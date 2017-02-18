From: simon.ho.cnxt@gmail.com
Subject: [PATCH 1/2] ASoC: cx2092x: Add DT bingings doc for
	CX2092X DSP
Date: Sat, 18 Feb 2017 22:26:30 +0800
Message-ID: <1487427991-18174-2-git-send-email-simon.ho@conexant.com>
References: <1487427991-18174-1-git-send-email-simon.ho@conexant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
 [209.85.192.194])
 by alsa0.perex.cz (Postfix) with ESMTP id F0A78266847
 for <alsa-devel@alsa-project.org>; Sat, 18 Feb 2017 15:26:38 +0100 (CET)
Received: by mail-pf0-f194.google.com with SMTP id 68so6266616pfx.2
 for <alsa-devel@alsa-project.org>; Sat, 18 Feb 2017 06:26:38 -0800 (PST)
In-Reply-To: <1487427991-18174-1-git-send-email-simon.ho@conexant.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Simon Ho <simon.ho@conexant.com>, tiwai@suse.com, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Simon Ho <simon.ho@conexant.com>

Initial version of CX2092X device tree bindings document.

Signed-off-by: Simon Ho <simon.ho@conexant.com>
---
 .../devicetree/bindings/sound/cx2092x.txt          | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cx2092x.txt

diff --git a/Documentation/devicetree/bindings/sound/cx2092x.txt b/Documentation/devicetree/bindings/sound/cx2092x.txt
new file mode 100644
index 0000000..cb61cfc
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cx2092x.txt
@@ -0,0 +1,30 @@
+Conexant CX20921/CX209724 Voice Processor SoC
+
+The devices supports both the I2C and SPI bus.
+
+Required properties:
+
+  - compatible : One of "cnxt,cx20921", "cnxt,cx20924".
+  - reg : the I2C address of the device for I2C, it should be <0x41>
+
+Optional properties:
+
+  - reset-gpio:  A GPIO spec to define which pin is connected to the chip's
+                 !RESET pin. If specified, the driver will assert a hardware
+                 reset at probe time.
+
+CODEC input pins:
+  "MIC"       - Microphone input
+
+
+Example:
+
+codec_i2c: cx20921@41 {
+        compatible = "cnxt,cx20921";
+        reg = <0x41>;
+        reset-gpio = <&gpio 23 0>;
+};
+
+codec_spi: cx20924@0 {
+        compatible = "cnxt,cx20924";
+};
-- 
2.7.4
