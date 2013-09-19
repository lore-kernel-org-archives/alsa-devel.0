From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: [PATCH] ASoC: generic: Add generic DT based simple codec
Date: Thu, 19 Sep 2013 10:54:37 +0200
Message-ID: <20130919105437.75e0f0a3@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This patch adds a simple sound codec which is described by the DT.
This codec may be used when no specific codec action is needed.

Signed-off-by: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
---
 .../devicetree/bindings/sound/simple-codec.txt | 103 +++++++++++++
 sound/soc/generic/Kconfig                      |   6 +
 sound/soc/generic/Makefile                     |   2 +
 sound/soc/generic/simple-codec.c               | 197 +++++++++++++++++=
++++++++
 4 files changed, 3088 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-codec.txt b=
/Documentation/devicetree/bindings/sound/simple-codec.txt
new file mode 100644
index 0000000..75be747
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/simple-codec.txt
@@ -0,0 +1,103 @@
+Device-Tree bindings for the simple codec
+
+Required properties:
+- compatible: should be "linux,simple-codec".
+- dai-name: name of the codec
+
+Optional properties:
+- capture: information about capture
+- playback: information about playback
+At least one of the 'capture' or 'playback' nodes must be present.
+
+Child 'capture' and 'playback' required properties:
+- stream-name: name of the stream
+- formats: list of the supported formats (see below)
+- rates: list of the supported rates (see below)
+- #channels: minimum and maximum numbers of channels
+
+Formats:
+	"s8"
+	"u8"
+	"s16_le"
+	"s16_be"
+	"u16_le"
+	"u16_be"
+	"s24_le"
+	"s24_be"
+	"u24_le"
+	"u24_be"
+	"s32_le"
+	"s32_be"
+	"u32_le"
+	"u32_be"
+	"float_le"
+	"float_be"
+	"float64_le"
+	"float64_be"
+	"iec958_subframe_le"
+	"iec958_subframe_be"
+	"mu_law"
+	"a_law"
+	"ima_adpcm"
+	"mpeg"
+	"gsm"
+	"special"
+	"s24_3l"
+	"s24_3be"
+	"u24_3le"
+	"u24_3be"
+	"s20_3le"
+	"s20_3be"
+	"u20_3le"
+	"u20_3be"
+	"s18_3le"
+	"s18_3b"
+	"u18_3le"
+	"u18_3be"
+	"g723_24"
+	"g723_24_1b"
+	"g723_40"
+	"g723_40_1b"
+	"dsd_u8"
+	"dsd_u16_le"
+
+Rates:
+	5512
+	8000
+	11025
+	16000
+	22050
+	32000
+	44100
+	48000
+	64000
+	88200
+	96000
+	176400
+	192000
+
+Examples:
+
+	spdifo: spdif-transmitter {
+		compatible =3D "linux,simple-codec";
+		dai-name =3D "dit-hifi";
+		playback {
+			stream-name =3D "S/PDIF Playback";
+			formats =3D "s16_le";
+			rates =3D <8000 11025 16000 22050 32000 44100
+				48000 64000 88200 96000>;
+			#channels =3D <1 384>;
+		};
+	};
+
+	hdmio: hdmi-transmitter {
+		compatible =3D "linux,simple-codec";
+		dai-name =3D "hdmi-hifi";
+		playback {
+			stream-name =3D "HDMI Playback";
+			formats =3D "s16_le", "s24_le";
+			rates =3D <32000 44100 48000 88200 96000
+				176400 192000>;
+			#channels =3D <2 8>;
+		};
+	};
diff --git a/sound/soc/generic/Kconfig b/sound/soc/generic/Kconfig
index 610f612..d9221539 100644
--- a/sound/soc/generic/Kconfig
+++ b/sound/soc/generic/Kconfig
@@ -2,3 +2,9 @@ config SND_SIMPLE_CARD
 	tristate "ASoC Simple sound card support"
 	help
 	  This option enables generic simple sound card support
+
+config SND_SIMPLE_CODEC
+	tristate "ASoC Simple sound codec support"
+	depends on OF
+	help
+	  This option enables generic simple sound codec support
diff --git a/sound/soc/generic/Makefile b/sound/soc/generic/Makefile
index 9c3b246..f94620e 100644
--- a/sound/soc/generic/Makefile
+++ b/sound/soc/generic/Makefile
@@ -1,3 +1,5 @@
 snd-soc-simple-card-objs	:=3D simple-card.o
+snd-soc-simple-codec-objs	:=3D simple-codec.o
=20
 obj-$(CONFIG_SND_SIMPLE_CARD)	+=3D snd-soc-simple-card.o
