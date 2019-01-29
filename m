From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Documentation: Add google,
	cros-ec-codec" to the asoc tree
Date: Tue, 29 Jan 2019 12:14:09 +0000 (GMT)
Message-ID: <20190129121409.B8B441127D50@debutante.sirena.org.uk>
References: <20190119113332.249720-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FD8D26749A
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2019 13:14:10 +0100 (CET)
In-Reply-To: <20190119113332.249720-1-cychiang@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: alsa-devel@alsa-project.org, tzungbi@chromium.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Rohit kumar <rohitkr@codeaurora.org>, Guenter Roeck <groeck@chromium.org>, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Documentation: Add google, cros-ec-codec

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 494a3503d684b6fc497623bc01e3e16f8def0499 Mon Sep 17 00:00:00 2001
From: Cheng-Yi Chiang <cychiang@chromium.org>
Date: Sat, 19 Jan 2019 19:33:31 +0800
Subject: [PATCH] ASoC: Documentation: Add google, cros-ec-codec

Add documentation for Chrome EC codec driver.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
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
index 9f64f8d3740e..3bcc5465e460 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3687,6 +3687,13 @@ N:	cros_ec
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
2.20.1
