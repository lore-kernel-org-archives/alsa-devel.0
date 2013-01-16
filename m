From: Yoichi Yuasa <yuasa@linux-mips.org>
Subject: [PATCH 09/19] ALSA: ymu831: add F-DSP driver
Date: Wed, 16 Jan 2013 17:35:04 +0900
Message-ID: <20130116173504.5d35ab46692269b2b04b6fcb@linux-mips.org>
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
 sound/soc/codecs/ymu831/Makefile    |    3 +-
 sound/soc/codecs/ymu831/mcfdspdrv.c | 1666 +++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ymu831/mcfdspdrv.h |   55 ++
 3 files changed, 1723 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/codecs/ymu831/mcfdspdrv.c
 create mode 100644 sound/soc/codecs/ymu831/mcfdspdrv.h

diff --git a/sound/soc/codecs/ymu831/Makefile b/sound/soc/codecs/ymu831/Makefile
index d0586ca..c6809c0 100644
--- a/sound/soc/codecs/ymu831/Makefile
+++ b/sound/soc/codecs/ymu831/Makefile
@@ -3,6 +3,7 @@ snd-soc-ymu831-objs := \
 	mccdspdrv.o	\
 	mcdevif.o	\
 	mcdriver.o	\
-	mcedspdrv.o
+	mcedspdrv.o	\
+	mcfdspdrv.o
 
 obj-$(CONFIG_SND_SOC_YMU831) += snd-soc-ymu831.o
