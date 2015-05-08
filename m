From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v12 6/6] ASoC: tda998x: add a codec to the HDMI transmitter
Date: Fri, 8 May 2015 10:41:12 +0200
Message-ID: <b8db8eb79caf334b88e2c8aca1d3422f042e5cb0.1431083916.git.moinejf@free.fr>
References: <cover.1431083916.git.moinejf@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1431083916.git.moinejf@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Dave Airlie <airlied@gmail.com>, Andrew Jackson <Andrew.Jackson@arm.com>, Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The tda998x CODEC maintains the audio constraints according to
the HDMI device parameters (EDID) and sets dynamically the input ports
in the TDA998x I2C driver on start/stop audio streaming.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c |  80 +++++++++++++++++++++++
 include/sound/tda998x.h           |  15 +++++
 sound/soc/codecs/Kconfig          |   6 ++
 sound/soc/codecs/Makefile         |   2 +
 sound/soc/codecs/tda998x.c        | 132 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 235 insertions(+)
 create mode 100644 sound/soc/codecs/tda998x.c

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 7a9d9a7..64eddcf 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -755,6 +755,66 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 	tda998x_write_aif(priv, p);
 }
 
+#if IS_ENABLED(CONFIG_SND_SOC_TDA998X)
+/* tda998x audio codec interface */
+
+/* return the ELD to the CODEC */
+static u8 *tda998x_get_eld(struct device *dev)
+{
+	struct tda998x_priv *priv = dev_get_drvdata(dev);
+	struct drm_encoder *encoder = priv->encoder;
+	struct drm_device *drm = encoder->dev;
+	struct drm_connector *connector;
+
+	if (!priv->is_hdmi_sink
+	 || !encoder->crtc)
+		return NULL;
+
+	list_for_each_entry(connector, &drm->mode_config.connector_list, head) {
+		if (connector->encoder == encoder)
+			return connector->eld;
+	}
+	return NULL;
+}
+
+/* switch the audio port and initialize the audio parameters for streaming */
+static int tda998x_set_audio_input(struct device *dev,
+				int port_index,
+				unsigned sample_rate)
+{
+	struct tda998x_priv *priv = dev_get_drvdata(dev);
+	struct tda998x_encoder_params *p = &priv->params;
+
+	if (!priv->encoder->crtc)
+		return -ENODEV;
+
+	/* if no port, just disable the audio port */
+	if (port_index == PORT_NONE) {
+		reg_write(priv, REG_ENA_AP, 0);
+		return 0;
+	}
+
+	/* if same audio parameters, just enable the audio port */
+	if (p->audio_cfg == priv->audio.ports[port_index] &&
+	    p->audio_sample_rate == sample_rate) {
+		reg_write(priv, REG_ENA_AP, p->audio_cfg);
+		return 0;
+	}
+
+	p->audio_format = priv->audio.port_types[port_index];
+	p->audio_clk_cfg = p->audio_format == AFMT_SPDIF ? 0 : 1;
+	p->audio_cfg = priv->audio.ports[port_index];
+	p->audio_sample_rate = sample_rate;
+	tda998x_configure_audio(priv, &priv->encoder->crtc->hwmode, p);
+	return 0;
+}
+
+static struct tda998x_ops_s tda998x_codec_ops = {
+	.get_eld = tda998x_get_eld,
+	.set_audio_input = tda998x_set_audio_input,
+};
+#endif /* SND_SOC */
+
 /* DRM encoder functions */
 
 static void tda998x_encoder_set_config(struct tda998x_priv *priv,
@@ -1120,6 +1180,12 @@ tda998x_encoder_get_modes(struct tda998x_priv *priv,
 	drm_mode_connector_update_edid_property(connector, edid);
 	n = drm_add_edid_modes(connector, edid);
 	priv->is_hdmi_sink = drm_detect_hdmi_monitor(edid);
+
+#if IS_ENABLED(CONFIG_SND_SOC_TDA998X)
+	if (priv->is_hdmi_sink)
+		drm_edid_to_eld(connector, edid);
+#endif
+
 	kfree(edid);
 
 	return n;
@@ -1155,6 +1221,10 @@ static void tda998x_destroy(struct tda998x_priv *priv)
 		cancel_delayed_work_sync(&priv->dwork);
 	}
 
+#if IS_ENABLED(CONFIG_SND_SOC_TDA998X)
+	if (priv->audio.ports[0])
+		tda9998x_codec_unregister(&priv->hdmi->dev);
+#endif
 	i2c_unregister_device(priv->cec);
 }
 
@@ -1291,6 +1361,9 @@ static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
 	priv->vip_cntrl_1 = VIP_CNTRL_1_SWAP_C(0) | VIP_CNTRL_1_SWAP_D(1);
 	priv->vip_cntrl_2 = VIP_CNTRL_2_SWAP_E(4) | VIP_CNTRL_2_SWAP_F(5);
 
