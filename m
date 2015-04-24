From: Kevin Cernekee <cernekee@chromium.org>
Subject: [PATCH V2 2/4] ASoC: tas571x: Add DT binding document
Date: Fri, 24 Apr 2015 15:36:46 -0700
Message-ID: <1429915008-22015-3-git-send-email-cernekee@chromium.org>
References: <1429915008-22015-1-git-send-email-cernekee@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f170.google.com (mail-ig0-f170.google.com
 [209.85.213.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 68B6B2607E9
 for <alsa-devel@alsa-project.org>; Sat, 25 Apr 2015 00:37:10 +0200 (CEST)
Received: by igblo3 with SMTP id lo3so25930858igb.0
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 15:37:09 -0700 (PDT)
In-Reply-To: <1429915008-22015-1-git-send-email-cernekee@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, abrestic@chromium.org, linux-kernel@vger.kernel.org, dgreid@chromium.org, olofj@chromium.org
List-Id: alsa-devel@alsa-project.org

Document the bindings for the soon-to-be-added tas571x driver.

Signed-off-by: Kevin Cernekee <cernekee@chromium.org>
---
 .../devicetree/bindings/sound/tas571x.txt          | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tas571x.txt

diff --git a/Documentation/devicetree/bindings/sound/tas571x.txt b/Documentation/devicetree/bindings/sound/tas571x.txt
new file mode 100644
index 000000000000..0ac31d8d5ac4
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tas571x.txt
@@ -0,0 +1,41 @@
+Texas Instruments TAS5711/TAS5717/TAS5719 stereo power amplifiers
+
+The codec is controlled through an I2C interface.  It also has two other
+signals that can be wired up to GPIOs: reset (strongly recommended), and
+powerdown (optional).
+
+Required properties:
+
+- compatible: "ti,tas5711", "ti,tas5717", or "ti,tas5719"
+- reg: The I2C address of the device
+- #sound-dai-cells: must be equal to 0
+
+Optional properties:
+
+- reset-gpios: GPIO specifier for the TAS571x's active low reset line
+- pdn-gpios: GPIO specifier for the TAS571x's active low powerdown line
+- clocks: clock phandle for the MCLK input
+- clock-names: should be "mclk"
+- AVDD-supply: regulator phandle for the AVDD supply (all chips)
+- DVDD-supply: regulator phandle for the DVDD supply (all chips)
+- HPVDD-supply: regulator phandle for the HPVDD supply (5717/5719)
+- PVDD_AB-supply: regulator phandle for the PVDD_AB supply (5717/5719)
+- PVDD_CD-supply: regulator phandle for the PVDD_CD supply (5717/5719)
+- PVDD_A-supply: regulator phandle for the PVDD_A supply (5711)
+- PVDD_B-supply: regulator phandle for the PVDD_B supply (5711)
+- PVDD_C-supply: regulator phandle for the PVDD_C supply (5711)
+- PVDD_D-supply: regulator phandle for the PVDD_D supply (5711)
+
+Example:
+
+	tas5717: audio-codec@2a {
+		compatible = "ti,tas5717";
+		reg = <0x2a>;
+		#sound-dai-cells = <0>;
+
+		reset-gpios = <&gpio5 1 GPIO_ACTIVE_LOW>;
+		pdn-gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
+
+		clocks = <&clk_core CLK_I2S>;
+		clock-names = "mclk";
+	};
-- 
2.2.0.rc0.207.ga3a616c
