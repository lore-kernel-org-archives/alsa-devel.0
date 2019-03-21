From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7219: Update DAI clock binding info to cover WCLK/BCLK" to the asoc tree
Date: Thu, 21 Mar 2019 15:07:09 +0000 (GMT)
Message-ID: <20190321150709.C97CB11288EC@debutante.sirena.org.uk>
References: <a2e2ae888b3c2fbcaab3e4791ce98f877e3d38ff.1553017237.git.Adam.Thomson.Opensource@diasemi.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a2e2ae888b3c2fbcaab3e4791ce98f877e3d38ff.1553017237.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>, Akshu Agrawal <Akshu.Agrawal@amd.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7219: Update DAI clock binding info to cover WCLK/BCLK

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

>From 41d176d3ec147f499614adc773080f244d47e3cd Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 19 Mar 2019 17:49:30 +0000
Subject: [PATCH] ASoC: da7219: Update DAI clock binding info to cover
 WCLK/BCLK

With the need to expose WCLK and BCLK as separate clocks, the
'clock-cells' and 'clock-output-names' descriptions need to be
updated as now the codec is providing 2 clocks. The example is
also updated accordingly.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/da7219.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/da7219.txt b/Documentation/devicetree/bindings/sound/da7219.txt
index e9d0baeb94e2..add1caf26ac2 100644
--- a/Documentation/devicetree/bindings/sound/da7219.txt
+++ b/Documentation/devicetree/bindings/sound/da7219.txt
@@ -23,8 +23,8 @@ Optional properties:
   interrupt is to be used to wake system, otherwise "irq" should be used.
 - wakeup-source: Flag to indicate this device can wake system (suspend/resume).
 
-- #clock-cells :  Should be set to '<0>', only one clock source provided;
-- clock-output-names : Name given for DAI clocks output;
+- #clock-cells :  Should be set to '<1>', two clock sources provided;
+- clock-output-names : Names given for DAI clock outputs (WCLK & BCLK);
 
 - clocks : phandle and clock specifier for codec MCLK.
 - clock-names : Clock name string for 'clocks' attribute, should be "mclk".
@@ -84,8 +84,8 @@ Example:
 		VDDMIC-supply = <&reg_audio>;
 		VDDIO-supply = <&reg_audio>;
 
-		#clock-cells = <0>;
-		clock-output-names = "dai-clks";
+		#clock-cells = <1>;
+		clock-output-names = "dai-wclk", "dai-bclk";
 
 		clocks = <&clks 201>;
 		clock-names = "mclk";
-- 
2.20.1
