From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: add axg pdm input DT binding
	documentation" to the asoc tree
Date: Wed, 29 Aug 2018 16:08:49 +0100 (BST)
Message-ID: <20180829150849.095D3112486B@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F25E26766C
 for <alsa-devel@alsa-project.org>; Wed, 29 Aug 2018 17:08:49 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: meson: add axg pdm input DT binding documentation

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

>From 5cc3f8f89f2a42992315c4917e0c67ccb0269dec Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 29 Aug 2018 17:00:50 +0200
Subject: [PATCH] ASoC: meson: add axg pdm input DT binding documentation

Add the DT binding documentation for axg's PDM input

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/amlogic,axg-pdm.txt        | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt
new file mode 100644
index 000000000000..5672d0bc5b16
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt
@@ -0,0 +1,24 @@
+* Amlogic Audio PDM input
+
+Required properties:
+- compatible: 'amlogic,axg-pdm'
+- reg: physical base address of the controller and length of memory
+       mapped region.
+- clocks: list of clock phandle, one for each entry clock-names.
+- clock-names: should contain the following:
+  * "pclk"   : peripheral clock.
+  * "dclk"   : pdm digital clock
+  * "sysclk" : dsp system clock
+- #sound-dai-cells: must be 0.
+
+Example of PDM on the A113 SoC:
+
+pdm: audio-controller@ff632000 {
+	compatible = "amlogic,axg-pdm";
+	reg = <0x0 0xff632000 0x0 0x34>;
+	#sound-dai-cells = <0>;
+	clocks = <&clkc_audio AUD_CLKID_PDM>,
+		 <&clkc_audio AUD_CLKID_PDM_DCLK>,
+		 <&clkc_audio AUD_CLKID_PDM_SYSCLK>;
+	clock-names = "pclk", "dclk", "sysclk";
+};
-- 
2.18.0
