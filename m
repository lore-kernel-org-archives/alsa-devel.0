From: simon.ho.cnxt@gmail.com
Subject: [PATCH v2 1/2] doc: cx2092x: Add DT bingings doc for
	CX2092X DSP
Date: Tue, 21 Feb 2017 09:01:51 +0800
Message-ID: <328f8c2aa7184e7d632637f81c471919e9d9c671.1487595577.git.simon.ho@conexant.com>
References: <cover.1487595577.git.simon.ho@conexant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f194.google.com (mail-qk0-f194.google.com
 [209.85.220.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 494182667A5
 for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2017 02:01:57 +0100 (CET)
Received: by mail-qk0-f194.google.com with SMTP id n127so5593146qkf.2
 for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2017 17:01:57 -0800 (PST)
In-Reply-To: <cover.1487595577.git.simon.ho@conexant.com>
In-Reply-To: <cover.1487595577.git.simon.ho@conexant.com>
References: <cover.1487595577.git.simon.ho@conexant.com>
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
 .../devicetree/bindings/sound/cnxt,cx2092x.txt     | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cnxt,cx2092x.txt

diff --git a/Documentation/devicetree/bindings/sound/cnxt,cx2092x.txt b/Documentation/devicetree/bindings/sound/cnxt,cx2092x.txt
new file mode 100644
index 0000000..72928bd
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cnxt,cx2092x.txt
@@ -0,0 +1,29 @@
+Conexant CX20921/CX209724 Voice Processor DSP
+
+The devices supports both the I2C and SPI bus.
+
+Required properties:
+
+  - compatible: One of "cnxt,cx20921", "cnxt,cx20924".
+  - reg: The I2C address of the device for I2C, it should be <0x41>
+
+Optional properties:
+
+  - reset-gpios: A GPIO spec to define which pin is connected to the chip's
+		 !RESET pin. If specified, the driver will assert a hardware
+		 reset at probe time.
+
+CODEC input pins:
+  "MIC"	- Microphone input
+
+Example:
+
+codec_i2c: cx20921@41 {
+	compatible = "cnxt,cx20921";
+	reg = <0x41>;
+	reset-gpios = <&gpio1 23 0>;
+};
+
+codec_spi: cx20924@0 {
+	compatible = "cnxt,cx20924";
+};
-- 
2.7.4
