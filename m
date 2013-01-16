From: Yoichi Yuasa <yuasa@linux-mips.org>
Subject: [PATCH 18/19] ALSA: ymu831: add hwdep ioctl
Date: Wed, 16 Jan 2013 17:44:29 +0900
Message-ID: <20130116174429.c9f25228f247679ae7906f71@linux-mips.org>
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
 include/uapi/sound/asound.h           |    3 +-
 include/uapi/sound/ymu831.h           |   81 +++++
 sound/soc/codecs/ymu831/ymu831.c      |  585 +++++++++++++++++++++++++++++++++
 sound/soc/codecs/ymu831/ymu831_priv.h |    5 +-
 4 files changed, 672 insertions(+), 2 deletions(-)
 create mode 100644 include/uapi/sound/ymu831.h

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 1774a5c..e13b05e 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -93,9 +93,10 @@ enum {
 	SNDRV_HWDEP_IFACE_SB_RC,	/* SB Extigy/Audigy2NX remote control */
 	SNDRV_HWDEP_IFACE_HDA,		/* HD-audio */
 	SNDRV_HWDEP_IFACE_USB_STREAM,	/* direct access to usb stream */
+	SNDRV_HWDEP_IFACE_YMU831,	/* Yamaha YMU831 */
 
 	/* Don't forget to change the following: */
-	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_USB_STREAM
+	SNDRV_HWDEP_IFACE_LAST = SNDRV_HWDEP_IFACE_YMU831
 };
 
 struct snd_hwdep_info {
diff --git a/include/uapi/sound/ymu831.h b/include/uapi/sound/ymu831.h
new file mode 100644
index 0000000..d5c22b3
--- /dev/null
+++ b/include/uapi/sound/ymu831.h
@@ -0,0 +1,81 @@
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
+ * - split from sound/soc/codecs/ymu831/ymu831.h
+ */
+#ifndef _UAPI__SOUND_YMU831_H
+#define _UAPI__SOUND_YMU831_H
+
+#define MC_ASOC_MAGIC			'N'
+#define MC_ASOC_IOCTL_SET_CTRL		1
+#define MC_ASOC_IOCTL_NOTIFY_HOLD	4
+
+struct ymc_ctrl_args {
+	void *param;
+	unsigned long size;
+	unsigned long option;
+};
+
+#define YMC_IOCTL_SET_CTRL \
+	_IOW(MC_ASOC_MAGIC, MC_ASOC_IOCTL_SET_CTRL, struct ymc_ctrl_args)
+
+#define YMC_IOCTL_NOTIFY_HOLD \
+	_IOWR(MC_ASOC_MAGIC, MC_ASOC_IOCTL_NOTIFY_HOLD, unsigned long)
+
+#define YMC_DSP_OUTPUT_BASE		0x00000000
+#define YMC_DSP_OUTPUT_SP		0x00000001
+#define YMC_DSP_OUTPUT_RC		0x00000002
+#define YMC_DSP_OUTPUT_HP		0x00000003
+#define YMC_DSP_OUTPUT_LO1		0x00000004
+#define YMC_DSP_OUTPUT_LO2		0x00000005
+#define YMC_DSP_OUTPUT_BT		0x00000006
+
+#define YMC_DSP_INPUT_BASE		0x00000010
+#define YMC_DSP_INPUT_MAINMIC		0x00000020
+#define YMC_DSP_INPUT_SUBMIC		0x00000030
+#define YMC_DSP_INPUT_2MIC		0x00000040
+#define YMC_DSP_INPUT_HEADSET		0x00000050
+#define YMC_DSP_INPUT_BT		0x00000060
+#define YMC_DSP_INPUT_LINEIN1		0x00000070
+#define YMC_DSP_INPUT_LINEIN2		0x00000080
+
+#define YMC_DSP_VOICECALL_BASE_1MIC	0x00000100
+#define YMC_DSP_VOICECALL_BASE_2MIC	0x00000200
+#define YMC_DSP_VOICECALL_SP_1MIC	0x00000300
+#define YMC_DSP_VOICECALL_SP_2MIC	0x00000400
+#define YMC_DSP_VOICECALL_RC_1MIC	0x00000500
+#define YMC_DSP_VOICECALL_RC_2MIC	0x00000600
+#define YMC_DSP_VOICECALL_HP_1MIC	0x00000700
+#define YMC_DSP_VOICECALL_HP_2MIC	0x00000800
+#define YMC_DSP_VOICECALL_LO1_1MIC	0x00000900
+#define YMC_DSP_VOICECALL_LO1_2MIC	0x00000a00
+#define YMC_DSP_VOICECALL_LO2_1MIC	0x00000b00
+#define YMC_DSP_VOICECALL_LO2_2MIC	0x00000c00
+#define YMC_DSP_VOICECALL_HEADSET	0x00000d00
+#define YMC_DSP_VOICECALL_BT		0x00000e00
+#define YMC_DSP_VOICECALL_BASE_COMMON	0x00000f00
+
+#define YMC_NOTITY_HOLD_OFF		0
+#define YMC_NOTITY_HOLD_ON		1
+
+#endif /* _UAPI__SOUND_YMU831_H */
diff --git a/sound/soc/codecs/ymu831/ymu831.c b/sound/soc/codecs/ymu831/ymu831.c
index 62c4a90..f6a32ce 100644
--- a/sound/soc/codecs/ymu831/ymu831.c
+++ b/sound/soc/codecs/ymu831/ymu831.c
@@ -46,6 +46,8 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 
+#include <uapi/sound/ymu831.h>
+
 #include "mcdevif.h"
 #include "mcdriver.h"
 #include "ymu831.h"
@@ -62,6 +64,8 @@
 				 SNDRV_PCM_FMTBIT_S20_3LE |	\
 				 SNDRV_PCM_FMTBIT_S24_3LE)
 
