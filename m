From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: dmic: Make number of channels configurable" to the asoc tree
Date: Tue, 09 Jan 2018 17:43:48 +0000
Message-ID: <E1eYxwC-0006dW-Rc@debutante>
References: <20180105203957.184883-1-mka@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180105203957.184883-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Arnaud Pouliquen <arnaud.pouliquen@st.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, huang lin <hl@rock-chips.com>, Brian Norris <briannorris@chromium.org>Arnaud Pouliquen <arnaud.pouliquen@st.com>, linux-kernel@vger.kernel.org, Dylan Reid <dgreid@chromium.org>, Bhumika Goyal <bhumirks@gmail.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: dmic: Make number of channels configurable

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

>From 7fb59e940f6225beed0b24cd09e9fad9aebb7565 Mon Sep 17 00:00:00 2001
From: Matthias Kaehlcke <mka@chromium.org>
Date: Fri, 5 Jan 2018 12:39:57 -0800
Subject: [PATCH] ASoC: codecs: dmic: Make number of channels configurable

The DMIC DAI driver specifies a number of 1 to 8 channels for each DAI.
The actual number of mics can currently not be configured in the device
tree or audio glue, but is derived from the min/max channels of the CPU
and codec DAI. A typical CPU DAI has two or more channels, in consequence
a single mic is treated as a stereo/multi channel device, even though
only one channel carries audio data.

This change adds the option to specify the number of used DMIC channels
in the device tree. When specified this value overwrites the default
channels_max value of 8 in the snd_soc_dai_driver struct of the codec.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/dmic.txt |  2 ++
 sound/soc/codecs/dmic.c                          | 24 +++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/dmic.txt b/Documentation/devicetree/bindings/sound/dmic.txt
index 54c8ef6498a8..f7bf65611453 100644
--- a/Documentation/devicetree/bindings/sound/dmic.txt
+++ b/Documentation/devicetree/bindings/sound/dmic.txt
@@ -7,10 +7,12 @@ Required properties:
 
 Optional properties:
 	- dmicen-gpios: GPIO specifier for dmic to control start and stop
+	- num-channels: Number of microphones on this DAI
 
 Example node:
 
 	dmic_codec: dmic@0 {
 		compatible = "dmic-codec";
 		dmicen-gpios = <&gpio4 3 GPIO_ACTIVE_HIGH>;
+		num-channels = <1>;
 	};
diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index b88a1ee66f80..c88f974ebe3e 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -107,8 +107,30 @@ static const struct snd_soc_codec_driver soc_dmic = {
 
 static int dmic_dev_probe(struct platform_device *pdev)
 {
+	int err;
+	u32 chans;
+	struct snd_soc_dai_driver *dai_drv = &dmic_dai;
+
+	if (pdev->dev.of_node) {
+		err = of_property_read_u32(pdev->dev.of_node, "num-channels", &chans);
+		if (err && (err != -ENOENT))
+			return err;
+
+		if (!err) {
+			if (chans < 1 || chans > 8)
+				return -EINVAL;
+
+			dai_drv = devm_kzalloc(&pdev->dev, sizeof(*dai_drv), GFP_KERNEL);
+			if (!dai_drv)
+				return -ENOMEM;
+
+			memcpy(dai_drv, &dmic_dai, sizeof(*dai_drv));
+			dai_drv->capture.channels_max = chans;
+		}
+	}
+
 	return snd_soc_register_codec(&pdev->dev,
-			&soc_dmic, &dmic_dai, 1);
+			&soc_dmic, dai_drv, 1);
 }
 
 static int dmic_dev_remove(struct platform_device *pdev)
-- 
2.15.1
