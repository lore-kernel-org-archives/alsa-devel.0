From: Matt Porter <mporter@konsulko.com>
Subject: [PATCH v2 1/2] ASoC: add tda7419 audio processor
	binding
Date: Sun, 18 Mar 2018 13:22:37 -0400
Message-ID: <20180318172238.9795-2-mporter@konsulko.com>
References: <20180318172238.9795-1-mporter@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f193.google.com (mail-io0-f193.google.com
 [209.85.223.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 128F1267205
 for <alsa-devel@alsa-project.org>; Sun, 18 Mar 2018 18:22:48 +0100 (CET)
Received: by mail-io0-f193.google.com with SMTP id m83so17987506ioi.8
 for <alsa-devel@alsa-project.org>; Sun, 18 Mar 2018 10:22:48 -0700 (PDT)
In-Reply-To: <20180318172238.9795-1-mporter@konsulko.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

DeviceTree binding for the tda7419 audio processor.

Signed-off-by: Matt Porter <mporter@konsulko.com>
---
 .../devicetree/bindings/sound/tda7419.txt          | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tda7419.txt

diff --git a/Documentation/devicetree/bindings/sound/tda7419.txt b/Documentation/devicetree/bindings/sound/tda7419.txt
new file mode 100644
index 000000000000..6b85ec38dd56
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tda7419.txt
@@ -0,0 +1,38 @@
+TDA7419 audio processor
+
+This device supports I2C only.
+
+Required properties:
+
+- compatible : "st,tda7419"
+- reg : the I2C address of the device.
+- vdd-supply : a regulator spec for the common power supply (8-10V)
+
+Optional properties:
+
+- st,mute-gpios : a GPIO spec for the MUTE pin.
+
+Pins on the device (for linking into audio routes):
+
+  * SE3L
+  * SE3R
+  * SE2L
+  * SE2R
+  * SE1L
+  * SE1R
+  * DIFFL
+  * DIFFR
+  * MIX
+  * OUTLF
+  * OUTRF
+  * OUTLR
+  * OUTRR
+  * OUTSW
+
+Example:
+
+ap: tda7419@44 {
+	compatible = "st,tda7419";
+	reg = <0x44>;
+	vdd-supply = <&vdd_9v0_reg>;
+};
-- 
2.11.0
