From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dt-bindings: Document support for ak4497" to the asoc tree
Date: Mon,  7 Jan 2019 18:58:35 +0000 (GMT)
Message-ID: <20190107185835.8CDFC1127491@debutante.sirena.org.uk>
References: <20190104162649.13103-3-daniel.baluta@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190104162649.13103-3-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Mark Brown <broonie@kernel.org>"broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Viorel Suman <viorel.suman@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dt-bindings: Document support for ak4497

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

>From 5d8d66077af12681441897a350f346c0da7f5576 Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Fri, 4 Jan 2019 16:27:04 +0000
Subject: [PATCH] ASoC: dt-bindings: Document support for ak4497

ak4458 driver supports also ak4497 codec.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/ak4458.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/ak4458.txt b/Documentation/devicetree/bindings/sound/ak4458.txt
index 7839be78448d..e5820235e0d5 100644
--- a/Documentation/devicetree/bindings/sound/ak4458.txt
+++ b/Documentation/devicetree/bindings/sound/ak4458.txt
@@ -4,7 +4,7 @@ This device supports I2C mode.
 
 Required properties:
 
-- compatible : "asahi-kasei,ak4458"
+- compatible : "asahi-kasei,ak4458" or "asahi-kasei,ak4497"
 - reg : The I2C address of the device for I2C
 
 Optional properties:
-- 
2.20.1