+#define MC_ASOC_HWDEP_ID	MC_ASOC_NAME
+
 #define get_port_id(id)		(id - 1)
 
 #define PORT_MUSIC		0
@@ -129,6 +133,7 @@ static const struct mc_asoc_info_store info_store_tbl[] = {
 struct snd_soc_codec *mc_asoc_codec;
 
 static u8 mc_asoc_ver_id = 1;
+static u8 mc_asoc_hold = YMC_NOTITY_HOLD_OFF;
 static bool mc_asoc_suspended;
 static u8 mc_asoc_hpimpclass = 0xff;
 static u8 mc_asoc_jack_status;
@@ -3238,6 +3243,33 @@ static void auto_powerdown(struct snd_soc_codec *codec)
 #endif
 }
 
+static int add_dsp_param(struct mc_asoc_data *mc_asoc, int i, int j,
+			 u8 *param, u32 size)
+{
+	struct mc_asoc_dsp_params *dsp_params, *next;
+
+	dsp_params = &mc_asoc->params_store[i][j];
+	while (dsp_params->pab_param) {
+		if (!dsp_params->next) {
+			next = kzalloc(sizeof(struct mc_asoc_dsp_params),
+				       GFP_KERNEL);
+			if (!next)
+				return -ENOMEM;
+
+			dsp_params->next = next;
+			dsp_params = dsp_params->next;
+			break;
+		}
+
+		dsp_params = dsp_params->next;
+	}
+
+	dsp_params->pab_param = param;
+	dsp_params->size = size;
+
+	return 0;
+}
+
 static void del_dsp_param(struct mc_asoc_data *mc_asoc)
 {
 	struct mc_asoc_dsp_params *dsp_params, *next;
@@ -3287,6 +3319,9 @@ static int set_audio_mode_play(struct snd_soc_codec *codec, unsigned int value)
 	if (!value)
 		del_dsp_param(mc_asoc);
 
+	if (mc_asoc_hold == YMC_NOTITY_HOLD_ON)
+		return 0;
+
 	ret = connect_path(codec);
 	if (!value)
 		auto_powerdown(codec);
@@ -3319,6 +3354,9 @@ static int set_audio_mode_cap(struct snd_soc_codec *codec, unsigned int value)
 	if (!value)
 		del_dsp_param(mc_asoc);
 
+	if (mc_asoc_hold == YMC_NOTITY_HOLD_ON)
+		return 0;
+
 	ret = connect_path(codec);
 	if (!value)
 		auto_powerdown(codec);
@@ -3361,6 +3399,9 @@ static int set_incall_mic(struct snd_soc_codec *codec,
 		dsp_params = dsp_params->next;
 	}
 
+	if (mc_asoc_hold == YMC_NOTITY_HOLD_ON)
+		return 0;
+
 	return connect_path(codec);
 }
 
