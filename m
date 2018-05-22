From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec: wolfson: Make the node name
	generic" to the asoc tree
Date: Tue, 22 May 2018 11:58:32 +0100
Message-ID: <E1fL4zw-0000Qa-D7@debutante>
References: <1526820821-12106-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B2B5C267671
 for <alsa-devel@alsa-project.org>; Tue, 22 May 2018 12:58:35 +0200 (CEST)
In-Reply-To: <1526820821-12106-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec: wolfson: Make the node name generic

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

>From 34f5897c59d19ac1b97fd4030b430ac4658c722c Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Sun, 20 May 2018 09:53:41 -0300
Subject: [PATCH] ASoC: codec: wolfson: Make the node name generic

According to Devicetree Specification v0.2 document:

"The name of a node should be somewhat generic, reflecting the function
of the device and not its precise programming model."

Do as suggested in the bindings examples.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
index fa1a32b85577..e6b6cc041f89 100644
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
index 04746186b283..f3a6485f4b8a 100644
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
index 0f0553563fc1..f6c0c263b135 100644
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
index 78fce9b14954..ff3f9f5f2111 100644
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
index 8ed9998cd23c..c30a1387c4bf 100644
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
index a8b5c3668e60..a3608b4c78b9 100644
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
index 236690e99b87..f660d9bb0e69 100644
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
index 4bc2cea3b140..eda1ec6a7563 100644
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
index a13315408719..b69e196c741c 100644
--- a/Documentation/devicetree/bindings/sound/wm8741.txt
+++ b/Documentation/devicetree/bindings/sound/wm8741.txt
@@ -21,7 +21,7 @@ Optional properties:
 
 Example:
 
-codec: wm8741@1a {
+wm8741: codec@1a {
 	compatible = "wlf,wm8741";
 	reg = <0x1a>;
 
diff --git a/Documentation/devicetree/bindings/sound/wm8750.txt b/Documentation/devicetree/bindings/sound/wm8750.txt
index 8db239fd5ecd..682f221f6f38 100644
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
index 8eee61282105..eca9e5a825a9 100644
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
index 866e00ca150b..cac762a1105d 100644
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
index 3b9ca49abc2b..01173369c3ed 100644
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
index 6fd124b16496..2c1641c17a91 100644
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
index afc51caf1137..6371c2434afe 100644
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
index 68c4e8d96bed..4a9dead1b7d3 100644
--- a/Documentation/devicetree/bindings/sound/wm8994.txt
+++ b/Documentation/devicetree/bindings/sound/wm8994.txt
@@ -59,7 +59,7 @@ Optional properties:
 
 Example:
 
-codec: wm8994@1a {
+wm8994: codec@1a {
 	compatible = "wlf,wm8994";
 	reg = <0x1a>;
 
-- 
2.17.0
