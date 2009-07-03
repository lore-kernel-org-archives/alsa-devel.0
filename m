From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] [RFC 3/13] Intel SST driver include headers
Date: Fri,  3 Jul 2009 12:32:25 +0530
Message-ID: <1246604545-12854-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 456E31038B6
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 08:53:27 +0200 (CEST)
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

This patch adds the intel_sst.h header file that is places in the
include folder for MAD driver (ALSA sound card driver for the platform
given in later patches) to use. This file contains the definitions
of interfaces exposed by the SST drivers along with the definitions of
all the controls for the sound card to be used by MAD driver.
intel_sst_ioctl.h - this file exposes the ioctls definitions
for player/middleware to use. Many of the definitions are reuse from ALSA

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>

	new file:   include/sound/intel_sst.h
	new file:   include/sound/intel_sst_ioctl.h
---
 include/sound/intel_sst.h       |  259 +++++++++++++++++++++++++++++
 include/sound/intel_sst_ioctl.h |  351 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 610 insertions(+), 0 deletions(-)
 create mode 100644 include/sound/intel_sst.h
 create mode 100644 include/sound/intel_sst_ioctl.h

diff --git a/include/sound/intel_sst.h b/include/sound/intel_sst.h
new file mode 100644
index 0000000..c709390
--- /dev/null
+++ b/include/sound/intel_sst.h
@@ -0,0 +1,259 @@
+#ifndef __INTEL_SST_H__
+#define __INTEL_SST_H__
+/*
+ *  intel_sst.h - Intel SST Driver for audio engine
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
+ *  This driver exposes the audio engine functionalities to the ALSA
+ *	and middleware.
+ *  This file is shared between the SST and MAD drivers
+ */
+
+#ifndef CONFIG_SST_IPC_NOT_INCLUDED
+#include <asm/ipc_defs.h>
+#endif
+
+#define SST_CARD_NAMES "intel_mid_card"
+
+/*
+control list Pmic & Lpe
+*/
+/*Input controls*/
+
+enum sst_controls {
+	SST_SND_ALLOC =				0x1000,
+	SST_SND_PAUSE =				0x1001,
+	SST_SND_RESUME =			0x1002,
+	SST_SND_DROP =				0x1003,
+	SST_SND_FREE =				0x1004,
+	SST_SND_BUFFER_POINTER =		0x1005,
+	SST_SND_STREAM_INIT =			0x1006,
+	SST_MAX_CONTROLS =			0x1006,
+	SST_CONTROL_BASE =			0x1000,
+};
+
+struct pcm_stream_info {
+	int str_id;
+	void *mad_substream;
+	void (*period_elapsed) (void *mad_substream);
+	unsigned long buffer_ptr;
+};
+
+struct sst_control_list {
+	int control_element;
+	char *value;
+	struct sst_control_list *next_elem;
+};
+
+struct stream_buffer {
+	unsigned long	addr;
+	int		length;
+};
+
+
+/*
+SST debug print statement definition
+*/
+
+static inline long sst_get_time(void)
+{
+	 struct timeval t;
+	 do_gettimeofday(&t);
+	 return t.tv_usec;
+}
+
+#define _sst_printk_(level, format, arg...) \
+	printk(level "Time:%8ld::%8ld >> SST: %s %d " format, \
+		get_seconds(), sst_get_time(), __func__ , __LINE__, ## arg)
+
+#define sst_err(format, arg...) _sst_printk_(KERN_ERR, "ERR: " format, ## arg)
+#define sst_info(format, arg...) \
+	_sst_printk_(KERN_INFO, "INFO: " format, ## arg)
+
+#ifdef CONFIG_SST_DBG_PRINT
+#define sst_dbg(format, arg...) _sst_printk_(KERN_DEBUG, "DBG: " format, ## arg)
+#else
+#define sst_dbg(format, arg...) do {} while (0);
+#endif
+struct snd_pmic_ops {
+	int (*set_input_dev) (int value);
+	int (*get_input_dev) (int *value);
+
+	int (*set_output_dev) (int value);
+	int (*get_output_dev) (int *value);
+
+	int (*set_mute) (int dev_id, int value);
+	int (*get_mute) (int dev_id, int *value);
+
+	int (*set_vol) (int dev_id, int value);
+	int (*get_vol) (int dev_id, int *value);
+
+	int(*init_card) (void);
+	void (*set_pcm_params) (int sfreq, int word_size);
+
+	int (*init_card_capture) (void);
+
+};
+
+struct intel_sst_card_ops {
+	char *module_name;
+	int  vendor_id;
+	int (*control_set) (int control_element, void *value);
+	int (*send_buffer) (int str_id, struct stream_buffer *mad_buf);
+	struct snd_pmic_ops *scard_ops;
+};
+
+int register_sst_card(struct intel_sst_card_ops *card);
+void unregister_sst_card(struct intel_sst_card_ops *card);
+
+/*periphral interrupt interface*/
+enum lpe_periphral {
+	LPE_DMA = 1,
+	LPE_SSP0,
+	LPE_SSP1
+};
+
+/*modified for generic access*/
+struct sc_reg_access {
+	u16 reg_addr;
+	u8 value;
+	u8 mask;
+};
+enum sc_reg_access_type {
+	PMIC_READ = 0,
+	PMIC_WRITE,
+	PMIC_READ_MODIFY,
+};
+
+static inline int sst_sc_reg_access(struct sc_reg_access *sc_access,
+							int type, int num_val)
+{
+#ifndef CONFIG_SST_IPC_NOT_INCLUDED
+	int i, retval = 0, j = 0, k = 0, count = 0;
+	struct ipc_pmic_reg_data reg_data;
+	struct ipc_pmic_mod_reg_data pmic_mod_reg = {0};
+
+	reg_data.ioc = TRUE;
+	if (type == PMIC_WRITE) {
+		do {
+			int max_retries = 0;
+
+			if (num_val <= 4)
+				count = num_val;
+			else
+				count = 4;
+retry_write:
+			for (i = 0; i < count; i++, j++) {
+				reg_data.pmic_reg_data[i].
+				register_address = sc_access[j].reg_addr;
+
+				reg_data.pmic_reg_data[i].value =
+						sc_access[j].value;
+			}
+			reg_data.num_entries = count;
+			retval = ipc_pmic_register_write(&reg_data, 0);
+			if (E_NO_INTERRUPT_ON_IOC == retval &&
+					max_retries < 10) {
+				sst_err("write communcation needs retry\n");
+				max_retries++;
+				goto retry_write;
+			}
+			if (0 != retval) {
+				/*pmic communication fails*/
+				sst_err("pmic write failed \n");
+				return retval;
+			}
+			num_val -= count;
+		} while (num_val > 0);
+	} else if (type == PMIC_READ) {
+		do {
+			int max_retries = 0;
+			if (num_val <= 4)
+				count = num_val;
+			else
+				count = 4;
+retry_read:
+			for (i = 0; i < count; i++, j++)
+				reg_data.pmic_reg_data[i].register_address
+						= sc_access[j].reg_addr;
+			reg_data.num_entries = count;
+			retval = ipc_pmic_register_read(&reg_data);
+			if (E_NO_INTERRUPT_ON_IOC == retval &&
+						max_retries < 10) {
+				sst_err("read communcation needs retry\n");
+				max_retries++;
+				goto retry_read;
+			}
+			if (0 != retval) {
+				/*pmic communication fails*/
+				sst_err("pmic read failed \n");
+				return retval;
+			}
+
+			for (i = 0; i < count; i++, k++)
+				sc_access[k].value =
+					reg_data.pmic_reg_data[i].value;
+			num_val -= count;
+		} while (num_val > 0);
+	} else {
+		pmic_mod_reg.ioc = TRUE;
+		do {
+			int max_retries = 0;
+			if (num_val <= 4)
+				count = num_val;
+			else
+				count = 4;
+retry_readmod:
+			for (i = 0; i < count; i++, j++) {
+				pmic_mod_reg.pmic_mod_reg_data[i].
+				register_address = sc_access[j].reg_addr;
+				pmic_mod_reg.pmic_mod_reg_data[i].value =
+							sc_access[j].value;
+				pmic_mod_reg.pmic_mod_reg_data[i].bit_map =
+							sc_access[j].mask;
+			}
+			pmic_mod_reg.num_entries = count;
+			retval = ipc_pmic_register_read_modify(&pmic_mod_reg);
+			if (E_NO_INTERRUPT_ON_IOC == retval &&
+						max_retries < 10) {
+				sst_err("read/modify retry\n");
+				max_retries++;
+				goto retry_readmod;
+			}
+			if (0 != retval) {
+				/*pmic communication fails*/
+				sst_err("pmic read_modify failed \n");
+				return retval;
+			}
+			num_val -= count;
+		} while (num_val > 0);
+	}
+	return retval;
+#else
+	return 0;
+#endif
+}
+
+int lpe_mask_periphral_intr(enum lpe_periphral device);
+int lpe_unmask_periphral_intr(enum lpe_periphral device);
+int lpe_periphral_intr_status(enum lpe_periphral device, int *status);
+#endif /*__INTEL_SST_H__*/
diff --git a/include/sound/intel_sst_ioctl.h b/include/sound/intel_sst_ioctl.h
new file mode 100644
index 0000000..848ea26
--- /dev/null
+++ b/include/sound/intel_sst_ioctl.h
@@ -0,0 +1,351 @@
+#ifndef __INTEL_SST_IOCTL_H__
+#define __INTEL_SST_IOCTL_H__
+/*
+ *  intel_sst_ipc.h - Intel SST Driver for audio engine
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
+ *  This file defines all sst ioctls
+ */
+
+/*codec and post/pre processing related info*/
+
+enum sst_codec_types {
+/*  AUDIO/MUSIC	CODEC Type Definitions */
+	SST_CODEC_TYPE_UNKNOWN = 0,
+	SST_CODEC_TYPE_PCM,	/* Pass through Audio codec */
+	SST_CODEC_TYPE_MP3,
+	SST_CODEC_TYPE_MP24,
+	SST_CODEC_TYPE_AAC,
+	SST_CODEC_TYPE_AACP,
+	SST_CODEC_TYPE_eAACP,
+	SST_CODEC_TYPE_WMA9,
+	SST_CODEC_TYPE_WMA10,
+	SST_CODEC_TYPE_WMA10P,
+	SST_CODEC_TYPE_RA,
+	SST_CODEC_TYPE_DDAC3,
+	SST_CODEC_TYPE_STEREO_TRUE_HD,
+	SST_CODEC_TYPE_STEREO_HD_PLUS,
+
+	/*  VOICE CODEC Type Definitions */
+	SST_CODEC_TYPE_VOICE_PCM = 0x21, /* Pass through voice codec */
+	SRC = 0x64,
+	MIXER = 0x65,
+	DOWN_MIXER = 0x66,
+	VOLUME_CONTROL = 0x67,
+	OEM1 = 0xC8,
+	OEM2 = 0xC9,
+};
+
+enum snd_sst_stream_ops {
+	STREAM_OPS_PLAYBACK = 0,	/* Decode */
+	STREAM_OPS_CAPTURE,		/* Encode */
+	STREAM_OPS_PLAYBACK_DRM,	/* Play Audio/Voice */
+	STREAM_OPS_PLAYBACK_ALERT,	/* Play Audio/Voice */
+	STREAM_OPS_CAPTURE_VOICE_CALL,	/* CSV Voice recording */
+};
+
+enum stream_type {
+	STREAM_TYPE_MUSIC = 1,
+	STREAM_TYPE_VOICE
+};
+
+/* Firmware Version info */
+struct snd_sst_fw_version {
+	__u8 build;	/* build number*/
+	__u8 minor;	/* minor number*/
+	__u8 major;	/* major number*/
+	__u8 type; /* build type*/
+};
+
+/* Port info structure */
+struct snd_sst_port_info {
+	__u16 port_type;
+	__u16  reserved;
+};
+
+/* Mixer info structure */
+struct snd_sst_mix_info {
+	__u16 max_streams;
+	__u16 reserved;
+};
+
+/* PCM Parameters */
+struct snd_pcm_params {
+	__u16 codec;	/* codec type */
+	__u8 num_chan;	/* 1=Mono, 2=Stereo	*/
+	__u8 pcm_wd_sz;	/* 16/24 - bit*/
+	__u32 brate;	/* Bitrate in bits per second */
+	__u32 sfreq;	/* Sampling rate in Hz */
+	__u16 frame_size;
+	__u16 samples_per_frame;	/* Frame size num samples per frame */
+	__u32 period_count; /* period elapsed time count, in samples,*/
+};
+
+/* MP3 Music Parameters Message */
+struct snd_mp3_params {
+	__u16  codec;
+	__u8   num_chan;	/* 1=Mono, 2=Stereo	*/
+	__u8   pcm_wd_sz; /* 16/24 - bit*/
+	__u32  brate; /* Use the hard coded value. */
+	__u32  sfreq; /* Sampling freq eg. 8000, 441000, 48000 */
+	__u8  crc_check; /* crc_check - disable (0) or enable (1) */
+	__u8  op_align; /* op align 0- 16 bit, 1- MSB, 2 LSB*/
+	__u16  reserved;	/* Unused */
+};
+
+#define AAC_BIT_STREAM_ADTS		0
+#define AAC_BIT_STREAM_ADIF		1
+#define AAC_BIT_STREAM_RAW		2
+
+/* AAC Music Parameters Message */
+struct snd_aac_params {
+	__u16 codec;
+	__u8 num_chan; /* 1=Mono, 2=Stereo*/
+	__u8 pcm_wd_sz; /* 16/24 - bit*/
+	__u32 brate;
+	__u32 sfreq; /* Sampling freq eg. 8000, 441000, 48000 */
+	__u32 aac_srate;	/* Plain AAC decoder operating sample rate */
+	__u8 mpg_id; /* 0=MPEG-2, 1=MPEG-4 */
+	__u8 bs_format; /* input bit stream format adts=0, adif=1, raw=2 */
+	__u8 aac_profile; /* 0=Main Profile, 1=LC profile, 3=SSR profile */
+	__u8 ext_chl; /* No.of external channels */
+	__u8 aot; /* Audio object type. 1=Main , 2=LC , 3=SSR, 4=SBR*/
+	__u8 op_align; /* output alignment 0=16 bit , 1=MSB, 2= LSB align */
+	__u8 brate_type; /* 0=CBR, 1=VBR */
+	__u8 crc_check; /* crc check 0= disable, 1=enable */
+	__s8 bit_stream_format[8]; /* input bit stream format adts/adif/raw */
+};
+
+/* WMA Music Parameters Message */
+struct snd_wma_params {
+	__u16  codec;
+	__u8   num_chan;	/* 1=Mono, 2=Stereo	*/
+	__u8   pcm_wd_sz;	/* 16/24 - bit*/
+	__u32  brate; 	/* Use the hard coded value. */
+	__u32  sfreq;	/* Sampling freq eg. 8000, 441000, 48000 */
+	__u32  channel_mask;  /* Channel Mask */
+	__u16  format_tag;	/* Format Tag */
+	__u16  block_align;	/* packet size */
+	__u16  wma_encode_opt;/* Encoder option */
+	__u8 op_align;	/* op align 0- 16 bit, 1- MSB, 2 LSB*/
+	__u8 reserved;	/* reserved */
+};
+
+/* Pre processing param structure */
+struct snd_prp_params {
+	__u32  reserved;	/* No pre-processing defined yet */
+};
+
+/* Post processing param structure */
+struct snd_pop_params {
+	s16 volume;		/* Voulme in db */
+	u16 ramp_duration; 	/* Ramp duration in ms */
+	u16 mute;		/* 0=Un-mute, 1=Mute*/
+	u16 reserved;		/* */
+};
+
+/* Post processing Capability info structure */
+struct snd_sst_postproc_info {
+	__u32 src_min;		/* Supported SRC Min sampling freq */
+	__u32 src_max;		/* Supported SRC Max sampling freq */
+	__u8  src;		/* 0=Not supported, 1=Supported */
+	__u8  bass_boost;		/* 0=Not Supported, 1=Supported */
+	__u8  stereo_widening;	/* 0=Not Supported, 1=Supported */
+	__u8  volume_control; 	/* 0=Not Supported, 1=Supported */
+	__s16 min_vol;		/* Minimum value of Volume in dB */
+	__s16 max_vol;		/* Maximum value of Volume in dB */
+};
+
+/* pre processing Capability info structure */
+struct snd_sst_prp_info {
+	__s16 min_vol;			/* Minimum value of Volume in dB */
+	__s16 max_vol;			/* Maximum value of Volume in dB */
+	__u8 volume_control; 		/* 0=Not Supported, 1=Supported */
+	__u8 reserved1;			/* for 32 bit alignment */
+	__u16 reserved2;			/* for 32 bit alignment */
+} __attribute__ ((packed));
+
+/* Firmware capabilities info */
+struct snd_sst_fw_info {
+	struct snd_sst_fw_version fw_version; /* Firmware version */
+	__u8 audio_codecs_supported[8];	/* Codecs supported by FW */
+	__u32 recommend_min_duration; /* Min duration for Low power Playback*/
+	__u8 max_pcm_streams_supported; /*Max number of PCM streams supported */
+	__u8 max_enc_streams_supported;	/*Max number of Encoded streams */
+	__u16 reserved;			/* 32 bit alignment*/
+	struct snd_sst_postproc_info pop_info; /* Post processing capability*/
+	struct snd_sst_prp_info prp_info; /* pre_processing mod cap info */
+	struct snd_sst_port_info port_info[2]; /* Port info */
+	struct snd_sst_mix_info mix_info; 	/* Mixer info */
+	__u32 min_input_buf; /*minmum i/p buffer for decode*/
+};
+
+/* Add the codec parameter structures for new codecs to be supported */
+#define CODEC_PARAM_STRUCTURES \
+	struct snd_pcm_params pcm_params; \
+	struct snd_mp3_params mp3_params; \
+	struct snd_aac_params aac_params; \
+	struct snd_wma_params wma_params;
+
+/* Pre and Post Processing param structures */
+#define PPP_PARAM_STRUCTURES \
+	struct snd_prp_params prp_params;\
+	struct snd_pop_params pop_params;
+
+/* Codec params struture */
+union  snd_sst_codec_params {
+	 CODEC_PARAM_STRUCTURES;
+};
+
+/* Pre-processing params struture */
+union snd_sst_ppp_params{
+	 PPP_PARAM_STRUCTURES;
+};
+
+struct snd_sst_stream_params {
+	union snd_sst_codec_params uc;
+	union snd_sst_ppp_params up;
+} __attribute__ ((packed));
+
+struct snd_sst_params {
+	unsigned long 	result;
+	unsigned int 	stream_id;
+	enum sst_codec_types codec;
+	enum snd_sst_stream_ops	ops;
+	unsigned int	stream_type;
+	struct snd_sst_stream_params sparams;
+};
+
+/*ioctl related stuff here*/
+struct snd_sst_pmic_config {
+	__u32  sfreq;                /* Sampling rate in Hz */
+	__u16  num_chan;             /* Mono =1 or Stereo =2 */
+	__u16  pcm_wd_sz;            /* Number of bits per sample */
+} __attribute__ ((packed));
+
+struct snd_sst_get_stream_params {
+	struct snd_sst_params codec_params;
+	struct snd_sst_pmic_config pcm_params;
+};
+
+enum snd_sst_target_type {
+	SND_SST_TARGET_PMIC = 1,
+	SND_SST_TARGET_OTHER,
+};
+
+enum snd_sst_port_action {
+	SND_SST_PORT_PREPARE = 1,
+	SND_SST_PORT_ACTIVATE,
+};
+
+/* Target selection per device structure */
+struct snd_sst_slot_info {
+	__u8 mix_enable;		/* Mixer enable or disable */
+	__u8 device_type;
+	__u8 device_instance; 	/* 0, 1, 2 */
+	__u16 slot[2];
+	struct snd_sst_pmic_config pcm_params;
+	enum snd_sst_target_type type;
+	__s8 master;
+	enum snd_sst_port_action action;
+} __attribute__ ((packed));
+
+/* Target device list structure */
+struct snd_sst_target_device  {
+	__u32 device_route;
+	struct snd_sst_slot_info devices[2];
+} __attribute__ ((packed));
+
+struct snd_sst_driver_info {
+	unsigned int version;	/* Version of the driver */
+	unsigned int active_pcm_streams;
+	unsigned int active_enc_streams;
+	unsigned int max_pcm_streams;
+	unsigned int max_enc_streams;
+	unsigned int buf_per_stream;
+};
+
+struct snd_sst_vol {
+	unsigned int	stream_id;
+	int		volume;
+	unsigned long	ramp_duration;
+	__u32 ramp_type;		/* Ramp type, default=0 */
+};
+
+struct snd_sst_mute {
+	unsigned int	stream_id;
+	int		mute;
+};
+
+enum snd_sst_buff_type {
+	SST_BUF_USER = 1,
+	SST_BUF_MMAP,
+	SST_BUF_RAR,
+};
+
+struct snd_sst_buff_entry {
+	union {
+		void *user;
+		unsigned int offset;
+	} buffer;
+	unsigned int size;
+};
+
+struct snd_sst_buffs {
+	unsigned int entries;
+	enum snd_sst_buff_type type;
+	struct snd_sst_buff_entry *buff;
+};
+
+struct snd_sst_dbufs  {
+	struct snd_sst_buff_entry *ibufs;
+	struct snd_sst_buff_entry *obufs;
+	__s8 force;
+};
+
+/*IOCTL defined here*/
+/*SST MMF IOCTLS only*/
+#define SNDRV_SST_STREAM_SET_PARAMS _IOR('L', 0x00, \
+					struct snd_sst_stream_params *)
+#define SNDRV_SST_STREAM_GET_PARAMS _IOWR('L', 0x01, \
+					struct snd_sst_get_stream_params *)
+#define SNDRV_SST_STREAM_GET_TSTAMP _IOWR('L', 0x02, unsigned long long *)
+#define	SNDRV_SST_STREAM_DECODE	_IOWR('L', 0x03, struct snd_sst_dbufs *)
+#define SNDRV_SST_STREAM_START	_IO('A', 0x42)
+#define SNDRV_SST_STREAM_DROP 	_IO('A', 0x43)
+#define SNDRV_SST_STREAM_DRAIN	_IO('A', 0x44)
+#define SNDRV_SST_STREAM_PAUSE 	_IOW('A', 0x45, int)
+#define SNDRV_SST_STREAM_RESUME _IO('A', 0x47)
+#define SNDRV_SST_MMAP_PLAY	_IOW('L', 0x05, struct snd_sst_buffs *)
+#define SNDRV_SST_MMAP_CAPTURE _IOW('L', 0x06, struct snd_sst_buffs *)
+/*SST common ioctls */
+#define SNDRV_SST_DRIVER_INFO	_IOR('L', 0x10, struct snd_sst_driver_info *)
+#define SNDRV_SST_SET_VOL	_IOW('L', 0x11, struct snd_sst_vol *)
+#define SNDRV_SST_GET_VOL	_IOW('L', 0x12, struct snd_sst_vol *)
+#define SNDRV_SST_MUTE		_IOW('L', 0x13, struct snd_sst_mute *)
+
+/*AM Ioctly only*/
+#define SNDRV_SST_FW_INFO	_IOR('L', 0x20,  struct snd_sst_fw_info *)
+#define SNDRV_SST_SET_TARGET_DEVICE _IOW('L', 0x21, \
+					struct snd_sst_target_device *)
+
+#endif /*__INTEL_SST_IOCTL_H__*/
-- 
1.5.4.5
