From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tas2552: Improve DT binding document
	example" to the asoc tree
Date: Wed, 15 Mar 2017 18:13:57 +0000
Message-ID: <E1coDQr-0002SW-1Y@debutante>
References: <1489434963-2843-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AE09B267094
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 19:14:10 +0100 (CET)
In-Reply-To: <1489434963-2843-1-git-send-email-festevam@gmail.com>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, dmurphy@ti.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tas2552: Improve DT binding document example

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

>From 6cd6ad0e45b9ea48bf3b62eee2dd7238f3e4dd7c Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Mon, 13 Mar 2017 16:56:03 -0300
Subject: [PATCH] ASoC: tas2552: Improve DT binding document example

Improve DT binding document example by providing the mandatory
regulator properties.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/tas2552.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tas2552.txt b/Documentation/devicetree/bindings/sound/tas2552.txt
index c49992c0b62a..54c1c87c4ad8 100644
--- a/Documentation/devicetree/bindings/sound/tas2552.txt
+++ b/Documentation/devicetree/bindings/sound/tas2552.txt
@@ -25,6 +25,9 @@ Example:
 tas2552: tas2552@41 {
 	compatible = "ti,tas2552";
 	reg = <0x41>;
+	vbat-supply = <&reg_vbat>;
+	iovdd-supply = <&reg_iovdd>;
+	avdd-supply = <&reg_avdd>;
 	enable-gpio = <&gpio4 2 GPIO_ACTIVE_HIGH>;
 };
 
-- 
2.11.0
