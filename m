From: simon.ho.cnxt@gmail.com
Subject: [PATCH 1/2] ASoC: cx2072x: Add DT bingings
	documentation for CX2072X CODEC
Date: Sat, 17 Dec 2016 15:52:32 +0800
Message-ID: <6cb94db3a39df9904e1f96438f0484456166024e.1481903061.git.simon.ho@conexant.com>
References: <cover.1481903061.git.simon.ho@conexant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f67.google.com (mail-pg0-f67.google.com [74.125.83.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FB25266569
 for <alsa-devel@alsa-project.org>; Sat, 17 Dec 2016 08:52:43 +0100 (CET)
Received: by mail-pg0-f67.google.com with SMTP id a1so5118245pgf.3
 for <alsa-devel@alsa-project.org>; Fri, 16 Dec 2016 23:52:43 -0800 (PST)
In-Reply-To: <cover.1481903061.git.simon.ho@conexant.com>
In-Reply-To: <cover.1481903061.git.simon.ho@conexant.com>
References: <cover.1481903061.git.simon.ho@conexant.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Simon Ho <simon.ho@conexant.com>
List-Id: alsa-devel@alsa-project.org

From: Simon Ho <simon.ho@conexant.com>

Initial version of CX2072X device tree bindings document.

Signed-off-by: Simon Ho <simon.ho@conexant.com>
---
 .../devicetree/bindings/sound/cx2072x.txt          | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cx2072x.txt

diff --git a/Documentation/devicetree/bindings/sound/cx2072x.txt b/Documentation/devicetree/bindings/sound/cx2072x.txt
new file mode 100644
index 0000000..05ddf7c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cx2072x.txt
@@ -0,0 +1,36 @@
+Conexant CX20721/CX20723/CX7601 audio CODEC
+
+The devices support I2C only.
+
+Required properties:
+
+  - compatible : One of "cnxt,cx20721", "cnxt,cx20723", "cnxt,cx7601".
+
+  - reg : the I2C address of the device for I2C, it should be <0x33>
+
+Optional properties:
+
+  - clocks : phandle and clock specifier for codec MCLK.
+  - clock-names : Clock name string for 'clocks' attribute, should be "mclk".
+
+CODEC output pins:
+  "PORTA"	- Headphone
+  "PORTG"	- Class-D output
+  "PORTE"	- Line out
+
+CODEC output pins for Conexant DSP chip:
+  "AEC REF"	- AEC reference signal
+
+CODEC input pins:
+  "PORTB"	- Analog mic
+  "PORTC"	- Digital mic
+  "PORTD"	- Headset mic
+
+Example:
+
+codec: cx20721@33 {
+	compatible = "cnxt,cx20721";
+	reg = <0x33>;
+	clocks = <&sco>;
+	clock-names = "mclk";
+};
-- 
2.7.4
