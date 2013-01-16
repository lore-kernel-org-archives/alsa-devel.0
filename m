From: Yoichi Yuasa <yuasa@linux-mips.org>
Subject: [PATCH 17/19] ALSA: ymu831: add codec driver
Date: Wed, 16 Jan 2013 17:43:28 +0900
Message-ID: <20130116174328.5b309b4f4d15c08fe6e8548a@linux-mips.org>
References: <20130116172530.857b627ef3303fb6fe43f603@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20130116172530.857b627ef3303fb6fe43f603@linux-mips.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, yuasa@linux-mips.org
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 sound/soc/codecs/ymu831/Makefile      |    2 +-
 sound/soc/codecs/ymu831/ymu831.c      | 5235 +++++++++++++++++++++++++++++++++
 sound/soc/codecs/ymu831/ymu831.h      |   48 +
 sound/soc/codecs/ymu831/ymu831_priv.h |  278 ++
 4 files changed, 5562 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/codecs/ymu831/ymu831.c
 create mode 100644 sound/soc/codecs/ymu831/ymu831.h
 create mode 100644 sound/soc/codecs/ymu831/ymu831_priv.h

diff --git a/sound/soc/codecs/ymu831/Makefile b/sound/soc/codecs/ymu831/Makefile
index 3fd53fe..ada24db 100644
--- a/sound/soc/codecs/ymu831/Makefile
+++ b/sound/soc/codecs/ymu831/Makefile
@@ -1,4 +1,4 @@
-snd-soc-ymu831-objs := \
+snd-soc-ymu831-objs := ymu831.o \
 	mcbdspdrv.o	\
 	mccdspdrv.o	\
 	mcdevif.o	\
