From: Jose Abreu <Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 1/4] drm/i2c/adv7511: Add audio support
Date: Mon, 28 Mar 2016 10:41:49 +0100
Message-ID: <c1305665593e507b0ea71389784fc0b084bb576c.1458839710.git.joabreu@synopsys.com>
References: <cover.1458839710.git.joabreu@synopsys.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1458839710.git.joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
In-Reply-To: <cover.1458839710.git.joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
References: <cover.1458839710.git.joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: airlied-cv59FeDIM0c@public.gmane.org, lgirdwoord-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, mjonker-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Jose Abreu <Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This patch adds audio support for the ADV7511 HDMI transmitter
using ALSA SOC.

The code was ported from Analog Devices linux tree from
commit 1770c4a1e32b ("Merge remote-tracking branch
'xilinx/master' into xcomm_zynq"), which is available at:
	- https://github.com/analogdevicesinc/linux/

The main core file was renamed from adv7511.c to adv7511_core.c
so that audio and video compile into a single adv7511.ko module
and to keep up with Analog Devices kernel tree.

The audio can be disabled using menu-config so it is possible
to use only video mode.

The HDMI mode is automatically started at boot and the audio
(when enabled) registers as a codec into ALSA.

SPDIF DAI format was also added to ASoC as it is required by
adv7511 audio.

Signed-off-by: Jose Abreu <joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
---
 drivers/gpu/drm/i2c/Kconfig         |    8 +
 drivers/gpu/drm/i2c/Makefile        |    2 +
 drivers/gpu/drm/i2c/adv7511.c       | 1024 -----------------------------------
 drivers/gpu/drm/i2c/adv7511.h       |   41 ++
 drivers/gpu/drm/i2c/adv7511_audio.c |  310 +++++++++++
 drivers/gpu/drm/i2c/adv7511_core.c  | 1005 ++++++++++++++++++++++++++++++++++
 include/sound/soc-dai.h             |    1 +
 7 files changed, 1367 insertions(+), 1024 deletions(-)
 delete mode 100644 drivers/gpu/drm/i2c/adv7511.c
 create mode 100644 drivers/gpu/drm/i2c/adv7511_audio.c
 create mode 100644 drivers/gpu/drm/i2c/adv7511_core.c

diff --git a/drivers/gpu/drm/i2c/Kconfig b/drivers/gpu/drm/i2c/Kconfig
index 22c7ed6..2cb6c0d 100644
--- a/drivers/gpu/drm/i2c/Kconfig
+++ b/drivers/gpu/drm/i2c/Kconfig
@@ -7,6 +7,14 @@ config DRM_I2C_ADV7511
 	help
 	  Support for the Analog Device ADV7511(W) and ADV7513 HDMI encoders.
 
+config DRM_I2C_ADV7511_AUDIO
+	bool "ADV7511 audio"
+	depends on DRM_I2C_ADV7511 && SND_SOC
+	default y
+	help
+	  This adds support for audio on the ADV7511(W) and ADV7513 HDMI
+	  encoders.
+
 config DRM_I2C_CH7006
 	tristate "Chrontel ch7006 TV encoder"
 	default m if DRM_NOUVEAU
diff --git a/drivers/gpu/drm/i2c/Makefile b/drivers/gpu/drm/i2c/Makefile
index 2c72eb5..513f683 100644
--- a/drivers/gpu/drm/i2c/Makefile
+++ b/drivers/gpu/drm/i2c/Makefile
@@ -1,6 +1,8 @@
 ccflags-y := -Iinclude/drm
 
 obj-$(CONFIG_DRM_I2C_ADV7511) += adv7511.o
+adv7511-y := adv7511_core.o
+adv7511-$(CONFIG_DRM_I2C_ADV7511_AUDIO) += adv7511_audio.o
 
 ch7006-y := ch7006_drv.o ch7006_mode.o
 obj-$(CONFIG_DRM_I2C_CH7006) += ch7006.o
diff --git a/drivers/gpu/drm/i2c/adv7511.c b/drivers/gpu/drm/i2c/adv7511.c
deleted file mode 100644
index a02112b..0000000
--- a/drivers/gpu/drm/i2c/adv7511.c
+++ /dev/null
@@ -1,1024 +0,0 @@
-/*
- * Analog Devices ADV7511 HDMI transmitter driver
- *
- * Copyright 2012 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
- */
-
-#include <linux/device.h>
-#include <linux/gpio/consumer.h>
-#include <linux/i2c.h>
-#include <linux/module.h>
-#include <linux/regmap.h>
-#include <linux/slab.h>
-
-#include <drm/drmP.h>
-#include <drm/drm_crtc_helper.h>
-#include <drm/drm_edid.h>
-#include <drm/drm_encoder_slave.h>
-
-#include "adv7511.h"
-
-struct adv7511 {
-	struct i2c_client *i2c_main;
-	struct i2c_client *i2c_edid;
-
-	struct regmap *regmap;
-	struct regmap *packet_memory_regmap;
-	enum drm_connector_status status;
-	bool powered;
-
-	unsigned int f_tmds;
-
-	unsigned int current_edid_segment;
-	uint8_t edid_buf[256];
-	bool edid_read;
-
-	wait_queue_head_t wq;
-	struct drm_encoder *encoder;
-
-	bool embedded_sync;
-	enum adv7511_sync_polarity vsync_polarity;
-	enum adv7511_sync_polarity hsync_polarity;
-	bool rgb;
-
-	struct edid *edid;
-
-	struct gpio_desc *gpio_pd;
-};
-
-static struct adv7511 *encoder_to_adv7511(struct drm_encoder *encoder)
-{
-	return to_encoder_slave(encoder)->slave_priv;
-}
-
-/* ADI recommended values for proper operation. */
-static const struct reg_sequence adv7511_fixed_registers[] = {
-	{ 0x98, 0x03 },
-	{ 0x9a, 0xe0 },
-	{ 0x9c, 0x30 },
-	{ 0x9d, 0x61 },
-	{ 0xa2, 0xa4 },
-	{ 0xa3, 0xa4 },
-	{ 0xe0, 0xd0 },
-	{ 0xf9, 0x00 },
-	{ 0x55, 0x02 },
-};
-
-/* -----------------------------------------------------------------------------
- * Register access
- */
-
-static const uint8_t adv7511_register_defaults[] = {
-	0x12, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 00 */
-	0x00, 0x00, 0x01, 0x0e, 0xbc, 0x18, 0x01, 0x13,
-	0x25, 0x37, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 10 */
-	0x46, 0x62, 0x04, 0xa8, 0x00, 0x00, 0x1c, 0x84,
-	0x1c, 0xbf, 0x04, 0xa8, 0x1e, 0x70, 0x02, 0x1e, /* 20 */
-	0x00, 0x00, 0x04, 0xa8, 0x08, 0x12, 0x1b, 0xac,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 30 */
-	0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x00, 0xb0,
-	0x00, 0x50, 0x90, 0x7e, 0x79, 0x70, 0x00, 0x00, /* 40 */
-	0x00, 0xa8, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x02, 0x0d, 0x00, 0x00, 0x00, 0x00, /* 50 */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 60 */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x01, 0x0a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 70 */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 80 */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0xc0, 0x00, 0x00, 0x00, /* 90 */
-	0x0b, 0x02, 0x00, 0x18, 0x5a, 0x60, 0x00, 0x00,
-	0x00, 0x00, 0x80, 0x80, 0x08, 0x04, 0x00, 0x00, /* a0 */
-	0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x40, 0x14,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* b0 */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* c0 */
-	0x00, 0x03, 0x00, 0x00, 0x02, 0x00, 0x01, 0x04,
-	0x30, 0xff, 0x80, 0x80, 0x80, 0x00, 0x00, 0x00, /* d0 */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x01,
-	0x80, 0x75, 0x00, 0x00, 0x60, 0x00, 0x00, 0x00, /* e0 */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x75, 0x11, 0x00, /* f0 */
-	0x00, 0x7c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-};
-
-static bool adv7511_register_volatile(struct device *dev, unsigned int reg)
-{
-	switch (reg) {
-	case ADV7511_REG_CHIP_REVISION:
-	case ADV7511_REG_SPDIF_FREQ:
-	case ADV7511_REG_CTS_AUTOMATIC1:
-	case ADV7511_REG_CTS_AUTOMATIC2:
-	case ADV7511_REG_VIC_DETECTED:
-	case ADV7511_REG_VIC_SEND:
-	case ADV7511_REG_AUX_VIC_DETECTED:
-	case ADV7511_REG_STATUS:
-	case ADV7511_REG_GC(1):
-	case ADV7511_REG_INT(0):
-	case ADV7511_REG_INT(1):
-	case ADV7511_REG_PLL_STATUS:
-	case ADV7511_REG_AN(0):
-	case ADV7511_REG_AN(1):
-	case ADV7511_REG_AN(2):
-	case ADV7511_REG_AN(3):
-	case ADV7511_REG_AN(4):
-	case ADV7511_REG_AN(5):
-	case ADV7511_REG_AN(6):
-	case ADV7511_REG_AN(7):
-	case ADV7511_REG_HDCP_STATUS:
-	case ADV7511_REG_BCAPS:
-	case ADV7511_REG_BKSV(0):
-	case ADV7511_REG_BKSV(1):
-	case ADV7511_REG_BKSV(2):
-	case ADV7511_REG_BKSV(3):
-	case ADV7511_REG_BKSV(4):
-	case ADV7511_REG_DDC_STATUS:
-	case ADV7511_REG_EDID_READ_CTRL:
-	case ADV7511_REG_BSTATUS(0):
-	case ADV7511_REG_BSTATUS(1):
-	case ADV7511_REG_CHIP_ID_HIGH:
-	case ADV7511_REG_CHIP_ID_LOW:
-		return true;
-	}
-
-	return false;
-}
-
-static const struct regmap_config adv7511_regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-
-	.max_register = 0xff,
-	.cache_type = REGCACHE_RBTREE,
-	.reg_defaults_raw = adv7511_register_defaults,
-	.num_reg_defaults_raw = ARRAY_SIZE(adv7511_register_defaults),
-
-	.volatile_reg = adv7511_register_volatile,
-};
-
-/* -----------------------------------------------------------------------------
- * Hardware configuration
- */
-
-static void adv7511_set_colormap(struct adv7511 *adv7511, bool enable,
-				 const uint16_t *coeff,
-				 unsigned int scaling_factor)
-{
-	unsigned int i;
-
-	regmap_update_bits(adv7511->regmap, ADV7511_REG_CSC_UPPER(1),
-			   ADV7511_CSC_UPDATE_MODE, ADV7511_CSC_UPDATE_MODE);
-
-	if (enable) {
-		for (i = 0; i < 12; ++i) {
-			regmap_update_bits(adv7511->regmap,
-					   ADV7511_REG_CSC_UPPER(i),
-					   0x1f, coeff[i] >> 8);
-			regmap_write(adv7511->regmap,
-				     ADV7511_REG_CSC_LOWER(i),
-				     coeff[i] & 0xff);
-		}
-	}
-
-	if (enable)
-		regmap_update_bits(adv7511->regmap, ADV7511_REG_CSC_UPPER(0),
-				   0xe0, 0x80 | (scaling_factor << 5));
-	else
-		regmap_update_bits(adv7511->regmap, ADV7511_REG_CSC_UPPER(0),
-				   0x80, 0x00);
-
-	regmap_update_bits(adv7511->regmap, ADV7511_REG_CSC_UPPER(1),
-			   ADV7511_CSC_UPDATE_MODE, 0);
-}
-
-static int adv7511_packet_enable(struct adv7511 *adv7511, unsigned int packet)
-{
-	if (packet & 0xff)
-		regmap_update_bits(adv7511->regmap, ADV7511_REG_PACKET_ENABLE0,
-				   packet, 0xff);
-
-	if (packet & 0xff00) {
-		packet >>= 8;
-		regmap_update_bits(adv7511->regmap, ADV7511_REG_PACKET_ENABLE1,
-				   packet, 0xff);
-	}
-
-	return 0;
-}
-
-static int adv7511_packet_disable(struct adv7511 *adv7511, unsigned int packet)
-{
-	if (packet & 0xff)
-		regmap_update_bits(adv7511->regmap, ADV7511_REG_PACKET_ENABLE0,
-				   packet, 0x00);
-
-	if (packet & 0xff00) {
-		packet >>= 8;
-		regmap_update_bits(adv7511->regmap, ADV7511_REG_PACKET_ENABLE1,
-				   packet, 0x00);
-	}
-
-	return 0;
-}
-
-/* Coefficients for adv7511 color space conversion */
-static const uint16_t adv7511_csc_ycbcr_to_rgb[] = {
-	0x0734, 0x04ad, 0x0000, 0x1c1b,
-	0x1ddc, 0x04ad, 0x1f24, 0x0135,
-	0x0000, 0x04ad, 0x087c, 0x1b77,
-};
-
-static void adv7511_set_config_csc(struct adv7511 *adv7511,
-				   struct drm_connector *connector,
-				   bool rgb)
-{
-	struct adv7511_video_config config;
-	bool output_format_422, output_format_ycbcr;
-	unsigned int mode;
-	uint8_t infoframe[17];
-
-	if (adv7511->edid)
-		config.hdmi_mode = drm_detect_hdmi_monitor(adv7511->edid);
-	else
-		config.hdmi_mode = false;
-
-	hdmi_avi_infoframe_init(&config.avi_infoframe);
-
-	config.avi_infoframe.scan_mode = HDMI_SCAN_MODE_UNDERSCAN;
-
-	if (rgb) {
-		config.csc_enable = false;
-		config.avi_infoframe.colorspace = HDMI_COLORSPACE_RGB;
-	} else {
-		config.csc_scaling_factor = ADV7511_CSC_SCALING_4;
-		config.csc_coefficents = adv7511_csc_ycbcr_to_rgb;
-
-		if ((connector->display_info.color_formats &
-		     DRM_COLOR_FORMAT_YCRCB422) &&
-		    config.hdmi_mode) {
-			config.csc_enable = false;
-			config.avi_infoframe.colorspace =
-				HDMI_COLORSPACE_YUV422;
-		} else {
-			config.csc_enable = true;
-			config.avi_infoframe.colorspace = HDMI_COLORSPACE_RGB;
-		}
-	}
-
-	if (config.hdmi_mode) {
-		mode = ADV7511_HDMI_CFG_MODE_HDMI;
-
-		switch (config.avi_infoframe.colorspace) {
-		case HDMI_COLORSPACE_YUV444:
-			output_format_422 = false;
-			output_format_ycbcr = true;
-			break;
-		case HDMI_COLORSPACE_YUV422:
-			output_format_422 = true;
-			output_format_ycbcr = true;
-			break;
-		default:
-			output_format_422 = false;
-			output_format_ycbcr = false;
-			break;
-		}
-	} else {
-		mode = ADV7511_HDMI_CFG_MODE_DVI;
-		output_format_422 = false;
-		output_format_ycbcr = false;
-	}
-
-	adv7511_packet_disable(adv7511, ADV7511_PACKET_ENABLE_AVI_INFOFRAME);
-
-	adv7511_set_colormap(adv7511, config.csc_enable,
-			     config.csc_coefficents,
-			     config.csc_scaling_factor);
-
-	regmap_update_bits(adv7511->regmap, ADV7511_REG_VIDEO_INPUT_CFG1, 0x81,
-			   (output_format_422 << 7) | output_format_ycbcr);
-
-	regmap_update_bits(adv7511->regmap, ADV7511_REG_HDCP_HDMI_CFG,
-			   ADV7511_HDMI_CFG_MODE_MASK, mode);
-
-	hdmi_avi_infoframe_pack(&config.avi_infoframe, infoframe,
-				sizeof(infoframe));
-
-	/* The AVI infoframe id is not configurable */
-	regmap_bulk_write(adv7511->regmap, ADV7511_REG_AVI_INFOFRAME_VERSION,
-			  infoframe + 1, sizeof(infoframe) - 1);
-
-	adv7511_packet_enable(adv7511, ADV7511_PACKET_ENABLE_AVI_INFOFRAME);
-}
-
-static void adv7511_set_link_config(struct adv7511 *adv7511,
-				    const struct adv7511_link_config *config)
-{
-	/*
-	 * The input style values documented in the datasheet don't match the
-	 * hardware register field values :-(
-	 */
-	static const unsigned int input_styles[4] = { 0, 2, 1, 3 };
-
-	unsigned int clock_delay;
-	unsigned int color_depth;
-	unsigned int input_id;
-
-	clock_delay = (config->clock_delay + 1200) / 400;
-	color_depth = config->input_color_depth == 8 ? 3
-		    : (config->input_color_depth == 10 ? 1 : 2);
-
-	/* TODO Support input ID 6 */
-	if (config->input_colorspace != HDMI_COLORSPACE_YUV422)
-		input_id = config->input_clock == ADV7511_INPUT_CLOCK_DDR
-			 ? 5 : 0;
-	else if (config->input_clock == ADV7511_INPUT_CLOCK_DDR)
-		input_id = config->embedded_sync ? 8 : 7;
-	else if (config->input_clock == ADV7511_INPUT_CLOCK_2X)
-		input_id = config->embedded_sync ? 4 : 3;
-	else
-		input_id = config->embedded_sync ? 2 : 1;
-
-	regmap_update_bits(adv7511->regmap, ADV7511_REG_I2C_FREQ_ID_CFG, 0xf,
-			   input_id);
-	regmap_update_bits(adv7511->regmap, ADV7511_REG_VIDEO_INPUT_CFG1, 0x7e,
-			   (color_depth << 4) |
-			   (input_styles[config->input_style] << 2));
-	regmap_write(adv7511->regmap, ADV7511_REG_VIDEO_INPUT_CFG2,
-		     config->input_justification << 3);
-	regmap_write(adv7511->regmap, ADV7511_REG_TIMING_GEN_SEQ,
-		     config->sync_pulse << 2);
-
-	regmap_write(adv7511->regmap, 0xba, clock_delay << 5);
-
-	adv7511->embedded_sync = config->embedded_sync;
-	adv7511->hsync_polarity = config->hsync_polarity;
-	adv7511->vsync_polarity = config->vsync_polarity;
-	adv7511->rgb = config->input_colorspace == HDMI_COLORSPACE_RGB;
-}
-
-static void adv7511_power_on(struct adv7511 *adv7511)
-{
-	adv7511->current_edid_segment = -1;
-
-	regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER,
-			   ADV7511_POWER_POWER_DOWN, 0);
-	if (adv7511->i2c_main->irq) {
-		/*
-		 * Documentation says the INT_ENABLE registers are reset in
-		 * POWER_DOWN mode. My 7511w preserved the bits, however.
-		 * Still, let's be safe and stick to the documentation.
-		 */
-		regmap_write(adv7511->regmap, ADV7511_REG_INT_ENABLE(0),
-			     ADV7511_INT0_EDID_READY);
-		regmap_write(adv7511->regmap, ADV7511_REG_INT_ENABLE(1),
-			     ADV7511_INT1_DDC_ERROR);
-	}
-
-	/*
-	 * Per spec it is allowed to pulse the HPD signal to indicate that the
-	 * EDID information has changed. Some monitors do this when they wakeup
-	 * from standby or are enabled. When the HPD goes low the adv7511 is
-	 * reset and the outputs are disabled which might cause the monitor to
-	 * go to standby again. To avoid this we ignore the HPD pin for the
-	 * first few seconds after enabling the output.
-	 */
-	regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER2,
-			   ADV7511_REG_POWER2_HPD_SRC_MASK,
-			   ADV7511_REG_POWER2_HPD_SRC_NONE);
-
-	/*
-	 * Most of the registers are reset during power down or when HPD is low.
-	 */
-	regcache_sync(adv7511->regmap);
-
-	adv7511->powered = true;
-}
-
-static void adv7511_power_off(struct adv7511 *adv7511)
-{
-	/* TODO: setup additional power down modes */
-	regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER,
-			   ADV7511_POWER_POWER_DOWN,
-			   ADV7511_POWER_POWER_DOWN);
-	regcache_mark_dirty(adv7511->regmap);
-
-	adv7511->powered = false;
-}
-
-/* -----------------------------------------------------------------------------
- * Interrupt and hotplug detection
- */
-
-static bool adv7511_hpd(struct adv7511 *adv7511)
-{
-	unsigned int irq0;
-	int ret;
-
-	ret = regmap_read(adv7511->regmap, ADV7511_REG_INT(0), &irq0);
-	if (ret < 0)
-		return false;
-
-	if (irq0 & ADV7511_INT0_HPD) {
-		regmap_write(adv7511->regmap, ADV7511_REG_INT(0),
-			     ADV7511_INT0_HPD);
-		return true;
-	}
-
-	return false;
-}
-
-static int adv7511_irq_process(struct adv7511 *adv7511)
-{
-	unsigned int irq0, irq1;
-	int ret;
-
-	ret = regmap_read(adv7511->regmap, ADV7511_REG_INT(0), &irq0);
-	if (ret < 0)
-		return ret;
-
-	ret = regmap_read(adv7511->regmap, ADV7511_REG_INT(1), &irq1);
-	if (ret < 0)
-		return ret;
-
-	regmap_write(adv7511->regmap, ADV7511_REG_INT(0), irq0);
-	regmap_write(adv7511->regmap, ADV7511_REG_INT(1), irq1);
-
-	if (irq0 & ADV7511_INT0_HPD && adv7511->encoder)
-		drm_helper_hpd_irq_event(adv7511->encoder->dev);
-
-	if (irq0 & ADV7511_INT0_EDID_READY || irq1 & ADV7511_INT1_DDC_ERROR) {
-		adv7511->edid_read = true;
-
-		if (adv7511->i2c_main->irq)
-			wake_up_all(&adv7511->wq);
-	}
-
-	return 0;
-}
-
-static irqreturn_t adv7511_irq_handler(int irq, void *devid)
-{
-	struct adv7511 *adv7511 = devid;
-	int ret;
-
-	ret = adv7511_irq_process(adv7511);
-	return ret < 0 ? IRQ_NONE : IRQ_HANDLED;
-}
-
-/* -----------------------------------------------------------------------------
- * EDID retrieval
- */
-
-static int adv7511_wait_for_edid(struct adv7511 *adv7511, int timeout)
-{
-	int ret;
-
-	if (adv7511->i2c_main->irq) {
-		ret = wait_event_interruptible_timeout(adv7511->wq,
-				adv7511->edid_read, msecs_to_jiffies(timeout));
-	} else {
-		for (; timeout > 0; timeout -= 25) {
-			ret = adv7511_irq_process(adv7511);
-			if (ret < 0)
-				break;
-
-			if (adv7511->edid_read)
-				break;
-
-			msleep(25);
-		}
-	}
-
-	return adv7511->edid_read ? 0 : -EIO;
-}
-
-static int adv7511_get_edid_block(void *data, u8 *buf, unsigned int block,
-				  size_t len)
-{
-	struct adv7511 *adv7511 = data;
-	struct i2c_msg xfer[2];
-	uint8_t offset;
-	unsigned int i;
-	int ret;
-
-	if (len > 128)
-		return -EINVAL;
-
-	if (adv7511->current_edid_segment != block / 2) {
-		unsigned int status;
-
-		ret = regmap_read(adv7511->regmap, ADV7511_REG_DDC_STATUS,
-				  &status);
-		if (ret < 0)
-			return ret;
-
-		if (status != 2) {
-			adv7511->edid_read = false;
-			regmap_write(adv7511->regmap, ADV7511_REG_EDID_SEGMENT,
-				     block);
-			ret = adv7511_wait_for_edid(adv7511, 200);
-			if (ret < 0)
-				return ret;
-		}
-
-		/* Break this apart, hopefully more I2C controllers will
-		 * support 64 byte transfers than 256 byte transfers
-		 */
-
-		xfer[0].addr = adv7511->i2c_edid->addr;
-		xfer[0].flags = 0;
-		xfer[0].len = 1;
-		xfer[0].buf = &offset;
-		xfer[1].addr = adv7511->i2c_edid->addr;
-		xfer[1].flags = I2C_M_RD;
-		xfer[1].len = 64;
-		xfer[1].buf = adv7511->edid_buf;
-
-		offset = 0;
-
-		for (i = 0; i < 4; ++i) {
-			ret = i2c_transfer(adv7511->i2c_edid->adapter, xfer,
-					   ARRAY_SIZE(xfer));
-			if (ret < 0)
-				return ret;
-			else if (ret != 2)
-				return -EIO;
-
-			xfer[1].buf += 64;
-			offset += 64;
-		}
-
-		adv7511->current_edid_segment = block / 2;
-	}
-
-	if (block % 2 == 0)
-		memcpy(buf, adv7511->edid_buf, len);
-	else
-		memcpy(buf, adv7511->edid_buf + 128, len);
-
-	return 0;
-}
-
-/* -----------------------------------------------------------------------------
- * Encoder operations
- */
-
-static int adv7511_get_modes(struct drm_encoder *encoder,
-			     struct drm_connector *connector)
-{
-	struct adv7511 *adv7511 = encoder_to_adv7511(encoder);
-	struct edid *edid;
-	unsigned int count;
-
-	/* Reading the EDID only works if the device is powered */
-	if (!adv7511->powered) {
-		regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER,
-				   ADV7511_POWER_POWER_DOWN, 0);
-		if (adv7511->i2c_main->irq) {
-			regmap_write(adv7511->regmap, ADV7511_REG_INT_ENABLE(0),
-				     ADV7511_INT0_EDID_READY);
-			regmap_write(adv7511->regmap, ADV7511_REG_INT_ENABLE(1),
-				     ADV7511_INT1_DDC_ERROR);
-		}
-		adv7511->current_edid_segment = -1;
-	}
-
-	edid = drm_do_get_edid(connector, adv7511_get_edid_block, adv7511);
-
-	if (!adv7511->powered)
-		regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER,
-				   ADV7511_POWER_POWER_DOWN,
-				   ADV7511_POWER_POWER_DOWN);
-
-	kfree(adv7511->edid);
-	adv7511->edid = edid;
-	if (!edid)
-		return 0;
-
-	drm_mode_connector_update_edid_property(connector, edid);
-	count = drm_add_edid_modes(connector, edid);
-
-	adv7511_set_config_csc(adv7511, connector, adv7511->rgb);
-
-	return count;
-}
-
-static void adv7511_encoder_dpms(struct drm_encoder *encoder, int mode)
-{
-	struct adv7511 *adv7511 = encoder_to_adv7511(encoder);
-
-	if (mode == DRM_MODE_DPMS_ON)
-		adv7511_power_on(adv7511);
-	else
-		adv7511_power_off(adv7511);
-}
-
-static enum drm_connector_status
-adv7511_encoder_detect(struct drm_encoder *encoder,
-		       struct drm_connector *connector)
-{
-	struct adv7511 *adv7511 = encoder_to_adv7511(encoder);
-	enum drm_connector_status status;
-	unsigned int val;
-	bool hpd;
-	int ret;
-
-	ret = regmap_read(adv7511->regmap, ADV7511_REG_STATUS, &val);
-	if (ret < 0)
-		return connector_status_disconnected;
-
-	if (val & ADV7511_STATUS_HPD)
-		status = connector_status_connected;
-	else
-		status = connector_status_disconnected;
-
-	hpd = adv7511_hpd(adv7511);
-
-	/* The chip resets itself when the cable is disconnected, so in case
-	 * there is a pending HPD interrupt and the cable is connected there was
-	 * at least one transition from disconnected to connected and the chip
-	 * has to be reinitialized. */
-	if (status == connector_status_connected && hpd && adv7511->powered) {
-		regcache_mark_dirty(adv7511->regmap);
-		adv7511_power_on(adv7511);
-		adv7511_get_modes(encoder, connector);
-		if (adv7511->status == connector_status_connected)
-			status = connector_status_disconnected;
-	} else {
-		/* Renable HPD sensing */
-		regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER2,
-				   ADV7511_REG_POWER2_HPD_SRC_MASK,
-				   ADV7511_REG_POWER2_HPD_SRC_BOTH);
-	}
-
-	adv7511->status = status;
-	return status;
-}
-
-static int adv7511_encoder_mode_valid(struct drm_encoder *encoder,
-				      struct drm_display_mode *mode)
-{
-	if (mode->clock > 165000)
-		return MODE_CLOCK_HIGH;
-
-	return MODE_OK;
-}
-
-static void adv7511_encoder_mode_set(struct drm_encoder *encoder,
-				     struct drm_display_mode *mode,
-				     struct drm_display_mode *adj_mode)
-{
-	struct adv7511 *adv7511 = encoder_to_adv7511(encoder);
-	unsigned int low_refresh_rate;
-	unsigned int hsync_polarity = 0;
-	unsigned int vsync_polarity = 0;
-
-	if (adv7511->embedded_sync) {
-		unsigned int hsync_offset, hsync_len;
-		unsigned int vsync_offset, vsync_len;
-
-		hsync_offset = adj_mode->crtc_hsync_start -
-			       adj_mode->crtc_hdisplay;
-		vsync_offset = adj_mode->crtc_vsync_start -
-			       adj_mode->crtc_vdisplay;
-		hsync_len = adj_mode->crtc_hsync_end -
-			    adj_mode->crtc_hsync_start;
-		vsync_len = adj_mode->crtc_vsync_end -
-			    adj_mode->crtc_vsync_start;
-
-		/* The hardware vsync generator has a off-by-one bug */
-		vsync_offset += 1;
-
-		regmap_write(adv7511->regmap, ADV7511_REG_HSYNC_PLACEMENT_MSB,
-			     ((hsync_offset >> 10) & 0x7) << 5);
-		regmap_write(adv7511->regmap, ADV7511_REG_SYNC_DECODER(0),
-			     (hsync_offset >> 2) & 0xff);
-		regmap_write(adv7511->regmap, ADV7511_REG_SYNC_DECODER(1),
-			     ((hsync_offset & 0x3) << 6) |
-			     ((hsync_len >> 4) & 0x3f));
-		regmap_write(adv7511->regmap, ADV7511_REG_SYNC_DECODER(2),
-			     ((hsync_len & 0xf) << 4) |
-			     ((vsync_offset >> 6) & 0xf));
-		regmap_write(adv7511->regmap, ADV7511_REG_SYNC_DECODER(3),
-			     ((vsync_offset & 0x3f) << 2) |
-			     ((vsync_len >> 8) & 0x3));
-		regmap_write(adv7511->regmap, ADV7511_REG_SYNC_DECODER(4),
-			     vsync_len & 0xff);
-
-		hsync_polarity = !(adj_mode->flags & DRM_MODE_FLAG_PHSYNC);
-		vsync_polarity = !(adj_mode->flags & DRM_MODE_FLAG_PVSYNC);
-	} else {
-		enum adv7511_sync_polarity mode_hsync_polarity;
-		enum adv7511_sync_polarity mode_vsync_polarity;
-
-		/**
-		 * If the input signal is always low or always high we want to
-		 * invert or let it passthrough depending on the polarity of the
-		 * current mode.
-		 **/
-		if (adj_mode->flags & DRM_MODE_FLAG_NHSYNC)
-			mode_hsync_polarity = ADV7511_SYNC_POLARITY_LOW;
-		else
-			mode_hsync_polarity = ADV7511_SYNC_POLARITY_HIGH;
-
-		if (adj_mode->flags & DRM_MODE_FLAG_NVSYNC)
-			mode_vsync_polarity = ADV7511_SYNC_POLARITY_LOW;
-		else
-			mode_vsync_polarity = ADV7511_SYNC_POLARITY_HIGH;
-
-		if (adv7511->hsync_polarity != mode_hsync_polarity &&
-		    adv7511->hsync_polarity !=
-		    ADV7511_SYNC_POLARITY_PASSTHROUGH)
-			hsync_polarity = 1;
-
-		if (adv7511->vsync_polarity != mode_vsync_polarity &&
-		    adv7511->vsync_polarity !=
-		    ADV7511_SYNC_POLARITY_PASSTHROUGH)
-			vsync_polarity = 1;
-	}
-
-	if (mode->vrefresh <= 24000)
-		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_24HZ;
-	else if (mode->vrefresh <= 25000)
-		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_25HZ;
-	else if (mode->vrefresh <= 30000)
-		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_30HZ;
-	else
-		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_NONE;
-
-	regmap_update_bits(adv7511->regmap, 0xfb,
-		0x6, low_refresh_rate << 1);
-	regmap_update_bits(adv7511->regmap, 0x17,
-		0x60, (vsync_polarity << 6) | (hsync_polarity << 5));
-
-	/*
-	 * TODO Test first order 4:2:2 to 4:4:4 up conversion method, which is
-	 * supposed to give better results.
-	 */
-
-	adv7511->f_tmds = mode->clock;
-}
-
-static const struct drm_encoder_slave_funcs adv7511_encoder_funcs = {
-	.dpms = adv7511_encoder_dpms,
-	.mode_valid = adv7511_encoder_mode_valid,
-	.mode_set = adv7511_encoder_mode_set,
-	.detect = adv7511_encoder_detect,
-	.get_modes = adv7511_get_modes,
-};
-
-/* -----------------------------------------------------------------------------
- * Probe & remove
- */
-
-static int adv7511_parse_dt(struct device_node *np,
-			    struct adv7511_link_config *config)
-{
-	const char *str;
-	int ret;
-
-	memset(config, 0, sizeof(*config));
-
-	of_property_read_u32(np, "adi,input-depth", &config->input_color_depth);
-	if (config->input_color_depth != 8 && config->input_color_depth != 10 &&
-	    config->input_color_depth != 12)
-		return -EINVAL;
-
-	ret = of_property_read_string(np, "adi,input-colorspace", &str);
-	if (ret < 0)
-		return ret;
-
-	if (!strcmp(str, "rgb"))
-		config->input_colorspace = HDMI_COLORSPACE_RGB;
-	else if (!strcmp(str, "yuv422"))
-		config->input_colorspace = HDMI_COLORSPACE_YUV422;
-	else if (!strcmp(str, "yuv444"))
-		config->input_colorspace = HDMI_COLORSPACE_YUV444;
-	else
-		return -EINVAL;
-
-	ret = of_property_read_string(np, "adi,input-clock", &str);
-	if (ret < 0)
-		return ret;
-
-	if (!strcmp(str, "1x"))
-		config->input_clock = ADV7511_INPUT_CLOCK_1X;
-	else if (!strcmp(str, "2x"))
-		config->input_clock = ADV7511_INPUT_CLOCK_2X;
-	else if (!strcmp(str, "ddr"))
-		config->input_clock = ADV7511_INPUT_CLOCK_DDR;
-	else
-		return -EINVAL;
-
-	if (config->input_colorspace == HDMI_COLORSPACE_YUV422 ||
-	    config->input_clock != ADV7511_INPUT_CLOCK_1X) {
-		ret = of_property_read_u32(np, "adi,input-style",
-					   &config->input_style);
-		if (ret)
-			return ret;
-
-		if (config->input_style < 1 || config->input_style > 3)
-			return -EINVAL;
-
-		ret = of_property_read_string(np, "adi,input-justification",
-					      &str);
-		if (ret < 0)
-			return ret;
-
-		if (!strcmp(str, "left"))
-			config->input_justification =
-				ADV7511_INPUT_JUSTIFICATION_LEFT;
-		else if (!strcmp(str, "evenly"))
-			config->input_justification =
-				ADV7511_INPUT_JUSTIFICATION_EVENLY;
-		else if (!strcmp(str, "right"))
-			config->input_justification =
-				ADV7511_INPUT_JUSTIFICATION_RIGHT;
-		else
-			return -EINVAL;
-
-	} else {
-		config->input_style = 1;
-		config->input_justification = ADV7511_INPUT_JUSTIFICATION_LEFT;
-	}
-
-	of_property_read_u32(np, "adi,clock-delay", &config->clock_delay);
-	if (config->clock_delay < -1200 || config->clock_delay > 1600)
-		return -EINVAL;
-
-	config->embedded_sync = of_property_read_bool(np, "adi,embedded-sync");
-
-	/* Hardcode the sync pulse configurations for now. */
-	config->sync_pulse = ADV7511_INPUT_SYNC_PULSE_NONE;
-	config->vsync_polarity = ADV7511_SYNC_POLARITY_PASSTHROUGH;
-	config->hsync_polarity = ADV7511_SYNC_POLARITY_PASSTHROUGH;
-
-	return 0;
-}
-
-static const int edid_i2c_addr = 0x7e;
-static const int packet_i2c_addr = 0x70;
-static const int cec_i2c_addr = 0x78;
-
-static int adv7511_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
-{
-	struct adv7511_link_config link_config;
-	struct adv7511 *adv7511;
-	struct device *dev = &i2c->dev;
-	unsigned int val;
-	int ret;
-
-	if (!dev->of_node)
-		return -EINVAL;
-
-	adv7511 = devm_kzalloc(dev, sizeof(*adv7511), GFP_KERNEL);
-	if (!adv7511)
-		return -ENOMEM;
-
-	adv7511->powered = false;
-	adv7511->status = connector_status_disconnected;
-
-	ret = adv7511_parse_dt(dev->of_node, &link_config);
-	if (ret)
-		return ret;
-
-	/*
-	 * The power down GPIO is optional. If present, toggle it from active to
-	 * inactive to wake up the encoder.
-	 */
-	adv7511->gpio_pd = devm_gpiod_get_optional(dev, "pd", GPIOD_OUT_HIGH);
-	if (IS_ERR(adv7511->gpio_pd))
-		return PTR_ERR(adv7511->gpio_pd);
-
-	if (adv7511->gpio_pd) {
-		mdelay(5);
-		gpiod_set_value_cansleep(adv7511->gpio_pd, 0);
-	}
-
-	adv7511->regmap = devm_regmap_init_i2c(i2c, &adv7511_regmap_config);
-	if (IS_ERR(adv7511->regmap))
-		return PTR_ERR(adv7511->regmap);
-
-	ret = regmap_read(adv7511->regmap, ADV7511_REG_CHIP_REVISION, &val);
-	if (ret)
-		return ret;
-	dev_dbg(dev, "Rev. %d\n", val);
-
-	ret = regmap_register_patch(adv7511->regmap, adv7511_fixed_registers,
-				    ARRAY_SIZE(adv7511_fixed_registers));
-	if (ret)
-		return ret;
-
-	regmap_write(adv7511->regmap, ADV7511_REG_EDID_I2C_ADDR, edid_i2c_addr);
-	regmap_write(adv7511->regmap, ADV7511_REG_PACKET_I2C_ADDR,
-		     packet_i2c_addr);
-	regmap_write(adv7511->regmap, ADV7511_REG_CEC_I2C_ADDR, cec_i2c_addr);
-	adv7511_packet_disable(adv7511, 0xffff);
-
-	adv7511->i2c_main = i2c;
-	adv7511->i2c_edid = i2c_new_dummy(i2c->adapter, edid_i2c_addr >> 1);
-	if (!adv7511->i2c_edid)
-		return -ENOMEM;
-
-	if (i2c->irq) {
-		init_waitqueue_head(&adv7511->wq);
-
-		ret = devm_request_threaded_irq(dev, i2c->irq, NULL,
-						adv7511_irq_handler,
-						IRQF_ONESHOT, dev_name(dev),
-						adv7511);
-		if (ret)
-			goto err_i2c_unregister_device;
-	}
-
-	/* CEC is unused for now */
-	regmap_write(adv7511->regmap, ADV7511_REG_CEC_CTRL,
-		     ADV7511_CEC_CTRL_POWER_DOWN);
-
-	adv7511_power_off(adv7511);
-
-	i2c_set_clientdata(i2c, adv7511);
-
-	adv7511_set_link_config(adv7511, &link_config);
-
-	return 0;
-
-err_i2c_unregister_device:
-	i2c_unregister_device(adv7511->i2c_edid);
-
-	return ret;
-}
-
-static int adv7511_remove(struct i2c_client *i2c)
-{
-	struct adv7511 *adv7511 = i2c_get_clientdata(i2c);
-
-	i2c_unregister_device(adv7511->i2c_edid);
-
-	kfree(adv7511->edid);
-
-	return 0;
-}
-
-static int adv7511_encoder_init(struct i2c_client *i2c, struct drm_device *dev,
-				struct drm_encoder_slave *encoder)
-{
-
-	struct adv7511 *adv7511 = i2c_get_clientdata(i2c);
-
-	encoder->slave_priv = adv7511;
-	encoder->slave_funcs = &adv7511_encoder_funcs;
-
-	adv7511->encoder = &encoder->base;
-
-	return 0;
-}
-
-static const struct i2c_device_id adv7511_i2c_ids[] = {
-	{ "adv7511", 0 },
-	{ "adv7511w", 0 },
-	{ "adv7513", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, adv7511_i2c_ids);
-
-static const struct of_device_id adv7511_of_ids[] = {
-	{ .compatible = "adi,adv7511", },
-	{ .compatible = "adi,adv7511w", },
-	{ .compatible = "adi,adv7513", },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, adv7511_of_ids);
-
-static struct drm_i2c_encoder_driver adv7511_driver = {
-	.i2c_driver = {
-		.driver = {
-			.name = "adv7511",
-			.of_match_table = adv7511_of_ids,
-		},
-		.id_table = adv7511_i2c_ids,
-		.probe = adv7511_probe,
-		.remove = adv7511_remove,
-	},
-
-	.encoder_init = adv7511_encoder_init,
-};
-
-static int __init adv7511_init(void)
-{
-	return drm_i2c_encoder_register(THIS_MODULE, &adv7511_driver);
-}
-module_init(adv7511_init);
-
-static void __exit adv7511_exit(void)
-{
-	drm_i2c_encoder_unregister(&adv7511_driver);
-}
-module_exit(adv7511_exit);
-
-MODULE_AUTHOR("Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>");
-MODULE_DESCRIPTION("ADV7511 HDMI transmitter driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/i2c/adv7511.h b/drivers/gpu/drm/i2c/adv7511.h
index 38515b3..fccb86e 100644
--- a/drivers/gpu/drm/i2c/adv7511.h
+++ b/drivers/gpu/drm/i2c/adv7511.h
@@ -10,6 +10,8 @@
 #define __DRM_I2C_ADV7511_H__
 
 #include <linux/hdmi.h>
+#include <linux/gpio/consumer.h>
+#include <drm/drmP.h>
 
 #define ADV7511_REG_CHIP_REVISION		0x00
 #define ADV7511_REG_N0				0x01
@@ -286,4 +288,43 @@ struct adv7511_video_config {
 	struct hdmi_avi_infoframe avi_infoframe;
 };
 
+struct adv7511 {
+	struct i2c_client *i2c_main;
+	struct i2c_client *i2c_edid;
+
+	struct regmap *regmap;
+	struct regmap *packet_memory_regmap;
+	enum drm_connector_status status;
+	bool powered;
+
+	unsigned int f_tmds;
+	unsigned int f_audio;
+
+	unsigned int audio_source;
+
+	unsigned int current_edid_segment;
+	uint8_t edid_buf[256];
+	bool edid_read;
+
+	wait_queue_head_t wq;
+	struct drm_encoder *encoder;
+
+	bool embedded_sync;
+	enum adv7511_sync_polarity vsync_polarity;
+	enum adv7511_sync_polarity hsync_polarity;
+	bool rgb;
+
+	struct edid *edid;
+
+	struct gpio_desc *gpio_pd;
+};
+
+int adv7511_packet_enable(struct adv7511 *adv7511, unsigned int packet);
+int adv7511_packet_disable(struct adv7511 *adv7511, unsigned int packet);
+
+#ifdef CONFIG_DRM_I2C_ADV7511_AUDIO
+int adv7511_audio_init(struct device *dev);
+void adv7511_audio_exit(struct device *dev);
+#endif
+
 #endif /* __DRM_I2C_ADV7511_H__ */
diff --git a/drivers/gpu/drm/i2c/adv7511_audio.c b/drivers/gpu/drm/i2c/adv7511_audio.c
new file mode 100644
index 0000000..5562ed5
--- /dev/null
+++ b/drivers/gpu/drm/i2c/adv7511_audio.c
@@ -0,0 +1,310 @@
+/*
+ * Analog Devices ADV7511 HDMI transmitter driver
+ *
+ * Copyright 2012 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/i2c.h>
+#include <linux/spi/spi.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+
+#include "adv7511.h"
+
+static const struct snd_soc_dapm_widget adv7511_dapm_widgets[] = {
+	SND_SOC_DAPM_OUTPUT("TMDS"),
+	SND_SOC_DAPM_AIF_IN("AIFIN", "Playback", 0, SND_SOC_NOPM, 0, 0),
+};
+
+static const struct snd_soc_dapm_route adv7511_routes[] = {
+	{ "TMDS", NULL, "AIFIN" },
+};
+
+static void adv7511_calc_cts_n(unsigned int f_tmds, unsigned int fs,
+			       unsigned int *cts, unsigned int *n)
+{
+	switch (fs) {
+	case 32000:
+		*n = 4096;
+		break;
+	case 44100:
+		*n = 6272;
+		break;
+	case 48000:
+		*n = 6144;
+		break;
+	}
+
+	*cts = ((f_tmds * *n) / (128 * fs)) * 1000;
+}
+
+static int adv7511_update_cts_n(struct adv7511 *adv7511)
+{
+	unsigned int cts = 0;
+	unsigned int n = 0;
+
+	adv7511_calc_cts_n(adv7511->f_tmds, adv7511->f_audio, &cts, &n);
+
+	regmap_write(adv7511->regmap, ADV7511_REG_N0, (n >> 16) & 0xf);
+	regmap_write(adv7511->regmap, ADV7511_REG_N1, (n >> 8) & 0xff);
+	regmap_write(adv7511->regmap, ADV7511_REG_N2, n & 0xff);
+
+	regmap_write(adv7511->regmap, ADV7511_REG_CTS_MANUAL0,
+		     (cts >> 16) & 0xf);
+	regmap_write(adv7511->regmap, ADV7511_REG_CTS_MANUAL1,
+		     (cts >> 8) & 0xff);
+	regmap_write(adv7511->regmap, ADV7511_REG_CTS_MANUAL2,
+		     cts & 0xff);
+
+	return 0;
+}
+
+static int adv7511_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_codec *codec = rtd->codec;
+	struct adv7511 *adv7511 = snd_soc_codec_get_drvdata(codec);
+	unsigned int rate;
+	unsigned int len;
+
+	switch (params_rate(params)) {
+	case 32000:
+		rate = ADV7511_SAMPLE_FREQ_32000;
+		break;
+	case 44100:
+		rate = ADV7511_SAMPLE_FREQ_44100;
+		break;
+	case 48000:
+		rate = ADV7511_SAMPLE_FREQ_48000;
+		break;
+	case 88200:
+		rate = ADV7511_SAMPLE_FREQ_88200;
+		break;
+	case 96000:
+		rate = ADV7511_SAMPLE_FREQ_96000;
+		break;
+	case 176400:
+		rate = ADV7511_SAMPLE_FREQ_176400;
+		break;
+	case 192000:
+		rate = ADV7511_SAMPLE_FREQ_192000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		len = ADV7511_I2S_SAMPLE_LEN_16;
+		break;
+	case SNDRV_PCM_FORMAT_S18_3LE:
+		len = ADV7511_I2S_SAMPLE_LEN_18;
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		len = ADV7511_I2S_SAMPLE_LEN_20;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		len = ADV7511_I2S_SAMPLE_LEN_24;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	adv7511->f_audio = params_rate(params);
+
+	adv7511_update_cts_n(adv7511);
+
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_AUDIO_CFG3,
+			   ADV7511_AUDIO_CFG3_LEN_MASK, len);
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_I2C_FREQ_ID_CFG,
+			   ADV7511_I2C_FREQ_ID_CFG_RATE_MASK, rate << 4);
+
+	return 0;
+}
+
+static int adv7511_set_dai_fmt(struct snd_soc_dai *codec_dai,
+			       unsigned int fmt)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct adv7511 *adv7511 = snd_soc_codec_get_drvdata(codec);
+	unsigned int audio_source, i2s_format = 0;
+	unsigned int invert_clock;
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		audio_source = ADV7511_AUDIO_SOURCE_I2S;
+		i2s_format = ADV7511_I2S_FORMAT_I2S;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		audio_source = ADV7511_AUDIO_SOURCE_I2S;
+		i2s_format = ADV7511_I2S_FORMAT_RIGHT_J;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		audio_source = ADV7511_AUDIO_SOURCE_I2S;
+		i2s_format = ADV7511_I2S_FORMAT_LEFT_J;
+		break;
+	case SND_SOC_DAIFMT_SPDIF:
+		audio_source = ADV7511_AUDIO_SOURCE_SPDIF;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		invert_clock = 0;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		invert_clock = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_AUDIO_SOURCE, 0x70,
+			   audio_source << 4);
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_AUDIO_CONFIG, BIT(6),
+			   invert_clock << 6);
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_I2S_CONFIG, 0x03,
+			   i2s_format);
+
+	adv7511->audio_source = audio_source;
+
+	return 0;
+}
+
+static int adv7511_set_bias_level(struct snd_soc_codec *codec,
+				  enum snd_soc_bias_level level)
+{
+	struct adv7511 *adv7511 = snd_soc_codec_get_drvdata(codec);
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		switch (adv7511->audio_source) {
+		case ADV7511_AUDIO_SOURCE_I2S:
+			break;
+		case ADV7511_AUDIO_SOURCE_SPDIF:
+			regmap_update_bits(adv7511->regmap,
+					   ADV7511_REG_AUDIO_CONFIG, BIT(7),
+					   BIT(7));
+			break;
+		}
+		break;
+	case SND_SOC_BIAS_PREPARE:
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_STANDBY) {
+			adv7511_packet_enable(adv7511,
+					ADV7511_PACKET_ENABLE_AUDIO_SAMPLE);
+			adv7511_packet_enable(adv7511,
+					ADV7511_PACKET_ENABLE_AUDIO_INFOFRAME);
+			adv7511_packet_enable(adv7511,
+					ADV7511_PACKET_ENABLE_N_CTS);
+		} else {
+			adv7511_packet_disable(adv7511,
+					ADV7511_PACKET_ENABLE_AUDIO_SAMPLE);
+			adv7511_packet_disable(adv7511,
+					ADV7511_PACKET_ENABLE_AUDIO_INFOFRAME);
+			adv7511_packet_disable(adv7511,
+					ADV7511_PACKET_ENABLE_N_CTS);
+		}
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		regmap_update_bits(adv7511->regmap, ADV7511_REG_AUDIO_CONFIG,
+				   BIT(7), 0);
+		break;
+	case SND_SOC_BIAS_OFF:
+		break;
+	}
+	return 0;
+}
+
+#define ADV7511_RATES (SNDRV_PCM_RATE_32000 |\
+		SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |\
+		SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |\
+		SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_192000)
+
+#define ADV7511_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S18_3LE |\
+		SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S24_LE)
+
+static const struct snd_soc_dai_ops adv7511_dai_ops = {
+	.hw_params	= adv7511_hw_params,
+	/*.set_sysclk	= adv7511_set_dai_sysclk,*/
+	.set_fmt	= adv7511_set_dai_fmt,
+};
+
+static struct snd_soc_dai_driver adv7511_dai = {
+	.name = "adv7511",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = ADV7511_RATES,
+		.formats = ADV7511_FORMATS,
+	},
+	.ops = &adv7511_dai_ops,
+};
+
+static int adv7511_suspend(struct snd_soc_codec *codec)
+{
+	return adv7511_set_bias_level(codec, SND_SOC_BIAS_OFF);
+}
+
+static int adv7511_resume(struct snd_soc_codec *codec)
+{
+	return adv7511_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+}
+
+static int adv7511_probe(struct snd_soc_codec *codec)
+{
+	return adv7511_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+}
+
+static int adv7511_remove(struct snd_soc_codec *codec)
+{
+	adv7511_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	return 0;
+}
+
+static struct snd_soc_codec_driver adv7511_codec_driver = {
+	.probe		    = adv7511_probe,
+	.remove		    = adv7511_remove,
+	.suspend	    = adv7511_suspend,
+	.resume		    = adv7511_resume,
+	.set_bias_level	    = adv7511_set_bias_level,
+
+	.dapm_widgets	    = adv7511_dapm_widgets,
+	.num_dapm_widgets   = ARRAY_SIZE(adv7511_dapm_widgets),
+	.dapm_routes	    = adv7511_routes,
+	.num_dapm_routes    = ARRAY_SIZE(adv7511_routes),
+};
+
+int adv7511_audio_init(struct device *dev)
+{
+	return snd_soc_register_codec(dev, &adv7511_codec_driver,
+			&adv7511_dai, 1);
+}
+
+void adv7511_audio_exit(struct device *dev)
+{
+	snd_soc_unregister_codec(dev);
+}
diff --git a/drivers/gpu/drm/i2c/adv7511_core.c b/drivers/gpu/drm/i2c/adv7511_core.c
new file mode 100644
index 0000000..d54256a
--- /dev/null
+++ b/drivers/gpu/drm/i2c/adv7511_core.c
@@ -0,0 +1,1005 @@
+/*
+ * Analog Devices ADV7511 HDMI transmitter driver
+ *
+ * Copyright 2012 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#include <drm/drmP.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_edid.h>
+#include <drm/drm_encoder_slave.h>
+
+#include "adv7511.h"
+
+static struct adv7511 *encoder_to_adv7511(struct drm_encoder *encoder)
+{
+	return to_encoder_slave(encoder)->slave_priv;
+}
+
+/* ADI recommended values for proper operation. */
+static const struct reg_sequence adv7511_fixed_registers[] = {
+	{ 0x98, 0x03 },
+	{ 0x9a, 0xe0 },
+	{ 0x9c, 0x30 },
+	{ 0x9d, 0x61 },
+	{ 0xa2, 0xa4 },
+	{ 0xa3, 0xa4 },
+	{ 0xe0, 0xd0 },
+	{ 0xf9, 0x00 },
+	{ 0x55, 0x02 },
+};
+
+/* -----------------------------------------------------------------------------
+ * Register access
+ */
+
+static const uint8_t adv7511_register_defaults[] = {
+	0x12, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 00 */
+	0x00, 0x00, 0x01, 0x0e, 0xbc, 0x18, 0x01, 0x13,
+	0x25, 0x37, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 10 */
+	0x46, 0x62, 0x04, 0xa8, 0x00, 0x00, 0x1c, 0x84,
+	0x1c, 0xbf, 0x04, 0xa8, 0x1e, 0x70, 0x02, 0x1e, /* 20 */
+	0x00, 0x00, 0x04, 0xa8, 0x08, 0x12, 0x1b, 0xac,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 30 */
+	0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x00, 0xb0,
+	0x00, 0x50, 0x90, 0x7e, 0x79, 0x70, 0x00, 0x00, /* 40 */
+	0x00, 0xa8, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x02, 0x0d, 0x00, 0x00, 0x00, 0x00, /* 50 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 60 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x01, 0x0a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 70 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 80 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0xc0, 0x00, 0x00, 0x00, /* 90 */
+	0x0b, 0x02, 0x00, 0x18, 0x5a, 0x60, 0x00, 0x00,
+	0x00, 0x00, 0x80, 0x80, 0x08, 0x04, 0x00, 0x00, /* a0 */
+	0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x40, 0x14,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* b0 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* c0 */
+	0x00, 0x03, 0x00, 0x00, 0x02, 0x00, 0x01, 0x04,
+	0x30, 0xff, 0x80, 0x80, 0x80, 0x00, 0x00, 0x00, /* d0 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x01,
+	0x80, 0x75, 0x00, 0x00, 0x60, 0x00, 0x00, 0x00, /* e0 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x75, 0x11, 0x00, /* f0 */
+	0x00, 0x7c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static bool adv7511_register_volatile(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case ADV7511_REG_CHIP_REVISION:
+	case ADV7511_REG_SPDIF_FREQ:
+	case ADV7511_REG_CTS_AUTOMATIC1:
+	case ADV7511_REG_CTS_AUTOMATIC2:
+	case ADV7511_REG_VIC_DETECTED:
+	case ADV7511_REG_VIC_SEND:
+	case ADV7511_REG_AUX_VIC_DETECTED:
+	case ADV7511_REG_STATUS:
+	case ADV7511_REG_GC(1):
+	case ADV7511_REG_INT(0):
+	case ADV7511_REG_INT(1):
+	case ADV7511_REG_PLL_STATUS:
+	case ADV7511_REG_AN(0):
+	case ADV7511_REG_AN(1):
+	case ADV7511_REG_AN(2):
+	case ADV7511_REG_AN(3):
+	case ADV7511_REG_AN(4):
+	case ADV7511_REG_AN(5):
+	case ADV7511_REG_AN(6):
+	case ADV7511_REG_AN(7):
+	case ADV7511_REG_HDCP_STATUS:
+	case ADV7511_REG_BCAPS:
+	case ADV7511_REG_BKSV(0):
+	case ADV7511_REG_BKSV(1):
+	case ADV7511_REG_BKSV(2):
+	case ADV7511_REG_BKSV(3):
+	case ADV7511_REG_BKSV(4):
+	case ADV7511_REG_DDC_STATUS:
+	case ADV7511_REG_EDID_READ_CTRL:
+	case ADV7511_REG_BSTATUS(0):
+	case ADV7511_REG_BSTATUS(1):
+	case ADV7511_REG_CHIP_ID_HIGH:
+	case ADV7511_REG_CHIP_ID_LOW:
+		return true;
+	}
+
+	return false;
+}
+
+static const struct regmap_config adv7511_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = 0xff,
+	.cache_type = REGCACHE_RBTREE,
+	.reg_defaults_raw = adv7511_register_defaults,
+	.num_reg_defaults_raw = ARRAY_SIZE(adv7511_register_defaults),
+
+	.volatile_reg = adv7511_register_volatile,
+};
+
+/* -----------------------------------------------------------------------------
+ * Hardware configuration
+ */
+
+static void adv7511_set_colormap(struct adv7511 *adv7511, bool enable,
+				 const uint16_t *coeff,
+				 unsigned int scaling_factor)
+{
+	unsigned int i;
+
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_CSC_UPPER(1),
+			   ADV7511_CSC_UPDATE_MODE, ADV7511_CSC_UPDATE_MODE);
+
+	if (enable) {
+		for (i = 0; i < 12; ++i) {
+			regmap_update_bits(adv7511->regmap,
+					   ADV7511_REG_CSC_UPPER(i),
+					   0x1f, coeff[i] >> 8);
+			regmap_write(adv7511->regmap,
+				     ADV7511_REG_CSC_LOWER(i),
+				     coeff[i] & 0xff);
+		}
+	}
+
+	if (enable)
+		regmap_update_bits(adv7511->regmap, ADV7511_REG_CSC_UPPER(0),
+				   0xe0, 0x80 | (scaling_factor << 5));
+	else
+		regmap_update_bits(adv7511->regmap, ADV7511_REG_CSC_UPPER(0),
+				   0x80, 0x00);
+
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_CSC_UPPER(1),
+			   ADV7511_CSC_UPDATE_MODE, 0);
+}
+
+int adv7511_packet_enable(struct adv7511 *adv7511, unsigned int packet)
+{
+	if (packet & 0xff)
+		regmap_update_bits(adv7511->regmap, ADV7511_REG_PACKET_ENABLE0,
+				   packet, 0xff);
+
+	if (packet & 0xff00) {
+		packet >>= 8;
+		regmap_update_bits(adv7511->regmap, ADV7511_REG_PACKET_ENABLE1,
+				   packet, 0xff);
+	}
+
+	return 0;
+}
+
+int adv7511_packet_disable(struct adv7511 *adv7511, unsigned int packet)
+{
+	if (packet & 0xff)
+		regmap_update_bits(adv7511->regmap, ADV7511_REG_PACKET_ENABLE0,
+				   packet, 0x00);
+
+	if (packet & 0xff00) {
+		packet >>= 8;
+		regmap_update_bits(adv7511->regmap, ADV7511_REG_PACKET_ENABLE1,
+				   packet, 0x00);
+	}
+
+	return 0;
+}
+
+/* Coefficients for adv7511 color space conversion */
+static const uint16_t adv7511_csc_ycbcr_to_rgb[] = {
+	0x0734, 0x04ad, 0x0000, 0x1c1b,
+	0x1ddc, 0x04ad, 0x1f24, 0x0135,
+	0x0000, 0x04ad, 0x087c, 0x1b77,
+};
+
+static void adv7511_set_config_csc(struct adv7511 *adv7511,
+				   struct drm_connector *connector,
+				   bool rgb)
+{
+	struct adv7511_video_config config;
+	bool output_format_422, output_format_ycbcr;
+	unsigned int mode;
+	uint8_t infoframe[17];
+
+	if (adv7511->edid)
+		config.hdmi_mode = drm_detect_hdmi_monitor(adv7511->edid);
+	else
+		config.hdmi_mode = false;
+
+	hdmi_avi_infoframe_init(&config.avi_infoframe);
+
+	config.avi_infoframe.scan_mode = HDMI_SCAN_MODE_UNDERSCAN;
+
+	if (rgb) {
+		config.csc_enable = false;
+		config.avi_infoframe.colorspace = HDMI_COLORSPACE_RGB;
+	} else {
+		config.csc_scaling_factor = ADV7511_CSC_SCALING_4;
+		config.csc_coefficents = adv7511_csc_ycbcr_to_rgb;
+
+		if ((connector->display_info.color_formats &
+		     DRM_COLOR_FORMAT_YCRCB422) &&
+		    config.hdmi_mode) {
+			config.csc_enable = false;
+			config.avi_infoframe.colorspace =
+				HDMI_COLORSPACE_YUV422;
+		} else {
+			config.csc_enable = true;
+			config.avi_infoframe.colorspace = HDMI_COLORSPACE_RGB;
+		}
+	}
+
+	if (config.hdmi_mode) {
+		mode = ADV7511_HDMI_CFG_MODE_HDMI;
+
+		switch (config.avi_infoframe.colorspace) {
+		case HDMI_COLORSPACE_YUV444:
+			output_format_422 = false;
+			output_format_ycbcr = true;
+			break;
+		case HDMI_COLORSPACE_YUV422:
+			output_format_422 = true;
+			output_format_ycbcr = true;
+			break;
+		default:
+			output_format_422 = false;
+			output_format_ycbcr = false;
+			break;
+		}
+	} else {
+		mode = ADV7511_HDMI_CFG_MODE_DVI;
+		output_format_422 = false;
+		output_format_ycbcr = false;
+	}
+
+	adv7511_packet_disable(adv7511, ADV7511_PACKET_ENABLE_AVI_INFOFRAME);
+
+	adv7511_set_colormap(adv7511, config.csc_enable,
+			     config.csc_coefficents,
+			     config.csc_scaling_factor);
+
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_VIDEO_INPUT_CFG1, 0x81,
+			   (output_format_422 << 7) | output_format_ycbcr);
+
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_HDCP_HDMI_CFG,
+			   ADV7511_HDMI_CFG_MODE_MASK, mode);
+
+	hdmi_avi_infoframe_pack(&config.avi_infoframe, infoframe,
+				sizeof(infoframe));
+
+	/* The AVI infoframe id is not configurable */
+	regmap_bulk_write(adv7511->regmap, ADV7511_REG_AVI_INFOFRAME_VERSION,
+			  infoframe + 1, sizeof(infoframe) - 1);
+
+	adv7511_packet_enable(adv7511, ADV7511_PACKET_ENABLE_AVI_INFOFRAME);
+}
+
+static void adv7511_set_link_config(struct adv7511 *adv7511,
+				    const struct adv7511_link_config *config)
+{
+	/*
+	 * The input style values documented in the datasheet don't match the
+	 * hardware register field values :-(
+	 */
+	static const unsigned int input_styles[4] = { 0, 2, 1, 3 };
+
+	unsigned int clock_delay;
+	unsigned int color_depth;
+	unsigned int input_id;
+
+	clock_delay = (config->clock_delay + 1200) / 400;
+	color_depth = config->input_color_depth == 8 ? 3
+		    : (config->input_color_depth == 10 ? 1 : 2);
+
+	/* TODO Support input ID 6 */
+	if (config->input_colorspace != HDMI_COLORSPACE_YUV422)
+		input_id = config->input_clock == ADV7511_INPUT_CLOCK_DDR
+			 ? 5 : 0;
+	else if (config->input_clock == ADV7511_INPUT_CLOCK_DDR)
+		input_id = config->embedded_sync ? 8 : 7;
+	else if (config->input_clock == ADV7511_INPUT_CLOCK_2X)
+		input_id = config->embedded_sync ? 4 : 3;
+	else
+		input_id = config->embedded_sync ? 2 : 1;
+
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_I2C_FREQ_ID_CFG, 0xf,
+			   input_id);
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_VIDEO_INPUT_CFG1, 0x7e,
+			   (color_depth << 4) |
+			   (input_styles[config->input_style] << 2));
+	regmap_write(adv7511->regmap, ADV7511_REG_VIDEO_INPUT_CFG2,
+		     config->input_justification << 3);
+	regmap_write(adv7511->regmap, ADV7511_REG_TIMING_GEN_SEQ,
+		     config->sync_pulse << 2);
+
+	regmap_write(adv7511->regmap, 0xba, clock_delay << 5);
+
+	adv7511->embedded_sync = config->embedded_sync;
+	adv7511->hsync_polarity = config->hsync_polarity;
+	adv7511->vsync_polarity = config->vsync_polarity;
+	adv7511->rgb = config->input_colorspace == HDMI_COLORSPACE_RGB;
+}
+
+static void adv7511_power_on(struct adv7511 *adv7511)
+{
+	adv7511->current_edid_segment = -1;
+
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER,
+			   ADV7511_POWER_POWER_DOWN, 0);
+	if (adv7511->i2c_main->irq) {
+		/*
+		 * Documentation says the INT_ENABLE registers are reset in
+		 * POWER_DOWN mode. My 7511w preserved the bits, however.
+		 * Still, let's be safe and stick to the documentation.
+		 */
+		regmap_write(adv7511->regmap, ADV7511_REG_INT_ENABLE(0),
+			     ADV7511_INT0_EDID_READY);
+		regmap_write(adv7511->regmap, ADV7511_REG_INT_ENABLE(1),
+			     ADV7511_INT1_DDC_ERROR);
+	}
+
+	/*
+	 * Per spec it is allowed to pulse the HPD signal to indicate that the
+	 * EDID information has changed. Some monitors do this when they wakeup
+	 * from standby or are enabled. When the HPD goes low the adv7511 is
+	 * reset and the outputs are disabled which might cause the monitor to
+	 * go to standby again. To avoid this we ignore the HPD pin for the
+	 * first few seconds after enabling the output.
+	 */
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER2,
+			   ADV7511_REG_POWER2_HPD_SRC_MASK,
+			   ADV7511_REG_POWER2_HPD_SRC_NONE);
+
+	/*
+	 * Most of the registers are reset during power down or when HPD is low.
+	 */
+	regcache_sync(adv7511->regmap);
+
+	adv7511->powered = true;
+}
+
+static void adv7511_power_off(struct adv7511 *adv7511)
+{
+	/* TODO: setup additional power down modes */
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER,
+			   ADV7511_POWER_POWER_DOWN,
+			   ADV7511_POWER_POWER_DOWN);
+	regcache_mark_dirty(adv7511->regmap);
+
+	adv7511->powered = false;
+}
+
+/* -----------------------------------------------------------------------------
+ * Interrupt and hotplug detection
+ */
+
+static bool adv7511_hpd(struct adv7511 *adv7511)
+{
+	unsigned int irq0;
+	int ret;
+
+	ret = regmap_read(adv7511->regmap, ADV7511_REG_INT(0), &irq0);
+	if (ret < 0)
+		return false;
+
+	if (irq0 & ADV7511_INT0_HPD) {
+		regmap_write(adv7511->regmap, ADV7511_REG_INT(0),
+			     ADV7511_INT0_HPD);
+		return true;
+	}
+
+	return false;
+}
+
+static int adv7511_irq_process(struct adv7511 *adv7511)
+{
+	unsigned int irq0, irq1;
+	int ret;
+
+	ret = regmap_read(adv7511->regmap, ADV7511_REG_INT(0), &irq0);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_read(adv7511->regmap, ADV7511_REG_INT(1), &irq1);
+	if (ret < 0)
+		return ret;
+
+	regmap_write(adv7511->regmap, ADV7511_REG_INT(0), irq0);
+	regmap_write(adv7511->regmap, ADV7511_REG_INT(1), irq1);
+
+	if (irq0 & ADV7511_INT0_HPD && adv7511->encoder)
+		drm_helper_hpd_irq_event(adv7511->encoder->dev);
+
+	if (irq0 & ADV7511_INT0_EDID_READY || irq1 & ADV7511_INT1_DDC_ERROR) {
+		adv7511->edid_read = true;
+
+		if (adv7511->i2c_main->irq)
+			wake_up_all(&adv7511->wq);
+	}
+
+	return 0;
+}
+
+static irqreturn_t adv7511_irq_handler(int irq, void *devid)
+{
+	struct adv7511 *adv7511 = devid;
+	int ret;
+
+	ret = adv7511_irq_process(adv7511);
+	return ret < 0 ? IRQ_NONE : IRQ_HANDLED;
+}
+
+/* -----------------------------------------------------------------------------
+ * EDID retrieval
+ */
+
+static int adv7511_wait_for_edid(struct adv7511 *adv7511, int timeout)
+{
+	int ret;
+
+	if (adv7511->i2c_main->irq) {
+		ret = wait_event_interruptible_timeout(adv7511->wq,
+				adv7511->edid_read, msecs_to_jiffies(timeout));
+	} else {
+		for (; timeout > 0; timeout -= 25) {
+			ret = adv7511_irq_process(adv7511);
+			if (ret < 0)
+				break;
+
+			if (adv7511->edid_read)
+				break;
+
+			msleep(25);
+		}
+	}
+
+	return adv7511->edid_read ? 0 : -EIO;
+}
+
+static int adv7511_get_edid_block(void *data, u8 *buf, unsigned int block,
+				  size_t len)
+{
+	struct adv7511 *adv7511 = data;
+	struct i2c_msg xfer[2];
+	uint8_t offset;
+	unsigned int i;
+	int ret;
+
+	if (len > 128)
+		return -EINVAL;
+
+	if (adv7511->current_edid_segment != block / 2) {
+		unsigned int status;
+
+		ret = regmap_read(adv7511->regmap, ADV7511_REG_DDC_STATUS,
+				  &status);
+		if (ret < 0)
+			return ret;
+
+		if (status != 2) {
+			adv7511->edid_read = false;
+			regmap_write(adv7511->regmap, ADV7511_REG_EDID_SEGMENT,
+				     block);
+			ret = adv7511_wait_for_edid(adv7511, 200);
+			if (ret < 0)
+				return ret;
+		}
+
+		/* Break this apart, hopefully more I2C controllers will
+		 * support 64 byte transfers than 256 byte transfers
+		 */
+
+		xfer[0].addr = adv7511->i2c_edid->addr;
+		xfer[0].flags = 0;
+		xfer[0].len = 1;
+		xfer[0].buf = &offset;
+		xfer[1].addr = adv7511->i2c_edid->addr;
+		xfer[1].flags = I2C_M_RD;
+		xfer[1].len = 64;
+		xfer[1].buf = adv7511->edid_buf;
+
+		offset = 0;
+
+		for (i = 0; i < 4; ++i) {
+			ret = i2c_transfer(adv7511->i2c_edid->adapter, xfer,
+					   ARRAY_SIZE(xfer));
+			if (ret < 0)
+				return ret;
+			else if (ret != 2)
+				return -EIO;
+
+			xfer[1].buf += 64;
+			offset += 64;
+		}
+
+		adv7511->current_edid_segment = block / 2;
+	}
+
+	if (block % 2 == 0)
+		memcpy(buf, adv7511->edid_buf, len);
+	else
+		memcpy(buf, adv7511->edid_buf + 128, len);
+
+	return 0;
+}
+
+/* -----------------------------------------------------------------------------
+ * Encoder operations
+ */
+
+static int adv7511_get_modes(struct drm_encoder *encoder,
+			     struct drm_connector *connector)
+{
+	struct adv7511 *adv7511 = encoder_to_adv7511(encoder);
+	struct edid *edid;
+	unsigned int count;
+
+	/* Reading the EDID only works if the device is powered */
+	if (!adv7511->powered) {
+		regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER,
+				   ADV7511_POWER_POWER_DOWN, 0);
+		if (adv7511->i2c_main->irq) {
+			regmap_write(adv7511->regmap, ADV7511_REG_INT_ENABLE(0),
+				     ADV7511_INT0_EDID_READY);
+			regmap_write(adv7511->regmap, ADV7511_REG_INT_ENABLE(1),
+				     ADV7511_INT1_DDC_ERROR);
+		}
+		adv7511->current_edid_segment = -1;
+	}
+
+	edid = drm_do_get_edid(connector, adv7511_get_edid_block, adv7511);
+
+	if (!adv7511->powered)
+		regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER,
+				   ADV7511_POWER_POWER_DOWN,
+				   ADV7511_POWER_POWER_DOWN);
+
+	kfree(adv7511->edid);
+	adv7511->edid = edid;
+	if (!edid)
+		return 0;
+
+	drm_mode_connector_update_edid_property(connector, edid);
+	count = drm_add_edid_modes(connector, edid);
+
+	adv7511_set_config_csc(adv7511, connector, adv7511->rgb);
+
+	return count;
+}
+
+static void adv7511_encoder_dpms(struct drm_encoder *encoder, int mode)
+{
+	struct adv7511 *adv7511 = encoder_to_adv7511(encoder);
+
+	if (mode == DRM_MODE_DPMS_ON)
+		adv7511_power_on(adv7511);
+	else
+		adv7511_power_off(adv7511);
+}
+
+static enum drm_connector_status
+adv7511_encoder_detect(struct drm_encoder *encoder,
+		       struct drm_connector *connector)
+{
+	struct adv7511 *adv7511 = encoder_to_adv7511(encoder);
+	enum drm_connector_status status;
+	unsigned int val;
+	bool hpd;
+	int ret;
+
+	ret = regmap_read(adv7511->regmap, ADV7511_REG_STATUS, &val);
+	if (ret < 0)
+		return connector_status_disconnected;
+
+	if (val & ADV7511_STATUS_HPD)
+		status = connector_status_connected;
+	else
+		status = connector_status_disconnected;
+
+	hpd = adv7511_hpd(adv7511);
+
+	/* The chip resets itself when the cable is disconnected, so in case
+	 * there is a pending HPD interrupt and the cable is connected there was
+	 * at least one transition from disconnected to connected and the chip
+	 * has to be reinitialized. */
+	if (status == connector_status_connected && hpd && adv7511->powered) {
+		regcache_mark_dirty(adv7511->regmap);
+		adv7511_power_on(adv7511);
+		adv7511_get_modes(encoder, connector);
+		if (adv7511->status == connector_status_connected)
+			status = connector_status_disconnected;
+	} else {
+		/* Renable HPD sensing */
+		regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER2,
+				   ADV7511_REG_POWER2_HPD_SRC_MASK,
+				   ADV7511_REG_POWER2_HPD_SRC_BOTH);
+	}
+
+	adv7511->status = status;
+	return status;
+}
+
+static int adv7511_encoder_mode_valid(struct drm_encoder *encoder,
+				      struct drm_display_mode *mode)
+{
+	if (mode->clock > 165000)
+		return MODE_CLOCK_HIGH;
+
+	return MODE_OK;
+}
+
+static void adv7511_encoder_mode_set(struct drm_encoder *encoder,
+				     struct drm_display_mode *mode,
+				     struct drm_display_mode *adj_mode)
+{
+	struct adv7511 *adv7511 = encoder_to_adv7511(encoder);
+	unsigned int low_refresh_rate;
+	unsigned int hsync_polarity = 0;
+	unsigned int vsync_polarity = 0;
+
+	if (adv7511->embedded_sync) {
+		unsigned int hsync_offset, hsync_len;
+		unsigned int vsync_offset, vsync_len;
+
+		hsync_offset = adj_mode->crtc_hsync_start -
+			       adj_mode->crtc_hdisplay;
+		vsync_offset = adj_mode->crtc_vsync_start -
+			       adj_mode->crtc_vdisplay;
+		hsync_len = adj_mode->crtc_hsync_end -
+			    adj_mode->crtc_hsync_start;
+		vsync_len = adj_mode->crtc_vsync_end -
+			    adj_mode->crtc_vsync_start;
+
+		/* The hardware vsync generator has a off-by-one bug */
+		vsync_offset += 1;
+
+		regmap_write(adv7511->regmap, ADV7511_REG_HSYNC_PLACEMENT_MSB,
+			     ((hsync_offset >> 10) & 0x7) << 5);
+		regmap_write(adv7511->regmap, ADV7511_REG_SYNC_DECODER(0),
+			     (hsync_offset >> 2) & 0xff);
+		regmap_write(adv7511->regmap, ADV7511_REG_SYNC_DECODER(1),
+			     ((hsync_offset & 0x3) << 6) |
+			     ((hsync_len >> 4) & 0x3f));
+		regmap_write(adv7511->regmap, ADV7511_REG_SYNC_DECODER(2),
+			     ((hsync_len & 0xf) << 4) |
+			     ((vsync_offset >> 6) & 0xf));
+		regmap_write(adv7511->regmap, ADV7511_REG_SYNC_DECODER(3),
+			     ((vsync_offset & 0x3f) << 2) |
+			     ((vsync_len >> 8) & 0x3));
+		regmap_write(adv7511->regmap, ADV7511_REG_SYNC_DECODER(4),
+			     vsync_len & 0xff);
+
+		hsync_polarity = !(adj_mode->flags & DRM_MODE_FLAG_PHSYNC);
+		vsync_polarity = !(adj_mode->flags & DRM_MODE_FLAG_PVSYNC);
+	} else {
+		enum adv7511_sync_polarity mode_hsync_polarity;
+		enum adv7511_sync_polarity mode_vsync_polarity;
+
+		/**
+		 * If the input signal is always low or always high we want to
+		 * invert or let it passthrough depending on the polarity of the
+		 * current mode.
+		 **/
+		if (adj_mode->flags & DRM_MODE_FLAG_NHSYNC)
+			mode_hsync_polarity = ADV7511_SYNC_POLARITY_LOW;
+		else
+			mode_hsync_polarity = ADV7511_SYNC_POLARITY_HIGH;
+
+		if (adj_mode->flags & DRM_MODE_FLAG_NVSYNC)
+			mode_vsync_polarity = ADV7511_SYNC_POLARITY_LOW;
+		else
+			mode_vsync_polarity = ADV7511_SYNC_POLARITY_HIGH;
+
+		if (adv7511->hsync_polarity != mode_hsync_polarity &&
+		    adv7511->hsync_polarity !=
+		    ADV7511_SYNC_POLARITY_PASSTHROUGH)
+			hsync_polarity = 1;
+
+		if (adv7511->vsync_polarity != mode_vsync_polarity &&
+		    adv7511->vsync_polarity !=
+		    ADV7511_SYNC_POLARITY_PASSTHROUGH)
+			vsync_polarity = 1;
+	}
+
+	if (mode->vrefresh <= 24000)
+		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_24HZ;
+	else if (mode->vrefresh <= 25000)
+		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_25HZ;
+	else if (mode->vrefresh <= 30000)
+		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_30HZ;
+	else
+		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_NONE;
+
+	regmap_update_bits(adv7511->regmap, 0xfb,
+		0x6, low_refresh_rate << 1);
+	regmap_update_bits(adv7511->regmap, 0x17,
+		0x60, (vsync_polarity << 6) | (hsync_polarity << 5));
+
+	/*
+	 * TODO Test first order 4:2:2 to 4:4:4 up conversion method, which is
+	 * supposed to give better results.
+	 */
+
+	adv7511->f_tmds = mode->clock;
+}
+
+static const struct drm_encoder_slave_funcs adv7511_encoder_funcs = {
+	.dpms = adv7511_encoder_dpms,
+	.mode_valid = adv7511_encoder_mode_valid,
+	.mode_set = adv7511_encoder_mode_set,
+	.detect = adv7511_encoder_detect,
+	.get_modes = adv7511_get_modes,
+};
+
+/* -----------------------------------------------------------------------------
+ * Probe & remove
+ */
+
+static int adv7511_parse_dt(struct device_node *np,
+			    struct adv7511_link_config *config)
+{
+	const char *str;
+	int ret;
+
+	memset(config, 0, sizeof(*config));
+
+	of_property_read_u32(np, "adi,input-depth", &config->input_color_depth);
+	if (config->input_color_depth != 8 && config->input_color_depth != 10 &&
+	    config->input_color_depth != 12)
+		return -EINVAL;
+
+	ret = of_property_read_string(np, "adi,input-colorspace", &str);
+	if (ret < 0)
+		return ret;
+
+	if (!strcmp(str, "rgb"))
+		config->input_colorspace = HDMI_COLORSPACE_RGB;
+	else if (!strcmp(str, "yuv422"))
+		config->input_colorspace = HDMI_COLORSPACE_YUV422;
+	else if (!strcmp(str, "yuv444"))
+		config->input_colorspace = HDMI_COLORSPACE_YUV444;
+	else
+		return -EINVAL;
+
+	ret = of_property_read_string(np, "adi,input-clock", &str);
+	if (ret < 0)
+		return ret;
+
+	if (!strcmp(str, "1x"))
+		config->input_clock = ADV7511_INPUT_CLOCK_1X;
+	else if (!strcmp(str, "2x"))
+		config->input_clock = ADV7511_INPUT_CLOCK_2X;
+	else if (!strcmp(str, "ddr"))
+		config->input_clock = ADV7511_INPUT_CLOCK_DDR;
+	else
+		return -EINVAL;
+
+	if (config->input_colorspace == HDMI_COLORSPACE_YUV422 ||
+	    config->input_clock != ADV7511_INPUT_CLOCK_1X) {
+		ret = of_property_read_u32(np, "adi,input-style",
+					   &config->input_style);
+		if (ret)
+			return ret;
+
+		if (config->input_style < 1 || config->input_style > 3)
+			return -EINVAL;
+
+		ret = of_property_read_string(np, "adi,input-justification",
+					      &str);
+		if (ret < 0)
+			return ret;
+
+		if (!strcmp(str, "left"))
+			config->input_justification =
+				ADV7511_INPUT_JUSTIFICATION_LEFT;
+		else if (!strcmp(str, "evenly"))
+			config->input_justification =
+				ADV7511_INPUT_JUSTIFICATION_EVENLY;
+		else if (!strcmp(str, "right"))
+			config->input_justification =
+				ADV7511_INPUT_JUSTIFICATION_RIGHT;
+		else
+			return -EINVAL;
+
+	} else {
+		config->input_style = 1;
+		config->input_justification = ADV7511_INPUT_JUSTIFICATION_LEFT;
+	}
+
+	of_property_read_u32(np, "adi,clock-delay", &config->clock_delay);
+	if (config->clock_delay < -1200 || config->clock_delay > 1600)
+		return -EINVAL;
+
+	config->embedded_sync = of_property_read_bool(np, "adi,embedded-sync");
+
+	/* Hardcode the sync pulse configurations for now. */
+	config->sync_pulse = ADV7511_INPUT_SYNC_PULSE_NONE;
+	config->vsync_polarity = ADV7511_SYNC_POLARITY_PASSTHROUGH;
+	config->hsync_polarity = ADV7511_SYNC_POLARITY_PASSTHROUGH;
+
+	return 0;
+}
+
+static const int edid_i2c_addr = 0x7e;
+static const int packet_i2c_addr = 0x70;
+static const int cec_i2c_addr = 0x78;
+
+static int adv7511_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
+{
+	struct adv7511_link_config link_config;
+	struct adv7511 *adv7511;
+	struct device *dev = &i2c->dev;
+	unsigned int val;
+	int ret;
+
+	if (!dev->of_node)
+		return -EINVAL;
+
+	adv7511 = devm_kzalloc(dev, sizeof(*adv7511), GFP_KERNEL);
+	if (!adv7511)
+		return -ENOMEM;
+
+	adv7511->powered = false;
+	adv7511->status = connector_status_disconnected;
+
+	ret = adv7511_parse_dt(dev->of_node, &link_config);
+	if (ret)
+		return ret;
+
+	/*
+	 * The power down GPIO is optional. If present, toggle it from active to
+	 * inactive to wake up the encoder.
+	 */
+	adv7511->gpio_pd = devm_gpiod_get_optional(dev, "pd", GPIOD_OUT_HIGH);
+	if (IS_ERR(adv7511->gpio_pd))
+		return PTR_ERR(adv7511->gpio_pd);
+
+	if (adv7511->gpio_pd) {
+		mdelay(5);
+		gpiod_set_value_cansleep(adv7511->gpio_pd, 0);
+	}
+
+	adv7511->regmap = devm_regmap_init_i2c(i2c, &adv7511_regmap_config);
+	if (IS_ERR(adv7511->regmap))
+		return PTR_ERR(adv7511->regmap);
+
+	ret = regmap_read(adv7511->regmap, ADV7511_REG_CHIP_REVISION, &val);
+	if (ret)
+		return ret;
+	dev_dbg(dev, "Rev. %d\n", val);
+
+	ret = regmap_register_patch(adv7511->regmap, adv7511_fixed_registers,
+				    ARRAY_SIZE(adv7511_fixed_registers));
+	if (ret)
+		return ret;
+
+	regmap_write(adv7511->regmap, ADV7511_REG_EDID_I2C_ADDR, edid_i2c_addr);
+	regmap_write(adv7511->regmap, ADV7511_REG_PACKET_I2C_ADDR,
+		     packet_i2c_addr);
+	regmap_write(adv7511->regmap, ADV7511_REG_CEC_I2C_ADDR, cec_i2c_addr);
+	adv7511_packet_disable(adv7511, 0xffff);
+
+	adv7511->i2c_main = i2c;
+	adv7511->i2c_edid = i2c_new_dummy(i2c->adapter, edid_i2c_addr >> 1);
+	if (!adv7511->i2c_edid)
+		return -ENOMEM;
+
+	if (i2c->irq) {
+		init_waitqueue_head(&adv7511->wq);
+
+		ret = devm_request_threaded_irq(dev, i2c->irq, NULL,
+						adv7511_irq_handler,
+						IRQF_ONESHOT, dev_name(dev),
+						adv7511);
+		if (ret)
+			goto err_i2c_unregister_device;
+	}
+
+	/* CEC is unused for now */
+	regmap_write(adv7511->regmap, ADV7511_REG_CEC_CTRL,
+		     ADV7511_CEC_CTRL_POWER_DOWN);
+
+	adv7511_power_off(adv7511);
+
+	i2c_set_clientdata(i2c, adv7511);
+
+#ifdef CONFIG_DRM_I2C_ADV7511_AUDIO
+	adv7511_audio_init(&i2c->dev);
+#endif
+
+	adv7511_set_link_config(adv7511, &link_config);
+
+	/* Enable HDMI mode */
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_HDCP_HDMI_CFG,
+			ADV7511_HDMI_CFG_MODE_MASK,
+			ADV7511_HDMI_CFG_MODE_HDMI);
+
+	return 0;
+
+err_i2c_unregister_device:
+	i2c_unregister_device(adv7511->i2c_edid);
+
+	return ret;
+}
+
+static int adv7511_remove(struct i2c_client *i2c)
+{
+	struct adv7511 *adv7511 = i2c_get_clientdata(i2c);
+
+	i2c_unregister_device(adv7511->i2c_edid);
+
+	kfree(adv7511->edid);
+
+	return 0;
+}
+
+static int adv7511_encoder_init(struct i2c_client *i2c, struct drm_device *dev,
+				struct drm_encoder_slave *encoder)
+{
+
+	struct adv7511 *adv7511 = i2c_get_clientdata(i2c);
+
+	encoder->slave_priv = adv7511;
+	encoder->slave_funcs = &adv7511_encoder_funcs;
+
+	adv7511->encoder = &encoder->base;
+
+	return 0;
+}
+
+static const struct i2c_device_id adv7511_i2c_ids[] = {
+	{ "adv7511", 0 },
+	{ "adv7511w", 0 },
+	{ "adv7513", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, adv7511_i2c_ids);
+
+static const struct of_device_id adv7511_of_ids[] = {
+	{ .compatible = "adi,adv7511", },
+	{ .compatible = "adi,adv7511w", },
+	{ .compatible = "adi,adv7513", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adv7511_of_ids);
+
+static struct drm_i2c_encoder_driver adv7511_driver = {
+	.i2c_driver = {
+		.driver = {
+			.name = "adv7511",
+			.of_match_table = adv7511_of_ids,
+		},
+		.id_table = adv7511_i2c_ids,
+		.probe = adv7511_probe,
+		.remove = adv7511_remove,
+	},
+
+	.encoder_init = adv7511_encoder_init,
+};
+
+static int __init adv7511_init(void)
+{
+	return drm_i2c_encoder_register(THIS_MODULE, &adv7511_driver);
+}
+module_init(adv7511_init);
+
+static void __exit adv7511_exit(void)
+{
+	drm_i2c_encoder_unregister(&adv7511_driver);
+}
+module_exit(adv7511_exit);
+
+MODULE_AUTHOR("Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>");
+MODULE_DESCRIPTION("ADV7511 HDMI transmitter driver");
+MODULE_LICENSE("GPL");
diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 964b7de..539c091 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -33,6 +33,7 @@ struct snd_compr_stream;
 #define SND_SOC_DAIFMT_DSP_B		5 /* L data MSB during FRM LRC */
 #define SND_SOC_DAIFMT_AC97		6 /* AC97 */
 #define SND_SOC_DAIFMT_PDM		7 /* Pulse density modulation */
+#define SND_SOC_DAIFMT_SPDIF		8 /* SPDIF */
 
 /* left and right justified also known as MSB and LSB respectively */
 #define SND_SOC_DAIFMT_MSB		SND_SOC_DAIFMT_LEFT_J
-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