@@ -3395,6 +3436,9 @@ static int set_ain_playback(struct snd_soc_codec *codec,
 	    && audio_mode_cap == MC_ASOC_AUDIO_MODE_INCOMM)
 		return 0;
 
+	if (mc_asoc_hold == YMC_NOTITY_HOLD_ON)
+		return 0;
+
 	ret = connect_path(codec);
 	if (!value)
 		auto_powerdown(codec);
@@ -3411,6 +3455,9 @@ static int set_dtmf_control(struct snd_soc_codec *codec,
 	if (ret < 0)
 		return ret;
 
+	if (mc_asoc_hold == YMC_NOTITY_HOLD_ON)
+		return 0;
+
 	ret = connect_path(codec);
 	if (!value)
 		auto_powerdown(codec);
@@ -3427,6 +3474,9 @@ static int set_dtmf_output(struct snd_soc_codec *codec,
 	if (ret < 0)
 		return ret;
 
+	if (mc_asoc_hold == YMC_NOTITY_HOLD_ON)
+		return 0;
+
 	return connect_path(codec);
 }
 
@@ -4233,6 +4283,535 @@ static int mc_asoc_add_widgets(struct snd_soc_codec *codec)
 	return snd_soc_dapm_new_widgets(&codec->dapm);
 }
 
