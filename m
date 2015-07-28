From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: [PATCH v14 3/3] ASoC: tda998x: add a codec to the HDMI transmitter
Date: Tue, 28 Jul 2015 10:41:01 +0200
Message-ID: <f713800198e3e1dce74108d4a211d76858b1ff4b.1438076750.git.moinejf@free.fr>
References: <cover.1438076750.git.moinejf@free.fr>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1438076750.git.moinejf-GANU6spQydw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The tda998x CODEC maintains the audio constraints according to
the HDMI device parameters (EDID) and sets dynamically the input ports
in the TDA998x I2C driver on start/stop audio streaming.

Signed-off-by: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
---
 drivers/gpu/drm/i2c/tda998x_drv.c |  71 ++++++++++++++++++-
 include/sound/tda998x.h           |  10 +++
 sound/soc/codecs/Kconfig          |   6 ++
 sound/soc/codecs/Makefile         |   2 +
 sound/soc/codecs/tda998x.c        | 141 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 227 insertions(+), 3 deletions(-)
 create mode 100644 sound/soc/codecs/tda998x.c

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 3504ef9..a271a53 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -32,6 +32,7 @@
 #define DBG(fmt, ...) DRM_DEBUG(fmt"\n", ##__VA_ARGS__)
 
 struct tda998x_priv {
+	struct tda998x_audio audio;		/* audio and video common field */
 	struct i2c_client *cec;
 	struct i2c_client *hdmi;
 	struct mutex mutex;
@@ -48,8 +49,6 @@ struct tda998x_priv {
 	wait_queue_head_t wq_edid;
 	volatile int wq_edid_wait;
 	struct drm_encoder *encoder;
-
-	struct tda998x_audio audio;
 };
 
 #define to_tda998x_priv(x)  ((struct tda998x_priv *)to_encoder_slave(x)->slave_priv)
@@ -552,6 +551,9 @@ tda998x_reset(struct tda998x_priv *priv)
 
 	/* Write the default value MUX register */
 	reg_write(priv, REG_MUX_VP_VIP_OUT, 0x24);
+
+	/* disable audio input */
+	reg_write(priv, REG_ENA_AP, 0);
 }
 
 /* handle HDMI connect/disconnect */
@@ -758,6 +760,42 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 	tda998x_write_aif(priv, p);
 }
 
+#if IS_ENABLED(CONFIG_SND_SOC_TDA998X)
+/* tda998x audio codec interface */
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
+#endif /* SND_SOC */
+
 /* DRM encoder functions */
 
 static void tda998x_encoder_set_config(struct tda998x_priv *priv,
@@ -777,8 +815,10 @@ static void tda998x_encoder_set_config(struct tda998x_priv *priv,
 			    (p->mirr_f ? VIP_CNTRL_2_MIRR_F : 0);
 
 	priv->params = *p;
+#if IS_ENABLED(CONFIG_SND_SOC_TDA998X)
 	priv->audio.port_types[0] = p->audio_format;
 	priv->audio.ports[0] = p->audio_cfg;
+#endif
 }
 
 static void tda998x_encoder_dpms(struct tda998x_priv *priv, int mode)
@@ -1029,9 +1069,11 @@ tda998x_encoder_mode_set(struct tda998x_priv *priv,
 
 		tda998x_write_avi(priv, adjusted_mode);
 
+#if !IS_ENABLED(CONFIG_SND_SOC_TDA998X)
 		if (priv->params.audio_cfg)
 			tda998x_configure_audio(priv, adjusted_mode,
 						&priv->params);
+#endif
 	}
 }
 
