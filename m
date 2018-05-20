From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: codec: wolfson: Make the node name
	generic
Date: Sun, 20 May 2018 09:53:41 -0300
Message-ID: <1526820821-12106-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f195.google.com (mail-qk0-f195.google.com
 [209.85.220.195])
 by alsa0.perex.cz (Postfix) with ESMTP id DB5512671D2
 for <alsa-devel@alsa-project.org>; Sun, 20 May 2018 14:53:43 +0200 (CEST)
Received: by mail-qk0-f195.google.com with SMTP id a74-v6so2618844qkg.7
 for <alsa-devel@alsa-project.org>; Sun, 20 May 2018 05:53:43 -0700 (PDT)
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

According to Devicetree Specification v0.2 document:

"The name of a node should be somewhat generic, reflecting the function
of the device and not its precise programming model."

Do as suggested in the bindings examples.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 Documentation/devicetree/bindings/sound/wm8510.txt | 2 +-
 Documentation/devicetree/bindings/sound/wm8523.txt | 2 +-
 Documentation/devicetree/bindings/sound/wm8524.txt | 2 +-
 Documentation/devicetree/bindings/sound/wm8580.txt | 2 +-
 Documentation/devicetree/bindings/sound/wm8711.txt | 2 +-
 Documentation/devicetree/bindings/sound/wm8728.txt | 2 +-
 Documentation/devicetree/bindings/sound/wm8731.txt | 2 +-
 Documentation/devicetree/bindings/sound/wm8737.txt | 2 +-
 Documentation/devicetree/bindings/sound/wm8741.txt | 2 +-
 Documentation/devicetree/bindings/sound/wm8750.txt | 2 +-
 Documentation/devicetree/bindings/sound/wm8753.txt | 2 +-
 Documentation/devicetree/bindings/sound/wm8770.txt | 2 +-
 Documentation/devicetree/bindings/sound/wm8776.txt | 2 +-
 Documentation/devicetree/bindings/sound/wm8804.txt | 2 +-
 Documentation/devicetree/bindings/sound/wm8903.txt | 2 +-
 Documentation/devicetree/bindings/sound/wm8994.txt | 2 +-
 16 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/wm8510.txt b/Documentation/devicetree/bindings/sound/wm8510.txt
index fa1a32b..e6b6cc0 100644
--- a/Documentation/devicetree/bindings/sound/wm8510.txt
+++ b/Documentation/devicetree/bindings/sound/wm8510.txt
@@ -12,7 +12,7 @@ Required properties:
 
 Example:
 