diff --git a/sound/soc/codecs/ymu831/mcfdspdrv.c b/sound/soc/codecs/ymu831/mcfdspdrv.c
new file mode 100644
index 0000000..9312b70
--- /dev/null
+++ b/sound/soc/codecs/ymu831/mcfdspdrv.c
@@ -0,0 +1,1666 @@
+/****************************************************************************
+ *
+ * Copyright(c) 2012 Yamaha Corporation. All rights reserved.
+ *
+ * Module	: mcfdspdrv.c
+ * Description	: MC F-DSP driver
+ * Version	: 1.0.0	Dec 13 2012
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
+ *
+ ****************************************************************************/
+/*
+ * changelog:
+ * - change in the Linux coding style
+ * - remove unnecessary comments
+ * - remove unused codes
+ */
+#include <linux/errno.h>
+#include <linux/types.h>
+
+#include <asm/byteorder.h>
+
+#include "mcdefs.h"
+#include "mcdevif.h"
+#include "mcfdspdrv.h"
+#include "mcresctrl.h"
+
+#define CHUNK_SIZE			8
+
+#define COEF_DMA_TRANS			0
+#define COEF_DSP_TRANS			1
+#define COEF_DSP_TRANS_MAX		512
+
+#define AEC_FDSP_TAG_FWCTRL		0x00000100
+#define FWCTRL_SIZE			27
+#define AEC_FDSP_TAG_CHSEL		0x00000200
+#define CHSEL_SIZE			33
+#define AEC_FDSP_TAG_TOP_ENV		0x00000300
+#define TOP_ENV_SIZE			29
+#define AEC_FDSP_TAG_TOP_COEF		0x00000400
+#define TOP_COEF_FIX_SIZE		8
+#define AEC_FDSP_TAG_TOP_INS		0x00000500
+#define TOP_INS_FIX_SIZE		8
+#define AEC_FDSP_TAG_APP_MASK		0xffffff00
+#define AEC_FDSP_TAG_APPNO_MASK		0xff
+#define AEC_FDSP_TAG_APP_ENV		0x00000600
+#define APP_ENV_FIX_SIZE		38
+#define AEC_FDSP_TAG_APP_COEF		0x00000700
+#define APP_COEF_FIX_SIZE		9
+#define AEC_FDSP_TAG_APP_CONST		0x00000800
+#define AEC_FDSP_TAG_APP_INS		0x00000900
+#define APP_INS_FIX_SIZE		8
+#define AEC_FDSP_TAG_APP_REG		0x00000a00
+#define APP_REG_FIX_SIZE		8
+#define AEC_FDSP_TAG_EX_INFO_1		0x00000b00
+#define EX_INFO_1_SIZE			4
+
+#define FWCTL_FWMOD			0
+#define FWCTL_FS			1
+#define FWCTL_APPEXEC			2
+#define FWCTL_FADECODE			26
+
+#define CHSEL_BYPASS			0
+#define CHSEL_INFDSPSRC			1
+#define CHSEL_OUTAUDIOSRC		17
+
+#define TOP_ENV_ID			0
+#define TOP_ENV_INSTBASE		1
+#define TOP_ENV_MBLKSIZE		5
+#define TOP_ENV_MBUFSIZE		6
+#define TOP_ENV_MOCHCNFG		7
+#define TOP_ENV_MICHCNFG		8
+#define TOP_ENV_SSTARTCH		9
+#define TOP_ENV_SNUMOFOCH		10
+#define TOP_ENV_SNUMOFICH		11
+#define TOP_ENV_SAVEBUFSIZE1		12
+#define TOP_ENV_SAVEBUFSIZE0		16
+#define TOP_ENV_LIMITWORKSIZE		20
+#define TOP_ENV_WORKBASE		24
+#define TOP_ENV_TOPBASE0		28
+
+#define TOP_COEF_ADR			0
+#define TOP_COEF_SIZE			4
+#define TOP_COEF_DATA			8
+
+#define TOP_INST_ADR			0
+#define TOP_INST_SIZE			4
+#define TOP_INST_DATA			8
+
+#define APP_ENV_ID			0
+#define APP_ENV_EXCECPROCESS		1
+#define APP_ENV_INSTBASE		2
+#define APP_ENV_REGBASE			6
+#define APP_ENV_EXECFS			10
+#define APP_ENV_EXECCH			14
+#define APP_ENV_WORKBASE		18
+#define APP_ENV_APPBASE0		22
+#define APP_ENV_APPBASE1		26
+#define APP_ENV_APPBASE2		30
+#define APP_ENV_APPBASE3		34
+#define APP_ENV_APPFADE			38
+#define APP_ENV_APPIRQ			39
+
+#define APP_COEF_ADR			0
+#define APP_COEF_SIZE			5
+#define APP_COEF_DATA			9
+
+#define APP_INST_ADR			0
+#define APP_INST_SIZE			4
+#define APP_INST_DATA			8
+
+#define APP_REG_ADR			0
+#define APP_REG_SIZE			4
+#define APP_REG_DATA			8
+
+#define APP_PARAM_ON			1
+
+#define MULTI_CHUNK_TOP_COEF		1
+#define MULTI_CHUNK_APP_COEF		2
+#define MULTI_CHUNK_APP_REG		3
+
+#define STOP_KIND_NONE			0x00
+#define STOP_KIND_FDSP			0x01
+#define STOP_KIND_APP_EXEC		0x02
+#define STOP_KIND_APP			0x04
+#define STOP_KIND_WAIT			0x08
+
+#define RESTART_OFF			0
+#define RESTART_ON			1
+#define RESTART_BYPASS			2
+
+#define APP_VOL_ID			0x07
+#define FIX_APP_VOL_FREE		0
+#define FIX_APP_VOL_EXIST		1
+#define FIX_APP_VOL_NO			22
+#define FIX_APP_VOL_ACT			MCI_APPACT0
+#define FIX_APP_VOL_BIT			MCB_APPACT22
+#define FIX_APP_VOL_APPEXEC		0x400000
+#define FIX_APP_VOL_REG_BASE		0x4F
+#define FIX_APP_VOL_REG_FADE_CTRL	(FIX_APP_VOL_REG_BASE + 1)
+#define FIX_APP_VOL_REG_FADE_CTRL_BIT	0x01
+#define FIX_APP_VOL_REG_FADE_STE	(FIX_APP_VOL_REG_BASE + 2)
+#define FIX_APP_VOL_REG_FADE_STE_BIT	0x01
+#define FIX_APP_FADE_WAIT_TIME_US	10000
+
+#define DEF_FDSP_STOP_WAIT_TIME_US	15000
+
+#define FDSP_APP_NUM			24
+#define FDSP_APP_EXEC_STOP		0
+#define FDSP_APP_EXEC_START		1
+#define FDSP_APP_EXEC_DONTCARE		2
+
+struct fdsp_info {
+	bool initialized;
+	u16 input_add_format;
+	u16 output_add_format;
+	u32 wait;
+	u32 app_stop;
+	u32 app_irq_enable;
+	u32 app_fade;
+	u8 dsp_bypass;
+	u8 fix_app_vol;
+
+	/* registers */
+	u8 adi_mute0;
+	u8 adi_mute1;
+	u8 ado_mute0;
+	u8 ado_mute1;
+	u8 dsp_ctrl;
+	u8 app_exec0;
+	u8 app_exec1;
+	u8 app_exec2;
+	u8 app_irq_enable0;
+	u8 app_irq_enable1;
+	u8 app_irq_enable2;
+};
+
+struct fdsp_data {
+	u8 *data;
+	u32 data_size;
+	u8 must_stop;
+	u8 *fw_ctrl;
+	u8 *ch_sel;
+	u8 *top_env;
+	u32 top_coef_count;
+	u8 *top_inst;
+	u32 target_app;
+	u32 app_env_count;
+	u8 *app_env[FDSP_APP_NUM];
+	u8 coef_trans;
+	u32 app_coef_count;
+	u32 app_const_count;
+	u32 app_coef_trans_max;
+	u32 app_inst_count;
+	u8 *app_inst[FDSP_APP_NUM];
+	u32 app_reg_count;
+	u8 *ext_info1;
+	u32 app_exec;
+};
+
+struct fdsp_exec {
+	u32 app_exec;
+	u8 restart;
+};
+
+static struct fdsp_info mc_fdsp_info = {
+	.wait = DEF_FDSP_STOP_WAIT_TIME_US
+};
+
+static inline u8 create_mute_value(u8 mute, u8 onoff, u8 mask)
+{
+	switch (onoff) {
+	case FDSP_MUTE_ON:
+		mute &= ~mask;
+		break;
+	case FDSP_MUTE_OFF:
+		mute |= mask;
+		break;
+	default:
+		break;
+	}
+
+	return mute;
+}
+
+static u32 fdsp_app_act_get(void)
+{
+	u32 app_act;
+	u8 data;
+
+	mc_read_f(MCI_APPACT0, &data, 1);
+	app_act = (u32) data << 16;
+
+	mc_read_f(MCI_APPACT1, &data, 1);
+	app_act |= (u32) data << 8;
+
+	mc_read_f(MCI_APPACT2, &data, 1);
+	app_act |= data;
+
+	return app_act;
+}
+
+static inline void fdsp_audioif_set(u16 input_add_format, u16 output_add_format)
+{
+	mc_packet_add_force_write_f(MCI_ADIDFMT0, input_add_format & 0xff);
+	mc_packet_add_force_write_f(MCI_ADIDFMT1,
+				    (input_add_format >> 8) & 0xff);
+
+	mc_packet_add_force_write_f(MCI_ADODFMT0, output_add_format & 0xff);
+	mc_packet_add_force_write_f(MCI_ADODFMT1,
+				    (output_add_format >> 8) & 0xff);
+
+	mc_packet_execute();
+}
+
+static void fdsp_core_init(void)
+{
+	mc_fdsp_info.app_stop = 0;
+	mc_fdsp_info.app_irq_enable = 0;
+	mc_fdsp_info.app_fade = 0;
+	mc_fdsp_info.dsp_bypass = 0;
+	mc_fdsp_info.fix_app_vol = FIX_APP_VOL_FREE;
+
+	mc_fdsp_info.dsp_ctrl = MCI_DSPCTRL_DEF;
+	mc_fdsp_info.app_exec0 = MCI_APPEXEC0_DEF;
+	mc_fdsp_info.app_exec1 = MCI_APPEXEC1_DEF;
+	mc_fdsp_info.app_exec2 = MCI_APPEXEC2_DEF;
+	mc_fdsp_info.app_irq_enable0 = MCI_APPIENB0_DEF;
+	mc_fdsp_info.app_irq_enable1 = MCI_APPIENB1_DEF;
+	mc_fdsp_info.app_irq_enable2 = MCI_APPIENB2_DEF;
+
+	mc_packet_add_force_write_f(MCI_DSPCTRL, mc_fdsp_info.dsp_ctrl);
+
+	mc_packet_add_force_write_f(MCI_APPEXEC0, mc_fdsp_info.app_exec0);
+
+	mc_packet_add_force_write_f(MCI_APPEXEC1, mc_fdsp_info.app_exec1);
+
+	mc_packet_add_force_write_f(MCI_APPEXEC2, mc_fdsp_info.app_exec2);
+
+	mc_packet_add_force_write_f(MCI_APPIENB0, mc_fdsp_info.app_irq_enable0);
+
+	mc_packet_add_force_write_f(MCI_APPIENB1, mc_fdsp_info.app_irq_enable1);
+
+	mc_packet_add_force_write_f(MCI_APPIENB2, mc_fdsp_info.app_irq_enable2);
+
+	mc_packet_add_force_write_f(MCI_ADIMUTE0, mc_fdsp_info.adi_mute0);
+
+	mc_packet_add_force_write_f(MCI_ADIMUTE1, mc_fdsp_info.adi_mute1);
+
+	mc_packet_add_force_write_f(MCI_ADIMUTE2, MCB_ADIMTSET);
+
+	mc_packet_add_force_write_f(MCI_ADOMUTE0, mc_fdsp_info.ado_mute0);
+
+	mc_packet_add_force_write_f(MCI_ADOMUTE1, mc_fdsp_info.ado_mute1);
+
+	mc_packet_add_force_write_f(MCI_ADOMUTE2, MCB_ADOMTSET);
+
+	mc_packet_add_force_write_f(MCI_APPFADE0, 0);
+
+	mc_packet_add_force_write_f(MCI_APPFADE1, 0);
+
+	mc_packet_add_force_write_f(MCI_APPFADE2, 0);
+
+	mc_packet_execute();
+
+	fdsp_audioif_set(mc_fdsp_info.input_add_format,
+			 mc_fdsp_info.output_add_format);
+}
+
+static int fdsp_get_data(struct mcdrv_aec_info *aec, struct fdsp_data *fdsp)
+{
+	fdsp->data = NULL;
+	fdsp->data_size = 0;
+
+	switch (aec->fdsp_locate) {
+	case FDSP_LOCATE_AUDIOENGINE:
+		if (aec->audio_engine.enable) {
+			if (!aec->audio_engine.fdsp_on)
+				return 0;
+
+			fdsp->data = &aec->audio_engine.fdsp.data[CHUNK_SIZE];
+			fdsp->data_size = aec->audio_engine.fdsp.data_size;
+		}
+		break;
+	case FDSP_LOCATE_V_BOX:
+		if (aec->vbox.enable) {
+			if (!aec->vbox.fdsp_on)
+				return 0;
+
+			fdsp->data = &aec->vbox.fdsp.data[CHUNK_SIZE];
+			fdsp->data_size = aec->vbox.fdsp.data_size;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static inline int fdsp_firmware_control_analyze(struct fdsp_data *fdsp,
+						u8 *data)
+{
+	int i;
+
+	if (data[FWCTL_FWMOD])
+		return -EINVAL;
+
+	if (data[FWCTL_FS] != 0xff || data[FWCTL_FADECODE] != 0xff)
+		fdsp->must_stop |= STOP_KIND_FDSP;
+
+	for (i = 0; i < FDSP_APP_NUM; ++i)
+		if (data[FWCTL_APPEXEC + i] != FDSP_APP_EXEC_DONTCARE &&
+		    i != FIX_APP_VOL_NO) {
+			fdsp->must_stop |= STOP_KIND_APP_EXEC;
+			break;
+		}
+
+	return 0;
+}
+
+static inline int fdsp_app_environment_check(u32 app_no, u8 *app_env)
+{
+	if (app_no != FIX_APP_VOL_NO)
+		return 0;
+
+	if (!app_env[APP_ENV_ID])
+		return 0;
+
+	if (app_env[APP_ENV_ID] != APP_VOL_ID)
+		return -EINVAL;
+
+	if ((app_env[APP_ENV_REGBASE + 3] & 0x7F) != FIX_APP_VOL_REG_BASE)
+		return -EINVAL;
+
+	return 0;
+}
+
+static inline int fdsp_app_data_analyze(struct fdsp_data *fdsp,
+					u32 tag, u32 size, u32 top, u8 *data)
+{
+	u32 app_no, tmp;
+
+	app_no = tag & AEC_FDSP_TAG_APPNO_MASK;
+	if (app_no >= FDSP_APP_NUM)
+		return -EINVAL;
+
+	switch (tag & AEC_FDSP_TAG_APP_MASK) {
+	case AEC_FDSP_TAG_APP_ENV:
+		if (size < APP_ENV_FIX_SIZE)
+			return -EINVAL;
+		if (fdsp->app_env[app_no])
+			return -EINVAL;
+		if (fdsp_app_environment_check(app_no, &data[top]) < 0)
+			return -EINVAL;
+
+		fdsp->app_env[app_no] = &data[top];
+		fdsp->app_env_count++;
+		fdsp->target_app |= 1 << app_no;
+		fdsp->coef_trans = COEF_DMA_TRANS;
+		fdsp->must_stop |= STOP_KIND_APP;
+		break;
+	case AEC_FDSP_TAG_APP_COEF:
+	case AEC_FDSP_TAG_APP_CONST:
+		if (size < APP_COEF_FIX_SIZE)
+			return -EINVAL;
+
+		tmp = htonl(*(u32 *) (data + top + 5));
+		if (!tmp)
+			break;
+		if (tmp & 3)
+			return -EINVAL;
+		if (tmp + APP_COEF_FIX_SIZE > size)
+			return -EINVAL;
+
+		if (data[top + 4] != COEF_DSP_TRANS) {
+			fdsp->coef_trans = COEF_DMA_TRANS;
+			fdsp->must_stop |= STOP_KIND_APP;
+		}
+
+		if ((tag & AEC_FDSP_TAG_APP_MASK) == AEC_FDSP_TAG_APP_COEF)
+			fdsp->app_coef_count++;
+		else
+			fdsp->app_const_count++;
+
+		fdsp->target_app |= 1 << app_no;
+
+		if (tmp > fdsp->app_coef_trans_max)
+			fdsp->app_coef_trans_max = tmp;
+
+		fdsp->must_stop |= STOP_KIND_WAIT;
+		break;
+	case AEC_FDSP_TAG_APP_INS:
+		if (size < APP_INS_FIX_SIZE)
+			return -EINVAL;
+		if (fdsp->app_inst[app_no])
+			return -EINVAL;
+
+		tmp = htonl(*(u32 *) (data + top + 4));
+		if (!tmp)
+			break;
+		if (tmp & 3)
+			return -EINVAL;
+		if (tmp + APP_INS_FIX_SIZE > size)
+			return -EINVAL;
+
+		fdsp->app_inst[app_no] = &data[top];
+		fdsp->app_inst_count++;
+		fdsp->target_app |= 1 << app_no;
+		fdsp->coef_trans = COEF_DMA_TRANS;
+		fdsp->must_stop |= STOP_KIND_APP;
+		break;
+	case AEC_FDSP_TAG_APP_REG:
+		if (size < APP_REG_FIX_SIZE)
+			return -EINVAL;
+		tmp = htonl(*(u32 *) (data + top + 4));
+		if (!tmp)
+			break;
+		if (tmp + APP_REG_FIX_SIZE > size)
+			return -EINVAL;
+
+		fdsp->app_reg_count++;
+		fdsp->must_stop |= STOP_KIND_WAIT;
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static inline void fdsp_coef_trans_check(struct fdsp_data *fdsp)
+{
+	if (fdsp->coef_trans != COEF_DSP_TRANS)
+		return;
+
+	if (!fdsp->app_coef_count && !fdsp->app_const_count)
+		return;
+
+	if (fdsp->app_coef_trans_max > COEF_DSP_TRANS_MAX ||
+	    (fdsp->app_coef_count + fdsp->app_const_count) > 1)
+		fdsp->coef_trans = COEF_DMA_TRANS;
+
+	if (fdsp->coef_trans == COEF_DMA_TRANS)
+		fdsp->must_stop |= STOP_KIND_APP;
+}
+
+static int fdsp_data_analyze(struct fdsp_data *fdsp)
+{
+	u32 top, tag, size, tmp;
+	u8 *data;
+	u32 data_size;
+	int ret, i;
+
+	fdsp->must_stop = STOP_KIND_NONE;
+	fdsp->fw_ctrl = NULL;
+	fdsp->ch_sel = NULL;
+	fdsp->top_env = NULL;
+	fdsp->top_coef_count = 0;
+	fdsp->top_inst = NULL;
+	fdsp->target_app = 0;
+	fdsp->app_env_count = 0;
+	fdsp->coef_trans = COEF_DSP_TRANS;
+	fdsp->app_coef_count = 0;
+	fdsp->app_const_count = 0;
+	fdsp->app_coef_trans_max = 0;
+	fdsp->app_inst_count = 0;
+	fdsp->app_reg_count = 0;
+	fdsp->ext_info1 = NULL;
+	for (i = 0; i < FDSP_APP_NUM; ++i) {
+		fdsp->app_env[i] = NULL;
+		fdsp->app_inst[i] = NULL;
+	}
+
+	if (!fdsp->data || !fdsp->data_size)
+		return 0;
+
+	data = fdsp->data;
+	data_size = fdsp->data_size;
+
+	top = 0;
+	while (top < data_size) {
+		if (top + CHUNK_SIZE > data_size)
+			return -EINVAL;
+
+		tag = htonl(*(u32 *) (data + top));
+		size = htonl(*(u32 *) (data + top + 4));
+		if (top + CHUNK_SIZE + size > data_size)
+			return -EINVAL;
+
+		top += CHUNK_SIZE;
+		switch (tag) {
+		case AEC_FDSP_TAG_FWCTRL:
+			if (size < FWCTRL_SIZE)
+				return -EINVAL;
+			if (fdsp->fw_ctrl)
+				return -EINVAL;
+
+			ret = fdsp_firmware_control_analyze(fdsp, &data[top]);
+			if (ret < 0)
+				return ret;
+
+			fdsp->fw_ctrl = &data[top];
+			break;
+		case AEC_FDSP_TAG_CHSEL:
+			if (size < CHSEL_SIZE)
+				return -EINVAL;
+			if (fdsp->ch_sel)
+				return -EINVAL;
+
+			fdsp->ch_sel = &data[top];
+			fdsp->must_stop |= STOP_KIND_FDSP;
+			break;
+		case AEC_FDSP_TAG_TOP_ENV:
+			if (size < TOP_ENV_SIZE)
+				return -EINVAL;
+			if (fdsp->top_env)
+				return -EINVAL;
+
+			fdsp->top_env = &data[top];
+			fdsp->must_stop |= STOP_KIND_FDSP;
+			break;
+		case AEC_FDSP_TAG_TOP_COEF:
+			if (size < TOP_COEF_FIX_SIZE)
+				return -EINVAL;
+			tmp = htonl(*(u32 *) (data + top + 4));
+			if (tmp & 3)
+				return -EINVAL;
+			if (tmp + TOP_COEF_FIX_SIZE > size)
+				return -EINVAL;
+
+			fdsp->top_coef_count++;
+			fdsp->must_stop |= STOP_KIND_FDSP;
+			break;
+		case AEC_FDSP_TAG_TOP_INS:
+			if (size < TOP_INS_FIX_SIZE)
+				return -EINVAL;
+			if (fdsp->top_inst)
+				return -EINVAL;
+
+			tmp = htonl(*(u32 *) (data + top + 4));
+			if (!tmp)
+				break;
+			if (tmp & 3)
+				return -EINVAL;
+			if (tmp + TOP_INS_FIX_SIZE > size)
+				return -EINVAL;
+
+			fdsp->top_inst = &data[top];
+			fdsp->must_stop |= STOP_KIND_FDSP;
+			break;
+		default:
+			ret = fdsp_app_data_analyze(fdsp, tag, size, top, data);
+			if (ret < 0)
+				return ret;
+		}
+
+		top += size;
+	}
+
+	fdsp_coef_trans_check(fdsp);
+
+	return 0;
+}
+
+static void fdsp_app_irq_set(u32 app_irq_enable)
+{
+	u8 app_irq_enable0;
+	u8 app_irq_enable1;
+	u8 app_irq_enable2;
+	u8 data;
+
+	app_irq_enable0 = (app_irq_enable >> 16) & 0xff;
+	app_irq_enable1 = (app_irq_enable >> 8) & 0xff;
+	app_irq_enable2 = app_irq_enable & 0xff;
+
+	if (mc_fdsp_info.app_irq_enable0 != app_irq_enable0) {
+		data = app_irq_enable0 & ~mc_fdsp_info.app_irq_enable0;
+		if (data)
+			mc_packet_add_force_write_f(MCI_IREQAPP0, data);
+
+		mc_fdsp_info.app_irq_enable0 = app_irq_enable0;
+		mc_packet_add_force_write_f(MCI_APPIENB0, app_irq_enable0);
+
+		mc_packet_execute();
+	}
+
+	if (mc_fdsp_info.app_irq_enable1 != app_irq_enable1) {
+		data = app_irq_enable1 & ~mc_fdsp_info.app_irq_enable1;
+		if (data)
+			mc_packet_add_force_write_f(MCI_IREQAPP1, data);
+
+		mc_fdsp_info.app_irq_enable1 = app_irq_enable1;
+		mc_packet_add_force_write_f(MCI_APPIENB1, app_irq_enable1);
+
+		mc_packet_execute();
+	}
+
+	if (mc_fdsp_info.app_irq_enable2 != app_irq_enable2) {
+		data = app_irq_enable2 & ~mc_fdsp_info.app_irq_enable2;
+		if (data)
+			mc_packet_add_force_write_f(MCI_IREQAPP2, data);
+
+		mc_fdsp_info.app_irq_enable2 = app_irq_enable2;
+		mc_packet_add_force_write_f(MCI_APPIENB2, app_irq_enable2);
+
+		mc_packet_execute();
+	}
+}
+
+static inline void fdsp_irq_disable(struct fdsp_data *fdsp)
+{
+	if (fdsp->must_stop & STOP_KIND_FDSP) {
+		mc_packet_add_force_write_if(MCI_IESERR, MCI_IESERR_DEF);
+
+		mc_packet_add_force_write_f(MCI_TOPIENB, MCI_TOPIENB_DEF);
+
+		mc_packet_execute();
+
+		fdsp_app_irq_set(0);
+	} else if (fdsp->must_stop & STOP_KIND_APP)
+		fdsp_app_irq_set(mc_fdsp_info.app_irq_enable & ~fdsp->
+				 target_app);
+}
+
+static int fdsp_fade_out_set(void)
+{
+	u8 act;
+
+	if (mc_fdsp_info.fix_app_vol != FIX_APP_VOL_EXIST)
+		return 0;
+
+	mc_read_f(FIX_APP_VOL_ACT, &act, 1);
+
+	mc_packet_add_force_write_f(MCI_IREQAPP0, MCB_IRAPP22);
+
+	mc_packet_add_force_write_f(FIX_APP_VOL_REG_FADE_CTRL, 0);
+
+	mc_packet_execute();
+
+	if (!(act & FIX_APP_VOL_BIT))
+		return 0;
+
+	mc_packet_add_wait(FIX_APP_FADE_WAIT_TIME_US);
+
+	mc_packet_execute();
+
+	return 0;
+}
+
+static inline int fdsp_forwarding_wait(void)
+{
+	mc_packet_add_wait_event(MCDRV_EVT_IF_REG_FLAG_RESET |
+				 (MCI_FDSPTREQ << 8) | MCB_FDSPTREQ);
+
+	return mc_packet_execute();
+}
+
+static void fdsp_control_set(u8 dsp_ctrl)
+{
+	if ((dsp_ctrl & MCB_DSPSTART) != MCB_DSPSTART)
+		mc_packet_add_force_write_if(MCI_FDSPTREQ, MCI_FDSPTREQ_DEF);
+
+	mc_packet_add_force_write_f(MCI_DSPCTRL, dsp_ctrl);
+	mc_packet_execute();
+
+	mc_fdsp_info.dsp_ctrl = dsp_ctrl;
+}
+
+static void fdsp_app_fade_set(void)
+{
+	u8 fade0, fade1, fade2;
+
+	fade0 = mc_fdsp_info.app_fade >> 16;
+	fade1 = mc_fdsp_info.app_fade >> 8;
+	fade2 = mc_fdsp_info.app_fade;
+
+	mc_packet_add_write_f(MCI_APPFADE0, fade0);
+	mc_packet_add_write_f(MCI_APPFADE1, fade1);
+	mc_packet_add_write_f(MCI_APPFADE2, fade2);
+
+	mc_packet_execute();
+}
+
+static void fdsp_app_exec_set(u8 app_exec0, u8 app_exec1, u8 app_exec2)
+{
+	mc_packet_add_write_f(MCI_APPEXEC0, app_exec0);
+	mc_packet_add_write_f(MCI_APPEXEC1, app_exec1);
+	mc_packet_add_write_f(MCI_APPEXEC2, app_exec2);
+	mc_packet_execute();
+
+	mc_fdsp_info.app_exec0 = app_exec0;
+	mc_fdsp_info.app_exec1 = app_exec1;
+	mc_fdsp_info.app_exec2 = app_exec2;
+}
+
+static inline int fdsp_app_stop(u32 app_stop)
+{
+	u8 app_stop0, app_stop1, app_stop2;
+	u8 app_stop0_org, app_stop1_org, app_stop2_org;
+	u8 app_exec0, app_exec1, app_exec2;
+	int ret = 0;
+
+	if (!app_stop)
+		return 0;
+
+	app_stop0 = (app_stop >> 16) & MCB_APPEXEC0;
+	app_stop1 = (app_stop >> 8) & MCB_APPEXEC1;
+	app_stop2 = app_stop & MCB_APPEXEC2;
+	app_stop0_org = app_stop0;
+	app_stop1_org = app_stop1;
+	app_stop2_org = app_stop2;
+
+	app_stop0 = mc_fdsp_info.app_exec0 & app_stop0;
+	app_stop1 = mc_fdsp_info.app_exec1 & app_stop1;
+	app_stop2 = mc_fdsp_info.app_exec2 & app_stop2;
+
+	app_exec0 = mc_fdsp_info.app_exec0 & ~app_stop0;
+	app_exec1 = mc_fdsp_info.app_exec1 & ~app_stop1;
+	app_exec2 = mc_fdsp_info.app_exec2 & ~app_stop2;
+	fdsp_app_exec_set(app_exec0, app_exec1, app_exec2);
+
+	if (app_stop0_org) {
+		mc_packet_add_wait_event(MCDRV_EVT_F_REG_FLAG_RESET |
+					 (MCI_APPACT0 << 8) | app_stop0_org);
+		ret = mc_packet_execute();
+		if (ret < 0)
+			return ret;
+	}
+
+	if (app_stop1_org) {
+		mc_packet_add_wait_event(MCDRV_EVT_F_REG_FLAG_RESET |
+					 (MCI_APPACT1 << 8) | app_stop1_org);
+		ret = mc_packet_execute();
+		if (ret < 0)
+			return ret;
+	}
+
+	if (app_stop2_org) {
+		mc_packet_add_wait_event(MCDRV_EVT_F_REG_FLAG_RESET |
+					 (MCI_APPACT2 << 8) | app_stop2_org);
+		ret = mc_packet_execute();
+		if (ret < 0)
+			return ret;
+	}
+
+	mc_packet_add_force_write_f(MCI_IREQAPP0, app_stop0_org);
+	mc_packet_add_force_write_f(MCI_IREQAPP1, app_stop1_org);
+	mc_packet_add_force_write_f(MCI_IREQAPP2, app_stop2_org);
+	mc_packet_execute();
+
+	return ret;
+}
+
+static int fdsp_stop(struct fdsp_data *fdsp)
+{
+	u8 val;
+	int ret = 0;
+
+	if (fdsp->must_stop & STOP_KIND_FDSP) {
+		if (mc_fdsp_info.dsp_ctrl & MCB_DSPSTART) {
+			ret = fdsp_fade_out_set();
+			if (ret < 0)
+				return ret;
+
+			ret = fdsp_forwarding_wait();
+			if (ret < 0)
+				return ret;
+		}
+
+		mc_read_f(MCI_DSPSTATE, &val, 1);
+
+		fdsp_control_set(MCI_DSPCTRL_DEF);
+
+		if (val & MCB_DSPACT) {
+			mc_packet_add_wait(mc_fdsp_info.wait);
+
+			ret = mc_packet_execute();
+			if (ret < 0)
+				return ret;
+
+			val = mc_if_register_get_value(MCI_RST);
+			if (val & MCB_PSW_F) {
+				mc_packet_add_force_write_if(MCI_RST,
+							     val | MCB_RST_F);
+				mc_packet_add_force_write_if(MCI_RST, val);
+				ret = mc_packet_execute();
+				if (ret < 0)
+					return ret;
+			}
+
+			fdsp_core_init();
+		}
+	} else if (fdsp->must_stop & STOP_KIND_APP) {
+		ret = fdsp_forwarding_wait();
+		if (ret < 0)
+			return ret;
+
+		fdsp_app_fade_set();
+
+		ret = fdsp_app_stop(fdsp->target_app);
+	} else if (fdsp->must_stop & STOP_KIND_WAIT)
+		ret = fdsp_forwarding_wait();
+
+	return ret;
+}
+
+static inline void fdsp_firmware_control_set(struct fdsp_data *fdsp)
+{
+	u8 *fw_ctrl;
+	u8 data;
+	int i;
+
+	fw_ctrl = fdsp->fw_ctrl;
+
+	for (i = 0; i < FDSP_APP_NUM; ++i) {
+		if (i != FIX_APP_VOL_NO) {
+			switch (fw_ctrl[FWCTL_APPEXEC + i]) {
+			case FDSP_APP_EXEC_STOP:
+				fdsp->app_exec &= ~(0x01U << i);
+				break;
+			case FDSP_APP_EXEC_START:
+				fdsp->app_exec |= (0x01U << i);
+				break;
+			default:
+				break;
+			}
+		}
+	}
+
+	if (!(fdsp->must_stop & STOP_KIND_FDSP))
+		return;
+
+	data = (fw_ctrl[FWCTL_FWMOD] << 4) & MCB_FWMOD;
+	if (fw_ctrl[FWCTL_FS] != 0xff) {
+		data |= fw_ctrl[FWCTL_FS] & MCB_FS;
+		mc_packet_add_force_write_f(MCI_FWMOD, data);
+	}
+
+	if (fw_ctrl[FWCTL_FADECODE] != 0xff) {
+		data = fw_ctrl[FWCTL_FADECODE] & MCB_FADECODE;
+		mc_packet_add_force_write_f(MCI_FADECODE, data);
+	}
+
+	mc_packet_execute();
+}
+
+static inline void fdsp_channel_select(u8 *ch_sel)
+{
+	u8 data;
+
+	mc_fdsp_info.dsp_bypass = (ch_sel[CHSEL_BYPASS] << 7) & MCB_DSPBYPASS;
+
+	data = (ch_sel[CHSEL_INFDSPSRC + 1] << 4) & MCB_ADI01CSEL;
+	data |= ch_sel[CHSEL_INFDSPSRC + 0] & MCB_ADI00CSEL;
+	mc_packet_add_force_write_f(MCI_ADICSEL0, data);
+
+	data = (ch_sel[CHSEL_INFDSPSRC + 3] << 4) & MCB_ADI03CSEL;
+	data |= ch_sel[CHSEL_INFDSPSRC + 2] & MCB_ADI02CSEL;
+	mc_packet_add_force_write_f(MCI_ADICSEL1, data);
+
+	data = (ch_sel[CHSEL_INFDSPSRC + 5] << 4) & MCB_ADI05CSEL;
+	data |= ch_sel[CHSEL_INFDSPSRC + 4] & MCB_ADI04CSEL;
+	mc_packet_add_force_write_f(MCI_ADICSEL2, data);
+
+	data = (ch_sel[CHSEL_INFDSPSRC + 7] << 4) & MCB_ADI07CSEL;
+	data |= ch_sel[CHSEL_INFDSPSRC + 6] & MCB_ADI06CSEL;
+	mc_packet_add_force_write_f(MCI_ADICSEL3, data);
+
+	data = (ch_sel[CHSEL_INFDSPSRC + 9] << 4) & MCB_ADI09CSEL;
+	data |= ch_sel[CHSEL_INFDSPSRC + 8] & MCB_ADI08CSEL;
+	mc_packet_add_force_write_f(MCI_ADICSEL4, data);
+
+	data = (ch_sel[CHSEL_INFDSPSRC + 11] << 4) & MCB_ADI11CSEL;
+	data |= ch_sel[CHSEL_INFDSPSRC + 10] & MCB_ADI10CSEL;
+	mc_packet_add_force_write_f(MCI_ADICSEL5, data);
+
+	data = (ch_sel[CHSEL_INFDSPSRC + 13] << 4) & MCB_ADI13CSEL;
+	data |= ch_sel[CHSEL_INFDSPSRC + 12] & MCB_ADI12CSEL;
+	mc_packet_add_force_write_f(MCI_ADICSEL6, data);
+
+	data = (ch_sel[CHSEL_INFDSPSRC + 15] << 4) & MCB_ADI15CSEL;
+	data |= ch_sel[CHSEL_INFDSPSRC + 14] & MCB_ADI14CSEL;
+	mc_packet_add_force_write_f(MCI_ADICSEL7, data);
+
+	data = (ch_sel[CHSEL_OUTAUDIOSRC + 1] << 4) & MCB_ADO01CSEL;
+	data |= ch_sel[CHSEL_OUTAUDIOSRC + 0] & MCB_ADO00CSEL;
+	mc_packet_add_force_write_f(MCI_ADOCSEL0, data);
+
+	data = (ch_sel[CHSEL_OUTAUDIOSRC + 3] << 4) & MCB_ADO03CSEL;
+	data |= ch_sel[CHSEL_OUTAUDIOSRC + 2] & MCB_ADO02CSEL;
+	mc_packet_add_force_write_f(MCI_ADOCSEL1, data);
+
+	data = (ch_sel[CHSEL_OUTAUDIOSRC + 5] << 4) & MCB_ADO05CSEL;
+	data |= ch_sel[CHSEL_OUTAUDIOSRC + 4] & MCB_ADO04CSEL;
+	mc_packet_add_force_write_f(MCI_ADOCSEL2, data);
+
+	data = (ch_sel[CHSEL_OUTAUDIOSRC + 7] << 4) & MCB_ADO07CSEL;
+	data |= ch_sel[CHSEL_OUTAUDIOSRC + 6] & MCB_ADO06CSEL;
+	mc_packet_add_force_write_f(MCI_ADOCSEL3, data);
+
+	data = (ch_sel[CHSEL_OUTAUDIOSRC + 9] << 4) & MCB_ADO09CSEL;
+	data |= ch_sel[CHSEL_OUTAUDIOSRC + 8] & MCB_ADO08CSEL;
+	mc_packet_add_force_write_f(MCI_ADOCSEL4, data);
+
+	data = (ch_sel[CHSEL_OUTAUDIOSRC + 11] << 4) & MCB_ADO11CSEL;
+	data |= ch_sel[CHSEL_OUTAUDIOSRC + 10] & MCB_ADO10CSEL;
+	mc_packet_add_force_write_f(MCI_ADOCSEL5, data);
+
+	data = (ch_sel[CHSEL_OUTAUDIOSRC + 13] << 4) & MCB_ADO13CSEL;
+	data |= ch_sel[CHSEL_OUTAUDIOSRC + 12] & MCB_ADO12CSEL;
+	mc_packet_add_force_write_f(MCI_ADOCSEL6, data);
+
+	data = (ch_sel[CHSEL_OUTAUDIOSRC + 15] << 4) & MCB_ADO15CSEL;
+	data |= ch_sel[CHSEL_OUTAUDIOSRC + 14] & MCB_ADO14CSEL;
+	mc_packet_add_force_write_f(MCI_ADOCSEL7, data);
+
+	mc_packet_execute();
+}
+
+static void fdsp_top_environment_set(u8 *top_env)
+{
+	u8 data;
+
+	mc_packet_add_force_write_if(MCI_FMAA_19_16, 0);
+	mc_packet_add_force_write_if(MCI_FMAA_15_8, 0);
+	mc_packet_add_force_write_if(MCI_FMAA_7_0, 8);
+
+	mc_packet_add_force_write_if(MCI_FDSPTINI, MCI_FDSPTINI_DEF);
+	mc_packet_execute();
+
+	mc_packet_add_force_write_if(MCI_FMAD, top_env[TOP_ENV_ID]);
+	mc_packet_add_force_write_if(MCI_FMAD,
+				     top_env[TOP_ENV_INSTBASE + 1] & 0x1f);
+	mc_packet_add_force_write_if(MCI_FMAD, top_env[TOP_ENV_INSTBASE + 2]);
+	mc_packet_add_force_write_if(MCI_FMAD, top_env[TOP_ENV_INSTBASE + 3]);
+
+	mc_packet_add_force_write_if(MCI_FMAD,
+				     top_env[TOP_ENV_MBLKSIZE] & 0x1f);
+	mc_packet_add_force_write_if(MCI_FMAD,
+				     top_env[TOP_ENV_MBUFSIZE] & 0x1f);
+	mc_packet_add_force_write_if(MCI_FMAD, 0);
+	data = (top_env[TOP_ENV_MOCHCNFG] << 4) & 0xf0;
+	data |= top_env[TOP_ENV_MICHCNFG] & 0x0f;
+	mc_packet_add_force_write_if(MCI_FMAD, data);
+
+	mc_packet_add_force_write_if(MCI_FMAD, 0);
+	mc_packet_add_force_write_if(MCI_FMAD, 0);
+	mc_packet_add_force_write_if(MCI_FMAD,
+				     top_env[TOP_ENV_SSTARTCH] & 0x0f);
+	data = (top_env[TOP_ENV_SNUMOFOCH] << 4) & 0xf0;
+	data |= top_env[TOP_ENV_SNUMOFICH] & 0x0f;
+	mc_packet_add_force_write_if(MCI_FMAD, data);
+
+	mc_packet_add_force_write_if(MCI_FMAD,
+				     top_env[TOP_ENV_SAVEBUFSIZE1 + 2]);
+	mc_packet_add_force_write_if(MCI_FMAD,
+				     top_env[TOP_ENV_SAVEBUFSIZE1 + 3]);
+	mc_packet_add_force_write_if(MCI_FMAD,
+				     top_env[TOP_ENV_SAVEBUFSIZE0 + 2]);
+	mc_packet_add_force_write_if(MCI_FMAD,
+				     top_env[TOP_ENV_SAVEBUFSIZE0 + 3]);
+
+	mc_packet_add_force_write_if(MCI_FMAD, 0);
+	mc_packet_add_force_write_if(MCI_FMAD,
+				     top_env[TOP_ENV_LIMITWORKSIZE + 1] & 0x0f);
+	mc_packet_add_force_write_if(MCI_FMAD,
+				     top_env[TOP_ENV_LIMITWORKSIZE + 2]);
+	mc_packet_add_force_write_if(MCI_FMAD,
+				     top_env[TOP_ENV_LIMITWORKSIZE + 3]);
+
+	mc_packet_add_force_write_if(MCI_FMAD, 0);
+	mc_packet_add_force_write_if(MCI_FMAD,
+				     top_env[TOP_ENV_WORKBASE + 1] & 0x0f);
+	mc_packet_add_force_write_if(MCI_FMAD, top_env[TOP_ENV_WORKBASE + 2]);
+	mc_packet_add_force_write_if(MCI_FMAD, top_env[TOP_ENV_WORKBASE + 3]);
+
+	mc_packet_add_force_write_if(MCI_FMAD, 0);
+	mc_packet_add_force_write_if(MCI_FMAD,
+				     top_env[TOP_ENV_TOPBASE0 + 1] & 0x1f);
+	mc_packet_add_force_write_if(MCI_FMAD, top_env[TOP_ENV_TOPBASE0 + 2]);
+	mc_packet_add_force_write_if(MCI_FMAD, top_env[TOP_ENV_TOPBASE0 + 3]);
+
+	mc_packet_execute();
+}
+
+static inline void fdsp_top_coef_set(u8 *coef)
+{
+	u32 size, i;
+
+	mc_packet_add_force_write_if(MCI_FMAA_19_16,
+				     coef[TOP_COEF_ADR + 1] & MCB_FMAA_19_16);
+	mc_packet_add_force_write_if(MCI_FMAA_15_8,
+				     coef[TOP_COEF_ADR + 2] & MCB_FMAA_15_8);
+	mc_packet_add_force_write_if(MCI_FMAA_7_0,
+				     coef[TOP_COEF_ADR + 3] & MCB_FMAA_7_0);
+	mc_packet_add_force_write_if(MCI_FDSPTINI, MCI_FDSPTINI_DEF);
+	mc_packet_execute();
+
+	size = htonl(*(u32 *) (coef + TOP_COEF_SIZE));
+	for (i = 0; i < size; i++)
+		mc_packet_add_force_write_if(MCI_FMAD, coef[TOP_COEF_DATA + i]);
+
+	mc_packet_execute();
+}
+
+static inline void fdsp_app_coef_set(u8 *coef, u8 coef_trans)
+{
+	u32 size, i;
+
+	mc_packet_add_force_write_if(MCI_FMAA_19_16,
+				     coef[APP_COEF_ADR + 1] & MCB_FMAA_19_16);
+	mc_packet_add_force_write_if(MCI_FMAA_15_8,
+				     coef[APP_COEF_ADR + 2] & MCB_FMAA_15_8);
+	mc_packet_add_force_write_if(MCI_FMAA_7_0,
+				     coef[APP_COEF_ADR + 3] & MCB_FMAA_7_0);
+
+	if (coef_trans == COEF_DSP_TRANS)
+		mc_packet_add_force_write_if(MCI_FDSPTINI,
+					     MCB_DSPTINI | MCB_FMAMOD_DSP);
+	else
+		mc_packet_add_force_write_if(MCI_FDSPTINI, MCI_FDSPTINI_DEF);
+	mc_packet_execute();
+
+	size = htonl(*(u32 *) (coef + APP_COEF_SIZE));
+	for (i = 0; i < size; i++)
+		mc_packet_add_force_write_if(MCI_FMAD, coef[APP_COEF_DATA + i]);
+	mc_packet_execute();
+}
+
+static inline void fdsp_app_reg_set(u8 *reg)
+{
+	u32 size, i;
+
+	mc_packet_add_force_write_if(MCI_F_REG_A,
+				     reg[APP_REG_ADR + 3] | MCB_F_REG_AINC);
+	mc_packet_execute();
+
+	size = htonl(*(u32 *) (reg + APP_REG_SIZE));
+	for (i = 0; i < size; i++)
+		mc_packet_add_force_write_if(MCI_F_REG_D,
+					     reg[APP_REG_DATA + i]);
+	mc_packet_execute();
+}
+
+static void fdsp_multi_data_set(struct fdsp_data *fdsp, u32 target)
+{
+	u32 top, tag, size, app_no, data_size;
+	u8 *data;
+
+	data = fdsp->data;
+	data_size = fdsp->data_size;
+	top = 0;
+
+	while (top < data_size) {
+		tag = htonl(*(u32 *) (data + top));
+		size = htonl(*(u32 *) (data + top + 4));
+
+		top += CHUNK_SIZE;
+		app_no = tag & AEC_FDSP_TAG_APPNO_MASK;
+
+		switch (tag & AEC_FDSP_TAG_APP_MASK) {
+		case AEC_FDSP_TAG_APP_COEF:
+		case AEC_FDSP_TAG_APP_CONST:
+			if (target == MULTI_CHUNK_APP_COEF &&
+			    app_no < FDSP_APP_NUM)
+				fdsp_app_coef_set(&data[top], fdsp->coef_trans);
+			break;
+		case AEC_FDSP_TAG_APP_REG:
+			if (target == MULTI_CHUNK_APP_REG &&
+			    app_no < FDSP_APP_NUM)
+				fdsp_app_reg_set(&data[top]);
+			break;
+		default:
+			if (tag == AEC_FDSP_TAG_TOP_COEF &&
+			    target == MULTI_CHUNK_TOP_COEF)
+				fdsp_top_coef_set(&data[top]);
+			break;
+		}
+
+		top += size;
+	}
+}
+
+static inline void fdsp_top_instruction_set(u8 *inst)
+{
+	u32 size, i;
+
+	mc_packet_add_force_write_if(MCI_FMAA_19_16,
+				     inst[TOP_INST_ADR + 1] & MCB_FMAA_19_16);
+	mc_packet_add_force_write_if(MCI_FMAA_15_8,
+				     inst[TOP_INST_ADR + 2] & MCB_FMAA_15_8);
+	mc_packet_add_force_write_if(MCI_FMAA_7_0,
+				     inst[TOP_INST_ADR + 3] & MCB_FMAA_7_0);
+	mc_packet_add_force_write_if(MCI_FDSPTINI, MCB_FMABUS_I);
+	mc_packet_execute();
+
+	size = htonl(*(u32 *) (inst + TOP_INST_SIZE));
+	for (i = 0; i < size; i++)
+		mc_packet_add_force_write_if(MCI_FMAD, inst[TOP_INST_DATA + i]);
+	mc_packet_execute();
+}
+
+static inline void fdsp_app_environment_fix(u32 app_no, u8 *app_env)
+{
+	if (app_no != FIX_APP_VOL_NO)
+		return;
+
+	if (app_env[APP_ENV_ID] == APP_VOL_ID)
+		mc_fdsp_info.fix_app_vol = FIX_APP_VOL_EXIST;
+	else
+		mc_fdsp_info.fix_app_vol = FIX_APP_VOL_FREE;
+}
+
+static inline void fdsp_app_environment_set(u32 app_no, u8 *app_env)
+{
+	u32 base;
+	u8 data;
+
+	base = 0x10 + (app_no * 8);
+
+	mc_packet_add_force_write_if(MCI_FMAA_19_16,
+				     (base >> 16) & MCB_FMAA_19_16);
+	mc_packet_add_force_write_if(MCI_FMAA_15_8,
+				     (base >> 8) & MCB_FMAA_15_8);
+	mc_packet_add_force_write_if(MCI_FMAA_7_0, base & MCB_FMAA_7_0);
+
+	mc_packet_add_force_write_if(MCI_FDSPTINI, MCI_FDSPTINI_DEF);
+
+	mc_packet_add_force_write_if(MCI_FMAD, app_env[APP_ENV_ID]);
+	data = (app_env[APP_ENV_EXCECPROCESS] << 7) & 0x80;
+	data |= app_env[APP_ENV_INSTBASE + 1] & 0x1f;
+	mc_packet_add_force_write_if(MCI_FMAD, data);
+	mc_packet_add_force_write_if(MCI_FMAD, app_env[APP_ENV_INSTBASE + 2]);
+	mc_packet_add_force_write_if(MCI_FMAD, app_env[APP_ENV_INSTBASE + 3]);
+
+	mc_packet_add_force_write_if(MCI_FMAD, 0);
+	mc_packet_add_force_write_if(MCI_FMAD,
+				     app_env[APP_ENV_REGBASE + 3] & 0x7f);
+	mc_packet_add_force_write_if(MCI_FMAD,
+				     app_env[APP_ENV_EXECFS + 2] & 0x7f);
+	mc_packet_add_force_write_if(MCI_FMAD, app_env[APP_ENV_EXECFS + 3]);
+
+	mc_packet_add_force_write_if(MCI_FMAD, 0);
+	mc_packet_add_force_write_if(MCI_FMAD, 0);
+	mc_packet_add_force_write_if(MCI_FMAD, app_env[APP_ENV_EXECCH + 2]);
+	mc_packet_add_force_write_if(MCI_FMAD, app_env[APP_ENV_EXECCH + 3]);
+
+	mc_packet_add_force_write_if(MCI_FMAD, 0);
+	mc_packet_add_force_write_if(MCI_FMAD,
+				     app_env[APP_ENV_WORKBASE + 1] & 0x1f);
+	mc_packet_add_force_write_if(MCI_FMAD, app_env[APP_ENV_WORKBASE + 2]);
+	mc_packet_add_force_write_if(MCI_FMAD, app_env[APP_ENV_WORKBASE + 3]);
+
+	mc_packet_add_force_write_if(MCI_FMAD, 0);
+	mc_packet_add_force_write_if(MCI_FMAD,
+				     app_env[APP_ENV_APPBASE0 + 1] & 0x1f);
+	mc_packet_add_force_write_if(MCI_FMAD, app_env[APP_ENV_APPBASE0 + 2]);
+	mc_packet_add_force_write_if(MCI_FMAD, app_env[APP_ENV_APPBASE0 + 3]);
+
+	mc_packet_add_force_write_if(MCI_FMAD, 0);
+	mc_packet_add_force_write_if(MCI_FMAD,
+				     app_env[APP_ENV_APPBASE1 + 1] & 0x1f);
+	mc_packet_add_force_write_if(MCI_FMAD, app_env[APP_ENV_APPBASE1 + 2]);
+	mc_packet_add_force_write_if(MCI_FMAD, app_env[APP_ENV_APPBASE1 + 3]);
+
+	mc_packet_add_force_write_if(MCI_FMAD, 0);
+	mc_packet_add_force_write_if(MCI_FMAD,
+				     app_env[APP_ENV_APPBASE2 + 1] & 0x1f);
+	mc_packet_add_force_write_if(MCI_FMAD, app_env[APP_ENV_APPBASE2 + 2]);
+	mc_packet_add_force_write_if(MCI_FMAD, app_env[APP_ENV_APPBASE2 + 3]);
+
+	mc_packet_add_force_write_if(MCI_FMAD, 0);
+	mc_packet_add_force_write_if(MCI_FMAD,
+				     app_env[APP_ENV_APPBASE3 + 1] & 0x1f);
+	mc_packet_add_force_write_if(MCI_FMAD, app_env[APP_ENV_APPBASE3 + 2]);
+	mc_packet_add_force_write_if(MCI_FMAD, app_env[APP_ENV_APPBASE3 + 3]);
+
+	mc_packet_execute();
+
+	if ((app_env[APP_ENV_APPFADE] & APP_PARAM_ON) == APP_PARAM_ON)
+		mc_fdsp_info.app_fade |= 0x01U << app_no;
+	else
+		mc_fdsp_info.app_fade &= ~(0x01U << app_no);
+
+	if ((app_env[APP_ENV_APPIRQ] & APP_PARAM_ON) == APP_PARAM_ON)
+		mc_fdsp_info.app_irq_enable |= 0x01U << app_no;
+	else
+		mc_fdsp_info.app_irq_enable &= ~(0x01UL << app_no);
+}
+
+static void fdsp_app_instruction_set(u8 *inst)
+{
+	u32 size, i;
+
+	mc_packet_add_force_write_if(MCI_FMAA_19_16,
+				     inst[APP_INST_ADR + 1] & MCB_FMAA_19_16);
+	mc_packet_add_force_write_if(MCI_FMAA_15_8,
+				     inst[APP_INST_ADR + 2] & MCB_FMAA_15_8);
+	mc_packet_add_force_write_if(MCI_FMAA_7_0,
+				     inst[APP_INST_ADR + 3] & MCB_FMAA_7_0);
+
+	mc_packet_add_force_write_if(MCI_FDSPTINI, MCB_FMABUS_I);
+	mc_packet_execute();
+
+	size = htonl(*(u32 *) (inst + APP_INST_SIZE));
+	for (i = 0; i < size; i++)
+		mc_packet_add_force_write_if(MCI_FMAD, inst[APP_INST_DATA + i]);
+	mc_packet_execute();
+}
+
+static void fdsp_download(struct fdsp_data *fdsp)
+{
+	int i;
+
+	if (fdsp->fw_ctrl)
+		fdsp_firmware_control_set(fdsp);
+
+	if (fdsp->ch_sel)
+		fdsp_channel_select(fdsp->ch_sel);
+
+	if (fdsp->top_env)
+		fdsp_top_environment_set(fdsp->top_env);
+
+	if (fdsp->top_coef_count)
+		fdsp_multi_data_set(fdsp, MULTI_CHUNK_TOP_COEF);
+
+	if (fdsp->top_inst)
+		fdsp_top_instruction_set(fdsp->top_inst);
+
+	if (fdsp->target_app)
+		for (i = 0; i < FDSP_APP_NUM; i++)
+			if (fdsp->app_env[i]) {
+				fdsp_app_environment_fix(i, fdsp->app_env[i]);
+				fdsp_app_environment_set(i, fdsp->app_env[i]);
+			}
+
+	if (fdsp->app_coef_count || fdsp->app_const_count) {
+		fdsp_multi_data_set(fdsp, MULTI_CHUNK_APP_COEF);
+
+		if (fdsp->coef_trans == COEF_DSP_TRANS) {
+			mc_packet_add_force_write_if(MCI_FDSPTREQ,
+						     MCB_FDSPTREQ);
+			mc_packet_execute();
+		}
+	}
+
+	if (fdsp->app_inst_count)
+		for (i = 0; i < FDSP_APP_NUM; i++)
+			if (fdsp->app_inst[i])
+				fdsp_app_instruction_set(fdsp->app_inst[i]);
+
+	if (fdsp->app_reg_count)
+		fdsp_multi_data_set(fdsp, MULTI_CHUNK_APP_REG);
+}
+
+static void fdsp_irq_enable(struct fdsp_data *fdsp, struct fdsp_exec *exec)
+{
+	if (fdsp->must_stop & STOP_KIND_FDSP) {
+		mc_packet_add_force_write_f(MCI_IREQTOP, MCB_IREQTOP);
+		mc_packet_add_force_write_if(MCI_IRSERR, MCB_IRSERR | MCB_IRFW);
+		mc_packet_execute();
+
+		fdsp_app_irq_set(mc_fdsp_info.app_irq_enable & exec->app_exec);
+
+		mc_packet_add_force_write_f(MCI_TOPIENB, MCB_TOPIENB);
+		mc_packet_add_force_write_if(MCI_IESERR, MCB_IESERR | MCB_IEFW);
+		mc_packet_execute();
+	} else if (fdsp->must_stop & STOP_KIND_APP_EXEC) {
+		mc_packet_add_force_write_if(MCI_IRSERR, MCB_IRFW_DSP);
+		mc_packet_execute();
+
+		fdsp_app_irq_set(mc_fdsp_info.app_irq_enable & exec->app_exec);
+	} else if (fdsp->must_stop & STOP_KIND_APP) {
+		mc_packet_add_force_write_if(MCI_IRSERR, MCB_IRFW_DSP);
+		mc_packet_execute();
+
+		fdsp_app_irq_set(mc_fdsp_info.app_irq_enable & exec->app_exec);
+	} else if (fdsp->must_stop & STOP_KIND_WAIT) {
+		mc_packet_add_force_write_if(MCI_IRSERR, MCB_IRFW_DSP);
+		mc_packet_execute();
+	}
+}
+
+static void fdsp_face_in_set(void)
+{
+	if (mc_fdsp_info.fix_app_vol != FIX_APP_VOL_EXIST)
+		return;
+
+	mc_packet_add_force_write_f(FIX_APP_VOL_REG_FADE_CTRL,
+				    FIX_APP_VOL_REG_FADE_CTRL_BIT);
+	mc_packet_execute();
+}
+
+static inline void fdsp_restart(struct fdsp_data *fdsp, struct fdsp_exec *exec)
+{
+	u8 app_exec0;
+	u8 app_exec1;
+	u8 app_exec2;
+	u32 app_stop;
+	u32 app_act;
+
+	app_exec0 = (exec->app_exec >> 16) & MCB_APPEXEC0;
+	app_exec1 = (exec->app_exec >> 8) & MCB_APPEXEC1;
+	app_exec2 = exec->app_exec & MCB_APPEXEC2;
+
+	if (fdsp->must_stop & STOP_KIND_FDSP) {
+		fdsp_app_exec_set(app_exec0, app_exec1, app_exec2);
+		if (exec->restart == RESTART_ON) {
+			mc_fdsp_info.app_stop = 0;
+			if (mc_fdsp_info.dsp_bypass & MCB_DSPBYPASS)
+				fdsp_control_set(MCB_DSPBYPASS);
+			else {
+				fdsp_control_set(MCB_DSPSTART);
+				fdsp_face_in_set();
+			}
+		}
+	} else if (fdsp->must_stop & STOP_KIND_APP_EXEC) {
+		app_stop = (u32) (mc_fdsp_info.app_exec0 & ~app_exec0) << 16;
+		app_stop |= (u32) (mc_fdsp_info.app_exec1 & ~app_exec1) << 8;
+		app_stop |= mc_fdsp_info.app_exec2 & ~app_exec2;
+
+		fdsp_app_fade_set();
+		fdsp_app_exec_set(app_exec0, app_exec1, app_exec2);
+		fdsp_face_in_set();
+
+		app_act = fdsp_app_act_get();
+		if ((app_stop & app_act) != app_stop)
+			app_stop &= app_act;
+
+		mc_fdsp_info.app_stop |= app_stop;
+	} else if (fdsp->must_stop & STOP_KIND_APP) {
+		fdsp_app_fade_set();
+		fdsp_app_exec_set(app_exec0, app_exec1, app_exec2);
+		fdsp_face_in_set();
+	}
+}
+
+static inline int fdsp_audio_engine_set(struct fdsp_data *fdsp)
+{
+	struct fdsp_exec exec;
+	u8 data;
+	int ret;
+
+	fdsp->app_exec = (u32) mc_fdsp_info.app_exec0 << 16 |
+	    (u32) mc_fdsp_info.app_exec1 << 8 | (u32) mc_fdsp_info.app_exec2;
+
+	if (mc_fdsp_info.dsp_ctrl != MCI_DSPCTRL_DEF)
+		exec.restart = RESTART_ON;
+	else
+		exec.restart = RESTART_OFF;
+
+	if (mc_fdsp_info.dsp_ctrl & MCB_DSPBYPASS)
+		fdsp->must_stop |= STOP_KIND_FDSP;
+	else if (mc_fdsp_info.dsp_ctrl & MCB_DSPSTART) {
+		fdsp->must_stop |= STOP_KIND_FDSP;
+		fdsp->coef_trans = COEF_DMA_TRANS;
+	} else {
+		mc_read_f(MCI_DSPSTATE, &data, 1);
+		if ((data & MCB_DSPACT) != MCB_DSPACT)
+			fdsp->coef_trans = COEF_DMA_TRANS;
+	}
+
+	fdsp_irq_disable(fdsp);
+
+	ret = fdsp_stop(fdsp);
+	if (ret < 0)
+		return ret;
+
+	if (fdsp->must_stop & STOP_KIND_FDSP) {
+		mc_packet_add_write_f(MCI_APPFADE0, 0);
+		mc_packet_add_write_f(MCI_APPFADE1, 0);
+		mc_packet_add_write_f(MCI_APPFADE2, 0);
+	}
+
+	fdsp_download(fdsp);
+
+	exec.app_exec = fdsp->app_exec;
+	if (mc_fdsp_info.fix_app_vol == FIX_APP_VOL_EXIST)
+		exec.app_exec |= FIX_APP_VOL_APPEXEC;
+	else
+		exec.app_exec &= ~FIX_APP_VOL_APPEXEC;
+
+	fdsp_irq_enable(fdsp, &exec);
+	fdsp_restart(fdsp, &exec);
+
+	return 0;
+}
+
+int mc_fdsp_init(u8 locate, u32 wait)
+{
+	if (mc_fdsp_info.initialized)
+		return -EBUSY;
+
+	if (!locate) {
+		mc_fdsp_info.input_add_format = 0xf0ff;
+		mc_fdsp_info.output_add_format = 0xf0ff;
+	} else {
+		mc_fdsp_info.input_add_format = 0xf000;
+		mc_fdsp_info.output_add_format = 0xf000;
+	}
+
+	if (wait)
+		mc_fdsp_info.wait = wait;
+	else
+		mc_fdsp_info.wait = DEF_FDSP_STOP_WAIT_TIME_US;
+
+	mc_fdsp_info.adi_mute0 = MCI_ADIMUTE0_DEF;
+	mc_fdsp_info.adi_mute1 = MCI_ADIMUTE1_DEF;
+	mc_fdsp_info.ado_mute0 = MCI_ADOMUTE0_DEF;
+	mc_fdsp_info.ado_mute1 = MCI_ADOMUTE1_DEF;
+
+	fdsp_core_init();
+
+	mc_fdsp_info.initialized = true;
+
+	return 0;
+}
+
+void mc_fdsp_term(void)
+{
+	if (!mc_fdsp_info.initialized)
+		return;
+
+	mc_packet_add_force_write_if(MCI_IESERR, MCI_IESERR_DEF);
+	mc_packet_add_force_write_if(MCI_IRSERR, MCB_IRSERR | MCB_IRFW);
+	mc_packet_add_force_write_f(MCI_DSPCTRL, MCI_DSPCTRL_DEF);
+	mc_packet_execute();
+
+	mc_fdsp_info.initialized = false;
+}
+
+void mc_fdsp_irq(void)
+{
+	u32 app_stop;
+	u8 ireq, ireq_top = 0, ireq_app0 = 0, ireq_app1 = 0, ireq_app2 = 0;
+
+	mc_read_f(MCI_IRSERR, &ireq, 1);
+
+	mc_packet_add_force_write_if(MCI_IRSERR, ireq);
+	mc_packet_execute();
+
+	if (ireq & MCB_IRFW_TOP) {
+		mc_read_f(MCI_IREQTOP, &ireq_top, 1);
+
+		mc_packet_add_force_write_f(MCI_IREQTOP, ireq_top);
+		mc_packet_execute();
+	}
+
+	if (ireq & MCB_IRFW_APP) {
+		if (mc_fdsp_info.app_irq_enable0) {
+			mc_read_f(MCI_IREQAPP0, &ireq_app0, 1);
+
+			mc_packet_add_force_write_f(MCI_IREQAPP0, ireq_app0);
+			mc_packet_execute();
+
+			ireq_app0 = ireq_app0 & mc_fdsp_info.app_irq_enable0;
+		}
+
+		if (mc_fdsp_info.app_irq_enable1) {
+			mc_read_f(MCI_IREQAPP1, &ireq_app1, 1);
+
+			mc_packet_add_force_write_f(MCI_IREQAPP1, ireq_app1);
+			mc_packet_execute();
+
+			ireq_app2 = ireq_app1 & mc_fdsp_info.app_irq_enable1;
+		}
+
+		if (mc_fdsp_info.app_irq_enable2) {
+			mc_read_f(MCI_IREQAPP2, &ireq_app2, 1);
+
+			mc_packet_add_force_write_f(MCI_IREQAPP2, ireq_app2);
+			mc_packet_execute();
+
+			ireq_app2 = ireq_app2 & mc_fdsp_info.app_irq_enable2;
+		}
+	}
+
+	if (ireq_top & MCB_IREQTOP0) {
+		app_stop = mc_fdsp_info.app_stop & ~fdsp_app_act_get();
+		mc_fdsp_info.app_stop &= ~app_stop;
+	}
+}
+
+int mc_fdsp_set_dsp(struct mcdrv_aec_info *aec)
+{
+	struct fdsp_data fdsp;
+	int ret;
+
+	if (!aec)
+		return -EINVAL;
+
+	ret = fdsp_get_data(aec, &fdsp);
+	if (ret < 0)
+		return ret;
+
+	ret = fdsp_data_analyze(&fdsp);
+	if (ret < 0)
+		return ret;
+
+	if (!fdsp.data || !fdsp.data_size)
+		return 0;
+
+	if (!mc_fdsp_info.initialized)
+		return -EBUSY;
+
+	return fdsp_audio_engine_set(&fdsp);
+}
+
+int mc_fdsp_start(void)
+{
+	if (!mc_fdsp_info.initialized)
+		return -EBUSY;
+
+	if (mc_fdsp_info.dsp_bypass & MCB_DSPBYPASS) {
+		mc_fdsp_info.app_stop = 0;
+		fdsp_control_set(MCB_DSPBYPASS);
+	} else if (!(mc_fdsp_info.dsp_ctrl & MCB_DSPSTART)) {
+		mc_fdsp_info.app_stop = 0;
+		fdsp_control_set(MCB_DSPSTART);
+		fdsp_face_in_set();
+	}
+
+	return 0;
+}
+
+int mc_fdsp_stop(void)
+{
+	if (!mc_fdsp_info.initialized)
+		return 0;
+
+	if (mc_fdsp_info.dsp_ctrl & MCB_DSPSTART)
+		fdsp_fade_out_set();
+
+	fdsp_control_set(MCI_DSPCTRL_DEF);
+
+	return 0;
+}
+
+int mc_fdsp_set_mute(struct mcdrv_fdsp_mute *mute)
+{
+	u8 adi_mute0, adi_mute1;
+	u8 ado_mute0, ado_mute1;
+	int i;
+
+	if (!mute)
+		return -EINVAL;
+
+	for (i = 0; i < FDSP_MUTE_NUM; i++)
+		if (mute->in_mute[i] > FDSP_MUTE_OFF ||
+		    mute->out_mute[i] > FDSP_MUTE_OFF)
+			return -EINVAL;
+
+	if (!mc_fdsp_info.initialized)
+		return -EBUSY;
+
+	adi_mute0 = mc_fdsp_info.adi_mute0;
+	adi_mute0 = create_mute_value(adi_mute0, mute->in_mute[0],
+				      MCB_ADI01MTN | MCB_ADI00MTN);
+	adi_mute0 = create_mute_value(adi_mute0, mute->in_mute[1],
+				      MCB_ADI03MTN | MCB_ADI02MTN);
+	adi_mute0 = create_mute_value(adi_mute0, mute->in_mute[2],
+				      MCB_ADI05MTN | MCB_ADI04MTN);
+	adi_mute0 = create_mute_value(adi_mute0, mute->in_mute[3],
+				      MCB_ADI07MTN | MCB_ADI06MTN);
+	adi_mute1 = mc_fdsp_info.adi_mute1;
+	adi_mute1 = create_mute_value(adi_mute1, mute->in_mute[4],
+				      MCB_ADI09MTN | MCB_ADI08MTN);
+	adi_mute1 = create_mute_value(adi_mute1, mute->in_mute[5],
+				      MCB_ADI11MTN | MCB_ADI10MTN);
+	adi_mute1 = create_mute_value(adi_mute1, mute->in_mute[6],
+				      MCB_ADI13MTN | MCB_ADI12MTN);
+	adi_mute1 = create_mute_value(adi_mute1, mute->in_mute[7],
+				      MCB_ADI15MTN | MCB_ADI14MTN);
+
+	ado_mute0 = mc_fdsp_info.ado_mute0;
+	ado_mute0 = create_mute_value(ado_mute0, mute->out_mute[0],
+				      MCB_ADO01MTN | MCB_ADO00MTN);
+	ado_mute0 = create_mute_value(ado_mute0, mute->out_mute[1],
+				      MCB_ADO03MTN | MCB_ADO02MTN);
+	ado_mute0 = create_mute_value(ado_mute0, mute->out_mute[2],
+				      MCB_ADO05MTN | MCB_ADO04MTN);
+	ado_mute0 = create_mute_value(ado_mute0, mute->out_mute[3],
+				      MCB_ADO07MTN | MCB_ADO06MTN);
+	ado_mute1 = mc_fdsp_info.ado_mute1;
+	ado_mute1 = create_mute_value(ado_mute1, mute->out_mute[4],
+				      MCB_ADO09MTN | MCB_ADO08MTN);
+	ado_mute1 = create_mute_value(ado_mute1, mute->out_mute[5],
+				      MCB_ADO11MTN | MCB_ADO10MTN);
+	ado_mute1 = create_mute_value(ado_mute1, mute->out_mute[6],
+				      MCB_ADO13MTN | MCB_ADO12MTN);
+	ado_mute1 = create_mute_value(ado_mute1, mute->out_mute[7],
+				      MCB_ADO15MTN | MCB_ADO14MTN);
+
+	mc_packet_add_force_write_f(MCI_ADIMUTE0, adi_mute0);
+	mc_packet_add_force_write_f(MCI_ADIMUTE1, adi_mute1);
+	mc_packet_add_force_write_f(MCI_ADIMUTE2, MCB_ADIMTSET);
+
+	mc_packet_add_force_write_f(MCI_ADOMUTE0, ado_mute0);
+	mc_packet_add_force_write_f(MCI_ADOMUTE1, ado_mute1);
+	mc_packet_add_force_write_f(MCI_ADOMUTE2, MCB_ADOMTSET);
+
+	mc_packet_execute();
+
+	mc_fdsp_info.adi_mute0 = adi_mute0;
+	mc_fdsp_info.adi_mute1 = adi_mute1;
+	mc_fdsp_info.ado_mute0 = ado_mute0;
+	mc_fdsp_info.ado_mute1 = ado_mute1;
+
+	return 0;
+}
diff --git a/sound/soc/codecs/ymu831/mcfdspdrv.h b/sound/soc/codecs/ymu831/mcfdspdrv.h
new file mode 100644
index 0000000..72c6076
--- /dev/null
+++ b/sound/soc/codecs/ymu831/mcfdspdrv.h
@@ -0,0 +1,55 @@
+/****************************************************************************
+ *
+ * Copyright(c) 2012 Yamaha Corporation. All rights reserved.
+ *
+ * Module	: mcfdspdrv.h
+ * Description	: MC F-DSP driver header
+ * Version	: 1.0.0	Dec 13 2012
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
+ *
+ ****************************************************************************/
+/*
+ * changelog:
+ * - change in the Linux coding style
+ * - remove unnecessary comments
+ * - remove unused codes
+ */
+#ifndef	_MCFDSPDRV_H
+#define	_MCFDSPDRV_H
+
+#include "mcresctrl.h"
+
+#define FDSP_MUTE_NUM		8
+#define FDSP_MUTE_NOTCHANGE	0
+#define FDSP_MUTE_ON		1
+#define FDSP_MUTE_OFF		2
+
+struct mcdrv_fdsp_mute {
+	u8 in_mute[FDSP_MUTE_NUM];
+	u8 out_mute[FDSP_MUTE_NUM];
+};
+
+int mc_fdsp_init(u8 locate, u32 wait);
+void mc_fdsp_term(void);
+void mc_fdsp_irq(void);
+int mc_fdsp_set_dsp(struct mcdrv_aec_info *aec);
+int mc_fdsp_start(void);
+int mc_fdsp_stop(void);
+int mc_fdsp_set_mute(struct mcdrv_fdsp_mute *mute);
+
+#endif /* _MCFDSPDRV_H */
-- 
1.7.9.5