@@ -1107,6 +1149,9 @@ tda998x_encoder_get_modes(struct tda998x_priv *priv,
 	struct edid *edid;
 	int n;
 
+#if IS_ENABLED(CONFIG_SND_SOC_TDA998X)
+	priv->audio.eld = NULL;
+#endif
 	if (priv->rev == TDA19988)
 		reg_clear(priv, REG_TX4, TX4_PD_RAM);
 
@@ -1123,6 +1168,14 @@ tda998x_encoder_get_modes(struct tda998x_priv *priv,
 	drm_mode_connector_update_edid_property(connector, edid);
 	n = drm_add_edid_modes(connector, edid);
 	priv->is_hdmi_sink = drm_detect_hdmi_monitor(edid);
+
+#if IS_ENABLED(CONFIG_SND_SOC_TDA998X)
+	if (priv->is_hdmi_sink) {
+		drm_edid_to_eld(connector, edid);
+		priv->audio.eld = connector->eld;
+	}
+#endif
+
 	kfree(edid);
 
 	return n;
@@ -1158,6 +1211,10 @@ static void tda998x_destroy(struct tda998x_priv *priv)
 		cancel_delayed_work_sync(&priv->dwork);
 	}
 
+#if IS_ENABLED(CONFIG_SND_SOC_TDA998X)
+	if (priv->audio.ports[0])
+		tda9998x_codec_unregister(&priv->hdmi->dev);
+#endif
 	i2c_unregister_device(priv->cec);
 }
 
@@ -1294,6 +1351,9 @@ static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
 	priv->vip_cntrl_1 = VIP_CNTRL_1_SWAP_C(0) | VIP_CNTRL_1_SWAP_D(1);
 	priv->vip_cntrl_2 = VIP_CNTRL_2_SWAP_E(4) | VIP_CNTRL_2_SWAP_F(5);
 
+	priv->params.audio_frame[1] = 1;		/* channels - 1 */
+	priv->params.audio_sample_rate = 48000;		/* 48kHz */
+
 	priv->current_page = 0xff;
 	priv->hdmi = client;
 	/* CEC I2C address bound to TDA998x I2C addr by configuration pins */
@@ -1399,14 +1459,19 @@ static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
 			if (ret < 0)
 				goto fail;
 
