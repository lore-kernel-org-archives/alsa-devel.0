From: Yoichi Yuasa <yuasa@linux-mips.org>
Subject: [PATCH 03/19] ALSA: ymu831: add B-DSP driver
Date: Wed, 16 Jan 2013 17:28:32 +0900
Message-ID: <20130116172832.7339f01ca4557727fdc3883f@linux-mips.org>
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
 sound/soc/codecs/ymu831/Makefile    |    1 +
 sound/soc/codecs/ymu831/mcbdspdrv.c | 1193 +++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ymu831/mcbdspdrv.h |   43 ++
 3 files changed, 1237 insertions(+)
 create mode 100644 sound/soc/codecs/ymu831/mcbdspdrv.c
 create mode 100644 sound/soc/codecs/ymu831/mcbdspdrv.h

diff --git a/sound/soc/codecs/ymu831/Makefile b/sound/soc/codecs/ymu831/Makefile
index 5b3f66d..e74a60f 100644
--- a/sound/soc/codecs/ymu831/Makefile
+++ b/sound/soc/codecs/ymu831/Makefile
@@ -1,3 +1,4 @@
 snd-soc-ymu831-objs := \
+	mcbdspdrv.o
 
 obj-$(CONFIG_SND_SOC_YMU831) += snd-soc-ymu831.o