+obj-$(CONFIG_SND_SIMPLE_CODEC)	+=3D snd-soc-simple-codec.o
diff --git a/sound/soc/generic/simple-codec.c b/sound/soc/generic/simpl=
e-codec.c
new file mode 100644
index 0000000..217cd0e
--- /dev/null
+++ b/sound/soc/generic/simple-codec.c
@@ -0,0 +1,197 @@
+/*
+ * ALSA SoC simple codec driver
+ *
+ * This driver is used by controllers which do not need any codec
+ * (s/pdif, hdmi..).
+ * Its parameters are built from a DT description.
+ *
+ * Copyright: (C) 2013 Jean-Fran=C3=A7ois Moine <moinejf-GANU6spQydw@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <sound/soc.h>
+#include <linux/of.h>
+
+#define DRV_NAME "simple-codec"
+
+static struct snd_soc_codec_driver soc_codec_simple_codec;
+
+static char *format_tb[] =3D {
+	"s8", "u8", "s16_le", "s16_be",
+	"u16_le", "u16_be", "s24_le", "s24_be",
+	"u24_le", "u24_be", "s32_le", "s32_be",
+	"u32_le", "u32_be", "float_le", "float_be",
+
+	"float64_le", "float64_be", "iec958_subframe_le", "iec958_subframe_be=
",
+	"mu_law", "a_law", "ima_adpcm", "mpeg",
+	"gsm", "", "", "",
+	"", "", "", "special",
+
+	"s24_3l", "s24_3be", "u24_3le", "u24_3be",
+	"s20_3le", "s20_3be", "u20_3le", "u20_3be",
+	"s18_3le", "s18_3b", "u18_3le", "u18_3be",
+	"g723_24", "g723_24_1b", "g723_40", "g723_40_1b",
+
+	"dsd_u8", "dsd_u16_le",
+};
+
+#if SNDRV_PCM_RATE_5512 !=3D 1 << 0 || SNDRV_PCM_RATE_192000 !=3D 1 <<=
 12
+#error "Change this table"
+#endif
+static u32 rate_tb[] =3D { 5512, 8000, 11025, 16000, 22050, 32000, 441=
00,
+			48000, 64000, 88200, 96000, 176400, 192000 };
+
+static int get_format(u64 *p_formats, char *p)
+{
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(format_tb); i++) {
+		if (strcmp(format_tb[i], p) =3D=3D 0) {
+			*p_formats |=3D 1 << i;
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
+static int get_rate(u32 *p_rates, u32 val)
+{
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(rate_tb); i++) {
+		if (rate_tb[i] =3D=3D val) {
+			*p_rates |=3D 1 << i;
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
+static int stream_populate(struct device *dev,
+			struct snd_soc_pcm_stream *stream,
+			struct device_node *np)
+{
+	u64 formats;
+	u32 rates, val;
+	char *p;
+	int i, ret;
+
+	ret =3D of_property_read_string(np, "stream-name", &stream->stream_na=
me);
+	if (ret) {
+		dev_err(dev, "Failed to parse stream-name string\n");
+		return ret;
+	}
+
+	i =3D 0;
+	formats =3D 0;
+	for (;;) {
+		ret =3D of_property_read_string_index(np, "formats", i,
+					(const char **) &p);
+		if (ret)
+			break;
+		ret =3D get_format(&formats, p);
+		if (ret) {
+			dev_err(dev, "Bad codec format\n");
+			return ret;
+		}
+		i++;
+	}
+	stream->formats =3D formats;
+
+	i =3D 0;
+	rates =3D 0;
+	for (;;) {
+		ret =3D of_property_read_u32_index(np, "rates", i, &val);
+		if (ret)
+			break;
+		ret =3D get_rate(&rates, val);
+		if (ret) {
+			dev_err(dev, "Bad rate\n");
+			return ret;
+		}
+		i++;
+	}
+	stream->rates =3D rates;
+
+	ret =3D of_property_read_u32_index(np, "#channels", 0, &val);
+	if (ret) {
+		dev_err(dev, "Bad min channel\n");
+		return ret;
+	}
+	stream->channels_min =3D val;
+	ret =3D of_property_read_u32_index(np, "#channels", 1, &val);
+	if (ret) {
+		dev_err(dev, "Bad max channel\n");
+		return ret;
+	}
+	stream->channels_max =3D val;
+
+	return 0;
+}
+
+static int simple_codec_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	struct device_node *np =3D dev->of_node;
+	struct device_node *np2;
+	struct snd_soc_dai_driver *dai;
+	int ret;
+
+	dai =3D devm_kzalloc(dev, sizeof *dai, GFP_KERNEL);
+	if (!dai)
+		return -ENOMEM;
+
+	ret =3D of_property_read_string(np, "dai-name", &dai->name);
+	if (ret) {
+		dev_err(dev, "Failed to parse dai-name\n");
+		return ret;
+	}
+
+	np2 =3D of_find_node_by_name(np, "capture");
+	if (np2) {
+		ret =3D stream_populate(dev, &dai->capture, np2);
+		if (ret)
+			return ret;
+	}
+	np2 =3D of_find_node_by_name(np, "playback");
+	if (np2) {
+		ret =3D stream_populate(dev, &dai->playback, np2);
+		if (ret)
+			return ret;
+	}
+
+	return snd_soc_register_codec(dev, &soc_codec_simple_codec,
+					dai, 1);
+}
+
+static int simple_codec_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev);
+	return 0;
+}
+
+static const struct of_device_id simple_codec_of_match[] =3D {
+	{ .compatible =3D "linux,simple-codec", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, simple_codec_of_match);
+
+static struct platform_driver simple_codec_driver =3D {
+	.probe		=3D simple_codec_probe,
+	.remove		=3D simple_codec_remove,
+	.driver		=3D {
+		.name	=3D DRV_NAME,
+		.owner	=3D THIS_MODULE,
+		.of_match_table =3D simple_codec_of_match,
+	},
+};
+
+module_platform_driver(simple_codec_driver);
+
+MODULE_AUTHOR("Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>");
+MODULE_DESCRIPTION("simple codec driver");
+MODULE_LICENSE("GPL");


--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
