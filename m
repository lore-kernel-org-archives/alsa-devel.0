From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] [RFC 12/13] Intel SST sound card headers
Date: Fri,  3 Jul 2009 11:54:38 +0530
Message-ID: <1246602278-11456-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id E156B1038D3
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 08:15:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, Harsha Priya <priya.harsha@intel.com>
List-Id: alsa-devel@alsa-project.org

This adds header files of sound card driver, it defines some utility
functions and common declarations for vendor sound cards as well

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>

	new file:   sound/pci/sst/intelmid.h
	new file:   sound/pci/sst/intelmid_pvt.h
	new file:   sound/pci/sst/intelmid_snd_control.h
---
 sound/pci/sst/intelmid.h             |  274 ++++++++++++++++++++++++++++++++++
 sound/pci/sst/intelmid_pvt.h         |  198 ++++++++++++++++++++++++
 sound/pci/sst/intelmid_snd_control.h |  153 +++++++++++++++++++
 3 files changed, 625 insertions(+), 0 deletions(-)
 create mode 100644 sound/pci/sst/intelmid.h
 create mode 100644 sound/pci/sst/intelmid_pvt.h
 create mode 100644 sound/pci/sst/intelmid_snd_control.h

diff --git a/sound/pci/sst/intelmid.h b/sound/pci/sst/intelmid.h
new file mode 100644
index 0000000..938ad52
--- /dev/null
+++ b/sound/pci/sst/intelmid.h
@@ -0,0 +1,274 @@
+/*
+ *  intelmid.c - Intel Sound card driver for MID
+ *
+ *  Copyright (C) 2008-09 Intel Corp
+ *  Authors:	Vinod Koul <vinod.koul@intel.com>
+ *		Harsha Priya <priya.harsha@intel.com>
+ *
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *  ALSA driver  header for Intel MAD chipset
+ */
+#ifndef __INTELMID_H
+#define __INTELMID_H
+
+#include <linux/time.h>
+#define DRIVER_NAME "pmic_audio"
+#define PMIC_SOUND_IRQ_TYPE_MASK (1 << 15)
+#define AUDINT_BASE (0xFFFFEFF8 + (6 * sizeof(u8)))
+/*#define FULL_CTRL*/
+/*#define REG_IRQ*/
+/*values #defined  */
+/* will differ for different hw - to be taken from config */
+#define MAX_DEVICES		1
+#define MIN_RATE		8000
+#define MAX_RATE		48000
+#define MAX_BUFFER		(320*1024)
+#define MIN_BUFFER		(320*1024)
+#define MAX_PERIODS		(1024*2)
+#define MIN_PERIODS		1
+#define MAX_PERIOD_BYTES MAX_BUFFER
+#define MIN_PERIOD_BYTES 32
+#define MAX_MUTE		1
+#define MIN_MUTE		0
+#define MONO_CNTL		1
+#define STEREO_CNTL		2
+#define MIN_CHANNEL		1
+#define MAX_CHANNEL		2
+#define FIFO_SIZE		0 /*fifo not being used*/
+#define INTEL_MAD		"Intel MAD"
+#define MUTE_ALL_DEV	9
+/*TODO +6 db*/
+#define MAX_VOL 		64
+/*TODO -57 db*/
+#define MIN_VOL 		0
+#define PLAYBACK_COUNT  1
+#define CAPTURE_COUNT  	1
+
+struct mad_device {
+	unsigned int 	mic_plugged:1;
+	unsigned int 	headphones_plugged:1;
+	unsigned int 	line_in_plugged:1;
+};
+
+struct mad_wq {
+	struct snd_pcm_substream *substream;
+	struct work_struct	wq;
+	struct mutex wq_lock;
+};
+
+struct mad_capture_wq {
+	struct snd_pcm_substream *substream;
+	struct stream_buffer buffer_to_sst;
+	struct work_struct	wq;
+};
+struct snd_intelmad {
+	struct snd_card	*card; /*ptr to the card details*/
+	int		card_index;/* card index */
+	char		*card_id; /*card id*/
+	struct mad_device pin_sense; /*current pin sense */
+	struct intel_sst_card_ops *sstdrv_ops;/*ptr to sst driver ops*/
+	struct spi_device *spi;
+	int irq;
+	int pmic_status;
+	void __iomem *int_base;
+};
+
+struct snd_control_val {
+	int	mic1_vol_max;
+	int	mic1_vol_min;
+	int	mic2_vol_max;
+	int	mic2_vol_min;
+	int	dmic_vol_max;
+	int	dmic_vol_min;
+	int	linein_vol_max;
+	int	linein_vol_min;
+	int	hp_vol_max;
+	int	hp_vol_min;
+	int	speaker_vol_max;
+	int	speaker_vol_min;
+	int	earpiece_vol_max;
+	int	earpiece_vol_min;
+};
+
+struct mad_stream_pvt {
+	int 		stream_id;
+	int 		stream_status;
+	int		stream_ops;
+	unsigned int	stream_type; /*0:Audio 1:Voice Default:Audio*/
+	struct snd_pcm_substream *substream;
+	unsigned int 	pcm_size;
+	unsigned int 	pcm_jiffie;
+	unsigned int 	pcm_buf_pos;
+	struct snd_pcm_indirect pcm_indirect;
+	struct pcm_stream_info buf_ptr;
+	unsigned long	period_elapsed_ptr;
+	struct mad_wq 	mad_msg_wq;
+	struct mad_capture_wq 	mad_capture_wq;
+};
+
+enum mad_drv_status {
+    INIT = 1,
+    STARTED,
+    RUNNING,
+    PAUSED,
+    DROPPED,
+};
+
+enum mad_pmic_status {
+	PMIC_UNINIT = 1,
+	PMIC_INIT,
+};
+#ifdef FULL_CTRL
+enum _widget_ctrl {
+	LINE_IN_VOL  = 1,
+	LINE_IN_MUTE,
+	DMIC_VOL,
+	DMIC_MUTE,
+	MIC1_VOL,
+	MIC1_MUTE,
+	MIC2_VOL,
+	MIC2_MUTE,
+	INPUT_SEL,
+	HEADPHONES_VOL ,
+	HEADPHONES_MUTE,
+	INTERNAL_SPEAKERS_VOL,
+	INTERNAL_SPEAKERS_MUTE,
+	EARPIECE_VOL,
+	EARPIECE_MUTE,
+	OUTPUT_SEL,
+	MASTER_MUTE
+};
+#else
+enum _widget_ctrl {
+	HEADPHONES_VOL = 1 ,
+	HEADPHONES_MUTE,
+};
+#endif
+
+enum {
+	AUDIO_GENL_ATTR_UNSPEC = 0,
+	AUDIO_GENL_ATTR_EVENT,	/* Audio event info needed by user space */
+	AUDIO_GENL_ATTR_MAX,
+};
+enum {
+	AUDIO_GENL_CMD_UNSPEC,
+	AUDIO_GENL_CMD_EVENT,	/* kernel->user notifications for OSPM events */
+	AUDIO_GENL_CMD_MAX,
+};
+
+enum eaudio_events {
+	AUDIO_EVENT_HP_DETECT,
+	AUDIO_EVENT_HS_DETECT,
+	AUDIO_EVENT_SHORT_PRESS,
+	AUDIO_EVENT_LONG_PRESS,
+	AUDIO_EVENT_COUNT,
+};
+
+struct audio_genl_event {
+	u32 orig;
+	enum eaudio_events event;
+};
+
+struct snd_pmic_ops v[3] = {
+	{
+		.set_input_dev 	= 	fs_set_selected_input_dev,
+		.set_output_dev = 	fs_set_selected_output_dev,
+		.set_mute 	=	fs_set_mute,
+		.get_mute 	= 	fs_get_mute,
+		.set_vol 	= 	fs_set_vol,
+		.get_vol 	= 	fs_get_vol,
+		.init_card 	= 	fs_init_card,
+		.set_pcm_params	=	fs_set_pcm_params,
+		.init_card_capture = 	fs_init_capture_card,
+	},
+	{
+		.set_input_dev 	= 	mx_set_selected_input_dev,
+		.set_output_dev = 	mx_set_selected_output_dev,
+		.set_mute 	= 	mx_set_mute,
+		.get_mute 	= 	mx_get_mute,
+		.set_vol 	= 	mx_set_vol,
+		.get_vol 	= 	mx_get_vol,
+		.init_card 	= 	mx_init_card,
+		.set_pcm_params	=	mx_set_pcm_params,
+		.init_card_capture =	mx_init_capture_card,
+	},
+	{
+		.set_input_dev 	= 	nc_set_selected_input_dev,
+		.set_output_dev = 	nc_set_selected_output_dev,
+		.set_mute 	= 	nc_set_mute,
+		.get_mute 	= 	nc_get_mute,
+		.set_vol 	= 	nc_set_vol,
+		.get_vol 	= 	nc_get_vol,
+		.init_card 	= 	nc_init_card,
+		.set_pcm_params	=	nc_set_pcm_params,
+		.init_card_capture =	nc_init_capture_card,
+	},
+};
+
+struct snd_control_val ctrl_val[3] = {
+	{
+		.mic1_vol_max = MAX_VOL,
+		.mic1_vol_min = MIN_VOL,
+		.mic2_vol_max = MAX_VOL,
+		.mic2_vol_min = MIN_VOL,
+		.dmic_vol_max = MAX_VOL,
+		.dmic_vol_min = MIN_VOL,
+		.linein_vol_max = MAX_VOL,
+		.linein_vol_min = MIN_VOL,
+		.hp_vol_max = MAX_VOL,
+		.hp_vol_min = MIN_VOL,
+		.speaker_vol_max = MAX_VOL,
+		.speaker_vol_min = MIN_VOL,
+		.earpiece_vol_max = MAX_VOL,
+		.earpiece_vol_min = MIN_VOL,
+	},
+	{
+		.mic1_vol_max = MAX_VOL,
+		.mic1_vol_min = MIN_VOL,
+		.mic2_vol_max = MAX_VOL,
+		.mic2_vol_min = MIN_VOL,
+		.dmic_vol_max = MAX_VOL,
+		.dmic_vol_min = MIN_VOL,
+		.linein_vol_max = MAX_VOL,
+		.linein_vol_min = MIN_VOL,
+		.hp_vol_max = MAX_VOL,
+		.hp_vol_min = MIN_VOL,
+		.speaker_vol_max = MAX_VOL,
+		.speaker_vol_min = MIN_VOL,
+		.earpiece_vol_max = MAX_VOL,
+		.earpiece_vol_min = MIN_VOL,
+	},
+	{
+		.mic1_vol_max = 30,
+		.mic1_vol_min = 10,
+		.mic2_vol_max = 30,
+		.mic2_vol_min = 10,
+		.dmic_vol_max = 0,
+		.dmic_vol_min = -63,
+		.linein_vol_max = MAX_VOL,
+		.linein_vol_min = MIN_VOL,
+		.hp_vol_max = 6,
+		.hp_vol_min = -25,
+		.speaker_vol_max = 6,
+		.speaker_vol_min = -25,
+		.earpiece_vol_max = 6,
+		.earpiece_vol_min = -25,
+	},
+};
+
+#endif /*__INTELMID_H*/
diff --git a/sound/pci/sst/intelmid_pvt.h b/sound/pci/sst/intelmid_pvt.h
new file mode 100644
index 0000000..73cb9b5
--- /dev/null
+++ b/sound/pci/sst/intelmid_pvt.h
@@ -0,0 +1,198 @@
+#ifndef __INTEL_MID_PVT_H__
+#define __INTEL_MID_PVT_H__
+/*
+ *   intelmid_pvt.h - Intel Sound card driver for MID
+ *
+ *  Copyright (C) 2008-09 Intel Corp
+ *  Authors:	Vinod Koul <vinod.koul@intel.com>
+ *		Harsha Priya <priya.harsha@intel.com>
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * ALSA driver for Intel MID sound card chipset - holding private functions
+ */
+
+static int snd_intelmad_volume_info(struct snd_ctl_elem_info *uinfo,
+					int control_type, int max, int min)
+{
+	WARN_ON(!uinfo);
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = control_type;
+	uinfo->value.integer.min = min;
+	uinfo->value.integer.max = max;
+	return 0;
+}
+
+#ifdef FULL_CTRL
+/**
+* mute_all - mutes all the DAC and ADC controls
+* @kcontrol:	pointer to the control of master mute switch
+* @uval: 	pointer to the structure where the control's info need
+*		to be filled
+* This function is internally called from snd_intelmad_mute_set for master_mute
+*/
+static int mute_all(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *uval)
+{
+	int i = 0, value = 0, ret_val = 0;
+	struct snd_intelmad *intelmaddata = NULL;
+	struct snd_pmic_ops *scard_ops = NULL;
+	int cntl_list[MUTE_ALL_DEV] =
+			{PMIC_SND_LEFT_HP_MUTE,
+			 PMIC_SND_RIGHT_HP_MUTE,
+			 PMIC_SND_RIGHT_SPEAKER_MUTE,
+			 PMIC_SND_LEFT_SPEAKER_MUTE,
+			 PMIC_SND_MONO_EARPIECE_MUTE,
+			 PMIC_SND_INPUT_MUTE_LINE_IN,
+			 PMIC_SND_INPUT_MUTE_MIC1,
+			 PMIC_SND_INPUT_MUTE_MIC2,
+			 PMIC_SND_INPUT_MUTE_DMIC
+			};
+
+	sst_dbg("called\n");
+
+	WARN_ON(!uval);
+	WARN_ON(!kcontrol);
+
+	value = uval->value.integer.value[0];
+	if (value == 0)
+		value = 1;
+	else
+		value = 0;
+
+	intelmaddata = kcontrol->private_data;
+
+	WARN_ON(!intelmaddata->sstdrv_ops);
+
+	if (PMIC_UNINIT == intelmaddata->pmic_status) {
+		ret_val = intelmaddata->sstdrv_ops->scard_ops->init_card();
+		intelmaddata->pmic_status = PMIC_INIT;
+	}
+
+	if (0 != ret_val)
+		return ret_val;
+
+	scard_ops = intelmaddata->sstdrv_ops->scard_ops;
+
+	WARN_ON(!scard_ops);
+	sst_dbg("************uval::%ld\n", uval->value.integer.value[0]);
+	sst_dbg("************value::%d\n", value);
+	for (i = 0; i < MUTE_ALL_DEV; i++) {
+		ret_val = scard_ops->set_mute(cntl_list[i], value);
+		if (0 != ret_val)
+			return ret_val;
+	}
+	kcontrol->private_value = 0;
+	return ret_val;
+}
+#endif
+
+void period_elapsed(void *mad_substream)
+{
+	struct snd_pcm_substream *substream = mad_substream;
+	struct mad_stream_pvt *stream = substream->runtime->private_data;
+
+	sst_dbg("called\n");
+	if (stream->stream_status != RUNNING)
+		return;
+	sst_dbg("calling period elapsed\n");
+	snd_pcm_period_elapsed(substream);
+	return;
+}
+
+
+int snd_intelmad_alloc_stream(struct snd_pcm_substream *substream)
+{
+	struct snd_intelmad *intelmaddata = NULL;
+	struct mad_stream_pvt *stream = substream->runtime->private_data;
+	struct snd_sst_stream_params param = {{{0,},},};
+	struct snd_sst_params str_params = {0};
+	int ret_val = 0, stream_type = 0;
+	unsigned int bits_per_sec = 0;
+
+	intelmaddata = snd_pcm_substream_chip(substream);
+
+	if (SNDRV_PCM_FMTBIT_S8 == substream->runtime->format ||
+			SNDRV_PCM_FMTBIT_U8 == substream->runtime->format)
+		stream->stream_type = STREAM_TYPE_VOICE;
+	else
+		stream->stream_type = STREAM_TYPE_MUSIC;
+
+	stream_type = substream->stream;
+	sst_dbg("stream type = %d \n", stream_type);
+
+	bits_per_sec = (substream->runtime->sample_bits/8)
+			* (substream->runtime->channels)
+			* (substream->runtime->rate);
+	/*set codec params and inform SST driver the same*/
+
+	param.uc.pcm_params.codec = SST_CODEC_TYPE_PCM;
+	param.uc.pcm_params.brate = bits_per_sec;
+	param.uc.pcm_params.num_chan = substream->runtime->channels;
+	param.uc.pcm_params.sfreq = substream->runtime->rate;
+	param.uc.pcm_params.pcm_wd_sz = substream->runtime->sample_bits;
+	param.uc.pcm_params.frame_size = 0;
+	param.uc.pcm_params.samples_per_frame = 250;
+	param.uc.pcm_params.period_count = substream->runtime->period_size;
+	sst_dbg("period_count = %d\n", param.uc.pcm_params.period_count);
+	sst_dbg("sfreq= %d, wd_sz = %d\n", param.uc.pcm_params.sfreq,
+					param.uc.pcm_params.pcm_wd_sz);
+
+	str_params.sparams = param;
+	str_params.codec = SST_CODEC_TYPE_PCM;
+
+	if (SNDRV_PCM_STREAM_PLAYBACK == stream_type)
+		str_params.ops = STREAM_OPS_PLAYBACK;
+	else
+		str_params.ops = STREAM_OPS_CAPTURE;
+	ret_val = intelmaddata->sstdrv_ops->control_set(SST_SND_ALLOC,
+					&str_params);
+	sst_dbg("SST_SND_PLAY/CAPTURE ret_val = %x\n",
+			ret_val);
+	if (ret_val < 0)
+		return ret_val;
+
+	stream->stream_id = ret_val;
+	stream->stream_status = INIT;
+	stream->period_elapsed_ptr = 0;
+	stream->buf_ptr.buffer_ptr = 0;
+	sst_dbg("str id :  %d\n", stream->stream_id);
+
+	return ret_val;
+}
+
+int snd_intelmad_init_stream(struct snd_pcm_substream *substream)
+{
+	struct mad_stream_pvt *stream = substream->runtime->private_data;
+	struct snd_intelmad *intelmaddata = NULL;
+	int ret_val = 0;
+
+	sst_dbg("setting buffer ptr param\n");
+	intelmaddata = snd_pcm_substream_chip(substream);
+	stream->buf_ptr.str_id = stream->stream_id;
+	stream->buf_ptr.period_elapsed = period_elapsed;
+	stream->buf_ptr.mad_substream = substream;
+	stream->buf_ptr.buffer_ptr = 0;
+	ret_val = intelmaddata->sstdrv_ops->control_set(SST_SND_STREAM_INIT,
+					&stream->buf_ptr);
+	if (0 != ret_val)
+		sst_err("error code = %d \n", ret_val);
+	return ret_val;
+
+}
+
+#endif
diff --git a/sound/pci/sst/intelmid_snd_control.h b/sound/pci/sst/intelmid_snd_control.h
new file mode 100644
index 0000000..49fdf9c
--- /dev/null
+++ b/sound/pci/sst/intelmid_snd_control.h
@@ -0,0 +1,153 @@
+#ifndef __INTELMID_SND_CTRL_H__
+#define __INTELMID_SND_CTRL_H__
+/*
+ *  intelmid_snd_control.h - Intel Sound card driver for MID
+ *
+ *  Copyright (C) 2008-09 	Intel Corporation
+ *  Authors:	Vinod Koul <vinod.koul@intel.com>
+ *  		Harsha Priya <priya.harsha@intel.com>
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This file defines all snd control functions
+ */
+
+/*
+Mask bits
+*/
+#define MASK0 	0x01	/*0000 0001*/
+#define MASK1 	0x02	/*0000 0010*/
+#define MASK2 	0x04	/*0000 0100*/
+#define MASK3 	0x08	/*0000 1000*/
+#define MASK4 	0x10	/*0001 0000*/
+#define MASK5 	0x20	/*0010 0000*/
+#define MASK6 	0x40	/*0100 0000*/
+#define MASK7 	0x80	/*1000 0000*/
+/*
+value bits
+*/
+#define VALUE0	0x01	/*0000 0001*/
+#define VALUE1	0x02	/*0000 0010*/
+#define VALUE2	0x04	/*0000 0100*/
+#define VALUE3	0x08	/*0000 1000*/
+#define VALUE4	0x10	/*0001 0000*/
+#define VALUE5	0x20	/*0010 0000*/
+#define VALUE6	0x40	/*0100 0000*/
+#define VALUE7	0x80	/*1000 0000*/
+
+#define MUTE 0    /* ALSA Passes 0 for mute */
+#define UNMUTE 1  /* ALSA Passes 1 for unmute */
+
+#define MAX_VOL_PMIC_VENDOR0    6 /* max volume in dB for stereo & voice DAC */
+#define MIN_VOL_PMIC_VENDOR0    (-57) /* min vol in dB for stereo & voice DAC*/
+/* Head phone volume control */
+#define MAX_HP_VOL_PMIC_VENDOR1    6 /* max volume in dB for HP */
+#define MIN_HP_VOL_PMIC_VENDOR1    (-84) /* min volume in dB for HP */
+#define MAX_HP_VOL_INDX_PMIC_VENDOR1 40 /* Number of HP volume control values */
+
+/* Mono Earpiece Volume control */
+#define MAX_EP_VOL_PMIC_VENDOR1    0 /* max volume in dB for EP */
+#define MIN_EP_VOL_PMIC_VENDOR1    (-75) /* min volume in dB for EP */
+#define MAX_EP_VOL_INDX_PMIC_VENDOR1 32 /* Number of EP volume control values */
+
+int nc_set_selected_input_dev(int value);
+int nc_get_selected_input_dev(int *value);
+int nc_set_selected_output_dev(int value);
+int nc_get_selected_output_dev(int *value);
+int nc_set_mute(int dev_id, int value);
+int nc_get_mute(int dev_id, int *value);
+int nc_set_vol(int dev_id, int value);
+int nc_get_vol(int dev_id, int *value);
+int nc_init_card(void);
+void nc_set_pcm_params(int sfreq, int word_size);
+int nc_init_capture_card(void);
+
+int fs_set_selected_input_dev(int value);
+int fs_get_selected_input_dev(int *value);
+int fs_set_selected_output_dev(int value);
+int fs_get_selected_output_dev(int *value);
+int fs_set_mute(int dev_id, int value);
+int fs_get_mute(int dev_id, int *value);
+int fs_set_vol(int dev_id, int value);
+int fs_get_vol(int dev_id, int *value);
+int fs_init_card(void);
+void fs_set_pcm_params(int sfreq, int word_size);
+int fs_init_capture_card(void);
+
+int mx_get_selected_input_dev(int *value);
+int mx_set_selected_input_dev(int value);
+int mx_set_selected_output_dev(int value);
+int mx_get_selected_output_dev(int *value);
+int mx_set_mute(int dev_id, int value);
+int mx_get_mute(int dev_id, int *value);
+int mx_set_vol(int dev_id, int value);
+int mx_get_vol(int dev_id, int *value);
+int mx_init_card(void);
+void mx_set_pcm_params(int sfreq, int word_size);
+int mx_init_capture_card(void);
+
+
+/*device*/
+enum SND_INPUT_DEVICE {
+	LINE_IN = 0,
+	MIC1,
+	MIC2,
+	DMIC,
+	IN_UNDEFINED
+};
+
+enum SND_OUTPUT_DEVICE {
+	MONO_HS = 0,
+	STEREO_HEADPHONE,
+	INTERNAL_SPKR,
+	OUT_UNDEFINED
+};
+
+enum SND_CARDS {
+	SND_FS = 0,
+	SND_MX,
+	SND_NC,
+};
+
+enum pmic_controls {
+	PMIC_SND_INPUT_MUTE_LINE_IN =		0x0001,
+	PMIC_SND_INPUT_MUTE_MIC1 =		0x0002,
+	PMIC_SND_INPUT_MUTE_MIC2 =		0x0003,
+	PMIC_SND_INPUT_MUTE_DMIC =		0x0004,
+	PMIC_SND_INPUT_VOL_MIC1 =		0x0005,
+	PMIC_SND_INPUT_VOL_MIC2 =		0x0006,
+	PMIC_SND_INPUT_VOL_DMIC =		0x0007,
+	PMIC_SND_INPUT_VOL_RIGHT_LINE_IN =	0x0008,
+	PMIC_SND_INPUT_VOL_LEFT_LINE_IN =	0x0009,
+/*Output controls*/
+	PMIC_SND_LEFT_HP_VOL =			0x0010,
+	PMIC_SND_RIGHT_HP_VOL =			0x0011,
+	PMIC_SND_LEFT_HP_MUTE =			0x0012,
+	PMIC_SND_RIGHT_HP_MUTE =	 	0x0013,
+	PMIC_SND_LEFT_SPEAKER_VOL =		0x0014,
+	PMIC_SND_RIGHT_SPEAKER_VOL =		0x0015,
+	PMIC_SND_LEFT_SPEAKER_MUTE =		0x0016,
+	PMIC_SND_RIGHT_SPEAKER_MUTE =		0x0017,
+	PMIC_SND_MONO_EARPIECE_VOL =		0x0018,
+	PMIC_SND_MONO_EARPIECE_MUTE =		0x0019,
+/*Other controls*/
+	PMIC_MAX_CONTROLS =			0x0019,
+};
+
+#endif /*__INTELMID_SND_CTRL_H__*/
+
+
-- 
1.5.4.5
