From: timothyc.howe@gmail.com
Subject: [PATCH - CS4349 2/2] Add devicetree bindings for
	Cirrus Logic CS4349
Date: Mon, 13 Jul 2015 15:08:44 -0500
Message-ID: <55a41ad3.c4a76b0a.fee3d.35e9@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f170.google.com (mail-ie0-f170.google.com
 [209.85.223.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AFF32625D7
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 22:08:54 +0200 (CEST)
Received: by iecuq6 with SMTP id uq6so243002311iec.2
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 13:08:51 -0700 (PDT)
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
Cc: brian.austin@cirrus.com, broonie@kernel.org, lgirdwood@gmail.com, Tim Howe <tim.howe@cirrus.com>
List-Id: alsa-devel@alsa-project.org

From: Tim Howe <tim.howe@cirrus.com>

Signed-off-by: Tim Howe <tim.howe@cirrus.com>
---
 Documentation/devicetree/bindings/sound/cs4349.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cs4349.txt

diff --git a/Documentation/devicetree/bindings/sound/cs4349.txt b/Documentation/devicetree/bindings/sound/cs4349.txt
new file mode 100644
index 0000000..54c117b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cs4349.txt
@@ -0,0 +1,19 @@
+CS4349 audio CODEC
+
+Required properties:
+
+  - compatible : "cirrus,cs4349"
+
+  - reg : the I2C address of the device for I2C
+
+Optional properties:
+
+  - reset-gpios : a GPIO spec for the reset pin.
+
+Example:
+
+codec: cs4349@48 {
+        compatible = "cirrus,cs4349";
+        reg = <0x48>;
+        reset-gpios = <&gpio 54 0>;
+};
-- 
2.4.5
