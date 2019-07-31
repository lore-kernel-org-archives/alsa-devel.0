From: Mark Brown <broonie@kernel.org>
Subject: Applied "dt-bindings: sound: Add bindings for UDA1334 codec" to the asoc tree
Date: Wed, 31 Jul 2019 12:29:38 +0100 (BST)
Message-ID: <20190731112938.3BF792742CC3@ypsilon.sirena.org.uk>
References: <20190731111930.20230-2-andradanciu1997@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190731111930.20230-2-andradanciu1997@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andra Danciu <andradanciu1997@gmail.com>
Cc: alsa-devel@alsa-project.org, anders.roxell@linaro.org, broonie@kernel.org, ckeepax@opensource.cirrus.com, Daniel Baluta <daniel.baluta@nxp.com>daniel.baluta@nxp.com, devicetree@vger.kernel.org, jbrunet@baylibre.com, kmarinushkin@birdec.tech, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, mark.rutland@arm.com, m.felsch@pengutronix.de, nh6z@nh6z.net, paul@crapouillou.net, perex@perex.cz, piotrs@opensource.cirrus.com, rf@opensource.wolfsonmicro.com, robh+dt@kernel.org, srinivas.kandagatla@linaro.org, tiwai@suse.com, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   dt-bindings: sound: Add bindings for UDA1334 codec

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From d6de65fde51644f6ed6b1c0c05fef6a2da5ff768 Mon Sep 17 00:00:00 2001
From: Andra Danciu <andradanciu1997@gmail.com>
Date: Wed, 31 Jul 2019 14:19:29 +0300
Subject: [PATCH] dt-bindings: sound: Add bindings for UDA1334 codec

The UDA1334 is an NXP audio codec, supports the I2S-bus data format
and has basic features such as de-emphasis (at 44.1 kHz sampling
rate) and mute. Product information can be found at:
https://www.nxp.com/pages/low-power-audio-dac-with-pll:UDA1334

Cc: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
Link: https://lore.kernel.org/r/20190731111930.20230-2-andradanciu1997@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/uda1334.txt       | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/uda1334.txt

diff --git a/Documentation/devicetree/bindings/sound/uda1334.txt b/Documentation/devicetree/bindings/sound/uda1334.txt
new file mode 100644
index 000000000000..f64071b25e8d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/uda1334.txt
@@ -0,0 +1,17 @@
+UDA1334 audio CODEC
+
+This device uses simple GPIO pins for controlling codec settings.
+
+Required properties:
+
+  - compatible : "nxp,uda1334"
+  - nxp,mute-gpios: a GPIO spec for the MUTE pin.
+  - nxp,deemph-gpios: a GPIO spec for the De-emphasis pin
+
+Example:
+
+uda1334: audio-codec {
+	compatible = "nxp,uda1334";
+	nxp,mute-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
+	nxp,deemph-gpios = <&gpio3 3 GPIO_ACTIVE_LOW>;
+};
-- 
2.20.1