+static int mc_asoc_hwdep_ioctl(struct snd_hwdep *hw, struct file *file,
+			       unsigned int cmd, unsigned long arg)
+{
+	struct snd_soc_codec *codec;
+	struct mc_asoc_data *mc_asoc;
+	struct ymc_ctrl_args ymc_ctrl_arg;
+	u32 hold;
+	u8 *param;
+	int output_path, input_path, incall_mic;
+	int err = 0;
+
+	if (!hw)
+		return -EINVAL;
+
+	codec = hw->private_data;
+	if (!codec)
+		return -EINVAL;
+
+	mc_asoc = snd_soc_codec_get_drvdata(codec);
+	if (!mc_asoc)
+		return -EINVAL;
+
+	output_path = read_cache(codec, MC_ASOC_OUTPUT_PATH);
+	if (output_path < 0)
+		return -EIO;
+
+	input_path = read_cache(codec, MC_ASOC_INPUT_PATH);
+	if (input_path < 0)
+		return -EIO;
+
+	incall_mic = get_incall_mic(codec, output_path);
+	if (incall_mic < 0)
+		return -EIO;
+
+	switch (cmd) {
+	case YMC_IOCTL_SET_CTRL:
+		if (!access_ok(VERIFY_READ,
+			       (struct ymc_ctrl_args *)arg,
+			       sizeof(struct ymc_ctrl_args)))
+			return -EFAULT;
+		if (copy_from_user(&ymc_ctrl_arg,
+				   (struct ymc_ctrl_args *)arg,
+				   sizeof(struct ymc_ctrl_args))) {
+			return -EFAULT;
+		}
+
+		if (ymc_ctrl_arg.size == 0)
+			break;
+		if (ymc_ctrl_arg.size > MAX_YMS_CTRL_PARAM_SIZE)
+			return -ENOMEM;
+
+		param = kzalloc(ymc_ctrl_arg.size, GFP_KERNEL);
+		if (!param)
+			return -ENOMEM;
+
+		if (copy_from_user(param, ymc_ctrl_arg.param,
+				   ymc_ctrl_arg.size)) {
+			err = -EFAULT;
+			goto error;
+		}
+
+		switch (ymc_ctrl_arg.option) {
+		case YMC_DSP_OUTPUT_BASE:
+			err = add_dsp_param(mc_asoc, DSP_PRM_OUTPUT,
+					    DSP_PRM_BASE, param,
+					    ymc_ctrl_arg.size);
+			break;
+		case YMC_DSP_INPUT_BASE:
+			err = add_dsp_param(mc_asoc, DSP_PRM_INPUT,
+					    DSP_PRM_BASE, param,
+					    ymc_ctrl_arg.size);
+			break;
+		case YMC_DSP_VOICECALL_BASE_COMMON:
+			err = add_dsp_param(mc_asoc, DSP_PRM_VC_1MIC,
+					    DSP_PRM_BASE, param,
+					    ymc_ctrl_arg.size);
+			if (err)
+				goto error;
+
+			param = kzalloc(ymc_ctrl_arg.size, GFP_KERNEL);
+			if (!param) {
+				err = -ENOMEM;
+				goto error;
+			}
+
+			if (copy_from_user(param, ymc_ctrl_arg.param,
+					   ymc_ctrl_arg.size)) {
+				err = -EFAULT;
+				goto error;
+			}
+
+			err = add_dsp_param(mc_asoc, DSP_PRM_VC_2MIC,
+					    DSP_PRM_BASE, param,
+					    ymc_ctrl_arg.size);
+			break;
+		case YMC_DSP_VOICECALL_BASE_1MIC:
+			err = add_dsp_param(mc_asoc, DSP_PRM_VC_1MIC,
+					    DSP_PRM_BASE, param,
+					    ymc_ctrl_arg.size);
+			if (err)
+				goto error;
+
+			if (incall_mic != MC_ASOC_INCALL_MIC_MAINMIC
+			    && incall_mic != MC_ASOC_INCALL_MIC_SUBMIC)
+				goto exit;
+			break;
+		case YMC_DSP_VOICECALL_BASE_2MIC:
+			err = add_dsp_param(mc_asoc, DSP_PRM_VC_2MIC,
+					    DSP_PRM_BASE, param,
+					    ymc_ctrl_arg.size);
+			if (err)
+				goto error;
+
+			if (incall_mic != MC_ASOC_INCALL_MIC_2MIC)
+				goto exit;
+			break;
+		case YMC_DSP_OUTPUT_SP:
+			if (output_path != MC_ASOC_OUTPUT_PATH_SP) {
+				kfree(param);
+				goto exit;
+			}
+
+			err = add_dsp_param(mc_asoc, DSP_PRM_OUTPUT,
+					    DSP_PRM_USER, param,
+					    ymc_ctrl_arg.size);
+			break;
+		case YMC_DSP_OUTPUT_RC:
+			if (output_path != MC_ASOC_OUTPUT_PATH_RC
+			    && output_path != MC_ASOC_OUTPUT_PATH_SP_RC
+			    && output_path != MC_ASOC_OUTPUT_PATH_LO1_RC
+			    && output_path != MC_ASOC_OUTPUT_PATH_LO2_RC) {
+				kfree(param);
+				goto exit;
+			}
+
+			err = add_dsp_param(mc_asoc, DSP_PRM_OUTPUT,
+					    DSP_PRM_USER, param,
+					    ymc_ctrl_arg.size);
+			break;
+		case YMC_DSP_OUTPUT_HP:
+			if (output_path != MC_ASOC_OUTPUT_PATH_HP
+			    && output_path != MC_ASOC_OUTPUT_PATH_HS
+			    && output_path != MC_ASOC_OUTPUT_PATH_SP_HP
+			    && output_path != MC_ASOC_OUTPUT_PATH_LO1_HP
+			    && output_path != MC_ASOC_OUTPUT_PATH_LO2_HP) {
+				kfree(param);
+				goto exit;
+			}
+
+			err = add_dsp_param(mc_asoc, DSP_PRM_OUTPUT,
+					    DSP_PRM_USER, param,
+					    ymc_ctrl_arg.size);
+			break;
+		case YMC_DSP_OUTPUT_LO1:
+			if (output_path != MC_ASOC_OUTPUT_PATH_LO1
+			    && output_path != MC_ASOC_OUTPUT_PATH_SP_LO1
+			    && output_path != MC_ASOC_OUTPUT_PATH_LO2_LO1) {
+				kfree(param);
+				goto exit;
+			}
+
+			err = add_dsp_param(mc_asoc, DSP_PRM_OUTPUT,
+					    DSP_PRM_USER, param,
+					    ymc_ctrl_arg.size);
+			break;
+		case YMC_DSP_OUTPUT_LO2:
+			if (output_path != MC_ASOC_OUTPUT_PATH_LO2
+			    && output_path != MC_ASOC_OUTPUT_PATH_SP_LO2
+			    && output_path != MC_ASOC_OUTPUT_PATH_LO1_LO2) {
+				kfree(param);
+				goto exit;
+			}
+
+			err = add_dsp_param(mc_asoc, DSP_PRM_OUTPUT,
+					    DSP_PRM_USER, param,
+					    ymc_ctrl_arg.size);
+			break;
+		case YMC_DSP_OUTPUT_BT:
+			if (output_path != MC_ASOC_OUTPUT_PATH_BT
+			    && output_path != MC_ASOC_OUTPUT_PATH_SP_BT
+			    && output_path != MC_ASOC_OUTPUT_PATH_LO1_BT
+			    && output_path != MC_ASOC_OUTPUT_PATH_LO2_BT) {
+				kfree(param);
+				goto exit;
+			}
+
+			err = add_dsp_param(mc_asoc, DSP_PRM_OUTPUT,
+					    DSP_PRM_USER, param,
+					    ymc_ctrl_arg.size);
+			break;
+		case YMC_DSP_INPUT_MAINMIC:
+			if (input_path != MC_ASOC_INPUT_PATH_MAINMIC) {
+				kfree(param);
+				goto exit;
+			}
+
+			err = add_dsp_param(mc_asoc, DSP_PRM_INPUT,
+					    DSP_PRM_USER, param,
+					    ymc_ctrl_arg.size);
+			break;
+		case YMC_DSP_INPUT_SUBMIC:
+			if (input_path != MC_ASOC_INPUT_PATH_SUBMIC) {
+				kfree(param);
+				goto exit;
+			}
+
+			err = add_dsp_param(mc_asoc, DSP_PRM_INPUT,
+					    DSP_PRM_USER, param,
+					    ymc_ctrl_arg.size);
+			break;
+		case YMC_DSP_INPUT_2MIC:
+			if (input_path != MC_ASOC_INPUT_PATH_2MIC) {
+				kfree(param);
+				goto exit;
+			}
+
+			err = add_dsp_param(mc_asoc, DSP_PRM_INPUT,
+					    DSP_PRM_USER, param,
+					    ymc_ctrl_arg.size);
+			break;
+		case YMC_DSP_INPUT_HEADSET:
+			if (input_path != MC_ASOC_INPUT_PATH_HS) {
+				kfree(param);
+				goto exit;
+			}
+
+			err = add_dsp_param(mc_asoc, DSP_PRM_INPUT,
+					    DSP_PRM_USER, param,
+					    ymc_ctrl_arg.size);
+			break;
+		case YMC_DSP_INPUT_BT:
+			if (input_path != MC_ASOC_INPUT_PATH_BT) {
+				kfree(param);
+				goto exit;
+			}
+
+			err = add_dsp_param(mc_asoc, DSP_PRM_INPUT,
+					    DSP_PRM_USER, param,
+					    ymc_ctrl_arg.size);
+			break;
+		case YMC_DSP_INPUT_LINEIN1:
+			if (input_path != MC_ASOC_INPUT_PATH_LIN1) {
+				kfree(param);
+				goto exit;
+			}
+
+			err = add_dsp_param(mc_asoc, DSP_PRM_INPUT,
+					    DSP_PRM_USER, param,
+					    ymc_ctrl_arg.size);
+			break;
+		case YMC_DSP_VOICECALL_SP_1MIC:
+			if (output_path != MC_ASOC_OUTPUT_PATH_SP) {
+				kfree(param);
+				goto exit;
+			}
+
+			err = add_dsp_param(mc_asoc, DSP_PRM_VC_1MIC,
+					    DSP_PRM_USER, param,
+					    ymc_ctrl_arg.size);
+			if (err)
+				goto error;
+			if (incall_mic != MC_ASOC_INCALL_MIC_MAINMIC
+			    && incall_mic != MC_ASOC_INCALL_MIC_SUBMIC)
+				goto exit;
+			break;
+		case YMC_DSP_VOICECALL_RC_1MIC:
+			if (output_path != MC_ASOC_OUTPUT_PATH_RC
+			    && output_path != MC_ASOC_OUTPUT_PATH_SP_RC
+			    && output_path != MC_ASOC_OUTPUT_PATH_LO1_RC
+			    && output_path != MC_ASOC_OUTPUT_PATH_LO2_RC) {
+				kfree(param);
+				goto exit;
+			}
+
+			err = add_dsp_param(mc_asoc, DSP_PRM_VC_1MIC,
+					    DSP_PRM_USER, param,
+					    ymc_ctrl_arg.size);
+			if (err)
+				goto error;
+
+			if (incall_mic != MC_ASOC_INCALL_MIC_MAINMIC
+			    && incall_mic != MC_ASOC_INCALL_MIC_SUBMIC)
+				goto exit;
+			break;
+		case YMC_DSP_VOICECALL_HP_1MIC:
+			if (output_path != MC_ASOC_OUTPUT_PATH_HP
+			    && output_path != MC_ASOC_OUTPUT_PATH_SP_HP
+			    && output_path != MC_ASOC_OUTPUT_PATH_LO1_HP
+			    && output_path != MC_ASOC_OUTPUT_PATH_LO2_HP) {
+				kfree(param);
+				goto exit;
+			}
+
+			err = add_dsp_param(mc_asoc, DSP_PRM_VC_1MIC,
+					    DSP_PRM_USER, param,
+					    ymc_ctrl_arg.size);
+			if (err)
+				goto error;
+
+			if (incall_mic != MC_ASOC_INCALL_MIC_MAINMIC
+			    && incall_mic != MC_ASOC_INCALL_MIC_SUBMIC)
+				goto exit;
+			break;
+		case YMC_DSP_VOICECALL_LO1_1MIC:
+			if (output_path != MC_ASOC_OUTPUT_PATH_LO1
+			    && output_path != MC_ASOC_OUTPUT_PATH_SP_LO1
+			    && output_path != MC_ASOC_OUTPUT_PATH_LO2_LO1) {
+				kfree(param);
+				goto exit;
+			}
+
+			err = add_dsp_param(mc_asoc, DSP_PRM_VC_1MIC,
+					    DSP_PRM_USER, param,
+					    ymc_ctrl_arg.size);
+			if (err)
+				goto error;
+
+			if (incall_mic != MC_ASOC_INCALL_MIC_MAINMIC
+			    && incall_mic != MC_ASOC_INCALL_MIC_SUBMIC)
+				goto exit;
+			break;
+		case YMC_DSP_VOICECALL_LO2_1MIC:
+			if (output_path != MC_ASOC_OUTPUT_PATH_LO2
+			    && output_path != MC_ASOC_OUTPUT_PATH_SP_LO2
+			    && output_path != MC_ASOC_OUTPUT_PATH_LO1_LO2) {
+				kfree(param);
+				goto exit;
+			}
+
+			err = add_dsp_param(mc_asoc, DSP_PRM_VC_1MIC,
+					    DSP_PRM_USER, param,
+					    ymc_ctrl_arg.size);
+			if (err)
+				goto error;
+
+			if (incall_mic != MC_ASOC_INCALL_MIC_MAINMIC
+			    && incall_mic != MC_ASOC_INCALL_MIC_SUBMIC)
+				goto exit;
+			break;
+		case YMC_DSP_VOICECALL_HEADSET:
+			if (output_path != MC_ASOC_OUTPUT_PATH_HS) {
+				kfree(param);
+				goto exit;
+			}
+
+			err = add_dsp_param(mc_asoc, DSP_PRM_VC_1MIC,
+					    DSP_PRM_USER, param,
+					    ymc_ctrl_arg.size);
+			if (err)
+				goto error;
+
+			if (incall_mic != MC_ASOC_INCALL_MIC_MAINMIC
+			    && incall_mic != MC_ASOC_INCALL_MIC_SUBMIC)
+				goto exit;
+			break;
+		case YMC_DSP_VOICECALL_BT:
+			if (output_path != MC_ASOC_OUTPUT_PATH_BT
+			    && output_path != MC_ASOC_OUTPUT_PATH_SP_BT
+			    && output_path != MC_ASOC_OUTPUT_PATH_LO1_BT
+			    && output_path != MC_ASOC_OUTPUT_PATH_LO2_BT) {
+				kfree(param);
+				goto exit;
+			}
+
+			err = add_dsp_param(mc_asoc, DSP_PRM_VC_2MIC,
+					    DSP_PRM_USER, param,
+					    ymc_ctrl_arg.size);
+			if (err)
+				goto error;
+
+			if (incall_mic != MC_ASOC_INCALL_MIC_MAINMIC
+			    && incall_mic != MC_ASOC_INCALL_MIC_SUBMIC)
+				goto exit;
+			break;
+		case YMC_DSP_VOICECALL_SP_2MIC:
+			if (output_path != MC_ASOC_OUTPUT_PATH_SP) {
+				kfree(param);
+				goto exit;
+			}
+
+			err = add_dsp_param(mc_asoc, DSP_PRM_VC_2MIC,
+					    DSP_PRM_USER, param,
+					    ymc_ctrl_arg.size);
+			if (err)
+				goto error;
+
+			if (incall_mic != MC_ASOC_INCALL_MIC_2MIC)
+				goto exit;
+			break;
+		case YMC_DSP_VOICECALL_RC_2MIC:
+			if (output_path != MC_ASOC_OUTPUT_PATH_RC
+			    && output_path != MC_ASOC_OUTPUT_PATH_SP_RC
+			    && output_path != MC_ASOC_OUTPUT_PATH_LO1_RC
+			    && output_path != MC_ASOC_OUTPUT_PATH_LO2_RC) {
+				kfree(param);
+				goto exit;
+			}
+
+			err = add_dsp_param(mc_asoc, DSP_PRM_VC_2MIC,
+					    DSP_PRM_USER, param,
+					    ymc_ctrl_arg.size);
+			if (err)
+				goto error;
+
+			if (incall_mic != MC_ASOC_INCALL_MIC_2MIC)
+				goto exit;
+			break;
+		case YMC_DSP_VOICECALL_HP_2MIC:
+			if (output_path != MC_ASOC_OUTPUT_PATH_HP
+			    && output_path != MC_ASOC_OUTPUT_PATH_HS
+			    && output_path != MC_ASOC_OUTPUT_PATH_SP_HP
+			    && output_path != MC_ASOC_OUTPUT_PATH_LO1_HP
+			    && output_path != MC_ASOC_OUTPUT_PATH_LO2_HP) {
+				kfree(param);
+				goto exit;
+			}
+
+			err = add_dsp_param(mc_asoc, DSP_PRM_VC_2MIC,
+					    DSP_PRM_USER, param,
+					    ymc_ctrl_arg.size);
+			if (err)
+				goto error;
+
+			if (incall_mic != MC_ASOC_INCALL_MIC_2MIC)
+				goto exit;
+			break;
+		case YMC_DSP_VOICECALL_LO1_2MIC:
+			if (output_path != MC_ASOC_OUTPUT_PATH_LO1
+			    && output_path != MC_ASOC_OUTPUT_PATH_SP_LO1
+			    && output_path != MC_ASOC_OUTPUT_PATH_LO2_LO1) {
+				kfree(param);
+				goto exit;
+			}
+
+			err = add_dsp_param(mc_asoc, DSP_PRM_VC_2MIC,
+					    DSP_PRM_USER, param,
+					    ymc_ctrl_arg.size);
+			if (err)
+				goto error;
+
+			if (incall_mic != MC_ASOC_INCALL_MIC_2MIC)
+				goto exit;
+			break;
+		case YMC_DSP_VOICECALL_LO2_2MIC:
+			if (output_path != MC_ASOC_OUTPUT_PATH_LO2
+			    && output_path != MC_ASOC_OUTPUT_PATH_SP_LO2
+			    && output_path != MC_ASOC_OUTPUT_PATH_LO1_LO2) {
+				kfree(param);
+				goto exit;
+			}
+
+			err = add_dsp_param(mc_asoc, DSP_PRM_VC_2MIC,
+					    DSP_PRM_USER, param,
+					    ymc_ctrl_arg.size);
+			if (err)
+				goto error;
+
+			if (incall_mic != MC_ASOC_INCALL_MIC_2MIC)
+				goto exit;
+			break;
+		default:
+			err = -EINVAL;
+			break;
+		}
+
+		if (err)
+			goto error;
+
+		err =
+		    mc_control(MCDRV_SET_DSP, (unsigned long)param,
+			       ymc_ctrl_arg.size);
+		break;
+	case YMC_IOCTL_NOTIFY_HOLD:
+		if (!access_ok(VERIFY_READ, (u32 *) arg, sizeof(u32)))
+			return -EFAULT;
+		if (copy_from_user(&hold, (u32 *) arg, sizeof(u32))) {
+			err = -EFAULT;
+			break;
+		}
+
+		switch (hold) {
+		case YMC_NOTITY_HOLD_OFF:
+			err = connect_path(codec);
+			if (!err)
+				auto_powerdown(codec);
+		case YMC_NOTITY_HOLD_ON:
+			mc_asoc_hold = hold;
+			break;
+		default:
+			err = -EINVAL;
+			break;
+		}
+		break;
+	default:
+		err = -EINVAL;
+	}
+exit:
+	return err;
+
+error:
+	kfree(param);
+
+	return err;
+}
+
+static int mc_asoc_add_hwdep(struct snd_soc_codec *codec)
+{
+	struct snd_hwdep *hw;
+	struct mc_asoc_data *mc_asoc;
+	int err;
+
+	mc_asoc = snd_soc_codec_get_drvdata(codec);
+	if (!mc_asoc)
+		return -EINVAL;
+
+	err = snd_hwdep_new(codec->card->snd_card, MC_ASOC_HWDEP_ID, 0, &hw);
+	if (err < 0)
+		return err;
+
+	hw->iface = SNDRV_HWDEP_IFACE_YMU831;
+	hw->private_data = codec;
+	hw->ops.ioctl = mc_asoc_hwdep_ioctl;
+	hw->exclusive = 1;
+	strcpy(hw->name, MC_ASOC_HWDEP_ID);
+	mc_asoc->hwdep = hw;
+
+	return 0;
+}
+
 static struct input_dev *inp_dev;
 
 static struct snd_soc_jack hs_jack;
