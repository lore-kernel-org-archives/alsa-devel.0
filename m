From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 1/2] ASoC: Add device tree documentation file
	for wm8782 stereo DAC
Date: Wed,  3 Oct 2018 21:34:35 +0200
Message-ID: <20181003193436.5281-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F36F2677F0
 for <alsa-devel@alsa-project.org>; Wed,  3 Oct 2018 21:34:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: tiwai@suse.de, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Add a device tree documentation file for the wm8782 stereo DAC to describe
the regulator handles.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 .../devicetree/bindings/sound/wm8782.txt        | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/wm8782.txt

diff --git a/Documentation/devicetree/bindings/sound/wm8782.txt b/Documentation/devicetree/bindings/sound/wm8782.txt
new file mode 100644
index 000000000000..256cdec6ec4d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wm8782.txt
@@ -0,0 +1,17 @@
+WM8782 stereo ADC
+
+This device does not have any control interface or reset pins.
+
+Required properties:
+
+ - compatible  : "wlf,wm8782"
+ - Vdda-supply : phandle to a regulator for the analog power supply (2.7V - 5.5V)
+ - Vdd-supply  : phandle to a regulator for the digital power supply (2.7V - 3.6V)
+
+Example:
+
+wm8782: stereo-adc {
+	compatible = "wlf,wm8782";
+	Vdda-supply = <&vdda_supply>;
+	Vdd-supply = <&vdd_supply>;
+};
-- 
2.17.1
