From: simon.ho.cnxt@gmail.com
Subject: [PATCH v5 1/2] doc: cx2092x: Add DT bingings doc for
	CX2092X DSP
Date: Thu,  6 Apr 2017 11:04:33 +0800
Message-ID: <0237e17dca2cbb38dcec19a0452628858785a498.1491446448.git.simon.ho@conexant.com>
References: <cover.1491446448.git.simon.ho@conexant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id B632726722D
 for <alsa-devel@alsa-project.org>; Thu,  6 Apr 2017 05:04:41 +0200 (CEST)
Received: by mail-pg0-f65.google.com with SMTP id 81so5165031pgh.3
 for <alsa-devel@alsa-project.org>; Wed, 05 Apr 2017 20:04:41 -0700 (PDT)
In-Reply-To: <cover.1491446448.git.simon.ho@conexant.com>
In-Reply-To: <cover.1491446448.git.simon.ho@conexant.com>
References: <cover.1491446448.git.simon.ho@conexant.com>
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
Cc: pierre-louis.bossart@linux.intel.com, Simon Ho <simon.ho@conexant.com>, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

From: Simon Ho <simon.ho@conexant.com>

Initial version of CX2092X device tree bindings document.

Signed-off-by: Simon Ho <simon.ho@conexant.com>
---
 .../devicetree/bindings/sound/cnxt,cx2092x.txt     | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cnxt,cx2092x.txt

diff --git a/Documentation/devicetree/bindings/sound/cnxt,cx2092x.txt b/Documentation/devicetree/bindings/sound/cnxt,cx2092x.txt
new file mode 100644
index 0000000..8dd2428
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cnxt,cx2092x.txt
@@ -0,0 +1,25 @@
+Conexant CX20921/CX209724 Voice Processor DSP
+
+The devices supports the I2C bus.
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
+codec: cx20921@41 {
+	compatible = "cnxt,cx20921";
+	reg = <0x41>;
+	reset-gpios = <&gpio1 23 0>;
+};
-- 
2.7.4
