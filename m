From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: codec: realtek: Make the node name
	generic
Date: Sun, 20 May 2018 12:22:48 -0300
Message-ID: <1526829768-15001-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f195.google.com (mail-qk0-f195.google.com
 [209.85.220.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B0F12671D2
 for <alsa-devel@alsa-project.org>; Sun, 20 May 2018 17:22:52 +0200 (CEST)
Received: by mail-qk0-f195.google.com with SMTP id s70-v6so10050585qks.13
 for <alsa-devel@alsa-project.org>; Sun, 20 May 2018 08:22:51 -0700 (PDT)
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

"The name of a node should be somewhat generic, reflecting the function
of the device and not its precise programming model."

Do as suggested in the bindings examples.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 Documentation/devicetree/bindings/sound/rt274.txt  | 2 +-
 Documentation/devicetree/bindings/sound/rt5514.txt | 2 +-
 Documentation/devicetree/bindings/sound/rt5616.txt | 2 +-
 Documentation/devicetree/bindings/sound/rt5645.txt | 2 +-
 Documentation/devicetree/bindings/sound/rt5651.txt | 2 +-
 Documentation/devicetree/bindings/sound/rt5663.txt | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rt274.txt b/Documentation/devicetree/bindings/sound/rt274.txt
index e9a6178..791a1bd 100644
--- a/Documentation/devicetree/bindings/sound/rt274.txt
+++ b/Documentation/devicetree/bindings/sound/rt274.txt
@@ -26,7 +26,7 @@ Pins on the device (for linking into audio routes) for RT274:
 
 Example:
 
-codec: rt274@1c {
+rt274: codec@1c {
 	compatible = "realtek,rt274";
 	reg = <0x1c>;
 	interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
diff --git a/Documentation/devicetree/bindings/sound/rt5514.txt b/Documentation/devicetree/bindings/sound/rt5514.txt
index 4f33b0d..b25ed08 100644
--- a/Documentation/devicetree/bindings/sound/rt5514.txt
+++ b/Documentation/devicetree/bindings/sound/rt5514.txt
@@ -32,7 +32,7 @@ Pins on the device (for linking into audio routes) for I2C:
 
 Example:
 
-codec: rt5514@57 {
+rt5514: codec@57 {
 	compatible = "realtek,rt5514";
 	reg = <0x57>;
 };
diff --git a/Documentation/devicetree/bindings/sound/rt5616.txt b/Documentation/devicetree/bindings/sound/rt5616.txt
index e410858..540a4bf 100644
--- a/Documentation/devicetree/bindings/sound/rt5616.txt
+++ b/Documentation/devicetree/bindings/sound/rt5616.txt
@@ -26,7 +26,7 @@ Pins on the device (for linking into audio routes) for RT5616:
 
 Example:
 
-codec: rt5616@1b {
+rt5616: codec@1b {
 	compatible = "realtek,rt5616";
 	reg = <0x1b>;
 };
diff --git a/Documentation/devicetree/bindings/sound/rt5645.txt b/Documentation/devicetree/bindings/sound/rt5645.txt
index 7cee1f51..a03f9a8 100644
--- a/Documentation/devicetree/bindings/sound/rt5645.txt
+++ b/Documentation/devicetree/bindings/sound/rt5645.txt
@@ -69,4 +69,4 @@ codec: rt5650@1a {
 	realtek,dmic-en = "true";
 	realtek,en-jd-func = "true";
 	realtek,jd-mode = <3>;
-};
\ No newline at end of file
+};
diff --git a/Documentation/devicetree/bindings/sound/rt5651.txt b/Documentation/devicetree/bindings/sound/rt5651.txt
index b852218..a41199a 100644
--- a/Documentation/devicetree/bindings/sound/rt5651.txt
+++ b/Documentation/devicetree/bindings/sound/rt5651.txt
@@ -50,7 +50,7 @@ Pins on the device (for linking into audio routes) for RT5651:
 
 Example:
 
-codec: rt5651@1a {
+rt5651: codec@1a {
 	compatible = "realtek,rt5651";
 	reg = <0x1a>;
 	realtek,dmic-en = "true";
diff --git a/Documentation/devicetree/bindings/sound/rt5663.txt b/Documentation/devicetree/bindings/sound/rt5663.txt
index 497bcfc..2338644 100644
--- a/Documentation/devicetree/bindings/sound/rt5663.txt
+++ b/Documentation/devicetree/bindings/sound/rt5663.txt
@@ -47,7 +47,7 @@ Pins on the device (for linking into audio routes) for RT5663:
 
 Example:
 
-codec: rt5663@12 {
+rt5663: codec@12 {
 	compatible = "realtek,rt5663";
 	reg = <0x12>;
 	interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
-- 
2.7.4
