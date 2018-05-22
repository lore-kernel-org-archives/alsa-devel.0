From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec: realtek: Make the node name
	generic" to the asoc tree
Date: Tue, 22 May 2018 11:58:22 +0100
Message-ID: <E1fL4zm-0000PV-Cv@debutante>
References: <1526829768-15001-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C3D4426765C
 for <alsa-devel@alsa-project.org>; Tue, 22 May 2018 12:58:27 +0200 (CEST)
In-Reply-To: <1526829768-15001-1-git-send-email-festevam@gmail.com>
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

   ASoC: codec: realtek: Make the node name generic

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

>From 520a76f855e570c11fd042dd2ab4712ce33fb3a0 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Sun, 20 May 2018 12:22:48 -0300
Subject: [PATCH] ASoC: codec: realtek: Make the node name generic

"The name of a node should be somewhat generic, reflecting the function
of the device and not its precise programming model."

Do as suggested in the bindings examples.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/rt274.txt  | 2 +-
 Documentation/devicetree/bindings/sound/rt5514.txt | 2 +-
 Documentation/devicetree/bindings/sound/rt5616.txt | 2 +-
 Documentation/devicetree/bindings/sound/rt5645.txt | 2 +-
 Documentation/devicetree/bindings/sound/rt5651.txt | 2 +-
 Documentation/devicetree/bindings/sound/rt5663.txt | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rt274.txt b/Documentation/devicetree/bindings/sound/rt274.txt
index e9a6178c78cf..791a1bd767b9 100644
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
index 4f33b0d96afe..b25ed08c7a5a 100644
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
index e41085818559..540a4bf252e4 100644
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
index 7cee1f518f59..a03f9a872a71 100644
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
index b85221864cec..a41199a5cd79 100644
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
index 497bcfc58b71..23386446c63d 100644
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
2.17.0
