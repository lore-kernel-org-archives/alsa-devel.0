From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sgtl5000: Pass the required
	'#sound-dai-cells'" to the asoc tree
Date: Mon, 12 Mar 2018 21:32:56 +0000 (GMT)
Message-ID: <20180312213256.D8367440079@finisterre.ee.mobilebroadband>
References: <1520890089-29191-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 74FD2266F0F
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 22:32:59 +0100 (CET)
In-Reply-To: <1520890089-29191-1-git-send-email-festevam@gmail.com>
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

   ASoC: sgtl5000: Pass the required '#sound-dai-cells'

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

>From c4e50b1d87fbbeabb2d7f286af673666f507acb9 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Mon, 12 Mar 2018 18:28:09 -0300
Subject: [PATCH] ASoC: sgtl5000: Pass the required '#sound-dai-cells'

DTC now warns about missing #sound-dai-cells:

arch/arm/boot/dts/imx6ul-geam.dtb: Warning (sound_dai_property): /sound/simple-audio-card,codec: Missing property '#sound-dai-cells' in node /soc/aips-bus@2100000/i2c@21a0000/codec@a or bad phandle (referred from sound-dai[0])

Pass the required '#sound-dai-cells' property to improve the documentation.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/sgtl5000.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/sgtl5000.txt b/Documentation/devicetree/bindings/sound/sgtl5000.txt
index 060cb4a3b47e..9a36c7e2a143 100644
--- a/Documentation/devicetree/bindings/sound/sgtl5000.txt
+++ b/Documentation/devicetree/bindings/sound/sgtl5000.txt
@@ -5,6 +5,8 @@ Required properties:
 
 - reg : the I2C address of the device
 
+- #sound-dai-cells: must be equal to 0
+
 - clocks : the clock provider of SYS_MCLK
 
 - VDDA-supply : the regulator provider of VDDA
@@ -40,6 +42,7 @@ Example:
 codec: sgtl5000@a {
 	compatible = "fsl,sgtl5000";
 	reg = <0x0a>;
+	#sound-dai-cells = <0>;
 	clocks = <&clks 150>;
 	micbias-resistor-k-ohms = <2>;
 	micbias-voltage-m-volts = <2250>;
-- 
2.16.2
