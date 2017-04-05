From: simon.ho.cnxt@gmail.com
Subject: [PATCH v2 1/2] ASoC: cx2072x: Add DT bingings
	documentation for CX2072X CODEC
Date: Wed,  5 Apr 2017 17:07:13 +0800
Message-ID: <0f800bdd9d66af0a975d903018805aef5330c758.1491382907.git.simon.ho@conexant.com>
References: <cover.1491382907.git.simon.ho@conexant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f67.google.com (mail-pg0-f67.google.com [74.125.83.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 4824D266FBF
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 11:07:21 +0200 (CEST)
Received: by mail-pg0-f67.google.com with SMTP id g2so1238572pge.2
 for <alsa-devel@alsa-project.org>; Wed, 05 Apr 2017 02:07:21 -0700 (PDT)
In-Reply-To: <cover.1491382907.git.simon.ho@conexant.com>
In-Reply-To: <cover.1491382907.git.simon.ho@conexant.com>
References: <cover.1491382907.git.simon.ho@conexant.com>
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
Cc: pierre-louis.bossart@linux.intel.com, Simon Ho <simon.ho@conexant.com>, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
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
