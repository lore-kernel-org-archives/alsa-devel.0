From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH] ASoC: simple-amplifier: Make gpio property optional
Date: Mon, 18 Mar 2019 11:39:38 +0100
Message-ID: <20190318103938.15035-1-maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>, Maxime Ripard <maxime.ripard@bootlin.com>
List-Id: alsa-devel@alsa-project.org

From: Mylène Josserand <mylene.josserand@bootlin.com>

Some amplifier may not have a GPIO to control the power, but instead simply
rely on the regulator to power up and down the amplifier.

In order to support those setups, let's make the GPIO optional.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 Documentation/devicetree/bindings/sound/simple-amplifier.txt | 2 +-
 sound/soc/codecs/simple-amplifier.c                          | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/simple-amplifier.txt b/Documentation/devicetree/bindings/sound/simple-amplifier.txt
index 7182ac4f1e65..b1b097cc9b68 100644
--- a/Documentation/devicetree/bindings/sound/simple-amplifier.txt
+++ b/Documentation/devicetree/bindings/sound/simple-amplifier.txt
@@ -2,9 +2,9 @@ Simple Amplifier Audio Driver
 
 Required properties:
 - compatible : "dioo,dio2125" or "simple-audio-amplifier"
-- enable-gpios : the gpio connected to the enable pin of the simple amplifier
 
 Optional properties:
+- enable-gpios : the gpio connected to the enable pin of the simple amplifier
 - VCC-supply   : power supply for the device, as covered
                  in Documentation/devicetree/bindings/regulator/regulator.txt
 
diff --git a/sound/soc/codecs/simple-amplifier.c b/sound/soc/codecs/simple-amplifier.c
index c07e8a80b4b7..351aa55c384e 100644
--- a/sound/soc/codecs/simple-amplifier.c
+++ b/sound/soc/codecs/simple-amplifier.c
@@ -89,7 +89,8 @@ static int simple_amp_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, priv);
 
-	priv->gpiod_enable = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
+	priv->gpiod_enable = devm_gpiod_get_optional(dev, "enable",
+						     GPIOD_OUT_LOW);
 	if (IS_ERR(priv->gpiod_enable)) {
 		err = PTR_ERR(priv->gpiod_enable);
 		if (err != -EPROBE_DEFER)
-- 
2.20.1
