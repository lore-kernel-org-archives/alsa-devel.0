From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: add g12a compatibles" to the asoc tree
Date: Fri,  5 Apr 2019 09:43:21 +0700 (+07)
Message-ID: <20190405024322.05F3C441D3C@finisterre.ee.mobilebroadband>
References: <20190404111733.28705-2-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190404111733.28705-2-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Maxime Jourdan <mjourdan@baylibre.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: meson: add g12a compatibles

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

>From 679f4e6cfd45bcc14bb563576e419ac9e43fad7c Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 4 Apr 2019 13:17:28 +0200
Subject: [PATCH] ASoC: meson: add g12a compatibles

Add new compatible strings for the g12a devices.
Audio wise, the g12a is fairly to close to the axg, yet some differences
need to be handled.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt  | 4 +++-
 Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt   | 3 ++-
 .../devicetree/bindings/sound/amlogic,axg-spdifin.txt         | 3 ++-
 .../devicetree/bindings/sound/amlogic,axg-spdifout.txt        | 3 ++-
 .../devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt  | 4 +++-
 5 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
index 3dfc2515e5c6..4330fc9dca6d 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
@@ -2,7 +2,9 @@
 
 Required properties:
 - compatible: 'amlogic,axg-toddr' or
-	      'amlogic,axg-frddr'
+	      'amlogic,axg-toddr' or
+	      'amlogic,g12a-frddr' or
+	      'amlogic,g12a-toddr'
 - reg: physical base address of the controller and length of memory
        mapped region.
 - interrupts: interrupt specifier for the fifo.
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt
index 5672d0bc5b16..73f473a9365f 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt
@@ -1,7 +1,8 @@
 * Amlogic Audio PDM input
 
 Required properties:
-- compatible: 'amlogic,axg-pdm'
+- compatible: 'amlogic,axg-pdm' or
+	      'amlogic,g12a-pdm'
 - reg: physical base address of the controller and length of memory
        mapped region.
 - clocks: list of clock phandle, one for each entry clock-names.
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
index 2e6cb7d9b202..0b82504fa419 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
@@ -1,7 +1,8 @@
 * Amlogic Audio SPDIF Input
 
 Required properties:
-- compatible: 'amlogic,axg-spdifin'
+- compatible: 'amlogic,axg-spdifin' or
+	      'amlogic,g12a-spdifin'
 - interrupts: interrupt specifier for the spdif input.
 - clocks: list of clock phandle, one for each entry clock-names.
 - clock-names: should contain the following:
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt
index 521c38ad89e7..826152730508 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt
@@ -1,7 +1,8 @@
 * Amlogic Audio SPDIF Output
 
 Required properties:
-- compatible: 'amlogic,axg-spdifout'
+- compatible: 'amlogic,axg-spdifout' or
+	      'amlogic,g12a-spdifout'
 - clocks: list of clock phandle, one for each entry clock-names.
 - clock-names: should contain the following:
   * "pclk" : peripheral clock.
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
index 1c1b7490554e..3b94a715a0b9 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
@@ -2,7 +2,9 @@
 
 Required properties:
 - compatible: 'amlogic,axg-tdmin' or
-	      'amlogic,axg-tdmout'
+	      'amlogic,axg-tdmout' or
+	      'amlogic,g12a-tdmin' or
+	      'amlogic,g12a-tdmout'
 - reg: physical base address of the controller and length of memory
        mapped region.
 - clocks: list of clock phandle, one for each entry clock-names.
-- 
2.20.1
