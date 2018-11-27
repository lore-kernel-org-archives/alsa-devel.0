From: Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH 2/3] ASoC: Documentation: Add google,cros-ec-codec
Date: Tue, 27 Nov 2018 20:00:40 +0800
Message-ID: <20181127120041.90759-2-cychiang@chromium.org>
References: <20181127120041.90759-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181127120041.90759-1-cychiang@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, dgreid@chromium.org, tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>, Cheng-Yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org

Add documentation for Chrome EC codec driver.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 .../bindings/sound/google,cros-ec-codec.txt   | 24 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++++
 2 files changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt

diff --git a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
new file mode 100644
index 0000000000000..57718382b3a36
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
@@ -0,0 +1,24 @@
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
+	};
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 91b4218195aac..5cf8ab296cc61 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3552,6 +3552,11 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git
 F:	drivers/platform/chrome/
 
+CHROME EC CODEC DRIVER
+M:	Cheng-Yi Chiang <cychiang@chromium.org>
+S:	Maintained
+F:	Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
+
 CIRRUS LOGIC AUDIO CODEC DRIVERS
 M:	Brian Austin <brian.austin@cirrus.com>
 M:	Paul Handrigan <Paul.Handrigan@cirrus.com>
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog
