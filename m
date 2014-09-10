From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH v5] ASoC: tda998x: Add a codec to the HDMI transmitter
Date: Wed, 10 Sep 2014 11:29:53 +0200
Message-ID: <20140910101654.DA9BE897EF@gabe.freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Mark Brown <broonie@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Andrew Jackson <Andrew.Jackson@arm.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

This patch adds a CODEC function to the NXP TDA998x HDMI transmitter.

The CODEC handles both I2S and S/PDIF inputs.
It maintains the audio format and rate constraints according
to the HDMI device parameters (EDID) and does dynamic input
switch in the TDA998x I2C driver on start/stop audio streaming.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
v5:
	- use the TDA998x private data instead of a specific area
	  for the CODEC interface
	- the CODEC is TDA998x specific (Mark Brown)
v4:
	- remove all the TDA998x specific stuff from the CODEC
	- move the EDID scan from the CODEC to the TDA998x
	- move the CODEC to sound/soc (Mark Brown)
	- update the audio_sample_rate from the EDID (Andrew Jackson)
v3: fix bad rate (Andrew Jackson)
v2: check double stream start (Mark Brown)
---
 .../devicetree/bindings/drm/i2c/tda998x.txt        |  18 ++
 drivers/gpu/drm/i2c/Kconfig                        |   1 +
 drivers/gpu/drm/i2c/tda998x_drv.c                  | 234 +++++++++++++++++++--
 include/drm/i2c/tda998x.h                          |  12 ++
 sound/soc/codecs/Kconfig                           |   3 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/tda998x.c                         | 163 ++++++++++++++
 7 files changed, 415 insertions(+), 18 deletions(-)
 create mode 100644 sound/soc/codecs/tda998x.c

diff --git a/Documentation/devicetree/bindings/drm/i2c/tda998x.txt b/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
index e9e4bce..e50e7cd 100644
--- a/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
+++ b/Documentation/devicetree/bindings/drm/i2c/tda998x.txt
@@ -17,6 +17,20 @@ Optional properties:
   - video-ports: 24 bits value which defines how the video controller
 	output is wired to the TDA998x input - default: <0x230145>
 
+  - audio-ports: must contain one or two values selecting the source
+	in the audio port.
+	The source type is given by the corresponding entry in
+	the audio-port-names property.
+
+  - audio-port-names: must contain entries matching the entries in
+	the audio-ports property.
+	Each value may be "i2s" or "spdif", giving the type of
+	the audio source.
+
+  - #sound-dai-cells: must be set to <1> for use with the simple-card.
+	The TDA998x audio CODEC always defines two DAIs.
+	The DAI 0 is the S/PDIF input and the DAI 1 is the I2S input.
+
 Example:
 
 	tda998x: hdmi-encoder {
@@ -26,4 +40,8 @@ Example:
 		interrupts = <27 2>;		/* falling edge */
 		pinctrl-0 = <&pmx_camera>;
 		pinctrl-names = "default";
+
+		audio-ports = <0x04>, <0x03>;
+		audio-port-names = "spdif", "i2s";
+		#sound-dai-cells = <1>;
 	};
diff --git a/drivers/gpu/drm/i2c/Kconfig b/drivers/gpu/drm/i2c/Kconfig
index 4d341db..01b4f95 100644
--- a/drivers/gpu/drm/i2c/Kconfig
+++ b/drivers/gpu/drm/i2c/Kconfig
@@ -22,6 +22,7 @@ config DRM_I2C_SIL164
 config DRM_I2C_NXP_TDA998X
 	tristate "NXP Semiconductors TDA998X HDMI encoder"
 	default m if DRM_TILCDC
+	select SND_SOC_TDA998x
 	help
 	  Support for NXP Semiconductors TDA998X HDMI encoders.
 
diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index d476279..7db681f 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/irq.h>
 #include <sound/asoundef.h>
+#include <linux/platform_device.h>
 
 #include <drm/drmP.h>
 #include <drm/drm_crtc_helper.h>
