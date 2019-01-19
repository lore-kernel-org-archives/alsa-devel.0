From: Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v4 1/2] ASoC: Documentation: Add google,cros-ec-codec
Date: Sat, 19 Jan 2019 19:33:31 +0800
Message-ID: <20190119113332.249720-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, dgreid@chromium.org, tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>, Guenter Roeck <groeck@chromium.org>, Cheng-Yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org

Add documentation for Chrome EC codec driver.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 Change in v4:
 - Add a property max-dmic-gain so we can configure maximum gain on dmic.
 - Add Guenter to the reviewer list.

 .../bindings/sound/google,cros-ec-codec.txt   | 26 +++++++++++++++++++
 MAINTAINERS                                   |  7 +++++
 2 files changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt

diff --git a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
new file mode 100644
index 000000000000..1084f7f22eea
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
@@ -0,0 +1,26 @@
+* Audio codec controlled by ChromeOS EC
+
+Google's ChromeOS EC codec is a digital mic codec provided by the
+Embedded Controller (EC) and is controlled via a host-command interface.
+
+An EC codec node should only be found as a sub-node of the EC node (see
+Documentation/devicetree/bindings/mfd/cros-ec.txt).
+
+Required properties:
+- compatible: Must contain "google,cros-ec-codec"
+- #sound-dai-cells: Should be 1. The cell specifies number of DAIs.
+- max-dmic-gain: A number for maximum gain in dB on digital microphone.
+
+Example:
+
+cros-ec@0 {
+	compatible = "google,cros-ec-spi";
+
+	...
+
+	cros_ec_codec: ec-codec {
+		compatible = "google,cros-ec-codec";
+		#sound-dai-cells = <1>;
+		max-dmic-gain = <43>;
+	};
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 4d04cebb4a71..a5678e4041e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3688,6 +3688,13 @@ N:	cros_ec
 N:	cros-ec
 F:	drivers/power/supply/cros_usbpd-charger.c
 
+CHROMEOS EC CODEC DRIVER
+M:	Cheng-Yi Chiang <cychiang@chromium.org>
+S:	Maintained
+R:	Enric Balletbo i Serra <enric.balletbo@collabora.com>
+R:	Guenter Roeck <groeck@chromium.org>
+F:	Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
+
 CIRRUS LOGIC AUDIO CODEC DRIVERS
 M:	Brian Austin <brian.austin@cirrus.com>
 M:	Paul Handrigan <Paul.Handrigan@cirrus.com>
-- 
2.20.1.321.g9e740568ce-goog
