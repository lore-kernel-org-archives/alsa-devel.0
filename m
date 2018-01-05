From: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] ASoC: codecs: dmic: Make number of channels configurable
Date: Fri,  5 Jan 2018 12:39:57 -0800
Message-ID: <20180105203957.184883-1-mka@chromium.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bhumika Goyal <bhumirks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, huang lin <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Dylan Reid <dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

The DMIC DAI driver specifies a number of 1 to 8 channels for each DAI.
The actual number of mics can currently not be configured in the device
tree or audio glue, but is derived from the min/max channels of the CPU
and codec DAI. A typical CPU DAI has two or more channels, in consequence
a single mic is treated as a stereo/multi channel device, even though
only one channel carries audio data.

This change adds the option to specify the number of used DMIC channels
in the device tree. When specified this value overwrites the default
channels_max value of 8 in the snd_soc_dai_driver struct of the codec.

Signed-off-by: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
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
2.16.0.rc0.223.g4a4ac83678-goog

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