@@ -4674,6 +5253,12 @@ static int mc_asoc_probe(struct snd_soc_codec *codec)
 		goto error;
 	}
 
+	err = mc_asoc_add_hwdep(codec);
+	if (err < 0) {
+		dev_err(dev, "Error in mc_asoc_add_hwdep: %d\n", err);
+		goto error;
+	}
+
 	snd_soc_cache_write(codec, MC_ASOC_EXT_MASTERSLAVE,
 			    ext_port_def.dio_common.master_slave);
 	snd_soc_cache_write(codec, MC_ASOC_EXT_RATE,
diff --git a/sound/soc/codecs/ymu831/ymu831_priv.h b/sound/soc/codecs/ymu831/ymu831_priv.h
index 10bce05..36ee29b 100644
--- a/sound/soc/codecs/ymu831/ymu831_priv.h
+++ b/sound/soc/codecs/ymu831/ymu831_priv.h
@@ -30,6 +30,8 @@
 
 #include <linux/spi/spi.h>
 
+#include <sound/hwdep.h>
+
 #include "mcdriver.h"
 
 #undef MC_ASOC_TEST
@@ -173,7 +175,7 @@ enum {
 	MC_ASOC_MIC2_BIAS,
 	MC_ASOC_MIC3_BIAS,
 	MC_ASOC_MIC4_BIAS,
-#endif
+#endif /* MC_ASOC_TEST */
 
 	MC_ASOC_N_REG
 };
@@ -273,6 +275,7 @@ struct mc_asoc_data {
 	struct mcdrv_swap_info swap_store;
 	struct mcdrv_hsdet_info hsdet_store;
 	struct mc_asoc_dsp_params params_store[4][2];
+	struct snd_hwdep *hwdep;
 };
 
 #endif /* _YMU831_PRIV_H */
-- 
1.7.9.5
