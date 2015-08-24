From: Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH 07/10] ALSA: axd: add cmd interface helper functions
Date: Mon, 24 Aug 2015 13:39:16 +0100
Message-ID: <1440419959-14315-8-git-send-email-qais.yousef@imgtec.com>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Qais Yousef <qais.yousef@imgtec.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

AXD has a lot of registers. These files contain helper functions to
access these registers in a readable way.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/img/axd/axd_cmds_config.c         | 1235 ++++++++++
 sound/soc/img/axd/axd_cmds_decoder_config.c |  422 ++++
 sound/soc/img/axd/axd_cmds_info.c           | 1249 ++++++++++
 sound/soc/img/axd/axd_cmds_internal.c       | 3264 +++++++++++++++++++++++++++
 sound/soc/img/axd/axd_cmds_internal.h       |  317 +++
 sound/soc/img/axd/axd_cmds_pipes.c          |    4 +-
 6 files changed, 6489 insertions(+), 2 deletions(-)
 create mode 100644 sound/soc/img/axd/axd_cmds_config.c
 create mode 100644 sound/soc/img/axd/axd_cmds_decoder_config.c
 create mode 100644 sound/soc/img/axd/axd_cmds_info.c
 create mode 100644 sound/soc/img/axd/axd_cmds_internal.c
 create mode 100644 sound/soc/img/axd/axd_cmds_internal.h