-			/* initialize the default audio configuration */
+			/* initialize the audio configuration */
 			if (priv->audio.ports[0]) {
+#if IS_ENABLED(CONFIG_SND_SOC_TDA998X)
+				priv->audio.set_audio_input = tda998x_set_audio_input;
+				tda9998x_codec_register(&client->dev);
+#else
 				priv->params.audio_cfg = priv->audio.ports[0];
 				priv->params.audio_format =
 						priv->audio.port_types[0];
 				priv->params.audio_clk_cfg =
 					priv->params.audio_format ==
 							AFMT_SPDIF ? 0 : 1;
+#endif
 			}
 		} else {
 
diff --git a/include/sound/tda998x.h b/include/sound/tda998x.h
index bef1da7..91a069c 100644
--- a/include/sound/tda998x.h
+++ b/include/sound/tda998x.h
@@ -1,8 +1,18 @@
 #ifndef SND_TDA998X_H
 #define SND_TDA998X_H
 
+/* port index for audio stream stop */
+#define PORT_NONE (-1)
+
 struct tda998x_audio {
 	u8 ports[2];			/* AP value */
 	u8 port_types[2];		/* AFMT_xxx */
+	u8 *eld;
+	int (*set_audio_input)(struct device *dev,
+			int port_index,
+			unsigned sample_rate);
 };
+
+int tda9998x_codec_register(struct device *dev);
+void tda9998x_codec_unregister(struct device *dev);
 #endif
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index efaafce..08b73bd 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -105,6 +105,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_TAS2552 if I2C
 	select SND_SOC_TAS5086 if I2C
 	select SND_SOC_TAS571X if I2C
+	select SND_SOC_TDA998X if DRM_I2C_NXP_TDA998X
 	select SND_SOC_TFA9879 if I2C
 	select SND_SOC_TLV320AIC23_I2C if I2C
 	select SND_SOC_TLV320AIC23_SPI if SPI_MASTER
@@ -622,6 +623,11 @@ config SND_SOC_TAS571X
 	tristate "Texas Instruments TAS5711/TAS5717/TAS5719 power amplifiers"
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
index cf160d9..819d689 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -108,6 +108,7 @@ snd-soc-sta529-objs := sta529.o
 snd-soc-stac9766-objs := stac9766.o
 snd-soc-tas5086-objs := tas5086.o
 snd-soc-tas571x-objs := tas571x.o
+snd-soc-tda998x-objs := tda998x.o
 snd-soc-tfa9879-objs := tfa9879.o
 snd-soc-tlv320aic23-objs := tlv320aic23.o
 snd-soc-tlv320aic23-i2c-objs := tlv320aic23-i2c.o
@@ -292,6 +293,7 @@ obj-$(CONFIG_SND_SOC_STAC9766)	+= snd-soc-stac9766.o
 obj-$(CONFIG_SND_SOC_TAS2552)	+= snd-soc-tas2552.o
 obj-$(CONFIG_SND_SOC_TAS5086)	+= snd-soc-tas5086.o
 obj-$(CONFIG_SND_SOC_TAS571X)	+= snd-soc-tas571x.o
+obj-$(CONFIG_SND_SOC_TDA998X)	+= snd-soc-tda998x.o
 obj-$(CONFIG_SND_SOC_TFA9879)	+= snd-soc-tfa9879.o
 obj-$(CONFIG_SND_SOC_TLV320AIC23)	+= snd-soc-tlv320aic23.o
 obj-$(CONFIG_SND_SOC_TLV320AIC23_I2C)	+= snd-soc-tlv320aic23-i2c.o
diff --git a/sound/soc/codecs/tda998x.c b/sound/soc/codecs/tda998x.c
new file mode 100644
index 0000000..0153b80
--- /dev/null
+++ b/sound/soc/codecs/tda998x.c
@@ -0,0 +1,141 @@
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
+static int tda998x_codec_startup(struct snd_pcm_substream *substream,
+			struct snd_soc_dai *dai)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct tda998x_audio *tda998x_audio = dev_get_drvdata(dai->dev);
+	u8 *eld;
+
+	eld = tda998x_audio->eld;
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
+	struct tda998x_audio *tda998x_audio = dev_get_drvdata(dai->dev);
+
+	return tda998x_audio->set_audio_input(dai->dev, dai->id,
+					params_rate(params));
+}
+
+static void tda998x_codec_shutdown(struct snd_pcm_substream *substream,
+				   struct snd_soc_dai *dai)
+{
+	struct tda998x_audio *tda998x_audio = dev_get_drvdata(dai->dev);
+
+	tda998x_audio->set_audio_input(dai->dev, PORT_NONE, 0);
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
+static const struct snd_soc_dai_driver tda998x_dai_i2s = {
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
+static const struct snd_soc_dai_driver tda998x_dai_spdif = {
+	.name = "spdif-hifi",
+	.playback = {
+		.stream_name	= "HDMI SPDIF Playback",
+		.channels_min	= 1,
+		.channels_max	= 2,
+		.rates		= SNDRV_PCM_RATE_CONTINUOUS,
+		.rate_min	= 22050,
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
+int tda9998x_codec_register(struct device *dev)
+{
+	struct snd_soc_dai_driver *dais, *p_dai;
+	struct tda998x_audio *tda998x_audio = dev_get_drvdata(dev);
+	int i, ndais;
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
+		if (tda998x_audio->port_types[i] == AFMT_I2S)
+			memcpy(p_dai, &tda998x_dai_i2s, sizeof(*p_dai));
+		else
+			memcpy(p_dai, &tda998x_dai_spdif, sizeof(*p_dai));
+		p_dai->id = i;
+	}
+
+	return snd_soc_register_codec(dev,
+				&tda998x_codec_drv,
+				dais, ndais);
+}
+EXPORT_SYMBOL_GPL(tda9998x_codec_register);
+
+void tda9998x_codec_unregister(struct device *dev)
+{
+	snd_soc_unregister_codec(dev);
+}
+EXPORT_SYMBOL_GPL(tda9998x_codec_unregister);
+
+MODULE_AUTHOR("Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>");
+MODULE_DESCRIPTION("TDA998X CODEC");
+MODULE_LICENSE("GPL");
-- 
2.4.6

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