+	priv->params.audio_frame[1] = 1;		/* channels - 1 */
+	priv->params.audio_sample_rate = 48000;		/* 48kHz */
+
 	priv->current_page = 0xff;
 	priv->hdmi = client;
 	/* CEC I2C address bound to TDA998x I2C addr by configuration pins */
@@ -1404,6 +1477,13 @@ static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
 				priv->params.audio_clk_cfg =
 					priv->params.audio_format ==
 							AFMT_SPDIF ? 0 : 1;
+
+#if IS_ENABLED(CONFIG_SND_SOC_TDA998X)
+				/* and create the audio CODEC */
+				tda9998x_codec_register(&client->dev,
+							&priv->audio,
+							&tda998x_codec_ops);
+#endif
 			}
 		} else {
 
diff --git a/include/sound/tda998x.h b/include/sound/tda998x.h
index 487a809..8e89db4 100644
--- a/include/sound/tda998x.h
+++ b/include/sound/tda998x.h
@@ -1,8 +1,23 @@
 #ifndef SND_TDA998X_H
 #define SND_TDA998X_H
 
+/* port index for audio stream stop */
+#define PORT_NONE (-1)
+
 struct tda998x_audio_s {
 	u8 ports[2];			/* AP value */
 	u8 port_types[2];		/* AFMT_xxx */
 };
+
+struct tda998x_ops_s {
+	u8 *(*get_eld)(struct device *dev);
+	int (*set_audio_input)(struct device *dev,
+			int port_index,
+			unsigned sample_rate);
+};
+
+int tda9998x_codec_register(struct device *dev,
+			struct tda998x_audio_s *tda998x_audio_i,
+			struct tda998x_ops_s *tda998x_ops);
+void tda9998x_codec_unregister(struct device *dev);
 #endif
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 061c465..e7a33cc 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -104,6 +104,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_STAC9766 if SND_SOC_AC97_BUS
 	select SND_SOC_TAS2552 if I2C
 	select SND_SOC_TAS5086 if I2C
+	select SND_SOC_TDA998X if DRM_I2C_NXP_TDA998X
 	select SND_SOC_TFA9879 if I2C
 	select SND_SOC_TLV320AIC23_I2C if I2C
 	select SND_SOC_TLV320AIC23_SPI if SPI_MASTER
@@ -611,6 +612,11 @@ config SND_SOC_TAS5086
 	tristate "Texas Instruments TAS5086 speaker amplifier"
 	depends on I2C
 
+config SND_SOC_TDA998X
+	def_tristate y
+	select SND_PCM_ELD
+	depends on DRM_I2C_NXP_TDA998X
+
 config SND_SOC_TFA9879
 	tristate "NXP Semiconductors TFA9879 amplifier"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index abe2d7e..8183474 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -106,6 +106,7 @@ snd-soc-sta350-objs := sta350.o
 snd-soc-sta529-objs := sta529.o
 snd-soc-stac9766-objs := stac9766.o
 snd-soc-tas5086-objs := tas5086.o
+snd-soc-tda998x-objs := tda998x.o
 snd-soc-tfa9879-objs := tfa9879.o
 snd-soc-tlv320aic23-objs := tlv320aic23.o
 snd-soc-tlv320aic23-i2c-objs := tlv320aic23-i2c.o
@@ -288,6 +289,7 @@ obj-$(CONFIG_SND_SOC_STA529)   += snd-soc-sta529.o
 obj-$(CONFIG_SND_SOC_STAC9766)	+= snd-soc-stac9766.o
 obj-$(CONFIG_SND_SOC_TAS2552)	+= snd-soc-tas2552.o
 obj-$(CONFIG_SND_SOC_TAS5086)	+= snd-soc-tas5086.o
+obj-$(CONFIG_SND_SOC_TDA998X)	+= snd-soc-tda998x.o
 obj-$(CONFIG_SND_SOC_TFA9879)	+= snd-soc-tfa9879.o
 obj-$(CONFIG_SND_SOC_TLV320AIC23)	+= snd-soc-tlv320aic23.o
 obj-$(CONFIG_SND_SOC_TLV320AIC23_I2C)	+= snd-soc-tlv320aic23-i2c.o
diff --git a/sound/soc/codecs/tda998x.c b/sound/soc/codecs/tda998x.c
new file mode 100644
index 0000000..f588a75
--- /dev/null
+++ b/sound/soc/codecs/tda998x.c
@@ -0,0 +1,132 @@
+/*
+ * ALSA SoC TDA998x CODEC
+ *
+ * Copyright (C) 2015 Jean-Francois Moine
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <sound/soc.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <sound/pcm_drm_eld.h>
+#include <drm/i2c/tda998x.h>
+#include <sound/tda998x.h>
+
+/* functions in tda998x_drv */
+static struct tda998x_ops_s *tda998x_ops;
+
+static int tda998x_codec_startup(struct snd_pcm_substream *substream,
+			struct snd_soc_dai *dai)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	u8 *eld;
+
+	eld = tda998x_ops->get_eld(dai->dev);
+	if (!eld)
+		return -ENODEV;
+	return snd_pcm_hw_constraint_eld(runtime, eld);
+}
+
+/* ask the HDMI transmitter to activate the audio input port */
+static int tda998x_codec_hw_params(struct snd_pcm_substream *substream,
+				   struct snd_pcm_hw_params *params,
+				   struct snd_soc_dai *dai)
+{
+	return tda998x_ops->set_audio_input(dai->dev, dai->id,
+					params_rate(params));
+}
+
+static void tda998x_codec_shutdown(struct snd_pcm_substream *substream,
+				   struct snd_soc_dai *dai)
+{
+	tda998x_ops->set_audio_input(dai->dev, PORT_NONE, 0);
+}
+
+static const struct snd_soc_dai_ops tda998x_codec_ops = {
+	.startup = tda998x_codec_startup,
+	.hw_params = tda998x_codec_hw_params,
+	.shutdown = tda998x_codec_shutdown,
+};
+
+#define TDA998X_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
+			SNDRV_PCM_FMTBIT_S20_3LE | \
+			SNDRV_PCM_FMTBIT_S24_LE | \
+			SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver tda998x_dai_i2s = {
+	.name = "i2s-hifi",
+	.playback = {
+		.stream_name	= "HDMI I2S Playback",
+		.channels_min	= 1,
+		.channels_max	= 8,
+		.rates		= SNDRV_PCM_RATE_CONTINUOUS,
+		.rate_min	= 5512,
+		.rate_max	= 192000,
+		.formats	= TDA998X_FORMATS,
+	},
+	.ops = &tda998x_codec_ops,
+};
+
+static const struct snd_soc_dapm_widget tda998x_widgets[] = {
+	SND_SOC_DAPM_OUTPUT("hdmi-out"),
+};
+static const struct snd_soc_dapm_route tda998x_routes[] = {
+	{ "hdmi-out", NULL, "HDMI I2S Playback" },
+	{ "hdmi-out", NULL, "HDMI SPDIF Playback" },
+};
+
+static struct snd_soc_codec_driver tda998x_codec_drv = {
+	.dapm_widgets = tda998x_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(tda998x_widgets),
+	.dapm_routes = tda998x_routes,
+	.num_dapm_routes = ARRAY_SIZE(tda998x_routes),
+	.ignore_pmdown_time = true,
+};
+
+int tda9998x_codec_register(struct device *dev,
+			struct tda998x_audio_s *tda998x_audio,
+			struct tda998x_ops_s *tda998x_ops_i)
+{
+	struct snd_soc_dai_driver *dais, *p_dai;
+	int i, ndais;
+
+	tda998x_ops = tda998x_ops_i;
+
+	/* build the DAIs */
+	for (ndais = 0; ndais < ARRAY_SIZE(tda998x_audio->ports); ndais++) {
+		if (!tda998x_audio->ports[ndais])
+			break;
+	}
+	dais = devm_kzalloc(dev, sizeof(*dais) * ndais, GFP_KERNEL);
+	if (!dais)
+		return -ENOMEM;
+	for (i = 0, p_dai = dais; i < ndais ; i++, p_dai++) {
+		memcpy(p_dai, &tda998x_dai_i2s, sizeof(*p_dai));
+		p_dai->id = i;
+		if (tda998x_audio->port_types[i] == AFMT_SPDIF) {
+			p_dai->name = "spdif-hifi";
+			p_dai->playback.stream_name = "HDMI SPDIF Playback";
+			p_dai->playback.channels_max = 2;
+			p_dai->playback.rate_min = 22050;
+		}
+	}
+
+	return snd_soc_register_codec(dev,
+				&tda998x_codec_drv,
+				dais, ndais);
+}
+EXPORT_SYMBOL(tda9998x_codec_register);
+
+void tda9998x_codec_unregister(struct device *dev)
+{
+	snd_soc_unregister_codec(dev);
+}
+EXPORT_SYMBOL(tda9998x_codec_unregister);
+
+MODULE_AUTHOR("Jean-Francois Moine <moinejf@free.fr>");
+MODULE_DESCRIPTION("TDA998X CODEC");
+MODULE_LICENSE("GPL");
-- 
2.1.4