diff --git a/sound/soc/img/axd/axd_cmds_config.c b/sound/soc/img/axd/axd_cmds_config.c
new file mode 100644
index 000000000000..17366a6a40eb
--- /dev/null
+++ b/sound/soc/img/axd/axd_cmds_config.c
@@ -0,0 +1,1235 @@
+/*
+ * Copyright (C) 2011-2015 Imagination Technologies Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * AXD Commands API - Configuration functions.
+ */
+#include "axd_cmds.h"
+#include "axd_cmds_internal.h"
+
+
+/*
+ * Enable/Disable Mixer EQ.
+ * @pipe: pipe number.
+ * @enable:
+ *	Enable	= !0
+ *	Disable	= 0
+ */
+void axd_cmd_mixer_set_eqenabled(struct axd_cmd *cmd, unsigned int pipe,
+								int enable)
+{
+	unsigned int reg = AXD_REG_EQ_CTRL_GAIN;
+	unsigned int control;
+
+	if (axd_read_reg(cmd, reg, &control))
+		return;
+
+	if (enable)
+		control |= AXD_EQCTRL_ENABLE_BITS;
+	else
+		control &= ~AXD_EQCTRL_ENABLE_BITS;
+	axd_write_reg(cmd, reg, control);
+}
+
+/*
+ * Set the Master gain of the EQ of the Mixer
+ * @pipe: pipe number.
+ * @gain: 0-99 gain value
+ */
+void axd_cmd_mixer_set_eqmastergain(struct axd_cmd *cmd, unsigned int pipe,
+								int gain)
+{
+	unsigned int reg = AXD_REG_EQ_CTRL_GAIN;
+	unsigned int control;
+
+	if (unlikely(gain > 99 || gain < 0))
+		return;
+
+	if (axd_read_reg(cmd, reg, &control))
+		return;
+
+	gain = (gain << AXD_EQCTRL_GAIN_SHIFT) & AXD_EQCTRL_GAIN_BITS;
+	control &= ~AXD_EQCTRL_GAIN_BITS;
+	control |= gain;
+	axd_write_reg(cmd, reg, control);
+}
+
+/*
+ * Set the gain of the EQ Band0 of the Mixer
+ * @pipe: pipe number.
+ * @gain: Signed 8 bit 2'compliment gain value.
+ */
+void axd_cmd_mixer_set_eqband0gain(struct axd_cmd *cmd, unsigned int pipe,
+								int gain)
+{
+	gain = (gain << AXD_EQBANDX_GAIN_SHIFT) & AXD_EQBANDX_GAIN_BITS;
+	axd_write_reg(cmd, AXD_REG_EQ_BAND0, gain);
+}
+
+/*
+ * Set the gain of the EQ Band1 of the Mixer
+ * @pipe: pipe number.
+ * @gain: Signed 8 bit 2'compliment gain value.
+ */
+void axd_cmd_mixer_set_eqband1gain(struct axd_cmd *cmd, unsigned int pipe,
+								int gain)
+{
+	gain = (gain << AXD_EQBANDX_GAIN_SHIFT) & AXD_EQBANDX_GAIN_BITS;
+	axd_write_reg(cmd, AXD_REG_EQ_BAND1, gain);
+}
+
+/*
+ * Set the gain of the EQ Band2 of Mixer
+ * @pipe: pipe number.
+ * @gain: Signed 8 bit 2'compliment gain value.
+ */
+void axd_cmd_mixer_set_eqband2gain(struct axd_cmd *cmd, unsigned int pipe,
+								int gain)
+{
+	gain = (gain << AXD_EQBANDX_GAIN_SHIFT) & AXD_EQBANDX_GAIN_BITS;
+	axd_write_reg(cmd, AXD_REG_EQ_BAND2, gain);
+}
+
+/*
+ * Set the gain of the EQ Band3 of the Mixer
+ * @pipe: pipe number.
+ * @gain: Signed 8 bit 2'compliment gain value.
+ */
+void axd_cmd_mixer_set_eqband3gain(struct axd_cmd *cmd, unsigned int pipe,
+								int gain)
+{
+	gain = (gain << AXD_EQBANDX_GAIN_SHIFT) & AXD_EQBANDX_GAIN_BITS;
+	axd_write_reg(cmd, AXD_REG_EQ_BAND3, gain);
+}
+
+/*
+ * Set the gain of the EQ Band4 of the Mixer
+ * @pipe: pipe number.
+ * @gain: Signed 8 bit 2'compliment gain value.
+ */
+void axd_cmd_mixer_set_eqband4gain(struct axd_cmd *cmd, unsigned int pipe,
+								int gain)
+{
+	gain = (gain << AXD_EQBANDX_GAIN_SHIFT) & AXD_EQBANDX_GAIN_BITS;
+	axd_write_reg(cmd, AXD_REG_EQ_BAND4, gain);
+}
+
+/*
+ * Select Mixer's Mux output
+ * @pipe: pipe number.
+ * @mux:
+ *	Mix	= 0
+ *	Input 0	= 1
+ *	Input 1	= 2
+ *	Input 2	= 3
+ *	Input 3	= 4
+ */
+void axd_cmd_mixer_set_mux(struct axd_cmd *cmd, unsigned int pipe,
+								int mux)
+{
+	unsigned int reg = axd_get_mixer_mux_reg(cmd, pipe);
+
+	if (unlikely(mux > 4 || mux < 0))
+		return;
+	axd_write_reg(cmd, reg, mux);
+}
+
+/*
+ * Enable/Disable input.
+ * @pipe: pipe number.
+ * @enable:
+ *	Enable	= !0
+ *	Disable	= 0
+ */
+int axd_cmd_input_set_enabled(struct axd_cmd *cmd, unsigned int pipe,
+								int enable)
+{
+	unsigned int reg = axd_get_input_control_reg(cmd, pipe);
+	unsigned int control;
+
+	if (unlikely(!reg))
+		return -1;
+
+	if (axd_read_reg(cmd, reg, &control))
+		return -1;
+
+	if (enable)
+		control |= AXD_INCTRL_ENABLE_BITS;
+	else
+		control &= ~AXD_INCTRL_ENABLE_BITS;
+	if (axd_write_reg(cmd, reg, control))
+		return -1;
+	return 0;
+}
+
+/*
+ * Set the source of the input pipe.
+ * @pipe: pipe number.
+ * @source:
+ *	Pipe	= 0
+ *	Aux	= 1
+ */
+void axd_cmd_input_set_source(struct axd_cmd *cmd, unsigned int pipe,
+								int source)
+{
+	unsigned int reg = axd_get_input_control_reg(cmd, pipe);
+	unsigned int control;
+
+	if (unlikely(!reg || source > 1 || source < 0))
+		return;
+	if (axd_read_reg(cmd, reg, &control))
+		return;
+	source = (source << AXD_INCTRL_SOURCE_SHIFT) & AXD_INCTRL_SOURCE_BITS;
+	control &= ~AXD_INCTRL_SOURCE_BITS;
+	control |= source;
+	axd_write_reg(cmd, reg, control);
+}
+
+/*
+ * Set the codec of the input pipe.
+ * @pipe: pipe number.
+ * @codec:
+ *	PCM Pass Through	= 0
+ *	MPEG (2/3)		= 1
+ *	Dolby AC3		= 2
+ *	AAC			= 3
+ *	Ogg Vorbis		= 4
+ *	FLAC			= 5
+ *	Cook			= 6
+ *	WMA			= 7
+ *	DDPlus			= 8
+ *	DTS			= 9   Unsupported
+ *	DTS-HD			= 10  Unsupported
+ *	ALAC			= 11
+ *	SBC			= 13
+ */
+int axd_cmd_input_set_codec(struct axd_cmd *cmd, unsigned int pipe,
+								int codec)
+{
+	unsigned int reg = axd_get_input_control_reg(cmd, pipe);
+	unsigned int control, config1;
+
+	/* make sure it's a valid value */
+	if (unlikely(!reg || codec > 13 || codec < 0 ||
+						codec == 9 || codec == 10))
+		return -1;
+
+	/* make sure the firmware supports it */
+	if (axd_read_reg(cmd, AXD_REG_CONFIG1, &config1))
+		return -1;
+	if (!(config1 & BIT(codec)))
+		return -1;
+
+	if (axd_read_reg(cmd, reg, &control))
+		return -1;
+	codec = (codec << AXD_INCTRL_CODEC_SHIFT) & AXD_INCTRL_CODEC_BITS;
+	control &= ~AXD_INCTRL_CODEC_BITS;
+	control |= codec;
+	axd_write_reg(cmd, reg, control);
+
+	return 0;
+}
+
+/*
+ * Set the gain of the input pipe.
+ * @pipe: pipe number.
+ * @gain: Signed 32 bit 2'compliment gain value.
+ *	Gain Cut or Boost in 0.25dB increment. ie: 4 = 1dB.
+ */
+void axd_cmd_input_set_gain(struct axd_cmd *cmd, unsigned int pipe,
+								int gain)
+{
+	unsigned int reg = axd_get_input_gain_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return;
+	axd_write_reg(cmd, reg, gain);
+}
+
+/*
+ * Mute/Unmute the input pipe.
+ * @pipe: pipe number.
+ * @mute:  0	= OFF
+ *	  !0	= ON
+ */
+void axd_cmd_input_set_mute(struct axd_cmd *cmd, unsigned int pipe,
+								int mute)
+{
+	unsigned int reg = axd_get_input_mute_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return;
+	axd_write_reg(cmd, reg, mute);
+}
+
+/*
+ * Send event for output pipe.
+ * @pipe: pipe number.
+ * @event:
+ *	Pause	= 0
+ *	Resume	= 1
+ */
+void axd_cmd_output_set_event(struct axd_cmd *cmd, unsigned int pipe,
+								int event)
+{
+	unsigned int reg = axd_get_output_event_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return;
+	axd_write_reg(cmd, reg, event);
+}
+
+/*
+ * Set the upmix of the input pipe.
+ * @pipe: pipe number.
+ * @upmix:
+ *	Pass through		= 0
+ *	Simple 5.1		= 1
+ *	Dolby Pro Logic 2	= 2
+ */
+void axd_cmd_input_set_upmix(struct axd_cmd *cmd, unsigned int pipe,
+								int upmix)
+{
+	unsigned int reg = axd_get_input_upmix_reg(cmd, pipe);
+
+	if (unlikely(!reg || upmix > 2 || upmix < 0))
+		return;
+	axd_write_reg(cmd, reg, upmix);
+}
+
+/* Set the buffer occupancy value of @pipe. */
+void axd_cmd_input_set_buffer_occupancy(struct axd_cmd *cmd, unsigned int pipe,
+								unsigned int bo)
+{
+	unsigned int reg = axd_get_input_buffer_occupancy_reg(cmd, pipe);
+
+	axd_write_reg(cmd, reg, bo);
+}
+
+/*
+ * Enable/Disable output.
+ * @pipe: pipe number.
+ * @enable:
+ *	Enable	= !0
+ *	Disable	= 0
+ */
+int axd_cmd_output_set_enabled(struct axd_cmd *cmd, unsigned int pipe,
+								int enable)
+{
+	unsigned int reg = axd_get_output_control_reg(cmd, pipe);
+	unsigned int control;
+
+	if (unlikely(!reg))
+		return -1;
+	if (axd_read_reg(cmd, reg, &control))
+		return -1;
+	if (enable)
+		control |= AXD_OUTCTRL_ENABLE_BITS;
+	else
+		control &= ~AXD_OUTCTRL_ENABLE_BITS;
+	if (axd_write_reg(cmd, reg, control))
+		return -1;
+	return 0;
+}
+
+/*
+ * Set the codec of the output pipe.
+ * @pipe: pipe number.
+ * @codec:
+ *	PCM Pass Through	=  0
+ *	MPEG (2/3)		=  1 Unsupported
+ *	Dolby AC3		=  2 Unsupported
+ *	AAC			=  3 Unsupported
+ *	Ogg Vorbis		=  4 Unsupported
+ *	FLAC			=  5
+ *	Cook			=  6 Unsupported
+ *	WMA			=  7 Unsupported
+ *	DDPlus			=  8 Unsupported
+ *	DTS			=  9 Unsupported
+ *	DTS-HD			= 10 Unsupported
+ *	ALAC			= 11
+ *	SBC			= 13 Unsupported
+ */
+int axd_cmd_output_set_codec(struct axd_cmd *cmd, unsigned int pipe,
+								int codec)
+{
+	unsigned int reg = axd_get_output_control_reg(cmd, pipe);
+	unsigned int control, config2;
+
+	/* make sure it's a valid value */
+	if (unlikely(!reg || !(codec == 0 || codec == 5 || codec == 11)))
+		return -1;
+
+	/* make sure the firmware supports it */
+	if (axd_read_reg(cmd, AXD_REG_CONFIG2, &config2))
+		return -1;
+	if (!(config2 & BIT(codec)))
+		return -1;
+
+	if (axd_read_reg(cmd, reg, &control))
+		return -1;
+	codec = (codec << AXD_OUTCTRL_CODEC_SHIFT) & AXD_OUTCTRL_CODEC_BITS;
+	control &= ~AXD_OUTCTRL_CODEC_BITS;
+	control |= codec;
+	axd_write_reg(cmd, reg, control);
+
+	return 0;
+}
+
+/*
+ * Set the sink of the output pipe.
+ * @pipe: pipe number.
+ * @source:
+ *	Pipe	= 0
+ */
+void axd_cmd_output_set_sink(struct axd_cmd *cmd, unsigned int pipe,
+								int sink)
+{
+	unsigned int reg = axd_get_output_control_reg(cmd, pipe);
+	unsigned int control;
+
+	if (unlikely(!reg || (sink < 0 && sink > 3)))
+		return;
+	if (axd_read_reg(cmd, reg, &control))
+		return;
+	sink = (sink << AXD_OUTCTRL_SINK_SHIFT) & AXD_OUTCTRL_SINK_BITS;
+	control &= ~AXD_OUTCTRL_SINK_BITS;
+	control |= sink;
+	axd_write_reg(cmd, reg, control);
+}
+
+/*
+ * Set the downmix of the output pipe.
+ * @pipe: pipe number.
+ * @downmix:
+ *	Pass through	= 0
+ *	5.1		= 1
+ *	2.0		= 2
+ */
+void axd_cmd_output_set_downmix(struct axd_cmd *cmd, unsigned int pipe,
+								int downmix)
+{
+	unsigned int reg = axd_get_output_downmix_reg(cmd, pipe);
+
+	if (unlikely(!reg || downmix > 2 || downmix < 0))
+		return;
+	axd_write_reg(cmd, reg, downmix);
+}
+
+/*
+ * Enable/Disable output EQ.
+ * @pipe: pipe number.
+ * @enable:
+ *	Enable	= !0
+ *	Disable	= 0
+ */
+void axd_cmd_output_set_eqenabled(struct axd_cmd *cmd, unsigned int pipe,
+								int enable)
+{
+	unsigned int reg = axd_get_output_eqcontrol_reg(cmd, pipe);
+	unsigned int control;
+
+	if (unlikely(!reg))
+		return;
+	if (axd_read_reg(cmd, reg, &control))
+		return;
+
+	if (enable)
+		control |= AXD_EQCTRL_ENABLE_BITS;
+	else
+		control &= ~AXD_EQCTRL_ENABLE_BITS;
+	axd_write_reg(cmd, reg, control);
+}
+
+/*
+ * Set the Master gain of the EQ of output pipe.
+ * @pipe: pipe number.
+ * @gain: 0-99 gain value
+ */
+void axd_cmd_output_set_eqmastergain(struct axd_cmd *cmd, unsigned int pipe,
+								int gain)
+{
+	unsigned int reg = axd_get_output_eqcontrol_reg(cmd, pipe);
+	unsigned int control;
+
+	if (unlikely(!reg || gain > 99 || gain < 0))
+		return;
+	if (axd_read_reg(cmd, reg, &control))
+		return;
+
+	gain = (gain << AXD_EQCTRL_GAIN_SHIFT) & AXD_EQCTRL_GAIN_BITS;
+	control &= ~AXD_EQCTRL_GAIN_BITS;
+	control |= gain;
+	axd_write_reg(cmd, reg, control);
+}
+
+/*
+ * Set the gain of the EQ Band0 of output pipe.
+ * @pipe: pipe number.
+ * @gain: Signed 8 bit 2'compliment gain value.
+ */
+void axd_cmd_output_set_eqband0gain(struct axd_cmd *cmd, unsigned int pipe,
+								int gain)
+{
+	unsigned int reg = axd_get_output_eqband0_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return;
+	gain = (gain << AXD_EQBANDX_GAIN_SHIFT) & AXD_EQBANDX_GAIN_BITS;
+	axd_write_reg(cmd, reg, gain);
+}
+
+/*
+ * Set the gain of the EQ Band1 of output pipe.
+ * @pipe: pipe number.
+ * @gain: Signed 8 bit 2'compliment gain value.
+ */
+void axd_cmd_output_set_eqband1gain(struct axd_cmd *cmd, unsigned int pipe,
+								int gain)
+{
+	unsigned int reg = axd_get_output_eqband1_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return;
+	gain = (gain << AXD_EQBANDX_GAIN_SHIFT) & AXD_EQBANDX_GAIN_BITS;
+	axd_write_reg(cmd, reg, gain);
+}
+
+/*
+ * Set the gain of the EQ Band2 of output pipe.
+ * @pipe: pipe number.
+ * @gain: Signed 8 bit 2'compliment gain value.
+ */
+void axd_cmd_output_set_eqband2gain(struct axd_cmd *cmd, unsigned int pipe,
+								int gain)
+{
+	unsigned int reg = axd_get_output_eqband2_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return;
+	gain = (gain << AXD_EQBANDX_GAIN_SHIFT) & AXD_EQBANDX_GAIN_BITS;
+	axd_write_reg(cmd, reg, gain);
+}
+
+/*
+ * Set the gain of the EQ Band3 of output pipe.
+ * @pipe: pipe number.
+ * @gain: Signed 8 bit 2'compliment gain value.
+ */
+void axd_cmd_output_set_eqband3gain(struct axd_cmd *cmd, unsigned int pipe,
+								int gain)
+{
+	unsigned int reg = axd_get_output_eqband3_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return;
+	gain = (gain << AXD_EQBANDX_GAIN_SHIFT) & AXD_EQBANDX_GAIN_BITS;
+	axd_write_reg(cmd, reg, gain);
+}
+
+/*
+ * Set the gain of the EQ Band4 of output pipe.
+ * @pipe: pipe number.
+ * @gain: Signed 8 bit 2'compliment gain value.
+ */
+void axd_cmd_output_set_eqband4gain(struct axd_cmd *cmd, unsigned int pipe,
+								int gain)
+{
+	unsigned int reg = axd_get_output_eqband4_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return;
+	gain = (gain << AXD_EQBANDX_GAIN_SHIFT) & AXD_EQBANDX_GAIN_BITS;
+	axd_write_reg(cmd, reg, gain);
+}
+
+/* DCPP */
+
+int axd_cmd_output_set_dcpp_enabled(struct axd_cmd *cmd, unsigned int pipe,
+								int enable)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	reg = axd_get_output_dcpp_control_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return -1;
+	if (axd_read_reg(cmd, reg, &control))
+		return -1;
+
+	if (enable)
+		control |= AXD_DCPP_CTRL_ENABLE_BITS;
+	else
+		control &= ~AXD_DCPP_CTRL_ENABLE_BITS;
+
+	return axd_write_reg_buf(cmd, reg, control);
+}
+
+int axd_cmd_output_set_dcpp_mode(struct axd_cmd *cmd, unsigned int pipe,
+							unsigned int mode)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	reg = axd_get_output_dcpp_control_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return -1;
+	if (axd_read_reg(cmd, reg, &control))
+		return -1;
+
+	/* Conditionally mask in mode bit */
+	control ^= ((control ^ (mode << AXD_DCPP_CTRL_MODE_SHIFT))
+						& AXD_DCPP_CTRL_MODE_BITS);
+
+	return axd_write_reg_buf(cmd, reg, control);
+}
+
+int axd_cmd_output_set_dcpp_eq_mode(struct axd_cmd *cmd, unsigned int pipe,
+							unsigned int mode)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	reg = axd_get_output_dcpp_control_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return -1;
+	if (axd_read_reg(cmd, reg, &control))
+		return -1;
+
+	/* Conditionally mask in mode bit */
+	control ^= ((control ^ (mode << AXD_DCPP_CTRL_EQ_MODE_SHIFT))
+						& AXD_DCPP_CTRL_EQ_MODE_BITS);
+
+	return axd_write_reg_buf(cmd, reg, control);
+}
+
+int axd_cmd_output_set_dcpp_channel_delay_samples(struct axd_cmd *cmd,
+		unsigned int pipe, unsigned int channel, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+
+	reg = axd_get_output_dcpp_channel_delay_samples_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_channel_eq_output_volume(struct axd_cmd *cmd,
+		unsigned int pipe, unsigned int channel, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+
+	reg = axd_get_output_dcpp_channel_eq_output_volume_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_channel_eq_passthrough_gain(struct axd_cmd *cmd,
+		unsigned int pipe, unsigned int channel, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+
+	reg = axd_get_output_dcpp_channel_eq_passthrough_gain_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_channel_eq_inverse_passthrough_gain(
+					struct axd_cmd *cmd, unsigned int pipe,
+					unsigned int channel, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+
+	reg = axd_get_output_dcpp_channel_eq_inverse_passthrough_gain_reg(cmd,
+									pipe);
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_channel_bass_shelf_shift(struct axd_cmd *cmd,
+		unsigned int pipe, unsigned int channel, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+
+	reg = axd_get_output_dcpp_channel_bass_shelf_shift_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_channel_bass_shelf_a0(struct axd_cmd *cmd,
+		unsigned int pipe, unsigned int channel, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+
+	reg = axd_get_output_dcpp_channel_bass_shelf_a0_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_channel_bass_shelf_a1(struct axd_cmd *cmd,
+		unsigned int pipe, unsigned int channel, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+
+	reg = axd_get_output_dcpp_channel_bass_shelf_a1_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_channel_bass_shelf_a2(struct axd_cmd *cmd,
+		unsigned int pipe, unsigned int channel, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+
+	reg = axd_get_output_dcpp_channel_bass_shelf_a2_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_channel_bass_shelf_b0(struct axd_cmd *cmd,
+		unsigned int pipe, unsigned int channel, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+
+	reg = axd_get_output_dcpp_channel_bass_shelf_b0_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_channel_bass_shelf_b1(struct axd_cmd *cmd,
+		unsigned int pipe, unsigned int channel, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+
+	reg = axd_get_output_dcpp_channel_bass_shelf_b1_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_channel_treble_shelf_shift(struct axd_cmd *cmd,
+		unsigned int pipe, unsigned int channel, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+
+	reg = axd_get_output_dcpp_channel_treble_shelf_shift_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_channel_treble_shelf_a0(struct axd_cmd *cmd,
+		unsigned int pipe, unsigned int channel, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+
+	reg = axd_get_output_dcpp_channel_treble_shelf_a0_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_channel_treble_shelf_a1(struct axd_cmd *cmd,
+		unsigned int pipe, unsigned int channel, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+
+	reg = axd_get_output_dcpp_channel_treble_shelf_a1_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_channel_treble_shelf_a2(struct axd_cmd *cmd,
+		unsigned int pipe, unsigned int channel, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+
+	reg = axd_get_output_dcpp_channel_treble_shelf_a2_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_channel_treble_shelf_b0(struct axd_cmd *cmd,
+		unsigned int pipe, unsigned int channel, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+
+	reg = axd_get_output_dcpp_channel_treble_shelf_b0_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_channel_treble_shelf_b1(struct axd_cmd *cmd,
+		unsigned int pipe, unsigned int channel, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+
+	reg = axd_get_output_dcpp_channel_treble_shelf_b1_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_channel_eq_gain(struct axd_cmd *cmd,
+					unsigned int pipe, unsigned int channel,
+					unsigned int band, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+	axd_cmd_output_dcpp_select_band(cmd, pipe, band);
+
+	reg = axd_get_output_dcpp_channel_eq_gain_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_channel_eq_a0(struct axd_cmd *cmd,
+					unsigned int pipe, unsigned int channel,
+					unsigned int band, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+	axd_cmd_output_dcpp_select_band(cmd, pipe, band);
+
+	reg = axd_get_output_dcpp_channel_eq_a0_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_channel_eq_a1(struct axd_cmd *cmd,
+					unsigned int pipe, unsigned int channel,
+					unsigned int band, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+	axd_cmd_output_dcpp_select_band(cmd, pipe, band);
+
+	reg = axd_get_output_dcpp_channel_eq_a1_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_channel_eq_a2(struct axd_cmd *cmd,
+					unsigned int pipe, unsigned int channel,
+					unsigned int band, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+	axd_cmd_output_dcpp_select_band(cmd, pipe, band);
+
+	reg = axd_get_output_dcpp_channel_eq_a2_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_channel_eq_b0(struct axd_cmd *cmd,
+					unsigned int pipe, unsigned int channel,
+					unsigned int band, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+	axd_cmd_output_dcpp_select_band(cmd, pipe, band);
+
+	reg = axd_get_output_dcpp_channel_eq_b0_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_channel_eq_b1(struct axd_cmd *cmd,
+					unsigned int pipe, unsigned int channel,
+					unsigned int band, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+	axd_cmd_output_dcpp_select_band(cmd, pipe, band);
+
+	reg = axd_get_output_dcpp_channel_eq_b1_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_channel_eq_shift(struct axd_cmd *cmd,
+					unsigned int pipe, unsigned int channel,
+					unsigned int band, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+	axd_cmd_output_dcpp_select_band(cmd, pipe, band);
+
+	reg = axd_get_output_dcpp_channel_eq_shift_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_subband_enabled(struct axd_cmd *cmd,
+						unsigned int pipe, int enable)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	reg = axd_get_output_dcpp_control_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return -1;
+	if (axd_read_reg(cmd, reg, &control))
+		return -1;
+
+	if (enable)
+		control |= AXD_DCPP_CTRL_SUBBAND_ENABLE_BITS;
+	else
+		control &= ~AXD_DCPP_CTRL_SUBBAND_ENABLE_BITS;
+
+	return axd_write_reg_buf(cmd, reg, enable);
+}
+
+int axd_cmd_output_set_dcpp_subband_delay_samples(struct axd_cmd *cmd,
+					unsigned int pipe, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, true, 0);
+
+	reg = axd_get_output_dcpp_channel_delay_samples_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_subband_input_channel_mask(struct axd_cmd *cmd,
+					unsigned int pipe, unsigned int data)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	reg = axd_get_output_dcpp_control_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return -1;
+	if (axd_read_reg(cmd, reg, &control))
+		return -1;
+
+	control &= ~AXD_DCPP_CTRL_SUBBAND_CHANNEL_MASK_BITS;
+	control |= data << AXD_DCPP_CTRL_SUBBAND_CHANNEL_MASK_SHIFT;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_subband_eq_output_volume(struct axd_cmd *cmd,
+					unsigned int pipe, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, true, 0);
+
+	reg = axd_get_output_dcpp_channel_eq_output_volume_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_subband_eq_passthrough_gain(struct axd_cmd *cmd,
+					unsigned int pipe, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, true, 0);
+
+	reg = axd_get_output_dcpp_channel_eq_passthrough_gain_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_subband_eq_inverse_passthrough_gain(
+		struct axd_cmd *cmd, unsigned int pipe, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, true, 0);
+
+	reg = axd_get_output_dcpp_channel_eq_inverse_passthrough_gain_reg(cmd,
+									pipe);
+
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_subband_low_pass_filter_a0(struct axd_cmd *cmd,
+					unsigned int pipe, unsigned int data)
+{
+	unsigned int reg;
+
+	reg = axd_get_output_dcpp_subband_low_pass_filter_a0_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_subband_low_pass_filter_a1(struct axd_cmd *cmd,
+					unsigned int pipe, unsigned int data)
+{
+	unsigned int reg;
+
+	reg = axd_get_output_dcpp_subband_low_pass_filter_a1_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_subband_low_pass_filter_a2(struct axd_cmd *cmd,
+					unsigned int pipe, unsigned int data)
+{
+	unsigned int reg;
+
+	reg = axd_get_output_dcpp_subband_low_pass_filter_a2_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_subband_low_pass_filter_b0(struct axd_cmd *cmd,
+					unsigned int pipe, unsigned int data)
+{
+	unsigned int reg;
+
+	reg = axd_get_output_dcpp_subband_low_pass_filter_b0_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_subband_low_pass_filter_b1(struct axd_cmd *cmd,
+					unsigned int pipe, unsigned int data)
+{
+	unsigned int reg;
+
+	reg = axd_get_output_dcpp_subband_low_pass_filter_b1_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_subband_eq_gain(struct axd_cmd *cmd,
+			unsigned int pipe, unsigned int band, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, true, 0);
+	axd_cmd_output_dcpp_select_band(cmd, pipe, band);
+
+	reg = axd_get_output_dcpp_channel_eq_gain_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_subband_eq_a0(struct axd_cmd *cmd,
+			unsigned int pipe, unsigned int band, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, true, 0);
+	axd_cmd_output_dcpp_select_band(cmd, pipe, band);
+
+	reg = axd_get_output_dcpp_channel_eq_a0_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_subband_eq_a1(struct axd_cmd *cmd,
+			unsigned int pipe, unsigned int band, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, true, 0);
+	axd_cmd_output_dcpp_select_band(cmd, pipe, band);
+
+	reg = axd_get_output_dcpp_channel_eq_a1_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_subband_eq_a2(struct axd_cmd *cmd,
+			unsigned int pipe, unsigned int band, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, true, 0);
+	axd_cmd_output_dcpp_select_band(cmd, pipe, band);
+
+	reg = axd_get_output_dcpp_channel_eq_a2_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_subband_eq_b0(struct axd_cmd *cmd,
+			unsigned int pipe, unsigned int band, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, true, 0);
+	axd_cmd_output_dcpp_select_band(cmd, pipe, band);
+
+	reg = axd_get_output_dcpp_channel_eq_b0_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_subband_eq_b1(struct axd_cmd *cmd,
+			unsigned int pipe, unsigned int band, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, true, 0);
+	axd_cmd_output_dcpp_select_band(cmd, pipe, band);
+
+	reg = axd_get_output_dcpp_channel_eq_b1_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
+
+int axd_cmd_output_set_dcpp_subband_eq_shift(struct axd_cmd *cmd,
+			unsigned int pipe, unsigned int band, unsigned int data)
+{
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, true, 0);
+	axd_cmd_output_dcpp_select_band(cmd, pipe, band);
+
+	reg = axd_get_output_dcpp_channel_eq_shift_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return -1;
+
+	return axd_write_reg_buf(cmd, reg, data);
+}
diff --git a/sound/soc/img/axd/axd_cmds_decoder_config.c b/sound/soc/img/axd/axd_cmds_decoder_config.c
new file mode 100644
index 000000000000..3b4e15da724c
--- /dev/null
+++ b/sound/soc/img/axd/axd_cmds_decoder_config.c
@@ -0,0 +1,422 @@
+/*
+ * Copyright (C) 2011-2015 Imagination Technologies Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * AXD Commands API - Decoder Configuration functions
+ */
+#include <sound/compress_params.h>
+
+#include "axd_cmds.h"
+#include "axd_cmds_internal.h"
+
+/** PCM PASSTHROUGH (input) Config **/
+static int get_pcm_params(struct axd_cmd *cmd, unsigned int pipe,
+						struct snd_codec *codec)
+{
+	unsigned int reg;
+	unsigned int data;
+
+	reg = axd_get_decoder_pcm_samplerate_reg(cmd, pipe);
+	if (axd_read_reg(cmd, reg, &data))
+		return -1;
+	codec->sample_rate = data;
+
+	reg = axd_get_decoder_pcm_channels_reg(cmd, pipe);
+	if (axd_read_reg(cmd, reg, &data))
+		return -1;
+	codec->ch_in = data;
+	codec->ch_out = data;
+
+	return 0;
+}
+
+static int set_pcm_params(struct axd_cmd *cmd, unsigned int pipe,
+						struct snd_codec *codec)
+{
+	unsigned int reg;
+	unsigned int bitspersample;
+
+	switch (codec->sample_rate) {
+	case 16000:
+	case 32000:
+	case 44100:
+	case 48000:
+	case 64000:
+	case 96000:
+		break;
+	default:
+		return -1;
+	}
+	reg = axd_get_decoder_pcm_samplerate_reg(cmd, pipe);
+	axd_write_reg(cmd, reg, codec->sample_rate);
+
+	if (unlikely(codec->ch_in > 8))
+		return -1;
+	reg = axd_get_decoder_pcm_channels_reg(cmd, pipe);
+	axd_write_reg(cmd, reg, codec->ch_in);
+
+	bitspersample = codec->bit_rate / codec->sample_rate;
+	switch (bitspersample) {
+	case 8:
+	case 16:
+	case 24:
+	case 32:
+		break;
+	default:
+		return -1;
+	}
+	reg = axd_get_decoder_pcm_bitspersample_reg(cmd, pipe);
+	axd_write_reg(cmd, reg, bitspersample);
+
+	return 0;
+}
+
+/** MPEG (2/3) Config **/
+static int get_mpeg_params(struct axd_cmd *cmd, unsigned int pipe,
+						struct snd_codec *codec)
+{
+	unsigned int reg;
+	unsigned int data;
+
+	reg = axd_get_decoder_mpeg_numchannels_reg(cmd, pipe);
+	if (axd_read_reg(cmd, reg, &data))
+		return -1;
+	codec->ch_in = data;
+	codec->ch_out = data;
+
+	return 0;
+}
+
+static int set_mpeg_params(struct axd_cmd *cmd, unsigned int pipe,
+						struct snd_codec *codec)
+{
+	unsigned int reg;
+
+	if (unlikely(codec->ch_in > 2))
+		return -1;
+	reg = axd_get_decoder_mpeg_numchannels_reg(cmd, pipe);
+	axd_write_reg(cmd, reg, codec->ch_in);
+
+	return 0;
+}
+
+/** AAC Config **/
+static int get_aac_params(struct axd_cmd *cmd, unsigned int pipe,
+						struct snd_codec *codec)
+{
+	unsigned int reg;
+	unsigned int data;
+
+	reg = axd_get_decoder_aac_version_reg(cmd, pipe);
+	if (axd_read_reg(cmd, reg, &data))
+		return -1;
+	/* do something */
+
+	reg = axd_get_decoder_aac_channels_reg(cmd, pipe);
+	if (axd_read_reg(cmd, reg, &data))
+		return -1;
+	codec->ch_in = data;
+	codec->ch_out = data;
+
+	reg = axd_get_decoder_aac_profile_reg(cmd, pipe);
+	if (axd_read_reg(cmd, reg, &data))
+		return -1;
+	/* do something */
+
+	reg = axd_get_decoder_aac_streamtype_reg(cmd, pipe);
+	if (axd_read_reg(cmd, reg, &data))
+		return -1;
+	/* do something */
+
+	reg = axd_get_decoder_aac_samplerate_reg(cmd, pipe);
+	if (axd_read_reg(cmd, reg, &data))
+		return -1;
+	codec->sample_rate = data;
+
+	return 0;
+}
+
+static int set_aac_params(struct axd_cmd *cmd, unsigned int pipe,
+						struct snd_codec *codec)
+{
+	unsigned int reg;
+
+	/*
+	 * AXD AAC decoer version is not the same as AAC version.
+	 *
+	 * 0 -> MPEG2 LC
+	 * 1 -> MPEG4 LC
+	 * 2 -> MPEG4 HE
+	 * 3 -> MPEG4 DAB+
+	 *
+	 * 2 can actually decoder both MPEG4 LC and MPEG2 LC, so let's choose
+	 * it always.
+	 *
+	 * 3 is actually MPEG4 HE but it can only decode MPEG4 HE.
+	 */
+	reg = axd_get_decoder_aac_version_reg(cmd, pipe);
+	axd_write_reg(cmd, reg, 2);
+
+	reg = axd_get_decoder_aac_channels_reg(cmd, pipe);
+	axd_write_reg(cmd, reg, codec->ch_in);
+
+	/*
+	 * AXD supports the following profiles or modes in ALSA jargon
+	 *
+	 * 0 -> Main Profile (MP)
+	 * 1 -> Low Complexity (LC)
+	 * 2 -> Scalable Sample Rate (SSR)
+	 *
+	 * Not sure how to get that from snd_codec, so set it always to LC for
+	 * now.
+	 */
+	reg = axd_get_decoder_aac_profile_reg(cmd, pipe);
+	axd_write_reg(cmd, reg, 1);
+
+	/*
+	 * AXD supports the following stream types or formats
+	 *
+	 * 0 -> Auto Detect
+	 * 1 -> ADTS
+	 * 2 -> ADIF
+	 * 3 -> RAW
+	 */
+	reg = axd_get_decoder_aac_streamtype_reg(cmd, pipe);
+	switch (codec->format) {
+	case SND_AUDIOSTREAMFORMAT_MP2ADTS:
+	case SND_AUDIOSTREAMFORMAT_MP4ADTS:
+		axd_write_reg(cmd, reg, 1);
+		break;
+	case SND_AUDIOSTREAMFORMAT_ADIF:
+		axd_write_reg(cmd, reg, 2);
+		break;
+	case SND_AUDIOSTREAMFORMAT_RAW:
+		axd_write_reg(cmd, reg, 3);
+		break;
+	default:
+		/* should we set it to auto detect and see if we can play it? */
+		return -1;
+	}
+
+	reg = axd_get_decoder_aac_samplerate_reg(cmd, pipe);
+	axd_write_reg(cmd, reg, codec->sample_rate);
+
+	return 0;
+}
+
+/** FLAC Config **/
+static int get_flac_params(struct axd_cmd *cmd, unsigned int pipe,
+						struct snd_codec *codec)
+{
+	unsigned int reg;
+	unsigned int data;
+
+	reg = axd_get_decoder_flac_channels_reg(cmd, pipe);
+	if (axd_read_reg(cmd, reg, &data))
+		return -1;
+	codec->ch_in = data;
+	codec->ch_out = data;
+
+	reg = axd_get_decoder_flac_samplerate_reg(cmd, pipe);
+	if (axd_read_reg(cmd, reg, &data))
+		return -1;
+	codec->sample_rate = data;
+
+	reg = axd_get_decoder_flac_bitspersample_reg(cmd, pipe);
+	if (axd_read_reg(cmd, reg, &data))
+		return -1;
+	codec->bit_rate = data * codec->sample_rate;
+
+	reg = axd_get_decoder_flac_md5checking_reg(cmd, pipe);
+	if (axd_read_reg(cmd, reg, &data))
+		return -1;
+	/* do something */
+
+	return 0;
+}
+
+static int set_flac_params(struct axd_cmd *cmd, unsigned int pipe,
+						struct snd_codec *codec)
+{
+	unsigned int reg;
+
+	if (unlikely(codec->ch_in > 0x7))
+		return -1;
+	reg = axd_get_decoder_flac_channels_reg(cmd, pipe);
+	axd_write_reg(cmd, reg, codec->ch_in);
+
+	if (unlikely(codec->sample_rate > 0xFFFFF))
+		return -1;
+	reg = axd_get_decoder_flac_samplerate_reg(cmd, pipe);
+	axd_write_reg(cmd, reg, codec->sample_rate);
+
+	return 0;
+}
+
+/** WMA Config **/
+static int get_wma_params(struct axd_cmd *cmd, unsigned int pipe,
+						struct snd_codec *codec)
+{
+	unsigned int reg;
+	unsigned int data;
+
+	reg = axd_get_decoder_wma_playeropt_reg(cmd, pipe);
+	if (axd_read_reg(cmd, reg, &data))
+		return -1;
+
+	reg = axd_get_decoder_wma_drcsetting_reg(cmd, pipe);
+	if (axd_read_reg(cmd, reg, &data))
+		return -1;
+
+	reg = axd_get_decoder_wma_peakampref_reg(cmd, pipe);
+	if (axd_read_reg(cmd, reg, &data))
+		return -1;
+
+	reg = axd_get_decoder_wma_rmsampref_reg(cmd, pipe);
+	if (axd_read_reg(cmd, reg, &data))
+		return -1;
+
+	reg = axd_get_decoder_wma_peakamptarget_reg(cmd, pipe);
+	if (axd_read_reg(cmd, reg, &data))
+		return -1;
+
+	reg = axd_get_decoder_wma_rmsamptarget_reg(cmd, pipe);
+	if (axd_read_reg(cmd, reg, &data))
+		return -1;
+
+	reg = axd_get_decoder_wma_pcmvalidbitspersample_reg(cmd, pipe);
+	if (axd_read_reg(cmd, reg, &data))
+		return -1;
+
+	reg = axd_get_decoder_wma_pcmcontainersize_reg(cmd, pipe);
+	if (axd_read_reg(cmd, reg, &data))
+		return -1;
+
+	reg = axd_get_decoder_wma_wmaformattag_reg(cmd, pipe);
+	if (axd_read_reg(cmd, reg, &data))
+		return -1;
+
+	reg = axd_get_decoder_wma_wmanumchannels_reg(cmd, pipe);
+	if (axd_read_reg(cmd, reg, &data))
+		return -1;
+
+	reg = axd_get_decoder_wma_wmasamplespersec_reg(cmd, pipe);
+	if (axd_read_reg(cmd, reg, &data))
+		return -1;
+
+	reg = axd_get_decoder_wma_wmaaveragebytespersec_reg(cmd, pipe);
+	if (axd_read_reg(cmd, reg, &data))
+		return -1;
+
+	reg = axd_get_decoder_wma_wmablockalign_reg(cmd, pipe);
+	if (axd_read_reg(cmd, reg, &data))
+		return -1;
+
+	reg = axd_get_decoder_wma_wmavalidbitspersample_reg(cmd, pipe);
+	if (axd_read_reg(cmd, reg, &data))
+		return -1;
+
+	reg = axd_get_decoder_wma_wmachannelmask_reg(cmd, pipe);
+	if (axd_read_reg(cmd, reg, &data))
+		return -1;
+
+	reg = axd_get_decoder_wma_wmaencodeoptions_reg(cmd, pipe);
+	if (axd_read_reg(cmd, reg, &data))
+		return -1;
+
+	return 0;
+}
+
+static int set_wma_params(struct axd_cmd *cmd, unsigned int pipe,
+						struct snd_codec *codec)
+{
+	unsigned int reg;
+
+	reg = axd_get_decoder_wma_wmanumchannels_reg(cmd, pipe);
+	axd_write_reg(cmd, reg, codec->ch_in);
+
+	reg = axd_get_decoder_wma_wmasamplespersec_reg(cmd, pipe);
+	axd_write_reg(cmd, reg, codec->sample_rate);
+
+	return 0;
+}
+
+int axd_cmd_input_get_decoder_params(struct axd_cmd *cmd, unsigned int pipe,
+							struct snd_codec *codec)
+{
+	int ret;
+
+	switch (codec->id) {
+	case SND_AUDIOCODEC_PCM:
+		ret = axd_cmd_input_set_codec(cmd, pipe, 0);
+		if (ret)
+			break;
+		return get_pcm_params(cmd, pipe, codec);
+	case SND_AUDIOCODEC_MP3:
+		ret = axd_cmd_input_set_codec(cmd, pipe, 1);
+		if (ret)
+			break;
+		return get_mpeg_params(cmd, pipe, codec);
+	case SND_AUDIOCODEC_AAC:
+		ret = axd_cmd_input_set_codec(cmd, pipe, 3);
+		if (ret)
+			break;
+		return get_aac_params(cmd, pipe, codec);
+	case SND_AUDIOCODEC_WMA:
+		ret = axd_cmd_input_set_codec(cmd, pipe, 7);
+		if (ret)
+			break;
+		return get_wma_params(cmd, pipe, codec);
+	case SND_AUDIOCODEC_FLAC:
+		ret = axd_cmd_input_set_codec(cmd, pipe, 5);
+		if (ret)
+			break;
+		return get_flac_params(cmd, pipe, codec);
+	}
+
+	return -1;
+}
+
+int axd_cmd_input_set_decoder_params(struct axd_cmd *cmd, unsigned int pipe,
+							struct snd_codec *codec)
+{
+	int ret;
+
+	switch (codec->id) {
+	case SND_AUDIOCODEC_PCM:
+		ret = axd_cmd_input_set_codec(cmd, pipe, 0);
+		if (ret)
+			break;
+		return set_pcm_params(cmd, pipe, codec);
+	case SND_AUDIOCODEC_MP3:
+		ret = axd_cmd_input_set_codec(cmd, pipe, 1);
+		if (ret)
+			break;
+		return set_mpeg_params(cmd, pipe, codec);
+	case SND_AUDIOCODEC_AAC:
+		ret = axd_cmd_input_set_codec(cmd, pipe, 3);
+		if (ret)
+			break;
+		return set_aac_params(cmd, pipe, codec);
+	case SND_AUDIOCODEC_WMA:
+		ret = axd_cmd_input_set_codec(cmd, pipe, 7);
+		if (ret)
+			break;
+		return set_wma_params(cmd, pipe, codec);
+	case SND_AUDIOCODEC_FLAC:
+		ret = axd_cmd_input_set_codec(cmd, pipe, 5);
+		if (ret)
+			break;
+		return set_flac_params(cmd, pipe, codec);
+	}
+
+	return -1;
+}
diff --git a/sound/soc/img/axd/axd_cmds_info.c b/sound/soc/img/axd/axd_cmds_info.c
new file mode 100644
index 000000000000..9347cf7ff7cd
--- /dev/null
+++ b/sound/soc/img/axd/axd_cmds_info.c
@@ -0,0 +1,1249 @@
+/*
+ * Copyright (C) 2011-2015 Imagination Technologies Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * AXD Commands API - Info functions.
+ */
+#include <linux/bitops.h>
+#include <sound/compress_offload.h>
+
+#include "axd_cmds.h"
+#include "axd_cmds_internal.h"
+
+/* Fills @caps with the list of codecs as set in the bit map @bits */
+static void parse_codec_by_bit(unsigned int bits, struct snd_compr_caps *caps)
+{
+	if (bits & BIT(0)) {
+		caps->codecs[caps->num_codecs] = SND_AUDIOCODEC_PCM;
+		caps->num_codecs++;
+	}
+	if (bits & BIT(1)) {
+		caps->codecs[caps->num_codecs] = SND_AUDIOCODEC_MP3;
+		caps->num_codecs++;
+	}
+	if (bits & BIT(3)) {
+		caps->codecs[caps->num_codecs] = SND_AUDIOCODEC_AAC;
+		caps->num_codecs++;
+	}
+	if (bits & BIT(4)) {
+		caps->codecs[caps->num_codecs] = SND_AUDIOCODEC_VORBIS;
+		caps->num_codecs++;
+	}
+	if (bits & BIT(5)) {
+		caps->codecs[caps->num_codecs] = SND_AUDIOCODEC_FLAC;
+		caps->num_codecs++;
+	}
+	if (bits & BIT(7)) {
+		caps->codecs[caps->num_codecs] = SND_AUDIOCODEC_WMA;
+		caps->num_codecs++;
+	}
+}
+
+/* Info API */
+/* Sets the major and minor numbers of the currently running AXD firmware */
+void axd_cmd_get_version(struct axd_cmd *cmd,
+					int *major, int *minor, int *patch)
+{
+	unsigned int version;
+
+	axd_read_reg(cmd, AXD_REG_VERSION, &version);
+	if (unlikely(!major || !minor))
+		return;
+	*major = (version >> 22);		/* top 10 bits */
+	*minor = (version >> 12) & 0x3FF;	/* middle 10 bits */
+	*patch = version & 0xFFF;		/* bottom 12 bits */
+}
+
+/* Sets the number of supported in/out pipes */
+int axd_cmd_get_num_pipes(struct axd_cmd *cmd,
+				unsigned int *inpipes, unsigned int *outpipes)
+{
+	unsigned int config0;
+	int ret;
+
+	ret = axd_read_reg(cmd, AXD_REG_CONFIG0, &config0);
+	if (unlikely(!inpipes || !outpipes))
+		return -1;
+	if (ret)
+		return -1;
+	*inpipes = config0 >> 16;
+	*inpipes &= 0xFF;
+	*outpipes = config0 & 0xFF;
+	return 0;
+}
+
+/* Fills @codecs with a list of supported codecs */
+void axd_cmd_get_decoders(struct axd_cmd *cmd, struct snd_compr_caps *caps)
+{
+	unsigned int config1;
+
+	axd_read_reg(cmd, AXD_REG_CONFIG1, &config1);
+	if (unlikely(!caps))
+		return;
+	parse_codec_by_bit(config1, caps);
+}
+
+/* Fills @codecs with a list of supported codecs */
+void axd_cmd_get_encoders(struct axd_cmd *cmd, struct snd_compr_caps *caps)
+{
+	unsigned int config2;
+
+	axd_read_reg(cmd, AXD_REG_CONFIG2, &config2);
+	if (unlikely(!caps))
+		return;
+	parse_codec_by_bit(config2, caps);
+}
+
+/* Returns non-zero if Mix/Xbar is present. Zero otherwise. */
+int axd_cmd_xbar_present(struct axd_cmd *cmd)
+{
+	unsigned int temp;
+
+	axd_read_reg(cmd, AXD_REG_CONFIG3, &temp);
+	return temp & 0x1;
+}
+
+/* Returns non-zero if mixer EQ is enabled. Zero otherwise. */
+int axd_cmd_mixer_get_eqenabled(struct axd_cmd *cmd, unsigned int pipe)
+{
+	unsigned int control;
+
+	axd_read_reg(cmd, AXD_REG_EQ_CTRL_GAIN, &control);
+	return (control & AXD_EQCTRL_ENABLE_BITS) >> AXD_EQCTRL_ENABLE_SHIFT;
+}
+
+/* Sets @gain to the currently set output EQ Master gain value */
+void axd_cmd_mixer_get_eqmastergain(struct axd_cmd *cmd, unsigned int pipe,
+								int *gain)
+{
+	unsigned int control;
+
+	axd_read_reg(cmd, AXD_REG_EQ_CTRL_GAIN, &control);
+	*gain = (control & AXD_EQCTRL_GAIN_BITS) >> AXD_EQCTRL_GAIN_SHIFT;
+}
+
+/* Sets @gain to the currently set output EQ Band0 gain value */
+void axd_cmd_mixer_get_eqband0gain(struct axd_cmd *cmd, unsigned int pipe,
+								int *gain)
+{
+	unsigned int temp;
+
+	axd_read_reg(cmd, AXD_REG_EQ_BAND0, &temp);
+	*gain = ((int)temp & AXD_EQBANDX_GAIN_BITS) >> AXD_EQBANDX_GAIN_SHIFT;
+}
+
+/* Sets @gain to the currently set output EQ Band1 gain value */
+void axd_cmd_mixer_get_eqband1gain(struct axd_cmd *cmd, unsigned int pipe,
+								int *gain)
+{
+	unsigned int  temp;
+
+	axd_read_reg(cmd, AXD_REG_EQ_BAND1, &temp);
+	*gain = ((int)temp & AXD_EQBANDX_GAIN_BITS) >> AXD_EQBANDX_GAIN_SHIFT;
+}
+
+/* Sets @gain to the currently set output EQ Band2 gain value */
+void axd_cmd_mixer_get_eqband2gain(struct axd_cmd *cmd, unsigned int pipe,
+								int *gain)
+{
+	unsigned int  temp;
+
+	axd_read_reg(cmd, AXD_REG_EQ_BAND2, &temp);
+	*gain = ((int)temp & AXD_EQBANDX_GAIN_BITS) >> AXD_EQBANDX_GAIN_SHIFT;
+}
+
+/* Sets @gain to the currently set output EQ Band3 gain value */
+void axd_cmd_mixer_get_eqband3gain(struct axd_cmd *cmd, unsigned int pipe,
+								int *gain)
+{
+	unsigned int  temp;
+
+	axd_read_reg(cmd, AXD_REG_EQ_BAND3, &temp);
+	*gain = ((int)temp & AXD_EQBANDX_GAIN_BITS) >> AXD_EQBANDX_GAIN_SHIFT;
+}
+
+/* Sets @gain to the currently set output EQ Band4 gain value */
+void axd_cmd_mixer_get_eqband4gain(struct axd_cmd *cmd, unsigned int pipe,
+								int *gain)
+{
+	unsigned int  temp;
+
+	axd_read_reg(cmd, AXD_REG_EQ_BAND4, &temp);
+	*gain = ((int)temp & AXD_EQBANDX_GAIN_BITS) >> AXD_EQBANDX_GAIN_SHIFT;
+}
+
+/*
+ * Returns to the currently selected mux output @pipe of mixer
+ *
+ * 0 = mixer
+ * 1 = input 0
+ * 2 = input 1
+ * 3 = input 2
+ * 4 = input 3
+ */
+int axd_cmd_mixer_get_mux(struct axd_cmd *cmd, unsigned int pipe)
+{
+	unsigned int reg = axd_get_mixer_mux_reg(cmd, pipe);
+	unsigned int setting;
+
+	if (unlikely(!reg))
+		return -1;
+	axd_read_reg(cmd, reg, &setting);
+	return setting;
+}
+
+/* Returns non-zero of input @pipe is enabled. Zero otherwise. */
+int axd_cmd_input_get_enabled(struct axd_cmd *cmd, unsigned int pipe)
+{
+	unsigned int reg = axd_get_input_control_reg(cmd, pipe);
+	unsigned int control;
+
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return (control & AXD_INCTRL_ENABLE_BITS) >> AXD_INCTRL_ENABLE_SHIFT;
+}
+
+/*
+ * Returns the currently selected source of input @pipe
+ *
+ * 0 = pipe (buffer) mode
+ * 1 = aux input
+ */
+int axd_cmd_input_get_source(struct axd_cmd *cmd, unsigned int pipe)
+{
+	unsigned int reg = axd_get_input_control_reg(cmd, pipe);
+	unsigned int control;
+
+	if (unlikely(!reg))
+		return -1;
+	axd_read_reg(cmd, reg, &control);
+	return (control & AXD_INCTRL_SOURCE_BITS) >> AXD_INCTRL_SOURCE_SHIFT;
+}
+
+/* Returns the currently selected codec of input @pipe */
+int axd_cmd_input_get_codec(struct axd_cmd *cmd, unsigned int pipe)
+{
+	unsigned int codec_num = axd_get_input_codec_number(cmd, pipe);
+
+	switch (codec_num) {
+	case 0:
+		return SND_AUDIOCODEC_PCM;
+	case 1:
+		return SND_AUDIOCODEC_MP3;
+	case 3:
+		return SND_AUDIOCODEC_AAC;
+	case 4:
+		return SND_AUDIOCODEC_VORBIS;
+	case 5:
+		return SND_AUDIOCODEC_FLAC;
+	case 7:
+		return SND_AUDIOCODEC_WMA;
+	default:
+		return -EINVAL;
+	}
+}
+
+/* Sets @gain to the currently set input gain value */
+void axd_cmd_input_get_gain(struct axd_cmd *cmd, unsigned int pipe,
+								int *gain)
+{
+	unsigned int reg = axd_get_input_gain_reg(cmd, pipe);
+
+	if (unlikely(!reg || !gain))
+		return;
+	axd_read_reg(cmd, reg, gain);
+}
+
+/* Sets @gain to the currently set input gain value */
+void axd_cmd_input_get_mute(struct axd_cmd *cmd, unsigned int pipe,
+								int *muted)
+{
+	unsigned int reg = axd_get_input_gain_reg(cmd, pipe);
+
+	if (unlikely(!reg || !muted))
+		return;
+	axd_read_reg(cmd, reg, muted);
+}
+
+/*
+ * Returns the currently selected upmix setting of input @pipe
+ *
+ * 0 = Pass Through
+ * 1 = Simple 5.1
+ * 2 = Dolby Pro Logic 2
+ */
+int axd_cmd_input_get_upmix(struct axd_cmd *cmd, unsigned int pipe)
+{
+	unsigned int reg = axd_get_input_upmix_reg(cmd, pipe);
+	unsigned int setting;
+
+	if (unlikely(!reg))
+		return -1;
+	axd_read_reg(cmd, reg, &setting);
+	return setting;
+}
+
+/* Returns the buffer occupancy value of @pipe. */
+unsigned int axd_cmd_input_get_buffer_occupancy(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	unsigned int bo;
+	unsigned int reg = axd_get_input_buffer_occupancy_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &bo);
+	return bo;
+}
+
+/* Returns non-zero of output @pipe is enabled. Zero otherwise. */
+int axd_cmd_output_get_enabled(struct axd_cmd *cmd, unsigned int pipe)
+{
+	unsigned int reg = axd_get_output_control_reg(cmd, pipe);
+	unsigned int control;
+
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return (control & AXD_OUTCTRL_ENABLE_BITS) >> AXD_OUTCTRL_ENABLE_SHIFT;
+}
+
+/* Returns the currently selected codec of output @pipe */
+int axd_cmd_output_get_codec(struct axd_cmd *cmd, unsigned int pipe)
+{
+	unsigned int codec_num = axd_get_output_codec_number(cmd, pipe);
+
+	switch (codec_num) {
+	case 0:
+		return SND_AUDIOCODEC_PCM;
+	case 1:
+		return SND_AUDIOCODEC_MP3;
+	case 3:
+		return SND_AUDIOCODEC_AAC;
+	case 4:
+		return SND_AUDIOCODEC_VORBIS;
+	case 5:
+		return SND_AUDIOCODEC_FLAC;
+	case 7:
+		return SND_AUDIOCODEC_WMA;
+	default:
+		return -EINVAL;
+	}
+}
+
+/*
+ * Returns the currently selected sink of output @pipe
+ *
+ * 0 = pipe (buffer) mode
+ * 1 = i2s output
+ */
+int axd_cmd_output_get_sink(struct axd_cmd *cmd, unsigned int pipe)
+{
+	unsigned int reg = axd_get_output_control_reg(cmd, pipe);
+	unsigned int control;
+
+	if (unlikely(!reg))
+		return -1;
+	axd_read_reg(cmd, reg, &control);
+	return (control & AXD_OUTCTRL_SINK_BITS) >> AXD_OUTCTRL_SINK_SHIFT;
+}
+
+/*
+ * Returns the currently selected downmix setting of output @pipe
+ *
+ * 0 = pass through
+ * 1 = 5.1
+ * 2 = 2.0
+ */
+int axd_cmd_output_get_downmix(struct axd_cmd *cmd, unsigned int pipe)
+{
+	unsigned int reg = axd_get_output_downmix_reg(cmd, pipe);
+	unsigned int setting;
+
+	if (unlikely(!reg))
+		return -1;
+	axd_read_reg(cmd, reg, &setting);
+	return setting;
+}
+
+/* Returns non-zero of output @pipe EQ is enabled. Zero otherwise. */
+int axd_cmd_output_get_eqenabled(struct axd_cmd *cmd, unsigned int pipe)
+{
+	unsigned int reg = axd_get_output_eqcontrol_reg(cmd, pipe);
+	unsigned int control;
+
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return (control & AXD_EQCTRL_ENABLE_BITS) >> AXD_EQCTRL_ENABLE_SHIFT;
+}
+
+/* Sets @gain to the currently set output EQ Master gain value */
+void axd_cmd_output_get_eqmastergain(struct axd_cmd *cmd, unsigned int pipe,
+								int *gain)
+{
+	unsigned int reg = axd_get_output_eqcontrol_reg(cmd, pipe);
+	unsigned int temp;
+
+	if (unlikely(!reg || !gain))
+		return;
+	axd_read_reg(cmd, reg, &temp);
+	*gain = ((int)temp & AXD_EQCTRL_GAIN_BITS) >> AXD_EQCTRL_GAIN_SHIFT;
+}
+
+/* Sets @gain to the currently set output EQ Band0 gain value */
+void axd_cmd_output_get_eqband0gain(struct axd_cmd *cmd, unsigned int pipe,
+								int *gain)
+{
+	unsigned int reg = axd_get_output_eqband0_reg(cmd, pipe);
+	unsigned int temp;
+
+	if (unlikely(!reg || !gain))
+		return;
+	axd_read_reg(cmd, reg, &temp);
+	*gain = ((int)temp & AXD_EQBANDX_GAIN_BITS) >> AXD_EQBANDX_GAIN_SHIFT;
+}
+
+/* Sets @gain to the currently set output EQ Band1 gain value */
+void axd_cmd_output_get_eqband1gain(struct axd_cmd *cmd, unsigned int pipe,
+								int *gain)
+{
+	unsigned int reg = axd_get_output_eqband1_reg(cmd, pipe);
+	unsigned int temp;
+
+	if (unlikely(!reg || !gain))
+		return;
+	axd_read_reg(cmd, reg, &temp);
+	*gain = ((int)temp & AXD_EQBANDX_GAIN_BITS) >> AXD_EQBANDX_GAIN_SHIFT;
+}
+
+/* Sets @gain to the currently set output EQ Band2 gain value */
+void axd_cmd_output_get_eqband2gain(struct axd_cmd *cmd, unsigned int pipe,
+								int *gain)
+{
+	unsigned int reg = axd_get_output_eqband2_reg(cmd, pipe);
+	unsigned int temp;
+
+	if (unlikely(!reg || !gain))
+		return;
+	axd_read_reg(cmd, reg, &temp);
+	*gain = ((int)temp & AXD_EQBANDX_GAIN_BITS) >> AXD_EQBANDX_GAIN_SHIFT;
+}
+
+/* Sets @gain to the currently set output EQ Band3 gain value */
+void axd_cmd_output_get_eqband3gain(struct axd_cmd *cmd, unsigned int pipe,
+								int *gain)
+{
+	unsigned int reg = axd_get_output_eqband3_reg(cmd, pipe);
+	unsigned int temp;
+
+	if (unlikely(!reg || !gain))
+		return;
+	axd_read_reg(cmd, reg, &temp);
+	*gain = ((int)temp & AXD_EQBANDX_GAIN_BITS) >> AXD_EQBANDX_GAIN_SHIFT;
+}
+
+/* Sets @gain to the currently set output EQ Band4 gain value */
+void axd_cmd_output_get_eqband4gain(struct axd_cmd *cmd, unsigned int pipe,
+								int *gain)
+{
+	unsigned int reg = axd_get_output_eqband4_reg(cmd, pipe);
+	unsigned int temp;
+
+	if (unlikely(!reg || !gain))
+		return;
+	axd_read_reg(cmd, reg, &temp);
+	*gain = ((int)temp & AXD_EQBANDX_GAIN_BITS) >> AXD_EQBANDX_GAIN_SHIFT;
+}
+
+void axd_cmd_output_get_geq_power(struct axd_cmd *cmd, unsigned int pipe,
+							char *buf, int channel)
+{
+	u32 data[5];
+	int i;
+
+	if (channel < 4) {
+		for (i = 0; i < 5; i++) {
+			u32 reg = axd_get_output_eq_power_reg_ch0_3(cmd,
+								pipe, i);
+
+			if (unlikely(!reg))
+				return;
+
+			if (axd_read_reg(cmd, reg, &data[i]))
+				return;
+		}
+
+		sprintf(buf, "%d, %d, %d, %d, %d\n",
+				(data[0] >> (channel * 8)) & 0xFF,
+				(data[1] >> (channel * 8)) & 0xFF,
+				(data[2] >> (channel * 8)) & 0xFF,
+				(data[3] >> (channel * 8)) & 0xFF,
+				(data[3] >> (channel * 8)) & 0xFF);
+
+	} else {
+		for (i = 0; i < 5; i++) {
+			u32 reg = axd_get_output_eq_power_reg_ch4_7(cmd,
+								pipe, i);
+
+			if (unlikely(!reg))
+				return;
+
+			if (axd_read_reg(cmd, reg, &data[i]))
+				return;
+		}
+
+		sprintf(buf, "%d, %d, %d, %d, %d\n",
+				(data[0] >> (channel-4 * 8)) & 0xFF,
+				(data[1] >> (channel-4 * 8)) & 0xFF,
+				(data[2] >> (channel-4 * 8)) & 0xFF,
+				(data[3] >> (channel-4 * 8)) & 0xFF,
+				(data[4] >> (channel-4 * 8)) & 0xFF);
+	}
+}
+
+unsigned int axd_cmd_info_get_resampler_fin(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	unsigned int temp;
+	unsigned int reg = axd_get_resample_fin_reg(cmd, pipe);
+
+	axd_read_reg(cmd, reg, &temp);
+
+	return temp;
+}
+
+unsigned int axd_cmd_info_get_resampler_fout(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	unsigned int temp;
+	unsigned int reg = axd_get_resample_fout_reg(cmd, pipe);
+
+	axd_read_reg(cmd, reg, &temp);
+
+	return temp;
+}
+
+void axd_cmd_info_set_resampler_fout(struct axd_cmd *cmd,
+					unsigned int pipe, unsigned int fout)
+{
+	unsigned int reg = axd_get_resample_fout_reg(cmd, pipe);
+
+	axd_write_reg(cmd, reg, fout);
+}
+
+unsigned int axd_cmd_output_get_dcpp_enabled(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	unsigned int reg = axd_get_output_dcpp_control_reg(cmd, pipe);
+	unsigned int control;
+
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return (control & AXD_DCPP_CTRL_ENABLE_BITS) >>
+						AXD_DCPP_CTRL_ENABLE_SHIFT;
+}
+
+unsigned int axd_cmd_output_get_dcpp_mode(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	unsigned int reg = axd_get_output_dcpp_control_reg(cmd, pipe);
+	unsigned int control;
+
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return (control & AXD_DCPP_CTRL_MODE_BITS) >> AXD_DCPP_CTRL_MODE_SHIFT;
+}
+
+unsigned int axd_cmd_output_get_dcpp_channels(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	unsigned int reg = axd_get_output_dcpp_control_reg(cmd, pipe);
+	unsigned int control;
+
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return (control & AXD_DCPP_CTRL_CHANNELS_BITS) >>
+						AXD_DCPP_CTRL_CHANNELS_SHIFT;
+}
+
+unsigned int axd_cmd_output_get_dcpp_eq_mode(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	unsigned int reg = axd_get_output_dcpp_control_reg(cmd, pipe);
+	unsigned int control;
+
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return (control & AXD_DCPP_CTRL_EQ_MODE_BITS) >>
+						AXD_DCPP_CTRL_EQ_MODE_SHIFT;
+}
+
+unsigned int axd_cmd_output_get_dcpp_eq_bands(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	unsigned int reg = axd_get_output_dcpp_control_reg(cmd, pipe);
+	unsigned int control;
+
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return (control & AXD_DCPP_CTRL_EQ_BANDS_BITS) >>
+						AXD_DCPP_CTRL_EQ_BANDS_SHIFT;
+}
+
+unsigned int axd_cmd_output_get_dcpp_max_delay_samples(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	unsigned int reg = axd_get_output_dcpp_max_delay_samples_reg(cmd, pipe);
+	unsigned int control;
+
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_channel_delay_samples(struct axd_cmd *cmd,
+				unsigned int pipe, unsigned int channel)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+
+	reg = axd_get_output_dcpp_channel_delay_samples_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_channel_eq_output_volume(
+		struct axd_cmd *cmd, unsigned int pipe, unsigned int channel)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+
+	reg = axd_get_output_dcpp_channel_eq_output_volume_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_channel_eq_passthrough_gain(
+		struct axd_cmd *cmd, unsigned int pipe, unsigned int channel)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+
+	reg = axd_get_output_dcpp_channel_eq_passthrough_gain_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_channel_eq_inverse_passthrough_gain(
+		struct axd_cmd *cmd, unsigned int pipe, unsigned int channel)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+
+	reg = axd_get_output_dcpp_channel_eq_inverse_passthrough_gain_reg(cmd,
+									pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_channel_bass_shelf_shift(
+		struct axd_cmd *cmd, unsigned int pipe, unsigned int channel)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+
+	reg = axd_get_output_dcpp_channel_bass_shelf_shift_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_channel_bass_shelf_a0(struct axd_cmd *cmd,
+				unsigned int pipe, unsigned int channel)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+
+	reg = axd_get_output_dcpp_channel_bass_shelf_a0_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_channel_bass_shelf_a1(struct axd_cmd *cmd,
+				unsigned int pipe, unsigned int channel)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+
+	reg = axd_get_output_dcpp_channel_bass_shelf_a1_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_channel_bass_shelf_a2(struct axd_cmd *cmd,
+				unsigned int pipe, unsigned int channel)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+
+	reg = axd_get_output_dcpp_channel_bass_shelf_a2_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_channel_bass_shelf_b0(struct axd_cmd *cmd,
+				unsigned int pipe, unsigned int channel)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+
+	reg = axd_get_output_dcpp_channel_bass_shelf_b0_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_channel_bass_shelf_b1(struct axd_cmd *cmd,
+				unsigned int pipe, unsigned int channel)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+
+	reg = axd_get_output_dcpp_channel_bass_shelf_b1_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_channel_treble_shelf_shift(
+		struct axd_cmd *cmd, unsigned int pipe, unsigned int channel)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+
+	reg = axd_get_output_dcpp_channel_treble_shelf_shift_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_channel_treble_shelf_a0(
+		struct axd_cmd *cmd, unsigned int pipe, unsigned int channel)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+
+	reg = axd_get_output_dcpp_channel_treble_shelf_a0_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_channel_treble_shelf_a1(
+		struct axd_cmd *cmd, unsigned int pipe, unsigned int channel)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+
+	reg = axd_get_output_dcpp_channel_treble_shelf_a1_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_channel_treble_shelf_a2(
+		struct axd_cmd *cmd, unsigned int pipe, unsigned int channel)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+
+	reg = axd_get_output_dcpp_channel_treble_shelf_a2_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_channel_treble_shelf_b0(
+		struct axd_cmd *cmd, unsigned int pipe, unsigned int channel)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+
+	reg = axd_get_output_dcpp_channel_treble_shelf_b0_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_channel_treble_shelf_b1(
+		struct axd_cmd *cmd, unsigned int pipe, unsigned int channel)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+
+	reg = axd_get_output_dcpp_channel_treble_shelf_b1_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_channel_eq_gain(struct axd_cmd *cmd,
+		unsigned int pipe, unsigned int channel, unsigned int band)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+	axd_cmd_output_dcpp_select_band(cmd, pipe, band);
+
+	reg = axd_get_output_dcpp_channel_eq_gain_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_channel_eq_a0(struct axd_cmd *cmd,
+		unsigned int pipe, unsigned int channel, unsigned int band)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+	axd_cmd_output_dcpp_select_band(cmd, pipe, band);
+
+	reg = axd_get_output_dcpp_channel_eq_a0_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_channel_eq_a1(struct axd_cmd *cmd,
+		unsigned int pipe, unsigned int channel, unsigned int band)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+	axd_cmd_output_dcpp_select_band(cmd, pipe, band);
+
+	reg = axd_get_output_dcpp_channel_eq_a1_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_channel_eq_a2(struct axd_cmd *cmd,
+		unsigned int pipe, unsigned int channel, unsigned int band)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+	axd_cmd_output_dcpp_select_band(cmd, pipe, band);
+
+	reg = axd_get_output_dcpp_channel_eq_a2_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_channel_eq_b0(struct axd_cmd *cmd,
+		unsigned int pipe, unsigned int channel, unsigned int band)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+	axd_cmd_output_dcpp_select_band(cmd, pipe, band);
+
+	reg = axd_get_output_dcpp_channel_eq_b0_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_channel_eq_b1(struct axd_cmd *cmd,
+		unsigned int pipe, unsigned int channel, unsigned int band)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+	axd_cmd_output_dcpp_select_band(cmd, pipe, band);
+
+	reg = axd_get_output_dcpp_channel_eq_b1_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_channel_eq_shift(struct axd_cmd *cmd,
+		unsigned int pipe, unsigned int channel, unsigned int band)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, false, channel);
+	axd_cmd_output_dcpp_select_band(cmd, pipe, band);
+
+	reg = axd_get_output_dcpp_channel_eq_shift_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_subband_eq_bands(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	unsigned int reg = axd_get_output_dcpp_control_reg(cmd, pipe);
+	unsigned int control;
+
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return (control & AXD_DCPP_CTRL_SUBBAND_EQ_BANDS_BITS)
+				>> AXD_DCPP_CTRL_SUBBAND_EQ_BANDS_SHIFT;
+}
+
+unsigned int axd_cmd_output_get_dcpp_subband_enabled(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	unsigned int reg = axd_get_output_dcpp_control_reg(cmd, pipe);
+	unsigned int control;
+
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return (control & AXD_DCPP_CTRL_SUBBAND_ENABLE_BITS)
+				>> AXD_DCPP_CTRL_SUBBAND_ENABLE_SHIFT;
+}
+
+unsigned int axd_cmd_output_get_dcpp_subband_input_channel_mask(
+					struct axd_cmd *cmd, unsigned int pipe)
+{
+	unsigned int reg = axd_get_output_dcpp_control_reg(cmd, pipe);
+	unsigned int control;
+
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return (control & AXD_DCPP_CTRL_SUBBAND_CHANNEL_MASK_BITS)
+				>> AXD_DCPP_CTRL_SUBBAND_CHANNEL_MASK_SHIFT;
+}
+
+unsigned int axd_cmd_output_get_dcpp_subband_delay_samples(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, true, 0);
+
+	reg = axd_get_output_dcpp_channel_delay_samples_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_subband_eq_output_volume(
+					struct axd_cmd *cmd, unsigned int pipe)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, true, 0);
+
+	reg = axd_get_output_dcpp_channel_eq_output_volume_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_subband_eq_passthrough_gain(
+					struct axd_cmd *cmd, unsigned int pipe)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, true, 0);
+
+	reg = axd_get_output_dcpp_channel_eq_passthrough_gain_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_subband_eq_inverse_passthrough_gain(
+					struct axd_cmd *cmd, unsigned int pipe)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, true, 0);
+
+	reg = axd_get_output_dcpp_channel_eq_inverse_passthrough_gain_reg(cmd,
+									pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_subband_eq_gain(struct axd_cmd *cmd,
+					unsigned int pipe, unsigned int band)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, true, 0);
+	axd_cmd_output_dcpp_select_band(cmd, pipe, band);
+
+	reg = axd_get_output_dcpp_channel_eq_gain_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_subband_eq_a0(struct axd_cmd *cmd,
+					unsigned int pipe, unsigned int band)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, true, 0);
+	axd_cmd_output_dcpp_select_band(cmd, pipe, band);
+
+	reg = axd_get_output_dcpp_channel_eq_a0_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_subband_eq_a1(struct axd_cmd *cmd,
+					unsigned int pipe, unsigned int band)
+{
+	unsigned int control;
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, true, 0);
+	axd_cmd_output_dcpp_select_band(cmd, pipe, band);
+
+	reg = axd_get_output_dcpp_channel_eq_a1_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_subband_eq_a2(struct axd_cmd *cmd,
+					unsigned int pipe, unsigned int band)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, true, 0);
+	axd_cmd_output_dcpp_select_band(cmd, pipe, band);
+
+	reg = axd_get_output_dcpp_channel_eq_a2_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_subband_eq_b0(struct axd_cmd *cmd,
+					unsigned int pipe, unsigned int band)
+{
+	unsigned int control;
+	unsigned int reg;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, true, 0);
+	axd_cmd_output_dcpp_select_band(cmd, pipe, band);
+
+	reg = axd_get_output_dcpp_channel_eq_b0_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_subband_eq_b1(struct axd_cmd *cmd,
+					unsigned int pipe, unsigned int band)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, true, 0);
+	axd_cmd_output_dcpp_select_band(cmd, pipe, band);
+
+	reg = axd_get_output_dcpp_channel_eq_b1_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_subband_eq_shift(struct axd_cmd *cmd,
+					unsigned int pipe, unsigned int band)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	axd_cmd_output_dcpp_select_channel(cmd, pipe, true, 0);
+	axd_cmd_output_dcpp_select_band(cmd, pipe, band);
+
+	reg = axd_get_output_dcpp_channel_eq_shift_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_subband_low_pass_filter_a0(
+					struct axd_cmd *cmd, unsigned int pipe)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	reg = axd_get_output_dcpp_subband_low_pass_filter_a0_reg(cmd, pipe);
+
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_subband_low_pass_filter_a1(
+					struct axd_cmd *cmd, unsigned int pipe)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	reg = axd_get_output_dcpp_subband_low_pass_filter_a1_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_subband_low_pass_filter_a2(
+					struct axd_cmd *cmd, unsigned int pipe)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	reg = axd_get_output_dcpp_subband_low_pass_filter_a2_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_subband_low_pass_filter_b0(
+					struct axd_cmd *cmd, unsigned int pipe)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	reg = axd_get_output_dcpp_subband_low_pass_filter_b0_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
+
+unsigned int axd_cmd_output_get_dcpp_subband_low_pass_filter_b1(
+					struct axd_cmd *cmd, unsigned int pipe)
+{
+	unsigned int reg;
+	unsigned int control;
+
+	reg = axd_get_output_dcpp_subband_low_pass_filter_b1_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return 0;
+	axd_read_reg(cmd, reg, &control);
+	return control;
+}
diff --git a/sound/soc/img/axd/axd_cmds_internal.c b/sound/soc/img/axd/axd_cmds_internal.c
new file mode 100644
index 000000000000..6a1e532f748d
--- /dev/null
+++ b/sound/soc/img/axd/axd_cmds_internal.c
@@ -0,0 +1,3264 @@
+/*
+ * Copyright (C) 2011-2015 Imagination Technologies Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Common functionality required by other axd_cmds_*.c files.
+ */
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/sched.h>
+
+#include "axd_cmds_internal.h"
+#include "axd_module.h"
+#include "axd_platform.h"
+
+#define WRONG_PIPE_STR		"Wrong pipe number: %d\n"
+#define WRONG_BAND_STR		"Wrong band number: %d\n"
+
+/*
+ * Send/Clear control kick.
+ *
+ * NOTE:
+ * Must acquire axd_platform_lock() before accessing kick and interrupt status
+ * registers as the AXD firmware might be accessing them at the same time.
+ */
+inline void axd_ctrl_kick(struct axd_memory_map __iomem *message)
+{
+	unsigned long flags;
+	unsigned int temp;
+
+	flags = axd_platform_lock();
+	temp = ioread32(&message->kick) | AXD_ANY_KICK_BIT | AXD_KICK_CTRL_BIT;
+	iowrite32(temp, &message->kick);
+	axd_platform_unlock(flags);
+	axd_platform_kick();
+}
+inline void axd_kick_status_clear(struct axd_memory_map __iomem *message)
+{
+	unsigned long flags;
+	unsigned int temp;
+
+	flags = axd_platform_lock();
+	temp = ioread32(&message->int_status) & ~AXD_INT_KICK_DONE;
+	iowrite32(temp, &message->int_status);
+	axd_platform_unlock(flags);
+}
+/*
+ * Wait until axd is ready again. Must be called while cm_lock is held.
+ */
+int axd_wait_ready(struct axd_memory_map __iomem *message)
+{
+#define BUSYWAIT_TIME		1
+#define BUSYWAIT_TIMEOUT	100
+	unsigned int timeout = 0;
+
+	while (ioread32(&message->control_command) != AXD_CTRL_CMD_READY) {
+		mdelay(BUSYWAIT_TIME);
+		timeout += BUSYWAIT_TIME;
+		if (timeout == BUSYWAIT_TIMEOUT)
+			return -1;
+	}
+	return 0;
+}
+
+/*
+ * Reads a register from the MemoryMapped register interface.
+ * @cmd: pointer to initialized struct axd_cmd.
+ * @reg: the register address to be accessed.
+ */
+int axd_read_reg(struct axd_cmd *cmd, unsigned int reg, unsigned int *data)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	struct axd_memory_map __iomem *message = cmd->message;
+	struct mutex *cm_lock = &cmd->cm_lock;
+	int ret;
+
+	mutex_lock(cm_lock);
+	if (axd_get_flag(&cmd->fw_stopped_flg)) {
+		mutex_unlock(cm_lock);
+		return -1;
+	}
+	axd_set_flag(&cmd->response_flg, 0);
+	iowrite32(AXD_CTRL_CMD_READ_REGISTER | reg, &message->control_command);
+	axd_ctrl_kick(message);
+	ret = wait_event_timeout(cmd->wait,
+			axd_get_flag(&cmd->response_flg) != 0, CMD_TIMEOUT);
+	*data = ioread32(&message->control_data);
+	mutex_unlock(cm_lock);
+	if (!ret) {
+		dev_warn(axd->dev, "failed to read reg 0x%04X\n", reg);
+		*data = 0;
+		return -1;
+	}
+	return 0;
+}
+
+/*
+ * Writes control data to the MemoryMapped control interface.
+ * We assume that cm_lock is held before this function is called.
+ * @cmd: pointer to initialized struct axd_cmd.
+ * @ctrl_command: the control command to write.
+ * @ctrl_data: the control value to write.
+ */
+int axd_write_ctrl(struct axd_cmd *cmd, unsigned int ctrl_command,
+						unsigned int ctrl_data)
+{
+	struct axd_memory_map __iomem *message = cmd->message;
+	int ret;
+
+	axd_set_flag(&cmd->response_flg, 0);
+	iowrite32(ctrl_data, &message->control_data);
+	iowrite32(ctrl_command, &message->control_command);
+	axd_ctrl_kick(message);
+	ret = wait_event_timeout(cmd->wait,
+			axd_get_flag(&cmd->response_flg) != 0, CMD_TIMEOUT);
+	return ret;
+}
+
+/*
+ * Writes value to a register int the MemoryMapped register interface.
+ * @cmd: pointer to initialized struct axd_cmd.
+ * @reg: the register address to be accessed.
+ * @value: the new value to write.
+ */
+int axd_write_reg(struct axd_cmd *cmd, unsigned int reg, unsigned int value)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	struct mutex *cm_lock = &cmd->cm_lock;
+	int ret;
+
+	mutex_lock(cm_lock);
+	if (axd_get_flag(&cmd->fw_stopped_flg)) {
+		mutex_unlock(cm_lock);
+		return -1;
+	}
+	ret = axd_write_ctrl(cmd, AXD_CTRL_CMD_WRITE_REGISTER | reg, value);
+	mutex_unlock(cm_lock);
+	if (!ret) {
+		dev_warn(axd->dev, "failed to write reg 0x%04X\n", reg);
+		return -1;
+	}
+
+	return 0;
+}
+
+int axd_write_reg_buf(struct axd_cmd *cmd, unsigned int reg, unsigned int value)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	struct mutex *cm_lock = &cmd->cm_lock;
+	struct axd_ctrlbuf_item __iomem *buf;
+	unsigned int ctrlbuf_ctrl = ioread32(&cmd->message->ctrlbuf_ctrl);
+	unsigned int ctrlbuf_size = ioread32(&cmd->message->ctrlbuf_size);
+	unsigned int temp;
+
+	if (!axd_get_flag(&cmd->ctrlbuf_active_flg)) {
+		/* If the ctrlbuf isn't active, fall back to simple reg write */
+		return axd_write_reg(cmd, reg, value);
+	}
+
+	mutex_lock(cm_lock);
+	if (axd_get_flag(&cmd->fw_stopped_flg)) {
+		mutex_unlock(cm_lock);
+		return -1;
+	}
+
+	if (ctrlbuf_ctrl >= ctrlbuf_size) {
+		mutex_unlock(cm_lock);
+		dev_err(axd->dev, "Could not write to ctrlbuf: full\n");
+		return -1;
+	}
+
+	buf = &cmd->message->ctrlbuf[ctrlbuf_ctrl];
+
+	iowrite32(AXD_CTRL_CMD_WRITE_REGISTER | reg, &buf->reg);
+	iowrite32(value, &buf->val);
+
+	temp = ioread32(&cmd->message->ctrlbuf_ctrl) + 1;
+	iowrite32(temp, &cmd->message->ctrlbuf_ctrl);
+
+	mutex_unlock(cm_lock);
+
+	return 0;
+}
+
+int axd_flush_reg_buf(struct axd_cmd *cmd)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	struct mutex *cm_lock = &cmd->cm_lock;
+	int ret;
+
+	mutex_lock(cm_lock);
+	if (axd_get_flag(&cmd->fw_stopped_flg)) {
+		mutex_unlock(cm_lock);
+		return -1;
+	}
+
+	if (ioread32(&cmd->message->ctrlbuf_ctrl) == 0) {
+		mutex_unlock(cm_lock);
+		dev_warn(axd->dev, "Tried to flush empty ctrlbuf\n");
+		return -1;
+	}
+
+	ret = axd_write_ctrl(cmd, AXD_CTRL_CMD_CTRLBUF_FLUSH, 0);
+	if (!ret) {
+		/* Drop buffer and ignore any response */
+		iowrite32(0, &cmd->message->ctrlbuf_ctrl);
+
+		mutex_unlock(cm_lock);
+		dev_err(axd->dev, "Could not write control command to flush buffer");
+		return -EIO;
+	}
+
+	/* Ignore any response */
+	iowrite32(0, &cmd->message->ctrlbuf_ctrl);
+
+	mutex_unlock(cm_lock);
+
+	return 0;
+}
+
+/* Returns the address of the correct mixer mux register for @pipe */
+unsigned int axd_get_mixer_mux_reg(struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_MUX0;
+		break;
+	case 1:
+		reg = AXD_REG_MUX1;
+		break;
+	case 2:
+		reg = AXD_REG_MUX2;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the number of the currently set input codec */
+unsigned int axd_get_input_codec_number(struct axd_cmd *cmd, unsigned int pipe)
+{
+	unsigned int reg = axd_get_input_control_reg(cmd, pipe);
+	unsigned int control;
+
+	if (unlikely(!reg))
+		return -1;
+	axd_read_reg(cmd, reg, &control);
+	return (control & AXD_INCTRL_CODEC_BITS) >> AXD_INCTRL_CODEC_SHIFT;
+}
+
+/* Returns the address of the correct input control register for @pipe */
+unsigned int axd_get_input_control_reg(struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_INPUT0_CONTROL;
+		break;
+	case 1:
+		reg = AXD_REG_INPUT1_CONTROL;
+		break;
+	case 2:
+		reg = AXD_REG_INPUT2_CONTROL;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the correct input gain register for @pipe */
+unsigned int axd_get_input_gain_reg(struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_INPUT0_GAIN;
+		break;
+	case 1:
+		reg = AXD_REG_INPUT1_GAIN;
+		break;
+	case 2:
+		reg = AXD_REG_INPUT2_GAIN;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the correct input mute register for @pipe */
+unsigned int axd_get_input_mute_reg(struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_INPUT0_MUTE;
+		break;
+	case 1:
+		reg = AXD_REG_INPUT1_MUTE;
+		break;
+	case 2:
+		reg = AXD_REG_INPUT2_MUTE;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the correct input UpMix register for @pipe */
+unsigned int axd_get_input_upmix_reg(struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_INPUT0_UPMIX;
+		break;
+	case 1:
+		reg = AXD_REG_INPUT1_UPMIX;
+		break;
+	case 2:
+		reg = AXD_REG_INPUT2_UPMIX;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the correct input bufer occupancy reg for @pipe */
+unsigned int axd_get_input_buffer_occupancy_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_INPUT0_BUFFER_OCCUPANCY;
+		break;
+	case 1:
+		reg = AXD_REG_INPUT1_BUFFER_OCCUPANCY;
+		break;
+	case 2:
+		reg = AXD_REG_INPUT2_BUFFER_OCCUPANCY;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the number of the currently set output codec */
+unsigned int axd_get_output_codec_number(struct axd_cmd *cmd, unsigned int pipe)
+{
+	unsigned int reg = axd_get_output_control_reg(cmd, pipe);
+	unsigned int control;
+
+	if (unlikely(!reg))
+		return -1;
+	axd_read_reg(cmd, reg, &control);
+	return (control & AXD_OUTCTRL_CODEC_BITS) >> AXD_OUTCTRL_CODEC_SHIFT;
+}
+
+/* Returns the address of the correct output control register for @pipe */
+unsigned int axd_get_output_control_reg(struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_CONTROL;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_CONTROL;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_CONTROL;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the correct output DownMix register for @pipe */
+unsigned int axd_get_output_downmix_reg(struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DOWNMIX;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DOWNMIX;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DOWNMIX;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the correct output event register for @pipe */
+unsigned int axd_get_output_event_reg(struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_EVENT;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_EVENT;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_EVENT;
+		break;
+	default:
+		dev_err(axd->dev, "Unsupported output pipe number %d\n", pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/*
+ * Returns the address of the output EQ Ctrl / Master Gain register for
+ * @pipe
+ */
+unsigned int axd_get_output_eqcontrol_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_EQCTRL;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_EQCTRL;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_EQCTRL;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the output EQ Band0 register for @pipe*/
+unsigned int axd_get_output_eqband0_reg(struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_EQBAND0;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_EQBAND0;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_EQBAND0;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the output EQ Band1 register for @pipe*/
+unsigned int axd_get_output_eqband1_reg(struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_EQBAND1;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_EQBAND1;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_EQBAND1;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the output EQ Band2 register for @pipe*/
+unsigned int axd_get_output_eqband2_reg(struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_EQBAND2;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_EQBAND2;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_EQBAND2;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the output EQ Band3 register for @pipe*/
+unsigned int axd_get_output_eqband3_reg(struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_EQBAND3;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_EQBAND3;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_EQBAND3;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the output EQ Band4 register for @pipe*/
+unsigned int axd_get_output_eqband4_reg(struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_EQBAND4;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_EQBAND4;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_EQBAND4;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* DCPP */
+
+int axd_cmd_output_dcpp_select_channel(struct axd_cmd *cmd, unsigned int pipe,
+					bool subband, unsigned int channel)
+{
+	unsigned int reg;
+	unsigned int control;
+	int ret;
+
+	reg = axd_get_output_dcpp_channel_ctrl_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return -1;
+
+	/* Generate channel selector */
+	control = 0;
+
+	if (subband)
+		control = AXD_DCPP_CHANNEL_CTRL_SUBBAND_BITS;
+	else
+		control = channel << AXD_DCPP_CHANNEL_CTRL_CHANNEL_SHIFT;
+
+	/* Compare with last channel selector */
+	if (control == cmd->dcpp_channel_ctrl_cache[pipe]) {
+		ret = 0;
+	} else {
+		ret = axd_write_reg_buf(cmd, reg, control);
+		cmd->dcpp_channel_ctrl_cache[pipe] = control;
+	}
+
+	return ret;
+}
+
+int axd_cmd_output_dcpp_select_band(struct axd_cmd *cmd, unsigned int pipe,
+							unsigned int band)
+{
+	unsigned int reg;
+	unsigned int control;
+	int ret;
+
+	reg = axd_get_output_dcpp_band_ctrl_reg(cmd, pipe);
+	if (unlikely(!reg))
+		return -1;
+
+	/* Generate band selector */
+	control = band;
+
+	/* Compare with last band selector */
+	if (control == cmd->dcpp_band_ctrl_cache[pipe]) {
+		ret = 0;
+	} else {
+		ret = axd_write_reg_buf(cmd, reg, control);
+		cmd->dcpp_band_ctrl_cache[pipe] = control;
+	}
+
+	return ret;
+}
+
+unsigned int axd_get_output_dcpp_control_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DCPP_CONTROL;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DCPP_CONTROL;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DCPP_CONTROL;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_dcpp_max_delay_samples_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DCPP_MAX_DELAY_SAMPLES;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DCPP_MAX_DELAY_SAMPLES;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DCPP_MAX_DELAY_SAMPLES;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_dcpp_channel_ctrl_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg = 0;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DCPP_CHANNEL_CONTROL;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DCPP_CHANNEL_CONTROL;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DCPP_CHANNEL_CONTROL;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_dcpp_band_ctrl_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg = 0;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DCPP_BAND_CONTROL;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DCPP_BAND_CONTROL;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DCPP_BAND_CONTROL;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_dcpp_channel_delay_samples_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DCPP_CHANNEL_DELAY_SAMPLES;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DCPP_CHANNEL_DELAY_SAMPLES;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DCPP_CHANNEL_DELAY_SAMPLES;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_dcpp_channel_eq_output_volume_reg(
+					struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DCPP_CHANNEL_EQ_OUTPUT_VOLUME;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DCPP_CHANNEL_EQ_OUTPUT_VOLUME;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DCPP_CHANNEL_EQ_OUTPUT_VOLUME;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_dcpp_channel_eq_passthrough_gain_reg(
+					struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DCPP_CHANNEL_EQ_PASSTHROUGH_GAIN;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DCPP_CHANNEL_EQ_PASSTHROUGH_GAIN;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DCPP_CHANNEL_EQ_PASSTHROUGH_GAIN;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_dcpp_channel_eq_inverse_passthrough_gain_reg(
+					struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DCPP_CHANNEL_EQ_INVERSE_PASSTHROUGH_GAIN;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DCPP_CHANNEL_EQ_INVERSE_PASSTHROUGH_GAIN;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DCPP_CHANNEL_EQ_INVERSE_PASSTHROUGH_GAIN;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_dcpp_channel_bass_shelf_shift_reg(
+					struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DCPP_CHANNEL_BASS_SHELF_SHIFT;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DCPP_CHANNEL_BASS_SHELF_SHIFT;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DCPP_CHANNEL_BASS_SHELF_SHIFT;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_dcpp_channel_bass_shelf_a0_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DCPP_CHANNEL_BASS_SHELF_A0;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DCPP_CHANNEL_BASS_SHELF_A0;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DCPP_CHANNEL_BASS_SHELF_A0;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_dcpp_channel_bass_shelf_a1_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DCPP_CHANNEL_BASS_SHELF_A1;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DCPP_CHANNEL_BASS_SHELF_A1;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DCPP_CHANNEL_BASS_SHELF_A1;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_dcpp_channel_bass_shelf_a2_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DCPP_CHANNEL_BASS_SHELF_A2;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DCPP_CHANNEL_BASS_SHELF_A2;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DCPP_CHANNEL_BASS_SHELF_A2;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_dcpp_channel_bass_shelf_b0_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DCPP_CHANNEL_BASS_SHELF_B0;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DCPP_CHANNEL_BASS_SHELF_B0;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DCPP_CHANNEL_BASS_SHELF_B0;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_dcpp_channel_bass_shelf_b1_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DCPP_CHANNEL_BASS_SHELF_B1;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DCPP_CHANNEL_BASS_SHELF_B1;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DCPP_CHANNEL_BASS_SHELF_B1;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_dcpp_channel_treble_shelf_shift_reg(
+					struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DCPP_CHANNEL_TREBLE_SHELF_SHIFT;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DCPP_CHANNEL_TREBLE_SHELF_SHIFT;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DCPP_CHANNEL_TREBLE_SHELF_SHIFT;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_dcpp_channel_treble_shelf_a0_reg(
+					struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DCPP_CHANNEL_TREBLE_SHELF_A0;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DCPP_CHANNEL_TREBLE_SHELF_A0;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DCPP_CHANNEL_TREBLE_SHELF_A0;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_dcpp_channel_treble_shelf_a1_reg(
+					struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DCPP_CHANNEL_TREBLE_SHELF_A1;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DCPP_CHANNEL_TREBLE_SHELF_A1;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DCPP_CHANNEL_TREBLE_SHELF_A1;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_dcpp_channel_treble_shelf_a2_reg(
+					struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DCPP_CHANNEL_TREBLE_SHELF_A2;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DCPP_CHANNEL_TREBLE_SHELF_A2;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DCPP_CHANNEL_TREBLE_SHELF_A2;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_dcpp_channel_treble_shelf_b0_reg(
+					struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DCPP_CHANNEL_TREBLE_SHELF_B0;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DCPP_CHANNEL_TREBLE_SHELF_B0;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DCPP_CHANNEL_TREBLE_SHELF_B0;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_dcpp_channel_treble_shelf_b1_reg(
+					struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DCPP_CHANNEL_TREBLE_SHELF_B1;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DCPP_CHANNEL_TREBLE_SHELF_B1;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DCPP_CHANNEL_TREBLE_SHELF_B1;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_dcpp_channel_eq_gain_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DCPP_CHANNEL_EQ_BAND_GAIN;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DCPP_CHANNEL_EQ_BAND_GAIN;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DCPP_CHANNEL_EQ_BAND_GAIN;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_dcpp_channel_eq_a0_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DCPP_CHANNEL_EQ_BAND_A0;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DCPP_CHANNEL_EQ_BAND_A0;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DCPP_CHANNEL_EQ_BAND_A0;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_dcpp_channel_eq_a1_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DCPP_CHANNEL_EQ_BAND_A1;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DCPP_CHANNEL_EQ_BAND_A1;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DCPP_CHANNEL_EQ_BAND_A1;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_dcpp_channel_eq_a2_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DCPP_CHANNEL_EQ_BAND_A2;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DCPP_CHANNEL_EQ_BAND_A2;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DCPP_CHANNEL_EQ_BAND_A2;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_dcpp_channel_eq_b0_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DCPP_CHANNEL_EQ_BAND_B0;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DCPP_CHANNEL_EQ_BAND_B0;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DCPP_CHANNEL_EQ_BAND_B0;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_dcpp_channel_eq_b1_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DCPP_CHANNEL_EQ_BAND_B1;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DCPP_CHANNEL_EQ_BAND_B1;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DCPP_CHANNEL_EQ_BAND_B1;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_dcpp_channel_eq_shift_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DCPP_CHANNEL_EQ_BAND_SHIFT;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DCPP_CHANNEL_EQ_BAND_SHIFT;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DCPP_CHANNEL_EQ_BAND_SHIFT;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_dcpp_subband_low_pass_filter_a0_reg(
+					struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg = 0;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DCPP_SUBBAND_LOW_PASS_FILTER_A0;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DCPP_SUBBAND_LOW_PASS_FILTER_A0;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DCPP_SUBBAND_LOW_PASS_FILTER_A0;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_dcpp_subband_low_pass_filter_a1_reg(
+					struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg = 0;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DCPP_SUBBAND_LOW_PASS_FILTER_A1;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DCPP_SUBBAND_LOW_PASS_FILTER_A1;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DCPP_SUBBAND_LOW_PASS_FILTER_A1;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_dcpp_subband_low_pass_filter_a2_reg(
+					struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg = 0;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DCPP_SUBBAND_LOW_PASS_FILTER_A2;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DCPP_SUBBAND_LOW_PASS_FILTER_A2;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DCPP_SUBBAND_LOW_PASS_FILTER_A2;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_dcpp_subband_low_pass_filter_b0_reg(
+					struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg = 0;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DCPP_SUBBAND_LOW_PASS_FILTER_B0;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DCPP_SUBBAND_LOW_PASS_FILTER_B0;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DCPP_SUBBAND_LOW_PASS_FILTER_B0;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_dcpp_subband_low_pass_filter_b1_reg(
+					struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg = 0;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_OUTPUT0_DCPP_SUBBAND_LOW_PASS_FILTER_B1;
+		break;
+	case 1:
+		reg = AXD_REG_OUTPUT1_DCPP_SUBBAND_LOW_PASS_FILTER_B1;
+		break;
+	case 2:
+		reg = AXD_REG_OUTPUT2_DCPP_SUBBAND_LOW_PASS_FILTER_B1;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the aac version for decoder at @pipe*/
+unsigned int axd_get_decoder_aac_version_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_AAC_VERSION;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_AAC_VERSION;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_AAC_VERSION;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the aac pipes for decoder at @pipe*/
+unsigned int axd_get_decoder_aac_channels_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_AAC_CHANNELS;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_AAC_CHANNELS;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_AAC_CHANNELS;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the aac profile for decoder at @pipe*/
+unsigned int axd_get_decoder_aac_profile_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_AAC_PROFILE;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_AAC_PROFILE;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_AAC_PROFILE;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the aac stream type for decoder at @pipe*/
+unsigned int axd_get_decoder_aac_streamtype_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_AAC_STREAM_TYPE;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_AAC_STREAM_TYPE;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_AAC_STREAM_TYPE;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the aac stream type for decoder at @pipe*/
+unsigned int axd_get_decoder_aac_samplerate_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_AAC_SAMPLERATE;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_AAC_SAMPLERATE;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_AAC_SAMPLERATE;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+unsigned int axd_get_decoder_ac3_channels_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_AC3_CHANNELS;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_AC3_CHANNELS;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_AC3_CHANNELS;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_decoder_ac3_channel_order_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_AC3_CHANNEL_ORDER;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_AC3_CHANNEL_ORDER;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_AC3_CHANNEL_ORDER;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_decoder_ac3_mode_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_AC3_MODE;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_AC3_MODE;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_AC3_MODE;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the cook flavour for decoder at @pipe*/
+unsigned int axd_get_decoder_cook_flavour_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_COOK_FLAVOUR;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_COOK_FLAVOUR;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_COOK_FLAVOUR;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the flac pipes for decoder at @pipe*/
+unsigned int axd_get_decoder_flac_channels_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_FLAC_CHANNELS;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_FLAC_CHANNELS;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_FLAC_CHANNELS;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the flac sample rate for decoder at @pipe*/
+unsigned int axd_get_decoder_flac_samplerate_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_FLAC_SAMPLERATE;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_FLAC_SAMPLERATE;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_FLAC_SAMPLERATE;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the flac bits per sample for decoder at @pipe*/
+unsigned int axd_get_decoder_flac_bitspersample_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_FLAC_BITS_PER_SAMPLE;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_FLAC_BITS_PER_SAMPLE;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_FLAC_BITS_PER_SAMPLE;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the flac md5 checking for decoder at @pipe*/
+unsigned int axd_get_decoder_flac_md5checking_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_FLAC_MD5_CHECKING;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_FLAC_MD5_CHECKING;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_FLAC_MD5_CHECKING;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the mpeg num pipes for decoder at @pipe*/
+unsigned int axd_get_decoder_mpeg_numchannels_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_MPEG_CHANNELS;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_MPEG_CHANNELS;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_MPEG_CHANNELS;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the mpeg mlchannel for decoder at @pipe*/
+unsigned int axd_get_decoder_mpeg_mlchannel_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_MPEG_MLCHANNEL;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_MPEG_MLCHANNEL;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_MPEG_MLCHANNEL;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the wma player opt for decoder at @pipe*/
+unsigned int axd_get_decoder_wma_playeropt_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_WMA_PLAYER_OPT;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_WMA_PLAYER_OPT;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_WMA_PLAYER_OPT;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the wma player drc setting for decoder at @pipe*/
+unsigned int axd_get_decoder_wma_drcsetting_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_WMA_DRC_SETTING;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_WMA_DRC_SETTING;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_WMA_DRC_SETTING;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the wma player peak ref for decoder at @pipe*/
+unsigned int axd_get_decoder_wma_peakampref_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_WMA_PEAK_AMP_REF;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_WMA_PEAK_AMP_REF;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_WMA_PEAK_AMP_REF;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the wma player rms ref for decoder at @pipe*/
+unsigned int axd_get_decoder_wma_rmsampref_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_WMA_RMS_AMP_REF;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_WMA_RMS_AMP_REF;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_WMA_RMS_AMP_REF;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the wma player peak target for decoder at @pipe*/
+unsigned int axd_get_decoder_wma_peakamptarget_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_WMA_PEAK_AMP_TARGET;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_WMA_PEAK_AMP_TARGET;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_WMA_PEAK_AMP_TARGET;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the wma player rms target for decoder at @pipe*/
+unsigned int axd_get_decoder_wma_rmsamptarget_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_WMA_RMS_AMP_TARGET;
+		break;
+	case 1:
+		reg = AXD_REG_DEC2_WMA_RMS_AMP_TARGET;
+		break;
+	case 2:
+		reg = AXD_REG_DEC1_WMA_RMS_AMP_TARGET;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the wma pcm valid bits for decoder at @pipe*/
+unsigned int axd_get_decoder_wma_pcmvalidbitspersample_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_WMA_PCM_VAL_BITS_PER_SAMPLE;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_WMA_PCM_VAL_BITS_PER_SAMPLE;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_WMA_PCM_VAL_BITS_PER_SAMPLE;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the wma pcm container size for decoder at @pipe*/
+unsigned int axd_get_decoder_wma_pcmcontainersize_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_WMA_PCM_CONTAINER_SIZE;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_WMA_PCM_CONTAINER_SIZE;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_WMA_PCM_CONTAINER_SIZE;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the wma format tag for decoder at @pipe*/
+unsigned int axd_get_decoder_wma_wmaformattag_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_WMA_WMA_FORMAT_TAG;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_WMA_WMA_FORMAT_TAG;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_WMA_WMA_FORMAT_TAG;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the wma format num pipes for decoder at @pipe*/
+unsigned int axd_get_decoder_wma_wmanumchannels_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_WMA_WMA_CHANNELS;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_WMA_WMA_CHANNELS;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_WMA_WMA_CHANNELS;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the wma format sample/s for decoder at @pipe*/
+unsigned int axd_get_decoder_wma_wmasamplespersec_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_WMA_WMA_SAMPLES_PER_SEC;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_WMA_WMA_SAMPLES_PER_SEC;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_WMA_WMA_SAMPLES_PER_SEC;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/*
+ * Returns the address of the wma format average bytes per sample for decoder
+ * at @pipe
+ */
+unsigned int axd_get_decoder_wma_wmaaveragebytespersec_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_WMA_WMA_AVG_BYTES_PER_SEC;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_WMA_WMA_AVG_BYTES_PER_SEC;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_WMA_WMA_AVG_BYTES_PER_SEC;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the wma format block align for decoder at @pipe*/
+unsigned int axd_get_decoder_wma_wmablockalign_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_WMA_WMA_BLOCK_ALIGN;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_WMA_WMA_BLOCK_ALIGN;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_WMA_WMA_BLOCK_ALIGN;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the wma format valid bits for decoder at @pipe*/
+unsigned int axd_get_decoder_wma_wmavalidbitspersample_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_WMA_WMA_VAL_BITS_PER_SAMPLE;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_WMA_WMA_VAL_BITS_PER_SAMPLE;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_WMA_WMA_VAL_BITS_PER_SAMPLE;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the wma format pipe mask for decoder at @pipe*/
+unsigned int axd_get_decoder_wma_wmachannelmask_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_WMA_WMA_CHANNEL_MASK;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_WMA_WMA_CHANNEL_MASK;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_WMA_WMA_CHANNEL_MASK;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the wma format encode options for decoder at @pipe*/
+unsigned int axd_get_decoder_wma_wmaencodeoptions_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_WMA_WMA_ENCODE_OPTS;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_WMA_WMA_ENCODE_OPTS;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_WMA_WMA_ENCODE_OPTS;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the pcm samplerate reg for decoder at @pipe*/
+unsigned int axd_get_decoder_pcm_samplerate_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_PCMIN0_SAMPLE_RATE;
+		break;
+	case 1:
+		reg = AXD_REG_PCMIN1_SAMPLE_RATE;
+		break;
+	case 2:
+		reg = AXD_REG_PCMIN2_SAMPLE_RATE;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the pcm channels reg for decoder at @pipe*/
+unsigned int axd_get_decoder_pcm_channels_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_PCMIN0_CHANNELS;
+		break;
+	case 1:
+		reg = AXD_REG_PCMIN1_CHANNELS;
+		break;
+	case 2:
+		reg = AXD_REG_PCMIN2_CHANNELS;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the pcm bitspersample reg for decoder at @pipe*/
+unsigned int axd_get_decoder_pcm_bitspersample_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_PCMIN0_BITS_PER_SAMPLE;
+		break;
+	case 1:
+		reg = AXD_REG_PCMIN1_BITS_PER_SAMPLE;
+		break;
+	case 2:
+		reg = AXD_REG_PCMIN2_BITS_PER_SAMPLE;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+/* Returns the address of the pcm justification reg for decoder at @pipe*/
+unsigned int axd_get_decoder_pcm_justification_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_PCMIN0_JUSTIFICATION;
+		break;
+	case 1:
+		reg = AXD_REG_PCMIN1_JUSTIFICATION;
+		break;
+	case 2:
+		reg = AXD_REG_PCMIN2_JUSTIFICATION;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_decoder_ddplus_config_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_DDPLUS_CONFIG;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_DDPLUS_CONFIG;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_DDPLUS_CONFIG;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+unsigned int axd_get_decoder_ddplus_channel_order_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_DDPLUS_CHANNEL_ORDER;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_DDPLUS_CHANNEL_ORDER;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_DDPLUS_CHANNEL_ORDER;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_decoder_alac_channels_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_ALAC_CHANNELS;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_ALAC_CHANNELS;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_ALAC_CHANNELS;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+unsigned int axd_get_decoder_alac_depth_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_ALAC_DEPTH;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_ALAC_DEPTH;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_ALAC_DEPTH;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+unsigned int axd_get_decoder_alac_samplerate_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_ALAC_SAMPLE_RATE;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_ALAC_SAMPLE_RATE;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_ALAC_SAMPLE_RATE;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+unsigned int axd_get_decoder_alac_framelength_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_ALAC_FRAME_LENGTH;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_ALAC_FRAME_LENGTH;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_ALAC_FRAME_LENGTH;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_decoder_alac_maxframebytes_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_ALAC_MAX_FRAME_BYTES;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_ALAC_MAX_FRAME_BYTES;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_ALAC_MAX_FRAME_BYTES;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+unsigned int axd_get_decoder_alac_avgbitrate_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_ALAC_AVG_BIT_RATE;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_ALAC_AVG_BIT_RATE;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_ALAC_AVG_BIT_RATE;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_decoder_sbc_samplerate_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_SBC_SAMPLE_RATE;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_SBC_SAMPLE_RATE;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_SBC_SAMPLE_RATE;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_decoder_sbc_audiomode_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_SBC_AUDIO_MODE;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_SBC_AUDIO_MODE;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_SBC_AUDIO_MODE;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_decoder_sbc_blocks_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_SBC_BLOCKS;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_SBC_BLOCKS;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_SBC_BLOCKS;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_decoder_sbc_subbands_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_SBC_SUBBANDS;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_SBC_SUBBANDS;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_SBC_SUBBANDS;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_decoder_sbc_bitpool_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_SBC_BITPOOL;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_SBC_BITPOOL;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_SBC_BITPOOL;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_decoder_sbc_allocationmode_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_DEC0_SBC_ALLOCATION_MODE;
+		break;
+	case 1:
+		reg = AXD_REG_DEC1_SBC_ALLOCATION_MODE;
+		break;
+	case 2:
+		reg = AXD_REG_DEC2_SBC_ALLOCATION_MODE;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+
+unsigned int axd_get_decoder_ms11_mode_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	return AXD_REG_MS11_MODE;
+}
+
+unsigned int axd_get_decoder_ms11_common_config0_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	return AXD_REG_MS11_COMMON_CONFIG0;
+}
+
+unsigned int axd_get_decoder_ms11_common_config1_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	return AXD_REG_MS11_COMMON_CONFIG1;
+}
+
+unsigned int axd_get_decoder_ms11_ddt_config0_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	return AXD_REG_MS11_DDT_CONFIG0;
+}
+
+unsigned int axd_get_decoder_ms11_ddc_config0_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	return AXD_REG_MS11_DDC_CONFIG0;
+}
+
+unsigned int axd_get_decoder_ms11_ext_pcm_config0_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	return AXD_REG_MS11_EXT_PCM_CONFIG0;
+}
+
+/* Returns the address of the pcm bitspersample reg for output at @pipe*/
+unsigned int axd_get_encoder_pcm_bitspersample_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_PCMOUT0_BITS_PER_SAMPLE;
+		break;
+	case 1:
+		reg = AXD_REG_PCMOUT1_BITS_PER_SAMPLE;
+		break;
+	case 2:
+		reg = AXD_REG_PCMOUT2_BITS_PER_SAMPLE;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_encoder_flac_channels_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_ENC0_FLAC_CHANNELS;
+		break;
+	case 1:
+		reg = AXD_REG_ENC1_FLAC_CHANNELS;
+		break;
+	case 2:
+		reg = AXD_REG_ENC2_FLAC_CHANNELS;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+unsigned int axd_get_encoder_flac_bitspersample_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_ENC0_FLAC_BITS_PER_SAMPLE;
+		break;
+	case 1:
+		reg = AXD_REG_ENC1_FLAC_BITS_PER_SAMPLE;
+		break;
+	case 2:
+		reg = AXD_REG_ENC2_FLAC_BITS_PER_SAMPLE;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+unsigned int axd_get_encoder_flac_samplerate_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_ENC0_FLAC_SAMPLE_RATE;
+		break;
+	case 1:
+		reg = AXD_REG_ENC1_FLAC_SAMPLE_RATE;
+		break;
+	case 2:
+		reg = AXD_REG_ENC2_FLAC_SAMPLE_RATE;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+unsigned int axd_get_encoder_flac_totalsamples_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_ENC0_FLAC_TOTAL_SAMPLES;
+		break;
+	case 1:
+		reg = AXD_REG_ENC1_FLAC_TOTAL_SAMPLES;
+		break;
+	case 2:
+		reg = AXD_REG_ENC2_FLAC_TOTAL_SAMPLES;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+unsigned int axd_get_encoder_flac_domidsidestereo_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_ENC0_FLAC_DO_MID_SIDE_STEREO;
+		break;
+	case 1:
+		reg = AXD_REG_ENC1_FLAC_DO_MID_SIDE_STEREO;
+		break;
+	case 2:
+		reg = AXD_REG_ENC2_FLAC_DO_MID_SIDE_STEREO;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+unsigned int axd_get_encoder_flac_loosemidsidestereo_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_ENC0_FLAC_LOOSE_MID_SIDE_STEREO;
+		break;
+	case 1:
+		reg = AXD_REG_ENC1_FLAC_LOOSE_MID_SIDE_STEREO;
+		break;
+	case 2:
+		reg = AXD_REG_ENC2_FLAC_LOOSE_MID_SIDE_STEREO;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+unsigned int axd_get_encoder_flac_doexhaustivemodelsearch_reg(
+					struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_ENC0_FLAC_DO_EXHAUSTIVE_MODEL_SEARCH;
+		break;
+	case 1:
+		reg = AXD_REG_ENC1_FLAC_DO_EXHAUSTIVE_MODEL_SEARCH;
+		break;
+	case 2:
+		reg = AXD_REG_ENC2_FLAC_DO_EXHAUSTIVE_MODEL_SEARCH;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+unsigned int axd_get_encoder_flac_minresidualpartitionorder_reg(
+					struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_ENC0_FLAC_MIN_RESIDUAL_PARTITION_ORDER;
+		break;
+	case 1:
+		reg = AXD_REG_ENC1_FLAC_MIN_RESIDUAL_PARTITION_ORDER;
+		break;
+	case 2:
+		reg = AXD_REG_ENC2_FLAC_MIN_RESIDUAL_PARTITION_ORDER;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+unsigned int axd_get_encoder_flac_maxresidualpartitionorder_reg(
+					struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_ENC0_FLAC_MAX_RESIDUAL_PARTITION_ORDER;
+		break;
+	case 1:
+		reg = AXD_REG_ENC1_FLAC_MAX_RESIDUAL_PARTITION_ORDER;
+		break;
+	case 2:
+		reg = AXD_REG_ENC2_FLAC_MAX_RESIDUAL_PARTITION_ORDER;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+unsigned int axd_get_encoder_flac_blocksize_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_ENC0_FLAC_BLOCK_SIZE;
+		break;
+	case 1:
+		reg = AXD_REG_ENC1_FLAC_BLOCK_SIZE;
+		break;
+	case 2:
+		reg = AXD_REG_ENC2_FLAC_BLOCK_SIZE;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+unsigned int axd_get_encoder_flac_bytecount_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_ENC0_FLAC_BYTE_COUNT;
+		break;
+	case 1:
+		reg = AXD_REG_ENC1_FLAC_BYTE_COUNT;
+		break;
+	case 2:
+		reg = AXD_REG_ENC2_FLAC_BYTE_COUNT;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+unsigned int axd_get_encoder_flac_samplecount_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_ENC0_FLAC_SAMPLE_COUNT;
+		break;
+	case 1:
+		reg = AXD_REG_ENC1_FLAC_SAMPLE_COUNT;
+		break;
+	case 2:
+		reg = AXD_REG_ENC2_FLAC_SAMPLE_COUNT;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+unsigned int axd_get_encoder_flac_framecount_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_ENC0_FLAC_FRAME_COUNT;
+		break;
+	case 1:
+		reg = AXD_REG_ENC1_FLAC_FRAME_COUNT;
+		break;
+	case 2:
+		reg = AXD_REG_ENC2_FLAC_FRAME_COUNT;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+unsigned int axd_get_encoder_flac_framebytes_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_ENC0_FLAC_FRAME_BYTES;
+		break;
+	case 1:
+		reg = AXD_REG_ENC1_FLAC_FRAME_BYTES;
+		break;
+	case 2:
+		reg = AXD_REG_ENC2_FLAC_FRAME_BYTES;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_encoder_alac_channels_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_ENC0_ALAC_CHANNELS;
+		break;
+	case 1:
+		reg = AXD_REG_ENC1_ALAC_CHANNELS;
+		break;
+	case 2:
+		reg = AXD_REG_ENC2_ALAC_CHANNELS;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+unsigned int axd_get_encoder_alac_depth_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_ENC0_ALAC_DEPTH;
+		break;
+	case 1:
+		reg = AXD_REG_ENC1_ALAC_DEPTH;
+		break;
+	case 2:
+		reg = AXD_REG_ENC2_ALAC_DEPTH;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+unsigned int axd_get_encoder_alac_samplerate_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_ENC0_ALAC_SAMPLE_RATE;
+		break;
+	case 1:
+		reg = AXD_REG_ENC1_ALAC_SAMPLE_RATE;
+		break;
+	case 2:
+		reg = AXD_REG_ENC2_ALAC_SAMPLE_RATE;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+unsigned int axd_get_encoder_alac_framelength_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_ENC0_ALAC_FRAME_LENGTH;
+		break;
+	case 1:
+		reg = AXD_REG_ENC1_ALAC_FRAME_LENGTH;
+		break;
+	case 2:
+		reg = AXD_REG_ENC2_ALAC_FRAME_LENGTH;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+unsigned int axd_get_encoder_alac_maxframebytes_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_ENC0_ALAC_MAX_FRAME_BYTES;
+		break;
+	case 1:
+		reg = AXD_REG_ENC1_ALAC_MAX_FRAME_BYTES;
+		break;
+	case 2:
+		reg = AXD_REG_ENC2_ALAC_MAX_FRAME_BYTES;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+unsigned int axd_get_encoder_alac_avgbitrate_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_ENC0_ALAC_AVG_BIT_RATE;
+		break;
+	case 1:
+		reg = AXD_REG_ENC1_ALAC_AVG_BIT_RATE;
+		break;
+	case 2:
+		reg = AXD_REG_ENC2_ALAC_AVG_BIT_RATE;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+unsigned int axd_get_encoder_alac_fastmode_reg(struct axd_cmd *cmd,
+							unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_ENC0_ALAC_FAST_MODE;
+		break;
+	case 1:
+		reg = AXD_REG_ENC1_ALAC_FAST_MODE;
+		break;
+	case 2:
+		reg = AXD_REG_ENC2_ALAC_FAST_MODE;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_eq_power_reg_ch0_3(struct axd_cmd *cmd,
+		unsigned int pipe, unsigned int band)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg = 0;
+
+	if (pipe == 0) {
+		switch (band) {
+		case 0:
+			reg = AXD_REG_EQ_OUT0_POWER_B0_C0_C3;
+			break;
+		case 1:
+			reg = AXD_REG_EQ_OUT0_POWER_B1_C0_C3;
+			break;
+		case 2:
+			reg = AXD_REG_EQ_OUT0_POWER_B2_C0_C3;
+			break;
+		case 3:
+			reg = AXD_REG_EQ_OUT0_POWER_B3_C0_C3;
+			break;
+		case 4:
+			reg = AXD_REG_EQ_OUT0_POWER_B4_C0_C3;
+			break;
+		default:
+			dev_err(axd->dev, WRONG_BAND_STR, band);
+			return 0;
+		}
+	} else if (pipe == 1) {
+		switch (band) {
+		case 0:
+			reg = AXD_REG_EQ_OUT1_POWER_B0_C0_C3;
+			break;
+		case 1:
+			reg = AXD_REG_EQ_OUT1_POWER_B1_C0_C3;
+			break;
+		case 2:
+			reg = AXD_REG_EQ_OUT1_POWER_B2_C0_C3;
+			break;
+		case 3:
+			reg = AXD_REG_EQ_OUT1_POWER_B3_C0_C3;
+			break;
+		case 4:
+			reg = AXD_REG_EQ_OUT1_POWER_B4_C0_C3;
+			break;
+		default:
+			dev_err(axd->dev, WRONG_BAND_STR, band);
+			return 0;
+		}
+	} else if (pipe == 2) {
+		switch (band) {
+		case 0:
+			reg = AXD_REG_EQ_OUT2_POWER_B0_C0_C3;
+			break;
+		case 1:
+			reg = AXD_REG_EQ_OUT2_POWER_B1_C0_C3;
+			break;
+		case 2:
+			reg = AXD_REG_EQ_OUT2_POWER_B2_C0_C3;
+			break;
+		case 3:
+			reg = AXD_REG_EQ_OUT2_POWER_B3_C0_C3;
+			break;
+		case 4:
+			reg = AXD_REG_EQ_OUT2_POWER_B4_C0_C3;
+			break;
+		default:
+			dev_err(axd->dev, WRONG_BAND_STR, band);
+			return 0;
+		}
+	}
+	return reg;
+}
+
+unsigned int axd_get_output_eq_power_reg_ch4_7(struct axd_cmd *cmd,
+		unsigned int pipe, unsigned int band)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg = 0;
+
+	if (pipe == 0) {
+		switch (band) {
+		case 0:
+			reg = AXD_REG_EQ_OUT0_POWER_B0_C4_C7;
+			break;
+		case 1:
+			reg = AXD_REG_EQ_OUT0_POWER_B1_C4_C7;
+			break;
+		case 2:
+			reg = AXD_REG_EQ_OUT0_POWER_B2_C4_C7;
+			break;
+		case 3:
+			reg = AXD_REG_EQ_OUT0_POWER_B3_C4_C7;
+			break;
+		case 4:
+			reg = AXD_REG_EQ_OUT0_POWER_B4_C4_C7;
+			break;
+		default:
+			dev_err(axd->dev, WRONG_BAND_STR, band);
+			return 0;
+		}
+	} else if (pipe == 1) {
+		switch (band) {
+		case 0:
+			reg = AXD_REG_EQ_OUT1_POWER_B0_C4_C7;
+			break;
+		case 1:
+			reg = AXD_REG_EQ_OUT1_POWER_B1_C4_C7;
+			break;
+		case 2:
+			reg = AXD_REG_EQ_OUT1_POWER_B2_C4_C7;
+			break;
+		case 3:
+			reg = AXD_REG_EQ_OUT1_POWER_B3_C4_C7;
+			break;
+		case 4:
+			reg = AXD_REG_EQ_OUT1_POWER_B4_C4_C7;
+			break;
+		default:
+			dev_err(axd->dev, WRONG_BAND_STR, band);
+			return 0;
+		}
+	} else if (pipe == 2) {
+		switch (band) {
+		case 0:
+			reg = AXD_REG_EQ_OUT2_POWER_B0_C4_C7;
+			break;
+		case 1:
+			reg = AXD_REG_EQ_OUT2_POWER_B1_C4_C7;
+			break;
+		case 2:
+			reg = AXD_REG_EQ_OUT2_POWER_B2_C4_C7;
+			break;
+		case 3:
+			reg = AXD_REG_EQ_OUT2_POWER_B3_C4_C7;
+			break;
+		case 4:
+			reg = AXD_REG_EQ_OUT2_POWER_B4_C4_C7;
+			break;
+		default:
+			dev_err(axd->dev, WRONG_BAND_STR, band);
+			return 0;
+		}
+	}
+	return reg;
+}
+
+unsigned int axd_get_resample_fin_reg(struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_RESAMPLER0_FIN;
+		break;
+	case 1:
+		reg = AXD_REG_RESAMPLER1_FIN;
+		break;
+	case 2:
+		reg = AXD_REG_RESAMPLER2_FIN;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
+
+unsigned int axd_get_resample_fout_reg(struct axd_cmd *cmd, unsigned int pipe)
+{
+	struct axd_dev *axd = container_of(cmd, struct axd_dev, cmd);
+	unsigned int reg;
+
+	switch (pipe) {
+	case 0:
+		reg = AXD_REG_RESAMPLER0_FOUT;
+		break;
+	case 1:
+		reg = AXD_REG_RESAMPLER1_FOUT;
+		break;
+	case 2:
+		reg = AXD_REG_RESAMPLER2_FOUT;
+		break;
+	default:
+		dev_err(axd->dev, WRONG_PIPE_STR, pipe);
+		return 0;
+	}
+	return reg;
+}
diff --git a/sound/soc/img/axd/axd_cmds_internal.h b/sound/soc/img/axd/axd_cmds_internal.h
new file mode 100644
index 000000000000..683fb4cedd73
--- /dev/null
+++ b/sound/soc/img/axd/axd_cmds_internal.h
@@ -0,0 +1,317 @@
+/*
+ * Copyright (C) 2011-2015 Imagination Technologies Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Common functionality required by other axd_cmds_*.c files.
+ */
+#ifndef AXD_CMDS_INTERNAL_H_
+#define AXD_CMDS_INTERNAL_H_
+
+#include <linux/io.h>
+
+#include "axd_cmds.h"
+
+#define CMP_PARAM(str, param) \
+	!strncmp((str), (param "="), sizeof(param "=")-1)
+
+#define PARAM_VALUE(str, param) \
+	PARAM_VALUE_WITH_END(str, param, NULL)
+
+#define PARAM_VALUE_WITH_END(str, param, end) \
+	simple_strtol((str)+sizeof(param "=")-1, end, 0)
+
+#define PARAM_VALUE_ADV(str, param) \
+	PARAM_VALUE_WITH_END(str, param, &str)
+
+void axd_ctrl_kick(struct axd_memory_map __iomem *message);
+void axd_kick_status_clear(struct axd_memory_map __iomem *message);
+int axd_wait_ready(struct axd_memory_map __iomem *message);
+
+int axd_write_ctrl(struct axd_cmd *cmd, unsigned int ctrl_command,
+						unsigned int ctrl_data);
+
+int axd_read_reg(struct axd_cmd *cmd, unsigned int reg, unsigned int *data);
+int axd_write_reg(struct axd_cmd *cmd, unsigned int reg, unsigned int value);
+
+int axd_write_reg_buf(struct axd_cmd *cmd, unsigned int reg,
+							unsigned int value);
+
+unsigned int axd_get_mixer_mux_reg(struct axd_cmd *cmd, unsigned int pipe);
+
+unsigned int axd_get_input_codec_number(struct axd_cmd *cmd, unsigned int pipe);
+unsigned int axd_get_input_control_reg(struct axd_cmd *cmd, unsigned int pipe);
+unsigned int axd_get_input_gain_reg(struct axd_cmd *cmd, unsigned int pipe);
+unsigned int axd_get_input_mute_reg(struct axd_cmd *cmd, unsigned int pipe);
+unsigned int axd_get_input_upmix_reg(struct axd_cmd *cmd, unsigned int pipe);
+unsigned int axd_get_input_buffer_occupancy_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+
+unsigned int axd_get_output_codec_number(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_output_control_reg(struct axd_cmd *cmd, unsigned int pipe);
+unsigned int axd_get_output_downmix_reg(struct axd_cmd *cmd, unsigned int pipe);
+unsigned int axd_get_output_event_reg(struct axd_cmd *cmd, unsigned int pipe);
+unsigned int axd_get_output_eqcontrol_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_output_eqband0_reg(struct axd_cmd *cmd, unsigned int pipe);
+unsigned int axd_get_output_eqband1_reg(struct axd_cmd *cmd, unsigned int pipe);
+unsigned int axd_get_output_eqband2_reg(struct axd_cmd *cmd, unsigned int pipe);
+unsigned int axd_get_output_eqband3_reg(struct axd_cmd *cmd, unsigned int pipe);
+unsigned int axd_get_output_eqband4_reg(struct axd_cmd *cmd, unsigned int pipe);
+
+unsigned int axd_get_output_eq_power_reg_ch0_3(struct axd_cmd *cmd,
+					unsigned int pipe, unsigned int band);
+unsigned int axd_get_output_eq_power_reg_ch4_7(struct axd_cmd *cmd,
+					unsigned int pipe, unsigned int band);
+
+unsigned int axd_get_output_dcpp_control_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_output_dcpp_max_delay_samples_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_output_dcpp_channel_ctrl_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_output_dcpp_band_ctrl_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_output_dcpp_channel_delay_samples_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_output_dcpp_channel_eq_output_volume_reg(
+					struct axd_cmd *cmd, unsigned int pipe);
+unsigned int axd_get_output_dcpp_channel_eq_passthrough_gain_reg(
+					struct axd_cmd *cmd, unsigned int pipe);
+unsigned int axd_get_output_dcpp_channel_eq_inverse_passthrough_gain_reg(
+					struct axd_cmd *cmd, unsigned int pipe);
+unsigned int axd_get_output_dcpp_channel_bass_shelf_shift_reg(
+					struct axd_cmd *cmd, unsigned int pipe);
+unsigned int axd_get_output_dcpp_channel_bass_shelf_a0_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_output_dcpp_channel_bass_shelf_a1_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_output_dcpp_channel_bass_shelf_a2_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_output_dcpp_channel_bass_shelf_b0_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_output_dcpp_channel_bass_shelf_b1_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_output_dcpp_channel_treble_shelf_shift_reg(
+					struct axd_cmd *cmd, unsigned int pipe);
+unsigned int axd_get_output_dcpp_channel_treble_shelf_a0_reg(
+					struct axd_cmd *cmd, unsigned int pipe);
+unsigned int axd_get_output_dcpp_channel_treble_shelf_a1_reg(
+					struct axd_cmd *cmd, unsigned int pipe);
+unsigned int axd_get_output_dcpp_channel_treble_shelf_a2_reg(
+					struct axd_cmd *cmd, unsigned int pipe);
+unsigned int axd_get_output_dcpp_channel_treble_shelf_b0_reg(
+					struct axd_cmd *cmd, unsigned int pipe);
+unsigned int axd_get_output_dcpp_channel_treble_shelf_b1_reg(
+					struct axd_cmd *cmd, unsigned int pipe);
+unsigned int axd_get_output_dcpp_channel_eq_gain_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_output_dcpp_channel_eq_a0_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_output_dcpp_channel_eq_a1_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_output_dcpp_channel_eq_a2_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_output_dcpp_channel_eq_b0_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_output_dcpp_channel_eq_b1_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_output_dcpp_channel_eq_shift_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_output_dcpp_subband_input_select_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_output_dcpp_subband_low_pass_filter_a0_reg(
+					struct axd_cmd *cmd, unsigned int pipe);
+unsigned int axd_get_output_dcpp_subband_low_pass_filter_a1_reg(
+					struct axd_cmd *cmd, unsigned int pipe);
+unsigned int axd_get_output_dcpp_subband_low_pass_filter_a2_reg(
+					struct axd_cmd *cmd, unsigned int pipe);
+unsigned int axd_get_output_dcpp_subband_low_pass_filter_b0_reg(
+					struct axd_cmd *cmd, unsigned int pipe);
+unsigned int axd_get_output_dcpp_subband_low_pass_filter_b1_reg(
+					struct axd_cmd *cmd, unsigned int pipe);
+
+unsigned int axd_get_decoder_aac_version_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_aac_channels_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_aac_profile_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_aac_streamtype_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_aac_samplerate_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+
+unsigned int axd_get_decoder_ac3_channels_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_ac3_channel_order_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_ac3_mode_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+
+unsigned int axd_get_decoder_cook_flavour_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+
+unsigned int axd_get_decoder_flac_channels_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_flac_samplerate_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_flac_bitspersample_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_flac_md5checking_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+
+unsigned int axd_get_decoder_mpeg_numchannels_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_mpeg_mlchannel_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+
+unsigned int axd_get_decoder_wma_playeropt_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_wma_drcsetting_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_wma_peakampref_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_wma_rmsampref_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_wma_peakamptarget_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_wma_rmsamptarget_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+
+unsigned int axd_get_decoder_wma_pcmvalidbitspersample_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_wma_pcmcontainersize_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+
+unsigned int axd_get_decoder_wma_wmaformattag_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_wma_wmanumchannels_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_wma_wmasamplespersec_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_wma_wmaaveragebytespersec_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_wma_wmablockalign_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_wma_wmavalidbitspersample_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_wma_wmachannelmask_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_wma_wmaencodeoptions_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_pcm_samplerate_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_pcm_channels_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_pcm_bitspersample_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_pcm_justification_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+
+unsigned int axd_get_decoder_ddplus_config_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_ddplus_channel_order_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+
+unsigned int axd_get_decoder_alac_channels_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_alac_depth_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_alac_samplerate_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_alac_framelength_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_alac_maxframebytes_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_alac_avgbitrate_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+
+unsigned int axd_get_decoder_sbc_samplerate_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_sbc_audiomode_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_sbc_blocks_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_sbc_subbands_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_sbc_bitpool_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_sbc_allocationmode_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+
+unsigned int axd_get_decoder_ms11_mode_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_ms11_common_config0_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_ms11_common_config1_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_ms11_ddt_config0_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_ms11_ddc_config0_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_decoder_ms11_ext_pcm_config0_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+
+unsigned int axd_get_encoder_pcm_bitspersample_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+
+unsigned int axd_get_encoder_flac_channels_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_encoder_flac_bitspersample_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_encoder_flac_samplerate_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_encoder_flac_totalsamples_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_encoder_flac_domidsidestereo_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_encoder_flac_loosemidsidestereo_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_encoder_flac_doexhaustivemodelsearch_reg(
+					struct axd_cmd *cmd, unsigned int pipe);
+unsigned int axd_get_encoder_flac_minresidualpartitionorder_reg(
+					struct axd_cmd *cmd, unsigned int pipe);
+unsigned int axd_get_encoder_flac_maxresidualpartitionorder_reg(
+					struct axd_cmd *cmd, unsigned int pipe);
+unsigned int axd_get_encoder_flac_blocksize_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_encoder_flac_bytecount_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_encoder_flac_samplecount_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_encoder_flac_framecount_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_encoder_flac_framebytes_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+
+unsigned int axd_get_encoder_alac_channels_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_encoder_alac_depth_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_encoder_alac_samplerate_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_encoder_alac_framelength_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_encoder_alac_maxframebytes_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_encoder_alac_avgbitrate_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+unsigned int axd_get_encoder_alac_fastmode_reg(struct axd_cmd *cmd,
+							unsigned int pipe);
+
+unsigned int axd_get_resample_fin_reg(struct axd_cmd *cmd, unsigned int pipe);
+unsigned int axd_get_resample_fout_reg(struct axd_cmd *cmd, unsigned int pipe);
+
+void axd_cmd_inpipe_init(struct axd_cmd *cmd, unsigned int pipe);
+void axd_cmd_outpipe_init(struct axd_cmd *cmd, unsigned int pipe);
+
+#endif /* AXD_CMDS_INTERNAL_H_ */
diff --git a/sound/soc/img/axd/axd_cmds_pipes.c b/sound/soc/img/axd/axd_cmds_pipes.c
index db355b531f76..64d5f170483b 100644
--- a/sound/soc/img/axd/axd_cmds_pipes.c
+++ b/sound/soc/img/axd/axd_cmds_pipes.c
@@ -722,7 +722,7 @@ void axd_cmd_inpipe_init(struct axd_cmd *cmd, unsigned int pipe)
 	mutex_init(&axd_pipe->eos_mutex);
 	atomic_set(&axd_pipe->intcount, 0);
 
-	/* default buffer size, could be changed through sysfs */
+	/* default buffer size, could be changed through kcontrol */
 	axd_pipe->buf_size = 1024*2;
 }
 
@@ -740,7 +740,7 @@ void axd_cmd_outpipe_init(struct axd_cmd *cmd, unsigned int pipe)
 	axd_set_flag(&axd_pipe->eos_flg, 0);
 	atomic_set(&axd_pipe->intcount, 0);
 
-	/* default buffer size, could be changed through sysfs */
+	/* default buffer size, could be changed through kcontrol */
 	axd_pipe->buf_size = 1024*16;
 }
 
-- 
2.1.0