@@ -44,6 +45,23 @@ struct tda998x_priv {
 	wait_queue_head_t wq_edid;
 	volatile int wq_edid_wait;
 	struct drm_encoder *encoder;
+
+	/* audio variables */
+	struct platform_device *pdev_codec;
+	u8 audio_ports[2];
+
+	u8 max_channels;		/* EDID parameters */
+	u8 rate_mask;
+	u8 fmt;
+
+	int audio_sample_format;
+	struct snd_pcm_hw_constraint_list rate_constraints;
+};
+
+struct tda998x_priv2 {
+	struct tda998x_priv base;
+	struct drm_encoder encoder;
+	struct drm_connector connector;
 };
 
 #define to_tda998x_priv(x)  ((struct tda998x_priv *)to_encoder_slave(x)->slave_priv)
@@ -639,12 +657,11 @@ static void
 tda998x_configure_audio(struct tda998x_priv *priv,
 		struct drm_display_mode *mode, struct tda998x_encoder_params *p)
 {
-	uint8_t buf[6], clksel_aip, clksel_fs, cts_n, adiv;
+	uint8_t buf[6], clksel_aip, clksel_fs, cts_n, adiv, aclk;
 	uint32_t n;
 
 	/* Enable audio ports */
 	reg_write(priv, REG_ENA_AP, p->audio_cfg);
-	reg_write(priv, REG_ENA_ACLK, p->audio_clk_cfg);
 
 	/* Set audio input source */
 	switch (p->audio_format) {
@@ -653,13 +670,29 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 		clksel_aip = AIP_CLKSEL_AIP_SPDIF;
 		clksel_fs = AIP_CLKSEL_FS_FS64SPDIF;
 		cts_n = CTS_N_M(3) | CTS_N_K(3);
+		aclk = 0;				/* no clock */
 		break;
 
 	case AFMT_I2S:
 		reg_write(priv, REG_MUX_AP, MUX_AP_SELECT_I2S);
 		clksel_aip = AIP_CLKSEL_AIP_I2S;
 		clksel_fs = AIP_CLKSEL_FS_ACLK;
-		cts_n = CTS_N_M(3) | CTS_N_K(3);
+
+		/* with I2S input, the CTS_N predivider depends on
+		 * the sample width */
+		switch (priv->audio_sample_format) {
+		case SNDRV_PCM_FORMAT_S16_LE:
+			cts_n = CTS_N_M(3) | CTS_N_K(1);
+			break;
+		default:
+		case SNDRV_PCM_FORMAT_S24_LE:
+			cts_n = CTS_N_M(3) | CTS_N_K(2);
+			break;
+		case SNDRV_PCM_FORMAT_S32_LE:
+			cts_n = CTS_N_M(3) | CTS_N_K(3);
+			break;
+		}
+		aclk = 1;				/* clock enable */
 		break;
 
 	default:
@@ -671,6 +704,7 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 	reg_clear(priv, REG_AIP_CNTRL_0, AIP_CNTRL_0_LAYOUT |
 					AIP_CNTRL_0_ACR_MAN);	/* auto CTS */
 	reg_write(priv, REG_CTS_N, cts_n);
+	reg_write(priv, REG_ENA_ACLK, aclk);
 
 	/*
 	 * Audio input somehow depends on HDMI line rate which is
@@ -727,6 +761,67 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 	tda998x_write_aif(priv, p);
 }
 
+/* tda998x audio codec interface */
+
+/* return the audio parameters extracted from the last EDID */
+int tda998x_get_audio(struct device *dev,
+			int *max_channels,
+			int *rate_mask,
+			int *fmt,
+			struct snd_pcm_hw_constraint_list **rate_constraints)
+{
+	struct tda998x_priv2 *priv2 = dev_get_drvdata(dev);
+	struct tda998x_priv *priv = &priv2->base;
+
+	if (!priv->encoder->crtc)
+		return -ENODEV;
+
+	*max_channels = priv->max_channels;
+	*rate_mask = priv->rate_mask;
+	*fmt = priv->fmt;
+	*rate_constraints = &priv->rate_constraints;
+	return 0;
+}
+EXPORT_SYMBOL(tda998x_get_audio);
+
+/* switch the audio port and initialize the audio parameters for streaming */
+void tda998x_audio_switch(struct device *dev,
+				 int port_index,
+				 unsigned sample_rate,
+				 int sample_format)
+{
+	struct tda998x_priv2 *priv2 = dev_get_drvdata(dev);
+	struct tda998x_priv *priv = &priv2->base;
+	struct tda998x_encoder_params *p = &priv->params;
+
+	if (!priv->encoder->crtc)
+		return;
+
+	/*
+	 * if port_index is negative (streaming stop),
+	 * disable the audio port
+	 */
+	if (port_index < 0) {
+		reg_write(priv, REG_ENA_AP, 0);
+		return;
+	}
+
+	/* if same audio parameters, just enable the audio port */
+	if (p->audio_cfg == priv->audio_ports[port_index] &&
+	    p->audio_sample_rate == sample_rate &&
+	    priv->audio_sample_format == sample_format) {
+		reg_write(priv, REG_ENA_AP, p->audio_cfg);
+		return;
+	}
+
+	p->audio_format = port_index;
+	p->audio_cfg = priv->audio_ports[port_index];
+	p->audio_sample_rate = sample_rate;
+	priv->audio_sample_format = sample_format;
+	tda998x_configure_audio(priv, &priv->encoder->crtc->hwmode, p);
+}
+EXPORT_SYMBOL(tda998x_audio_switch);
+
 /* DRM encoder functions */
 
 static void tda998x_encoder_set_config(struct tda998x_priv *priv,
@@ -746,6 +841,8 @@ static void tda998x_encoder_set_config(struct tda998x_priv *priv,
 			    (p->mirr_f ? VIP_CNTRL_2_MIRR_F : 0);
 
 	priv->params = *p;
+	priv->audio_ports[p->audio_format] = p->audio_cfg;
+	priv->audio_sample_format = SNDRV_PCM_FORMAT_S24_LE;
 }
 
 static void tda998x_encoder_dpms(struct tda998x_priv *priv, int mode)
@@ -1128,6 +1225,47 @@ fail:
 	return NULL;
 }
 
+static void tda998x_set_audio(struct tda998x_priv *priv,
+			      struct drm_connector *connector)
+{
+	u8 *eld = connector->eld;
+	u8 *sad;
+	int sad_count;
+	unsigned eld_ver, mnl, rate_mask;
+	unsigned max_channels, fmt;
+
+	/* adjust the hw params from the ELD (EDID) */
+	eld_ver = eld[0] >> 3;
+	if (eld_ver != 2 && eld_ver != 31)
+		return;
+
+	mnl = eld[4] & 0x1f;
+	if (mnl > 16)
+		return;
+
+	sad_count = eld[5] >> 4;
+	sad = eld + 20 + mnl;
+
+	/* Start from the basic audio settings */
+	max_channels = 2;
+	rate_mask = 0;
+	fmt = 0;
+	while (sad_count--) {
+		switch (sad[0] & 0x78) {
+		case 0x08: /* PCM */
+			max_channels = max(max_channels, (sad[0] & 7) + 1u);
+			rate_mask |= sad[1];
+			fmt |= sad[2] & 0x07;
+			break;
+		}
+		sad += 3;
+	}
+
+	priv->max_channels = max_channels;
+	priv->rate_mask = rate_mask;
+	priv->fmt = fmt;
+}
+
 static int
 tda998x_encoder_get_modes(struct tda998x_priv *priv,
 			  struct drm_connector *connector)
@@ -1139,6 +1277,12 @@ tda998x_encoder_get_modes(struct tda998x_priv *priv,
 		drm_mode_connector_update_edid_property(connector, edid);
 		n = drm_add_edid_modes(connector, edid);
 		priv->is_hdmi_sink = drm_detect_hdmi_monitor(edid);
+
+		/* set the audio parameters from the EDID */
+		if (priv->is_hdmi_sink) {
+			drm_edid_to_eld(connector, edid);
+			tda998x_set_audio(priv, connector);
+		}
 		kfree(edid);
 	}
 
@@ -1173,6 +1317,8 @@ static void tda998x_destroy(struct tda998x_priv *priv)
 	if (priv->hdmi->irq)
 		free_irq(priv->hdmi->irq, priv);
 
+	if (priv->pdev_codec)
+		platform_device_del(priv->pdev_codec);
 	i2c_unregister_device(priv->cec);
 }
 
@@ -1250,16 +1396,38 @@ static struct drm_encoder_slave_funcs tda998x_encoder_slave_funcs = {
 
 /* I2C driver functions */
 
+static void tda998x_create_audio_codec(struct tda998x_priv *priv)
+{
+	struct platform_device *pdev;
+
+	request_module("snd-soc-tda998x");
+	pdev = platform_device_register_resndata(&priv->hdmi->dev,
+						 "tda998x-codec",
+						  PLATFORM_DEVID_NONE,
+						  NULL, 0,
+						  NULL, 0);
+	if (IS_ERR(pdev)) {
+		dev_err(&priv->hdmi->dev, "cannot create codec: %ld\n",
+			PTR_ERR(pdev));
+		return;
+	}
+
+	priv->pdev_codec = pdev;
+}
+
 static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
 {
 	struct device_node *np = client->dev.of_node;
 	u32 video;
-	int rev_lo, rev_hi, ret;
+	int i, j, rev_lo, rev_hi, ret;
 
 	priv->vip_cntrl_0 = VIP_CNTRL_0_SWAP_A(2) | VIP_CNTRL_0_SWAP_B(3);
 	priv->vip_cntrl_1 = VIP_CNTRL_1_SWAP_C(0) | VIP_CNTRL_1_SWAP_D(1);
 	priv->vip_cntrl_2 = VIP_CNTRL_2_SWAP_E(4) | VIP_CNTRL_2_SWAP_F(5);
 
+	priv->params.audio_frame[1] = 1;		/* channels - 1 */
+	priv->params.audio_sample_rate = 48000;		/* 48kHz */
+
 	priv->current_page = 0xff;
 	priv->hdmi = client;
 	priv->cec = i2c_new_dummy(client->adapter, 0x34);
@@ -1351,17 +1519,49 @@ static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
 	/* enable EDID read irq: */
 	reg_set(priv, REG_INT_FLAGS_2, INT_FLAGS_2_EDID_BLK_RD);
 
-	if (!np)
-		return 0;		/* non-DT */
+	/* get the device tree parameters */
+	if (np) {
+
+		/* optional video properties */
+		ret = of_property_read_u32(np, "video-ports", &video);
+		if (ret == 0) {
+			priv->vip_cntrl_0 = video >> 16;
+			priv->vip_cntrl_1 = video >> 8;
+			priv->vip_cntrl_2 = video;
+		}
+
+		/* optional audio properties */
+		for (i = 0; i < 2; i++) {
+			u32 port;
+			const char *p;
 
-	/* get the optional video properties */
-	ret = of_property_read_u32(np, "video-ports", &video);
-	if (ret == 0) {
-		priv->vip_cntrl_0 = video >> 16;
-		priv->vip_cntrl_1 = video >> 8;
-		priv->vip_cntrl_2 = video;
+			ret = of_property_read_u32_index(np, "audio-ports",
+							 i, &port);
+			if (ret)
+				break;
+			ret = of_property_read_string_index(np,
+							"audio-port-names",
+							i, &p);
+			if (ret) {
+				dev_err(&client->dev,
+					"missing audio-port-names[%d]\n", i);
+				break;
+			}
+			if (strcmp(p, "spdif") == 0) {
+				j = AFMT_SPDIF;
+			} else if (strcmp(p, "i2s") == 0) {
+				j = AFMT_I2S;
+			} else {
+				dev_err(&client->dev,
+					"bad audio-port-names '%s'\n", p);
+				break;
+			}
+			priv->audio_ports[j] = port;
+		}
 	}
 
+	tda998x_create_audio_codec(priv);
+
 	return 0;
 
 fail:
@@ -1395,15 +1595,13 @@ static int tda998x_encoder_init(struct i2c_client *client,
 	encoder_slave->slave_priv = priv;
 	encoder_slave->slave_funcs = &tda998x_encoder_slave_funcs;
 
+	/* set the drvdata pointer to priv2 for CODEC calls */
+	dev_set_drvdata(&client->dev,
+			container_of(priv, struct tda998x_priv2, base));
+
 	return 0;
 }
 
-struct tda998x_priv2 {
-	struct tda998x_priv base;
-	struct drm_encoder encoder;
-	struct drm_connector connector;
-};
-
 #define conn_to_tda998x_priv2(x) \
 	container_of(x, struct tda998x_priv2, connector);
 
diff --git a/include/drm/i2c/tda998x.h b/include/drm/i2c/tda998x.h
index 3e419d9..7db4c64 100644
--- a/include/drm/i2c/tda998x.h
+++ b/include/drm/i2c/tda998x.h
@@ -1,6 +1,8 @@
 #ifndef __DRM_I2C_TDA998X_H__
 #define __DRM_I2C_TDA998X_H__
 
+#include <sound/pcm_params.h>
+
 struct tda998x_encoder_params {
 	u8 swap_b:3;
 	u8 mirr_b:1;
@@ -27,4 +29,14 @@ struct tda998x_encoder_params {
 	unsigned audio_sample_rate;
 };
 
+/* audio codec interface */
+int tda998x_get_audio(struct device *dev,
+		      int *max_channels,
+		      int *rate_mask,
+		      int *fmt,
+		      struct snd_pcm_hw_constraint_list **rate_constraints);
+void tda998x_audio_switch(struct device *dev,
+			  int port_index,
+			  unsigned sample_rate,
+			  int sample_format);
 #endif
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 8ab1547..5928c4f 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -567,6 +567,9 @@ config SND_SOC_TAS5086
 	tristate "Texas Instruments TAS5086 speaker amplifier"
 	depends on I2C
 
+config SND_SOC_TDA998x
+	tristate
+
 config SND_SOC_TLV320AIC23
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index afba944..e7c2bec 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -100,6 +100,7 @@ snd-soc-sta350-objs := sta350.o
 snd-soc-sta529-objs := sta529.o
 snd-soc-stac9766-objs := stac9766.o
 snd-soc-tas5086-objs := tas5086.o
+snd-soc-tda998x-objs := tda998x.o
 snd-soc-tlv320aic23-objs := tlv320aic23.o
 snd-soc-tlv320aic23-i2c-objs := tlv320aic23-i2c.o
 snd-soc-tlv320aic23-spi-objs := tlv320aic23-spi.o
@@ -272,6 +273,7 @@ obj-$(CONFIG_SND_SOC_STA529)   += snd-soc-sta529.o
 obj-$(CONFIG_SND_SOC_STAC9766)	+= snd-soc-stac9766.o
 obj-$(CONFIG_SND_SOC_TAS2552)	+= snd-soc-tas2552.o
 obj-$(CONFIG_SND_SOC_TAS5086)	+= snd-soc-tas5086.o
+obj-$(CONFIG_SND_SOC_TDA998x)	+= snd-soc-tda998x.o
 obj-$(CONFIG_SND_SOC_TLV320AIC23)	+= snd-soc-tlv320aic23.o
 obj-$(CONFIG_SND_SOC_TLV320AIC23_I2C)	+= snd-soc-tlv320aic23-i2c.o
 obj-$(CONFIG_SND_SOC_TLV320AIC23_SPI)	+= snd-soc-tlv320aic23-spi.o
diff --git a/sound/soc/codecs/tda998x.c b/sound/soc/codecs/tda998x.c
new file mode 100644
index 0000000..e5c3dce
--- /dev/null
+++ b/sound/soc/codecs/tda998x.c
@@ -0,0 +1,163 @@
+/*
+ * ALSA SoC TDA998X CODEC
+ *
+ * Copyright (C) 2014 Jean-Francois Moine
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <sound/soc.h>
+#include <linux/of.h>
+#include <linux/i2c.h>
+#include <drm/i2c/tda998x.h>
+
+#define TDA998X_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
+			SNDRV_PCM_FMTBIT_S20_3LE | \
+			SNDRV_PCM_FMTBIT_S24_LE | \
+			SNDRV_PCM_FMTBIT_S32_LE)
+
+static int tda_startup(struct snd_pcm_substream *substream,
+			struct snd_soc_dai *dai)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct device *dev = dai->dev;
+	int ret, max_channels, rate_mask, fmt;
+	u64 formats;
+	struct snd_pcm_hw_constraint_list *rate_constraints;
+	static const u32 hdmi_rates[] = {
+		32000, 44100, 48000, 88200, 96000, 176400, 192000
+	};
+
+	/* get the EDID values and the rate constraints buffer */
+	ret = tda998x_get_audio(dev, &max_channels, &rate_mask, &fmt,
+			&rate_constraints);
+	if (ret < 0)
+		return ret;				/* no screen */
+
+	/* convert the EDID values to audio constraints */
+	rate_constraints->list = hdmi_rates;
+	rate_constraints->count = ARRAY_SIZE(hdmi_rates);
+	rate_constraints->mask = rate_mask;
+	snd_pcm_hw_constraint_list(runtime, 0,
+				   SNDRV_PCM_HW_PARAM_RATE,
+				   rate_constraints);
+
+	formats = 0;
+	if (fmt & 1)
+		formats |= SNDRV_PCM_FMTBIT_S16_LE;
+	if (fmt & 2)
+		formats |= SNDRV_PCM_FMTBIT_S20_3LE;
+	if (fmt & 4)
+		formats |= SNDRV_PCM_FMTBIT_S24_LE;
+	snd_pcm_hw_constraint_mask64(runtime,
+				SNDRV_PCM_HW_PARAM_FORMAT,
+				formats);
+
+	snd_pcm_hw_constraint_minmax(runtime,
+				SNDRV_PCM_HW_PARAM_CHANNELS,
+				1, max_channels);
+	return 0;
+}
+
+static int tda_hw_params(struct snd_pcm_substream *substream,
+			struct snd_pcm_hw_params *params,
+			struct snd_soc_dai *dai)
+{
+	struct device *dev = dai->dev;
+
+	tda998x_audio_switch(dev, dai->id,
+			  params_rate(params), params_format(params));
+	return 0;
+}
+
+static void tda_shutdown(struct snd_pcm_substream *substream,
+			struct snd_soc_dai *dai)
+{
+	struct device *dev = dai->dev;
+
+	tda998x_audio_switch(dev, -1, 0, 0);		/* stop */
+}
+
+static const struct snd_soc_dai_ops tda_ops = {
+	.startup = tda_startup,
+	.hw_params = tda_hw_params,
+	.shutdown = tda_shutdown,
+};
+
+static struct snd_soc_dai_driver tda998x_dais[] = {
+	{
+		.name = "spdif-hifi",
+		.id = AFMT_SPDIF,
+		.playback = {
+			.stream_name	= "HDMI SPDIF Playback",
+			.channels_min	= 1,
+			.channels_max	= 2,
+			.rates		= SNDRV_PCM_RATE_CONTINUOUS,
+			.rate_min	= 22050,
+			.rate_max	= 192000,
+			.formats	= TDA998X_FORMATS,
+		},
+		.ops = &tda_ops,
+	},
+	{
+		.name = "i2s-hifi",
+		.id = AFMT_I2S,
+		.playback = {
+			.stream_name	= "HDMI I2S Playback",
+			.channels_min	= 1,
+			.channels_max	= 8,
+			.rates		= SNDRV_PCM_RATE_CONTINUOUS,
+			.rate_min	= 5512,
+			.rate_max	= 192000,
+			.formats	= TDA998X_FORMATS,
+		},
+		.ops = &tda_ops,
+	},
+};
+
+static const struct snd_soc_dapm_widget tda_widgets[] = {
+	SND_SOC_DAPM_OUTPUT("hdmi-out"),
+};
+static const struct snd_soc_dapm_route tda_routes[] = {
+	{ "hdmi-out", NULL, "HDMI I2S Playback" },
+	{ "hdmi-out", NULL, "HDMI SPDIF Playback" },
+};
+
+static struct snd_soc_codec_driver soc_codec_tda998x = {
+	.dapm_widgets = tda_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(tda_widgets),
+	.dapm_routes = tda_routes,
+	.num_dapm_routes = ARRAY_SIZE(tda_routes),
+};
+
+static int tda998x_codec_dev_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_codec(pdev->dev.parent,
+				      &soc_codec_tda998x,
+				      tda998x_dais, ARRAY_SIZE(tda998x_dais));
+}
+
+static int tda998x_codec_dev_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(pdev->dev.parent);
+	return 0;
+}
+
+static struct platform_driver tda998x_codec = {
+	.driver = {
+		.name = "tda998x-codec",
+		.owner  = THIS_MODULE,
+	},
+	.probe = tda998x_codec_dev_probe,
+	.remove = tda998x_codec_dev_remove,
+};
+
+module_platform_driver(tda998x_codec);
+
+MODULE_AUTHOR("Jean-Francois Moine <moinejf@free.fr>");
+MODULE_DESCRIPTION("NXP TDA998X CODEC");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:tda998x-codec");
-- 
2.1.0