diff --git a/sound/soc/codecs/ymu831/mcbdspdrv.c b/sound/soc/codecs/ymu831/mcbdspdrv.c
new file mode 100644
index 0000000..c43604c
--- /dev/null
+++ b/sound/soc/codecs/ymu831/mcbdspdrv.c
@@ -0,0 +1,1193 @@
+/****************************************************************************
+ *
+ * Copyright(c) 2012 Yamaha Corporation. All rights reserved.
+ *
+ * Module	: mcbdspdrv.c
+ * Description	: MC B-DSP driver
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
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+
+#include <asm/byteorder.h>
+
+#include "mcbdspdrv.h"
+#include "mcdefs.h"
+#include "mcdevif.h"
+#include "mcresctrl.h"
+
+#define BDSP_STATUS_IDLE		0
+#define BDSP_STATUS_INITIALIZED		1
+
+#define DATA_SIZE			8
+
+#define AEC_BDSP_TAG_FWCTRL_B		0x00000c00
+#define FWCTRL_B_SIZE			14
+#define AEC_BDSP_TAG_APP_COEF		0x00000700
+#define APP_COEF_FIX_SIZE		9
+#define AEC_BDSP_TAG_APP_REG		0x00000a00
+#define APP_REG_FIX_SIZE		8
+#define AEC_BDSP_TAG_APP_MASK		0xffffff00
+#define AEC_BDSP_TAG_APPNO_MASK		0x000000ff
+
+#define FWCTRL_B_BYPASS			0
+#define FWCTRL_B_AE0_BYP		1
+#define FWCTRL_B_AE1_BYP		2
+#define FWCTRL_B_WIDE			3
+#define FWCTRL_B_HEX			4
+#define FWCTRL_B_EQ3_0A			5
+#define FWCTRL_B_DRC3			6
+#define FWCTRL_B_DRC_0			7
+#define FWCTRL_B_EQ3_0B			8
+#define FWCTRL_B_GEN			9
+#define FWCTRL_B_EQ3_1A			10
+#define FWCTRL_B_AGC			11
+#define FWCTRL_B_DRC_1			12
+#define FWCTRL_B_EQ3_1B			13
+
+#define APP_NO_GEN			0
+#define APP_NO_SWAP_0			1
+#define APP_NO_WIDE			2
+#define APP_NO_HEX			3
+#define APP_NO_EQ3_0A			4
+#define APP_NO_DRC3			5
+#define APP_NO_DRC_0			6
+#define APP_NO_EQ3_0B			7
+#define APP_NO_MIX_0			8
+#define APP_NO_SWAP_1			9
+#define APP_NO_EQ3_1A			10
+#define APP_NO_AGC			11
+#define APP_NO_DRC_1			12
+#define APP_NO_EQ3_1B			13
+#define APP_NO_MIX_1			14
+#define APP_NO_LAST			APP_NO_MIX_1
+
+#define APP_COEF_ADR			0
+#define APP_COEF_SIZE			5
+#define APP_COEF_DATA			9
+
+#define APP_REG_FLG			0
+#define APP_REG_FLG_FWCTL0		0x01
+#define APP_REG_FLG_FWCTL1		0x02
+#define APP_REG_FLG_FWCTL2		0x04
+#define APP_REG_FLG_FWCTL3		0x08
+#define APP_REG_FLG_FWCTL4		0x10
+#define APP_REG_FLG_FWCTL5		0x20
+#define APP_REG_FLG_FWCTL6		0x40
+#define APP_REG_FWCTL0			1
+#define APP_REG_FWCTL1			2
+#define APP_REG_FWCTL2			3
+#define APP_REG_FWCTL3			4
+#define APP_REG_FWCTL4			5
+#define APP_REG_FWCTL5			6
+#define APP_REG_FWCTL6			7
+
+#define COEF_DMA_TRANS			0
+#define COEF_DSP_TRANS			1
+#define COEF_DSP_TRANS_MAX		40
+
+#define TARGET_NONE			0x00000000
+#define TARGET_AE0_MASK			0x00003f00
+#define TARGET_AE0_EQ3_0B		0x00002000
+#define TARGET_AE0_DRC_0		0x00001000
+#define TARGET_AE0_DRC3			0x00000800
+#define TARGET_AE0_EQ3_0A		0x00000400
+#define TARGET_AE0_HEX			0x00000200
+#define TARGET_AE0_WIDE			0x00000100
+#define TARGET_AE1_MASK			0x0000003c
+#define TARGET_AE1_EQ3_1B		0x00000020
+#define TARGET_AE1_DRC_1		0x00000010
+#define TARGET_AE1_AGC			0x00000008
+#define TARGET_AE1_EQ3_1A		0x00000004
+#define TARGET_GEN_MASK			0x00008000
+#define TARGET_GEN_GEN			0x00008000
+#define TARGET_BASE_MASK		0xf0000000
+#define TARGET_BASE_SWAP_0		0x10000000
+#define TARGET_BASE_SWAP_1		0x20000000
+#define TARGET_BASE_MIX_0		0x40000000
+#define TARGET_BASE_MIX_1		0x80000000
+
+#define REG_APP_NO_STOP			0
+#define REG_APP_STOP			1
+
+#define MULTI_DATA_APP_COEF		1
+#define MULTI_DATA_APP_REG		2
+
+#define RAM_UNIT_SIZE_32		4UL
+#define RAM_UNIT_SIZE_64		8UL
+#define DXRAM_RANGE_MIN			0x0UL
+#define DXRAM_RANGE_MAX			0x017fUL
+#define DYRAM_RANGE_MIN			0x0UL
+#define DYRAM_RANGE_MAX			0x01ffUL
+
+#define NO_WAIT				0x00
+#define CROSS_FADE_WAIT			0x01
+#define SIN_OUT_WAIT			0x02
+
+#define BDSP_PATH_NORMAL		0
+#define BDSP_PATH_BYPASS		1
+#define BDSP_PATH_DONTCARE		2
+
+#define BDSP_BYPASS_FADE_TIME		10	/* msec */
+
+#define BDSP_SIN_CTRL_REG		0
+#define BDSP_SIN_CTRL_GPIO		1
+
+#define GEN_SIN_CTL_SEL_ADD		0x001d9
+
+#define BDSP_APP_EXEC_STOP		0
+#define BDSP_APP_EXEC_START		1
+
+#define BDSP_OFF			0
+#define BDSP_ON				1
+
+#define BDSP_PRC_FADE_AE0		0x01
+#define BDSP_PRC_FADE_AE1		0x02
+#define BDSP_PRC_SINOUT			0x04
+#define BDSP_PRC_COEF_TRS		0x08
+
+#define BDSP_AE_FW_DXRAM		1
+#define BDSP_AE_FW_DYRAM		2
+
+struct aec_bdsp_info {
+	u8 on;
+	u8 *data;
+	u32 data_size;
+	u8 *fwctrl_b;
+	u8 ae0_app_onoff;
+	u8 ae1_app_onoff;
+	u8 app_gen;
+	u32 app_coef_count;
+	u8 coef_trans;
+	u32 coef_target;
+	u8 sin_ctrl_sel;
+	u32 app_reg_count;
+	u32 app_stop_target;
+	u8 stopped_app_exec0;
+	u8 stopped_app_exec1;
+	u8 stopped_sin_out;
+	u8 stopped_bypass;
+};
+
+struct bdsp_info {
+	u32 status;
+	u8 dsp_bypass;
+	u8 sin_ctrl_sel;
+	u8 dsp_ctrl;
+	u8 app_exec0;
+	u8 app_exec1;
+	u8 aebypass;
+};
+
+static struct bdsp_info mc_bdsp_info = {
+	.status = BDSP_STATUS_IDLE,
+};
+
+static void bdsp_get_data(struct mcdrv_aec_info *aec,
+			  struct aec_bdsp_info *bdsp)
+{
+	bdsp->on = BDSP_OFF;
+	bdsp->data = NULL;
+	bdsp->data_size = 0;
+
+	if (aec->audio_engine.enable) {
+		bdsp->on = aec->audio_engine.on;
+		if (bdsp->on == BDSP_OFF)
+			return;
+
+		bdsp->data = aec->audio_engine.bdsp.data;
+		bdsp->data_size = aec->audio_engine.bdsp.data_size;
+	}
+
+	if (bdsp->data)
+		bdsp->data = &bdsp->data[DATA_SIZE];
+}
+
+static u8 bdsp_app_exec(u8 onoff, u8 app, u8 exec)
+{
+	switch (onoff) {
+	case BDSP_APP_EXEC_STOP:
+		if ((app & exec) == 0)
+			app = 0x00;
+		break;
+	case BDSP_APP_EXEC_START:
+		if ((app & exec) != 0)
+			app = 0x00;
+		break;
+	default:
+		app = 0x00;
+		break;
+	}
+
+	return app;
+}
+
+static inline void bdsp_app_check(struct aec_bdsp_info *bdsp)
+{
+	u8 *data;
+	u8 onoff, exec;
+
+	data = bdsp->fwctrl_b;
+
+	onoff = bdsp->ae0_app_onoff;
+	exec = mc_bdsp_info.app_exec0;
+
+	onoff |= bdsp_app_exec(data[FWCTRL_B_WIDE], MCB_AEEXEC0_WIDE, exec);
+	onoff |= bdsp_app_exec(data[FWCTRL_B_HEX], MCB_AEEXEC0_HEX, exec);
+	onoff |= bdsp_app_exec(data[FWCTRL_B_EQ3_0A], MCB_AEEXEC0_EQ3_0A, exec);
+	onoff |= bdsp_app_exec(data[FWCTRL_B_DRC3], MCB_AEEXEC0_DRC3, exec);
+	onoff |= bdsp_app_exec(data[FWCTRL_B_DRC_0], MCB_AEEXEC0_DRC_0, exec);
+	onoff |= bdsp_app_exec(data[FWCTRL_B_EQ3_0B], MCB_AEEXEC0_EQ3_0B, exec);
+
+	bdsp->ae0_app_onoff = onoff;
+
+	onoff = bdsp->ae1_app_onoff;
+	exec = mc_bdsp_info.app_exec1;
+
+	onoff |= bdsp_app_exec(data[FWCTRL_B_EQ3_1A], MCB_AEEXEC1_EQ3_1A, exec);
+	onoff |= bdsp_app_exec(data[FWCTRL_B_AGC], MCB_AEEXEC1_AGC, exec);
+	onoff |= bdsp_app_exec(data[FWCTRL_B_DRC_1], MCB_AEEXEC1_DRC_1, exec);
+	onoff |= bdsp_app_exec(data[FWCTRL_B_EQ3_1B], MCB_AEEXEC1_EQ3_1B, exec);
+
+	bdsp->ae1_app_onoff = onoff;
+
+	if ((data[FWCTRL_B_GEN] == BDSP_APP_EXEC_STOP) &&
+	    (mc_bdsp_info.app_exec0 & MCB_AEEXEC0_GEN) != 0)
+		bdsp->app_gen |= MCB_AEEXEC0_GEN;
+}
+
+static u32 bdsp_app_to_target(u32 app_no)
+{
+	switch (app_no) {
+	case APP_NO_GEN:
+		return TARGET_GEN_GEN;
+	case APP_NO_SWAP_0:
+		return TARGET_BASE_SWAP_0;
+	case APP_NO_WIDE:
+		return TARGET_AE0_WIDE;
+	case APP_NO_HEX:
+		return TARGET_AE0_HEX;
+	case APP_NO_EQ3_0A:
+		return TARGET_AE0_EQ3_0A;
+	case APP_NO_DRC3:
+		return TARGET_AE0_DRC3;
+	case APP_NO_DRC_0:
+		return TARGET_AE0_DRC_0;
+	case APP_NO_EQ3_0B:
+		return TARGET_AE0_EQ3_0B;
+	case APP_NO_MIX_0:
+		return TARGET_BASE_MIX_0;
+	case APP_NO_SWAP_1:
+		return TARGET_BASE_SWAP_1;
+	case APP_NO_EQ3_1A:
+		return TARGET_AE1_EQ3_1A;
+	case APP_NO_AGC:
+		return TARGET_AE1_AGC;
+	case APP_NO_DRC_1:
+		return TARGET_AE1_DRC_1;
+	case APP_NO_EQ3_1B:
+		return TARGET_AE1_EQ3_1B;
+	case APP_NO_MIX_1:
+		return TARGET_BASE_MIX_1;
+	default:
+		break;
+	}
+
+	return TARGET_NONE;
+}
+
+static void bdsp_check_sin_control_sel(struct aec_bdsp_info *bdsp, u8 *data)
+{
+	u32 addr;
+	u32 size;
+
+	addr = htonl(*(u32 *) data);
+	size = htonl(*(u32 *) (data + 5));
+	data = &data[9];
+
+	if (addr > GEN_SIN_CTL_SEL_ADD)
+		return;
+
+	if ((addr + (size / 4)) < GEN_SIN_CTL_SEL_ADD)
+		return;
+
+	addr = GEN_SIN_CTL_SEL_ADD - addr;
+
+	if ((data[(addr * 4) + 3] & BDSP_SIN_CTRL_GPIO) != 0)
+		bdsp->sin_ctrl_sel = BDSP_SIN_CTRL_GPIO;
+	else
+		bdsp->sin_ctrl_sel = BDSP_SIN_CTRL_REG;
+}
+
+static int bdsp_app_data_analyze(struct aec_bdsp_info *bdsp,
+				 u32 id, u32 size, u32 top, u8 *data)
+{
+	u32 tag, target;
+	u32 val;
+
+	tag = id & AEC_BDSP_TAG_APP_MASK;
+	if ((tag != AEC_BDSP_TAG_APP_COEF) && (tag != AEC_BDSP_TAG_APP_REG))
+		return 0;
+
+	target = bdsp_app_to_target(id & AEC_BDSP_TAG_APPNO_MASK);
+
+	if (tag == AEC_BDSP_TAG_APP_COEF) {
+		if (size < APP_COEF_FIX_SIZE)
+			return -EINVAL;
+
+		val = htonl(*(u32 *) (data + top + 5));
+		if (!val)
+			return 0;
+
+		if (val & 0x03)
+			return -EINVAL;
+
+		if (size < (val + APP_COEF_FIX_SIZE))
+			return -EINVAL;
+
+		bdsp->app_coef_count++;
+
+		if ((data[top + 4] != COEF_DSP_TRANS) ||
+		    (val > COEF_DSP_TRANS_MAX) || (bdsp->app_coef_count > 1))
+			bdsp->coef_trans = COEF_DMA_TRANS;
+
+		bdsp->coef_target |= target;
+
+		if (target == TARGET_GEN_GEN)
+			bdsp_check_sin_control_sel(bdsp, &data[top]);
+	} else {
+		if (size < APP_REG_FIX_SIZE)
+			return -EINVAL;
+
+		if (target != TARGET_GEN_GEN)
+			return 0;
+
+		bdsp->app_reg_count++;
+
+		if (data[top + APP_REG_FLG] & APP_REG_FLG_FWCTL4)
+			bdsp->app_stop_target |= TARGET_GEN_GEN;
+	}
+
+	return 0;
+}
+
+static int bdsp_data_analyze(struct aec_bdsp_info *bdsp)
+{
+	u32 top, id, size;
+	u8 *data;
+	u32 data_size;
+
+	bdsp->fwctrl_b = NULL;
+	bdsp->app_coef_count = 0UL;
+	bdsp->coef_trans = COEF_DSP_TRANS;
+	bdsp->ae0_app_onoff = 0;
+	bdsp->ae1_app_onoff = 0;
+	bdsp->app_gen = 0;
+	bdsp->coef_target = TARGET_NONE;
+	bdsp->sin_ctrl_sel = mc_bdsp_info.sin_ctrl_sel;
+	bdsp->app_reg_count = 0UL;
+	bdsp->app_stop_target = TARGET_NONE;
+	bdsp->stopped_app_exec0 = 0;
+	bdsp->stopped_app_exec1 = 0;
+	bdsp->stopped_sin_out = 0;
+	bdsp->stopped_bypass = 0;
+
+	if (!bdsp->data || !bdsp->data_size)
+		return 0;
+
+	data = bdsp->data;
+	data_size = bdsp->data_size;
+	top = 0;
+	while (top < data_size) {
+		if (data_size < (top + DATA_SIZE))
+			return -EINVAL;
+
+		id = htonl(*(u32 *) (data + top));
+		size = htonl(*(u32 *) (data + top + 4));
+		if (data_size < (top + DATA_SIZE + size))
+			return -EINVAL;
+
+		top += DATA_SIZE;
+		switch (id) {
+		case AEC_BDSP_TAG_FWCTRL_B:
+			if (size < FWCTRL_B_SIZE)
+				return -EINVAL;
+			if (bdsp->fwctrl_b != NULL)
+				return -EINVAL;
+
+			bdsp->fwctrl_b = &data[top];
+
+			bdsp_app_check(bdsp);
+			break;
+		default:
+			if (bdsp_app_data_analyze(bdsp, id, size, top, data))
+				return -EINVAL;
+		}
+
+		top += size;
+	}
+
+	return 0;
+}
+
+static inline int bdsp_trans_wait(void)
+{
+	mc_packet_add_wait_event(MCDRV_EVT_IF_REG_FLAG_RESET |
+				 (MCI_BDSPTREQ << 8) | MCB_BDSPTREQ);
+
+	return mc_packet_execute();
+}
+
+static inline int bdsp_cross_fade_wait(void)
+{
+	msleep(BDSP_BYPASS_FADE_TIME);
+
+	mc_packet_add_wait_event(MCDRV_EVT_B_REG_FLAG_RESET |
+				 (MCI_AEFADE << 8) | MCB_AEFADE_AE1 |
+				 MCB_AEFADE_AE0);
+
+	return mc_packet_execute();
+}
+
+static inline int bdsp_sin_out_wait(void)
+{
+	mc_packet_add_wait_event(MCDRV_EVT_B_REG_FLAG_RESET |
+				 (MCI_SINOUTFLG << 8) | MCB_SINOFLG);
+
+	return mc_packet_execute();
+}
+
+static inline u32 bdsp_path_bypass(struct aec_bdsp_info *bdsp)
+{
+	u8 bypass, stopped = 0;
+	u32 wait = NO_WAIT;
+
+	bypass = mc_bdsp_info.aebypass;
+
+	if (bdsp->ae0_app_onoff) {
+		bypass |= MCB_AEBYPASS_AE0;
+		stopped |= MCB_AEBYPASS_AE0;
+	}
+
+	if (bdsp->ae1_app_onoff) {
+		bypass |= MCB_AEBYPASS_AE1;
+		stopped |= MCB_AEBYPASS_AE1;
+	}
+
+	if (bdsp->coef_trans == COEF_DMA_TRANS) {
+		if (bdsp->coef_target & TARGET_AE0_MASK) {
+			bypass |= MCB_AEBYPASS_AE0;
+			stopped |= MCB_AEBYPASS_AE0;
+		}
+
+		if (bdsp->coef_target & TARGET_AE1_MASK) {
+			bypass |= MCB_AEBYPASS_AE1;
+			stopped |= MCB_AEBYPASS_AE1;
+		}
+	}
+
+	if (bypass != mc_bdsp_info.aebypass) {
+		mc_packet_add_write_b(MCI_AEBYPASS, bypass);
+		mc_packet_execute();
+
+		wait = CROSS_FADE_WAIT;
+		bdsp->stopped_bypass = stopped;
+		mc_bdsp_info.aebypass = bypass;
+	}
+
+	return wait;
+}
+
+static inline u32 bdsp_sin_stop(struct aec_bdsp_info *bdsp)
+{
+	u8 data;
+	u32 wait = NO_WAIT;
+
+	if (mc_bdsp_info.sin_ctrl_sel == BDSP_SIN_CTRL_GPIO)
+		return NO_WAIT;
+
+	if (!(mc_bdsp_info.app_exec0 & MCB_AEEXEC0_GEN))
+		return NO_WAIT;
+
+	if ((bdsp->app_gen || (bdsp->app_stop_target & TARGET_GEN_MASK)) ||
+	    ((bdsp->coef_trans == COEF_DMA_TRANS) &&
+	     (bdsp->coef_target & TARGET_GEN_MASK))) {
+		wait = SIN_OUT_WAIT;
+
+		mc_read_b(MCI_SINOUT, &data, 1);
+		if (data & MCB_SINOUT) {
+			mc_packet_add_write_b(MCI_SINOUT, MCI_SINOUT_DEF);
+			mc_packet_execute();
+
+			bdsp->stopped_sin_out = MCB_SINOUT;
+		}
+	}
+
+	return wait;
+}
+
+static inline void bdsp_app_stop(struct aec_bdsp_info *bdsp)
+{
+	u8 app_exec0, app_exec1;
+	u8 stopped_app_exec0 = 0, stopped_app_exec1 = 0;
+
+	app_exec0 = mc_bdsp_info.app_exec0;
+	app_exec1 = mc_bdsp_info.app_exec1;
+
+	if (bdsp->coef_trans == COEF_DMA_TRANS) {
+		if ((bdsp->coef_target & TARGET_AE0_EQ3_0B) &&
+		    (app_exec0 & MCB_AEEXEC0_EQ3_0B)) {
+			app_exec0 &= ~MCB_AEEXEC0_EQ3_0B;
+			stopped_app_exec0 |= MCB_AEEXEC0_EQ3_0B;
+		}
+		if ((bdsp->coef_target & TARGET_AE0_DRC_0) &&
+		    (app_exec0 & MCB_AEEXEC0_DRC_0)) {
+			app_exec0 &= ~MCB_AEEXEC0_DRC_0;
+			stopped_app_exec0 |= MCB_AEEXEC0_DRC_0;
+		}
+		if ((bdsp->coef_target & TARGET_AE0_DRC3) &&
+		    (app_exec0 & MCB_AEEXEC0_DRC3)) {
+			app_exec0 &= ~MCB_AEEXEC0_DRC3;
+			stopped_app_exec0 |= MCB_AEEXEC0_DRC3;
+		}
+		if ((bdsp->coef_target & TARGET_AE0_EQ3_0A) &&
+		    (app_exec0 & MCB_AEEXEC0_EQ3_0A)) {
+			app_exec0 &= ~MCB_AEEXEC0_EQ3_0A;
+			stopped_app_exec0 |= MCB_AEEXEC0_EQ3_0A;
+		}
+		if ((bdsp->coef_target & TARGET_AE0_HEX) &&
+		    (app_exec0 & MCB_AEEXEC0_HEX)) {
+			app_exec0 &= ~MCB_AEEXEC0_HEX;
+			stopped_app_exec0 |= MCB_AEEXEC0_HEX;
+		}
+		if ((bdsp->coef_target & TARGET_AE0_WIDE) &&
+		    (app_exec0 & MCB_AEEXEC0_WIDE)) {
+			app_exec0 &= ~MCB_AEEXEC0_WIDE;
+			stopped_app_exec0 |= MCB_AEEXEC0_WIDE;
+		}
+
+		if ((bdsp->coef_target & TARGET_AE1_EQ3_1B) &&
+		    (app_exec1 & MCB_AEEXEC1_EQ3_1B)) {
+			app_exec1 &= ~MCB_AEEXEC1_EQ3_1B;
+			stopped_app_exec1 |= MCB_AEEXEC1_EQ3_1B;
+		}
+		if ((bdsp->coef_target & TARGET_AE1_DRC_1) &&
+		    (app_exec1 & MCB_AEEXEC1_DRC_1)) {
+			app_exec1 &= ~MCB_AEEXEC1_DRC_1;
+			stopped_app_exec1 |= MCB_AEEXEC1_DRC_1;
+		}
+		if ((bdsp->coef_target & TARGET_AE1_AGC) &&
+		    (app_exec1 & MCB_AEEXEC1_AGC)) {
+			app_exec1 &= ~MCB_AEEXEC1_AGC;
+			stopped_app_exec1 |= MCB_AEEXEC1_AGC;
+		}
+		if ((bdsp->coef_target & TARGET_AE1_EQ3_1A) &&
+		    (app_exec1 & MCB_AEEXEC1_EQ3_1A)) {
+			app_exec1 &= ~MCB_AEEXEC1_EQ3_1A;
+			stopped_app_exec1 |= MCB_AEEXEC1_EQ3_1A;
+		}
+
+		if ((bdsp->coef_target & TARGET_GEN_GEN) &&
+		    (app_exec0 & MCB_AEEXEC0_GEN)) {
+			app_exec0 &= ~MCB_AEEXEC0_GEN;
+			stopped_app_exec0 |= MCB_AEEXEC0_GEN;
+		}
+	}
+
+	if ((bdsp->app_stop_target & TARGET_GEN_GEN) &&
+	    (app_exec0 & MCB_AEEXEC0_GEN)) {
+		app_exec0 &= ~MCB_AEEXEC0_GEN;
+		stopped_app_exec0 |= MCB_AEEXEC0_GEN;
+	}
+
+	mc_packet_add_write_b(MCI_AEEXEC0, app_exec0);
+
+	mc_packet_add_write_b(MCI_AEEXEC1, app_exec1);
+
+	bdsp->stopped_app_exec0 = stopped_app_exec0;
+	bdsp->stopped_app_exec1 = stopped_app_exec1;
+
+	mc_bdsp_info.app_exec0 = app_exec0;
+	mc_bdsp_info.app_exec1 = app_exec1;
+}
+
+static int bdsp_stop_all(struct aec_bdsp_info *bdsp)
+{
+	int ret;
+	u32 wait = NO_WAIT;
+
+	ret = bdsp_trans_wait();
+	if (ret < 0)
+		return ret;
+
+	wait |= bdsp_path_bypass(bdsp);
+	wait |= bdsp_sin_stop(bdsp);
+	if (wait & CROSS_FADE_WAIT) {
+		ret = bdsp_cross_fade_wait();
+		if (ret < 0)
+			return ret;
+	}
+	if (wait & SIN_OUT_WAIT) {
+		ret = bdsp_sin_out_wait();
+		if (ret < 0)
+			return ret;
+	}
+
+	bdsp_app_stop(bdsp);
+
+	return 0;
+}
+
+static void bdsp_app_coef_download(u8 *app_coef, u8 coef_trans)
+{
+	u32 size;
+	int i;
+
+	mc_packet_add_force_write_if(MCI_BMAA0,
+				     app_coef[APP_COEF_ADR + 1] & MCB_BMAA0);
+	mc_packet_add_force_write_if(MCI_BMAA1,
+				     app_coef[APP_COEF_ADR + 2] & MCB_BMAA1);
+	mc_packet_add_force_write_if(MCI_BMAA2,
+				     app_coef[APP_COEF_ADR + 3] & MCB_BMAA2);
+
+	if (coef_trans == COEF_DSP_TRANS)
+		mc_packet_add_force_write_if(MCI_BMACTL,
+					     MCB_BDSPTINI | MCB_BMAMOD_DSP |
+					     MCB_BMABUS_Y);
+	else
+		mc_packet_add_force_write_if(MCI_BMACTL, MCB_BMABUS_Y);
+
+	mc_packet_execute();
+
+	size = htonl(*(u32 *) (app_coef + APP_COEF_SIZE));
+	for (i = 0; i < size; i++)
+		mc_packet_add_force_write_if(MCI_BMAD,
+					     app_coef[APP_COEF_DATA + i]);
+
+	mc_packet_execute();
+}
+
+static inline void bdsp_app_reg_download(struct aec_bdsp_info *bdsp,
+					 u32 target, u8 *reg)
+{
+	if (target != TARGET_GEN_GEN)
+		return;
+
+	if (reg[APP_REG_FLG] & APP_REG_FLG_FWCTL4)
+		mc_packet_add_force_write_b(MCI_F01SEL, reg[APP_REG_FWCTL4]);
+
+	if (reg[APP_REG_FLG] & APP_REG_FLG_FWCTL5) {
+		mc_packet_add_force_write_b(MCI_SINOUT, reg[APP_REG_FWCTL5]);
+		if (!(reg[APP_REG_FWCTL5] & MCB_SINOUT))
+			bdsp->stopped_sin_out = 0;
+	}
+
+	mc_packet_execute();
+}
+
+static void bdsp_multi_data_download(struct aec_bdsp_info *bdsp, u32 target)
+{
+	u32 top, id, size;
+	u32 app_no;
+	u8 *data;
+	u32 data_size;
+
+	data = bdsp->data;
+	data_size = bdsp->data_size;
+
+	top = 0;
+	while (top < data_size) {
+		id = htonl(*(u32 *) (data + top));
+		size = htonl(*(u32 *) (data + top + 4));
+
+		top += DATA_SIZE;
+		app_no = id & AEC_BDSP_TAG_APPNO_MASK;
+
+		switch (id & AEC_BDSP_TAG_APP_MASK) {
+		case AEC_BDSP_TAG_APP_COEF:
+			if (target != MULTI_DATA_APP_COEF)
+				break;
+
+			if (app_no <= APP_NO_LAST)
+				bdsp_app_coef_download(&data[top],
+						       bdsp->coef_trans);
+
+			if (app_no == APP_NO_GEN)
+				mc_bdsp_info.sin_ctrl_sel = bdsp->sin_ctrl_sel;
+			break;
+		case AEC_BDSP_TAG_APP_REG:
+			if (target == MULTI_DATA_APP_REG)
+				bdsp_app_reg_download(bdsp,
+						      bdsp_app_to_target
+						      (app_no), &data[top]);
+			break;
+		default:
+			break;
+		}
+
+		top += size;
+	}
+}
+
+static inline void bdsp_download(struct aec_bdsp_info *bdsp)
+{
+	if (bdsp->app_coef_count) {
+		bdsp_multi_data_download(bdsp, MULTI_DATA_APP_COEF);
+
+		if (bdsp->coef_trans == COEF_DSP_TRANS) {
+			mc_packet_add_force_write_if(MCI_BDSPTREQ,
+						     MCB_BDSPTREQ);
+			mc_packet_execute();
+		}
+	}
+
+	if (bdsp->app_reg_count)
+		bdsp_multi_data_download(bdsp, MULTI_DATA_APP_REG);
+}
+
+static u8 bdsp_app_create_exec(u8 onoff, u8 app, u8 exec)
+{
+	switch (onoff) {
+	case BDSP_APP_EXEC_STOP:
+		exec &= ~app;
+		break;
+	case BDSP_APP_EXEC_START:
+		exec |= app;
+		break;
+	default:
+		break;
+	}
+
+	return exec;
+}
+
+static inline void bdsp_app_new(struct aec_bdsp_info *bdsp)
+{
+	u8 app_exec0;
+	u8 app_exec1;
+	u8 *data;
+
+	data = bdsp->fwctrl_b;
+
+	app_exec0 = mc_bdsp_info.app_exec0;
+	app_exec1 = mc_bdsp_info.app_exec1;
+
+	app_exec0 |= bdsp->stopped_app_exec0;
+	app_exec1 |= bdsp->stopped_app_exec1;
+
+	app_exec0 = bdsp_app_create_exec(data[FWCTRL_B_WIDE],
+					 MCB_AEEXEC0_WIDE, app_exec0);
+	app_exec0 = bdsp_app_create_exec(data[FWCTRL_B_HEX],
+					 MCB_AEEXEC0_HEX, app_exec0);
+	app_exec0 = bdsp_app_create_exec(data[FWCTRL_B_EQ3_0A],
+					 MCB_AEEXEC0_EQ3_0A, app_exec0);
+	app_exec0 = bdsp_app_create_exec(data[FWCTRL_B_DRC3],
+					 MCB_AEEXEC0_DRC3, app_exec0);
+	app_exec0 = bdsp_app_create_exec(data[FWCTRL_B_DRC_0],
+					 MCB_AEEXEC0_DRC_0, app_exec0);
+	app_exec0 = bdsp_app_create_exec(data[FWCTRL_B_EQ3_0B],
+					 MCB_AEEXEC0_EQ3_0B, app_exec0);
+
+	app_exec0 = bdsp_app_create_exec(data[FWCTRL_B_GEN],
+					 MCB_AEEXEC0_GEN, app_exec0);
+
+	app_exec1 = bdsp_app_create_exec(data[FWCTRL_B_EQ3_1A],
+					 MCB_AEEXEC1_EQ3_1A, app_exec1);
+	app_exec1 = bdsp_app_create_exec(data[FWCTRL_B_AGC],
+					 MCB_AEEXEC1_AGC, app_exec1);
+	app_exec1 = bdsp_app_create_exec(data[FWCTRL_B_DRC_1],
+					 MCB_AEEXEC1_DRC_1, app_exec1);
+	app_exec1 = bdsp_app_create_exec(data[FWCTRL_B_EQ3_1B],
+					 MCB_AEEXEC1_EQ3_1B, app_exec1);
+
+	mc_packet_add_write_b(MCI_AEEXEC0, app_exec0);
+
+	mc_packet_add_write_b(MCI_AEEXEC1, app_exec1);
+
+	mc_packet_execute();
+
+	mc_bdsp_info.app_exec0 = app_exec0;
+	mc_bdsp_info.app_exec1 = app_exec1;
+}
+
+static inline void bdsp_sin_start(struct aec_bdsp_info *bdsp)
+{
+	if (bdsp->stopped_sin_out == MCB_SINOUT) {
+		mc_packet_add_write_b(MCI_SINOUT, MCB_SINOUT);
+		mc_packet_execute();
+	}
+}
+
+static inline void bdsp_path_new(struct aec_bdsp_info *bdsp)
+{
+	u8 aebypass;
+	u8 *data;
+
+	data = bdsp->fwctrl_b;
+	if (!data)
+		return;
+
+	aebypass = mc_bdsp_info.aebypass;
+
+	switch (data[FWCTRL_B_AE0_BYP]) {
+	case BDSP_PATH_NORMAL:
+		aebypass &= ~MCB_AEBYPASS_AE0;
+		break;
+	case BDSP_PATH_BYPASS:
+		aebypass |= MCB_AEBYPASS_AE0;
+		break;
+	default:
+		break;
+	}
+
+	switch (data[FWCTRL_B_AE1_BYP]) {
+	case BDSP_PATH_NORMAL:
+		aebypass &= ~MCB_AEBYPASS_AE1;
+		break;
+	case BDSP_PATH_BYPASS:
+		aebypass |= MCB_AEBYPASS_AE1;
+		break;
+	default:
+		break;
+	}
+
+	mc_packet_add_write_b(MCI_AEBYPASS, aebypass);
+
+	mc_packet_execute();
+
+	mc_bdsp_info.aebypass = aebypass;
+}
+
+static inline void bdsp_path_set_audio_if(struct aec_bdsp_info *bdsp)
+{
+	u8 dsp_ctrl;
+
+	switch (bdsp->fwctrl_b[FWCTRL_B_BYPASS]) {
+	case BDSP_PATH_NORMAL:
+	case BDSP_PATH_BYPASS:
+		mc_bdsp_info.dsp_bypass =
+		    ((bdsp->fwctrl_b[FWCTRL_B_BYPASS] << 7) & MCB_BDSPBYPASS);
+		break;
+	default:
+		break;
+	};
+
+	dsp_ctrl = mc_bdsp_info.dsp_ctrl;
+	switch (mc_bdsp_info.dsp_bypass & MCB_BDSPBYPASS) {
+	case MCB_BDSPBYPASS:
+		if (dsp_ctrl & MCB_BDSPSTART)
+			dsp_ctrl = MCB_BDSPBYPASS;
+		break;
+	default:
+		if (dsp_ctrl & MCB_BDSPBYPASS)
+			dsp_ctrl = MCB_BDSPSTART;
+		break;
+	}
+
+	mc_packet_add_write_b(MCI_BDSPCTRL, dsp_ctrl);
+
+	mc_packet_execute();
+
+	mc_bdsp_info.dsp_ctrl = dsp_ctrl;
+}
+
+static inline void bdsp_app_resume(struct aec_bdsp_info *bdsp)
+{
+	u8 app_exec0;
+	u8 app_exec1;
+
+	app_exec0 = mc_bdsp_info.app_exec0;
+	app_exec1 = mc_bdsp_info.app_exec1;
+
+	app_exec0 |= bdsp->stopped_app_exec0;
+	app_exec1 |= bdsp->stopped_app_exec1;
+
+	mc_packet_add_write_b(MCI_AEEXEC0, app_exec0);
+
+	mc_packet_add_write_b(MCI_AEEXEC1, app_exec1);
+
+	mc_packet_execute();
+
+	mc_bdsp_info.app_exec0 = app_exec0;
+	mc_bdsp_info.app_exec1 = app_exec1;
+}
+
+static void bdsp_path_resume(struct aec_bdsp_info *bdsp)
+{
+	u8 aebypass;
+
+	aebypass = mc_bdsp_info.aebypass;
+	aebypass &= ~bdsp->stopped_bypass;
+
+	mc_packet_add_write_b(MCI_AEBYPASS, aebypass);
+
+	mc_packet_execute();
+
+	mc_bdsp_info.aebypass = aebypass;
+}
+
+static inline void bdsp_restart(struct aec_bdsp_info *bdsp)
+{
+	if (bdsp->fwctrl_b) {
+		bdsp_app_new(bdsp);
+		bdsp_sin_start(bdsp);
+		bdsp_path_new(bdsp);
+		bdsp_path_set_audio_if(bdsp);
+	} else {
+		bdsp_app_resume(bdsp);
+		bdsp_sin_start(bdsp);
+		bdsp_path_resume(bdsp);
+	}
+}
+
+static inline int bdsp_audio_engine_set(struct aec_bdsp_info *bdsp)
+{
+	int ret;
+
+	if (!(mc_bdsp_info.dsp_ctrl & MCB_BDSPSTART)) {
+		bdsp->ae0_app_onoff = 0;
+		bdsp->ae1_app_onoff = 0;
+		bdsp->app_gen = 0;
+		bdsp->coef_target = TARGET_NONE;
+		bdsp->coef_trans = COEF_DMA_TRANS;
+		bdsp->app_stop_target = TARGET_NONE;
+	}
+
+	ret = bdsp_stop_all(bdsp);
+	if (ret < 0)
+		return ret;
+
+	bdsp_download(bdsp);
+
+	bdsp_restart(bdsp);
+
+	return 0;
+}
+
+static void bdsp_upload(u8 addr0, u32 address, u8 bma_ctrl,
+			u32 size, u32 unit_size, u8 *data)
+{
+	u8 addr1, addr2;
+	int i;
+
+	addr1 = (address >> 8) & MCB_BMAA1;
+	addr2 = address & MCB_BMAA2;
+
+	mc_packet_add_force_write_if(MCI_BMAA0, addr0);
+	mc_packet_add_force_write_if(MCI_BMAA1, addr1);
+	mc_packet_add_force_write_if(MCI_BMAA2, addr2);
+
+	mc_packet_add_force_write_if(MCI_BMACTL, bma_ctrl);
+
+	mc_packet_execute();
+
+	for (i = 0; i < size; i++) {
+		mc_read_digital(MCI_BMAD, &data[(i * unit_size) + 0], 1);
+		mc_read_digital(MCI_BMAD, &data[(i * unit_size) + 1], 1);
+		mc_read_digital(MCI_BMAD, &data[(i * unit_size) + 2], 1);
+		mc_read_digital(MCI_BMAD, &data[(i * unit_size) + 3], 1);
+	}
+
+	mc_packet_add_force_write_if(MCI_BMAA0, MCI_BMAA0_DEF);
+	mc_packet_execute();
+}
+
+int mc_bdsp_init(void)
+{
+	static u8 fader_coef[17] = {
+		0x00, 0x00, 0x00, 0x00,	/* address */
+		0x00,
+		0x00, 0x00, 0x00, 0x08,	/* size 8 (4 * 2) */
+		0xF8, 0x44, 0x41, 0x78,	/* CFADE_0 10ms */
+		0xF8, 0x44, 0x41, 0x78	/* CFADE_1 10ms */
+	};
+
+	if (mc_bdsp_info.status != BDSP_STATUS_IDLE)
+		return -EBUSY;
+
+	mc_bdsp_info.dsp_bypass = MCB_BDSPBYPASS;
+	mc_bdsp_info.sin_ctrl_sel = BDSP_SIN_CTRL_REG;
+
+	mc_bdsp_info.dsp_ctrl = MCI_BDSPCTRL_DEF;
+	mc_bdsp_info.app_exec0 = MCI_AEEXEC0_DEF;
+	mc_bdsp_info.app_exec1 = MCI_AEEXEC1_DEF;
+	mc_bdsp_info.aebypass = MCI_AEBYPASS_DEF;
+
+	mc_packet_add_write_b(MCI_BDSPCTRL, mc_bdsp_info.dsp_ctrl);
+
+	mc_packet_add_write_b(MCI_AEEXEC0, mc_bdsp_info.app_exec0);
+	mc_packet_add_write_b(MCI_AEEXEC1, mc_bdsp_info.app_exec1);
+
+	mc_packet_add_write_b(MCI_AEBYPASS, mc_bdsp_info.aebypass);
+
+	mc_packet_add_write_b(MCI_AEFADE, MCI_AEFADE_DEF);
+
+	mc_packet_add_write_b(MCI_F01SEL, MCI_F01SEL_DEF);
+
+	mc_packet_add_write_b(MCI_SINOUT, MCI_SINOUT_DEF);
+
+	mc_packet_execute();
+
+	mc_bdsp_info.status = BDSP_STATUS_INITIALIZED;
+
+	bdsp_app_coef_download(fader_coef, COEF_DMA_TRANS);
+
+	return 0;
+}
+
+int mc_bdsp_term(void)
+{
+	if (mc_bdsp_info.status == BDSP_STATUS_IDLE)
+		return 0;
+
+	mc_packet_add_force_write_b(MCI_BDSPCTRL, MCI_BDSPCTRL_DEF);
+
+	mc_packet_execute();
+
+	mc_bdsp_info.status = BDSP_STATUS_IDLE;
+
+	return 0;
+}
+
+int mc_bdsp_get_dsp(u32 target, u32 address, u8 *data, u32 size)
+{
+	u8 bma_ctrl;
+	u32 unit_size = 0;
+
+	if (!data)
+		return -EINVAL;
+
+	bma_ctrl = MCB_BMADIR_UL;
+
+	switch (target) {
+	case BDSP_AE_FW_DXRAM:
+		if (address > DXRAM_RANGE_MAX)
+			return -EINVAL;
+
+		unit_size = RAM_UNIT_SIZE_64;
+		size = size / unit_size;
+
+		if (size > DXRAM_RANGE_MAX + 1)
+			size = DXRAM_RANGE_MAX + 1;
+
+		if (address + size > DXRAM_RANGE_MAX + 1)
+			size -= (address + size - (DXRAM_RANGE_MAX + 1));
+
+		bma_ctrl |= MCB_BMABUS_X;
+		break;
+	case BDSP_AE_FW_DYRAM:
+		if (address > DYRAM_RANGE_MAX)
+			return -EINVAL;
+
+		unit_size = RAM_UNIT_SIZE_32;
+		size = size / unit_size;
+
+		if (size > DYRAM_RANGE_MAX + 1)
+			size = DYRAM_RANGE_MAX + 1;
+
+		if (address + size > DYRAM_RANGE_MAX + 1)
+			size -= (address + size - (DYRAM_RANGE_MAX + 1));
+
+		bma_ctrl |= MCB_BMABUS_Y;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!size)
+		return 0;
+
+	if (mc_bdsp_info.status == BDSP_STATUS_IDLE)
+		return 0;
+
+	if (target == BDSP_AE_FW_DXRAM) {
+		bdsp_upload(MCB_BMAA0, address, bma_ctrl, size, unit_size,
+			    data);
+
+		bdsp_upload(MCI_BMAA0_DEF, address, bma_ctrl, size,
+			    unit_size, &data[4]);
+	} else
+		bdsp_upload(MCI_BMAA0_DEF, address, bma_ctrl, size,
+			    unit_size, data);
+
+	return size * unit_size;
+}
+
+int mc_bdsp_set_dsp(struct mcdrv_aec_info *aec)
+{
+	struct aec_bdsp_info bdsp;
+	int ret;
+
+	if (!aec)
+		return -EINVAL;
+
+	bdsp_get_data(aec, &bdsp);
+
+	ret = bdsp_data_analyze(&bdsp);
+	if (ret < 0)
+		return ret;
+
+	if (!bdsp.data || !bdsp.data_size)
+		return 0;
+
+	if (mc_bdsp_info.status == BDSP_STATUS_IDLE)
+		return -EBUSY;
+
+	return bdsp_audio_engine_set(&bdsp);
+}
+
+int mc_bdsp_start(void)
+{
+	if (mc_bdsp_info.status == BDSP_STATUS_IDLE)
+		return -EBUSY;
+
+	if (mc_bdsp_info.dsp_bypass & MCB_BDSPBYPASS)
+		mc_bdsp_info.dsp_ctrl = MCB_BDSPBYPASS;
+	else
+		mc_bdsp_info.dsp_ctrl = MCB_BDSPSTART;
+
+	mc_packet_add_write_b(MCI_BDSPCTRL, mc_bdsp_info.dsp_ctrl);
+
+	mc_packet_execute();
+
+	return 0;
+}
+
+int mc_bdsp_stop(void)
+{
+	if (mc_bdsp_info.status == BDSP_STATUS_IDLE)
+		return 0;
+
+	mc_packet_add_write_if(MCI_BDSPTREQ, MCI_BDSPTREQ_DEF);
+
+	mc_bdsp_info.dsp_ctrl = MCI_BDSPCTRL_DEF;
+	mc_packet_add_write_b(MCI_BDSPCTRL, MCI_BDSPCTRL_DEF);
+
+	mc_packet_execute();
+
+	return 0;
+}
diff --git a/sound/soc/codecs/ymu831/mcbdspdrv.h b/sound/soc/codecs/ymu831/mcbdspdrv.h
new file mode 100644
index 0000000..78971a8
--- /dev/null
+++ b/sound/soc/codecs/ymu831/mcbdspdrv.h
@@ -0,0 +1,43 @@
+/****************************************************************************
+ *
+ * Copyright(c) 2012 Yamaha Corporation. All rights reserved.
+ *
+ * Module	: mcbdspdrv.h
+ * Description	: MC B-DSP driver header
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
+#ifndef	_MCBDSPDRV_H
+#define	_MCBDSPDRV_H
+
+#include "mcresctrl.h"
+
+int mc_bdsp_init(void);
+int mc_bdsp_term(void);
+int mc_bdsp_set_dsp(struct mcdrv_aec_info *aec);
+int mc_bdsp_start(void);
+int mc_bdsp_stop(void);
+
+#endif /* _MCBDSPDRV_H */
-- 
1.7.9.5
