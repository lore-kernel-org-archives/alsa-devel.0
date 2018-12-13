From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: add axg spdif input DT binding
	documentation" to the asoc tree
Date: Thu, 13 Dec 2018 12:08:43 +0000 (GMT)
Message-ID: <20181213120843.876CB11254D1@debutante.sirena.org.uk>
References: <20181211134713.4908-3-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D3AC2267BA5
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 13:08:44 +0100 (CET)
In-Reply-To: <20181211134713.4908-3-jbrunet@baylibre.com>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: meson: add axg spdif input DT binding documentation

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

>From 18dc4665fb6f3bb617c2e6d7da3f19586d06ab17 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 11 Dec 2018 14:47:11 +0100
Subject: [PATCH] ASoC: meson: add axg spdif input DT binding documentation

Add the DT binding documentation for axg's SPDIF input.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/amlogic,axg-spdifin.txt    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
new file mode 100644
index 000000000000..2e6cb7d9b202
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
@@ -0,0 +1,22 @@
+* Amlogic Audio SPDIF Input
+
+Required properties:
+- compatible: 'amlogic,axg-spdifin'
+- interrupts: interrupt specifier for the spdif input.
+- clocks: list of clock phandle, one for each entry clock-names.
+- clock-names: should contain the following:
+  * "pclk" : peripheral clock.
+  * "refclk" : spdif input reference clock
+- #sound-dai-cells: must be 0.
+
+Example on the A113 SoC:
+
+spdifin: audio-controller@400 {
+	compatible = "amlogic,axg-spdifin";
+	reg = <0x0 0x400 0x0 0x30>;
+	#sound-dai-cells = <0>;
+	interrupts = <GIC_SPI 87 IRQ_TYPE_EDGE_RISING>;
+	clocks = <&clkc_audio AUD_CLKID_SPDIFIN>,
+		 <&clkc_audio AUD_CLKID_SPDIFIN_CLK>;
+	clock-names = "pclk", "refclk";
+};
-- 
2.19.0.rc2
