From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7213: Add bindings documentation for
	codec driver" to the asoc tree
Date: Wed, 07 Oct 2015 15:12:04 +0100
Message-ID: <E1ZjpRs-0007T3-DE@finisterre>
References: <d86c170c3eaea34e128026b04126b699e0311d65.1444042230.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 55E382664EB
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 16:12:21 +0200 (CEST)
In-Reply-To: <d86c170c3eaea34e128026b04126b699e0311d65.1444042230.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7213: Add bindings documentation for codec driver

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From a97d4e93a9bc556d0b3c2efb7695eb4c79938de7 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Wed, 7 Oct 2015 14:27:13 +0100
Subject: [PATCH] ASoC: da7213: Add bindings documentation for codec driver

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/da7213.txt | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/da7213.txt

diff --git a/Documentation/devicetree/bindings/sound/da7213.txt b/Documentation/devicetree/bindings/sound/da7213.txt
new file mode 100644
index 0000000..7280e82
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/da7213.txt
@@ -0,0 +1,41 @@
+Dialog Semiconductor DA7213 Audio Codec bindings
+
+======
+
+Required properties:
+- compatible : Should be "dlg,da7213"
+- reg: Specifies the I2C slave address
+
+Optional properties:
+- clocks : phandle and clock specifier for codec MCLK.
+- clock-names : Clock name string for 'clocks' attribute, should be "mclk".
+
+- dlg,micbias1-lvl : Voltage (mV) for Mic Bias 1
+	[<1600>, <2200>, <2500>, <3000>]
+- dlg,micbias2-lvl : Voltage (mV) for Mic Bias 2
+	[<1600>, <2200>, <2500>, <3000>]
+- dlg,dmic-data-sel : DMIC channel select based on clock edge.
+	["lrise_rfall", "lfall_rrise"]
+- dlg,dmic-samplephase : When to sample audio from DMIC.
+	["on_clkedge", "between_clkedge"]
+- dlg,dmic-clkrate : DMIC clock frequency (MHz).
+	[<1500000>, <3000000>]
+
+======
+
+Example:
+
+	codec_i2c: da7213@1a {
+		compatible = "dlg,da7213";
+ 		reg = <0x1a>;
+
+ 		clocks = <&clks 201>;
+		clock-names = "mclk";
+
+		dlg,micbias1-lvl = <2500>;
+		dlg,micbias2-lvl = <2500>;
+
+		dlg,dmic-data-sel = "lrise_rfall";
+		dlg,dmic-samplephase = "between_clkedge";
+		dlg,dmic-clkrate = <3000000>;
+	};
-- 
2.5.0
