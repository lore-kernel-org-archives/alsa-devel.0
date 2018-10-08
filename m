From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dt-bindings: max98088: add external
	clock binding" to the asoc tree
Date: Mon,  8 Oct 2018 19:54:52 +0100 (BST)
Message-ID: <20181008185452.A72E3440078@finisterre.ee.mobilebroadband>
References: <20181005075812.13986-4-m.felsch@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C825226778A
 for <alsa-devel@alsa-project.org>; Mon,  8 Oct 2018 20:54:53 +0200 (CEST)
In-Reply-To: <20181005075812.13986-4-m.felsch@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dt-bindings: max98088: add external clock binding

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

>From d6ed11edab5dd10ddf5548c02a9a1132ec728640 Mon Sep 17 00:00:00 2001
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Fri, 5 Oct 2018 09:58:10 +0200
Subject: [PATCH] ASoC: dt-bindings: max98088: add external clock binding

Allow setting the clock provider for the external clock called "mclk".

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/maxim,max98088.txt          | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/maxim,max98088.txt b/Documentation/devicetree/bindings/sound/maxim,max98088.txt
index a79ad5c7af88..da764d913319 100644
--- a/Documentation/devicetree/bindings/sound/maxim,max98088.txt
+++ b/Documentation/devicetree/bindings/sound/maxim,max98088.txt
@@ -7,9 +7,17 @@ Required properties:
 - compatible: "maxim,max98088" or "maxim,max98089".
 - reg: The I2C address of the device.
 
+Optional properties:
+
+- clocks: the clock provider of MCLK, see ../clock/clock-bindings.txt section
+  "consumer" for more information.
+- clock-names: must be set to "mclk"
+
 Example:
 
 max98089: codec@10 {
 	compatible = "maxim,max98089";
 	reg = <0x10>;
+	clocks = <&clks IMX6QDL_CLK_CKO2>;
+	clock-names = "mclk";
 };
-- 
2.19.0
