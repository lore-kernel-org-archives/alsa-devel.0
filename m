From: Ryan Lee <ryans.lee@maximintegrated.com>
Subject: [V3 1/2] dt-bindings: Added device tree binding for max98373 amplifier
Date: Wed,  3 Jan 2018 10:38:24 -0800
Message-ID: <1515004704-22182-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ryan.lee.maxim@gmail.com, Ryan Lee <ryans.lee@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
Changes since v2:
	* Splitted dt bindings to the separated patch
	* Changed 'interelave-mode' device property from u32 to boolean

 .../devicetree/bindings/sound/max98373.txt         | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/max98373.txt

diff --git a/Documentation/devicetree/bindings/sound/max98373.txt b/Documentation/devicetree/bindings/sound/max98373.txt
new file mode 100644
index 0000000..456cb1c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/max98373.txt
@@ -0,0 +1,40 @@
+Maxim Integrated MAX98373 Speaker Amplifier
+
+This device supports I2C.
+
+Required properties:
+
+ - compatible : "maxim,max98373"
+
+ - reg : the I2C address of the device.
+
+Optional properties:
+
+  - maxim,vmon-slot-no : slot number used to send voltage information
+                   or in inteleave mode this will be used as
+                   interleave slot.
+                   slot range : 0 ~ 15,  Default : 0
+
+  - maxim,imon-slot-no : slot number used to send current information
+                   slot range : 0 ~ 15,  Default : 0
+
+  - maxim,spkfb-slot-no : slot number used to send speaker feedback information
+                   slot range : 0 ~ 15,  Default : 0
+
+  - maxim,interleave-mode : For cases where a single combined channel
+		   for the I/V sense data is not sufficient, the device can also be configured
+		   to share a single data output channel on alternating frames.
+		   In this configuration, the current and voltage data will be frame interleaved
+		   on a single output channel.
+                   Boolean, define to enable the interleave mode, Default : false
+
+Example:
+
+codec: max98373@31 {
+   compatible = "maxim,max98373";
+   reg = <0x31>;
+   maxim,vmon-slot-no = <0>;
+   maxim,imon-slot-no = <1>;
+   maxim,spkfb-slot-no = <2>;
+   maxim,interleave-mode;
+};
-- 
2.7.4
