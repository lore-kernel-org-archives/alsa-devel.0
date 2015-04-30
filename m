From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH 2/3] Documentation: devicetree: sound: Add documentation for gtm601 codec
Date: Thu, 30 Apr 2015 23:28:02 +0200
Message-ID: <1430429283-27907-3-git-send-email-marek@goldelico.com>
References: <1430429283-27907-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430429283-27907-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.de
Cc: broonie@kernel.org, hns@goldelico.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Marek Belisko <marek@goldelico.com>
List-Id: alsa-devel@alsa-project.org

Add small documentation for gtm601 UMTS modem audio interface.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 Documentation/devicetree/bindings/sound/gtm601.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/gtm601.txt

diff --git a/Documentation/devicetree/bindings/sound/gtm601.txt b/Documentation/devicetree/bindings/sound/gtm601.txt
new file mode 100644
index 0000000..2d2dbfc
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/gtm601.txt
@@ -0,0 +1,14 @@
+GTM601 UMTS modem audio interface CODEC
+
+This device has no configuration interface. Sample rate is determined automatically
+by examining the Master clock and Bit clock ratios.
+
+Required properties:
+
+  - compatible : "option,gtm601"
+
+Example:
+
+codec: gtm601_codec {
+	compatible = "option,gtm601";
+};
-- 
1.9.1