diff --git a/sound/soc/codecs/ymu831/ymu831.c b/sound/soc/codecs/ymu831/ymu831.c
new file mode 100644
index 0000000..62c4a90
--- /dev/null
+++ b/sound/soc/codecs/ymu831/ymu831.c
@@ -0,0 +1,5235 @@
+/*
+ * YMU831 ASoC codec driver
+ *
+ * Copyright (c) 2012 Yamaha Corporation
+ *
+ * This software is provided 'as-is', without any express or implied
+ * warranty.	In no event will the authors be held liable for any damages
+ * arising from the use of this software.
+ *
+ * Permission is granted to anyone to use this software for any purpose,
+ * including commercial applications, and to alter it and redistribute it
+ * freely, subject to the following restrictions:
+ *
+ * 1. The origin of this software must not be misrepresented; you must not
+ *	claim that you wrote the original software. If you use this software
+ *	in a product, an acknowledgment in the product documentation would be
+ *	appreciated but is not required.
+ * 2. Altered source versions must be plainly marked as such, and must not be
+ *	misrepresented as being the original software.
+ * 3. This notice may not be removed or altered from any source distribution.
+ */
+/*
+ * changelog:
+ * - change in the Linux coding style
+ * - remove unnecessary comments
+ * - remove unused codes
+ */
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+#include <linux/spi/spi.h>
+
+#include <sound/hwdep.h>
+#include <sound/initval.h>
+#include <sound/jack.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include "mcdevif.h"
+#include "mcdriver.h"
+#include "ymu831.h"
+#include "ymu831_cfg.h"
+#include "ymu831_ctl.h"
+#include "ymu831_path_cfg.h"
+#include "ymu831_priv.h"
+#include "ymu831_vol.h"
+
+#define MC_ASOC_DRIVER_VERSION	"1.0.1"
+
+#define MC_ASOC_RATE		SNDRV_PCM_RATE_8000_192000
+#define MC_ASOC_FORMATS		(SNDRV_PCM_FMTBIT_S16_LE |	\
+				 SNDRV_PCM_FMTBIT_S20_3LE |	\
+				 SNDRV_PCM_FMTBIT_S24_3LE)
+
+#define get_port_id(id)		(id - 1)
+
+#define PORT_MUSIC		0
+#define PORT_EXT		1
+#define PORT_VOICE		2
+#define PORT_HIFI		3
+
+#define DIO_MUSIC		0
+#define DIO_VOICE		1
+#define LOUT1			3
+#define LOUT2			4
+#define LIN1			3
+#define LIN1_LOUT1		3
+#define LIN1_LOUT2		5
+
+#define DSP_PRM_OUTPUT		0
+#define DSP_PRM_INPUT		1
+#define DSP_PRM_VC_1MIC		2
+#define DSP_PRM_VC_2MIC		3
+#define DSP_PRM_BASE		0
+#define DSP_PRM_USER		1
+
+struct mc_asoc_info_store {
+	u32 get;
+	u32 set;
+	size_t offset;
+	u32 flags;
+};
+
+static const struct mc_asoc_info_store info_store_tbl[] = {
+	{
+	 .get = MCDRV_GET_CLOCKSW,
+	 .set = MCDRV_SET_CLOCKSW,
+	 .offset = offsetof(struct mc_asoc_data, clocksw_store),
+	 },
+	{
+	 .get = MCDRV_GET_DIGITALIO,
+	 .set = MCDRV_SET_DIGITALIO,
+	 .offset = offsetof(struct mc_asoc_data, dio_store),
+	 .flags = 0xfff,
+	 },
+	{
+	 .get = MCDRV_GET_DIGITALIO_PATH,
+	 .set = MCDRV_SET_DIGITALIO_PATH,
+	 .offset = offsetof(struct mc_asoc_data, diopath_store),
+	 .flags = 0x7ff,
+	 },
+	{
+	 .get = MCDRV_GET_PATH,
+	 .set = MCDRV_SET_PATH,
+	 .offset = offsetof(struct mc_asoc_data, path_store),
+	 },
+	{
+	 .get = MCDRV_GET_VOLUME,
+	 .set = MCDRV_SET_VOLUME,
+	 .offset = offsetof(struct mc_asoc_data, vol_store),
+	 },
+	{
+	 .get = MCDRV_GET_SWAP,
+	 .set = MCDRV_SET_SWAP,
+	 .offset = offsetof(struct mc_asoc_data, swap_store),
+	 .flags = 0x7fff},
+};
+
+struct snd_soc_codec *mc_asoc_codec;
+
+static u8 mc_asoc_ver_id = 1;
+static bool mc_asoc_suspended;
+static u8 mc_asoc_hpimpclass = 0xff;
+static u8 mc_asoc_jack_status;
+
+static struct mcdrv_vol_info mc_asoc_vol_info_mute;
+
+static u8 mc_asoc_main_mic = MAIN_MIC;
+static u8 mc_asoc_sub_mic = SUB_MIC;
+static u8 mc_asoc_hs_mic = HEADSET_MIC;
+static u8 mc_asoc_mic1_bias = MIC1_BIAS;
+static u8 mc_asoc_mic2_bias = MIC2_BIAS;
+static u8 mc_asoc_mic3_bias = MIC3_BIAS;
+static u8 mc_asoc_mic4_bias = MIC4_BIAS;
+
+static u8 mc_asoc_audio_play_port = DIO_MUSIC;
+static u8 mc_asoc_audio_cap_port = DIO_MUSIC;
+static u8 mc_asoc_voice_port = DIO_VOICE;
+static u8 mc_asoc_rate = MCDRV_FS_48000;
+
+static int set_bias_level(struct snd_soc_codec *codec,
+			  enum snd_soc_bias_level level)
+{
+	codec->dapm.bias_level = level;
+
+	return 0;
+}
+
+static int read_cache(struct snd_soc_codec *codec, unsigned int reg)
+{
+	int ret;
+	unsigned int val;
+
+	ret = snd_soc_cache_read(codec, reg, &val);
+	if (ret) {
+		dev_err(codec->dev, "Cache read to %x failed: %d\n", reg, ret);
+		return ret;
+	}
+
+	return val;
+}
+
+static int get_mic_block_on(u8 mic)
+{
+	switch (mic) {
+	case MIC_1:
+		return MCDRV_ASRC_MIC1_ON;
+	case MIC_2:
+		return MCDRV_ASRC_MIC2_ON;
+	case MIC_3:
+		return MCDRV_ASRC_MIC3_ON;
+	case MIC_4:
+		return MCDRV_ASRC_MIC4_ON;
+	default:
+		break;
+	}
+
+	return -1;
+}
+
+static int get_main_mic_block_on(void)
+{
+	return get_mic_block_on(mc_asoc_main_mic);
+}
+
+static int get_sub_mic_block_on(void)
+{
+	return get_mic_block_on(mc_asoc_sub_mic);
+}
+
+static int get_hs_mic_block_on(void)
+{
+	return get_mic_block_on(mc_asoc_hs_mic);
+}
+
+static int get_unused_mic_block_on(void)
+{
+	int ret = MCDRV_ASRC_MIC1_ON | MCDRV_ASRC_MIC2_ON |
+	    MCDRV_ASRC_MIC3_ON | MCDRV_ASRC_MIC4_ON;
+	if ((mc_asoc_main_mic == MIC_1)
+	    || (mc_asoc_sub_mic == MIC_1)
+	    || (mc_asoc_hs_mic == MIC_1))
+		ret &= ~MCDRV_ASRC_MIC1_ON;
+
+	if ((mc_asoc_main_mic == MIC_2)
+	    || (mc_asoc_sub_mic == MIC_2)
+	    || (mc_asoc_hs_mic == MIC_2))
+		ret &= ~MCDRV_ASRC_MIC2_ON;
+
+	if ((mc_asoc_main_mic == MIC_3)
+	    || (mc_asoc_sub_mic == MIC_3)
+	    || (mc_asoc_hs_mic == MIC_3))
+		ret &= ~MCDRV_ASRC_MIC3_ON;
+
+	if ((mc_asoc_main_mic == MIC_4)
+	    || (mc_asoc_sub_mic == MIC_4)
+	    || (mc_asoc_hs_mic == MIC_4))
+		ret &= ~MCDRV_ASRC_MIC4_ON;
+
+	return ret;
+}
+
+static int get_incall_mic(struct snd_soc_codec *codec, int output_path)
+{
+	switch (output_path) {
+	case MC_ASOC_OUTPUT_PATH_SP:
+		return read_cache(codec, MC_ASOC_INCALL_MIC_SP);
+	case MC_ASOC_OUTPUT_PATH_RC:
+	case MC_ASOC_OUTPUT_PATH_SP_RC:
+	case MC_ASOC_OUTPUT_PATH_LO1_RC:
+	case MC_ASOC_OUTPUT_PATH_LO2_RC:
+		return read_cache(codec, MC_ASOC_INCALL_MIC_RC);
+	case MC_ASOC_OUTPUT_PATH_HP:
+	case MC_ASOC_OUTPUT_PATH_SP_HP:
+	case MC_ASOC_OUTPUT_PATH_LO1_HP:
+	case MC_ASOC_OUTPUT_PATH_LO2_HP:
+		return read_cache(codec, MC_ASOC_INCALL_MIC_HP);
+	case MC_ASOC_OUTPUT_PATH_LO1:
+	case MC_ASOC_OUTPUT_PATH_SP_LO1:
+	case MC_ASOC_OUTPUT_PATH_LO2_LO1:
+		return read_cache(codec, MC_ASOC_INCALL_MIC_LO1);
+	case MC_ASOC_OUTPUT_PATH_LO2:
+	case MC_ASOC_OUTPUT_PATH_SP_LO2:
+	case MC_ASOC_OUTPUT_PATH_LO1_LO2:
+		return read_cache(codec, MC_ASOC_INCALL_MIC_LO2);
+	case MC_ASOC_OUTPUT_PATH_HS:
+	case MC_ASOC_OUTPUT_PATH_BT:
+	case MC_ASOC_OUTPUT_PATH_SP_BT:
+	case MC_ASOC_OUTPUT_PATH_LO1_BT:
+	case MC_ASOC_OUTPUT_PATH_LO2_BT:
+		return MC_ASOC_INCALL_MIC_MAINMIC;
+	default:
+		break;
+	}
+
+	return -EIO;
+}
+
+struct mixer_path_ctl_info {
+	int audio_mode_play;
+	int audio_mode_cap;
+	int output_path;
+	int input_path;
+	int incall_mic;
+	int mainmic_play;
+	int submic_play;
+	int msmic_play;
+	int hsmic_play;
+	int btmic_play;
+	int lin1_play;
+	int dtmf_control;
+	int dtmf_output;
+};
+
+static int get_mixer_path_ctl_info(struct snd_soc_codec *codec,
+				   struct mixer_path_ctl_info *info)
+{
+	info->audio_mode_play = read_cache(codec, MC_ASOC_AUDIO_MODE_PLAY);
+	if (info->audio_mode_play < 0)
+		return -EIO;
+
+	info->audio_mode_cap = read_cache(codec, MC_ASOC_AUDIO_MODE_CAP);
+	if (info->audio_mode_cap < 0)
+		return -EIO;
+
+	info->output_path = read_cache(codec, MC_ASOC_OUTPUT_PATH);
+	if (info->output_path < 0)
+		return -EIO;
+
+	info->input_path = read_cache(codec, MC_ASOC_INPUT_PATH);
+	if (info->input_path < 0)
+		return -EIO;
+
+	info->incall_mic = get_incall_mic(codec, info->output_path);
+	if (info->incall_mic < 0)
+		return -EIO;
+
+	info->dtmf_control = read_cache(codec, MC_ASOC_DTMF_CONTROL);
+	if (info->dtmf_control < 0)
+		return -EIO;
+
+	info->dtmf_output = read_cache(codec, MC_ASOC_DTMF_OUTPUT);
+	if (info->dtmf_output < 0)
+		return -EIO;
+
+	info->mainmic_play = read_cache(codec, MC_ASOC_MAINMIC_PLAYBACK_PATH);
+	if (info->mainmic_play < 0)
+		return -EIO;
+
+	info->submic_play = read_cache(codec, MC_ASOC_SUBMIC_PLAYBACK_PATH);
+	if (info->submic_play < 0)
+		return -EIO;
+
+	info->msmic_play = read_cache(codec, MC_ASOC_2MIC_PLAYBACK_PATH);
+	if (info->msmic_play < 0)
+		return -EIO;
+
+	info->hsmic_play = read_cache(codec, MC_ASOC_HSMIC_PLAYBACK_PATH);
+	if (info->hsmic_play < 0)
+		return -EIO;
+
+	info->btmic_play = read_cache(codec, MC_ASOC_BTMIC_PLAYBACK_PATH);
+	if (info->btmic_play < 0)
+		return -EIO;
+
+	info->lin1_play = read_cache(codec, MC_ASOC_LIN1_PLAYBACK_PATH);
+	if (info->lin1_play < 0)
+		return -EIO;
+
+	return 0;
+}
+
+static int get_path_preset_idx(struct mixer_path_ctl_info *info)
+{
+	if (info->audio_mode_play == MC_ASOC_AUDIO_MODE_INCOMM
+	    && info->audio_mode_cap == MC_ASOC_AUDIO_MODE_INCOMM) {
+		switch (info->output_path) {
+		case MC_ASOC_OUTPUT_PATH_BT:
+			return 25;
+		case MC_ASOC_OUTPUT_PATH_SP_BT:
+		case MC_ASOC_OUTPUT_PATH_LO1_BT:
+		case MC_ASOC_OUTPUT_PATH_LO2_BT:
+			return 26;
+		default:
+			return 24;
+		}
+	}
+
+	if (info->audio_mode_play == MC_ASOC_AUDIO_MODE_INCOMM2
+	    && info->audio_mode_cap == MC_ASOC_AUDIO_MODE_INCOMM) {
+		if (info->output_path == MC_ASOC_OUTPUT_PATH_BT)
+			return 63;
+		else if (info->output_path == MC_ASOC_OUTPUT_PATH_SP_BT
+			 || info->output_path == MC_ASOC_OUTPUT_PATH_LO1_BT
+			 || info->output_path == MC_ASOC_OUTPUT_PATH_LO2_BT)
+			return 64;
+		else
+			return 62;
+	}
+
+	if (info->audio_mode_play == MC_ASOC_AUDIO_MODE_INCALL) {
+		if (info->audio_mode_cap == MC_ASOC_AUDIO_MODE_INCALL) {
+			switch (info->output_path) {
+			case MC_ASOC_OUTPUT_PATH_BT:
+				return 13;
+			case MC_ASOC_OUTPUT_PATH_SP_BT:
+			case MC_ASOC_OUTPUT_PATH_LO1_BT:
+			case MC_ASOC_OUTPUT_PATH_LO2_BT:
+				return 14;
+			default:
+				return 12;
+			}
+		}
+
+		if (info->audio_mode_cap == MC_ASOC_AUDIO_MODE_AUDIO_INCALL) {
+			switch (info->output_path) {
+			case MC_ASOC_OUTPUT_PATH_BT:
+				return 19;
+			case MC_ASOC_OUTPUT_PATH_SP_BT:
+			case MC_ASOC_OUTPUT_PATH_LO1_BT:
+			case MC_ASOC_OUTPUT_PATH_LO2_BT:
+				return 20;
+			default:
+				return 18;
+			}
+		}
+	}
+
+	if (info->audio_mode_play == MC_ASOC_AUDIO_MODE_INCALL2) {
+		if (info->audio_mode_cap == MC_ASOC_AUDIO_MODE_INCALL) {
+			switch (info->output_path) {
+			case MC_ASOC_OUTPUT_PATH_BT:
+				return 51;
+			case MC_ASOC_OUTPUT_PATH_SP_BT:
+			case MC_ASOC_OUTPUT_PATH_LO1_BT:
+			case MC_ASOC_OUTPUT_PATH_LO2_BT:
+				return 52;
+			default:
+				return 50;
+			}
+		}
+
+		if (info->audio_mode_cap == MC_ASOC_AUDIO_MODE_AUDIO_INCALL) {
+			switch (info->output_path) {
+			case MC_ASOC_OUTPUT_PATH_BT:
+				return 57;
+			case MC_ASOC_OUTPUT_PATH_SP_BT:
+			case MC_ASOC_OUTPUT_PATH_LO1_BT:
+			case MC_ASOC_OUTPUT_PATH_LO2_BT:
+				return 58;
+			default:
+				return 56;
+			}
+		}
+	}
+
+	if (info->audio_mode_play == MC_ASOC_AUDIO_MODE_AUDIO_INCALL) {
+		if (info->audio_mode_cap == MC_ASOC_AUDIO_MODE_INCALL) {
+			switch (info->output_path) {
+			case MC_ASOC_OUTPUT_PATH_BT:
+				return 16;
+			case MC_ASOC_OUTPUT_PATH_SP_BT:
+			case MC_ASOC_OUTPUT_PATH_LO1_BT:
+			case MC_ASOC_OUTPUT_PATH_LO2_BT:
+				return 17;
+			default:
+				return 15;
+			}
+		}
+
+		if (info->audio_mode_cap == MC_ASOC_AUDIO_MODE_AUDIO_INCALL) {
+			switch (info->output_path) {
+			case MC_ASOC_OUTPUT_PATH_BT:
+				return 22;
+			case MC_ASOC_OUTPUT_PATH_SP_BT:
+			case MC_ASOC_OUTPUT_PATH_LO1_BT:
+			case MC_ASOC_OUTPUT_PATH_LO2_BT:
+				return 23;
+			default:
+				return 21;
+			}
+		}
+	}
+
+	if (info->audio_mode_play == MC_ASOC_AUDIO_MODE_AUDIO_INCALL2) {
+		if (info->audio_mode_cap == MC_ASOC_AUDIO_MODE_INCALL) {
+			switch (info->output_path) {
+			case MC_ASOC_OUTPUT_PATH_BT:
+				return 54;
+			case MC_ASOC_OUTPUT_PATH_SP_BT:
+			case MC_ASOC_OUTPUT_PATH_LO1_BT:
+			case MC_ASOC_OUTPUT_PATH_LO2_BT:
+				return 55;
+			default:
+				return 53;
+			}
+		}
+
+		if (info->audio_mode_cap == MC_ASOC_AUDIO_MODE_AUDIO_INCALL) {
+			switch (info->output_path) {
+			case MC_ASOC_OUTPUT_PATH_BT:
+				return 60;
+			case MC_ASOC_OUTPUT_PATH_SP_BT:
+			case MC_ASOC_OUTPUT_PATH_LO1_BT:
+			case MC_ASOC_OUTPUT_PATH_LO2_BT:
+				return 61;
+			default:
+				return 59;
+			}
+		}
+	}
+
+	if ((info->audio_mode_play == MC_ASOC_AUDIO_MODE_AUDIO &&
+	     (info->audio_mode_cap == MC_ASOC_AUDIO_MODE_OFF ||
+	      info->audio_mode_cap == MC_ASOC_AUDIO_MODE_INCALL ||
+	      info->audio_mode_cap == MC_ASOC_AUDIO_MODE_INCOMM))
+	    || (info->audio_mode_play == MC_ASOC_AUDIO_MODE_AUDIO_INCALL &&
+		(info->audio_mode_cap == MC_ASOC_AUDIO_MODE_OFF ||
+		 info->audio_mode_cap == MC_ASOC_AUDIO_MODE_INCOMM))
+	    || (info->audio_mode_play == MC_ASOC_AUDIO_MODE_AUDIO_INCALL2 &&
+		(info->audio_mode_cap == MC_ASOC_AUDIO_MODE_OFF ||
+		 info->audio_mode_cap == MC_ASOC_AUDIO_MODE_INCOMM))) {
+		switch (info->output_path) {
+		case MC_ASOC_OUTPUT_PATH_BT:
+			if (mc_asoc_rate == MCDRV_FS_96000
+			    || mc_asoc_rate == MCDRV_FS_192000)
+				return -1;
+			return 2;
+		case MC_ASOC_OUTPUT_PATH_SP_BT:
+		case MC_ASOC_OUTPUT_PATH_LO1_BT:
+		case MC_ASOC_OUTPUT_PATH_LO2_BT:
+			if (mc_asoc_rate == MCDRV_FS_96000
+			    || mc_asoc_rate == MCDRV_FS_192000)
+				return -1;
+			return 3;
+		default:
+			if (mc_asoc_rate == MCDRV_FS_96000
+			    || mc_asoc_rate == MCDRV_FS_192000)
+				return 27;
+			return 1;
+		}
+	}
+
+	if ((info->audio_mode_play == MC_ASOC_AUDIO_MODE_OFF &&
+	     (info->audio_mode_cap == MC_ASOC_AUDIO_MODE_AUDIO ||
+	      info->audio_mode_cap == MC_ASOC_AUDIO_MODE_AUDIO_INCALL))
+	    || (info->audio_mode_play == MC_ASOC_AUDIO_MODE_INCALL &&
+		info->audio_mode_cap == MC_ASOC_AUDIO_MODE_AUDIO)
+	    || (info->audio_mode_play == MC_ASOC_AUDIO_MODE_INCALL2 &&
+		info->audio_mode_cap == MC_ASOC_AUDIO_MODE_AUDIO)
+	    || (info->audio_mode_play == MC_ASOC_AUDIO_MODE_INCOMM &&
+		(info->audio_mode_cap == MC_ASOC_AUDIO_MODE_AUDIO ||
+		 info->audio_mode_cap == MC_ASOC_AUDIO_MODE_AUDIO_INCALL))
+	    || (info->audio_mode_play == MC_ASOC_AUDIO_MODE_INCOMM2 &&
+		(info->audio_mode_cap == MC_ASOC_AUDIO_MODE_AUDIO ||
+		 info->audio_mode_cap == MC_ASOC_AUDIO_MODE_AUDIO_INCALL))) {
+		switch (info->input_path) {
+		case MC_ASOC_INPUT_PATH_BT:
+			if (mc_asoc_rate == MCDRV_FS_96000
+			    || mc_asoc_rate == MCDRV_FS_192000)
+				return -1;
+			return 5;
+		case MC_ASOC_INPUT_PATH_VOICECALL:
+		case MC_ASOC_INPUT_PATH_VOICEUPLINK:
+		case MC_ASOC_INPUT_PATH_VOICEDOWNLINK:
+			if ((mc_asoc_rate == MCDRV_FS_96000)
+			    || (mc_asoc_rate == MCDRV_FS_192000))
+				return 28;
+			return 4;
+		default:
+			if (mc_asoc_rate == MCDRV_FS_96000
+			    || mc_asoc_rate == MCDRV_FS_192000)
+				return 28;
+			return 4;
+		}
+	}
+
+	if ((info->audio_mode_play == MC_ASOC_AUDIO_MODE_AUDIO &&
+	     (info->audio_mode_cap == MC_ASOC_AUDIO_MODE_AUDIO ||
+	      info->audio_mode_cap == MC_ASOC_AUDIO_MODE_AUDIO_INCALL))
+	    || (info->audio_mode_play == MC_ASOC_AUDIO_MODE_AUDIO_INCALL &&
+		info->audio_mode_cap == MC_ASOC_AUDIO_MODE_AUDIO)
+	    || (info->audio_mode_play == MC_ASOC_AUDIO_MODE_AUDIO_INCALL2 &&
+		info->audio_mode_cap == MC_ASOC_AUDIO_MODE_AUDIO)) {
+		switch (info->input_path) {
+		case MC_ASOC_INPUT_PATH_VOICECALL:
+		case MC_ASOC_INPUT_PATH_VOICEUPLINK:
+		case MC_ASOC_INPUT_PATH_VOICEDOWNLINK:
+			switch (info->output_path) {
+			case MC_ASOC_OUTPUT_PATH_BT:
+				if (mc_asoc_rate == MCDRV_FS_96000
+				    || mc_asoc_rate == MCDRV_FS_192000)
+					return -1;
+				return 8;
+			case MC_ASOC_OUTPUT_PATH_SP_BT:
+			case MC_ASOC_OUTPUT_PATH_LO1_BT:
+			case MC_ASOC_OUTPUT_PATH_LO2_BT:
+				if (mc_asoc_rate == MCDRV_FS_96000
+				    || mc_asoc_rate == MCDRV_FS_192000)
+					return -1;
+				return 10;
+			default:
+				if (mc_asoc_rate == MCDRV_FS_96000
+				    || mc_asoc_rate == MCDRV_FS_192000)
+					return 29;
+				return 6;
+			}
+		default:
+			switch (info->output_path) {
+			case MC_ASOC_OUTPUT_PATH_BT:
+				if (mc_asoc_rate == MCDRV_FS_96000
+				    || mc_asoc_rate == MCDRV_FS_192000)
+					return -1;
+				if (info->input_path == MC_ASOC_INPUT_PATH_BT)
+					return 9;
+				return 8;
+			case MC_ASOC_OUTPUT_PATH_SP_BT:
+			case MC_ASOC_OUTPUT_PATH_LO1_BT:
+			case MC_ASOC_OUTPUT_PATH_LO2_BT:
+				if (mc_asoc_rate == MCDRV_FS_96000
+				    || mc_asoc_rate == MCDRV_FS_192000)
+					return -1;
+				if (info->input_path == MC_ASOC_INPUT_PATH_BT)
+					return 11;
+				return 10;
+			default:
+				if (info->input_path == MC_ASOC_INPUT_PATH_BT) {
+					if (mc_asoc_rate == MCDRV_FS_96000
+					    || mc_asoc_rate == MCDRV_FS_192000)
+						return -1;
+					return 7;
+				}
+
+				if (mc_asoc_rate == MCDRV_FS_96000
+				    || mc_asoc_rate == MCDRV_FS_192000)
+					return 29;
+				return 6;
+			}
+		}
+	}
+
+	if ((info->audio_mode_play == MC_ASOC_AUDIO_MODE_OFF ||
+	     info->audio_mode_play == MC_ASOC_AUDIO_MODE_INCALL ||
+	     info->audio_mode_play == MC_ASOC_AUDIO_MODE_INCALL2 ||
+	     info->audio_mode_play == MC_ASOC_AUDIO_MODE_INCOMM ||
+	     info->audio_mode_play == MC_ASOC_AUDIO_MODE_INCOMM2)
+	    && info->audio_mode_cap == MC_ASOC_AUDIO_MODE_AUDIOEX) {
+		switch (info->input_path) {
+		case MC_ASOC_INPUT_PATH_VOICECALL:
+		case MC_ASOC_INPUT_PATH_VOICEUPLINK:
+		case MC_ASOC_INPUT_PATH_VOICEDOWNLINK:
+			return 30;
+		default:
+			if (info->input_path == MC_ASOC_INPUT_PATH_BT)
+				return 31;
+			return 30;
+		}
+	}
+
+	if ((info->audio_mode_play == MC_ASOC_AUDIO_MODE_AUDIO ||
+	     info->audio_mode_play == MC_ASOC_AUDIO_MODE_AUDIO_INCALL ||
+	     info->audio_mode_play == MC_ASOC_AUDIO_MODE_AUDIO_INCALL2)
+	    && info->audio_mode_cap == MC_ASOC_AUDIO_MODE_AUDIOEX) {
+		switch (info->input_path) {
+		case MC_ASOC_INPUT_PATH_VOICECALL:
+		case MC_ASOC_INPUT_PATH_VOICEUPLINK:
+		case MC_ASOC_INPUT_PATH_VOICEDOWNLINK:
+			switch (info->output_path) {
+			case MC_ASOC_OUTPUT_PATH_BT:
+				return 34;
+			case MC_ASOC_OUTPUT_PATH_SP_BT:
+			case MC_ASOC_OUTPUT_PATH_LO1_BT:
+			case MC_ASOC_OUTPUT_PATH_LO2_BT:
+				return 36;
+			default:
+				return 32;
+			}
+		default:
+			switch (info->output_path) {
+			case MC_ASOC_OUTPUT_PATH_BT:
+				if (info->input_path == MC_ASOC_INPUT_PATH_BT)
+					return 35;
+				return 34;
+			case MC_ASOC_OUTPUT_PATH_SP_BT:
+			case MC_ASOC_OUTPUT_PATH_LO1_BT:
+			case MC_ASOC_OUTPUT_PATH_LO2_BT:
+				if (info->input_path == MC_ASOC_INPUT_PATH_BT)
+					return 37;
+				return 36;
+			default:
+				if (info->input_path == MC_ASOC_INPUT_PATH_BT)
+					return 33;
+				return 32;
+			}
+		}
+	}
+
+	if ((info->audio_mode_play == MC_ASOC_AUDIO_MODE_OFF ||
+	     info->audio_mode_play == MC_ASOC_AUDIO_MODE_INCALL ||
+	     info->audio_mode_play == MC_ASOC_AUDIO_MODE_INCOMM)
+	    && info->audio_mode_cap == MC_ASOC_AUDIO_MODE_AUDIOVR) {
+		switch (info->input_path) {
+		case MC_ASOC_INPUT_PATH_VOICECALL:
+		case MC_ASOC_INPUT_PATH_VOICEUPLINK:
+		case MC_ASOC_INPUT_PATH_VOICEDOWNLINK:
+			return 38;
+		default:
+			if (info->input_path == MC_ASOC_INPUT_PATH_BT)
+				return 39;
+			return 38;
+		}
+	}
+
+	if ((info->audio_mode_play == MC_ASOC_AUDIO_MODE_AUDIO ||
+	     info->audio_mode_play == MC_ASOC_AUDIO_MODE_AUDIO_INCALL)
+	    && info->audio_mode_cap == MC_ASOC_AUDIO_MODE_AUDIOVR) {
+		switch (info->output_path) {
+		case MC_ASOC_OUTPUT_PATH_BT:
+			if (info->input_path == MC_ASOC_INPUT_PATH_BT)
+				return 43;
+			return 42;
+		case MC_ASOC_OUTPUT_PATH_SP_BT:
+		case MC_ASOC_OUTPUT_PATH_LO1_BT:
+		case MC_ASOC_OUTPUT_PATH_LO2_BT:
+			if (info->input_path == MC_ASOC_INPUT_PATH_BT)
+				return 45;
+			return 44;
+		default:
+			if (info->input_path == MC_ASOC_INPUT_PATH_BT)
+				return 41;
+			return 40;
+		}
+	}
+
+	if (info->audio_mode_play == MC_ASOC_AUDIO_MODE_KARAOKE) {
+		if (info->audio_mode_cap == MC_ASOC_AUDIO_MODE_OFF) {
+			if (info->input_path == MC_ASOC_INPUT_PATH_BT)
+				return 47;
+			return 46;
+		} else if (info->audio_mode_cap == MC_ASOC_AUDIO_MODE_AUDIO) {
+			if (info->input_path == MC_ASOC_INPUT_PATH_BT)
+				return 49;
+			return 48;
+		}
+	}
+
+	return 0;
+}
+
+static inline int is_incall(int preset_idx)
+{
+	if ((preset_idx >= 12 && preset_idx <= 23)
+	    || (preset_idx >= 50 && preset_idx <= 61))
+		return 1;
+
+	return 0;
+}
+
+static inline int is_incommunication(int preset_idx)
+{
+	if ((preset_idx >= 24 && preset_idx <= 26)
+	    || (preset_idx >= 62 && preset_idx <= 64))
+		return 1;
+
+	return 0;
+}
+
+static void set_vol_mute_flag(size_t offset, u8 lr, u8 mute)
+{
+	s16 *vp = (void *)&mc_asoc_vol_info_mute + offset;
+
+	if (offset == (size_t) -1)
+		return;
+
+	if (mute == 1)
+		*(vp + lr) = 0xa000;
+	else
+		*(vp + lr) = 0;
+}
+
+static u8 get_vol_mute_flag(size_t offset, u8 lr)
+{
+	s16 *vp;
+
+	if (offset == (size_t) -1)
+		return 1;	/* mute */
+
+	vp = (void *)&mc_asoc_vol_info_mute + offset;
+
+	return (*(vp + lr) != 0);
+}
+
+static int get_master_vol(struct snd_soc_codec *codec, s16 *db, int reg, int i)
+{
+	unsigned int v;
+	int cache, sum, sw, vol;
+
+	cache = read_cache(codec, MC_ASOC_DVOL_MASTER);
+	if (cache < 0)
+		return -EIO;
+
+	v = (cache >> (i * 8)) & 0xff;
+	sw = v & 0x80;
+	vol = sw ? (v & 0x7f) : 0;
+	if (!vol)
+		*db = vreg_map[reg].volmap[0];
+	else {
+		sum = *db + vreg_map[MC_ASOC_DVOL_MASTER].volmap[vol];
+		if (sum < vreg_map[reg].volmap[0])
+			sum = vreg_map[reg].volmap[0];
+		*db = sum;
+	}
+
+	return 0;
+}
+
+static int get_voice_vol(struct snd_soc_codec *codec, s16 *db, int reg, int i)
+{
+	unsigned int v;
+	int cache, sum, sw, vol;
+
+	cache = read_cache(codec, MC_ASOC_DVOL_VOICE);
+	if (cache < 0)
+		return -EIO;
+
+	v = (cache >> (i * 8)) & 0xff;
+	sw = v & 0x80;
+	vol = sw ? (v & 0x7f) : 0;
+	if (!vol)
+		*db = vreg_map[reg].volmap[0];
+	else {
+		sum = *db + vreg_map[MC_ASOC_DVOL_VOICE].volmap[vol];
+		if (sum < vreg_map[reg].volmap[0])
+			sum = vreg_map[reg].volmap[0];
+		*db = sum;
+	}
+
+	return 0;
+}
+
+static int get_aplay_vol(struct snd_soc_codec *codec, s16 *db, int reg, int i,
+			 int aplay_reg, struct mixer_path_ctl_info *info,
+			 int preset_idx)
+{
+	unsigned int v;
+	int cache, input_path, sw, vol;
+	s16 aplay_db;
+
+	if (preset_idx >= 46 && preset_idx <= 49)
+		return 0;
+
+	if (is_incall(preset_idx) || is_incommunication(preset_idx))
+		return 0;
+
+	if (!(preset_idx < 12 || preset_idx == 28 || preset_idx > 29))
+		return 0;
+
+	cache = read_cache(codec, aplay_reg);
+	if (cache < 0)
+		return -EIO;
+
+	v = (cache >> (i * 8)) & 0xff;
+	sw = v & 0x80;
+	vol = sw ? (v & 0x7f) : 0;
+	aplay_db = vreg_map[reg].volmap[vol];
+	input_path = info->input_path;
+
+	if (reg == MC_ASOC_DVOL_ADIF1IN) {
+		if (info->lin1_play == 1) {
+			if (preset_idx < 4 || preset_idx >= 38
+			    || input_path == MC_ASOC_INPUT_PATH_BT
+			    || input_path == MC_ASOC_INPUT_PATH_LIN1) {
+				*db = aplay_db;
+				return 0;
+			}
+		}
+
+		if (info->mainmic_play == 1) {
+			if (preset_idx < 4 || preset_idx >= 38
+			    || input_path == MC_ASOC_INPUT_PATH_BT
+			    || input_path == MC_ASOC_INPUT_PATH_MAINMIC) {
+				*db = aplay_db;
+				return 0;
+			}
+		}
+
+		if (info->submic_play == 1) {
+			if (preset_idx < 4 || preset_idx >= 38
+			    || input_path == MC_ASOC_INPUT_PATH_BT
+			    || input_path == MC_ASOC_INPUT_PATH_SUBMIC) {
+				*db = aplay_db;
+				return 0;
+			}
+		}
+
+		if (info->msmic_play == 1) {
+			if (preset_idx < 4 || preset_idx >= 38
+			    || input_path == MC_ASOC_INPUT_PATH_BT
+			    || input_path == MC_ASOC_INPUT_PATH_2MIC) {
+				*db = aplay_db;
+				return 0;
+			}
+		}
+
+		if (info->hsmic_play == 1) {
+			if (preset_idx < 4 || preset_idx >= 38
+			    || input_path == MC_ASOC_INPUT_PATH_BT
+			    || input_path == MC_ASOC_INPUT_PATH_HS) {
+				*db = aplay_db;
+				return 0;
+			}
+		}
+
+		return 0;
+	}
+
+	if (reg == MC_ASOC_AVOL_LINEIN1) {
+		if (info->lin1_play == 1) {
+			if (preset_idx < 4 || preset_idx >= 38
+			    || input_path == MC_ASOC_INPUT_PATH_BT
+			    || input_path == MC_ASOC_INPUT_PATH_LIN1)
+				*db = aplay_db;
+		}
+
+		return 0;
+	}
+
+	if (reg == MC_ASOC_AVOL_MIC1) {
+		if (mc_asoc_main_mic == MIC_1) {
+			if (info->mainmic_play == 1)
+				if (preset_idx < 4 || preset_idx >= 38
+				    || input_path == MC_ASOC_INPUT_PATH_BT
+				    || input_path ==
+				    MC_ASOC_INPUT_PATH_MAINMIC) {
+					*db = aplay_db;
+					return 0;
+				}
+
+			if (info->msmic_play == 1)
+				if (preset_idx < 4 || preset_idx >= 38
+				    || input_path == MC_ASOC_INPUT_PATH_BT
+				    || input_path == MC_ASOC_INPUT_PATH_2MIC) {
+					*db = aplay_db;
+					return 0;
+				}
+		}
+
+		if (mc_asoc_sub_mic == MIC_1) {
+			if (info->submic_play == 1)
+				if (preset_idx < 4 || preset_idx >= 38
+				    || input_path == MC_ASOC_INPUT_PATH_BT
+				    || input_path ==
+				    MC_ASOC_INPUT_PATH_SUBMIC) {
+					*db = aplay_db;
+					return 0;
+				}
+
+			if (info->msmic_play == 1)
+				if (preset_idx < 4 || preset_idx >= 38
+				    || input_path == MC_ASOC_INPUT_PATH_BT
+				    || input_path == MC_ASOC_INPUT_PATH_2MIC) {
+					*db = aplay_db;
+					return 0;
+				}
+		}
+
+		if (mc_asoc_hs_mic == MIC_1 && info->hsmic_play == 1)
+			if (preset_idx < 4 || preset_idx >= 38
+			    || input_path == MC_ASOC_INPUT_PATH_BT
+			    || input_path == MC_ASOC_INPUT_PATH_HS)
+				*db = aplay_db;
+
+		return 0;
+	}
+
+	if (reg == MC_ASOC_AVOL_MIC2) {
+		if (mc_asoc_main_mic == MIC_2) {
+			if (info->mainmic_play == 1)
+				if (preset_idx < 4 || preset_idx >= 38
+				    || input_path == MC_ASOC_INPUT_PATH_BT
+				    || input_path ==
+				    MC_ASOC_INPUT_PATH_MAINMIC) {
+					*db = aplay_db;
+					return 0;
+				}
+
+			if (info->msmic_play == 1)
+				if (preset_idx < 4 || preset_idx >= 38
+				    || input_path == MC_ASOC_INPUT_PATH_BT
+				    || input_path == MC_ASOC_INPUT_PATH_2MIC) {
+					*db = aplay_db;
+					return 0;
+				}
+		}
+
+		if (mc_asoc_sub_mic == MIC_2) {
+			if (info->submic_play == 1)
+				if (preset_idx < 4 || preset_idx >= 38
+				    || input_path == MC_ASOC_INPUT_PATH_BT
+				    || input_path ==
+				    MC_ASOC_INPUT_PATH_SUBMIC) {
+					*db = aplay_db;
+					return 0;
+				}
+
+			if (info->msmic_play == 1)
+				if (preset_idx < 4 || preset_idx >= 38
+				    || input_path == MC_ASOC_INPUT_PATH_BT
+				    || input_path == MC_ASOC_INPUT_PATH_2MIC) {
+					*db = aplay_db;
+					return 0;
+				}
+		}
+
+		if (mc_asoc_hs_mic == MIC_2 && info->hsmic_play == 1)
+			if (preset_idx < 4 || preset_idx >= 38
+			    || input_path == MC_ASOC_INPUT_PATH_BT
+			    || input_path == MC_ASOC_INPUT_PATH_HS)
+				*db = aplay_db;
+
+		return 0;
+	}
+
+	if (reg == MC_ASOC_AVOL_MIC3) {
+		if (mc_asoc_main_mic == MIC_3) {
+			if (info->mainmic_play == 1)
+				if (preset_idx < 4 || preset_idx >= 38
+				    || input_path == MC_ASOC_INPUT_PATH_BT
+				    || input_path ==
+				    MC_ASOC_INPUT_PATH_MAINMIC) {
+					*db = aplay_db;
+					return 0;
+				}
+
+			if (info->msmic_play == 1)
+				if (preset_idx < 4 || preset_idx >= 38
+				    || input_path == MC_ASOC_INPUT_PATH_BT
+				    || input_path == MC_ASOC_INPUT_PATH_2MIC) {
+					*db = aplay_db;
+					return 0;
+				}
+		}
+
+		if (mc_asoc_sub_mic == MIC_3) {
+			if (info->submic_play == 1)
+				if (preset_idx < 4 || preset_idx >= 38
+				    || input_path == MC_ASOC_INPUT_PATH_BT
+				    || input_path ==
+				    MC_ASOC_INPUT_PATH_SUBMIC) {
+					*db = aplay_db;
+					return 0;
+				}
+
+			if (info->msmic_play == 1)
+				if (preset_idx < 4 || preset_idx >= 38
+				    || input_path == MC_ASOC_INPUT_PATH_BT
+				    || input_path == MC_ASOC_INPUT_PATH_2MIC) {
+					*db = aplay_db;
+					return 0;
+				}
+		}
+
+		if (mc_asoc_hs_mic == MIC_3 && info->hsmic_play == 1)
+			if (preset_idx < 4 || preset_idx >= 38
+			    || input_path == MC_ASOC_INPUT_PATH_BT
+			    || input_path == MC_ASOC_INPUT_PATH_HS)
+				*db = aplay_db;
+
+		return 0;
+	}
+
+	if (reg == MC_ASOC_AVOL_MIC4) {
+		if (mc_asoc_main_mic == MIC_4) {
+			if (info->mainmic_play == 1)
+				if (preset_idx < 4 || preset_idx >= 38
+				    || input_path == MC_ASOC_INPUT_PATH_BT
+				    || input_path ==
+				    MC_ASOC_INPUT_PATH_MAINMIC) {
+					*db = aplay_db;
+					return 0;
+				}
+
+			if (info->msmic_play == 1)
+				if (preset_idx < 4 || preset_idx >= 38
+				    || input_path == MC_ASOC_INPUT_PATH_BT
+				    || input_path == MC_ASOC_INPUT_PATH_2MIC) {
+					*db = aplay_db;
+					return 0;
+				}
+		}
+
+		if (mc_asoc_sub_mic == MIC_4) {
+			if (info->submic_play == 1)
+				if (preset_idx < 4 || preset_idx >= 38
+				    || input_path == MC_ASOC_INPUT_PATH_BT
+				    || input_path ==
+				    MC_ASOC_INPUT_PATH_SUBMIC) {
+					*db = aplay_db;
+					return 0;
+				}
+
+			if (info->msmic_play == 1)
+				if (preset_idx < 4 || preset_idx >= 38
+				    || input_path == MC_ASOC_INPUT_PATH_BT
+				    || input_path == MC_ASOC_INPUT_PATH_2MIC) {
+					*db = aplay_db;
+					return 0;
+				}
+		}
+
+		if (mc_asoc_hs_mic == MIC_4 && info->hsmic_play == 1)
+			if (preset_idx < 4 || preset_idx >= 38
+			    || input_path == MC_ASOC_INPUT_PATH_BT
+			    || input_path == MC_ASOC_INPUT_PATH_HS)
+				*db = aplay_db;
+	}
+
+	return 0;
+}
+
+static int set_vol_info(struct snd_soc_codec *codec,
+			struct mcdrv_vol_info *vol_info, int reg,
+			struct mixer_path_ctl_info *mixer_info, int preset_idx)
+{
+	s16 *vp;
+	int i, cache;
+
+	if (!codec)
+		return -EIO;
+
+	if (reg >= MC_ASOC_AVOL_SP_GAIN)
+		return -EIO;
+
+	if (vreg_map[reg].offset != (size_t) -1) {
+		vp = (void *)vol_info + vreg_map[reg].offset;
+		cache = read_cache(codec, reg);
+		if (cache < 0)
+			return -EIO;
+
+		for (i = 0; i < vreg_map[reg].channels; i++, vp++) {
+			unsigned int v;
+			int sw, vol, size;
+			bool sw_overwrite;
+			s16 db, db_max, map;
+
+			v = (cache >> (i * 8)) & 0xff;
+			sw = v & 0x80;
+			sw_overwrite = false;
+
+			if (is_incall(preset_idx)) {
+				switch (reg) {
+				case MC_ASOC_DVOL_VOICEOUT:
+					if (mc_asoc_voice_port == DIO_VOICE
+					    && sw)
+						sw_overwrite = true;
+					break;
+				case MC_ASOC_DVOL_DAC0OUT:
+					if (mc_asoc_voice_port == LIN1_LOUT1
+					    && sw)
+						sw_overwrite = true;
+					break;
+				case MC_ASOC_DVOL_DAC1OUT:
+					if (mc_asoc_voice_port == LIN1_LOUT2
+					    && sw)
+						sw_overwrite = true;
+					break;
+				default:
+					break;
+				}
+			} else if (is_incommunication(preset_idx)) {
+				if (reg == MC_ASOC_DVOL_VOICEOUT) {
+					if (mc_asoc_voice_port == DIO_VOICE
+					    && sw)
+						sw_overwrite = true;
+				}
+			}
+
+			if (sw_overwrite)
+				sw = read_cache(codec, MC_ASOC_VOICE_RECORDING);
+
+			vol = sw ? (v & 0x7f) : 0;
+
+			if (get_vol_mute_flag(vreg_map[reg].offset, i))
+				db = vreg_map[reg].volmap[0];
+			else
+				db = vreg_map[reg].volmap[vol];
+
+			if (reg == MC_ASOC_DVOL_MUSICIN) {
+				if (mc_asoc_audio_play_port != DIO_MUSIC
+				    || !vol)
+					db = vreg_map[reg].volmap[0];
+				else if (get_master_vol(codec, &db, reg, i))
+					return -EIO;
+			} else if (reg == MC_ASOC_DVOL_VOICEIN) {
+				if (is_incall(preset_idx))
+					db = vreg_map[reg].volmap[vol];
+				else if (mc_asoc_voice_port == LIN1_LOUT1
+					 || mc_asoc_voice_port == LIN1_LOUT2
+					 || !vol)
+					db = vreg_map[reg].volmap[0];
+				else if (get_voice_vol(codec, &db, reg, i))
+					return -EIO;
+			} else if (reg == MC_ASOC_DVOL_ADIF1IN) {
+				if (get_aplay_vol(codec, &db, reg, i,
+						  MC_ASOC_DVOL_APLAY_D,
+						  mixer_info, preset_idx))
+					return -EIO;
+				if (mc_asoc_audio_play_port == LIN1)
+					if (get_master_vol(codec, &db, reg, i))
+						return -EIO;
+			} else if (reg == MC_ASOC_AVOL_LINEIN1) {
+				if (is_incall(preset_idx)) {
+					if ((mc_asoc_voice_port == LIN1_LOUT1 ||
+					     mc_asoc_voice_port == LIN1_LOUT2)
+					    && get_voice_vol(codec, &db, reg,
+							     i))
+						return -EIO;
+				} else {
+					if (get_aplay_vol(codec, &db, reg, i,
+							  MC_ASOC_DVOL_APLAY_A,
+							  mixer_info,
+							  preset_idx))
+						return -EIO;
+				}
+			} else if ((reg == MC_ASOC_AVOL_MIC1 ||
+				    reg == MC_ASOC_AVOL_MIC2 ||
+				    reg == MC_ASOC_AVOL_MIC3 ||
+				    reg == MC_ASOC_AVOL_MIC4)
+				   && get_aplay_vol(codec, &db, reg, i,
+						    MC_ASOC_DVOL_APLAY_A,
+						    mixer_info, preset_idx)) {
+				return -EIO;
+			} else if (reg == MC_ASOC_AVOL_HP
+				   && (mc_asoc_hpimpclass != (u8) -1 &&
+				       db > vreg_map[reg].volmap[0])) {
+				size = ARRAY_SIZE(volmap_hp) - 1;
+				db_max = vreg_map[MC_ASOC_AVOL_HP].volmap[size];
+				db += hp_vol_imp_table[mc_asoc_hpimpclass] << 8;
+				map = vreg_map[MC_ASOC_AVOL_HP].volmap[0];
+				if (db < map)
+					db = map;
+				else if (db > db_max)
+					db = db_max;
+			} else if (reg == MC_ASOC_DVOL_DAC0OUT
+				   && (mc_asoc_hpimpclass != (u8) -1 &&
+				       db > vreg_map[reg].volmap[0])) {
+				size = ARRAY_SIZE(volmap_digital) - 1;
+				db_max = volmap_digital[size];
+				db +=
+				    dac0_vol_imp_table[mc_asoc_hpimpclass] << 8;
+				map = volmap_digital[0];
+				if (db < map)
+					db = map;
+				else if (db > db_max)
+					db = db_max;
+			}
+
+			*vp = db | MCDRV_VOL_UPDATE;
+		}
+	}
+
+	return 0;
+}
+
+static int set_volume(struct snd_soc_codec *codec,
+		      struct mixer_path_ctl_info *mixer, int preset_idx)
+{
+	struct mcdrv_vol_info vol_info;
+	int err, reg;
+
+	if (!codec)
+		return -EIO;
+
+	memset(&vol_info, 0, sizeof(struct mcdrv_vol_info));
+
+	for (reg = MC_ASOC_DVOL_MUSICIN; reg < MC_ASOC_AVOL_SP_GAIN; reg++) {
+		err = set_vol_info(codec, &vol_info, reg, mixer, preset_idx);
+		if (err < 0)
+			return err;
+	}
+
+	err = mc_control(MCDRV_SET_VOLUME, (unsigned long)&vol_info, 0);
+	if (err < 0) {
+		dev_err(codec->dev, "Error in MCDRV_SET_VOLUME: %d\n", err);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static inline void mask_source(u32 *src, int size)
+{
+	int i;
+
+	for (i = 0; i < size; i++)
+		src[i] = 0x002aaaaa;
+}
+
+static void mask_analog_out_source(struct mcdrv_path_info *path,
+				   struct mixer_path_ctl_info *mixer,
+				   int preset_idx)
+{
+	int output_path;
+
+	output_path = mixer->output_path;
+
+	if (output_path != MC_ASOC_OUTPUT_PATH_SP
+	    && output_path != MC_ASOC_OUTPUT_PATH_SP_RC
+	    && output_path != MC_ASOC_OUTPUT_PATH_SP_HP
+	    && output_path != MC_ASOC_OUTPUT_PATH_SP_LO1
+	    && output_path != MC_ASOC_OUTPUT_PATH_SP_LO2
+	    && output_path != MC_ASOC_OUTPUT_PATH_SP_BT)
+		mask_source(path->sp, SP_PATH_CHANNELS);
+
+	if (output_path != MC_ASOC_OUTPUT_PATH_RC
+	    && output_path != MC_ASOC_OUTPUT_PATH_SP_RC
+	    && output_path != MC_ASOC_OUTPUT_PATH_LO1_RC
+	    && output_path != MC_ASOC_OUTPUT_PATH_LO2_RC)
+		mask_source(path->rc, RC_PATH_CHANNELS);
+
+	if (output_path != MC_ASOC_OUTPUT_PATH_HP
+	    && output_path != MC_ASOC_OUTPUT_PATH_HS
+	    && output_path != MC_ASOC_OUTPUT_PATH_SP_HP
+	    && output_path != MC_ASOC_OUTPUT_PATH_LO1_HP
+	    && output_path != MC_ASOC_OUTPUT_PATH_LO2_HP)
+		mask_source(path->hp, HP_PATH_CHANNELS);
+
+	if (output_path != MC_ASOC_OUTPUT_PATH_LO1
+	    && output_path != MC_ASOC_OUTPUT_PATH_SP_LO1
+	    && output_path != MC_ASOC_OUTPUT_PATH_LO1_RC
+	    && output_path != MC_ASOC_OUTPUT_PATH_LO1_HP
+	    && output_path != MC_ASOC_OUTPUT_PATH_LO1_BT
+	    && output_path != MC_ASOC_OUTPUT_PATH_LO1_LO2
+	    && output_path != MC_ASOC_OUTPUT_PATH_LO2_LO1) {
+		if (preset_idx < 12) {
+			if (mc_asoc_audio_cap_port == LOUT1) {
+				if (preset_idx <= 3 || preset_idx == 6
+				    || preset_idx == 7)
+					mask_source(path->lout1,
+						    LOUT1_PATH_CHANNELS);
+			} else
+				mask_source(path->lout1, LOUT1_PATH_CHANNELS);
+		} else if (is_incall(preset_idx)) {
+			/* incall */
+			if (mc_asoc_voice_port == LIN1_LOUT1) {
+				/* nothing to do */
+			} else if (mc_asoc_audio_cap_port == LOUT1) {
+				if (preset_idx != 18 && preset_idx != 21
+				    && preset_idx != 56 && preset_idx != 59)
+					mask_source(path->lout1,
+						    LOUT1_PATH_CHANNELS);
+			} else
+				mask_source(path->lout1, LOUT1_PATH_CHANNELS);
+		} else if (preset_idx == 24 || preset_idx >= 26)
+			mask_source(path->lout1, LOUT1_PATH_CHANNELS);
+
+	}
+
+	if (output_path != MC_ASOC_OUTPUT_PATH_LO2
+	    && output_path != MC_ASOC_OUTPUT_PATH_SP_LO2
+	    && output_path != MC_ASOC_OUTPUT_PATH_LO2_RC
+	    && output_path != MC_ASOC_OUTPUT_PATH_LO2_HP
+	    && output_path != MC_ASOC_OUTPUT_PATH_LO2_BT
+	    && output_path != MC_ASOC_OUTPUT_PATH_LO1_LO2
+	    && output_path != MC_ASOC_OUTPUT_PATH_LO2_LO1) {
+		if (preset_idx < 12) {
+			if (mc_asoc_audio_cap_port == LOUT2) {
+				if (preset_idx <= 3 || preset_idx == 6
+				    || preset_idx == 7)
+					mask_source(path->lout2,
+						    LOUT2_PATH_CHANNELS);
+			} else
+				mask_source(path->lout2, LOUT2_PATH_CHANNELS);
+		} else if (is_incall(preset_idx)) {
+			if (mc_asoc_voice_port == LIN1_LOUT2) {
+				/* nothing to do */
+			} else if (mc_asoc_audio_cap_port == LOUT2) {
+				if (preset_idx != 18 && preset_idx != 21
+				    && preset_idx != 56 && preset_idx != 59)
+					mask_source(path->lout2,
+						    LOUT2_PATH_CHANNELS);
+			} else
+				mask_source(path->lout2, LOUT2_PATH_CHANNELS);
+		} else if (preset_idx == 24 || preset_idx >= 26) {
+			mask_source(path->lout2, LOUT2_PATH_CHANNELS);
+		}
+	}
+}
+
+static void mask_bluetooth_out_source(struct mcdrv_path_info *path,
+				      int output_path)
+{
+	int i;
+
+	if (output_path != MC_ASOC_OUTPUT_PATH_BT
+	    && output_path != MC_ASOC_OUTPUT_PATH_SP_BT
+	    && output_path != MC_ASOC_OUTPUT_PATH_LO1_BT
+	    && output_path != MC_ASOC_OUTPUT_PATH_LO2_BT)
+		for (i = 0; i < EXTOUT_PATH_CHANNELS; i++)
+			path->ext_out[i] = 0x00aaaaaa;
+}
+
+static void mask_adc0_source(struct mcdrv_path_info *path,
+			     struct mixer_path_ctl_info *mixer, int preset_idx)
+{
+	int input_path, output_path, incall_mic;
+	int main_mic_block_on = get_main_mic_block_on();
+	int sub_mic_block_on = get_sub_mic_block_on();
+	int hs_mic_block_on = get_hs_mic_block_on();
+	int unused_mic_block_on = get_unused_mic_block_on();
+
+	if (!is_incall(preset_idx) && !is_incommunication(preset_idx)) {
+		/* !incall */
+		if (preset_idx == 4 || preset_idx == 6
+		    || preset_idx == 8 || preset_idx == 10
+		    || preset_idx == 28 || preset_idx == 29
+		    || preset_idx == 30 || preset_idx == 32
+		    || preset_idx == 34 || preset_idx == 36
+		    || preset_idx == 46 || preset_idx == 48) {
+			/* in capture */
+			input_path = mixer->input_path;
+			if (input_path != MC_ASOC_INPUT_PATH_MAINMIC
+			    && input_path != MC_ASOC_INPUT_PATH_2MIC
+			    && main_mic_block_on != -1) {
+				path->adc0[0] &= ~main_mic_block_on;
+				path->adc0[1] &= ~main_mic_block_on;
+			}
+
+			if (input_path != MC_ASOC_INPUT_PATH_SUBMIC
+			    && input_path != MC_ASOC_INPUT_PATH_2MIC
+			    && sub_mic_block_on != -1) {
+				path->adc0[0] &= ~sub_mic_block_on;
+				path->adc0[1] &= ~sub_mic_block_on;
+			}
+
+			if (input_path != MC_ASOC_INPUT_PATH_HS
+			    && hs_mic_block_on != -1) {
+				path->adc0[0] &= ~hs_mic_block_on;
+				path->adc0[1] &= ~hs_mic_block_on;
+			}
+
+			if (input_path == MC_ASOC_INPUT_PATH_2MIC) {
+				path->adc0[0] &= ~sub_mic_block_on;
+				path->adc0[1] &= ~main_mic_block_on;
+			}
+
+			if (input_path != MC_ASOC_INPUT_PATH_LIN1) {
+				path->adc0[0] &= ~MCDRV_ASRC_LINEIN1_L_ON;
+				path->adc0[1] &= ~MCDRV_ASRC_LINEIN1_R_ON;
+			}
+		} else {
+			if (mixer->mainmic_play != 1 && mixer->msmic_play != 1
+			    && main_mic_block_on != -1) {
+				path->adc0[0] &= ~main_mic_block_on;
+				path->adc0[1] &= ~main_mic_block_on;
+			}
+
+			if (mixer->submic_play != 1 && mixer->msmic_play != 1
+			    && sub_mic_block_on != -1) {
+				path->adc0[0] &= ~sub_mic_block_on;
+				path->adc0[1] &= ~sub_mic_block_on;
+			}
+
+			if (mixer->hsmic_play != 1 && hs_mic_block_on != -1) {
+				path->adc0[0] &= ~hs_mic_block_on;
+				path->adc0[1] &= ~hs_mic_block_on;
+			}
+
+			if (mixer->lin1_play != 1) {
+				path->adc0[0] &= ~MCDRV_ASRC_LINEIN1_ALL_ON;
+				path->adc0[1] &= ~MCDRV_ASRC_LINEIN1_ALL_ON;
+			}
+		}
+	} else {
+		/* incall or incommunication */
+		output_path = mixer->output_path;
+		if (output_path != MC_ASOC_OUTPUT_PATH_BT
+		    && output_path != MC_ASOC_OUTPUT_PATH_SP_BT
+		    && output_path != MC_ASOC_OUTPUT_PATH_LO1_BT
+		    && output_path != MC_ASOC_OUTPUT_PATH_LO2_BT) {
+			if (output_path != MC_ASOC_OUTPUT_PATH_HS) {
+				if (hs_mic_block_on != -1) {
+					path->adc0[0] &= ~hs_mic_block_on;
+					path->adc0[1] &= ~hs_mic_block_on;
+				}
+
+				incall_mic = mixer->incall_mic;
+				if (incall_mic != MC_ASOC_INCALL_MIC_MAINMIC
+				    && incall_mic != MC_ASOC_INCALL_MIC_2MIC
+				    && main_mic_block_on != -1) {
+					path->adc0[0] &= ~main_mic_block_on;
+					path->adc0[1] &= ~main_mic_block_on;
+				}
+
+				if (incall_mic != MC_ASOC_INCALL_MIC_SUBMIC
+				    && incall_mic != MC_ASOC_INCALL_MIC_2MIC
+				    && sub_mic_block_on != -1) {
+					path->adc0[0] &= ~sub_mic_block_on;
+					path->adc0[1] &= ~sub_mic_block_on;
+				}
+
+				if (incall_mic == MC_ASOC_INCALL_MIC_2MIC) {
+					path->adc0[0] &= ~sub_mic_block_on;
+					path->adc0[1] &= ~main_mic_block_on;
+				}
+			} else {
+				if (main_mic_block_on != -1) {
+					path->adc0[0] &= ~main_mic_block_on;
+					path->adc0[1] &= ~main_mic_block_on;
+				}
+
+				if (sub_mic_block_on != -1) {
+					path->adc0[0] &= ~sub_mic_block_on;
+					path->adc0[1] &= ~sub_mic_block_on;
+				}
+			}
+		}
+	}
+
+	path->adc0[0] &= ~unused_mic_block_on;
+	path->adc0[1] &= ~unused_mic_block_on;
+}
+
+static void mask_adc1_source(struct mcdrv_path_info *path,
+			     struct mixer_path_ctl_info *mixer, int preset_idx)
+{
+	int input_path = mixer->input_path;
+	int main_mic_block_on = get_main_mic_block_on();
+	int sub_mic_block_on = get_sub_mic_block_on();
+	int hs_mic_block_on = get_hs_mic_block_on();
+	int unused_mic_block_on = get_unused_mic_block_on();
+
+	/* !incall */
+	if (preset_idx == 38 || preset_idx == 40
+	    || preset_idx == 42 || preset_idx == 44) {
+		/* in capture */
+		if (input_path != MC_ASOC_INPUT_PATH_MAINMIC
+		    && input_path != MC_ASOC_INPUT_PATH_2MIC
+		    && main_mic_block_on != -1)
+			path->adc1[0] &= ~main_mic_block_on;
+
+		if (input_path != MC_ASOC_INPUT_PATH_SUBMIC
+		    && input_path != MC_ASOC_INPUT_PATH_2MIC
+		    && sub_mic_block_on != -1)
+			path->adc1[0] &= ~sub_mic_block_on;
+
+		if (input_path != MC_ASOC_INPUT_PATH_HS
+		    && hs_mic_block_on != -1)
+			path->adc1[0] &= ~hs_mic_block_on;
+
+		if (input_path != MC_ASOC_INPUT_PATH_LIN1)
+			path->adc1[0] &= ~MCDRV_ASRC_LINEIN1_M_ON;
+	}
+
+	path->adc1[0] &= ~unused_mic_block_on;
+}
+
+static void mask_dac_reference(struct mcdrv_path_info *path, int output_path)
+{
+	int i;
+
+	switch (output_path) {
+	case MC_ASOC_OUTPUT_PATH_SP:
+	case MC_ASOC_OUTPUT_PATH_LO2:
+	case MC_ASOC_OUTPUT_PATH_SP_LO2:
+	case MC_ASOC_OUTPUT_PATH_SP_BT:
+	case MC_ASOC_OUTPUT_PATH_LO2_BT:
+	case MC_ASOC_OUTPUT_PATH_LO1_LO2:
+		for (i = 0; i < ADIF2_PATH_CHANNELS; i++)
+			path->adif2[i] &= ~MCDRV_D2SRC_DAC0REF_ON;
+		break;
+	case MC_ASOC_OUTPUT_PATH_RC:
+	case MC_ASOC_OUTPUT_PATH_HP:
+	case MC_ASOC_OUTPUT_PATH_HS:
+	case MC_ASOC_OUTPUT_PATH_LO1:
+	case MC_ASOC_OUTPUT_PATH_LO1_RC:
+	case MC_ASOC_OUTPUT_PATH_LO1_HP:
+	case MC_ASOC_OUTPUT_PATH_LO1_BT:
+	case MC_ASOC_OUTPUT_PATH_SP_RC:
+	case MC_ASOC_OUTPUT_PATH_SP_HP:
+	case MC_ASOC_OUTPUT_PATH_SP_LO1:
+	case MC_ASOC_OUTPUT_PATH_LO2_RC:
+	case MC_ASOC_OUTPUT_PATH_LO2_HP:
+	case MC_ASOC_OUTPUT_PATH_LO2_LO1:
+		for (i = 0; i < ADIF2_PATH_CHANNELS; i++)
+			path->adif2[i] &= ~MCDRV_D2SRC_DAC1REF_ON;
+		break;
+	default:
+		break;
+	}
+}
+
+static void add_path_info(struct mcdrv_path_info *dst_path,
+			  const struct mcdrv_path_info *src_path)
+{
+	int i;
+
+	for (i = 0; i < MUSICOUT_PATH_CHANNELS; i++)
+		dst_path->music_out[i] |= src_path->music_out[i];
+
+	for (i = 0; i < EXTOUT_PATH_CHANNELS; i++)
+		dst_path->ext_out[i] |= src_path->ext_out[i];
+
+	for (i = 0; i < HIFIOUT_PATH_CHANNELS; i++)
+		dst_path->hifi_out[i] |= src_path->hifi_out[i];
+
+	for (i = 0; i < VBOXMIXIN_PATH_CHANNELS; i++)
+		dst_path->vbox_mix_in[i] |= src_path->vbox_mix_in[i];
+
+	for (i = 0; i < AE_PATH_CHANNELS; i++) {
+		dst_path->ae0[i] |= src_path->ae0[i];
+		dst_path->ae1[i] |= src_path->ae1[i];
+		dst_path->ae2[i] |= src_path->ae2[i];
+		dst_path->ae3[i] |= src_path->ae3[i];
+	}
+
+	for (i = 0; i < DAC0_PATH_CHANNELS; i++)
+		dst_path->dac0[i] |= src_path->dac0[i];
+
+	for (i = 0; i < DAC1_PATH_CHANNELS; i++)
+		dst_path->dac1[i] |= src_path->dac1[i];
+
+	for (i = 0; i < VOICEOUT_PATH_CHANNELS; i++)
+		dst_path->voice_out[i] |= src_path->voice_out[i];
+
+	for (i = 0; i < VBOXIOIN_PATH_CHANNELS; i++)
+		dst_path->vbox_io_in[i] |= src_path->vbox_io_in[i];
+
+	for (i = 0; i < VBOXHOSTIN_PATH_CHANNELS; i++)
+		dst_path->vbox_host_in[i] |= src_path->vbox_host_in[i];
+
+	for (i = 0; i < HOSTOUT_PATH_CHANNELS; i++)
+		dst_path->host_out[i] |= src_path->host_out[i];
+
+	for (i = 0; i < ADIF0_PATH_CHANNELS; i++)
+		dst_path->adif0[i] |= src_path->adif0[i];
+
+	for (i = 0; i < ADIF1_PATH_CHANNELS; i++)
+		dst_path->adif1[i] |= src_path->adif1[i];
+
+	for (i = 0; i < ADIF2_PATH_CHANNELS; i++)
+		dst_path->adif2[i] |= src_path->adif2[i];
+
+	for (i = 0; i < ADC0_PATH_CHANNELS; i++)
+		dst_path->adc0[i] |= src_path->adc0[i];
+
+	for (i = 0; i < ADC1_PATH_CHANNELS; i++)
+		dst_path->adc1[i] |= src_path->adc1[i];
+
+	for (i = 0; i < HP_PATH_CHANNELS; i++)
+		dst_path->hp[i] |= src_path->hp[i];
+
+	for (i = 0; i < SP_PATH_CHANNELS; i++)
+		dst_path->sp[i] |= src_path->sp[i];
+
+	for (i = 0; i < RC_PATH_CHANNELS; i++)
+		dst_path->rc[i] |= src_path->rc[i];
+
+	for (i = 0; i < LOUT1_PATH_CHANNELS; i++)
+		dst_path->lout1[i] |= src_path->lout1[i];
+
+	for (i = 0; i < LOUT2_PATH_CHANNELS; i++)
+		dst_path->lout2[i] |= src_path->lout2[i];
+
+	for (i = 0; i < BIAS_PATH_CHANNELS; i++)
+		dst_path->bias[i] |= src_path->bias[i];
+}
+
+static void exchange_adc0_to_pdm(struct mcdrv_path_info *path,
+				 u32 pdm_l_on, u32 pdm_r_on)
+{
+	if (pdm_l_on) {
+		path->adif1[0] &= ~MCDRV_D2SRC_ADC0_ON;
+		path->adif1[0] |= MCDRV_D2SRC_ADC0_OFF | pdm_l_on;
+	}
+
+	if (pdm_r_on) {
+		path->adif1[1] &= ~MCDRV_D2SRC_ADC0_ON;
+		path->adif1[1] |= MCDRV_D2SRC_ADC0_OFF | pdm_r_on;
+	}
+}
+
+static void exchange_adc1_to_pdm(struct mcdrv_path_info *path,
+				 u32 pdm_l_on, u32 pdm_r_on)
+{
+	if (pdm_l_on) {
+		path->adif0[0] &= ~MCDRV_D2SRC_ADC1_ON;
+		path->adif0[0] |= MCDRV_D2SRC_ADC1_OFF | pdm_l_on;
+	}
+
+	if (pdm_r_on) {
+		path->adif0[1] &= ~MCDRV_D2SRC_ADC1_ON;
+		path->adif0[1] |= MCDRV_D2SRC_ADC1_OFF | pdm_r_on;
+	}
+}
+
+static void set_ain_play_path(struct mcdrv_path_info *path,
+			      struct mixer_path_ctl_info *mixer,
+			      int preset_idx, int ignore_input_path)
+{
+	int idx = analog_path_mapping[preset_idx];
+	int input_path = mixer->input_path;
+
+	if (idx >= ARRAY_SIZE(analog_input_path))
+		return;
+
+	if (mixer->mainmic_play == 1) {
+		if (ignore_input_path
+		    || input_path == MC_ASOC_INPUT_PATH_MAINMIC) {
+			add_path_info(path, &analog_input_path[idx]);
+			if (mc_asoc_main_mic == MIC_PDM0)
+				exchange_adc0_to_pdm(path,
+						     MCDRV_D2SRC_PDM0_L_ON,
+						     MCDRV_D2SRC_PDM0_R_ON);
+			else if (mc_asoc_main_mic == MIC_PDM1)
+				exchange_adc0_to_pdm(path,
+						     MCDRV_D2SRC_PDM1_L_ON,
+						     MCDRV_D2SRC_PDM1_R_ON);
+			mask_adc0_source(path, mixer, preset_idx);
+			mask_bluetooth_out_source(path, mixer->output_path);
+			return;
+		}
+	}
+
+	if (mixer->submic_play == 1) {
+		if (ignore_input_path
+		    || input_path == MC_ASOC_INPUT_PATH_SUBMIC) {
+			add_path_info(path, &analog_input_path[idx]);
+			if (mc_asoc_sub_mic == MIC_PDM0)
+				exchange_adc0_to_pdm(path,
+						     MCDRV_D2SRC_PDM0_L_ON,
+						     MCDRV_D2SRC_PDM0_R_ON);
+			else if (mc_asoc_sub_mic == MIC_PDM1)
+				exchange_adc0_to_pdm(path,
+						     MCDRV_D2SRC_PDM1_L_ON,
+						     MCDRV_D2SRC_PDM1_R_ON);
+			mask_adc0_source(path, mixer, preset_idx);
+			mask_bluetooth_out_source(path, mixer->output_path);
+			return;
+		}
+	}
+
+	if (mixer->hsmic_play == 1) {
+		if (ignore_input_path || input_path == MC_ASOC_INPUT_PATH_HS) {
+			add_path_info(path, &analog_input_path[idx]);
+			if (mc_asoc_hs_mic == MIC_PDM0)
+				exchange_adc0_to_pdm(path,
+						     MCDRV_D2SRC_PDM0_L_ON,
+						     MCDRV_D2SRC_PDM0_R_ON);
+			else if (mc_asoc_hs_mic == MIC_PDM1)
+				exchange_adc0_to_pdm(path,
+						     MCDRV_D2SRC_PDM1_L_ON,
+						     MCDRV_D2SRC_PDM1_R_ON);
+			mask_adc0_source(path, mixer, preset_idx);
+			mask_bluetooth_out_source(path, mixer->output_path);
+			return;
+		}
+	}
+
+	if (mixer->msmic_play == 1) {
+		if (ignore_input_path
+		    || input_path == MC_ASOC_INPUT_PATH_2MIC) {
+			add_path_info(path, &analog_input_path[idx]);
+			if (mc_asoc_main_mic == MIC_PDM0)
+				exchange_adc0_to_pdm(path,
+						     MCDRV_D2SRC_PDM0_L_ON, 0);
+			else if (mc_asoc_main_mic == MIC_PDM1)
+				exchange_adc0_to_pdm(path,
+						     MCDRV_D2SRC_PDM1_L_ON, 0);
+			if (mc_asoc_sub_mic == MIC_PDM0)
+				exchange_adc0_to_pdm(path,
+						     0, MCDRV_D2SRC_PDM0_R_ON);
+			else if (mc_asoc_sub_mic == MIC_PDM1)
+				exchange_adc0_to_pdm(path,
+						     0, MCDRV_D2SRC_PDM1_R_ON);
+			mask_adc0_source(path, mixer, preset_idx);
+			mask_bluetooth_out_source(path, mixer->output_path);
+			return;
+		}
+	}
+
+	if (mixer->lin1_play == 1) {
+		if (ignore_input_path
+		    || input_path == MC_ASOC_INPUT_PATH_LIN1) {
+			add_path_info(path, &analog_input_path[idx]);
+			mask_adc0_source(path, mixer, preset_idx);
+			mask_bluetooth_out_source(path, mixer->output_path);
+			return;
+		}
+	}
+}
+
+static inline void set_bias(struct mcdrv_path_info *path)
+{
+	int mic_bias[BIAS_PATH_CHANNELS] = {
+		mc_asoc_mic1_bias,
+		mc_asoc_mic2_bias,
+		mc_asoc_mic3_bias,
+		mc_asoc_mic4_bias
+	};
+	u32 on[BIAS_PATH_CHANNELS] = {
+		MCDRV_ASRC_MIC1_ON,
+		MCDRV_ASRC_MIC2_ON,
+		MCDRV_ASRC_MIC3_ON,
+		MCDRV_ASRC_MIC4_ON
+	};
+	int i, j;
+
+	for (i = 0; i < BIAS_PATH_CHANNELS; i++) {
+		switch (mic_bias[i]) {
+		case BIAS_ON_ALWAYS:
+			path->bias[i] |= on[i];
+			break;
+		case BIAS_OFF:
+			path->bias[i] &= ~on[i];
+			break;
+		case BIAS_SYNC_MIC:
+			path->bias[i] &= ~on[i];
+			for (j = 0; j < ADC0_PATH_CHANNELS; j++) {
+				if (path->adc0[j] & on[i]) {
+					path->bias[i] |= on[i];
+					break;
+				}
+			}
+
+			for (j = 0; j < ADC1_PATH_CHANNELS; j++) {
+				if (path->adc1[j] & on[i]) {
+					path->bias[i] |= on[i];
+					break;
+				}
+			}
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (path->hp[0] & MCDRV_ASRC_DAC0_L_ON
+	    || path->hp[1] & MCDRV_ASRC_DAC0_R_ON) {
+		if (mc_asoc_jack_status)
+			path->bias[3] |= MCDRV_ASRC_MIC4_ON;
+	}
+}
+
+static void get_path_info(struct mcdrv_path_info *path,
+			  struct mixer_path_ctl_info *mixer, int preset_idx)
+{
+	const struct mcdrv_path_info *preset_path;
+	size_t offset;
+	bool mute_dit = false, ain_play = false;
+	int input_path, output_path, audio_mode_play, audio_mode_cap, idx;
+
+	if (mixer->mainmic_play == 1 || mixer->submic_play == 1
+	    || mixer->msmic_play == 1 || mixer->hsmic_play == 1
+	    || mixer->lin1_play == 1)
+		ain_play = true;
+
+	preset_path = &mc_preset_path_info[preset_idx];
+	input_path = mixer->input_path;
+	output_path = mixer->output_path;
+	audio_mode_play = mixer->audio_mode_play;
+	audio_mode_cap = mixer->audio_mode_cap;
+
+	if (mixer->dtmf_control == 1) {
+		if (!(mixer->dtmf_output == MC_ASOC_DTMF_OUTPUT_SP
+		      && output_path != MC_ASOC_OUTPUT_PATH_SP)) {
+			idx = dtmf_path_mapping[preset_idx];
+			if (idx >= ARRAY_SIZE(dtmf_path))
+				return;
+
+			add_path_info(path, &dtmf_path[idx]);
+			mask_analog_out_source(path, mixer, preset_idx);
+			mask_bluetooth_out_source(path, output_path);
+		}
+	}
+
+	if (is_incommunication(preset_idx)) {
+		if (output_path == MC_ASOC_OUTPUT_PATH_BT) {
+			add_path_info(path, preset_path);
+			path->vbox_mix_in[1] = 0x00aaaaaa;
+		} else if (output_path == MC_ASOC_OUTPUT_PATH_SP_BT
+			   || output_path == MC_ASOC_OUTPUT_PATH_LO1_BT
+			   || output_path == MC_ASOC_OUTPUT_PATH_LO2_BT) {
+			add_path_info(path, preset_path);
+			mask_analog_out_source(path, mixer, preset_idx);
+			path->vbox_mix_in[1] = 0x00aaaaaa;
+			mask_dac_reference(path, output_path);
+		} else {
+			add_path_info(path, preset_path);
+
+			switch (mixer->incall_mic) {
+			case MC_ASOC_INCALL_MIC_MAINMIC:
+				if (mc_asoc_main_mic == MIC_PDM0)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM0_L_ON,
+							MCDRV_D2SRC_PDM0_R_ON);
+				else if (mc_asoc_main_mic == MIC_PDM1)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM1_L_ON,
+							MCDRV_D2SRC_PDM1_R_ON);
+				path->vbox_mix_in[1] = 0x00aaaaaa;
+				break;
+			case MC_ASOC_INCALL_MIC_SUBMIC:
+				if (mc_asoc_sub_mic == MIC_PDM0)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM0_L_ON,
+							MCDRV_D2SRC_PDM0_R_ON);
+				else if (mc_asoc_sub_mic == MIC_PDM1)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM1_L_ON,
+							MCDRV_D2SRC_PDM1_R_ON);
+				path->vbox_mix_in[1] = 0x00aaaaaa;
+				break;
+			default:
+				if (mc_asoc_main_mic == MIC_PDM0)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM0_L_ON,
+							0);
+				else if (mc_asoc_main_mic == MIC_PDM1)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM1_L_ON,
+							0);
+				if (mc_asoc_sub_mic == MIC_PDM0)
+					exchange_adc0_to_pdm(path,
+							0,
+							MCDRV_D2SRC_PDM0_R_ON);
+				else if (mc_asoc_sub_mic == MIC_PDM1)
+					exchange_adc0_to_pdm(path,
+							0,
+							MCDRV_D2SRC_PDM1_R_ON);
+				break;
+			}
+
+			mask_dac_reference(path, output_path);
+			mask_adc0_source(path, mixer, preset_idx);
+			mask_analog_out_source(path, mixer, preset_idx);
+		}
+
+		return;
+	}
+
+	if ((preset_idx >= 12 && preset_idx <= 17)
+	    || (preset_idx >= 50 && preset_idx <= 55)) {
+		if (output_path == MC_ASOC_OUTPUT_PATH_BT) {
+			add_path_info(path, preset_path);
+			path->vbox_mix_in[1] = 0x00aaaaaa;
+		} else if (output_path == MC_ASOC_OUTPUT_PATH_SP_BT
+			   || output_path == MC_ASOC_OUTPUT_PATH_LO1_BT
+			   || output_path == MC_ASOC_OUTPUT_PATH_LO2_BT) {
+			add_path_info(path, preset_path);
+			mask_analog_out_source(path, mixer, preset_idx);
+			path->vbox_mix_in[1] = 0x00aaaaaa;
+			mask_dac_reference(path, output_path);
+		} else {
+			add_path_info(path, preset_path);
+			if (mixer->incall_mic == MC_ASOC_INCALL_MIC_MAINMIC) {
+				if (mc_asoc_main_mic == MIC_PDM0)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM0_L_ON,
+							MCDRV_D2SRC_PDM0_R_ON);
+				else if (mc_asoc_main_mic == MIC_PDM1)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM1_L_ON,
+							MCDRV_D2SRC_PDM1_R_ON);
+				path->vbox_mix_in[1] = 0x00aaaaaa;
+			} else if (mixer->incall_mic ==
+				   MC_ASOC_INCALL_MIC_SUBMIC) {
+				if (mc_asoc_sub_mic == MIC_PDM0)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM0_L_ON,
+							MCDRV_D2SRC_PDM0_R_ON);
+				else if (mc_asoc_sub_mic == MIC_PDM1)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM1_L_ON,
+							MCDRV_D2SRC_PDM1_R_ON);
+				path->vbox_mix_in[1] = 0x00aaaaaa;
+			} else {
+				if (mc_asoc_main_mic == MIC_PDM0)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM0_L_ON,
+							0);
+				else if (mc_asoc_main_mic == MIC_PDM1)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM1_L_ON,
+							0);
+
+				if (mc_asoc_sub_mic == MIC_PDM0)
+					exchange_adc0_to_pdm(path, 0,
+							MCDRV_D2SRC_PDM0_R_ON);
+				else if (mc_asoc_sub_mic == MIC_PDM1)
+					exchange_adc0_to_pdm(path, 0,
+							MCDRV_D2SRC_PDM1_R_ON);
+
+			}
+
+			mask_adc0_source(path, mixer, preset_idx);
+			mask_analog_out_source(path, mixer, preset_idx);
+			mask_dac_reference(path, output_path);
+		}
+
+		return;
+	}
+
+	if ((preset_idx >= 18 && preset_idx <= 23)
+	    || (preset_idx >= 56 && preset_idx <= 61)) {
+		if (output_path == MC_ASOC_OUTPUT_PATH_BT) {
+			add_path_info(path, preset_path);
+			path->vbox_mix_in[1] = 0x00aaaaaa;
+		} else if (output_path == MC_ASOC_OUTPUT_PATH_SP_BT
+			   || output_path == MC_ASOC_OUTPUT_PATH_LO1_BT
+			   || output_path == MC_ASOC_OUTPUT_PATH_LO2_BT) {
+			add_path_info(path, preset_path);
+			mask_analog_out_source(path, mixer, preset_idx);
+			path->vbox_mix_in[1] = 0x00aaaaaa;
+			mask_dac_reference(path, output_path);
+		} else {
+			add_path_info(path, preset_path);
+			if (mixer->incall_mic == MC_ASOC_INCALL_MIC_MAINMIC) {
+				if (mc_asoc_main_mic == MIC_PDM0)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM0_L_ON,
+							MCDRV_D2SRC_PDM0_R_ON);
+				else if (mc_asoc_main_mic == MIC_PDM1)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM1_L_ON,
+							MCDRV_D2SRC_PDM1_R_ON);
+				path->vbox_mix_in[1] = 0x00aaaaaa;
+			} else if (mixer->incall_mic ==
+				   MC_ASOC_INCALL_MIC_SUBMIC) {
+				if (mc_asoc_sub_mic == MIC_PDM0)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM0_L_ON,
+							MCDRV_D2SRC_PDM0_R_ON);
+				else if (mc_asoc_sub_mic == MIC_PDM1)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM1_L_ON,
+							MCDRV_D2SRC_PDM1_R_ON);
+				path->vbox_mix_in[1] = 0x00aaaaaa;
+			} else {
+				if (mc_asoc_main_mic == MIC_PDM0)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM0_L_ON,
+							0);
+				else if (mc_asoc_main_mic == MIC_PDM1)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM1_L_ON,
+							0);
+
+				if (mc_asoc_sub_mic == MIC_PDM0)
+					exchange_adc0_to_pdm(path, 0,
+							MCDRV_D2SRC_PDM0_R_ON);
+				else if (mc_asoc_sub_mic == MIC_PDM1)
+					exchange_adc0_to_pdm(path, 0,
+							MCDRV_D2SRC_PDM1_R_ON);
+			}
+
+			mask_adc0_source(path, mixer, preset_idx);
+			mask_analog_out_source(path, mixer, preset_idx);
+			mask_dac_reference(path, output_path);
+		}
+
+		return;
+	}
+
+	if (mixer->btmic_play == 1) {
+		idx = bt_path_mapping[preset_idx];
+		if (bt_path_mapping[preset_idx] < ARRAY_SIZE(bt_input_path)) {
+			add_path_info(path, &bt_input_path[idx]);
+			mask_bluetooth_out_source(path, output_path);
+		}
+	}
+
+	if ((preset_idx >= 1 && preset_idx <= 3) || preset_idx == 27) {
+		if (ain_play)
+			set_ain_play_path(path, mixer, preset_idx, 1);
+		add_path_info(path, preset_path);
+	} else if (preset_idx == 4 || preset_idx == 5 || preset_idx == 28
+		   || preset_idx == 30 || preset_idx == 31) {
+		if (input_path != MC_ASOC_INPUT_PATH_VOICECALL
+		    && input_path != MC_ASOC_INPUT_PATH_VOICEUPLINK
+		    && input_path != MC_ASOC_INPUT_PATH_VOICEDOWNLINK) {
+			if (ain_play == 1) {
+				if (input_path == MC_ASOC_INPUT_PATH_BT)
+					set_ain_play_path(path, mixer,
+							  preset_idx, 1);
+				else
+					set_ain_play_path(path, mixer,
+							  preset_idx, 0);
+			}
+
+			add_path_info(path, preset_path);
+			switch (input_path) {
+			case MC_ASOC_INPUT_PATH_MAINMIC:
+				if (mc_asoc_main_mic == MIC_PDM0)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM0_L_ON,
+							MCDRV_D2SRC_PDM0_R_ON);
+				else if (mc_asoc_main_mic == MIC_PDM1)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM1_L_ON,
+							MCDRV_D2SRC_PDM1_R_ON);
+				break;
+			case MC_ASOC_INPUT_PATH_SUBMIC:
+				if (mc_asoc_sub_mic == MIC_PDM0)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM0_L_ON,
+							MCDRV_D2SRC_PDM0_R_ON);
+				else if (mc_asoc_sub_mic == MIC_PDM1)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM1_L_ON,
+							MCDRV_D2SRC_PDM1_R_ON);
+				break;
+			case MC_ASOC_INPUT_PATH_2MIC:
+				if (mc_asoc_main_mic == MIC_PDM0)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM0_L_ON,
+							0);
+				else if (mc_asoc_main_mic == MIC_PDM1)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM1_L_ON,
+							0);
+				if (mc_asoc_sub_mic == MIC_PDM0)
+					exchange_adc0_to_pdm(path, 0,
+							MCDRV_D2SRC_PDM0_R_ON);
+				else if (mc_asoc_sub_mic == MIC_PDM1)
+					exchange_adc0_to_pdm(path, 0,
+							MCDRV_D2SRC_PDM1_R_ON);
+				break;
+			case MC_ASOC_INPUT_PATH_HS:
+				if (mc_asoc_hs_mic == MIC_PDM0)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM0_L_ON,
+							MCDRV_D2SRC_PDM0_R_ON);
+				else if (mc_asoc_hs_mic == MIC_PDM1)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM1_L_ON,
+							MCDRV_D2SRC_PDM1_R_ON);
+				break;
+			default:
+				break;
+			}
+
+			mask_adc0_source(path, mixer, preset_idx);
+			if (input_path != MC_ASOC_INPUT_PATH_2MIC)
+				path->vbox_mix_in[1] = 0x00aaaaaa;
+		} else {
+			add_path_info(path, preset_path);
+			mute_dit = true;
+		}
+	} else if ((preset_idx >= 6 && preset_idx <= 11)
+		   || preset_idx == 29
+		   || (preset_idx >= 32 && preset_idx <= 37)) {
+		if (input_path != MC_ASOC_INPUT_PATH_VOICECALL
+		    && input_path != MC_ASOC_INPUT_PATH_VOICEUPLINK
+		    && input_path != MC_ASOC_INPUT_PATH_VOICEDOWNLINK) {
+			if (ain_play == 1) {
+				if (input_path == MC_ASOC_INPUT_PATH_BT)
+					set_ain_play_path(path, mixer,
+							  preset_idx, 1);
+				else
+					set_ain_play_path(path, mixer,
+							  preset_idx, 0);
+			}
+
+			add_path_info(path, preset_path);
+			switch (input_path) {
+			case MC_ASOC_INPUT_PATH_MAINMIC:
+				if (mc_asoc_main_mic == MIC_PDM0)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM0_L_ON,
+							MCDRV_D2SRC_PDM0_R_ON);
+				else if (mc_asoc_main_mic == MIC_PDM1)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM1_L_ON,
+							MCDRV_D2SRC_PDM1_R_ON);
+				break;
+			case MC_ASOC_INPUT_PATH_SUBMIC:
+				if (mc_asoc_sub_mic == MIC_PDM0)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM0_L_ON,
+							MCDRV_D2SRC_PDM0_R_ON);
+				else if (mc_asoc_sub_mic == MIC_PDM1)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM1_L_ON,
+							MCDRV_D2SRC_PDM1_R_ON);
+				break;
+			case MC_ASOC_INPUT_PATH_2MIC:
+				if (mc_asoc_main_mic == MIC_PDM0)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM0_L_ON,
+							0);
+				else if (mc_asoc_main_mic == MIC_PDM1)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM1_L_ON,
+							0);
+				if (mc_asoc_sub_mic == MIC_PDM0)
+					exchange_adc0_to_pdm(path, 0,
+							MCDRV_D2SRC_PDM0_R_ON);
+				else if (mc_asoc_sub_mic == MIC_PDM1)
+					exchange_adc0_to_pdm(path, 0,
+							MCDRV_D2SRC_PDM1_R_ON);
+				break;
+			case MC_ASOC_INPUT_PATH_HS:
+				if (mc_asoc_hs_mic == MIC_PDM0)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM0_L_ON,
+							MCDRV_D2SRC_PDM0_R_ON);
+				else if (mc_asoc_hs_mic == MIC_PDM1)
+					exchange_adc0_to_pdm(path,
+							MCDRV_D2SRC_PDM1_L_ON,
+							MCDRV_D2SRC_PDM1_R_ON);
+				break;
+			default:
+				break;
+			}
+
+			mask_adc0_source(path, mixer, preset_idx);
+			if (input_path != MC_ASOC_INPUT_PATH_2MIC)
+				path->vbox_mix_in[1] = 0x00aaaaaa;
+		} else {
+			add_path_info(path, preset_path);
+			mute_dit = true;
+		}
+	} else if (preset_idx >= 38 && preset_idx <= 45) {
+		if (ain_play == 1)
+			set_ain_play_path(path, mixer, preset_idx, 1);
+		if (input_path != MC_ASOC_INPUT_PATH_VOICECALL
+		    && input_path != MC_ASOC_INPUT_PATH_VOICEUPLINK
+		    && input_path != MC_ASOC_INPUT_PATH_VOICEDOWNLINK) {
+			add_path_info(path, preset_path);
+			switch (input_path) {
+			case MC_ASOC_INPUT_PATH_MAINMIC:
+				if (mc_asoc_main_mic == MIC_PDM0)
+					exchange_adc1_to_pdm(path,
+							MCDRV_D2SRC_PDM0_L_ON,
+							MCDRV_D2SRC_PDM0_R_ON);
+				else if (mc_asoc_main_mic == MIC_PDM1)
+					exchange_adc1_to_pdm(path,
+							MCDRV_D2SRC_PDM1_L_ON,
+							MCDRV_D2SRC_PDM1_R_ON);
+				break;
+			case MC_ASOC_INPUT_PATH_SUBMIC:
+				if (mc_asoc_sub_mic == MIC_PDM0)
+					exchange_adc1_to_pdm(path,
+							MCDRV_D2SRC_PDM0_L_ON,
+							MCDRV_D2SRC_PDM0_R_ON);
+				else if (mc_asoc_sub_mic == MIC_PDM1)
+					exchange_adc1_to_pdm(path,
+							MCDRV_D2SRC_PDM1_L_ON,
+							MCDRV_D2SRC_PDM1_R_ON);
+				break;
+			case MC_ASOC_INPUT_PATH_2MIC:
+				if (mc_asoc_main_mic == MIC_PDM0)
+					exchange_adc1_to_pdm(path,
+							MCDRV_D2SRC_PDM0_L_ON,
+							0);
+				if (mc_asoc_main_mic == MIC_PDM1)
+					exchange_adc1_to_pdm(path,
+							MCDRV_D2SRC_PDM1_L_ON,
+							0);
+				if (mc_asoc_sub_mic == MIC_PDM0)
+					exchange_adc1_to_pdm(path, 0,
+							MCDRV_D2SRC_PDM0_R_ON);
+				else if (mc_asoc_sub_mic == MIC_PDM1)
+					exchange_adc1_to_pdm(path, 0,
+							MCDRV_D2SRC_PDM1_R_ON);
+				break;
+			case MC_ASOC_INPUT_PATH_HS:
+				if (mc_asoc_hs_mic == MIC_PDM0)
+					exchange_adc1_to_pdm(path,
+							MCDRV_D2SRC_PDM0_L_ON,
+							MCDRV_D2SRC_PDM0_R_ON);
+				else if (mc_asoc_hs_mic == MIC_PDM1)
+					exchange_adc1_to_pdm(path,
+							MCDRV_D2SRC_PDM1_L_ON,
+							MCDRV_D2SRC_PDM1_R_ON);
+				break;
+			default:
+				break;
+			}
+			mask_adc1_source(path, mixer, preset_idx);
+		} else {
+			add_path_info(path, preset_path);
+			mute_dit = true;
+		}
+	} else if (preset_idx == 46 || preset_idx == 47
+		   || preset_idx == 48 || preset_idx == 49) {
+		add_path_info(path, preset_path);
+		switch (input_path) {
+		case MC_ASOC_INPUT_PATH_MAINMIC:
+			if (mc_asoc_main_mic == MIC_PDM0)
+				exchange_adc0_to_pdm(path,
+						     MCDRV_D2SRC_PDM0_L_ON,
+						     MCDRV_D2SRC_PDM0_R_ON);
+			else if (mc_asoc_main_mic == MIC_PDM1)
+				exchange_adc0_to_pdm(path,
+						     MCDRV_D2SRC_PDM1_L_ON,
+						     MCDRV_D2SRC_PDM1_R_ON);
+			break;
+		case MC_ASOC_INPUT_PATH_SUBMIC:
+			if (mc_asoc_sub_mic == MIC_PDM0)
+				exchange_adc0_to_pdm(path,
+						     MCDRV_D2SRC_PDM0_L_ON,
+						     MCDRV_D2SRC_PDM0_R_ON);
+			else if (mc_asoc_sub_mic == MIC_PDM1)
+				exchange_adc0_to_pdm(path,
+						     MCDRV_D2SRC_PDM1_L_ON,
+						     MCDRV_D2SRC_PDM1_R_ON);
+			break;
+		case MC_ASOC_INPUT_PATH_2MIC:
+			if (mc_asoc_main_mic == MIC_PDM0)
+				exchange_adc0_to_pdm(path,
+						     MCDRV_D2SRC_PDM0_L_ON, 0);
+			else if (mc_asoc_main_mic == MIC_PDM1)
+				exchange_adc0_to_pdm(path,
+						     MCDRV_D2SRC_PDM1_L_ON, 0);
+			if (mc_asoc_sub_mic == MIC_PDM0)
+				exchange_adc0_to_pdm(path,
+						     0, MCDRV_D2SRC_PDM0_R_ON);
+			else if (mc_asoc_sub_mic == MIC_PDM1)
+				exchange_adc0_to_pdm(path,
+						     0, MCDRV_D2SRC_PDM1_R_ON);
+			break;
+		case MC_ASOC_INPUT_PATH_HS:
+			if (mc_asoc_hs_mic == MIC_PDM0)
+				exchange_adc0_to_pdm(path,
+						     MCDRV_D2SRC_PDM0_L_ON,
+						     MCDRV_D2SRC_PDM0_R_ON);
+			else if (mc_asoc_hs_mic == MIC_PDM1)
+				exchange_adc0_to_pdm(path,
+						     MCDRV_D2SRC_PDM1_L_ON,
+						     MCDRV_D2SRC_PDM1_R_ON);
+			break;
+		default:
+			break;
+		}
+
+		mask_adc0_source(path, mixer, preset_idx);
+	} else if (ain_play == 1)
+		set_ain_play_path(path, mixer, preset_idx, 1);
+
+	mask_analog_out_source(path, mixer, preset_idx);
+	if (preset_idx < 4 || CAPTURE_PORT != CAPTURE_PORT_EXT)
+		mask_bluetooth_out_source(path, output_path);
+
+	offset = vreg_map[MC_ASOC_DVOL_EXTOUT].offset;
+	set_vol_mute_flag(offset, 0, 0);
+	set_vol_mute_flag(offset, 1, 0);
+
+	offset = vreg_map[MC_ASOC_DVOL_MUSICOUT].offset;
+	set_vol_mute_flag(offset, 0, 0);
+	set_vol_mute_flag(offset, 1, 0);
+	if (CAPTURE_PORT == CAPTURE_PORT_EXT) {
+		if (preset_idx >= 4) {
+			path->ext_out[0] = path->music_out[0];
+			path->music_out[0] = 0x00aaaaaa;
+			path->ext_out[1] = path->music_out[1];
+			path->music_out[1] = 0x00aaaaaa;
+			if (mute_dit) {
+				offset = vreg_map[MC_ASOC_DVOL_EXTOUT].offset;
+				set_vol_mute_flag(offset, 0, 1);
+				set_vol_mute_flag(offset, 1, 1);
+			}
+		}
+	} else if (mute_dit) {
+		offset = vreg_map[MC_ASOC_DVOL_MUSICOUT].offset;
+		set_vol_mute_flag(offset, 0, 1);
+		set_vol_mute_flag(offset, 1, 1);
+	}
+}
+
+static void set_adif_source(u8 src, u32 *onoff)
+{
+	switch (src) {
+	case 1:
+		/* ADC0L */
+		*onoff = 0x00aaaaaa | MCDRV_D2SRC_ADC0_L_ON;
+		break;
+	case 2:
+		/* ADC0R */
+		*onoff = 0x00aaaaaa | MCDRV_D2SRC_ADC0_R_ON;
+		break;
+	case 3:
+		/* ADC1 */
+		*onoff = 0x00aaaaaa | MCDRV_D2SRC_ADC1_ON;
+		break;
+	case 4:
+		/* PDM0L */
+		*onoff = 0x00aaaaaa | MCDRV_D2SRC_PDM0_L_ON;
+		break;
+	case 5:
+		/* PDM0R */
+		*onoff = 0x00aaaaaa | MCDRV_D2SRC_PDM0_R_ON;
+		break;
+	case 6:
+		/* PDM1L */
+		*onoff = 0x00aaaaaa | MCDRV_D2SRC_PDM1_L_ON;
+		break;
+	case 7:
+		/* PDM1R */
+		*onoff = 0x00aaaaaa | MCDRV_D2SRC_PDM1_R_ON;
+		break;
+	case 8:
+		/* DAC0REF */
+		*onoff = 0x00aaaaaa | MCDRV_D2SRC_DAC0REF_ON;
+		break;
+	case 9:
+		/* DAC1REF */
+		*onoff = 0x00aaaaaa | MCDRV_D2SRC_DAC1REF_ON;
+		break;
+	default:
+		break;
+	}
+}
+
+static int connect_path(struct snd_soc_codec *codec)
+{
+	struct mixer_path_ctl_info mixer_info;
+	struct mcdrv_path_info path_info;
+	int preset_idx = 0;
+	int cache;
+	int err;
+
+	if (get_mixer_path_ctl_info(codec, &mixer_info) < 0)
+		return -EIO;
+
+	preset_idx = get_path_preset_idx(&mixer_info);
+	if (preset_idx < 0 || preset_idx > PRESET_PATH_N)
+		return -EIO;
+
+	memcpy(&path_info, &mc_preset_path_info[0],
+	       sizeof(struct mcdrv_path_info));
+	get_path_info(&path_info, &mixer_info, preset_idx);
+	set_bias(&path_info);
+
+	cache = read_cache(codec, MC_ASOC_ADIF0_SOURCE);
+	if (cache < 0)
+		return -EIO;
+	if ((cache & 0xff) && (cache & 0xff00)) {
+		set_adif_source(cache, &path_info.adif0[0]);
+		set_adif_source(cache >> 8, &path_info.adif0[1]);
+	}
+
+	cache = read_cache(codec, MC_ASOC_ADIF1_SOURCE);
+	if (cache < 0)
+		return -EIO;
+	if ((cache & 0xff) && (cache & 0xff00)) {
+		set_adif_source(cache, &path_info.adif1[0]);
+		set_adif_source(cache >> 8, &path_info.adif1[1]);
+	}
+
+	cache = read_cache(codec, MC_ASOC_ADIF2_SOURCE);
+	if (cache < 0)
+		return -EIO;
+	if ((cache & 0xff) && (cache & 0xff00)) {
+		set_adif_source(cache, &path_info.adif2[0]);
+		set_adif_source(cache >> 8, &path_info.adif2[1]);
+	}
+
+	err = set_volume(codec, &mixer_info, preset_idx);
+	if (err < 0)
+		return err;
+
+	err = mc_control(MCDRV_SET_PATH, (unsigned long)&path_info, 0);
+	if (err < 0)
+		return err;
+
+	return err;
+}
+
+/*
+ * DAI (PCM interface)
+ */
+static int is_dio_modified(struct mcdrv_dio_port *dio_port,
+			   int id, int mode, u32 update)
+{
+	struct mcdrv_dio_info dio_info;
+	struct mcdrv_dio_common *comm1, *comm2;
+	struct mcdrv_dio_dir *dir1, *dir2;
+	struct mcdrv_dio_dit *dit1, *dit2;
+	int err;
+
+	err = mc_control(MCDRV_GET_DIGITALIO, (unsigned long)&dio_info, 0);
+	if (err < 0)
+		return err;
+
+	comm1 = &dio_info.port[id].dio_common;
+	comm2 = &dio_port->dio_common;
+
+	if (update & (MCDRV_MUSIC_COM_UPDATE_FLAG | MCDRV_EXT_COM_UPDATE_FLAG |
+		      MCDRV_HIFI_COM_UPDATE_FLAG)) {
+		if (comm1->master_slave != comm2->master_slave
+		    || comm1->auto_fs != comm2->auto_fs
+		    || comm1->fs != comm2->fs
+		    || comm1->bck_fs != comm2->bck_fs
+		    || comm1->interface != comm2->interface
+		    || comm1->bck_invert != comm2->bck_invert
+		    || comm1->src_thru != comm2->src_thru)
+			return 1;
+
+		if (mode == MCDRV_DIO_PCM
+		    && (comm1->pcm_hiz_transition != comm2->pcm_hiz_transition
+			|| comm1->pcm_frame != comm2->pcm_frame
+			|| comm1->pcm_high_period != comm2->pcm_high_period))
+			return 1;
+	}
+
+	dir1 = &dio_info.port[id].dir;
+	dir2 = &dio_port->dir;
+
+	if (update
+	    & (MCDRV_MUSIC_DIR_UPDATE_FLAG | MCDRV_HIFI_DIR_UPDATE_FLAG)) {
+		if (mode == MCDRV_DIO_DA
+		    && (dir1->da_format.bit_sel != dir2->da_format.bit_sel
+			|| dir1->da_format.mode != dir2->da_format.mode))
+			return 1;
+
+		if (mode != MCDRV_DIO_DA
+		    && (dir1->pcm_format.mono != dir2->pcm_format.mono
+			|| dir1->pcm_format.order != dir2->pcm_format.order
+			|| dir1->pcm_format.law != dir2->pcm_format.law
+			|| dir1->pcm_format.bit_sel !=
+			dir2->pcm_format.bit_sel))
+			return 1;
+	}
+
+	dit1 = &dio_info.port[id].dit;
+	dit2 = &dio_port->dit;
+
+	if (update & (MCDRV_MUSIC_DIT_UPDATE_FLAG | MCDRV_EXT_DIT_UPDATE_FLAG |
+		      MCDRV_HIFI_DIT_UPDATE_FLAG)) {
+		if (mode == MCDRV_DIO_DA
+		    && (dit1->da_format.bit_sel != dit2->da_format.bit_sel
+			|| dit1->da_format.mode != dit2->da_format.mode))
+			return 1;
+
+		if (mode != MCDRV_DIO_DA
+		    && (dit1->pcm_format.mono != dit2->pcm_format.mono
+			|| dit1->pcm_format.order != dit2->pcm_format.order
+			|| dit1->pcm_format.law != dit2->pcm_format.law
+			|| dit1->pcm_format.bit_sel !=
+			dit2->pcm_format.bit_sel))
+			return 1;
+	}
+
+	return 0;
+}
+
+static int setup_dai(struct snd_soc_codec *codec,
+		     struct mc_asoc_data *mc_asoc, int id, int mode, int dir)
+{
+	struct mcdrv_dio_info dio;
+	struct mcdrv_dio_port *port = &dio.port[id];
+	struct mc_asoc_port_params *port_params = &mc_asoc->port;
+	struct mcdrv_path_info path, tmp_path;
+	u32 update = 0;
+	int ch, err, modify;
+
+	err = mc_control(MCDRV_GET_PATH, (unsigned long)&path, 0);
+	if (err < 0)
+		return err;
+
+	memset(&dio, 0, sizeof(struct mcdrv_dio_info));
+
+	if (port_params->stream == 0) {
+		port->dio_common.master_slave = port_params->master;
+		port->dio_common.auto_fs = MCDRV_AUTOFS_OFF;
+		port->dio_common.fs = port_params->rate;
+		port->dio_common.bck_fs = port_params->bckfs;
+		port->dio_common.interface = mode;
+		port->dio_common.bck_invert = port_params->inv;
+		port->dio_common.src_thru = port_params->srcthru;
+		if (mode == MCDRV_DIO_PCM)
+			port->dio_common.pcm_frame = port_params->format;
+		switch (id) {
+		case 0:
+			update |= MCDRV_MUSIC_COM_UPDATE_FLAG;
+			break;
+		case 1:
+			update |= MCDRV_EXT_COM_UPDATE_FLAG;
+			break;
+		case 3:
+			update |= MCDRV_HIFI_COM_UPDATE_FLAG;
+		default:
+			break;
+		}
+	}
+
+	if (dir == SNDRV_PCM_STREAM_PLAYBACK) {
+		if (mode == MCDRV_DIO_DA) {
+			port->dir.da_format.bit_sel = port_params->bits[dir];
+			port->dir.da_format.mode = port_params->format;
+		} else {
+			port->dir.pcm_format.mono = port_params->pcm_mono[dir];
+			port->dir.pcm_format.order =
+			    port_params->pcm_order[dir];
+			port->dir.pcm_format.law = port_params->pcm_law[dir];
+			port->dir.pcm_format.bit_sel = port_params->bits[dir];
+		}
+
+		switch (id) {
+		case 0:
+			update |= MCDRV_MUSIC_DIR_UPDATE_FLAG;
+			break;
+		case 3:
+			update |= MCDRV_HIFI_DIR_UPDATE_FLAG;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (dir == SNDRV_PCM_STREAM_CAPTURE) {
+		if (mode == MCDRV_DIO_DA) {
+			port->dit.da_format.bit_sel = port_params->bits[dir];
+			port->dit.da_format.mode = port_params->format;
+		} else {
+			port->dit.pcm_format.mono = port_params->pcm_mono[dir];
+			port->dit.pcm_format.order =
+			    port_params->pcm_order[dir];
+			port->dit.pcm_format.law = port_params->pcm_law[dir];
+			port->dit.pcm_format.bit_sel = port_params->bits[dir];
+		}
+
+		switch (id) {
+		case 0:
+			update |= MCDRV_MUSIC_DIT_UPDATE_FLAG;
+			break;
+		case 1:
+			update |= MCDRV_EXT_DIT_UPDATE_FLAG;
+			break;
+		case 3:
+			update |= MCDRV_HIFI_DIT_UPDATE_FLAG;
+			break;
+		default:
+			break;
+		}
+	}
+
+	modify = is_dio_modified(port, id, mode, update);
+	if (modify < 0)
+		return -EIO;
+	if (modify == 0)
+		return 0;
+
+	memcpy(&tmp_path, &path, sizeof(struct mcdrv_path_info));
+	if (dir == SNDRV_PCM_STREAM_PLAYBACK || !port_params->stream) {
+		switch (id) {
+		case 0:
+			for (ch = 0; ch < MUSICOUT_PATH_CHANNELS; ch++) {
+				tmp_path.music_out[ch] &=
+				    ~MCDRV_D1SRC_MUSICIN_ON;
+				tmp_path.music_out[ch] |=
+				    MCDRV_D1SRC_MUSICIN_OFF;
+			}
+
+			for (ch = 0; ch < EXTOUT_PATH_CHANNELS; ch++) {
+				tmp_path.ext_out[ch] &= ~MCDRV_D1SRC_MUSICIN_ON;
+				tmp_path.ext_out[ch] |= MCDRV_D1SRC_MUSICIN_OFF;
+			}
+
+			for (ch = 0; ch < VBOXMIXIN_PATH_CHANNELS; ch++) {
+				tmp_path.vbox_mix_in[ch] &=
+				    ~MCDRV_D1SRC_MUSICIN_ON;
+				tmp_path.vbox_mix_in[ch] |=
+				    MCDRV_D1SRC_MUSICIN_OFF;
+			}
+
+			for (ch = 0; ch < AE_PATH_CHANNELS; ch++) {
+				tmp_path.ae0[ch] &= ~MCDRV_D1SRC_MUSICIN_ON;
+				tmp_path.ae0[ch] |= MCDRV_D1SRC_MUSICIN_OFF;
+				tmp_path.ae1[ch] &= ~MCDRV_D1SRC_MUSICIN_ON;
+				tmp_path.ae1[ch] |= MCDRV_D1SRC_MUSICIN_OFF;
+				tmp_path.ae2[ch] &= ~MCDRV_D1SRC_MUSICIN_ON;
+				tmp_path.ae2[ch] |= MCDRV_D1SRC_MUSICIN_OFF;
+				tmp_path.ae3[ch] &= ~MCDRV_D1SRC_MUSICIN_ON;
+				tmp_path.ae3[ch] |= MCDRV_D1SRC_MUSICIN_OFF;
+			}
+
+			for (ch = 0; ch < DAC0_PATH_CHANNELS; ch++) {
+				tmp_path.dac0[ch] &= ~MCDRV_D1SRC_MUSICIN_ON;
+				tmp_path.dac0[ch] |= MCDRV_D1SRC_MUSICIN_OFF;
+			}
+
+			for (ch = 0; ch < DAC1_PATH_CHANNELS; ch++) {
+				tmp_path.dac1[ch] &= ~MCDRV_D1SRC_MUSICIN_ON;
+				tmp_path.dac1[ch] |= MCDRV_D1SRC_MUSICIN_OFF;
+			}
+			break;
+		case 3:
+			for (ch = 0; ch < DAC0_PATH_CHANNELS; ch++) {
+				tmp_path.dac0[ch] &= ~MCDRV_D1SRC_HIFIIN_ON;
+				tmp_path.dac0[ch] |= MCDRV_D1SRC_HIFIIN_OFF;
+			}
+
+			for (ch = 0; ch < DAC1_PATH_CHANNELS; ch++) {
+				tmp_path.dac1[ch] &= ~MCDRV_D1SRC_HIFIIN_ON;
+				tmp_path.dac1[ch] |= MCDRV_D1SRC_HIFIIN_OFF;
+			}
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (dir == SNDRV_PCM_STREAM_CAPTURE || !port_params->stream) {
+		switch (id) {
+		case 0:
+			for (ch = 0; ch < MUSICOUT_PATH_CHANNELS; ch++)
+				tmp_path.music_out[ch] = 0x00aaaaaa;
+			break;
+		case 1:
+			for (ch = 0; ch < EXTOUT_PATH_CHANNELS; ch++)
+				tmp_path.ext_out[ch] = 0x00aaaaaa;
+			break;
+		case 3:
+			for (ch = 0; ch < HIFIOUT_PATH_CHANNELS; ch++)
+				tmp_path.hifi_out[ch] = 0x00aaaaaa;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (!memcmp(&tmp_path, &path, sizeof(struct mcdrv_path_info)))
+		modify = 0;
+	else {
+		err = mc_control(MCDRV_SET_PATH, (unsigned long)&tmp_path, 0);
+		if (err < 0)
+			return err;
+	}
+
+	err = mc_control(MCDRV_SET_DIGITALIO, (unsigned long)&dio, update);
+	if (err < 0)
+		return err;
+
+	if (modify)
+		return connect_path(codec);
+
+	return 0;
+}
+
+static int mc_asoc_set_clkdiv(struct snd_soc_dai *dai, int div_id, int div)
+{
+	struct mc_asoc_data *mc_asoc;
+	struct mc_asoc_port_params *port;
+
+	if (!dai || !dai->codec || get_port_id(dai->id))
+		return -EINVAL;
+
+	mc_asoc = snd_soc_codec_get_drvdata(dai->codec);
+	if (!mc_asoc)
+		return -EINVAL;
+
+	port = &mc_asoc->port;
+
+	if (div_id == MC_ASOC_BCLK_MULT) {
+		switch (div) {
+		case MC_ASOC_LRCK_X64:
+			port->bckfs = MCDRV_BCKFS_64;
+			break;
+		case MC_ASOC_LRCK_X48:
+			port->bckfs = MCDRV_BCKFS_48;
+			break;
+		case MC_ASOC_LRCK_X32:
+			port->bckfs = MCDRV_BCKFS_32;
+			break;
+		case MC_ASOC_LRCK_X512:
+			port->bckfs = MCDRV_BCKFS_512;
+			break;
+		case MC_ASOC_LRCK_X256:
+			port->bckfs = MCDRV_BCKFS_256;
+			break;
+		case MC_ASOC_LRCK_X192:
+			port->bckfs = MCDRV_BCKFS_192;
+			break;
+		case MC_ASOC_LRCK_X128:
+			port->bckfs = MCDRV_BCKFS_128;
+			break;
+		case MC_ASOC_LRCK_X96:
+			port->bckfs = MCDRV_BCKFS_96;
+			break;
+		case MC_ASOC_LRCK_X24:
+			port->bckfs = MCDRV_BCKFS_24;
+			break;
+		case MC_ASOC_LRCK_X16:
+			port->bckfs = MCDRV_BCKFS_16;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int mc_asoc_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct mc_asoc_data *mc_asoc;
+	struct mc_asoc_port_params *port;
+
+	if (!dai || !dai->codec || get_port_id(dai->id))
+		return -EINVAL;
+
+	mc_asoc = snd_soc_codec_get_drvdata(dai->codec);
+	if (!mc_asoc)
+		return -EINVAL;
+
+	port = &mc_asoc->port;
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		port->format = MCDRV_DAMODE_I2S;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		port->format = MCDRV_DAMODE_TAILALIGN;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		port->format = MCDRV_DAMODE_HEADALIGN;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		port->format = MCDRV_PCM_SHORTFRAME;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		port->format = MCDRV_PCM_LONGFRAME;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		port->master = MCDRV_DIO_MASTER;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		port->master = MCDRV_DIO_SLAVE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		port->inv = MCDRV_BCLK_NORMAL;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		port->inv = MCDRV_BCLK_INVERT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mc_asoc_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec;
+	struct mc_asoc_data *mc_asoc;
+	struct mc_asoc_port_params *port;
+	struct mcdrv_dio_path_info dio_path;
+	int dir = substream->stream;
+	int id, rate, err = 0;
+
+	if (!substream || !dai)
+		return -EINVAL;
+
+	id = get_port_id(dai->id);
+	if (id)
+		return -EINVAL;
+
+	codec = dai->codec;
+	if (!codec)
+		return -EINVAL;
+
+	mc_asoc = snd_soc_codec_get_drvdata(codec);
+	if (!mc_asoc)
+		return -EINVAL;
+
+	port = &mc_asoc->port;
+
+	switch (params_channels(params)) {
+	case 1:
+		port->pcm_mono[dir] = MCDRV_PCM_MONO;
+		port->channels = MCDRV_MUSIC_2CH;
+		break;
+	case 2:
+		port->channels = MCDRV_MUSIC_2CH;
+		port->pcm_mono[dir] = MCDRV_PCM_STEREO;
+		break;
+	case 4:
+		port->channels = MCDRV_MUSIC_4CH;
+		port->pcm_mono[dir] = MCDRV_PCM_STEREO;
+		break;
+	case 6:
+		port->channels = MCDRV_MUSIC_6CH;
+		port->pcm_mono[dir] = MCDRV_PCM_STEREO;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		port->bits[dir] = MCDRV_BITSEL_16;
+		break;
+	case SNDRV_PCM_FORMAT_S20_3LE:
+		port->bits[dir] = MCDRV_BITSEL_20;
+		break;
+	case SNDRV_PCM_FORMAT_S24_3LE:
+		port->bits[dir] = MCDRV_BITSEL_24;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (dir == SNDRV_PCM_STREAM_PLAYBACK) {
+		port->pcm_order[dir] = music_port_def.dir.pcm_format.order;
+		port->pcm_law[dir] = music_port_def.dir.pcm_format.law;
+	} else {
+		port->pcm_order[dir] = music_port_def.dit.pcm_format.order;
+		port->pcm_law[dir] = music_port_def.dit.pcm_format.law;
+	}
+
+	switch (params_rate(params)) {
+	case 8000:
+		rate = MCDRV_FS_8000;
+		break;
+	case 11025:
+		rate = MCDRV_FS_11025;
+		break;
+	case 16000:
+		rate = MCDRV_FS_16000;
+		break;
+	case 22050:
+		rate = MCDRV_FS_22050;
+		break;
+	case 32000:
+		rate = MCDRV_FS_32000;
+		break;
+	case 44100:
+		rate = MCDRV_FS_44100;
+		break;
+	case 48000:
+		rate = MCDRV_FS_48000;
+		break;
+	case 96000:
+		rate = MCDRV_FS_96000;
+		break;
+	case 192000:
+		rate = MCDRV_FS_192000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mutex_lock(&mc_asoc->mutex);
+
+	if (CAPTURE_PORT == CAPTURE_PORT_MUSIC)
+		if ((port->stream & ~(1 << dir)) && rate != port->rate) {
+			err = -EBUSY;
+			goto error;
+		}
+
+	port->rate = rate;
+
+	if (rate == MCDRV_FS_96000 || rate == MCDRV_FS_192000) {
+		struct mixer_path_ctl_info mixer_info;
+		int preset_idx;
+
+		if (get_mixer_path_ctl_info(codec, &mixer_info) < 0) {
+			err = -EIO;
+			goto error;
+		}
+
+		preset_idx = get_path_preset_idx(&mixer_info);
+		if (is_incall(preset_idx) || is_incommunication(preset_idx)) {
+			err = -EINVAL;
+			goto error;
+		}
+	}
+
+	if (rate == MCDRV_FS_96000 || rate == MCDRV_FS_192000) {
+		id = 3;
+	} else {
+		dio_path.music_ch = port->channels;
+		err = mc_control(MCDRV_SET_DIGITALIO_PATH,
+				 (unsigned long)&dio_path,
+				 MCDRV_MUSICNUM_UPDATE_FLAG);
+		if (err < 0) {
+			dev_err(codec->dev,
+				"Error in MCDRV_SET_DIGITALIO_PATH: %d\n", err);
+			goto error;
+		}
+
+		if (dir == SNDRV_PCM_STREAM_CAPTURE
+		    && CAPTURE_PORT == CAPTURE_PORT_EXT)
+			id = 1;
+	}
+
+	err = setup_dai(codec, mc_asoc, id, MCDRV_DIO_DA, dir);
+	if (err < 0) {
+		dev_err(codec->dev, "Error in setup_dai: %d\n", err);
+		goto error;
+	}
+
+	port->stream |= 1 << dir;
+	mc_asoc_rate = rate;
+
+error:
+	mutex_unlock(&mc_asoc->mutex);
+
+	return err;
+}
+
+static int mc_asoc_hw_free(struct snd_pcm_substream *substream,
+			   struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec;
+	struct mc_asoc_data *mc_asoc;
+	struct mc_asoc_port_params *port;
+	int dir = substream->stream;
+
+	if (!substream || !dai || get_port_id(dai->id))
+		return -EINVAL;
+
+	codec = dai->codec;
+	if (!codec)
+		return -EINVAL;
+
+	mc_asoc = snd_soc_codec_get_drvdata(codec);
+	if (!mc_asoc)
+		return -EINVAL;
+
+	port = &mc_asoc->port;
+
+	mutex_lock(&mc_asoc->mutex);
+
+	if (port->stream & (1 << dir))
+		port->stream &= ~(1 << dir);
+
+	mutex_unlock(&mc_asoc->mutex);
+
+	return 0;
+}
+
+static struct snd_soc_dai_ops mc_asoc_dai_ops[] = {
+	{
+	 .set_clkdiv = mc_asoc_set_clkdiv,
+	 .set_fmt = mc_asoc_set_fmt,
+	 .hw_params = mc_asoc_hw_params,
+	 .hw_free = mc_asoc_hw_free,
+	 },
+};
+
+static struct snd_soc_dai_driver mc_asoc_dai[] = {
+	{
+	 .name = MC_ASOC_NAME "-da0",
+	 .id = 1,
+	 .playback = {
+		      .stream_name = "Playback",
+		      .channels_min = 1,
+		      .channels_max = 6,
+		      .rates = MC_ASOC_RATE,
+		      .formats = MC_ASOC_FORMATS,
+		      },
+	 .capture = {
+		     .stream_name = "Capture",
+		     .channels_min = 1,
+		     .channels_max = 2,
+		     .rates = MC_ASOC_RATE,
+		     .formats = MC_ASOC_FORMATS,
+		     },
+	 .ops = &mc_asoc_dai_ops[0]
+	 },
+};
+
+/*
+ * Control interface
+ */
+/*
+ * Virtual register
+ *
+ * 16bit software registers are implemented for volumes and mute
+ * switches (as an exception, no mute switches for MIC and HP gain).
+ * Register contents are stored in codec's register cache.
+ *
+ *	15	14			8	7			0
+ *	+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
+ *	|swR|	volume-R		|swL|	volume-L		|
+ *	+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
+ */
+
+static unsigned int mc_asoc_read_reg(struct snd_soc_codec *codec,
+				     unsigned int reg)
+{
+	int ret;
+
+	if (!codec)
+		return -EINVAL;
+
+	ret = read_cache(codec, reg);
+	if (ret < 0)
+		return -EIO;
+
+	return (unsigned int)ret;
+}
+
+static int write_reg_vol(struct snd_soc_codec *codec, unsigned int reg,
+			 unsigned int value)
+{
+	struct mcdrv_vol_info vol;
+	struct mixer_path_ctl_info mixer;
+	int err, preset_idx;
+
+	err = snd_soc_cache_write(codec, reg, value);
+	if (err < 0)
+		dev_err(codec->dev, "Cache write to 0x%x failed: %d\n", reg,
+			err);
+
+	if (get_mixer_path_ctl_info(codec, &mixer) < 0)
+		return -EIO;
+
+	preset_idx = get_path_preset_idx(&mixer);
+	if (preset_idx < 0 || preset_idx > PRESET_PATH_N)
+		return -EIO;
+
+	memset(&vol, 0, sizeof(struct mcdrv_vol_info));
+
+	switch (reg) {
+	case MC_ASOC_AVOL_SP_GAIN:
+		if (!mc_asoc_ver_id) {
+			vreg_map[MC_ASOC_AVOL_SP].volmap = volmap_sp[value];
+			reg = MC_ASOC_AVOL_SP;
+		} else
+			return 0;
+		break;
+	case MC_ASOC_DVOL_MASTER:
+		if (mc_asoc_audio_play_port == LIN1)
+			reg = MC_ASOC_DVOL_ADIF1IN;
+		else
+			reg = MC_ASOC_DVOL_MUSICIN;
+		break;
+	case MC_ASOC_DVOL_VOICE:
+		if (is_incall(preset_idx)) {
+			reg = MC_ASOC_DVOL_VOICEIN;
+			if (mc_asoc_voice_port == LIN1_LOUT1
+			    || mc_asoc_voice_port == LIN1_LOUT2)
+				reg = MC_ASOC_AVOL_LINEIN1;
+		} else
+			return 0;
+		break;
+	case MC_ASOC_DVOL_APLAY_A:
+		reg = MC_ASOC_AVOL_MIC1;
+		err = set_vol_info(codec, &vol, reg, &mixer, preset_idx);
+		if (err < 0)
+			return err;
+
+		reg = MC_ASOC_AVOL_MIC2;
+		err = set_vol_info(codec, &vol, reg, &mixer, preset_idx);
+		if (err < 0)
+			return err;
+
+		reg = MC_ASOC_AVOL_MIC3;
+		err = set_vol_info(codec, &vol, reg, &mixer, preset_idx);
+		if (err < 0)
+			return err;
+
+		reg = MC_ASOC_AVOL_MIC4;
+		err = set_vol_info(codec, &vol, reg, &mixer, preset_idx);
+		if (err < 0)
+			return err;
+
+		reg = MC_ASOC_AVOL_LINEIN1;
+		break;
+	case MC_ASOC_DVOL_APLAY_D:
+		reg = MC_ASOC_DVOL_ADIF1IN;
+		break;
+	case MC_ASOC_VOICE_RECORDING:
+		if (is_incall(preset_idx)) {
+			reg = MC_ASOC_DVOL_VOICEOUT;
+			if (mc_asoc_voice_port == LIN1_LOUT1)
+				reg = MC_ASOC_DVOL_DAC0OUT;
+			else if (mc_asoc_voice_port == LIN1_LOUT2)
+				reg = MC_ASOC_DVOL_DAC1OUT;
+		} else if (is_incommunication(preset_idx))
+			reg = MC_ASOC_DVOL_VOICEOUT;
+		else
+			return 0;
+		break;
+	default:
+		break;
+	}
+
+	err = set_vol_info(codec, &vol, reg, &mixer, preset_idx);
+	if (err < 0)
+		return err;
+
+	err = mc_control(MCDRV_SET_VOLUME, (unsigned long)&vol, 0);
+	if (err < 0) {
+		dev_err(codec->dev, "Error in MCDRV_SET_VOLUME: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static void auto_powerdown(struct snd_soc_codec *codec)
+{
+#if (AUTO_POWEROFF == AUTO_POWEROFF_ON)
+	struct mixer_path_ctl_info mixer;
+	u8 aec[] = {
+		0x41, 0x45, 0x43,
+		0x05,
+		0, 0, 0, 60,
+		0x00,
+		253,
+		0,
+		0,
+		/*      D7:     */
+		0x44, 0x37,
+		0, 0, 0, 50,
+		/*      AudioEngine:16  */
+		0x02, 0x00, 0x00, 0x00,
+		0, 0, 0, 8,
+		0,
+		0,
+		0,
+		0,
+		0,
+		0,
+		0,
+		0,
+		/*      V-BOX:23        */
+		0x03, 0x00, 0x00, 0x00,
+		0, 0, 0, 15,
+		0,
+		0,
+		0,
+		0,
+		0,
+		0,
+		0,
+		0,
+		0,
+		0,
+		0,
+		0,
+		0,
+		0,
+		0,
+		/*      E-DSP:11        */
+		0x07, 0x00, 0x00, 0x00,
+		0, 0, 0, 3,
+		0,
+		0,
+		0,
+	};
+
+	get_mixer_path_ctl_info(codec, &mixer);
+	if (!mixer.audio_mode_play && !mixer.audio_mode_cap
+	    && !mixer.mainmic_play && !mixer.submic_play
+	    && !mixer.msmic_play && !mixer.hsmic_play
+	    && !mixer.btmic_play && !mixer.lin1_play && !mixer.dtmf_control)
+		mc_control(MCDRV_SET_DSP, (unsigned long)aec, sizeof(aec));
+#endif
+}
+
+static void del_dsp_param(struct mc_asoc_data *mc_asoc)
+{
+	struct mc_asoc_dsp_params *dsp_params, *next;
+	int i, j;
+
+	for (i = 0; i <= DSP_PRM_VC_2MIC; i++) {
+		for (j = 0; j <= DSP_PRM_USER; j++) {
+			kfree(mc_asoc->params_store[i][j].pab_param);
+
+			dsp_params = mc_asoc->params_store[i][j].next;
+			while (dsp_params) {
+				kfree(dsp_params->pab_param);
+				next = dsp_params->next;
+				kfree(dsp_params);
+				dsp_params = next;
+			}
+
+			mc_asoc->params_store[i][j].pab_param = NULL;
+			mc_asoc->params_store[i][j].size = 0;
+			mc_asoc->params_store[i][j].next = NULL;
+		}
+	}
+}
+
+static int set_audio_mode_play(struct snd_soc_codec *codec, unsigned int value)
+{
+	struct mc_asoc_data *mc_asoc;
+	struct mc_asoc_port_params *port;
+	int ret;
+
+	mc_asoc = snd_soc_codec_get_drvdata(codec);
+	if (!mc_asoc)
+		return -EINVAL;
+
+	port = &mc_asoc->port;
+	if (value > 1) {
+		u8 rate = port->rate;
+		if (port->stream
+		    && (rate == MCDRV_FS_96000 || rate == MCDRV_FS_192000))
+			return -EINVAL;
+	}
+
+	ret = snd_soc_cache_write(codec, MC_ASOC_AUDIO_MODE_PLAY, value);
+	if (ret < 0)
+		return ret;
+
+	if (!value)
+		del_dsp_param(mc_asoc);
+
+	ret = connect_path(codec);
+	if (!value)
+		auto_powerdown(codec);
+
+	return ret;
+}
+
+static int set_audio_mode_cap(struct snd_soc_codec *codec, unsigned int value)
+{
+	struct mc_asoc_data *mc_asoc;
+	struct mc_asoc_port_params *port;
+	int ret;
+
+	mc_asoc = snd_soc_codec_get_drvdata(codec);
+	if (!mc_asoc)
+		return -EINVAL;
+
+	port = &mc_asoc->port;
+	if (value > 1) {
+		u8 rate = port->rate;
+		if (port->stream
+		    && (rate == MCDRV_FS_96000 || rate == MCDRV_FS_192000))
+			return -EINVAL;
+	}
+
+	ret = snd_soc_cache_write(codec, MC_ASOC_AUDIO_MODE_CAP, value);
+	if (ret < 0)
+		return ret;
+
+	if (!value)
+		del_dsp_param(mc_asoc);
+
+	ret = connect_path(codec);
+	if (!value)
+		auto_powerdown(codec);
+
+	return ret;
+}
+
+static int set_incall_mic(struct snd_soc_codec *codec,
+			  unsigned int reg, unsigned int value)
+{
+	struct mc_asoc_data *mc_asoc;
+	struct mc_asoc_dsp_params *dsp_params;
+	int ret;
+
+	mc_asoc = snd_soc_codec_get_drvdata(codec);
+	if (!mc_asoc)
+		return -EINVAL;
+
+	ret = snd_soc_cache_write(codec, reg, value);
+	if (ret < 0)
+		return ret;
+
+	if (value == MC_ASOC_INCALL_MIC_MAINMIC
+	    || value == MC_ASOC_INCALL_MIC_SUBMIC)
+		dsp_params =
+		    &mc_asoc->params_store[DSP_PRM_VC_1MIC][DSP_PRM_BASE];
+	else
+		dsp_params =
+		    &mc_asoc->params_store[DSP_PRM_VC_2MIC][DSP_PRM_BASE];
+
+	while (dsp_params) {
+		if (dsp_params->size > 0) {
+			ret = mc_control(MCDRV_SET_DSP,
+					 (unsigned long)dsp_params->pab_param,
+					 dsp_params->size);
+			if (ret < 0)
+				return ret;
+		}
+
+		dsp_params = dsp_params->next;
+	}
+
+	return connect_path(codec);
+}
+
+static int set_ain_playback(struct snd_soc_codec *codec,
+			    unsigned int reg, unsigned int value)
+{
+	int audio_mode, audio_mode_cap, ret;
+
+	audio_mode_cap = read_cache(codec, MC_ASOC_AUDIO_MODE_CAP);
+	if (audio_mode_cap < 0)
+		return -EIO;
+
+	audio_mode = read_cache(codec, MC_ASOC_AUDIO_MODE_PLAY);
+	if (audio_mode < 0)
+		return -EIO;
+
+	ret = snd_soc_cache_write(codec, reg, value);
+	if (ret < 0)
+		return ret;
+
+	if (audio_mode == MC_ASOC_AUDIO_MODE_INCALL
+	    || audio_mode == MC_ASOC_AUDIO_MODE_INCALL2
+	    || audio_mode == MC_ASOC_AUDIO_MODE_AUDIO_INCALL
+	    || audio_mode == MC_ASOC_AUDIO_MODE_AUDIO_INCALL2) {
+		if (audio_mode_cap == MC_ASOC_AUDIO_MODE_INCALL
+		    || audio_mode_cap == MC_ASOC_AUDIO_MODE_AUDIO_INCALL)
+			return 0;
+	}
+
+	if ((audio_mode == MC_ASOC_AUDIO_MODE_INCOMM
+	     || audio_mode == MC_ASOC_AUDIO_MODE_INCOMM2)
+	    && audio_mode_cap == MC_ASOC_AUDIO_MODE_INCOMM)
+		return 0;
+
+	ret = connect_path(codec);
+	if (!value)
+		auto_powerdown(codec);
+
+	return ret;
+}
+
+static int set_dtmf_control(struct snd_soc_codec *codec,
+			    unsigned int reg, unsigned int value)
+{
+	int ret;
+
+	ret = snd_soc_cache_write(codec, reg, value);
+	if (ret < 0)
+		return ret;
+
+	ret = connect_path(codec);
+	if (!value)
+		auto_powerdown(codec);
+
+	return ret;
+}
+
+static int set_dtmf_output(struct snd_soc_codec *codec,
+			   unsigned int reg, unsigned int value)
+{
+	int ret;
+
+	ret = snd_soc_cache_write(codec, reg, value);
+	if (ret < 0)
+		return ret;
+
+	return connect_path(codec);
+}
+
+static int set_switch_clock(struct snd_soc_codec *codec,
+			    unsigned int reg, unsigned int value)
+{
+	int ret;
+
+	ret = mc_control(MCDRV_SET_CLOCKSW, value, 0);
+	if (ret < 0)
+		return ret;
+
+	return snd_soc_cache_write(codec, reg, value);
+}
+
+static int set_master_slave(struct snd_soc_codec *codec,
+			    unsigned int reg, unsigned int value, u8 port)
+{
+	struct mcdrv_dio_info dio;
+	u32 flag;
+	int ret;
+
+	ret = mc_control(MCDRV_GET_DIGITALIO, (unsigned long)&dio, 0);
+	if (ret < 0)
+		return ret;
+
+	dio.port[port].dio_common.master_slave = value;
+	if (port == 1)
+		flag = MCDRV_EXT_COM_UPDATE_FLAG;
+	else
+		flag = MCDRV_VOICE_COM_UPDATE_FLAG;
+
+	ret = mc_control(MCDRV_SET_DIGITALIO, (unsigned long)&dio, flag);
+	if (ret < 0)
+		return ret;
+
+	return snd_soc_cache_write(codec, reg, value);
+}
+
+static int set_rate(struct snd_soc_codec *codec,
+		    unsigned int reg, unsigned int value, u8 port)
+{
+	struct mcdrv_dio_info dio;
+	u32 flag;
+	int ret;
+
+	ret = mc_control(MCDRV_GET_DIGITALIO, (unsigned long)&dio, 0);
+	if (ret < 0)
+		return ret;
+
+	dio.port[port].dio_common.fs = value;
+	if (port == 1)
+		flag = MCDRV_EXT_COM_UPDATE_FLAG;
+	else
+		flag = MCDRV_VOICE_COM_UPDATE_FLAG;
+
+	ret = mc_control(MCDRV_SET_DIGITALIO, (unsigned long)&dio, flag);
+	if (ret < 0)
+		return ret;
+
+	return snd_soc_cache_write(codec, reg, value);
+}
+
+static int set_bitclock_rate(struct snd_soc_codec *codec,
+			     unsigned int reg, unsigned int value, u8 port)
+{
+	struct mcdrv_dio_info dio;
+	u32 flag;
+	int ret;
+
+	ret = mc_control(MCDRV_GET_DIGITALIO, (unsigned long)&dio, 0);
+	if (ret < 0)
+		return ret;
+
+	dio.port[port].dio_common.bck_fs = value;
+	if (port == 1)
+		flag = MCDRV_EXT_COM_UPDATE_FLAG;
+	else
+		flag = MCDRV_VOICE_COM_UPDATE_FLAG;
+
+	ret = mc_control(MCDRV_SET_DIGITALIO, (unsigned long)&dio, flag);
+	if (ret < 0)
+		return ret;
+
+	return snd_soc_cache_write(codec, reg, value);
+}
+
+static int set_interface(struct snd_soc_codec *codec,
+			 unsigned int reg, unsigned int value, u8 port)
+{
+	struct mcdrv_dio_info dio;
+	u32 flag;
+	int ret;
+
+	ret = mc_control(MCDRV_GET_DIGITALIO, (unsigned long)&dio, 0);
+	if (ret < 0)
+		return ret;
+
+	dio.port[port].dio_common.interface = value;
+	if (port == 1)
+		flag = MCDRV_EXT_COM_UPDATE_FLAG;
+	else
+		flag = MCDRV_VOICE_COM_UPDATE_FLAG;
+
+	ret = mc_control(MCDRV_SET_DIGITALIO, (unsigned long)&dio, flag);
+	if (ret < 0)
+		return ret;
+
+	return snd_soc_cache_write(codec, reg, value);
+}
+
+static int set_bitclock_invert(struct snd_soc_codec *codec,
+			       unsigned int reg, unsigned int value, u8 port)
+{
+	struct mcdrv_dio_info dio;
+	u32 flag;
+	int ret;
+
+	ret = mc_control(MCDRV_GET_DIGITALIO, (unsigned long)&dio, 0);
+	if (ret < 0)
+		return ret;
+
+	dio.port[port].dio_common.bck_invert = value;
+	if (port == 1)
+		flag = MCDRV_EXT_COM_UPDATE_FLAG;
+	else
+		flag = MCDRV_VOICE_COM_UPDATE_FLAG;
+
+	ret = mc_control(MCDRV_SET_DIGITALIO, (unsigned long)&dio, flag);
+	if (ret < 0)
+		return ret;
+
+	return snd_soc_cache_write(codec, reg, value);
+}
+
+static int set_da_bit_width(struct snd_soc_codec *codec,
+			    unsigned int reg, unsigned int value,
+			    u8 port, u8 in_out)
+{
+	struct mcdrv_dio_info dio;
+	u32 flag;
+	int ret;
+
+	ret = mc_control(MCDRV_GET_DIGITALIO, (unsigned long)&dio, 0);
+	if (ret < 0)
+		return ret;
+
+	if (!in_out)
+		dio.port[port].dir.da_format.bit_sel = value;
+	else
+		dio.port[port].dit.da_format.bit_sel = value;
+
+	if (port == 1)
+		flag = MCDRV_EXT_DIR_UPDATE_FLAG | MCDRV_EXT_DIT_UPDATE_FLAG;
+	else
+		flag = MCDRV_VOICE_DIR_UPDATE_FLAG
+		    | MCDRV_VOICE_DIT_UPDATE_FLAG;
+
+	ret = mc_control(MCDRV_SET_DIGITALIO, (unsigned long)&dio, flag);
+	if (ret < 0)
+		return ret;
+
+	return snd_soc_cache_write(codec, reg, value);
+}
+
+static int set_da_format(struct snd_soc_codec *codec,
+			 unsigned int reg, unsigned int value,
+			 u8 port, u8 in_out)
+{
+	struct mcdrv_dio_info dio;
+	u32 flag;
+	int ret;
+
+	ret = mc_control(MCDRV_GET_DIGITALIO, (unsigned long)&dio, 0);
+	if (ret < 0)
+		return ret;
+
+	if (!in_out)
+		dio.port[port].dir.da_format.mode = value;
+	else
+		dio.port[port].dit.da_format.mode = value;
+
+	if (port == 1)
+		flag = MCDRV_EXT_DIR_UPDATE_FLAG | MCDRV_EXT_DIT_UPDATE_FLAG;
+	else
+		flag = MCDRV_VOICE_DIR_UPDATE_FLAG
+		    | MCDRV_VOICE_DIT_UPDATE_FLAG;
+
+	ret = mc_control(MCDRV_SET_DIGITALIO, (unsigned long)&dio, flag);
+	if (ret < 0)
+		return ret;
+
+	return snd_soc_cache_write(codec, reg, value);
+}
+
+static int set_pcm_mono_stereo(struct snd_soc_codec *codec,
+			       unsigned int reg, unsigned int value,
+			       u8 port, u8 in_out)
+{
+	struct mcdrv_dio_info dio;
+	u32 flag;
+	int ret;
+
+	ret = mc_control(MCDRV_GET_DIGITALIO, (unsigned long)&dio, 0);
+	if (ret < 0)
+		return ret;
+
+	if (!in_out)
+		dio.port[port].dir.pcm_format.mono = value;
+	else
+		dio.port[port].dit.pcm_format.mono = value;
+
+	if (port == 1)
+		flag = MCDRV_EXT_DIR_UPDATE_FLAG | MCDRV_EXT_DIT_UPDATE_FLAG;
+	else
+		flag = MCDRV_VOICE_DIR_UPDATE_FLAG
+		    | MCDRV_VOICE_DIT_UPDATE_FLAG;
+
+	ret = mc_control(MCDRV_SET_DIGITALIO, (unsigned long)&dio, flag);
+	if (ret < 0)
+		return ret;
+
+	return snd_soc_cache_write(codec, reg, value);
+}
+
+static int set_pcm_bit_order(struct snd_soc_codec *codec,
+			     unsigned int reg, unsigned int value,
+			     u8 port, u8 in_out)
+{
+	struct mcdrv_dio_info dio;
+	u32 flag;
+	int ret;
+
+	ret = mc_control(MCDRV_GET_DIGITALIO, (unsigned long)&dio, 0);
+	if (ret < 0)
+		return ret;
+
+	if (!in_out)
+		dio.port[port].dir.pcm_format.order = value;
+	else
+		dio.port[port].dit.pcm_format.order = value;
+
+	if (port == 1)
+		flag = MCDRV_EXT_DIR_UPDATE_FLAG | MCDRV_EXT_DIT_UPDATE_FLAG;
+	else
+		flag = MCDRV_VOICE_DIR_UPDATE_FLAG
+		    | MCDRV_VOICE_DIT_UPDATE_FLAG;
+
+	ret = mc_control(MCDRV_SET_DIGITALIO, (unsigned long)&dio, flag);
+	if (ret < 0)
+		return ret;
+
+	return snd_soc_cache_write(codec, reg, value);
+}
+
+static int set_pcm_format(struct snd_soc_codec *codec,
+			  unsigned int reg, unsigned int value,
+			  u8 port, u8 in_out)
+{
+	struct mcdrv_dio_info dio;
+	u32 flag;
+	int ret;
+
+	ret = mc_control(MCDRV_GET_DIGITALIO, (unsigned long)&dio, 0);
+	if (ret < 0)
+		return ret;
+
+	if (!in_out)
+		dio.port[port].dir.pcm_format.law = value;
+	else
+		dio.port[port].dit.pcm_format.law = value;
+
+	if (port == 1)
+		flag = MCDRV_EXT_DIR_UPDATE_FLAG | MCDRV_EXT_DIT_UPDATE_FLAG;
+	else
+		flag = MCDRV_VOICE_DIR_UPDATE_FLAG
+		    | MCDRV_VOICE_DIT_UPDATE_FLAG;
+
+	ret = mc_control(MCDRV_SET_DIGITALIO, (unsigned long)&dio, flag);
+	if (ret < 0)
+		return ret;
+
+	return snd_soc_cache_write(codec, reg, value);
+}
+
+static int set_pcm_bit_width(struct snd_soc_codec *codec,
+			     unsigned int reg, unsigned int value,
+			     u8 port, u8 in_out)
+{
+	struct mcdrv_dio_info dio;
+	u32 flag;
+	int ret;
+
+	ret = mc_control(MCDRV_GET_DIGITALIO, (unsigned long)&dio, 0);
+	if (ret < 0)
+		return ret;
+
+	if (!in_out)
+		dio.port[port].dir.pcm_format.bit_sel = value;
+	else
+		dio.port[port].dit.pcm_format.bit_sel = value;
+
+	if (port == 1)
+		flag = MCDRV_EXT_DIR_UPDATE_FLAG | MCDRV_EXT_DIT_UPDATE_FLAG;
+	else
+		flag = MCDRV_VOICE_DIR_UPDATE_FLAG
+		    | MCDRV_VOICE_DIT_UPDATE_FLAG;
+
+	ret = mc_control(MCDRV_SET_DIGITALIO, (unsigned long)&dio, flag);
+	if (ret < 0)
+		return ret;
+
+	return snd_soc_cache_write(codec, reg, value);
+}
+
+static int set_phys_port(struct snd_soc_codec *codec,
+			 unsigned int reg, unsigned int value, u8 port)
+{
+	struct mcdrv_dio_path_info info;
+	int ret;
+
+	info.phys_port[port] = value;
+	ret =
+	    mc_control(MCDRV_SET_DIGITALIO_PATH, (unsigned long)&info,
+		       1 << port);
+	if (ret < 0)
+		return ret;
+
+	return snd_soc_cache_write(codec, reg, value);
+}
+
+static int set_swap(struct snd_soc_codec *codec,
+		    unsigned int reg, unsigned int value,
+		    size_t offset, u32 flag)
+{
+	struct mcdrv_swap_info swap;
+	int ret;
+
+	*(u8 *) ((void *)&swap + offset) = value;
+	ret = mc_control(MCDRV_SET_SWAP, (unsigned long)&swap, flag);
+	if (ret < 0)
+		return ret;
+
+	return snd_soc_cache_write(codec, reg, value);
+}
+
+static int mc_asoc_write_reg(struct snd_soc_codec *codec,
+			     unsigned int reg, unsigned int value)
+{
+	int err = 0;
+
+	if (!codec)
+		return -EINVAL;
+
+	if (reg <= MC_ASOC_N_VOL_REG) {
+		switch (reg) {
+		case MC_ASOC_DVOL_MUSICIN:
+		case MC_ASOC_DVOL_EXTIN:
+		case MC_ASOC_DVOL_VOICEIN:
+		case MC_ASOC_DVOL_REFIN:
+		case MC_ASOC_DVOL_ADIF0IN:
+		case MC_ASOC_DVOL_ADIF1IN:
+		case MC_ASOC_DVOL_ADIF2IN:
+		case MC_ASOC_DVOL_MUSICOUT:
+		case MC_ASOC_DVOL_EXTOUT:
+		case MC_ASOC_DVOL_VOICEOUT:
+		case MC_ASOC_DVOL_REFOUT:
+		case MC_ASOC_DVOL_DAC0OUT:
+		case MC_ASOC_DVOL_DAC1OUT:
+		case MC_ASOC_DVOL_DPATHDA:
+		case MC_ASOC_DVOL_DPATHAD:
+		case MC_ASOC_DVOL_APLAY_D:
+			if (((value >> 8) & 0x7f) > 114 || (value & 0x7f) > 114)
+				return -EINVAL;
+			break;
+		case MC_ASOC_AVOL_LINEIN1:
+		case MC_ASOC_AVOL_MIC1:
+		case MC_ASOC_AVOL_MIC2:
+		case MC_ASOC_AVOL_MIC3:
+		case MC_ASOC_AVOL_MIC4:
+		case MC_ASOC_DVOL_APLAY_A:
+			if (((value >> 8) & 0x7f) > 63 || (value & 0x7f) > 63)
+				return -EINVAL;
+			break;
+		case MC_ASOC_AVOL_HP:
+			if (((value >> 8) & 0x7f) > 127 || (value & 0x7f) > 127)
+				return -EINVAL;
+			break;
+		case MC_ASOC_AVOL_SP:
+			if (((value >> 8) & 0x7f) > 127 || (value & 0x7f) > 127)
+				return -EINVAL;
+			break;
+		case MC_ASOC_AVOL_RC:
+			if (((value >> 8) & 0x7f) > 111 || (value & 0x7f) > 111)
+				return -EINVAL;
+			break;
+		case MC_ASOC_AVOL_LINEOUT1:
+		case MC_ASOC_AVOL_LINEOUT2:
+			if (((value >> 8) & 0x7f) > 119 || (value & 0x7f) > 119)
+				return -EINVAL;
+			break;
+		case MC_ASOC_AVOL_SP_GAIN:
+			if (((value >> 8) & 0x7f) > 4 || (value & 0x7f) > 4)
+				return -EINVAL;
+			break;
+		case MC_ASOC_DVOL_MASTER:
+		case MC_ASOC_DVOL_VOICE:
+			if (((value >> 8) & 0x7f) > 75 || (value & 0x7f) > 75)
+				return -EINVAL;
+			break;
+		case MC_ASOC_VOICE_RECORDING:
+			if ((value & 0x7f) > 1)
+				return -EINVAL;
+			break;
+		}
+
+		if (!err)
+			err = write_reg_vol(codec, reg, value);
+	} else {
+		switch (reg) {
+		case MC_ASOC_AUDIO_MODE_PLAY:
+			err = set_audio_mode_play(codec, value);
+			break;
+		case MC_ASOC_AUDIO_MODE_CAP:
+			err = set_audio_mode_cap(codec, value);
+			break;
+		case MC_ASOC_OUTPUT_PATH:
+			err = snd_soc_cache_write(codec, reg, value);
+			break;
+		case MC_ASOC_INPUT_PATH:
+			err = snd_soc_cache_write(codec, reg, value);
+			break;
+		case MC_ASOC_INCALL_MIC_SP:
+		case MC_ASOC_INCALL_MIC_RC:
+		case MC_ASOC_INCALL_MIC_HP:
+		case MC_ASOC_INCALL_MIC_LO1:
+		case MC_ASOC_INCALL_MIC_LO2:
+			err = set_incall_mic(codec, reg, value);
+			break;
+		case MC_ASOC_MAINMIC_PLAYBACK_PATH:
+		case MC_ASOC_SUBMIC_PLAYBACK_PATH:
+		case MC_ASOC_2MIC_PLAYBACK_PATH:
+		case MC_ASOC_HSMIC_PLAYBACK_PATH:
+		case MC_ASOC_BTMIC_PLAYBACK_PATH:
+		case MC_ASOC_LIN1_PLAYBACK_PATH:
+			err = set_ain_playback(codec, reg, value);
+			break;
+		case MC_ASOC_PARAMETER_SETTING:
+			break;
+		case MC_ASOC_DTMF_CONTROL:
+			err = set_dtmf_control(codec, reg, value);
+			break;
+		case MC_ASOC_DTMF_OUTPUT:
+			err = set_dtmf_output(codec, reg, value);
+			break;
+		case MC_ASOC_SWITCH_CLOCK:
+			err = set_switch_clock(codec, reg, value);
+			break;
+		case MC_ASOC_EXT_MASTERSLAVE:
+			if (CAPTURE_PORT != CAPTURE_PORT_EXT)
+				err = set_master_slave(codec, reg, value,
+						       PORT_EXT);
+			break;
+		case MC_ASOC_EXT_RATE:
+			if (CAPTURE_PORT != CAPTURE_PORT_EXT)
+				err = set_rate(codec, reg, value, PORT_EXT);
+			break;
+		case MC_ASOC_EXT_BITCLOCK_RATE:
+			if (CAPTURE_PORT != CAPTURE_PORT_EXT)
+				err = set_bitclock_rate(codec, reg, value,
+							PORT_EXT);
+			break;
+		case MC_ASOC_EXT_INTERFACE:
+			if (CAPTURE_PORT != CAPTURE_PORT_EXT)
+				err = set_interface(codec, reg, value,
+						    PORT_EXT);
+			break;
+		case MC_ASOC_EXT_BITCLOCK_INVERT:
+			if (CAPTURE_PORT != CAPTURE_PORT_EXT)
+				err = set_bitclock_invert(codec, reg, value,
+							  PORT_EXT);
+			break;
+		case MC_ASOC_EXT_INPUT_DA_BIT_WIDTH:
+			if (CAPTURE_PORT != CAPTURE_PORT_EXT)
+				err = set_da_bit_width(codec, reg, value,
+						       PORT_EXT, 0);
+			break;
+		case MC_ASOC_EXT_INPUT_DA_FORMAT:
+			if (CAPTURE_PORT != CAPTURE_PORT_EXT)
+				err = set_da_format(codec, reg, value,
+						    PORT_EXT, 0);
+			break;
+		case MC_ASOC_EXT_INPUT_PCM_MONOSTEREO:
+			if (CAPTURE_PORT != CAPTURE_PORT_EXT)
+				err = set_pcm_mono_stereo(codec, reg, value,
+							  PORT_EXT, 0);
+			break;
+		case MC_ASOC_EXT_INPUT_PCM_BIT_ORDER:
+			if (CAPTURE_PORT != CAPTURE_PORT_EXT)
+				err = set_pcm_bit_order(codec, reg, value,
+							PORT_EXT, 0);
+			break;
+		case MC_ASOC_EXT_INPUT_PCM_FORMAT:
+			if (CAPTURE_PORT != CAPTURE_PORT_EXT)
+				err = set_pcm_format(codec, reg, value,
+						     PORT_EXT, 0);
+			break;
+		case MC_ASOC_EXT_INPUT_PCM_BIT_WIDTH:
+			if (CAPTURE_PORT != CAPTURE_PORT_EXT)
+				err = set_pcm_bit_width(codec, reg, value,
+							PORT_EXT, 0);
+			break;
+		case MC_ASOC_EXT_OUTPUT_DA_BIT_WIDTH:
+			if (CAPTURE_PORT != CAPTURE_PORT_EXT)
+				err = set_da_bit_width(codec, reg, value,
+						       PORT_EXT, 1);
+			break;
+		case MC_ASOC_EXT_OUTPUT_DA_FORMAT:
+			if (CAPTURE_PORT != CAPTURE_PORT_EXT)
+				err = set_da_format(codec, reg, value,
+						    PORT_EXT, 1);
+			break;
+		case MC_ASOC_EXT_OUTPUT_PCM_MONOSTEREO:
+			if (CAPTURE_PORT != CAPTURE_PORT_EXT)
+				err = set_pcm_mono_stereo(codec, reg, value,
+							  PORT_EXT, 1);
+			break;
+		case MC_ASOC_EXT_OUTPUT_PCM_BIT_ORDER:
+			if (CAPTURE_PORT != CAPTURE_PORT_EXT)
+				err = set_pcm_bit_order(codec, reg, value,
+							PORT_EXT, 1);
+			break;
+		case MC_ASOC_EXT_OUTPUT_PCM_FORMAT:
+			if (CAPTURE_PORT != CAPTURE_PORT_EXT)
+				err = set_pcm_format(codec, reg, value,
+						     PORT_EXT, 1);
+			break;
+		case MC_ASOC_EXT_OUTPUT_PCM_BIT_WIDTH:
+			if (CAPTURE_PORT != CAPTURE_PORT_EXT)
+				err = set_pcm_bit_width(codec, reg, value,
+							PORT_EXT, 1);
+			break;
+		case MC_ASOC_VOICE_MASTERSLAVE:
+			err = set_master_slave(codec, reg, value, PORT_VOICE);
+			break;
+		case MC_ASOC_VOICE_RATE:
+			err = set_rate(codec, reg, value, PORT_VOICE);
+			break;
+		case MC_ASOC_VOICE_BITCLOCK_RATE:
+			err = set_bitclock_rate(codec, reg, value, PORT_VOICE);
+			break;
+		case MC_ASOC_VOICE_INTERFACE:
+			err = set_interface(codec, reg, value, PORT_VOICE);
+			break;
+		case MC_ASOC_VOICE_BITCLOCK_INVERT:
+			err = set_bitclock_invert(codec, reg, value,
+						  PORT_VOICE);
+			break;
+		case MC_ASOC_VOICE_INPUT_DA_BIT_WIDTH:
+			err = set_da_bit_width(codec, reg, value,
+					       PORT_VOICE, 0);
+			break;
+		case MC_ASOC_VOICE_INPUT_DA_FORMAT:
+			err = set_da_format(codec, reg, value, PORT_VOICE, 0);
+			break;
+		case MC_ASOC_VOICE_INPUT_PCM_MONOSTEREO:
+			err = set_pcm_mono_stereo(codec, reg, value,
+						  PORT_VOICE, 0);
+			break;
+		case MC_ASOC_VOICE_INPUT_PCM_BIT_ORDER:
+			err = set_pcm_bit_order(codec, reg, value,
+						PORT_VOICE, 0);
+			break;
+		case MC_ASOC_VOICE_INPUT_PCM_FORMAT:
+			err = set_pcm_format(codec, reg, value, PORT_VOICE, 0);
+			break;
+		case MC_ASOC_VOICE_INPUT_PCM_BIT_WIDTH:
+			err = set_pcm_bit_width(codec, reg, value,
+						PORT_VOICE, 0);
+			break;
+		case MC_ASOC_VOICE_OUTPUT_DA_BIT_WIDTH:
+			err = set_da_bit_width(codec, reg, value,
+					       PORT_VOICE, 1);
+			break;
+		case MC_ASOC_VOICE_OUTPUT_DA_FORMAT:
+			err = set_da_format(codec, reg, value, PORT_VOICE, 1);
+			break;
+		case MC_ASOC_VOICE_OUTPUT_PCM_MONOSTEREO:
+			err = set_pcm_mono_stereo(codec, reg, value,
+						  PORT_VOICE, 1);
+			break;
+		case MC_ASOC_VOICE_OUTPUT_PCM_BIT_ORDER:
+			err = set_pcm_bit_order(codec, reg, value,
+						PORT_VOICE, 1);
+			break;
+		case MC_ASOC_VOICE_OUTPUT_PCM_FORMAT:
+			err = set_pcm_format(codec, reg, value, PORT_VOICE, 1);
+			break;
+		case MC_ASOC_VOICE_OUTPUT_PCM_BIT_WIDTH:
+			err = set_pcm_bit_width(codec, reg, value,
+						PORT_VOICE, 1);
+			break;
+		case MC_ASOC_MUSIC_PHYSICAL_PORT:
+			err = set_phys_port(codec, reg, value, PORT_MUSIC);
+			break;
+		case MC_ASOC_EXT_PHYSICAL_PORT:
+			err = set_phys_port(codec, reg, value, PORT_EXT);
+			break;
+		case MC_ASOC_VOICE_PHYSICAL_PORT:
+			err = set_phys_port(codec, reg, value, PORT_VOICE);
+			break;
+		case MC_ASOC_HIFI_PHYSICAL_PORT:
+			err = set_phys_port(codec, reg, value, PORT_HIFI);
+			break;
+		case MC_ASOC_ADIF0_SWAP:
+			err = set_swap(codec, reg, value,
+				       offsetof(struct mcdrv_swap_info, adif0),
+				       MCDRV_SWAP_ADIF0_UPDATE_FLAG);
+			break;
+		case MC_ASOC_ADIF1_SWAP:
+			err = set_swap(codec, reg, value,
+				       offsetof(struct mcdrv_swap_info, adif1),
+				       MCDRV_SWAP_ADIF1_UPDATE_FLAG);
+			break;
+		case MC_ASOC_ADIF2_SWAP:
+			err = set_swap(codec, reg, value,
+				       offsetof(struct mcdrv_swap_info, adif2),
+				       MCDRV_SWAP_ADIF2_UPDATE_FLAG);
+			break;
+		case MC_ASOC_DAC0_SWAP:
+			err = set_swap(codec, reg, value,
+				       offsetof(struct mcdrv_swap_info, dac0),
+				       MCDRV_SWAP_DAC0_UPDATE_FLAG);
+			break;
+		case MC_ASOC_DAC1_SWAP:
+			err = set_swap(codec, reg, value,
+				       offsetof(struct mcdrv_swap_info, dac1),
+				       MCDRV_SWAP_DAC1_UPDATE_FLAG);
+			break;
+		case MC_ASOC_MUSIC_OUT0_SWAP:
+			err = set_swap(codec, reg, value,
+				       offsetof(struct mcdrv_swap_info,
+						music_out0),
+				       MCDRV_SWAP_MUSICOUT0_UPDATE_FLAG);
+			break;
+		case MC_ASOC_MUSIC_IN0_SWAP:
+			err = set_swap(codec, reg, value,
+				       offsetof(struct mcdrv_swap_info,
+						music_in0),
+				       MCDRV_SWAP_MUSICIN0_UPDATE_FLAG);
+			break;
+		case MC_ASOC_MUSIC_IN1_SWAP:
+			err = set_swap(codec, reg, value,
+				       offsetof(struct mcdrv_swap_info,
+						music_in1),
+				       MCDRV_SWAP_MUSICIN1_UPDATE_FLAG);
+			break;
+		case MC_ASOC_MUSIC_IN2_SWAP:
+			err = set_swap(codec, reg, value,
+				       offsetof(struct mcdrv_swap_info,
+						music_in2),
+				       MCDRV_SWAP_MUSICIN2_UPDATE_FLAG);
+			break;
+		case MC_ASOC_EXT_IN_SWAP:
+			err = set_swap(codec, reg, value,
+				       offsetof(struct mcdrv_swap_info, ext_in),
+				       MCDRV_SWAP_EXTIN_UPDATE_FLAG);
+			break;
+		case MC_ASOC_VOICE_IN_SWAP:
+			err = set_swap(codec, reg, value,
+				       offsetof(struct mcdrv_swap_info,
+						voice_in),
+				       MCDRV_SWAP_VOICEIN_UPDATE_FLAG);
+			break;
+		case MC_ASOC_MUSIC_OUT1_SWAP:
+			err = set_swap(codec, reg, value,
+				       offsetof(struct mcdrv_swap_info,
+						music_out1),
+				       MCDRV_SWAP_MUSICOUT1_UPDATE_FLAG);
+			break;
+		case MC_ASOC_MUSIC_OUT2_SWAP:
+			err = set_swap(codec, reg, value,
+				       offsetof(struct mcdrv_swap_info,
+						music_out2),
+				       MCDRV_SWAP_MUSICOUT2_UPDATE_FLAG);
+			break;
+		case MC_ASOC_EXT_OUT_SWAP:
+			err = set_swap(codec, reg, value,
+				       offsetof(struct mcdrv_swap_info,
+						ext_out),
+				       MCDRV_SWAP_EXTOUT_UPDATE_FLAG);
+			break;
+		case MC_ASOC_VOICE_OUT_SWAP:
+			err = set_swap(codec, reg, value,
+				       offsetof(struct mcdrv_swap_info,
+						voice_out),
+				       MCDRV_SWAP_VOICEOUT_UPDATE_FLAG);
+			break;
+		case MC_ASOC_ADIF0_SOURCE:
+		case MC_ASOC_ADIF1_SOURCE:
+		case MC_ASOC_ADIF2_SOURCE:
+			err = snd_soc_cache_write(codec, reg, value);
+			if (err < 0)
+				break;
+
+			err = connect_path(codec);
+			break;
+		case MC_ASOC_MAIN_MIC:
+			mc_asoc_main_mic = value;
+			snd_soc_cache_write(codec, reg, value);
+			break;
+		case MC_ASOC_SUB_MIC:
+			mc_asoc_sub_mic = value;
+			snd_soc_cache_write(codec, reg, value);
+			break;
+		case MC_ASOC_HS_MIC:
+			mc_asoc_hs_mic = value;
+			snd_soc_cache_write(codec, reg, value);
+			break;
+#ifdef MC_ASOC_TEST
+		case MC_ASOC_MIC1_BIAS:
+			mc_asoc_mic1_bias = value;
+			snd_soc_cache_write(codec, reg, value);
+			err = connect_path(codec);
+			break;
+		case MC_ASOC_MIC2_BIAS:
+			mc_asoc_mic2_bias = value;
+			snd_soc_cache_write(codec, reg, value);
+			err = connect_path(codec);
+			break;
+		case MC_ASOC_MIC3_BIAS:
+			mc_asoc_mic3_bias = value;
+			snd_soc_cache_write(codec, reg, value);
+			err = connect_path(codec);
+			break;
+		case MC_ASOC_MIC4_BIAS:
+			mc_asoc_mic4_bias = value;
+			snd_soc_cache_write(codec, reg, value);
+			err = connect_path(codec);
+			break;
+#endif
+		default:
+			err = -EINVAL;
+			break;
+		}
+	}
+
+	return err;
+}
+
+static const struct snd_soc_dapm_widget mc_asoc_widgets[] = {
+	SND_SOC_DAPM_DAC("DAC DUMMY", "DAC Playback", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_ADC("ADC DUMMY", "ADC Capture", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_INPUT("INPUT DUMMY"),
+	SND_SOC_DAPM_OUTPUT("OUTPUT DUMMY"),
+};
+
+static const struct snd_soc_dapm_widget mc_asoc_widgets_headset[] = {
+	SND_SOC_DAPM_OUTPUT("HPOUTL"),
+	SND_SOC_DAPM_OUTPUT("HPOUTR"),
+	SND_SOC_DAPM_INPUT("AMIC1"),
+	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+};
+
+static const struct snd_soc_dapm_route mc_asoc_intercon[] = {
+	{"OUTPUT DUMMY", NULL, "DAC DUMMY"},
+	{"ADC DUMMY", NULL, "INPUT DUMMY"}
+};
+
+static const struct snd_soc_dapm_route mc_asoc_intercon_headset[] = {
+	{"Headphone Jack", NULL, "HPOUTL"},
+	{"Headphone Jack", NULL, "HPOUTR"},
+	{"Mic Jack", NULL, "AMIC1"},
+};
+
+static int mc_asoc_add_widgets(struct snd_soc_codec *codec)
+{
+	int err;
+
+	if (!codec)
+		return -EINVAL;
+
+	err = snd_soc_dapm_new_controls(&codec->dapm, mc_asoc_widgets,
+					ARRAY_SIZE(mc_asoc_widgets));
+	if (err < 0)
+		return err;
+
+	err = snd_soc_dapm_add_routes(&codec->dapm, mc_asoc_intercon,
+				      ARRAY_SIZE(mc_asoc_intercon));
+	if (err < 0)
+		return err;
+
+	err = snd_soc_dapm_new_controls(&codec->dapm, mc_asoc_widgets_headset,
+					ARRAY_SIZE(mc_asoc_widgets_headset));
+	if (err < 0)
+		return err;
+
+	err = snd_soc_dapm_add_routes(&codec->dapm, mc_asoc_intercon_headset,
+				      ARRAY_SIZE(mc_asoc_intercon_headset));
+	if (err < 0)
+		return err;
+
+	return snd_soc_dapm_new_widgets(&codec->dapm);
+}
+
+static struct input_dev *inp_dev;
+
+static struct snd_soc_jack hs_jack;
+static struct snd_soc_jack_pin hs_jack_pins[] = {
+	{
+	 .pin = "Mic Jack",
+	 .mask = SND_JACK_MICROPHONE,
+	 },
+	{
+	 .pin = "Headphone Jack",
+	 .mask = SND_JACK_HEADPHONE,
+	 },
+};
+
+static struct workqueue_struct *mb4_workq;
+static struct delayed_work delayed_work;
+
+static void mb4_work(struct work_struct *work)
+{
+	connect_path(mc_asoc_codec);
+}
+
+static void headset_detect_callback(u32 flags, struct mcdrv_hsdet_res *res)
+{
+	struct mcdrv_hsdet_info info;
+	u8 hpimpclass = mc_asoc_hpimpclass;
+	u8 en_plug_det_db, en_mic_det, en_dly_key_off, en_dly_key_on;
+	u8 en_key_off, en_key_on, hs_det_dbnc, dbnc_num_plug;
+	u8 key0_on_dly_tim, key1_on_dly_tim, key2_on_dly_tim;
+	u8 key0_on_dly_tim2, key1_on_dly_tim2, key2_on_dly_tim2;
+	u8 current_en_plug_det_db;
+	int err;
+
+	if (!mc_asoc_suspended) {
+		en_plug_det_db = hsdet_info_def.en_plug_det_db;
+		en_mic_det = hsdet_info_def.en_mic_det;
+		en_dly_key_off = hsdet_info_def.en_dly_key_off;
+		en_dly_key_on = hsdet_info_def.en_dly_key_on;
+		en_key_off = hsdet_info_def.en_key_off;
+		en_key_on = hsdet_info_def.en_key_on;
+		key0_on_dly_tim = hsdet_info_def.key0_on_dly_tim;
+		key1_on_dly_tim = hsdet_info_def.key1_on_dly_tim;
+		key2_on_dly_tim = hsdet_info_def.key2_on_dly_tim;
+		key0_on_dly_tim2 = hsdet_info_def.key0_on_dly_tim2;
+		key1_on_dly_tim2 = hsdet_info_def.key1_on_dly_tim2;
+		key2_on_dly_tim2 = hsdet_info_def.key2_on_dly_tim2;
+		hs_det_dbnc = hsdet_info_def.hs_det_dbnc;
+		dbnc_num_plug = hsdet_info_def.dbnc_num_plug;
+	} else {
+		en_plug_det_db = hsdet_info_suspend.en_plug_det_db;
+		en_mic_det = hsdet_info_suspend.en_mic_det;
+		en_dly_key_off = hsdet_info_suspend.en_dly_key_off;
+		en_dly_key_on = hsdet_info_suspend.en_dly_key_on;
+		en_key_off = hsdet_info_suspend.en_key_off;
+		en_key_on = hsdet_info_suspend.en_key_on;
+		key0_on_dly_tim = hsdet_info_suspend.key0_on_dly_tim;
+		key1_on_dly_tim = hsdet_info_suspend.key1_on_dly_tim;
+		key2_on_dly_tim = hsdet_info_suspend.key2_on_dly_tim;
+		key0_on_dly_tim2 = hsdet_info_suspend.key0_on_dly_tim2;
+		key1_on_dly_tim2 = hsdet_info_suspend.key1_on_dly_tim2;
+		key2_on_dly_tim2 = hsdet_info_suspend.key2_on_dly_tim2;
+		hs_det_dbnc = hsdet_info_suspend.hs_det_dbnc;
+		dbnc_num_plug = hsdet_info_suspend.dbnc_num_plug;
+	}
+
+	mc_control(MCDRV_GET_HSDET, (unsigned long)&info, 0);
+	current_en_plug_det_db = info.en_plug_det_db;
+
+	if (flags & MCDRV_HSDET_EVT_SENSEFIN_FLAG)
+		mc_asoc_hpimpclass = res->hp_imp_class;
+
+	if (flags & MCDRV_HSDET_EVT_PLUGUNDET_DB_FLAG) {
+		if (current_en_plug_det_db & MCDRV_PLUGDETDB_UNDET_ENABLE) {
+			mc_asoc_jack_status = 0;
+			snd_soc_jack_report(&hs_jack, 0, SND_JACK_HEADSET);
+			cancel_delayed_work(&delayed_work);
+			info.en_plug_det_db =
+			    en_plug_det_db & MCDRV_PLUGDETDB_DET_ENABLE;
+			info.en_dly_key_off = MCDRV_KEYEN_D_D_D;
+			info.en_dly_key_on = MCDRV_KEYEN_D_D_D;
+			info.en_key_off = MCDRV_KEYEN_D_D_D;
+			info.en_key_on = MCDRV_KEYEN_D_D_D;
+
+			info.hs_det_dbnc = hs_det_dbnc;
+			info.dbnc_num_plug = dbnc_num_plug;
+			info.cbfunc = NULL;
+			err = mc_control(MCDRV_SET_HSDET,
+					 (unsigned long)&info, 0x410000ee);
+
+			info.cbfunc = headset_detect_callback;
+			err = mc_control(MCDRV_SET_HSDET,
+					 (unsigned long)&info, 0x40000000);
+			mc_asoc_hpimpclass = (u8) -1;
+		} else
+			connect_path(mc_asoc_codec);
+	}
+
+	if (mc_asoc_jack_status == SND_JACK_HEADSET) {
+		if ((flags & MCDRV_HSDET_EVT_KEYON0_FLAG) &&
+		    (en_key_on & MCDRV_KEYEN_D_D_E))
+			snd_soc_jack_report(&hs_jack, SND_JACK_BTN_0,
+					    SND_JACK_BTN_0);
+		if ((flags & MCDRV_HSDET_EVT_KEYON1_FLAG)
+		    && (en_key_on & MCDRV_KEYEN_D_E_D))
+			snd_soc_jack_report(&hs_jack, SND_JACK_BTN_1,
+					    SND_JACK_BTN_1);
+		if ((flags & MCDRV_HSDET_EVT_KEYON2_FLAG)
+		    && (en_key_on & MCDRV_KEYEN_E_D_D))
+			snd_soc_jack_report(&hs_jack, SND_JACK_BTN_2,
+					    SND_JACK_BTN_2);
+
+		if (flags & MCDRV_HSDET_EVT_KEYOFF0_FLAG) {
+			if (en_key_off & MCDRV_KEYEN_D_D_E)
+				snd_soc_jack_report(&hs_jack, 0,
+						    SND_JACK_BTN_0);
+			if ((en_dly_key_on & MCDRV_KEYEN_D_D_E)
+			    && !mc_asoc_ver_id
+			    && key0_on_dly_tim2 == 0 && (info.en_key_off & 1)) {
+				info.en_key_off &= ~1;
+				info.key0_on_dly_tim = key0_on_dly_tim;
+				err = mc_control(MCDRV_SET_HSDET,
+						 (unsigned long)&info, 0x2020);
+			}
+		}
+		if (flags & MCDRV_HSDET_EVT_KEYOFF1_FLAG) {
+			if (en_key_off & MCDRV_KEYEN_D_E_D)
+				snd_soc_jack_report(&hs_jack, 0,
+						    SND_JACK_BTN_1);
+			if ((en_dly_key_on & MCDRV_KEYEN_D_E_D)
+			    && !mc_asoc_ver_id
+			    && key1_on_dly_tim2 == 0 && (info.en_key_off & 2)) {
+				info.en_key_off &= ~2;
+				info.key1_on_dly_tim = key1_on_dly_tim;
+				err = mc_control(MCDRV_SET_HSDET,
+						 (unsigned long)&info, 0x4020);
+			}
+		}
+		if (flags & MCDRV_HSDET_EVT_KEYOFF2_FLAG) {
+			if (en_key_off & MCDRV_KEYEN_E_D_D)
+				snd_soc_jack_report(&hs_jack, 0,
+						    SND_JACK_BTN_2);
+			if ((en_dly_key_on & MCDRV_KEYEN_E_D_D)
+			    && !mc_asoc_ver_id
+			    && key2_on_dly_tim2 == 0 && (info.en_key_off & 4)) {
+				info.en_key_off &= ~4;
+				info.key2_on_dly_tim = key2_on_dly_tim;
+				err = mc_control(MCDRV_SET_HSDET,
+						 (unsigned long)&info, 0x8020);
+			}
+		}
+
+		if (flags & MCDRV_HSDET_EVT_DLYKEYON0_FLAG) {
+			if (en_dly_key_on & MCDRV_KEYEN_D_D_E) {
+				input_report_key(inp_dev,
+						 MC_ASOC_EV_KEY_DELAYKEYON0, 1);
+				input_sync(inp_dev);
+				input_report_key(inp_dev,
+						 MC_ASOC_EV_KEY_DELAYKEYON0, 0);
+				input_sync(inp_dev);
+				if (!mc_asoc_ver_id && key0_on_dly_tim2 == 0) {
+					info.en_key_off |= 1;
+					info.key0_on_dly_tim = 0;
+					err = mc_control(MCDRV_SET_HSDET,
+							 (unsigned long)&info,
+							 0x2020);
+				}
+			}
+		} else if (flags & MCDRV_HSDET_EVT_DLYKEYON1_FLAG) {
+			if (en_dly_key_on & MCDRV_KEYEN_D_E_D) {
+				input_report_key(inp_dev,
+						 MC_ASOC_EV_KEY_DELAYKEYON1, 1);
+				input_sync(inp_dev);
+				input_report_key(inp_dev,
+						 MC_ASOC_EV_KEY_DELAYKEYON1, 0);
+				input_sync(inp_dev);
+
+				if (!mc_asoc_ver_id && key1_on_dly_tim2 == 0) {
+					info.en_key_off |= 2;
+					info.key1_on_dly_tim = 0;
+					err = mc_control(MCDRV_SET_HSDET,
+							 (unsigned long)&info,
+							 0x4020);
+				}
+			}
+		} else if (flags & MCDRV_HSDET_EVT_DLYKEYON2_FLAG) {
+			if (en_dly_key_on & MCDRV_KEYEN_E_D_D) {
+				input_report_key(inp_dev,
+						 MC_ASOC_EV_KEY_DELAYKEYON2, 1);
+				input_sync(inp_dev);
+				input_report_key(inp_dev,
+						 MC_ASOC_EV_KEY_DELAYKEYON2, 0);
+				input_sync(inp_dev);
+
+				if (!mc_asoc_ver_id && key2_on_dly_tim2 == 0) {
+					info.en_key_off |= 4;
+					info.key2_on_dly_tim = 0;
+					err = mc_control(MCDRV_SET_HSDET,
+							 (unsigned long)&info,
+							 0x8020);
+				}
+			}
+		}
+
+		if (flags & MCDRV_HSDET_EVT_DLYKEYOFF0_FLAG) {
+			if (en_dly_key_off & MCDRV_KEYEN_D_D_E) {
+				input_report_key(inp_dev,
+						 delay_key_off0[res->key_cnt0],
+						 1);
+				input_sync(inp_dev);
+				input_report_key(inp_dev,
+						 delay_key_off0[res->key_cnt0],
+						 0);
+				input_sync(inp_dev);
+			}
+		} else if (flags & MCDRV_HSDET_EVT_DLYKEYOFF1_FLAG) {
+			if (en_dly_key_off & MCDRV_KEYEN_D_E_D) {
+				input_report_key(inp_dev,
+						 delay_key_off1[res->key_cnt1],
+						 1);
+				input_sync(inp_dev);
+				input_report_key(inp_dev,
+						 delay_key_off1[res->key_cnt1],
+						 0);
+				input_sync(inp_dev);
+			}
+		} else if (flags & MCDRV_HSDET_EVT_DLYKEYOFF2_FLAG) {
+			if (en_dly_key_off & MCDRV_KEYEN_E_D_D) {
+				input_report_key(inp_dev,
+						 delay_key_off2[res->key_cnt2],
+						 1);
+				input_sync(inp_dev);
+				input_report_key(inp_dev,
+						 delay_key_off2[res->key_cnt2],
+						 0);
+				input_sync(inp_dev);
+			}
+		}
+	}
+
+	if ((flags & MCDRV_HSDET_EVT_PLUGDET_DB_FLAG)
+	    && (current_en_plug_det_db & MCDRV_PLUGDETDB_DET_ENABLE)) {
+		if ((flags & MCDRV_HSDET_EVT_MICDET_FLAG)
+		    && (en_mic_det & MCDRV_MICDET_ENABLE)) {
+			mc_asoc_jack_status = SND_JACK_HEADSET;
+			snd_soc_jack_report(&hs_jack,
+					    mc_asoc_jack_status,
+					    SND_JACK_HEADSET);
+		} else {
+			mc_asoc_jack_status = SND_JACK_HEADPHONE;
+			snd_soc_jack_report(&hs_jack,
+					    mc_asoc_jack_status,
+					    SND_JACK_HEADSET);
+		}
+
+		queue_delayed_work(mb4_workq, &delayed_work,
+				   msecs_to_jiffies(MSDETMB4OFF));
+		info.en_plug_det_db =
+		    en_plug_det_db & MCDRV_PLUGDETDB_UNDET_ENABLE;
+		info.en_dly_key_off = en_dly_key_off;
+		info.en_dly_key_on = en_dly_key_on;
+		info.en_key_off = en_key_off;
+		info.en_key_on = en_key_on;
+		info.hs_det_dbnc = HSUNDETDBNC;
+		info.dbnc_num_plug = HSUNDETDBNCNUM;
+		info.cbfunc = NULL;
+		err = mc_control(MCDRV_SET_HSDET,
+				 (unsigned long)&info, 0x410000ee);
+		info.cbfunc = headset_detect_callback;
+		err = mc_control(MCDRV_SET_HSDET,
+				 (unsigned long)&info, 0x40000000);
+		if (info.sgnl_num == MCDRV_SGNLNUM_NONE)
+			mc_asoc_hpimpclass = MC_ASOC_IMP_TBL_NUM - 1;
+	}
+
+	if (mc_asoc_jack_status == SND_JACK_HEADPHONE
+	    && (flags & MCDRV_HSDET_EVT_MICDET_FLAG)
+	    && (en_mic_det & MCDRV_MICDET_ENABLE)) {
+		mc_asoc_jack_status = SND_JACK_HEADSET;
+		snd_soc_jack_report(&hs_jack,
+				    mc_asoc_jack_status, SND_JACK_HEADSET);
+	}
+
+	if (hpimpclass != mc_asoc_hpimpclass) {
+		if (mc_asoc_hpimpclass != (u8) -1) {
+			struct mixer_path_ctl_info mixer;
+			int preset_idx = 0;
+
+			err = get_mixer_path_ctl_info(mc_asoc_codec, &mixer);
+			if (err < 0)
+				return;
+			preset_idx = get_path_preset_idx(&mixer);
+			if (preset_idx < 0 || preset_idx > PRESET_PATH_N)
+				return;
+			set_volume(mc_asoc_codec, &mixer, preset_idx);
+		} else
+			connect_path(mc_asoc_codec);
+	}
+}
+
+static void mc_asoc_irq_work(struct work_struct *work)
+{
+	struct mc_asoc_data *mc_asoc =
+	    container_of(work, struct mc_asoc_data, work);
+	struct spi_device *spi_dev = mc_asoc->spi;
+	int err;
+
+	err = mc_do_irq();
+	if (err < 0)
+		dev_err(&spi_dev->dev, "IRQ processing error: %d\n", err);
+
+	if (IRQ_TYPE == IRQ_TYPE_LEVEL_LOW)
+		enable_irq(mc_asoc->irq);
+}
+
+static irqreturn_t irq_handler(int irq, void *data)
+{
+	struct mc_asoc_data *mc_asoc;
+
+	mc_asoc = (struct mc_asoc_data *)data;
+	if (mc_asoc && mc_asoc->workqueue) {
+		if (IRQ_TYPE == IRQ_TYPE_LEVEL_LOW)
+			disable_irq_nosync(mc_asoc->irq);
+
+		queue_work(mc_asoc->workqueue, &mc_asoc->work);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int init_irq(struct snd_soc_codec *codec)
+{
+	struct mc_asoc_data *mc_asoc;
+	int err;
+
+	mc_asoc = snd_soc_codec_get_drvdata(codec);
+	if (!mc_asoc)
+		return -EINVAL;
+
+	INIT_WORK(&mc_asoc->work, mc_asoc_irq_work);
+
+	mc_asoc->workqueue = create_workqueue("irq_queue");
+	if (!mc_asoc->workqueue)
+		return -ENOMEM;
+
+	err = irq_set_irq_type(mc_asoc->irq, IRQ_TYPE);
+	if (err < 0) {
+		dev_err(codec->dev, "Failed to set_irq_type: %d\n", err);
+		return -EIO;
+	}
+
+	err = request_irq(mc_asoc->irq, irq_handler,
+			  IRQF_DISABLED, "MC_YAMAHA IRQ", mc_asoc);
+	if (err < 0)
+		dev_err(codec->dev, "Failed to request_irq: %d\n", err);
+
+	return err;
+}
+
+static int term_irq(struct snd_soc_codec *codec)
+{
+	struct mc_asoc_data *mc_asoc;
+
+	mc_asoc = snd_soc_codec_get_drvdata(codec);
+	if (mc_asoc) {
+		free_irq(mc_asoc->irq, mc_asoc);
+
+		if (mc_asoc->workqueue)
+			destroy_workqueue(mc_asoc->workqueue);
+		if (mb4_workq)
+			destroy_workqueue(mb4_workq);
+	}
+
+	return 0;
+}
+
+static int mc_asoc_probe(struct snd_soc_codec *codec)
+{
+	struct mc_asoc_data *mc_asoc;
+	struct device *dev;
+	struct mcdrv_dio_info dio;
+	struct mcdrv_dio_path_info dio_path;
+	u32 update = 0;
+	int i, err;
+
+	mc_asoc_codec = codec;
+	mc_asoc_suspended = false;
+	mc_asoc_hpimpclass = (u8) -1;
+	mc_asoc_jack_status = 0;
+
+	mb4_workq = create_workqueue("mb4");
+	if (!mb4_workq)
+		return -ENOMEM;
+
+	INIT_DELAYED_WORK(&delayed_work, mb4_work);
+
+	if (!codec)
+		return -ENODEV;
+
+	mc_asoc = snd_soc_codec_get_drvdata(codec);
+	dev = codec->dev;
+	if (!mc_asoc || !dev)
+		return -ENODEV;
+
+	mc_asoc_ver_id = mc_version_id_get();
+
+	mc_asoc->setup = mc_asoc_cfg_setup;
+	if (mc_asoc_ver_id < 2) {
+		mc_asoc->setup.info.mb_sel1 = MCDRV_MBSEL_20;
+		mc_asoc->setup.info.mb_sel2 = MCDRV_MBSEL_20;
+		mc_asoc->setup.info.mb_sel3 = MCDRV_MBSEL_20;
+		mc_asoc->setup.info.mb_sel4 = MCDRV_MBSEL_20;
+	}
+
+	err = mc_init(&mc_asoc->setup.info);
+	if (err < 0) {
+		dev_err(dev, "Error in mc_init: %d\n", err);
+		return err;
+	}
+
+	if (mc_asoc_ver_id == 0) {
+		vreg_map[MC_ASOC_AVOL_HP].volmap = volmap_hp_es1;
+		vreg_map[MC_ASOC_AVOL_LINEOUT2].volmap = volmap_lineout;
+		vreg_map[MC_ASOC_DVOL_ADIF0IN].volmap = volmap_adif;
+		vreg_map[MC_ASOC_DVOL_ADIF1IN].volmap = volmap_adif;
+		vreg_map[MC_ASOC_DVOL_APLAY_D].volmap = volmap_adif;
+	} else
+		vreg_map[MC_ASOC_AVOL_SP].volmap = volmap_sp[4];
+
+	err = snd_soc_add_codec_controls(codec, mc_asoc_snd_controls,
+					 ARRAY_SIZE(mc_asoc_snd_controls));
+	if (err < 0) {
+		dev_err(dev, "Error in snd_soc_add_codec_controls: %d\n", err);
+		goto error;
+	}
+
+	err = mc_asoc_add_widgets(codec);
+	if (err < 0) {
+		dev_err(dev, "Error in mc_asoc_add_widgets: %d\n", err);
+		goto error;
+	}
+
+	snd_soc_cache_write(codec, MC_ASOC_EXT_MASTERSLAVE,
+			    ext_port_def.dio_common.master_slave);
+	snd_soc_cache_write(codec, MC_ASOC_EXT_RATE,
+			    ext_port_def.dio_common.fs);
+	snd_soc_cache_write(codec, MC_ASOC_EXT_BITCLOCK_RATE,
+			    ext_port_def.dio_common.bck_fs);
+	snd_soc_cache_write(codec, MC_ASOC_EXT_INTERFACE,
+			    ext_port_def.dio_common.interface);
+	snd_soc_cache_write(codec, MC_ASOC_EXT_BITCLOCK_INVERT,
+			    ext_port_def.dio_common.bck_invert);
+	snd_soc_cache_write(codec, MC_ASOC_EXT_INPUT_DA_BIT_WIDTH,
+			    ext_port_def.dir.da_format.bit_sel);
+	snd_soc_cache_write(codec, MC_ASOC_EXT_OUTPUT_DA_BIT_WIDTH,
+			    ext_port_def.dit.da_format.bit_sel);
+	snd_soc_cache_write(codec, MC_ASOC_EXT_INPUT_DA_FORMAT,
+			    ext_port_def.dir.da_format.mode);
+	snd_soc_cache_write(codec, MC_ASOC_EXT_OUTPUT_DA_FORMAT,
+			    ext_port_def.dit.da_format.mode);
+	snd_soc_cache_write(codec, MC_ASOC_EXT_INPUT_PCM_MONOSTEREO,
+			    ext_port_def.dir.pcm_format.mono);
+	snd_soc_cache_write(codec, MC_ASOC_EXT_OUTPUT_PCM_MONOSTEREO,
+			    ext_port_def.dit.pcm_format.mono);
+	snd_soc_cache_write(codec, MC_ASOC_EXT_INPUT_PCM_BIT_ORDER,
+			    ext_port_def.dir.pcm_format.order);
+	snd_soc_cache_write(codec, MC_ASOC_EXT_OUTPUT_PCM_BIT_ORDER,
+			    ext_port_def.dit.pcm_format.order);
+	snd_soc_cache_write(codec, MC_ASOC_EXT_INPUT_PCM_FORMAT,
+			    ext_port_def.dir.pcm_format.law);
+	snd_soc_cache_write(codec, MC_ASOC_EXT_OUTPUT_PCM_FORMAT,
+			    ext_port_def.dit.pcm_format.law);
+	snd_soc_cache_write(codec, MC_ASOC_EXT_INPUT_PCM_BIT_WIDTH,
+			    ext_port_def.dir.pcm_format.bit_sel);
+	snd_soc_cache_write(codec, MC_ASOC_EXT_OUTPUT_PCM_BIT_WIDTH,
+			    ext_port_def.dit.pcm_format.bit_sel);
+
+	snd_soc_cache_write(codec, MC_ASOC_VOICE_MASTERSLAVE,
+			    voice_port_def.dio_common.master_slave);
+	snd_soc_cache_write(codec, MC_ASOC_VOICE_RATE,
+			    voice_port_def.dio_common.fs);
+	snd_soc_cache_write(codec, MC_ASOC_VOICE_BITCLOCK_RATE,
+			    voice_port_def.dio_common.bck_fs);
+	snd_soc_cache_write(codec, MC_ASOC_VOICE_INTERFACE,
+			    voice_port_def.dio_common.interface);
+	snd_soc_cache_write(codec, MC_ASOC_VOICE_BITCLOCK_INVERT,
+			    voice_port_def.dio_common.bck_invert);
+	snd_soc_cache_write(codec, MC_ASOC_VOICE_INPUT_DA_BIT_WIDTH,
+			    voice_port_def.dir.da_format.bit_sel);
+	snd_soc_cache_write(codec, MC_ASOC_VOICE_OUTPUT_DA_BIT_WIDTH,
+			    voice_port_def.dit.da_format.bit_sel);
+	snd_soc_cache_write(codec, MC_ASOC_VOICE_INPUT_DA_FORMAT,
+			    voice_port_def.dir.da_format.mode);
+	snd_soc_cache_write(codec, MC_ASOC_VOICE_OUTPUT_DA_FORMAT,
+			    voice_port_def.dit.da_format.mode);
+	snd_soc_cache_write(codec, MC_ASOC_VOICE_INPUT_PCM_MONOSTEREO,
+			    voice_port_def.dir.pcm_format.mono);
+	snd_soc_cache_write(codec, MC_ASOC_VOICE_OUTPUT_PCM_MONOSTEREO,
+			    voice_port_def.dit.pcm_format.mono);
+	snd_soc_cache_write(codec, MC_ASOC_VOICE_INPUT_PCM_BIT_ORDER,
+			    voice_port_def.dir.pcm_format.order);
+	snd_soc_cache_write(codec, MC_ASOC_VOICE_OUTPUT_PCM_BIT_ORDER,
+			    voice_port_def.dit.pcm_format.order);
+	snd_soc_cache_write(codec, MC_ASOC_VOICE_INPUT_PCM_FORMAT,
+			    voice_port_def.dir.pcm_format.law);
+	snd_soc_cache_write(codec, MC_ASOC_VOICE_OUTPUT_PCM_FORMAT,
+			    voice_port_def.dit.pcm_format.law);
+	snd_soc_cache_write(codec, MC_ASOC_VOICE_INPUT_PCM_BIT_WIDTH,
+			    voice_port_def.dir.pcm_format.bit_sel);
+
+	snd_soc_cache_write(codec, MC_ASOC_VOICE_OUTPUT_PCM_BIT_WIDTH,
+			    voice_port_def.dit.pcm_format.bit_sel);
+
+	snd_soc_cache_write(codec, MC_ASOC_VOICE_RECORDING,
+			    VOICE_RECORDING_UNMUTE);
+	snd_soc_cache_write(codec, MC_ASOC_INCALL_MIC_SP, INCALL_MIC_SP);
+	snd_soc_cache_write(codec, MC_ASOC_INCALL_MIC_RC, INCALL_MIC_RC);
+	snd_soc_cache_write(codec, MC_ASOC_INCALL_MIC_HP, INCALL_MIC_HP);
+	snd_soc_cache_write(codec, MC_ASOC_INCALL_MIC_LO1, INCALL_MIC_LO1);
+	snd_soc_cache_write(codec, MC_ASOC_INCALL_MIC_LO2, INCALL_MIC_LO2);
+
+	snd_soc_cache_write(codec, MC_ASOC_MUSIC_PHYSICAL_PORT,
+			    MUSIC_PHYSICAL_PORT);
+	snd_soc_cache_write(codec, MC_ASOC_EXT_PHYSICAL_PORT,
+			    EXT_PHYSICAL_PORT);
+	snd_soc_cache_write(codec, MC_ASOC_VOICE_PHYSICAL_PORT,
+			    VOICE_PHYSICAL_PORT);
+	snd_soc_cache_write(codec, MC_ASOC_HIFI_PHYSICAL_PORT,
+			    HIFI_PHYSICAL_PORT);
+
+	snd_soc_cache_write(codec, MC_ASOC_MAIN_MIC, mc_asoc_main_mic);
+	snd_soc_cache_write(codec, MC_ASOC_SUB_MIC, mc_asoc_sub_mic);
+	snd_soc_cache_write(codec, MC_ASOC_HS_MIC, mc_asoc_hs_mic);
+#ifdef MC_ASOC_TEST
+	snd_soc_cache_write(codec, MC_ASOC_MIC1_BIAS, mc_asoc_mic1_bias);
+	snd_soc_cache_write(codec, MC_ASOC_MIC2_BIAS, mc_asoc_mic2_bias);
+	snd_soc_cache_write(codec, MC_ASOC_MIC3_BIAS, mc_asoc_mic3_bias);
+	snd_soc_cache_write(codec, MC_ASOC_MIC4_BIAS, mc_asoc_mic4_bias);
+#endif
+
+	/* Headset jack detection */
+	snd_soc_jack_new(codec, "Headset",
+			 SND_JACK_HEADSET | SND_JACK_BTN_0 |
+			 SND_JACK_BTN_1 | SND_JACK_BTN_2, &hs_jack);
+
+	snd_jack_set_key(hs_jack.jack, SND_JACK_BTN_0, KEY_MEDIA);
+	snd_jack_set_key(hs_jack.jack, SND_JACK_BTN_1, KEY_VOLUMEUP);
+	snd_jack_set_key(hs_jack.jack, SND_JACK_BTN_2, KEY_VOLUMEDOWN);
+
+	snd_soc_jack_add_pins(&hs_jack, ARRAY_SIZE(hs_jack_pins), hs_jack_pins);
+
+	inp_dev = input_allocate_device();
+	inp_dev->name = "Headset keys";
+	input_set_capability(inp_dev, EV_KEY, MC_ASOC_EV_KEY_DELAYKEYON0);
+	input_set_capability(inp_dev, EV_KEY, MC_ASOC_EV_KEY_DELAYKEYON1);
+	input_set_capability(inp_dev, EV_KEY, MC_ASOC_EV_KEY_DELAYKEYON2);
+	for (i = 0; i < 8; i++) {
+		input_set_capability(inp_dev, EV_KEY, delay_key_off0[i]);
+		input_set_capability(inp_dev, EV_KEY, delay_key_off1[i]);
+		input_set_capability(inp_dev, EV_KEY, delay_key_off2[i]);
+	}
+
+	err = input_register_device(inp_dev);
+	if (err < 0) {
+		dev_err(dev, "Error in input_register_device: %d\n", err);
+		goto error;
+	}
+
+	dio.port[0] = music_port_def;
+	dio.port[1] = ext_port_def;
+	dio.port[2] = voice_port_def;
+	dio.port[3] = hifi_port_def;
+
+	update = MCDRV_MUSIC_COM_UPDATE_FLAG
+	    | MCDRV_MUSIC_DIR_UPDATE_FLAG
+	    | MCDRV_MUSIC_DIT_UPDATE_FLAG
+	    | MCDRV_EXT_COM_UPDATE_FLAG
+	    | MCDRV_EXT_DIR_UPDATE_FLAG
+	    | MCDRV_EXT_DIT_UPDATE_FLAG
+	    | MCDRV_VOICE_COM_UPDATE_FLAG
+	    | MCDRV_VOICE_DIR_UPDATE_FLAG
+	    | MCDRV_VOICE_DIT_UPDATE_FLAG
+	    | MCDRV_HIFI_COM_UPDATE_FLAG
+	    | MCDRV_HIFI_DIR_UPDATE_FLAG | MCDRV_HIFI_DIT_UPDATE_FLAG;
+	err = mc_control(MCDRV_SET_DIGITALIO, (unsigned long)&dio, update);
+	if (err < 0) {
+		dev_err(dev, "Error in MCDRV_SET_DIGITALIO: %d\n", err);
+		goto error;
+	}
+
+	update = MCDRV_PHYS0_UPDATE_FLAG
+	    | MCDRV_PHYS1_UPDATE_FLAG
+	    | MCDRV_PHYS2_UPDATE_FLAG
+	    | MCDRV_PHYS3_UPDATE_FLAG
+	    | MCDRV_DIR0SLOT_UPDATE_FLAG
+	    | MCDRV_DIR1SLOT_UPDATE_FLAG
+	    | MCDRV_DIR2SLOT_UPDATE_FLAG
+	    | MCDRV_DIT0SLOT_UPDATE_FLAG
+	    | MCDRV_DIT1SLOT_UPDATE_FLAG | MCDRV_DIT2SLOT_UPDATE_FLAG;
+	dio_path.phys_port[0] = MUSIC_PHYSICAL_PORT;
+	dio_path.phys_port[1] = EXT_PHYSICAL_PORT;
+	dio_path.phys_port[2] = VOICE_PHYSICAL_PORT;
+	dio_path.phys_port[3] = HIFI_PHYSICAL_PORT;
+	dio_path.music_rslot[0] = mc_asoc_cfg_setup.rslot[0];
+	dio_path.music_rslot[1] = mc_asoc_cfg_setup.rslot[1];
+	dio_path.music_rslot[2] = mc_asoc_cfg_setup.rslot[2];
+	dio_path.music_tslot[0] = mc_asoc_cfg_setup.tslot[0];
+	dio_path.music_tslot[1] = mc_asoc_cfg_setup.tslot[1];
+	dio_path.music_tslot[2] = mc_asoc_cfg_setup.tslot[2];
+	err = mc_control(MCDRV_SET_DIGITALIO_PATH,
+			 (unsigned long)&dio_path, update);
+	if (err < 0) {
+		dev_err(dev, "Error in MCDRV_SET_DIGITALIO_PATH: %d\n", err);
+		goto error;
+	}
+
+	mc_asoc->hsdet_store = hsdet_info_def;
+	mc_asoc->hsdet_store.en_dly_key_off = MCDRV_KEYEN_D_D_D;
+	mc_asoc->hsdet_store.en_dly_key_on = MCDRV_KEYEN_D_D_D;
+	mc_asoc->hsdet_store.en_key_off = MCDRV_KEYEN_D_D_D;
+	mc_asoc->hsdet_store.en_key_on = MCDRV_KEYEN_D_D_D;
+	mc_asoc->hsdet_store.cbfunc = headset_detect_callback;
+	if (mc_asoc_ver_id == 0)
+		mc_asoc->hsdet_store.irq_type = MCDRV_IRQTYPE_NORMAL;
+
+	err = mc_control(MCDRV_SET_HSDET,
+			 (unsigned long)&mc_asoc->hsdet_store, 0x7fffffff);
+	if (err < 0) {
+		dev_err(dev, "Error in MCDRV_SET_HSDET: %d\n", err);
+		goto error;
+	}
+
+	err = connect_path(codec);
+	if (err < 0) {
+		dev_err(dev, "Error in coeenct_path: %d\n", err);
+		goto error;
+	}
+
+	err = mc_do_irq();
+	if (err < 0)
+		dev_err(dev, "Error in mc_do_IRQ: %d\n", err);
+
+	if (mc_asoc_ver_id) {
+		mc_asoc->hsdet_store.en_plug_det_db &=
+		    ~MCDRV_PLUGDETDB_UNDET_ENABLE;
+		err = mc_control(MCDRV_SET_HSDET,
+				 (unsigned long)&mc_asoc->hsdet_store, 0x2);
+		if (err < 0) {
+			dev_err(dev, "Error in MCDRV_SET_HSDET: %d\n", err);
+			goto error;
+		}
+	}
+
+	err = init_irq(codec);
+	if (err < 0) {
+		dev_err(dev, "Error in init_irq: %d\n", err);
+		goto error;
+	}
+
+	device_init_wakeup(dev, 1);
+
+	set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
+	return 0;
+
+error:
+	mc_term();
+
+	return err;
+}
+
+static int mc_asoc_remove(struct snd_soc_codec *codec)
+{
+	struct mc_asoc_data *mc_asoc;
+	int err;
+
+	if (!codec)
+		return -EINVAL;
+
+	mc_asoc = snd_soc_codec_get_drvdata(codec);
+	if (!mc_asoc)
+		return -EINVAL;
+
+	term_irq(codec);
+
+	input_unregister_device(inp_dev);
+
+	del_dsp_param(mc_asoc);
+
+	set_bias_level(codec, SND_SOC_BIAS_OFF);
+
+	err = mc_term();
+	if (err < 0)
+		dev_err(codec->dev, "Error in mc_term: %d\n", err);
+
+	return err;
+}
+
+static int mc_asoc_suspend(struct snd_soc_codec *codec)
+{
+	struct mc_asoc_data *mc_asoc;
+	struct mixer_path_ctl_info mixer;
+	struct mcdrv_hsdet_info hsdet_info;
+	int err;
+
+	if (!codec)
+		return -EINVAL;
+
+	mc_asoc = snd_soc_codec_get_drvdata(codec);
+	if (!mc_asoc)
+		return -EINVAL;
+
+	get_mixer_path_ctl_info(codec, &mixer);
+	if (mixer.audio_mode_play || mixer.audio_mode_cap
+	    || mixer.mainmic_play || mixer.submic_play || mixer.msmic_play
+	    || mixer.hsmic_play || mixer.btmic_play || mixer.lin1_play
+	    || mixer.dtmf_control)
+		return 0;
+
+	set_bias_level(codec, SND_SOC_BIAS_OFF);
+
+	mutex_lock(&mc_asoc->mutex);
+
+	err = mc_control(MCDRV_GET_HSDET,
+			 (unsigned long)&mc_asoc->hsdet_store, 0);
+	if (err < 0) {
+		dev_err(codec->dev, "Error in mc_asoc_suspend: %d\n", err);
+		goto error;
+	}
+
+	mc_asoc->hsdet_store.dly_irq_stop = hsdet_info_def.dly_irq_stop;
+
+	if (device_may_wakeup(codec->dev))
+		enable_irq_wake(mc_asoc->irq);
+
+	hsdet_info = hsdet_info_suspend;
+	if (!mc_asoc_ver_id)
+		hsdet_info.irq_type = MCDRV_IRQTYPE_NORMAL;
+
+	if (mc_asoc_jack_status != SND_JACK_HEADSET) {
+		hsdet_info.en_dly_key_off = MCDRV_KEYEN_D_D_D;
+		hsdet_info.en_dly_key_on = MCDRV_KEYEN_D_D_D;
+		hsdet_info.en_key_off = MCDRV_KEYEN_D_D_D;
+		hsdet_info.en_key_on = MCDRV_KEYEN_D_D_D;
+	}
+
+	hsdet_info.en_plug_det_db &= mc_asoc->hsdet_store.en_plug_det_db;
+	err = mc_control(MCDRV_SET_HSDET,
+			 (unsigned long)&hsdet_info, 0x7fffffff);
+	if (err < 0) {
+		dev_err(codec->dev, "Error in mc_asoc_suspend: %d\n", err);
+		goto error;
+	}
+
+	hsdet_info.cbfunc = headset_detect_callback;
+	err = mc_control(MCDRV_SET_HSDET,
+			 (unsigned long)&hsdet_info, 0x40000000);
+	if (err < 0) {
+		dev_err(codec->dev, "Error in mc_asoc_suspend: %d\n", err);
+		goto error;
+	}
+
+	mc_asoc_suspended = true;
+error:
+	mutex_unlock(&mc_asoc->mutex);
+
+	return err;
+}
+
+static int mc_asoc_resume(struct snd_soc_codec *codec)
+{
+	struct mc_asoc_data *mc_asoc;
+	struct mcdrv_hsdet_info hsdet_info;
+	int err;
+
+	if (!mc_asoc_suspended)
+		return 0;
+
+	mc_asoc = snd_soc_codec_get_drvdata(codec);
+	if (!mc_asoc)
+		return -EINVAL;
+
+	mutex_lock(&mc_asoc->mutex);
+
+	set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
+	err = mc_control(MCDRV_GET_HSDET, (unsigned long)&hsdet_info, 0);
+	if (err < 0) {
+		dev_err(codec->dev, "Error in mc_asoc_resume: %d\n", err);
+		goto error;
+	}
+
+	mc_asoc->hsdet_store.en_plug_det_db =
+	    hsdet_info_def.en_plug_det_db & hsdet_info.en_plug_det_db;
+	if (mc_asoc_jack_status != SND_JACK_HEADSET) {
+		mc_asoc->hsdet_store.en_dly_key_off = MCDRV_KEYEN_D_D_D;
+		mc_asoc->hsdet_store.en_dly_key_on = MCDRV_KEYEN_D_D_D;
+		mc_asoc->hsdet_store.en_key_off = MCDRV_KEYEN_D_D_D;
+		mc_asoc->hsdet_store.en_key_on = MCDRV_KEYEN_D_D_D;
+	} else {
+		mc_asoc->hsdet_store.en_dly_key_off =
+		    hsdet_info_def.en_dly_key_off;
+		mc_asoc->hsdet_store.en_dly_key_on =
+		    hsdet_info_def.en_dly_key_on;
+		mc_asoc->hsdet_store.en_key_off = hsdet_info_def.en_key_off;
+		mc_asoc->hsdet_store.en_key_on = hsdet_info_def.en_key_on;
+	}
+
+	mc_asoc->hsdet_store.cbfunc = NULL;
+	err = mc_control(MCDRV_SET_HSDET,
+			 (unsigned long)&mc_asoc->hsdet_store, 0x7fffffff);
+	if (err < 0) {
+		dev_err(codec->dev, "Error in mc_asoc_resume: %d\n", err);
+		goto error;
+	}
+
+	mc_asoc->hsdet_store.cbfunc = headset_detect_callback;
+	err = mc_control(MCDRV_SET_HSDET,
+			 (unsigned long)&mc_asoc->hsdet_store, 0x40000000);
+	if (err < 0) {
+		dev_err(codec->dev, "Error in mc_asoc_resume: %d\n", err);
+		goto error;
+	}
+
+	if (device_may_wakeup(codec->dev))
+		disable_irq_wake(mc_asoc->irq);
+
+	mc_asoc_suspended = false;
+
+error:
+	mutex_unlock(&mc_asoc->mutex);
+
+	return err;
+}
+
+static struct snd_soc_codec_driver mc_asoc_codec_dev = {
+	.probe = mc_asoc_probe,
+	.remove = mc_asoc_remove,
+	.suspend = mc_asoc_suspend,
+	.resume = mc_asoc_resume,
+	.read = mc_asoc_read_reg,
+	.write = mc_asoc_write_reg,
+	.reg_cache_size = MC_ASOC_N_REG,
+	.reg_word_size = sizeof(u16),
+	.reg_cache_step = 1,
+	.idle_bias_off = true,
+	.set_bias_level = set_bias_level
+};
+
+static int spi_rw(struct spi_device *spi_dev, u8 *tx, u8 *rx, int len)
+{
+	struct spi_message spi_msg;
+	struct spi_transfer spi_xfer;
+
+	spi_message_init(&spi_msg);
+
+	memset(&spi_xfer, 0, sizeof(spi_xfer));
+	spi_xfer.len = len;
+	spi_xfer.tx_buf = tx;
+	spi_xfer.rx_buf = rx;
+
+	spi_message_add_tail(&spi_xfer, &spi_msg);
+
+	if (spi_sync(spi_dev, &spi_msg)) {
+		dev_err(&spi_dev->dev, "spi_sync failure\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static u8 spi_buf[1024];
+
+static int mc_asoc_read_data(void *bus_priv, enum mcdrv_slave_addr slave_addr,
+			     u8 addr, u8 *data, u32 size)
+{
+	struct spi_device *spi_dev = (struct spi_device *)bus_priv;
+	u8 tx[2];
+	u8 *rx = NULL;
+	u8 *readbuf = spi_buf;
+	int err;
+
+	if (size + 1 > sizeof(spi_buf)) {
+		rx = kzalloc(size + 1, GFP_KERNEL);
+		if (!rx) {
+			dev_err(&spi_dev->dev, "Failed to allocate memory\n");
+			return -ENOMEM;
+		}
+
+		readbuf = rx;
+	}
+
+	tx[0] = (addr << 1) | 0x80;
+	tx[1] = 0;
+	if (size > 1)
+		tx[0] |= 0x01;	/* burst */
+
+	err = spi_rw(spi_dev, tx, readbuf, size + 1);
+	if (!err)
+		memcpy(data, readbuf + 1, size);
+
+	kfree(rx);
+
+	return err;
+}
+
+static int mc_asoc_write_data(void *bus_priv, enum mcdrv_slave_addr slave_addr,
+			      u8 *data, u32 size)
+{
+	struct spi_device *spi_dev = (struct spi_device *)bus_priv;
+
+	return spi_rw(spi_dev, data, NULL, size);
+}
+
+static struct mcdrv_bus_ops mc_asoc_bus_ops = {
+	.read = mc_asoc_read_data,
+	.write = mc_asoc_write_data,
+};
+
+static int __devinit mc_asoc_spi_probe(struct spi_device *spi)
+{
+	struct mc_asoc_data *mc_asoc;
+	int err;
+
+	mc_asoc = kzalloc(sizeof(struct mc_asoc_data), GFP_KERNEL);
+	if (!mc_asoc) {
+		dev_err(&spi->dev, "Failed to allocate memory\n");
+		return -ENOMEM;
+	}
+
+	mc_asoc->spi = spi;
+	mc_asoc->irq = spi->irq;
+	pr_info("MC ASOC IRQ1: %d\n", spi->irq);
+	mutex_init(&mc_asoc->mutex);
+	dev_set_drvdata(&spi->dev, mc_asoc);
+
+	err = snd_soc_register_codec(&spi->dev, &mc_asoc_codec_dev,
+				     mc_asoc_dai, ARRAY_SIZE(mc_asoc_dai));
+	if (err < 0) {
+		dev_set_drvdata(&spi->dev, NULL);
+		mutex_destroy(&mc_asoc->mutex);
+		kfree(mc_asoc);
+		dev_err(&spi->dev, "Failed to register codec: error=%d\n", err);
+		return err;
+	}
+
+	mc_asoc_bus_ops.priv = spi;
+	mc_bus_register(&mc_asoc_bus_ops);
+
+	return 0;
+}
+
+static int __devexit mc_asoc_spi_remove(struct spi_device *spi)
+{
+	struct mc_asoc_data *mc_asoc = dev_get_drvdata(&spi->dev);
+
+	if (mc_asoc) {
+		dev_set_drvdata(&spi->dev, NULL);
+		mutex_destroy(&mc_asoc->mutex);
+		kfree(mc_asoc);
+	}
+
+	mc_bus_register(NULL);
+	snd_soc_unregister_codec(&spi->dev);
+
+	return 0;
+}
+
+static struct spi_driver mc_asoc_spi_driver = {
+	.driver = {
+		   .name = MC_ASOC_NAME,
+		   .owner = THIS_MODULE,
+		   },
+	.probe = mc_asoc_spi_probe,
+	.remove = __devexit_p(mc_asoc_spi_remove),
+};
+
+static int __init ymu831_init(void)
+{
+	int err;
+
+	err = spi_register_driver(&mc_asoc_spi_driver);
+	if (err)
+		pr_err("Failed to register YMU831 SPI driver: %d\n", err);
+
+	return err;
+}
+
+module_init(ymu831_init);
+
+static void __exit ymu831_exit(void)
+{
+	spi_unregister_driver(&mc_asoc_spi_driver);
+}
+
+module_exit(ymu831_exit);
+
+MODULE_AUTHOR("Yamaha Corporation");
+MODULE_DESCRIPTION("Yamaha YMU831 ALSA SoC codec driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(MC_ASOC_DRIVER_VERSION);
diff --git a/sound/soc/codecs/ymu831/ymu831.h b/sound/soc/codecs/ymu831/ymu831.h
new file mode 100644
index 0000000..a38b976
--- /dev/null
+++ b/sound/soc/codecs/ymu831/ymu831.h
@@ -0,0 +1,48 @@
+/*
+ * YMU831 ASoC codec driver
+ *
+ * Copyright (c) 2012 Yamaha Corporation
+ *
+ * This software is provided 'as-is', without any express or implied
+ * warranty.  In no event will the authors be held liable for any damages
+ * arising from the use of this software.
+ *
+ * Permission is granted to anyone to use this software for any purpose,
+ * including commercial applications, and to alter it and redistribute it
+ * freely, subject to the following restrictions:
+ *
+ * 1. The origin of this software must not be misrepresented; you must not
+ *    claim that you wrote the original software. If you use this software
+ *    in a product, an acknowledgment in the product documentation would be
+ *    appreciated but is not required.
+ * 2. Altered source versions must be plainly marked as such, and must not be
+ *    misrepresented as being the original software.
+ * 3. This notice may not be removed or altered from any source distribution.
+ */
+/*
+ * changelog:
+ * - change in the Linux coding style
+ * - remove unnecessary comments
+ * - remove unused codes
+ */
+#ifndef _YMU831_H
+#define _YMU831_H
+
+#define MC_ASOC_NAME			"ymu831"
+
+/* div id */
+#define MC_ASOC_BCLK_MULT		5
+
+/* div for MC_ASOC_BCLK_MULT */
+#define MC_ASOC_LRCK_X64		0
+#define MC_ASOC_LRCK_X48		1
+#define MC_ASOC_LRCK_X32		2
+#define MC_ASOC_LRCK_X512		3
+#define MC_ASOC_LRCK_X256		4
+#define MC_ASOC_LRCK_X192		5
+#define MC_ASOC_LRCK_X128		6
+#define MC_ASOC_LRCK_X96		7
+#define MC_ASOC_LRCK_X24		8
+#define MC_ASOC_LRCK_X16		9
+
+#endif /* _YMU831_H */
diff --git a/sound/soc/codecs/ymu831/ymu831_priv.h b/sound/soc/codecs/ymu831/ymu831_priv.h
new file mode 100644
index 0000000..10bce05
--- /dev/null
+++ b/sound/soc/codecs/ymu831/ymu831_priv.h
@@ -0,0 +1,278 @@
+/*
+ * YMU831 ASoC codec driver - private header
+ *
+ * Copyright (c) 2012 Yamaha Corporation
+ *
+ * This software is provided 'as-is', without any express or implied
+ * warranty.  In no event will the authors be held liable for any damages
+ * arising from the use of this software.
+ *
+ * Permission is granted to anyone to use this software for any purpose,
+ * including commercial applications, and to alter it and redistribute it
+ * freely, subject to the following restrictions:
+ *
+ * 1. The origin of this software must not be misrepresented; you must not
+ *    claim that you wrote the original software. If you use this software
+ *    in a product, an acknowledgment in the product documentation would be
+ *    appreciated but is not required.
+ * 2. Altered source versions must be plainly marked as such, and must not be
+ *    misrepresented as being the original software.
+ * 3. This notice may not be removed or altered from any source distribution.
+ */
+/*
+ * changelog:
+ * - change in the Linux coding style
+ * - remove unnecessary comments
+ * - remove unused codes
+ */
+#ifndef _YMU831_PRIV_H
+#define _YMU831_PRIV_H
+
+#include <linux/spi/spi.h>
+
+#include "mcdriver.h"
+
+#undef MC_ASOC_TEST
+
+/*
+ * Virtual registers
+ */
+enum {
+	MC_ASOC_DVOL_MUSICIN,
+	MC_ASOC_DVOL_EXTIN,
+	MC_ASOC_DVOL_VOICEIN,
+	MC_ASOC_DVOL_REFIN,
+	MC_ASOC_DVOL_ADIF0IN,
+	MC_ASOC_DVOL_ADIF1IN,
+	MC_ASOC_DVOL_ADIF2IN,
+	MC_ASOC_DVOL_MUSICOUT,
+	MC_ASOC_DVOL_EXTOUT,
+	MC_ASOC_DVOL_VOICEOUT,
+	MC_ASOC_DVOL_REFOUT,
+	MC_ASOC_DVOL_DAC0OUT,
+	MC_ASOC_DVOL_DAC1OUT,
+	MC_ASOC_DVOL_DPATHDA,
+	MC_ASOC_DVOL_DPATHAD,
+	MC_ASOC_AVOL_LINEIN1,
+	MC_ASOC_AVOL_MIC1,
+	MC_ASOC_AVOL_MIC2,
+	MC_ASOC_AVOL_MIC3,
+	MC_ASOC_AVOL_MIC4,
+	MC_ASOC_AVOL_HP,
+	MC_ASOC_AVOL_SP,
+	MC_ASOC_AVOL_RC,
+	MC_ASOC_AVOL_LINEOUT1,
+	MC_ASOC_AVOL_LINEOUT2,
+	MC_ASOC_AVOL_SP_GAIN,
+
+	MC_ASOC_DVOL_MASTER,
+	MC_ASOC_DVOL_VOICE,
+	MC_ASOC_DVOL_APLAY_A,
+	MC_ASOC_DVOL_APLAY_D,
+
+	MC_ASOC_VOICE_RECORDING,
+
+	MC_ASOC_AUDIO_MODE_PLAY,
+	MC_ASOC_AUDIO_MODE_CAP,
+	MC_ASOC_OUTPUT_PATH,
+	MC_ASOC_INPUT_PATH,
+	MC_ASOC_INCALL_MIC_SP,
+	MC_ASOC_INCALL_MIC_RC,
+	MC_ASOC_INCALL_MIC_HP,
+	MC_ASOC_INCALL_MIC_LO1,
+	MC_ASOC_INCALL_MIC_LO2,
+
+	MC_ASOC_MAINMIC_PLAYBACK_PATH,
+	MC_ASOC_SUBMIC_PLAYBACK_PATH,
+	MC_ASOC_2MIC_PLAYBACK_PATH,
+	MC_ASOC_HSMIC_PLAYBACK_PATH,
+	MC_ASOC_BTMIC_PLAYBACK_PATH,
+	MC_ASOC_LIN1_PLAYBACK_PATH,
+
+	MC_ASOC_DTMF_CONTROL,
+	MC_ASOC_DTMF_OUTPUT,
+
+	MC_ASOC_SWITCH_CLOCK,
+
+	MC_ASOC_EXT_MASTERSLAVE,
+	MC_ASOC_EXT_RATE,
+	MC_ASOC_EXT_BITCLOCK_RATE,
+	MC_ASOC_EXT_INTERFACE,
+	MC_ASOC_EXT_BITCLOCK_INVERT,
+	MC_ASOC_EXT_INPUT_DA_BIT_WIDTH,
+	MC_ASOC_EXT_INPUT_DA_FORMAT,
+	MC_ASOC_EXT_INPUT_PCM_MONOSTEREO,
+	MC_ASOC_EXT_INPUT_PCM_BIT_ORDER,
+	MC_ASOC_EXT_INPUT_PCM_FORMAT,
+	MC_ASOC_EXT_INPUT_PCM_BIT_WIDTH,
+	MC_ASOC_EXT_OUTPUT_DA_BIT_WIDTH,
+	MC_ASOC_EXT_OUTPUT_DA_FORMAT,
+	MC_ASOC_EXT_OUTPUT_PCM_MONOSTEREO,
+	MC_ASOC_EXT_OUTPUT_PCM_BIT_ORDER,
+	MC_ASOC_EXT_OUTPUT_PCM_FORMAT,
+	MC_ASOC_EXT_OUTPUT_PCM_BIT_WIDTH,
+
+	MC_ASOC_VOICE_MASTERSLAVE,
+	MC_ASOC_VOICE_RATE,
+	MC_ASOC_VOICE_BITCLOCK_RATE,
+	MC_ASOC_VOICE_INTERFACE,
+	MC_ASOC_VOICE_BITCLOCK_INVERT,
+	MC_ASOC_VOICE_INPUT_DA_BIT_WIDTH,
+	MC_ASOC_VOICE_INPUT_DA_FORMAT,
+	MC_ASOC_VOICE_INPUT_PCM_MONOSTEREO,
+	MC_ASOC_VOICE_INPUT_PCM_BIT_ORDER,
+	MC_ASOC_VOICE_INPUT_PCM_FORMAT,
+	MC_ASOC_VOICE_INPUT_PCM_BIT_WIDTH,
+	MC_ASOC_VOICE_OUTPUT_DA_BIT_WIDTH,
+	MC_ASOC_VOICE_OUTPUT_DA_FORMAT,
+	MC_ASOC_VOICE_OUTPUT_PCM_MONOSTEREO,
+	MC_ASOC_VOICE_OUTPUT_PCM_BIT_ORDER,
+	MC_ASOC_VOICE_OUTPUT_PCM_FORMAT,
+	MC_ASOC_VOICE_OUTPUT_PCM_BIT_WIDTH,
+
+	MC_ASOC_MUSIC_PHYSICAL_PORT,
+	MC_ASOC_EXT_PHYSICAL_PORT,
+	MC_ASOC_VOICE_PHYSICAL_PORT,
+	MC_ASOC_HIFI_PHYSICAL_PORT,
+
+	MC_ASOC_ADIF0_SWAP,
+	MC_ASOC_ADIF1_SWAP,
+	MC_ASOC_ADIF2_SWAP,
+
+	MC_ASOC_DAC0_SWAP,
+	MC_ASOC_DAC1_SWAP,
+
+	MC_ASOC_MUSIC_OUT0_SWAP,
+
+	MC_ASOC_MUSIC_IN0_SWAP,
+	MC_ASOC_MUSIC_IN1_SWAP,
+	MC_ASOC_MUSIC_IN2_SWAP,
+
+	MC_ASOC_EXT_IN_SWAP,
+
+	MC_ASOC_VOICE_IN_SWAP,
+
+	MC_ASOC_MUSIC_OUT1_SWAP,
+	MC_ASOC_MUSIC_OUT2_SWAP,
+
+	MC_ASOC_EXT_OUT_SWAP,
+
+	MC_ASOC_VOICE_OUT_SWAP,
+
+	MC_ASOC_ADIF0_SOURCE,
+	MC_ASOC_ADIF1_SOURCE,
+	MC_ASOC_ADIF2_SOURCE,
+
+	MC_ASOC_PARAMETER_SETTING,
+
+	MC_ASOC_MAIN_MIC,
+	MC_ASOC_SUB_MIC,
+	MC_ASOC_HS_MIC,
+#ifdef MC_ASOC_TEST
+	MC_ASOC_MIC1_BIAS,
+	MC_ASOC_MIC2_BIAS,
+	MC_ASOC_MIC3_BIAS,
+	MC_ASOC_MIC4_BIAS,
+#endif
+
+	MC_ASOC_N_REG
+};
+
+#define MC_ASOC_N_VOL_REG			(MC_ASOC_DVOL_APLAY_D + 1)
+
+#define MC_ASOC_AUDIO_MODE_OFF			0
+#define MC_ASOC_AUDIO_MODE_AUDIO		1
+#define MC_ASOC_AUDIO_MODE_INCALL		2
+#define MC_ASOC_AUDIO_MODE_AUDIO_INCALL		3
+#define MC_ASOC_AUDIO_MODE_INCOMM		4
+#define MC_ASOC_AUDIO_MODE_KARAOKE		5
+#define MC_ASOC_AUDIO_MODE_AUDIOEX		5
+#define MC_ASOC_AUDIO_MODE_AUDIOVR		6
+#define MC_ASOC_AUDIO_MODE_INCALL2		6
+#define MC_ASOC_AUDIO_MODE_AUDIO_INCALL2	7
+#define MC_ASOC_AUDIO_MODE_INCOMM2		8
+
+#define MC_ASOC_OUTPUT_PATH_SP			0
+#define MC_ASOC_OUTPUT_PATH_RC			1
+#define MC_ASOC_OUTPUT_PATH_HP			2
+#define MC_ASOC_OUTPUT_PATH_HS			3
+#define MC_ASOC_OUTPUT_PATH_LO1			4
+#define MC_ASOC_OUTPUT_PATH_LO2			5
+#define MC_ASOC_OUTPUT_PATH_BT			6
+#define MC_ASOC_OUTPUT_PATH_SP_RC		7
+#define MC_ASOC_OUTPUT_PATH_SP_HP		8
+#define MC_ASOC_OUTPUT_PATH_SP_LO1		9
+#define MC_ASOC_OUTPUT_PATH_SP_LO2		10
+#define MC_ASOC_OUTPUT_PATH_SP_BT		11
+#define MC_ASOC_OUTPUT_PATH_LO1_RC		12
+#define MC_ASOC_OUTPUT_PATH_LO1_HP		13
+#define MC_ASOC_OUTPUT_PATH_LO1_BT		14
+#define MC_ASOC_OUTPUT_PATH_LO2_RC		15
+#define MC_ASOC_OUTPUT_PATH_LO2_HP		16
+#define MC_ASOC_OUTPUT_PATH_LO2_BT		17
+#define MC_ASOC_OUTPUT_PATH_LO1_LO2		18
+#define MC_ASOC_OUTPUT_PATH_LO2_LO1		19
+
+#define MC_ASOC_INPUT_PATH_MAINMIC		0
+#define MC_ASOC_INPUT_PATH_SUBMIC		1
+#define MC_ASOC_INPUT_PATH_2MIC			2
+#define MC_ASOC_INPUT_PATH_HS			3
+#define MC_ASOC_INPUT_PATH_BT			4
+#define MC_ASOC_INPUT_PATH_VOICECALL		5
+#define MC_ASOC_INPUT_PATH_VOICEUPLINK		6
+#define MC_ASOC_INPUT_PATH_VOICEDOWNLINK	7
+#define MC_ASOC_INPUT_PATH_LIN1			8
+
+#define MC_ASOC_INCALL_MIC_MAINMIC		0
+#define MC_ASOC_INCALL_MIC_SUBMIC		1
+#define MC_ASOC_INCALL_MIC_2MIC			2
+
+#define MC_ASOC_DTMF_OUTPUT_SP			0
+#define MC_ASOC_DTMF_OUTPUT_NORMAL		1
+
+struct mc_asoc_setup {
+	struct mcdrv_dev_info info;
+	unsigned char rslot[3];
+	unsigned char tslot[3];
+};
+
+struct mc_asoc_port_params {
+	u8 rate;
+	u8 bits[SNDRV_PCM_STREAM_LAST + 1];
+	u8 pcm_mono[SNDRV_PCM_STREAM_LAST + 1];
+	u8 pcm_order[SNDRV_PCM_STREAM_LAST + 1];
+	u8 pcm_law[SNDRV_PCM_STREAM_LAST + 1];
+	u8 master;
+	u8 inv;
+	u8 srcthru;
+	u8 format;
+	u8 bckfs;
+	u8 channels;
+	u8 stream;		/* bit0: Playback, bit1: Capture */
+};
+
+struct mc_asoc_dsp_params {
+	u8 *pab_param;
+	u32 size;
+	struct mc_asoc_dsp_params *next;
+};
+
+struct mc_asoc_data {
+	int irq;
+	struct spi_device *spi;
+	struct mutex mutex;
+	struct workqueue_struct *workqueue;
+	struct work_struct work;
+	struct mc_asoc_setup setup;
+	struct mc_asoc_port_params port;
+	u8 clocksw_store;
+	struct mcdrv_path_info path_store;
+	struct mcdrv_vol_info vol_store;
+	struct mcdrv_dio_info dio_store;
+	struct mcdrv_dio_path_info diopath_store;
+	struct mcdrv_swap_info swap_store;
+	struct mcdrv_hsdet_info hsdet_store;
+	struct mc_asoc_dsp_params params_store[4][2];
+};
+
+#endif /* _YMU831_PRIV_H */
-- 
1.7.9.5
