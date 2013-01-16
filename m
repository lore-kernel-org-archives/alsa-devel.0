From: Yoichi Yuasa <yuasa@linux-mips.org>
Subject: [PATCH 08/19] ALSA: ymu831: add E-DSP driver
Date: Wed, 16 Jan 2013 17:34:04 +0900
Message-ID: <20130116173404.cf75b9820432b67f9db9a2ae@linux-mips.org>
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
 sound/soc/codecs/ymu831/mcedspdrv.c |  636 +++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ymu831/mcedspdrv.h |   45 +++
 3 files changed, 683 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/codecs/ymu831/mcedspdrv.c
 create mode 100644 sound/soc/codecs/ymu831/mcedspdrv.h

diff --git a/sound/soc/codecs/ymu831/Makefile b/sound/soc/codecs/ymu831/Makefile
index e908b6d..d0586ca 100644
--- a/sound/soc/codecs/ymu831/Makefile
+++ b/sound/soc/codecs/ymu831/Makefile
@@ -2,6 +2,7 @@ snd-soc-ymu831-objs := \
 	mcbdspdrv.o	\
 	mccdspdrv.o	\
 	mcdevif.o	\
-	mcdriver.o
+	mcdriver.o	\
+	mcedspdrv.o
 
 obj-$(CONFIG_SND_SOC_YMU831) += snd-soc-ymu831.o