-codec: wm8510@1a {
+wm8510: codec@1a {
 	compatible = "wlf,wm8510";
 	reg = <0x1a>;
 };
diff --git a/Documentation/devicetree/bindings/sound/wm8523.txt b/Documentation/devicetree/bindings/sound/wm8523.txt
index 0474618..f3a6485 100644
--- a/Documentation/devicetree/bindings/sound/wm8523.txt
+++ b/Documentation/devicetree/bindings/sound/wm8523.txt
@@ -10,7 +10,7 @@ Required properties:
 
 Example:
 
-codec: wm8523@1a {
+wm8523: codec@1a {
 	compatible = "wlf,wm8523";
 	reg = <0x1a>;
 };
diff --git a/Documentation/devicetree/bindings/sound/wm8524.txt b/Documentation/devicetree/bindings/sound/wm8524.txt
index 0f05535..f6c0c26 100644
--- a/Documentation/devicetree/bindings/sound/wm8524.txt
+++ b/Documentation/devicetree/bindings/sound/wm8524.txt
@@ -10,7 +10,7 @@ Required properties:
 
 Example:
 
-codec: wm8524 {
+wm8524: codec {
 	compatible = "wlf,wm8524";
 	wlf,mute-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
 };
diff --git a/Documentation/devicetree/bindings/sound/wm8580.txt b/Documentation/devicetree/bindings/sound/wm8580.txt
index 78fce9b..ff3f9f5 100644
--- a/Documentation/devicetree/bindings/sound/wm8580.txt
+++ b/Documentation/devicetree/bindings/sound/wm8580.txt
@@ -10,7 +10,7 @@ Required properties:
 
 Example:
 
-codec: wm8580@1a {
+wm8580: codec@1a {
 	compatible = "wlf,wm8580";
 	reg = <0x1a>;
 };
diff --git a/Documentation/devicetree/bindings/sound/wm8711.txt b/Documentation/devicetree/bindings/sound/wm8711.txt
index 8ed9998..c30a138 100644
--- a/Documentation/devicetree/bindings/sound/wm8711.txt
+++ b/Documentation/devicetree/bindings/sound/wm8711.txt
@@ -12,7 +12,7 @@ Required properties:
 
 Example:
 
-codec: wm8711@1a {
+wm8711: codec@1a {
 	compatible = "wlf,wm8711";
 	reg = <0x1a>;
 };
diff --git a/Documentation/devicetree/bindings/sound/wm8728.txt b/Documentation/devicetree/bindings/sound/wm8728.txt
index a8b5c36..a3608b4 100644
--- a/Documentation/devicetree/bindings/sound/wm8728.txt
+++ b/Documentation/devicetree/bindings/sound/wm8728.txt
@@ -12,7 +12,7 @@ Required properties:
 
 Example:
 
-codec: wm8728@1a {
+wm8728: codec@1a {
 	compatible = "wlf,wm8728";
 	reg = <0x1a>;
 };
diff --git a/Documentation/devicetree/bindings/sound/wm8731.txt b/Documentation/devicetree/bindings/sound/wm8731.txt
index 236690e..f660d9b 100644
--- a/Documentation/devicetree/bindings/sound/wm8731.txt
+++ b/Documentation/devicetree/bindings/sound/wm8731.txt
@@ -12,7 +12,7 @@ Required properties:
 
 Example:
 
-codec: wm8731@1a {
+wm8731: codec@1a {
 	compatible = "wlf,wm8731";
 	reg = <0x1a>;
 };
diff --git a/Documentation/devicetree/bindings/sound/wm8737.txt b/Documentation/devicetree/bindings/sound/wm8737.txt
index 4bc2cea..eda1ec6 100644
--- a/Documentation/devicetree/bindings/sound/wm8737.txt
+++ b/Documentation/devicetree/bindings/sound/wm8737.txt
@@ -12,7 +12,7 @@ Required properties:
 
 Example:
 
-codec: wm8737@1a {
+wm8737: codec@1a {
 	compatible = "wlf,wm8737";
 	reg = <0x1a>;
 };
diff --git a/Documentation/devicetree/bindings/sound/wm8741.txt b/Documentation/devicetree/bindings/sound/wm8741.txt
index a133154..b69e196 100644
--- a/Documentation/devicetree/bindings/sound/wm8741.txt
+++ b/Documentation/devicetree/bindings/sound/wm8741.txt
@@ -21,7 +21,7 @@ Optional properties:
 
 Example:
 
-codec: wm8741@1a {
+wm8741: codec@1a {
 	compatible = "wlf,wm8741";
 	reg = <0x1a>;
 
diff --git a/Documentation/devicetree/bindings/sound/wm8750.txt b/Documentation/devicetree/bindings/sound/wm8750.txt
index 8db239f..682f221 100644
--- a/Documentation/devicetree/bindings/sound/wm8750.txt
+++ b/Documentation/devicetree/bindings/sound/wm8750.txt
@@ -12,7 +12,7 @@ Required properties:
 
 Example:
 
-codec: wm8750@1a {
+wm8750: codec@1a {
 	compatible = "wlf,wm8750";
 	reg = <0x1a>;
 };
diff --git a/Documentation/devicetree/bindings/sound/wm8753.txt b/Documentation/devicetree/bindings/sound/wm8753.txt
index 8eee612..eca9e5a 100644
--- a/Documentation/devicetree/bindings/sound/wm8753.txt
+++ b/Documentation/devicetree/bindings/sound/wm8753.txt
@@ -34,7 +34,7 @@ Pins on the device (for linking into audio routes):
 
 Example:
 
-codec: wm8753@1a {
+wm8753: codec@1a {
 	compatible = "wlf,wm8753";
 	reg = <0x1a>;
 };
diff --git a/Documentation/devicetree/bindings/sound/wm8770.txt b/Documentation/devicetree/bindings/sound/wm8770.txt
index 866e00c..cac762a 100644
--- a/Documentation/devicetree/bindings/sound/wm8770.txt
+++ b/Documentation/devicetree/bindings/sound/wm8770.txt
@@ -10,7 +10,7 @@ Required properties:
 
 Example:
 
-codec: wm8770@1 {
+wm8770: codec@1 {
 	compatible = "wlf,wm8770";
 	reg = <1>;
 };
diff --git a/Documentation/devicetree/bindings/sound/wm8776.txt b/Documentation/devicetree/bindings/sound/wm8776.txt
index 3b9ca49..0117336 100644
--- a/Documentation/devicetree/bindings/sound/wm8776.txt
+++ b/Documentation/devicetree/bindings/sound/wm8776.txt
@@ -12,7 +12,7 @@ Required properties:
 
 Example:
 
-codec: wm8776@1a {
+wm8776: codec@1a {
 	compatible = "wlf,wm8776";
 	reg = <0x1a>;
 };
diff --git a/Documentation/devicetree/bindings/sound/wm8804.txt b/Documentation/devicetree/bindings/sound/wm8804.txt
index 6fd124b..2c1641c 100644
--- a/Documentation/devicetree/bindings/sound/wm8804.txt
+++ b/Documentation/devicetree/bindings/sound/wm8804.txt
@@ -19,7 +19,7 @@ Optional properties:
 
 Example:
 
-codec: wm8804@1a {
+wm8804: codec@1a {
 	compatible = "wlf,wm8804";
 	reg = <0x1a>;
 };
diff --git a/Documentation/devicetree/bindings/sound/wm8903.txt b/Documentation/devicetree/bindings/sound/wm8903.txt
index afc51ca..6371c24 100644
--- a/Documentation/devicetree/bindings/sound/wm8903.txt
+++ b/Documentation/devicetree/bindings/sound/wm8903.txt
@@ -57,7 +57,7 @@ Pins on the device (for linking into audio routes):
 
 Example:
 
-codec: wm8903@1a {
+wm8903: codec@1a {
 	compatible = "wlf,wm8903";
 	reg = <0x1a>;
 	interrupts = < 347 >;
diff --git a/Documentation/devicetree/bindings/sound/wm8994.txt b/Documentation/devicetree/bindings/sound/wm8994.txt
index 68c4e8d..4a9dead 100644
--- a/Documentation/devicetree/bindings/sound/wm8994.txt
+++ b/Documentation/devicetree/bindings/sound/wm8994.txt
@@ -59,7 +59,7 @@ Optional properties:
 
 Example:
 
-codec: wm8994@1a {
+wm8994: codec@1a {
 	compatible = "wlf,wm8994";
 	reg = <0x1a>;
 
-- 
2.7.4