diff --git a/sound/soc/codecs/ymu831/mcedspdrv.c b/sound/soc/codecs/ymu831/mcedspdrv.c
new file mode 100644
index 0000000..ad143e8
--- /dev/null
+++ b/sound/soc/codecs/ymu831/mcedspdrv.c
@@ -0,0 +1,636 @@
+/****************************************************************************
+ *
+ * Copyright(c) 2012 Yamaha Corporation. All rights reserved.
+ *
+ * Module	: mcedspdrv.c
+ * Description	: MC E-DSP driver
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
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include <asm/byteorder.h>
+
+#include "mcdefs.h"
+#include "mcdevif.h"
+#include "mcresctrl.h"
+
+#define CHUNK_SIZE			8
+
+#define AEC_EDSP_TAG_IMEM		0x00002000
+#define AEC_EDSP_TAG_XMEM		0x00002100
+#define AEC_EDSP_TAG_YMEM		0x00002200
+#define AEC_EDSP_TAG_REG		0x00002300
+
+#define MEM_FIX_SIZE			4
+
+#define REG_UNIT_NUM			9
+#define REG_FIX_SIZE			4
+#define REG_COMMAND			0
+#define REG_REQ_0			1
+#define REG_REQ_NUM			8
+#define REG_RES_NUM			8
+
+#define E1_COMMAND_RUN_MODE		0x40
+#define E1_COMMAND_SLEEP_MODE		0x00
+#define E1_COMMAND_OFFSET_START		0x02
+#define E1_COMMAND_OFFSET_STOP		0x00
+#define E1_COMMAND_IMPEDANCE_START	0x81
+#define E1_COMMAND_IMPEDANCE_STOP	0x80
+#define OFFSET_START			1
+#define OFFSET_STOP			0
+#define IMPEDANCE_START			1
+#define IMPEDANCE_STOP			0
+
+#define SYSEQ_NUM			15
+#define BAND_NUM			3
+#define SYSEQ_NO_MODIFY			0
+#define SYSEQ_MODIFY_0			1
+#define SYSEQ_MODIFY_0			1
+#define SYSEQ_MODIFY_1			2
+#define SYSEQ_MODIFY_2			4
+
+struct aec_edsp_info {
+	bool on;
+	u8 *data;
+	u32 data_size;
+
+	u8 *i_mem;
+	u32 i_mem_size;
+	u8 *x_mem;
+	u32 x_mem_size;
+	u8 *y_mem;
+	u32 y_mem_size;
+	u8 *reg;
+	u32 cmd_count;
+};
+
+struct edsp_info {
+	bool initialized;
+	u8 sys_eq0_modify;
+	u8 sys_eq0[SYSEQ_NUM * BAND_NUM];
+	u8 sys_eq1_modify;
+	u8 sys_eq1[SYSEQ_NUM * BAND_NUM];
+};
+
+static struct edsp_info mc_edsp_info = {
+	.sys_eq0_modify = SYSEQ_MODIFY_0 | SYSEQ_MODIFY_1 | SYSEQ_MODIFY_2,
+	.sys_eq1_modify = SYSEQ_MODIFY_0 | SYSEQ_MODIFY_1 | SYSEQ_MODIFY_2,
+};
+
+static inline void edsp_get_data(struct mcdrv_aec_info *aec,
+			  struct aec_edsp_info *edsp)
+{
+	if (aec->e2.enable) {
+		edsp->on = aec->e2.on;
+
+		if (!edsp->on)
+			return;
+
+		edsp->data = &aec->e2.config.data[CHUNK_SIZE];
+		edsp->data_size = aec->e2.config.data_size;
+	}
+}
+
+static inline int edsp_data_analyze(struct aec_edsp_info *edsp)
+{
+	u32 top, tag, size, tmp;
+	u8 *data;
+	u32 data_size;
+
+	if (!edsp->on)
+		return 0;
+
+	if (!edsp->data || !edsp->data_size)
+		return 0;
+
+	data = edsp->data;
+	data_size = edsp->data_size;
+
+	top = 0;
+	while (top < data_size) {
+		if (top + CHUNK_SIZE > data_size)
+			return -EINVAL;
+
+		tag = htonl(*(u32 *) (data + top));
+		size = htonl(*(u32 *) (data + top + 4));
+
+		if (top + CHUNK_SIZE + size > data_size)
+			return -EINVAL;
+
+		top += CHUNK_SIZE;
+
+		switch (tag) {
+		case AEC_EDSP_TAG_IMEM:
+			if (data_size < MEM_FIX_SIZE)
+				return -EINVAL;
+
+			tmp = htonl(*(u32 *) (data + top));
+			if (!tmp)
+				break;
+			if (tmp % 3)
+				return -EINVAL;
+			if (tmp + MEM_FIX_SIZE > size)
+				return -EINVAL;
+			if (edsp->i_mem)
+				return -EINVAL;
+
+			edsp->i_mem = &data[top + MEM_FIX_SIZE];
+			edsp->i_mem_size = tmp;
+			break;
+		case AEC_EDSP_TAG_XMEM:
+			if (data_size < MEM_FIX_SIZE)
+				return -EINVAL;
+
+			tmp = htonl(*(u32 *) (data + top));
+			if (!tmp)
+				break;
+			if (tmp & 0x07)
+				return -EINVAL;
+			if (tmp + MEM_FIX_SIZE > size)
+				return -EINVAL;
+			if (edsp->x_mem)
+				return -EINVAL;
+
+			edsp->x_mem = &data[top + MEM_FIX_SIZE];
+			edsp->x_mem_size = tmp;
+			break;
+		case AEC_EDSP_TAG_YMEM:
+			if (data_size < MEM_FIX_SIZE)
+				return -EINVAL;
+
+			tmp = htonl(*(u32 *) (data + top));
+			if (!tmp)
+				break;
+			if (tmp % 3)
+				return -EINVAL;
+			if (tmp + MEM_FIX_SIZE > size)
+				return -EINVAL;
+			if (edsp->y_mem)
+				return -EINVAL;
+
+			edsp->y_mem = &data[top + MEM_FIX_SIZE];
+			edsp->y_mem_size = tmp;
+			break;
+		case AEC_EDSP_TAG_REG:
+			if (data_size < REG_FIX_SIZE)
+				return -EINVAL;
+
+			tmp = htonl(*(u32 *) (data + top));
+			if (!tmp)
+				break;
+			if (tmp != REG_UNIT_NUM)
+				return -EINVAL;
+			if (tmp + REG_FIX_SIZE > size)
+				return -EINVAL;
+			if (edsp->reg)
+				return -EINVAL;
+
+			edsp->reg = &data[top + MEM_FIX_SIZE];
+			edsp->cmd_count = 1;
+			break;
+		default:
+			break;
+		}
+
+		top += size;
+	}
+
+	return 0;
+}
+
+static inline void edsp_firmware_set(struct aec_edsp_info *edsp)
+{
+	u32 i;
+
+	if (!edsp->on)
+		return;
+
+	if (!edsp->i_mem && !edsp->x_mem && !edsp->y_mem)
+		return;
+
+	mc_packet_add_force_write_e(MCI_E2DSP, MCB_E2DSP_RST);
+
+	/* E2IMEM */
+	if (edsp->i_mem) {
+		mc_packet_add_force_write_if(MCI_EDSP_FW_PAGE,
+					     MCB_EDSP_FW_PAGE_E2IMEM);
+		mc_packet_add_force_write_if(MCI_EDSP_FW_A, 0);
+
+		for (i = 0; i < edsp->i_mem_size; ++i)
+			mc_packet_add_force_write_if(MCI_EDSP_FW_D,
+						     edsp->i_mem[i]);
+
+		mc_packet_execute();
+	}
+
+	/* E2YMEM */
+	if (edsp->y_mem) {
+		mc_packet_add_force_write_if(MCI_EDSP_FW_PAGE,
+					     MCB_EDSP_FW_PAGE_E2YMEM);
+		mc_packet_add_force_write_if(MCI_EDSP_FW_A, 0);
+
+		for (i = 0; i < edsp->y_mem_size; ++i)
+			mc_packet_add_force_write_if(MCI_EDSP_FW_D,
+						     edsp->y_mem[i]);
+
+		mc_packet_execute();
+	}
+
+	/* E2XMEM */
+	if (edsp->x_mem) {
+		mc_packet_add_force_write_if(MCI_EDSP_FW_PAGE,
+					     MCB_EDSP_FW_PAGE_E2XMEM);
+
+		mc_packet_add_force_write_if(MCI_EDSP_FW_A, 0);
+
+		for (i = 0; i < edsp->x_mem_size; ++i)
+			mc_packet_add_force_write_if(MCI_EDSP_FW_D,
+						     edsp->x_mem[i]);
+
+		mc_packet_execute();
+	}
+
+	mc_packet_add_force_write_if(MCI_EDSP_FW_PAGE, MCI_EDSP_FW_PAGE_DEF);
+	mc_packet_add_force_write_e(MCI_E2DSP, 0);
+	mc_packet_execute();
+}
+
+static inline void edsp_e2_command_write(struct aec_edsp_info *edsp)
+{
+	int i;
+
+	if (edsp->on && edsp->reg && edsp->cmd_count) {
+		for (i = 0; i < REG_REQ_NUM; ++i)
+			mc_packet_add_force_write_e((MCI_E2REQ_0 + i),
+						    edsp->reg[REG_REQ_0 + i]);
+
+		mc_packet_add_force_write_e(MCI_E2COMMAND,
+					    edsp->reg[REG_COMMAND]);
+		mc_packet_execute();
+	}
+}
+
+static inline void edsp_irq_enable(void)
+{
+	u8 data;
+
+	mc_read_digital(MCI_EEDSP, &data, 1);
+	data |= MCB_EE2DSP;
+	mc_packet_add_write_if(MCI_EEDSP, data);
+}
+
+static inline void edsp_irq_disable(void)
+{
+	u8 data;
+
+	mc_read_digital(MCI_EEDSP, &data, 1);
+	data &= ~MCB_EE2DSP;
+	mc_packet_add_write_if(MCI_EEDSP, data);
+}
+
+int mc_edsp_init(void)
+{
+	int i;
+
+	if (mc_edsp_info.initialized)
+		return -EBUSY;
+
+	mc_edsp_info.initialized = true;
+
+	mc_edsp_info.sys_eq0_modify = SYSEQ_MODIFY_0 | SYSEQ_MODIFY_1 |
+	    SYSEQ_MODIFY_2;
+	mc_edsp_info.sys_eq1_modify = SYSEQ_MODIFY_0 | SYSEQ_MODIFY_1 |
+	    SYSEQ_MODIFY_2;
+	for (i = 0; i < SYSEQ_NUM * BAND_NUM; ++i)
+		mc_edsp_info.sys_eq0[i] = 0;
+	for (i = 0; i < SYSEQ_NUM * BAND_NUM; ++i)
+		mc_edsp_info.sys_eq1[i] = 0;
+
+	return 0;
+}
+
+void mc_edsp_term(void)
+{
+	u8 data;
+
+	if (!mc_edsp_info.initialized)
+		return;
+
+	mc_read_digital(MCI_EEDSP, &data, 1);
+	data &= ~(MCB_EE2DSP_OV | MCB_EE2DSP);
+	mc_packet_add_force_write_if(MCI_EEDSP, data);
+	mc_packet_add_force_write_if(MCI_EDSP, MCB_E2DSP_STA);
+	mc_packet_add_force_write_e(MCI_E2DSP, MCI_E2DSP_DEF);
+	mc_packet_execute();
+
+	mc_edsp_info.initialized = false;
+}
+
+void mc_edsp_irq(void)
+{
+	u8 status, data;
+
+	mc_read_digital(MCI_EDSP, &status, 1);
+	status &= MCB_E2DSP_STA;
+	mc_packet_add_force_write_if(MCI_EDSP, status);
+	mc_packet_execute();
+
+	if (status & MCB_E2DSP_STA)
+		mc_read_e(MCI_E2STATUS, &data, 1);
+}
+
+int mc_edsp_set_dsp(struct mcdrv_aec_info *aec)
+{
+	struct aec_edsp_info edsp;
+	int ret;
+
+	if (!aec)
+		return -EINVAL;
+
+	memset(&edsp, 0, sizeof(edsp));
+
+	edsp_get_data(aec, &edsp);
+
+	ret = edsp_data_analyze(&edsp);
+	if (ret < 0)
+		return ret;
+
+	if (aec->e2.enable && !edsp.on) {
+		mc_packet_add_force_write_e(MCI_E2DSP, MCB_E2DSP_RST);
+		mc_packet_execute();
+	}
+
+	if (!edsp.data || !edsp.data_size)
+		return 0;
+
+	if (!mc_edsp_info.initialized)
+		return -EBUSY;
+
+	edsp_firmware_set(&edsp);
+
+	edsp_e2_command_write(&edsp);
+
+	return 0;
+}
+
+int mc_edsp_start(void)
+{
+	if (!mc_edsp_info.initialized)
+		return -EBUSY;
+
+	edsp_irq_enable();
+
+	return 0;
+}
+
+int mc_edsp_stop(void)
+{
+	if (!mc_edsp_info.initialized)
+		return -EBUSY;
+
+	edsp_irq_disable();
+
+	return 0;
+}
+
+static int edsp_e1_download_1band(u8 *sys_eq0, u8 *sys_eq1, u8 enable)
+{
+	u8 tmp;
+	bool sys_eq0_skip = false, sys_eq1_skip = false;
+	int i;
+
+	tmp = enable;
+	if (sys_eq0) {
+		for (i = 0; i < SYSEQ_NUM; ++i)
+			if (mc_edsp_info.sys_eq0[i] != sys_eq0[i]) {
+				mc_edsp_info.sys_eq0[i] = sys_eq0[i];
+				mc_edsp_info.sys_eq0_modify = true;
+			}
+
+		if (mc_edsp_info.sys_eq0_modify)
+			tmp &= ~MCB_SYSEQ_SYSEQ0_ENB;
+		else
+			sys_eq0_skip = true;
+		mc_edsp_info.sys_eq0_modify = false;
+	}
+	if (sys_eq1) {
+		for (i = 0; i < SYSEQ_NUM; ++i)
+			if (mc_edsp_info.sys_eq1[i] != sys_eq1[i]) {
+				mc_edsp_info.sys_eq1[i] = sys_eq1[i];
+				mc_edsp_info.sys_eq1_modify = true;
+			}
+
+		if (mc_edsp_info.sys_eq1_modify)
+			tmp &= ~MCB_SYSEQ_SYSEQ1_ENB;
+		else
+			sys_eq1_skip = true;
+		mc_edsp_info.sys_eq1_modify = false;
+	}
+
+	if (sys_eq0_skip && sys_eq1_skip)
+		return 0;
+
+	mc_packet_add_force_write_e(MCI_SYSEQ, tmp);
+
+	if (!sys_eq0_skip) {
+		mc_packet_add_force_write_if(MCI_EDSP_FW_PAGE,
+					     MCB_EDSP_FW_PAGE_SYSEQ0);
+
+		for (i = 0; i < SYSEQ_NUM; ++i)
+			mc_packet_add_force_write_if(MCI_EDSP_FW_D, sys_eq0[i]);
+
+		mc_packet_execute();
+	}
+
+	if (!sys_eq1_skip) {
+		mc_packet_add_force_write_if(MCI_EDSP_FW_PAGE,
+					     MCB_EDSP_FW_PAGE_SYSEQ1);
+
+		for (i = 0; i < SYSEQ_NUM; ++i)
+			mc_packet_add_force_write_if(MCI_EDSP_FW_D, sys_eq1[i]);
+
+		mc_packet_execute();
+	}
+
+	mc_packet_add_force_write_if(MCI_EDSP_FW_PAGE, MCI_EDSP_FW_PAGE_DEF);
+	mc_packet_add_force_write_e(MCI_SYSEQ, enable);
+	mc_packet_execute();
+
+	return 0;
+}
+
+int edsp_e1_download_3band(u8 *sys_eq0, u8 *sys_eq1, u8 enable)
+{
+	u8 sys_eq0_modify = SYSEQ_NO_MODIFY, sys_eq1_modify = SYSEQ_NO_MODIFY;
+	u8 tmp;
+	bool sys_eq0_skip = false, sys_eq1_skip = false;
+	int i, j, k;
+
+	tmp = enable;
+	if (sys_eq0) {
+		sys_eq0_modify = mc_edsp_info.sys_eq0_modify;
+		for (i = 0, j = SYSEQ_NUM, k = SYSEQ_NUM * 2; i < SYSEQ_NUM;
+		     i++, j++, k++) {
+			if (mc_edsp_info.sys_eq0[i] != sys_eq0[i]) {
+				mc_edsp_info.sys_eq0[i] = sys_eq0[i];
+				sys_eq0_modify |= SYSEQ_MODIFY_0;
+			}
+
+			if (mc_edsp_info.sys_eq0[j] != sys_eq0[j]) {
+				mc_edsp_info.sys_eq0[j] = sys_eq0[j];
+				sys_eq0_modify |= SYSEQ_MODIFY_1;
+			}
+
+			if (mc_edsp_info.sys_eq0[k] != sys_eq0[k]) {
+				mc_edsp_info.sys_eq0[k] = sys_eq0[k];
+				sys_eq0_modify |= SYSEQ_MODIFY_2;
+			}
+		}
+
+		if (sys_eq0_modify != SYSEQ_NO_MODIFY) {
+			if (sys_eq0_modify & SYSEQ_MODIFY_0)
+				tmp &= ~MCB_SYSEQ_SYSEQ0_B0_ENB;
+			if (sys_eq0_modify & SYSEQ_MODIFY_1)
+				tmp &= ~MCB_SYSEQ_SYSEQ0_B1_ENB;
+			if (sys_eq0_modify & SYSEQ_MODIFY_2)
+				tmp &= ~MCB_SYSEQ_SYSEQ0_B2_ENB;
+		} else
+			sys_eq0_skip = true;
+		mc_edsp_info.sys_eq0_modify = SYSEQ_NO_MODIFY;
+	}
+
+	if (sys_eq1) {
+		sys_eq1_modify = mc_edsp_info.sys_eq1_modify;
+		for (i = 0, j = SYSEQ_NUM, k = SYSEQ_NUM * 2; i < SYSEQ_NUM;
+		     ++i, ++j, ++k) {
+			if (mc_edsp_info.sys_eq1[i] != sys_eq1[i]) {
+				mc_edsp_info.sys_eq1[i] = sys_eq1[i];
+				sys_eq1_modify |= SYSEQ_MODIFY_0;
+			}
+
+			if (mc_edsp_info.sys_eq1[j] != sys_eq1[j]) {
+				mc_edsp_info.sys_eq1[j] = sys_eq1[j];
+				sys_eq1_modify |= SYSEQ_MODIFY_1;
+			}
+
+			if (mc_edsp_info.sys_eq1[k] != sys_eq1[k]) {
+				mc_edsp_info.sys_eq1[k] = sys_eq1[k];
+				sys_eq1_modify |= SYSEQ_MODIFY_2;
+			}
+		}
+
+		if (sys_eq1_modify != SYSEQ_NO_MODIFY) {
+			if (sys_eq1_modify & SYSEQ_MODIFY_0)
+				tmp &= ~MCB_SYSEQ_SYSEQ1_B0_ENB;
+			if (sys_eq1_modify & SYSEQ_MODIFY_1)
+				tmp &= ~MCB_SYSEQ_SYSEQ1_B1_ENB;
+			if (sys_eq1_modify & SYSEQ_MODIFY_2)
+				tmp &= ~MCB_SYSEQ_SYSEQ1_B2_ENB;
+		} else
+			sys_eq1_skip = true;
+		mc_edsp_info.sys_eq1_modify = SYSEQ_NO_MODIFY;
+	}
+
+	if (sys_eq0_skip && sys_eq1_skip)
+		return 0;
+
+	mc_packet_add_force_write_e(MCI_SYSEQ, tmp);
+
+	if (!sys_eq0_skip) {
+		if (sys_eq0_modify & SYSEQ_MODIFY_0) {
+			mc_packet_add_force_write_if(MCI_EDSP_FW_PAGE,
+						MCB_EDSP_FW_PAGE_SYSEQ0_B0);
+			for (i = 0; i < SYSEQ_NUM; i++)
+				mc_packet_add_force_write_if(MCI_EDSP_FW_D,
+							     sys_eq0[i]);
+		}
+
+		if (sys_eq0_modify & SYSEQ_MODIFY_1) {
+			mc_packet_add_force_write_if(MCI_EDSP_FW_PAGE,
+						MCB_EDSP_FW_PAGE_SYSEQ0_B1);
+			for (i = SYSEQ_NUM; i < SYSEQ_NUM * 2; i++)
+				mc_packet_add_force_write_if(MCI_EDSP_FW_D,
+							     sys_eq0[i]);
+		}
+
+		if (sys_eq0_modify & SYSEQ_MODIFY_2) {
+			mc_packet_add_force_write_if(MCI_EDSP_FW_PAGE,
+						MCB_EDSP_FW_PAGE_SYSEQ0_B2);
+			for (i = SYSEQ_NUM * 2; i < SYSEQ_NUM * 3; i++)
+				mc_packet_add_force_write_if(MCI_EDSP_FW_D,
+							     sys_eq0[i]);
+		}
+
+		mc_packet_execute();
+	}
+
+	if (!sys_eq1_skip) {
+		if (sys_eq1_modify & SYSEQ_MODIFY_0) {
+			mc_packet_add_force_write_if(MCI_EDSP_FW_PAGE,
+						MCB_EDSP_FW_PAGE_SYSEQ1_B0);
+			for (i = 0; i < SYSEQ_NUM; i++)
+				mc_packet_add_force_write_if(MCI_EDSP_FW_D,
+							     sys_eq1[i]);
+		}
+
+		if (sys_eq1_modify & SYSEQ_MODIFY_1) {
+			mc_packet_add_force_write_if(MCI_EDSP_FW_PAGE,
+						MCB_EDSP_FW_PAGE_SYSEQ1_B1);
+			for (i = SYSEQ_NUM; i < SYSEQ_NUM * 2; i++)
+				mc_packet_add_force_write_if(MCI_EDSP_FW_D,
+							     sys_eq1[i]);
+		}
+
+		if (sys_eq1_modify & SYSEQ_MODIFY_2) {
+			mc_packet_add_force_write_if(MCI_EDSP_FW_PAGE,
+						MCB_EDSP_FW_PAGE_SYSEQ1_B2);
+			for (i = SYSEQ_NUM * 2; i < SYSEQ_NUM * 3; i++)
+				mc_packet_add_force_write_if(MCI_EDSP_FW_D,
+							     sys_eq1[i]);
+		}
+
+		mc_packet_execute();
+	}
+
+	mc_packet_add_force_write_if(MCI_EDSP_FW_PAGE, MCI_EDSP_FW_PAGE_DEF);
+	mc_packet_add_force_write_e(MCI_SYSEQ, enable);
+	mc_packet_execute();
+
+	return 0;
+}
+
+int mc_edsp_e1_download(u8 *sys_eq0, u8 *sys_eq1, u8 enable)
+{
+	u8 dev_id;
+
+	dev_id = mc_a_register_get_value(MCI_A_DEV_ID);
+	if (dev_id & 0x7)
+		return edsp_e1_download_3band(sys_eq0, sys_eq1, enable);
+
+	return edsp_e1_download_1band(sys_eq0, sys_eq1, enable);
+}
diff --git a/sound/soc/codecs/ymu831/mcedspdrv.h b/sound/soc/codecs/ymu831/mcedspdrv.h
new file mode 100644
index 0000000..60697ac
--- /dev/null
+++ b/sound/soc/codecs/ymu831/mcedspdrv.h
@@ -0,0 +1,45 @@
+/****************************************************************************
+ *
+ * Copyright(c) 2012 Yamaha Corporation. All rights reserved.
+ *
+ * Module	: mcedspdrv.h
+ * Description	: MC E-DSP driver header
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
+#ifndef	_MCEDSPDRV_H
+#define	_MCEDSPDRV_H
+
+#include "mcresctrl.h"
+
+int mc_edsp_init(void);
+void mc_edsp_term(void);
+void mc_edsp_irq(void);
+int mc_edsp_set_dsp(struct mcdrv_aec_info *aec);
+int mc_edsp_start(void);
+int mc_edsp_stop(void);
+int mc_edsp_e1_download(u8 *sys_eq0, u8 *sys_eq1, u8 enable);
+
+#endif /* _MCEDSPDRV_H */
-- 
1.7.9.5
