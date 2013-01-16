From: Yoichi Yuasa <yuasa@linux-mips.org>
Subject: [PATCH 10/19] ALSA: ymu831: add device control packet
 packing driver
Date: Wed, 16 Jan 2013 17:36:01 +0900
Message-ID: <20130116173601.ca908967875c14c1447ef0d1@linux-mips.org>
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
 sound/soc/codecs/ymu831/mcpacking.c | 4064 +++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ymu831/mcpacking.h |  217 ++
 3 files changed, 4283 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/codecs/ymu831/mcpacking.c
 create mode 100644 sound/soc/codecs/ymu831/mcpacking.h

diff --git a/sound/soc/codecs/ymu831/Makefile b/sound/soc/codecs/ymu831/Makefile
index c6809c0..01f5910 100644
--- a/sound/soc/codecs/ymu831/Makefile
+++ b/sound/soc/codecs/ymu831/Makefile
@@ -4,6 +4,7 @@ snd-soc-ymu831-objs := \
 	mcdevif.o	\
 	mcdriver.o	\
 	mcedspdrv.o	\
-	mcfdspdrv.o
+	mcfdspdrv.o	\
+	mcpacking.o
 
 obj-$(CONFIG_SND_SOC_YMU831) += snd-soc-ymu831.o
diff --git a/sound/soc/codecs/ymu831/mcpacking.c b/sound/soc/codecs/ymu831/mcpacking.c
new file mode 100644
index 0000000..4563afd
--- /dev/null
+++ b/sound/soc/codecs/ymu831/mcpacking.c
@@ -0,0 +1,4064 @@
+/****************************************************************************
+ *
+ * Copyright(c) 2012 Yamaha Corporation. All rights reserved.
+ *
+ * Module	: mcpacking.c
+ * Description	: MC device control packet packing driver
+ * Version	: 1.0.1 Dec 19 2012
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
+ * - some mc_packet_*() functions move from mcdevif.c
+ */
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include "mcbdspdrv.h"
+#include "mccdspdrv.h"
+#include "mcdefs.h"
+#include "mcdevif.h"
+#include "mcedspdrv.h"
+#include "mcfdspdrv.h"
+#include "mcpacking.h"
+#include "mcresctrl.h"
+
+#define	MCDRV_TCXO_WAIT_TIME		2000
+#define	MCDRV_PLL_WAIT_TIME		2000
+#define	MCDRV_LDO_WAIT_TIME		1000
+#define	MCDRV_VREF_WAIT_TIME_ES1	2000
+#define	MCDRV_OSC_WAIT_TIME		10
+#define	MCDRV_CP_WAIT_TIME		2000
+#define	MCDRV_WAIT_TIME_500US		500
+#define	MCDRV_WAIT_TIME_350US		350
+#define	MCDRV_OFC_WAIT_TIME		3000
+#define MCDRV_DP_DAC_WAIT_TIME		21
+
+#define	DTH				3
+#define	EN_CP_ILMT_N			1
+#define	HP_IDLE				0
+#define	HP_IBST				3
+#define	HP_MIDBST			1
+#define	OP_DAC_HP			0x40
+#define	OP_DAC				0x30
+#define	CP_88OFF			1
+#define	CD_39				0x21
+#define	T_CPMODE_OFFCAN_BEFORE		0
+#define	T_CPMODE_OFFCAN_AFTER		2
+#define E_99				0x9f
+#define E_100				0x01
+#define ANA_114				0x31
+#define ANA_115				0x8a
+
+enum dio_port {
+	DIO_0 = 0,
+	DIO_1,
+	DIO_2,
+	DIO_3
+};
+
+struct mc_packet {
+	u32 desc;
+	u8 data;
+};
+
+static struct mc_packet packet_queue[MCDRV_MAX_PACKETS + 1];
+static int packet_terminate;
+
+int mc_packet_init(void)
+{
+	struct mcdrv_dev_info info;
+	struct mcdrv_aec_info aec;
+	enum mcdrv_dev_id id;
+	u8 val;
+
+	mc_packet_add_force_write_cd(MCI_CD_RST, MCI_CD_RST_DEF);
+	mc_packet_add_force_write_cd(MCI_CD_RST, 0);
+
+	id = mc_dev_id_get();
+	mc_dev_info_get(&info);
+
+	if (id == MCDRV_DEV_ID_80_90H)
+		val = info.ppd_rc << 4 | info.ppd_hp << 3 |
+		    info.ppd_sp << 2 |
+		    info.ppd_line_out2 << 1 | info.ppd_line_out1;
+	else
+		val = info.ppd_sp << 2;
+
+	mc_packet_add_write_ana(MCI_PPD, val);
+
+	switch (id) {
+	case MCDRV_DEV_ID_81_91H:
+		val = info.options[12] << 4 | 0x06;
+		mc_packet_add_write_ana(10, val);
+		break;
+	case MCDRV_DEV_ID_81_92H:
+		val = info.options[12] << 4 | (info.options[13] & 0x0f);
+		mc_packet_add_write_ana(10, val);
+		break;
+	default:
+		break;
+	}
+
+	val = info.mb_sel4 << 6 | info.mb_sel3 << 4 |
+	    info.mb_sel2 << 2 | info.mb_sel1;
+	mc_packet_add_write_ana(MCI_MBSEL, val);
+	mc_packet_add_write_ana(MCI_KDSET, info.mbs_disch << 4);
+
+	if (id != MCDRV_DEV_ID_80_90H)
+		mc_packet_add_write_ana(15, info.options[11]);
+
+	val = info.nonclip << 7;
+	if (id == MCDRV_DEV_ID_80_90H)
+		val |= DTH;
+	else
+		val |= info.options[3];
+	mc_packet_add_write_ana(MCI_NONCLIP, val);
+
+	val = info.line_out2_dif << 5 | info.line_out1_dif << 4 |
+	    info.line_in1_dif;
+	mc_packet_add_write_ana(MCI_DIF, val);
+
+	val = info.svol_hp << 7 | info.svol_sp << 6
+	    | info.svol_rc << 5 | info.svol_line_out2 << 4
+	    | info.svol_line_out1 << 3 | MCB_SVOL_HPDET;
+	mc_packet_add_write_ana(MCI_SVOL, val);
+
+	val = info.hp_hiz << 6 | info.sp_hiz << 4 | info.rc_hiz << 3;
+	if (id != MCDRV_DEV_ID_80_90H)
+		val |= info.options[2];
+	mc_packet_add_force_write_ana(MCI_HIZ, val);
+
+	val = info.line_out2_hiz << 6 | info.line_out1_hiz << 4;
+	mc_packet_add_write_ana(MCI_LO_HIZ, val);
+
+	val = info.mic4_single << 7 | info.mic3_single << 6 |
+	    info.mic2_single << 5 | info.mic1_single << 4;
+	mc_packet_add_write_ana(MCI_MCSNG, val);
+
+	val = info.zc_hp << 7 | info.zc_sp << 6 |
+	    info.zc_rc << 5 | info.zc_line_out2 << 4 | info.zc_line_out1 << 3;
+	mc_packet_add_write_ana(MCI_ZCOFF, val);
+
+	val = info.cp_mod;
+	if (id == MCDRV_DEV_ID_80_90H)
+		val |= EN_CP_ILMT_N << 2;
+	else
+		val |= MCB_HIP_DISABLE;
+
+	mc_packet_add_write_ana(MCI_CPMOD, val);
+
+	mc_aec_info_get(&aec);
+
+	val = aec.output.dng_release << 4 | aec.output.dng_attack;
+	if (id == MCDRV_DEV_ID_80_90H) {
+		mc_packet_add_write_ana(MCI_DNG_ES1, val);
+		mc_packet_add_write_ana(MCI_DNG_HP_ES1,
+					aec.output.dng_target[0]);
+		val = info.rb_sel << 7;
+	} else {
+		mc_packet_add_write_ana(MCI_DNG, val);
+		mc_packet_add_write_ana(MCI_DNG_HP, aec.output.dng_target[0]);
+		val = 0;
+	}
+
+	mc_packet_add_write_ana(MCI_RBSEL, val);
+
+	if (id == MCDRV_DEV_ID_80_90H) {
+		mc_packet_add_write_cd(MCI_STDPLUGSEL, info.plug_sel << 7);
+		mc_packet_add_write_ana(18, 0x20);
+	} else {
+		mc_packet_add_write_ana(114, ANA_114);
+		mc_packet_add_write_ana(115, ANA_115);
+		mc_packet_add_write_cd(MCI_SCKMSKON_R, info.options[1]);
+		mc_packet_add_write_cd(39, info.options[6]);
+	}
+
+	mc_packet_add_hsdet();
+
+	return 0;
+}
+
+void mc_packet_clear(void)
+{
+	packet_queue[0].desc = MCDRV_PACKET_TYPE_TERMINATE;
+	packet_terminate = 0;
+}
+
+void mc_packet_add(u32 desc, u8 data)
+{
+	if (packet_terminate >= MCDRV_MAX_PACKETS)
+		mc_packet_execute();
+
+	packet_queue[packet_terminate].desc = desc;
+	packet_queue[packet_terminate++].data = data;
+	packet_queue[packet_terminate].desc = MCDRV_PACKET_TYPE_TERMINATE;
+}
+
+int mc_packet_execute(void)
+{
+	enum mcdrv_update_mode mode;
+	u32 desc, delay;
+	int index;
+	int ret = 0;
+
+	mc_resource_clear();
+
+	index = 0;
+	desc = packet_queue[index].desc;
+
+	while (desc != MCDRV_PACKET_TYPE_TERMINATE) {
+		mode = MCDRV_UPDATE_FORCE;
+
+		switch (desc & MCDRV_PACKET_TYPE_MASK) {
+		case MCDRV_PACKET_TYPE_WRITE:
+			mode = MCDRV_UPDATE_NORMAL;
+		case MCDRV_PACKET_TYPE_FORCE_WRITE:
+			mc_bus_queue_add(desc & MCDRV_PACKET_REGTYPE_MASK,
+					 desc & MCDRV_PACKET_ADR_MASK,
+					 packet_queue[index].data, mode);
+			break;
+		case MCDRV_PACKET_TYPE_TIMWAIT:
+			mc_bus_queue_flush();
+			mc_resource_clear();
+
+			delay = desc & MCDRV_PACKET_TIME_MASK;
+			if (delay < 1000)
+				udelay(delay);
+			else
+				msleep(delay / 1000);
+			break;
+		case MCDRV_PACKET_TYPE_EVTWAIT:
+			mc_bus_queue_flush();
+			mc_resource_clear();
+			ret = mc_wait_event(desc & MCDRV_PACKET_EVT_MASK,
+					    desc & MCDRV_PACKET_EVTPRM_MASK);
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+
+		if (ret)
+			break;
+
+		desc = packet_queue[++index].desc;
+	}
+
+	if (!ret)
+		mc_bus_queue_flush();
+
+	mc_packet_clear();
+
+	return ret;
+}
+
+static inline void digital_io_init(void)
+{
+	struct mcdrv_dev_info info;
+	struct mcdrv_aec_info aec;
+	u8 val;
+
+	mc_dev_info_get(&info);
+	mc_aec_info_get(&aec);
+
+	/* DIO0 */
+	if (info.power_mode == MCDRV_POWMODE_CDSPDEBUG
+	    || aec.vbox.cdsp_jtag_on == 1)
+		val = 0x01;
+	else {
+		val = MCI_DO0_DRV_DEF;
+		if (!info.dio0_sdo_hiz)
+			val |= MCB_SDO0_DDR;
+		if (!info.dio0_clk_hiz)
+			val |= MCB_BCLK0_DDR | MCB_LRCK0_DDR;
+	}
+	mc_packet_add_write_a(MCI_DO0_DRV, val);
+
+	/* DIO1 */
+	if (info.power_mode == MCDRV_POWMODE_CDSPDEBUG
+	    || aec.vbox.cdsp_jtag_on == 1)
+		val = 0x22;
+	else {
+		val = MCI_DO1_DRV_DEF;
+		if (!info.dio1_sdo_hiz)
+			val |= MCB_SDO1_DDR;
+		if (!info.dio1_clk_hiz)
+			val |= MCB_BCLK1_DDR | MCB_LRCK1_DDR;
+	}
+	mc_packet_add_write_a(MCI_DO1_DRV, val);
+
+	/* DIO2 */
+	val = MCI_DO2_DRV_DEF;
+	if (!info.dio2_sdo_hiz)
+		val |= MCB_SDO2_DDR;
+	if (!info.dio2_clk_hiz)
+		val |= MCB_BCLK2_DDR | MCB_LRCK2_DDR;
+	mc_packet_add_write_a(MCI_DO2_DRV, val);
+
+	val = aec.pdm.pdm1_data_delay << 5;
+	val |= aec.pdm.pdm0_data_delay << 4;
+	if (info.dio0_pcm_hiz)
+		val |= MCB_PCMOUT0_HIZ;
+	if (info.dio1_pcm_hiz)
+		val |= MCB_PCMOUT1_HIZ;
+	if (info.dio2_pcm_hiz)
+		val |= MCB_PCMOUT2_HIZ;
+	mc_packet_add_write_a(MCI_PCMOUT_HIZ, val);
+}
+
+static inline void gpio_init(void)
+{
+	struct mcdrv_dev_info info;
+	struct mcdrv_gp_mode gp_mode;
+	u8 val;
+
+	mc_dev_info_get(&info);
+	mc_gp_mode_get(&gp_mode);
+
+	val = MCI_PA0_DEF;
+	if (info.pa0_func == MCDRV_PA_PDMCK)
+		val |= MCB_PA0_OUT | MCB_PA0_DDR;
+	else if (info.pa0_func == MCDRV_PA_GPIO) {
+		if (gp_mode.gp_ddr[MCDRV_GP_PAD0] == MCDRV_GPDDR_IN)
+			val &= ~MCB_PA0_DDR;
+		else
+			val |= MCB_PA0_DDR;
+		if (gp_mode.gp_host[MCDRV_GP_PAD0] == MCDRV_GPHOST_CPU)
+			val &= ~MCB_PA0_OUTSEL;
+		else
+			val |= MCB_PA0_OUTSEL;
+		if (gp_mode.gp_invert[MCDRV_GP_PAD0] == MCDRV_GPINV_NORMAL)
+			val &= ~MCB_PA0_INV;
+		else
+			val |= MCB_PA0_INV;
+	}
+	if (info.pa0_func == MCDRV_PA_GPIO
+	    && gp_mode.gp_ddr[MCDRV_GP_PAD0] == MCDRV_GPDDR_OUT
+	    && gp_mode.gp_host[MCDRV_GP_PAD0] == MCDRV_GPHOST_CPU)
+		val |= mc_gp_pad_get(MCDRV_GP_PAD0) << 4;
+	mc_packet_add_write_a(MCI_PA0, val);
+
+	val = mc_a_register_get_value(MCI_PA1);
+	if (info.pa1_func == MCDRV_PA_GPIO) {
+		if (gp_mode.gp_ddr[MCDRV_GP_PAD1] == MCDRV_GPDDR_IN)
+			val &= ~MCB_PA1_DDR;
+		else
+			val |= MCB_PA1_DDR;
+		if (gp_mode.gp_host[MCDRV_GP_PAD1] == MCDRV_GPHOST_CPU)
+			val &= ~MCB_PA1_OUTSEL;
+		else
+			val |= MCB_PA1_OUTSEL;
+		if (gp_mode.gp_invert[MCDRV_GP_PAD1] == MCDRV_GPINV_NORMAL)
+			val &= ~MCB_PA1_INV;
+		else
+			val |= MCB_PA1_INV;
+	}
+	val |= MCB_PA1_MSK;
+	if (info.pa1_func == MCDRV_PA_GPIO
+	    && gp_mode.gp_ddr[MCDRV_GP_PAD1] == MCDRV_GPDDR_OUT
+	    && gp_mode.gp_host[MCDRV_GP_PAD1] == MCDRV_GPHOST_CPU)
+		val |= mc_gp_pad_get(MCDRV_GP_PAD1) << 4;
+	mc_packet_add_write_a(MCI_PA1, val);
+
+	val = mc_a_register_get_value(MCI_PA2);
+	if (info.pa2_func == MCDRV_PA_GPIO) {
+		if (gp_mode.gp_ddr[MCDRV_GP_PAD2] == MCDRV_GPDDR_IN)
+			val &= ~MCB_PA2_DDR;
+		else
+			val |= MCB_PA2_DDR;
+		if (gp_mode.gp_host[MCDRV_GP_PAD2] == MCDRV_GPHOST_CPU)
+			val &= ~MCB_PA2_OUTSEL;
+		else
+			val |= MCB_PA2_OUTSEL;
+		if (gp_mode.gp_invert[MCDRV_GP_PAD2] == MCDRV_GPINV_NORMAL)
+			val &= ~MCB_PA2_INV;
+		else
+			val |= MCB_PA2_INV;
+	}
+	val |= MCB_PA2_MSK;
+	if (info.pa2_func == MCDRV_PA_GPIO
+	    && gp_mode.gp_ddr[MCDRV_GP_PAD2] == MCDRV_GPDDR_OUT
+	    && gp_mode.gp_host[MCDRV_GP_PAD2] == MCDRV_GPHOST_CPU)
+		val |= mc_gp_pad_get(MCDRV_GP_PAD2) << 4;
+	mc_packet_add_write_a(MCI_PA2, val);
+}
+
+static inline int mblock_init(void)
+{
+	u32 flags;
+	int ret;
+
+	if (mc_dev_id_get() != MCDRV_DEV_ID_80_90H)
+		mc_packet_add_write_ma(MCI_CLK_SEL, mc_clock_select_get());
+
+	mc_packet_add_digital_io(MCDRV_ALL_DIO_UPDATE_FLAG);
+
+	ret = mc_packet_execute();
+	if (ret < 0)
+		return ret;
+
+	mc_packet_add_write_a(MCI_LP0_FP, MCDRV_PHYSPORT_NONE);
+	mc_packet_add_write_a(MCI_LP1_FP, MCDRV_PHYSPORT_NONE);
+	mc_packet_add_write_a(MCI_LP2_FP, MCDRV_PHYSPORT_NONE);
+	mc_packet_add_write_a(MCI_LP0_FP, MCDRV_PHYSPORT_NONE);
+	mc_packet_add_digital_io_path();
+	ret = mc_packet_execute();
+	if (ret < 0)
+		return ret;
+
+	flags = MCDRV_SWAP_ALL_UPDATE_FLAG & ~MCDRV_SWAP_HIFIOUT_UPDATE_FLAG;
+	mc_packet_add_swap(flags);
+	return mc_packet_execute();
+}
+
+static void e_registers_setup(void)
+{
+	struct mcdrv_aec_info aec;
+	struct mcdrv_dev_info info;
+	enum mcdrv_dev_id id;
+	u8 val, val1, val2;
+	u8 sys_eq[2][45];
+	int i;
+
+	mc_dev_info_get(&info);
+
+	val = mc_if_register_get_value(MCI_RST);
+	if (val & (MCB_PSW_M | MCB_RST_M))
+		return;
+
+	val = mc_a_register_get_value(MCI_PD);
+	if (val & MCB_PE_CLK_PD)
+		return;
+
+	mc_aec_info_get(&aec);
+
+	id = mc_dev_id_get();
+	if (id != MCDRV_DEV_ID_80_90H)
+		mc_packet_add_write_e(MCI_ECLK_SEL, mc_e_clock_select_get());
+
+	val = mc_e_register_get_value(MCI_LPF_THR);
+	val &= (MCB_OSF1_MN | MCB_OSF0_MN | MCB_OSF1_ENB | MCB_OSF0_ENB);
+	val |= aec.output.lpf_post_thru[1] << 7
+	    | aec.output.lpf_post_thru[0] << 6
+	    | aec.output.lpf_pre_thru[1] << 5 | aec.output.lpf_pre_thru[0] << 4;
+	mc_packet_add_write_e(MCI_LPF_THR, val);
+
+	val = aec.output.dcc_sel[1] << 2 | aec.output.dcc_sel[0];
+	mc_packet_add_write_e(MCI_DAC_DCC_SEL, val);
+
+	val = aec.output.power_detect_level[1] << 6
+	    | aec.output.power_detect_level[0] << 4
+	    | aec.output.signal_detect_level;
+	mc_packet_add_write_e(MCI_DET_LVL, val);
+
+	val = aec.output.osf_sel[1] << 2 | aec.output.osf_sel[0];
+	mc_packet_add_write_e(MCI_OSF_SEL, val);
+
+	for (i = 0; i < MCDRV_AEC_OUTPUT_N; i++) {
+		memcpy(&sys_eq[i][0], aec.output.syseq_coef_a0[i], 3);
+		memcpy(&sys_eq[i][3], aec.output.syseq_coef_a1[i], 3);
+		memcpy(&sys_eq[i][6], aec.output.syseq_coef_a2[i], 3);
+		memcpy(&sys_eq[i][9], aec.output.syseq_coef_b1[i], 3);
+		memcpy(&sys_eq[i][12], aec.output.syseq_coef_b2[i], 3);
+		memcpy(aec.output.syseq_ex[i].band[0].coef_a0, &sys_eq[i][15],
+		       3);
+		memcpy(aec.output.syseq_ex[i].band[0].coef_a1, &sys_eq[i][18],
+		       3);
+		memcpy(aec.output.syseq_ex[i].band[0].coef_a2, &sys_eq[i][21],
+		       3);
+		memcpy(aec.output.syseq_ex[i].band[0].coef_b1, &sys_eq[i][24],
+		       3);
+		memcpy(aec.output.syseq_ex[i].band[0].coef_b2, &sys_eq[i][27],
+		       3);
+		memcpy(aec.output.syseq_ex[i].band[1].coef_a0, &sys_eq[i][30],
+		       3);
+		memcpy(aec.output.syseq_ex[i].band[1].coef_a1, &sys_eq[i][33],
+		       3);
+		memcpy(aec.output.syseq_ex[i].band[1].coef_a2, &sys_eq[i][36],
+		       3);
+		memcpy(aec.output.syseq_ex[i].band[1].coef_b1, &sys_eq[i][39],
+		       3);
+		memcpy(aec.output.syseq_ex[i].band[1].coef_b2, &sys_eq[i][42],
+		       3);
+	}
+
+	if (id == MCDRV_DEV_ID_80_90H)
+		val = aec.output.syseq_enb[1] << 1;
+	else
+		val = aec.output.syseq_enb[1] << 4;
+	val |= aec.output.syseq_enb[0];
+	mc_edsp_e1_download(sys_eq[0], sys_eq[1], val);
+	mc_packet_add_write_e(MCI_SYSEQ, val);
+
+	val = mc_ana_register_get_value(MCI_NONCLIP);
+	if (aec.output.clip_md[1] & 0x6)
+		val |= 1 << 7;
+	else
+		val &= 0x7f;
+	mc_packet_add_write_ana(MCI_NONCLIP, val);
+	mc_packet_add_write_e(MCI_CLIP_MD, aec.output.clip_md[1]);
+	mc_packet_add_write_e(MCI_CLIP_ATT, aec.output.clip_att[1]);
+	mc_packet_add_write_e(MCI_CLIP_REL, aec.output.clip_rel[1]);
+	mc_packet_add_write_e(MCI_CLIP_G, aec.output.clip_g[1]);
+
+	val1 = mc_e_register_get_value(MCI_OSF_GAIN0_15_8);
+	val2 = mc_e_register_get_value(MCI_OSF_GAIN0_7_0);
+	if (val1 != aec.output.osf_gain[0][0] ||
+	    val2 != aec.output.osf_gain[0][1]) {
+		mc_packet_add_force_write_e(MCI_OSF_GAIN0_15_8,
+					    aec.output.osf_gain[0][0]);
+		mc_packet_add_force_write_e(MCI_OSF_GAIN0_7_0,
+					    aec.output.osf_gain[0][1]);
+	}
+
+	val1 = mc_e_register_get_value(MCI_OSF_GAIN1_15_8);
+	val2 = mc_e_register_get_value(MCI_OSF_GAIN1_7_0);
+	if (val1 != aec.output.osf_gain[1][0] ||
+	    val2 != aec.output.osf_gain[1][1]) {
+		mc_packet_add_force_write_e(MCI_OSF_GAIN1_15_8,
+					    aec.output.osf_gain[1][0]);
+		mc_packet_add_force_write_e(MCI_OSF_GAIN1_7_0,
+					    aec.output.osf_gain[1][1]);
+	}
+
+	val = aec.output.dcl_on[1] << 7 | aec.output.dcl_gain[1] << 4
+	    | aec.output.dcl_on[0] << 3 | aec.output.dcl_gain[0];
+	mc_packet_add_write_e(MCI_DCL_GAIN, val);
+
+	val1 = mc_e_register_get_value(MCI_DCL0_LMT_14_8);
+	val2 = mc_e_register_get_value(MCI_DCL0_LMT_7_0);
+	if (val1 != aec.output.dcl_limit[0][0] ||
+	    val2 != aec.output.dcl_limit[0][1]) {
+		mc_packet_add_force_write_e(MCI_DCL0_LMT_14_8,
+					    aec.output.dcl_limit[0][0]);
+		mc_packet_add_force_write_e(MCI_DCL0_LMT_7_0,
+					    aec.output.dcl_limit[0][1]);
+	}
+
+	val1 = mc_e_register_get_value(MCI_DCL0_LMT_14_8);
+	val2 = mc_e_register_get_value(MCI_DCL0_LMT_7_0);
+	if (val1 != aec.output.dcl_limit[1][0] ||
+	    val2 != aec.output.dcl_limit[1][1]) {
+		mc_packet_add_force_write_e(MCI_DCL1_LMT_14_8,
+					    aec.output.dcl_limit[1][0]);
+		mc_packet_add_force_write_e(MCI_DCL1_LMT_7_0,
+					    aec.output.dcl_limit[1][1]);
+	}
+
+	if (id == MCDRV_DEV_ID_80_90H) {
+		val = aec.output.dc_dither_level[0] << 4
+		    | aec.output.random_dither_on[0] << 3
+		    | aec.output.random_dither_pos[0] << 2
+		    | aec.output.random_dither_level[0];
+		mc_packet_add_write_e(MCI_DITHER0, val);
+
+		val = aec.output.dc_dither_level[1] << 4
+		    | aec.output.random_dither_on[1] << 3
+		    | aec.output.random_dither_pos[1] << 2
+		    | aec.output.random_dither_level[1];
+		mc_packet_add_write_e(MCI_DITHER1, val);
+	} else {
+		mc_packet_add_write_e(MCI_DITHER0, info.options[4]);
+		mc_packet_add_write_e(MCI_DITHER1, info.options[5]);
+	}
+
+	val = aec.output.dng_fw[0] << 7 | aec.output.dng_time[0] << 5
+	    | aec.output.dng_zero[0];
+	val1 = aec.output.dng_fw[1] << 7 | aec.output.dng_time[1] << 5
+	    | aec.output.dng_zero[1];
+	val2 = aec.output.dng_on[1] << 1 | aec.output.dng_on[0];
+	if (id == MCDRV_DEV_ID_80_90H) {
+		mc_packet_add_write_e(MCI_DNG0_ES1, val);
+		mc_packet_add_write_e(MCI_DNG1_ES1, val1);
+		mc_packet_add_write_e(MCI_DNG_ON_ES1, val2);
+	} else {
+		mc_packet_add_write_e(MCI_DNG0, val);
+		mc_packet_add_write_e(MCI_DNG1, val1);
+		mc_packet_add_write_e(MCI_DNG_ON, val2);
+	}
+
+	mc_packet_add_write_e(MCI_ADJ_HOLD, aec.adj.hold);
+	mc_packet_add_write_e(MCI_ADJ_CNT, aec.adj.cnt);
+
+	val1 = mc_e_register_get_value(MCI_ADJ_MAX_15_8);
+	val2 = mc_e_register_get_value(MCI_ADJ_MAX_7_0);
+	if (val1 != aec.adj.max[0] || val2 != aec.adj.max[1]) {
+		mc_packet_add_force_write_e(MCI_ADJ_MAX_15_8, aec.adj.max[0]);
+		mc_packet_add_force_write_e(MCI_ADJ_MAX_7_0, aec.adj.max[1]);
+	}
+
+	val = aec.output.dither_type[1] << 5 | aec.output.dither_type[0] << 4;
+	mc_packet_add_write_e(40, val);
+
+	val = mc_e_register_get_value(MCI_DSF0_FLT_TYPE);
+	val &= MCB_DSF0_MN | MCB_DSF0ENB;
+	val |= aec.input.dsf32_r_type[0] << 6 | aec.input.dsf32_l_type[0] << 4;
+	mc_packet_add_write_e(MCI_DSF0_FLT_TYPE, val);
+
+	val = mc_e_register_get_value(MCI_DSF1_FLT_TYPE);
+	val &= MCB_DSF1_MN | MCB_DSF1ENB;
+	val |= aec.input.dsf32_r_type[1] << 6 | aec.input.dsf32_l_type[1] << 4;
+	mc_packet_add_write_e(MCI_DSF1_FLT_TYPE, val);
+
+	val = mc_e_register_get_value(MCI_DSF2_FLT_TYPE);
+	val &= MCB_DSF2REFSEL | MCB_DSF2REFBACK | MCB_DSF2_MN | MCB_DSF2ENB;
+	val |= aec.input.dsf32_r_type[2] << 6 | aec.input.dsf32_l_type[2] << 4;
+	mc_packet_add_write_e(MCI_DSF2_FLT_TYPE, val);
+
+	val = aec.input.dsf4_sel[2] << 2 | aec.input.dsf4_sel[1] << 1
+	    | aec.input.dsf4_sel[0];
+	mc_packet_add_write_e(MCI_DSF_SEL, val);
+
+	val = aec.input.dcc_sel[2] << 4 | aec.input.dcc_sel[1] << 2
+	    | aec.input.dcc_sel[0];
+	mc_packet_add_write_e(MCI_ADC_DCC_SEL, val);
+
+	val = aec.input.dng_on[2] << 2 | aec.input.dng_on[1] << 1
+	    | aec.input.dng_on[0];
+	mc_packet_add_write_e(MCI_ADC_DNG_ON, val);
+
+	val = aec.input.dng_fw[0] << 4 | aec.input.dng_rel[0] << 2
+	    | aec.input.dng_att[0];
+	mc_packet_add_write_e(MCI_ADC_DNG0_FW, val);
+	mc_packet_add_write_e(MCI_ADC_DNG0_TIM, aec.input.dng_time[0]);
+
+	val1 = mc_e_register_get_value(MCI_ADC_DNG0_ZERO_15_8);
+	val2 = mc_e_register_get_value(MCI_ADC_DNG0_ZERO_7_0);
+	if (val1 != aec.input.dng_zero[0][0] ||
+	    val2 != aec.input.dng_zero[0][1]) {
+		mc_packet_add_force_write_e(MCI_ADC_DNG0_ZERO_15_8,
+					    aec.input.dng_zero[0][0]);
+		mc_packet_add_force_write_e(MCI_ADC_DNG0_ZERO_7_0,
+					    aec.input.dng_zero[0][1]);
+	}
+
+	val1 = mc_e_register_get_value(MCI_ADC_DNG0_ZERO_15_8);
+	val2 = mc_e_register_get_value(MCI_ADC_DNG0_ZERO_7_0);
+	if (val1 != aec.input.dng_target[0][0] ||
+	    val2 != aec.input.dng_target[0][1]) {
+		mc_packet_add_force_write_e(MCI_ADC_DNG0_TGT_15_8,
+					    aec.input.dng_target[0][0]);
+		mc_packet_add_force_write_e(MCI_ADC_DNG0_TGT_7_0,
+					    aec.input.dng_target[0][1]);
+	}
+
+	val = aec.input.dng_fw[1] << 4 | aec.input.dng_rel[1] << 2
+	    | aec.input.dng_att[1];
+	mc_packet_add_write_e(MCI_ADC_DNG1_FW, val);
+	mc_packet_add_write_e(MCI_ADC_DNG1_TIM, aec.input.dng_time[1]);
+
+	val1 = mc_e_register_get_value(MCI_ADC_DNG1_ZERO_15_8);
+	val2 = mc_e_register_get_value(MCI_ADC_DNG1_ZERO_7_0);
+	if (val1 != aec.input.dng_zero[1][0] ||
+	    val2 != aec.input.dng_zero[1][1]) {
+		mc_packet_add_force_write_e(MCI_ADC_DNG1_ZERO_15_8,
+					    aec.input.dng_zero[1][0]);
+		mc_packet_add_force_write_e(MCI_ADC_DNG1_ZERO_7_0,
+					    aec.input.dng_zero[1][1]);
+	}
+
+	val1 = mc_e_register_get_value(MCI_ADC_DNG1_ZERO_15_8);
+	val2 = mc_e_register_get_value(MCI_ADC_DNG1_ZERO_7_0);
+	if (val1 != aec.input.dng_target[1][0] ||
+	    val2 != aec.input.dng_target[1][1]) {
+		mc_packet_add_force_write_e(MCI_ADC_DNG1_TGT_15_8,
+					    aec.input.dng_target[1][0]);
+		mc_packet_add_force_write_e(MCI_ADC_DNG1_TGT_7_0,
+					    aec.input.dng_target[1][1]);
+	}
+
+	val = aec.input.dng_fw[2] << 4 | aec.input.dng_rel[2] << 2
+	    | aec.input.dng_att[2];
+	mc_packet_add_write_e(MCI_ADC_DNG2_FW, val);
+	mc_packet_add_write_e(MCI_ADC_DNG2_TIM, aec.input.dng_time[2]);
+
+	val1 = mc_e_register_get_value(MCI_ADC_DNG2_ZERO_15_8);
+	val2 = mc_e_register_get_value(MCI_ADC_DNG2_ZERO_7_0);
+	if (val1 != aec.input.dng_zero[2][0] ||
+	    val2 != aec.input.dng_zero[2][1]) {
+
+		mc_packet_add_force_write_e(MCI_ADC_DNG2_ZERO_15_8,
+					    aec.input.dng_zero[2][0]);
+		mc_packet_add_force_write_e(MCI_ADC_DNG2_ZERO_7_0,
+					    aec.input.dng_zero[2][1]);
+	}
+
+	val1 = mc_e_register_get_value(MCI_ADC_DNG2_TGT_15_8);
+	val2 = mc_e_register_get_value(MCI_ADC_DNG2_TGT_7_0);
+	if (val1 != aec.input.dng_target[2][0] ||
+	    val2 != aec.input.dng_target[2][1]) {
+		mc_packet_add_force_write_e(MCI_ADC_DNG2_TGT_15_8,
+					    aec.input.dng_target[2][0]);
+		mc_packet_add_force_write_e(MCI_ADC_DNG2_TGT_7_0,
+					    aec.input.dng_target[2][1]);
+	}
+
+	val = aec.input.depop_wait[0] << 2 | aec.input.depop_att[0];
+	mc_packet_add_write_e(MCI_DEPOP0, val);
+
+	val = aec.input.depop_wait[1] << 2 | aec.input.depop_att[1];
+	mc_packet_add_write_e(MCI_DEPOP1, val);
+
+	val = aec.input.depop_wait[2] << 2 | aec.input.depop_att[2];
+	mc_packet_add_write_e(MCI_DEPOP2, val);
+
+	val = aec.pdm.st_wait << 2 | aec.pdm.mode;
+	mc_packet_add_write_e(MCI_PDM_MODE, val);
+
+	val = mc_e_register_get_value(MCI_PDM_LOAD_TIM);
+	val &= MCB_PDM1_START | MCB_PDM0_START;
+	val |= aec.pdm.pdm1_loadtime << 4 | aec.pdm.pdm0_loadtime;
+	mc_packet_add_write_e(MCI_PDM_LOAD_TIM, val);
+	mc_packet_add_write_e(MCI_PDM0L_FINE_DLY, aec.pdm.pdm0_l_finedelay);
+	mc_packet_add_write_e(MCI_PDM0R_FINE_DLY, aec.pdm.pdm0_r_finedelay);
+	mc_packet_add_write_e(MCI_PDM1L_FINE_DLY, aec.pdm.pdm1_l_finedelay);
+	mc_packet_add_write_e(MCI_PDM1R_FINE_DLY, aec.pdm.pdm1_r_finedelay);
+
+	val = aec.edsp_misc.ch_sel << 6 | aec.edsp_misc.i2s_out_enable << 5
+	    | aec.edsp_misc.loopback;
+	mc_packet_add_write_e(MCI_CH_SEL, val);
+
+	val = aec.e2.da_sel << 3 | aec.e2.ad_sel;
+	mc_packet_add_write_e(MCI_E2_SEL, val);
+
+	if (id != MCDRV_DEV_ID_80_90H) {
+		mc_packet_add_write_e(99, E_99);
+		mc_packet_add_write_e(100, E_100);
+	}
+}
+
+static int offset_cancel(void)
+{
+	struct mcdrv_aec_info aec;
+	struct mcdrv_dev_info info;
+	enum mcdrv_dev_id id;
+	u8 val, val1, val2, e_irq_hs;
+	u8 data[2];
+	int ret = 0;
+
+	id = mc_dev_id_get();
+	mc_dev_info_get(&info);
+	mc_aec_info_get(&aec);
+
+	mc_packet_add_force_write_e(MCI_E1DSP_CTRL, 0);
+	ret = mc_packet_execute();
+	if (ret < 0)
+		return ret;
+
+	mc_packet_add_force_write_e(MCI_LPF_THR,
+				    MCI_LPF_THR_DEF | MCB_OSF1_ENB |
+				    MCB_OSF0_ENB);
+
+	mc_packet_add_wait(MCDRV_DP_DAC_WAIT_TIME);
+
+	mc_packet_add_write_cd(MCI_DP, 0);
+	mc_packet_add_force_write_e(MCI_DSF0_FLT_TYPE, MCB_DSF0ENB);
+
+	e_irq_hs = mc_cd_register_get_value(MCI_IRQHS);
+	mc_packet_add_write_cd(MCI_IRQHS, 0);
+
+	if (id == MCDRV_DEV_ID_80_90H) {
+		val = aec.output.dc_dither_level[0] << 4
+		    | aec.output.random_dither_on[0] << 3
+		    | aec.output.random_dither_pos[0] << 2
+		    | aec.output.random_dither_level[0];
+		mc_packet_add_write_e(MCI_DITHER0, val);
+
+		val = aec.output.dc_dither_level[1] << 4
+		    | aec.output.random_dither_on[1] << 3
+		    | aec.output.random_dither_pos[1] << 2
+		    | aec.output.random_dither_level[1];
+		mc_packet_add_write_e(MCI_DITHER1, val);
+	}
+
+	val = aec.output.dither_type[1] << 5 | aec.output.dither_type[0] << 4;
+	mc_packet_add_write_e(40, val);
+
+	mc_packet_add_write_e(MCI_ADJ_HOLD, aec.adj.hold);
+	mc_packet_add_write_e(MCI_ADJ_CNT, aec.adj.cnt);
+
+	val1 = mc_e_register_get_value(MCI_ADJ_MAX_15_8);
+	val2 = mc_e_register_get_value(MCI_ADJ_MAX_7_0);
+	if (val1 != aec.adj.max[0] || val2 != aec.adj.max[1]) {
+		mc_packet_add_force_write_e(MCI_ADJ_MAX_15_8, aec.adj.max[0]);
+		mc_packet_add_force_write_e(MCI_ADJ_MAX_7_0, aec.adj.max[1]);
+	}
+
+	if (id == MCDRV_DEV_ID_80_90H) {
+		mc_packet_add_write_ana(22, CP_88OFF << 1);
+
+		if (mc_source_is_used(MCDRV_DST_HP, MCDRV_DST_CH0)
+		    || mc_source_is_used(MCDRV_DST_HP, MCDRV_DST_CH1))
+			mc_packet_add_write_ana(19, OP_DAC_HP);
+		else
+			mc_packet_add_write_ana(19, OP_DAC);
+
+		mc_packet_add_write_ana(17, (HP_IBST << 1) | HP_MIDBST);
+		mc_packet_add_force_write_ana(15, HP_IDLE << 5);
+		mc_packet_add_write_cd(39, CD_39);
+
+		mc_packet_add_force_write_if(31, 0xb5);
+		mc_packet_add_force_write_if(30, 0xd6);
+		mc_packet_add_force_write_ana(78, T_CPMODE_OFFCAN_BEFORE);
+	} else {
+		mc_packet_add_write_ana(22, CP_88OFF << 1);
+		mc_packet_add_write_ana(19, info.options[7]);
+		mc_packet_add_write_ana(62, info.options[8]);
+	}
+
+	mc_packet_add_force_write_e(MCI_E1COMMAND, E1COMMAND_OFFSET_CANCEL);
+	ret = mc_packet_execute();
+	if (ret < 0)
+		return ret;
+
+	if (id == MCDRV_DEV_ID_80_90H) {
+		data[0] = MCI_ANA_REG_A << 1;
+		data[1] = 78;
+		mc_write_analog(data, 2);
+		mc_read_analog(MCI_ANA_REG_D, &val, 1);
+		if (val != T_CPMODE_OFFCAN_BEFORE)
+			return -EIO;
+	}
+
+	mc_packet_add_wait_event(MCDRV_EVT_OFFCAN_BSY_RESET);
+	mc_packet_add_force_write_cd(MCI_SSENSEFIN, MCB_SOFFCANFIN);
+
+	mc_packet_add_force_write_e(MCI_DSF0_FLT_TYPE, 0);
+	mc_packet_add_write_cd(MCI_IRQHS, e_irq_hs);
+
+	if (id == MCDRV_DEV_ID_80_90H)
+		mc_packet_add_force_write_ana(78, T_CPMODE_OFFCAN_AFTER);
+
+	ret = mc_packet_execute();
+	if (ret < 0)
+		return ret;
+
+	if (id == MCDRV_DEV_ID_80_90H) {
+		data[0] = MCI_ANA_REG_A << 1;
+		data[1] = 78;
+		mc_write_analog(data, 2);
+		mc_read_analog(MCI_ANA_REG_D, &val, 1);
+		if (val != T_CPMODE_OFFCAN_AFTER)
+			ret = -EIO;
+	}
+
+	return ret;
+}
+
+static inline void add_dac_start(void)
+{
+	u8 val, osf0 = 0, osf1 = 0;
+
+	val = mc_e_register_get_value(MCI_LPF_THR);
+	osf0 = val & (MCB_OSF0_MN | MCB_OSF0_ENB);
+	if (mc_source_is_used(MCDRV_DST_DAC0, MCDRV_DST_CH0))
+		osf0 = MCB_OSF0_ENB | MCB_OSF0_MN;
+	if (mc_source_is_used(MCDRV_DST_DAC0, MCDRV_DST_CH1))
+		osf0 = MCB_OSF0_ENB;
+
+	osf1 = val & (MCB_OSF1_MN | MCB_OSF1_ENB);
+	if (mc_source_is_used(MCDRV_DST_DAC1, MCDRV_DST_CH0))
+		osf1 = MCB_OSF1_ENB | MCB_OSF1_MN;
+	if (mc_source_is_used(MCDRV_DST_DAC1, MCDRV_DST_CH1))
+		osf1 = MCB_OSF1_ENB;
+
+	val &= MCB_LPF_ALL_THR;
+	val |= osf1 | osf0;
+	mc_packet_add_write_e(MCI_LPF_THR, val);
+}
+
+static inline u32 get_max_wait(u8 reg_change)
+{
+	struct mcdrv_dev_info info;
+	u32 wait_time_max = 0;
+
+	mc_dev_info_get(&info);
+
+	if ((reg_change & MCB_MC1) || (reg_change & MCB_MB1))
+		if (info.wait_time.wait[0] > wait_time_max)
+			wait_time_max = info.wait_time.wait[0];
+
+	if ((reg_change & MCB_MC2) || (reg_change & MCB_MB2))
+		if (info.wait_time.wait[1] > wait_time_max)
+			wait_time_max = info.wait_time.wait[1];
+
+	if ((reg_change & MCB_MC3) || (reg_change & MCB_MB3))
+		if (info.wait_time.wait[2] > wait_time_max)
+			wait_time_max = info.wait_time.wait[2];
+
+	if ((reg_change & MCB_MC4) || (reg_change & MCB_MB4))
+		if (info.wait_time.wait[3] > wait_time_max)
+			wait_time_max = info.wait_time.wait[3];
+
+	return wait_time_max;
+}
+
+int mc_packet_add_powerup(struct mcdrv_power_info *power_info,
+			  struct mcdrv_power_update *power_update)
+{
+	struct mcdrv_aec_info aec;
+	struct mcdrv_dev_info info;
+	enum mcdrv_dev_id id;
+	u32 wait_time;
+	u8 val, ap, rst_reg, psw, rst, d_update, clock, reg_change;
+	u8 new_pd, org_pd, new_da0, new_da1, org_da0, org_da1;
+	u8 ofc = 0;
+	int ret = 0;
+
+	id = mc_dev_id_get();
+	mc_aec_info_get(&aec);
+	mc_dev_info_get(&info);
+	mc_clock_get(&clock);
+
+	rst_reg = mc_if_register_get_value(MCI_RST);
+	psw = rst_reg & (MCB_PSW_M | MCB_PSW_F | MCB_PSW_C);
+	rst = rst_reg & (MCB_RST_M | MCB_RST_F | MCB_RST_C);
+
+	org_pd = mc_a_register_get_value(MCI_PD);
+	new_pd = org_pd;
+
+	d_update = ~power_info->digital & power_update->digital;
+
+	ap = mc_ana_register_get_value(MCI_AP);
+
+	org_da0 = mc_ana_register_get_value(MCI_AP_DA0);
+	org_da1 = mc_ana_register_get_value(MCI_AP_DA1);
+
+	new_da0 = ~(org_da0 & power_update->analog[1]);
+	new_da0 |= power_info->analog[1];
+	new_da0 &= org_da0;
+
+	new_da1 = ~(org_da1 & power_update->analog[2]);
+	new_da1 |= power_info->analog[2];
+	new_da1 &= org_da1;
+
+	if ((d_update & MCDRV_POWINFO_D_PLL_PD) && (org_pd & MCB_PLL_PD)) {
+		if (ap & MCB_AP_LDOD) {
+			ap &= ~(MCB_AP_LDOD | MCB_AP_BGR);
+			mc_packet_add_write_ana(MCI_AP, ap);
+			mc_packet_add_wait(MCDRV_LDO_WAIT_TIME);
+		}
+
+		mc_packet_add_force_write_if(MCI_RST_A, MCI_RST_A_DEF);
+
+		ret = mc_packet_execute();
+		if (ret < 0)
+			return ret;
+
+		mc_packet_add_force_write_if(MCI_RST_A,
+					     MCI_RST_A_DEF & ~MCB_RST_A);
+
+		mc_a_registers_init();
+
+		if (info.power_mode == MCDRV_POWMODE_CDSPDEBUG
+		    || aec.vbox.cdsp_jtag_on == 1)
+			mc_packet_add_write_a(MCI_JTAGSEL, MCB_JTAGSEL);
+
+		digital_io_init();
+		gpio_init();
+
+		mc_packet_add_write_a(MCI_CK_TCX0, info.clk_sel);
+
+		mc_packet_add_write_a(MCI_PLL_MODE_A, info.pll_mode_a);
+		mc_packet_add_write_a(MCI_PLL_PREDIV_A, info.pll_prev_div_a);
+		mc_packet_add_write_a(MCI_PLL_FBDIV_A_12_8,
+				      info.pll_fb_div_a >> 8);
+		mc_packet_add_write_a(MCI_PLL_FBDIV_A_7_0,
+				      info.pll_fb_div_a & 0xff);
+		mc_packet_add_write_a(MCI_PLL_FRAC_A_15_8,
+				      info.pll_frac_a >> 8);
+		mc_packet_add_write_a(MCI_PLL_FRAC_A_7_0,
+				      info.pll_frac_a & 0xff);
+		mc_packet_add_write_a(MCI_PLL_FOUT_A, info.pll_freq_a << 1);
+
+		mc_packet_add_write_a(MCI_PLL_MODE_B, info.pll_mode_b);
+		mc_packet_add_write_a(MCI_PLL_PREDIV_B, info.pll_prev_div_b);
+		mc_packet_add_write_a(MCI_PLL_FBDIV_B_12_8,
+				      info.pll_fb_div_b >> 8);
+		mc_packet_add_write_a(MCI_PLL_FBDIV_B_7_0,
+				      info.pll_fb_div_b & 0xff);
+		mc_packet_add_write_a(MCI_PLL_FRAC_B_15_8,
+				      info.pll_frac_b >> 8);
+		mc_packet_add_write_a(MCI_PLL_FRAC_B_7_0,
+				      info.pll_frac_b & 0xff);
+		mc_packet_add_write_a(MCI_PLL_FOUT_B, info.pll_freq_b << 1);
+
+		val = mc_a_register_get_value(MCI_FREQ73M);
+		val &= 0xcf;
+		if (clock == MCDRV_CLKSW_CLKA)
+			val |= info.pll_freq_a << 4;
+		else
+			val |= info.pll_freq_b << 4;
+		mc_packet_add_write_a(MCI_FREQ73M, val);
+
+		val = info.clk_input;
+		if (clock == MCDRV_CLKSW_CLKB)
+			val |= MCB_CLK_INPUT;
+		mc_packet_add_write_a(MCI_CLKSRC, val);
+
+		if (id != MCDRV_DEV_ID_80_90H) {
+			mc_packet_add_write_a(MCI_DOA_DRV,
+					      info.options[0] << 7);
+			mc_packet_add_write_a(MCI_SCKMSKON_B, info.options[1]);
+		}
+
+		ret = mc_packet_execute();
+		if (ret < 0)
+			return ret;
+
+		val = MCI_CLK_MSK_DEF;
+		if (clock == MCDRV_CLKSW_CLKA) {
+			if (info.clk_input == MCDRV_CKINPUT_CLKI0_CLKI1
+			    || info.clk_input == MCDRV_CKINPUT_CLKI0_RTCK
+			    || info.clk_input == MCDRV_CKINPUT_CLKI0_SBCK)
+				val &= ~MCB_CLKI0_MSK;
+			else if (info.clk_input == MCDRV_CKINPUT_CLKI1_CLKI0
+				 || info.clk_input == MCDRV_CKINPUT_CLKI1_RTCK
+				 || info.clk_input == MCDRV_CKINPUT_CLKI1_SBCK)
+				val &= ~MCB_CLKI1_MSK;
+			else
+				val &= ~MCB_RTCI_MSK;
+		} else {
+			if (info.clk_input == MCDRV_CKINPUT_CLKI1_CLKI0
+			    || info.clk_input == MCDRV_CKINPUT_RTC_CLKI0
+			    || info.clk_input == MCDRV_CKINPUT_SBCK_CLKI0)
+				val &= ~MCB_CLKI0_MSK;
+			else if (info.clk_input == MCDRV_CKINPUT_CLKI0_CLKI1
+				 || info.clk_input == MCDRV_CKINPUT_RTC_CLKI1
+				 || info.clk_input == MCDRV_CKINPUT_SBCK_CLKI1)
+				val &= ~MCB_CLKI1_MSK;
+			else
+				val &= ~MCB_RTCI_MSK;
+		}
+		mc_packet_add_write_a(MCI_CLK_MSK, val);
+
+		if (!(val & MCB_CLKI0_MSK)) {
+			if (info.clk_sel == MCDRV_CKSEL_TCXO_TCXO
+			    || info.clk_sel == MCDRV_CKSEL_TCXO_CMOS)
+				mc_packet_add_wait(MCDRV_TCXO_WAIT_TIME);
+		} else if ((val & MCB_CLKI1_MSK) == 0) {
+			if (info.clk_sel == MCDRV_CKSEL_TCXO_TCXO
+			    || info.clk_sel == MCDRV_CKSEL_CMOS_TCXO)
+				mc_packet_add_wait(MCDRV_TCXO_WAIT_TIME);
+		}
+
+		if (!(val & MCB_RTCI_MSK)) {
+			val = mc_cd_register_get_value(MCI_CKSEL);
+			if (id == MCDRV_DEV_ID_80_90H)
+				val &= ~MCB_HSDET;
+			else
+				val &= ~MCB_CRTC;
+			mc_packet_add_write_cd(MCI_CKSEL, val);
+		}
+
+		new_pd &= ~MCB_PLL_PD;
+		mc_packet_add_write_a(MCI_PD, new_pd);
+
+		mc_packet_add_wait(MCDRV_PLL_WAIT_TIME);
+
+		new_pd &= ~MCB_VCOOUT_PD;
+		mc_packet_add_write_a(MCI_PD, new_pd);
+
+		mc_packet_add_force_write_if(MCI_IRQ, MCB_EIRQ);
+
+		ofc = 1;
+	}
+
+	if (((power_update->analog[0] & MCB_AP_LDOA)
+	     && !(power_info->analog[0] & MCB_AP_LDOA)) || ofc == 1) {
+		new_pd &= ~MCB_ANACLK_PD;
+		mc_packet_add_write_a(MCI_PD, new_pd);
+	}
+
+	if (ofc) {
+		if (id == MCDRV_DEV_ID_80_90H) {
+			if (mc_source_is_used(MCDRV_DST_HP, MCDRV_DST_CH0)
+			    || mc_source_is_used(MCDRV_DST_HP, MCDRV_DST_CH1))
+				mc_packet_add_write_ana(19, OP_DAC_HP);
+			else
+				mc_packet_add_write_ana(19, OP_DAC);
+		}
+	}
+
+	if (ap & MCB_AP_VR) {
+		if (((power_update->analog[0] & MCB_AP_LDOA)
+		     && !(power_info->analog[0] & MCB_AP_LDOA)) || ofc) {
+			if (id == MCDRV_DEV_ID_80_90H) {
+				ap &= ~MCB_AP_VR;
+				mc_packet_add_write_ana(MCI_AP, ap);
+
+				mc_packet_add_wait(MCDRV_VREF_WAIT_TIME_ES1);
+
+				ap &= ~(MCB_AP_LDOA | MCB_AP_BGR);
+				mc_packet_add_write_ana(MCI_AP, ap);
+
+				mc_packet_add_wait(MCDRV_LDO_WAIT_TIME);
+			} else {
+				ap &= ~MCB_AP_BGR;
+				mc_packet_add_write_ana(MCI_AP, ap);
+
+				ap &= ~MCB_AP_LDOA;
+				mc_packet_add_write_ana(MCI_AP, ap);
+
+				mc_packet_add_wait(MCDRV_LDO_WAIT_TIME);
+
+				mc_packet_add_write_ana(62, 0x20);
+
+				ap &= ~MCB_AP_VR;
+				mc_packet_add_write_ana(MCI_AP, ap);
+
+				mc_packet_add_wait(info.wait_time.wait[6]);
+
+				mc_packet_add_write_ana(62, 0);
+			}
+		}
+	}
+
+	if (((d_update & MCDRV_POWINFO_D_PM_CLK_PD) && (new_pd & MCB_PM_CLK_PD))
+	    || ofc) {
+		psw &= ~MCB_PSW_M;
+		rst &= ~MCB_RST_M;
+		new_pd &= ~MCB_PM_CLK_PD;
+		mc_mblock_registers_init();
+	}
+
+	if ((d_update & MCDRV_POWINFO_D_PB_CLK_PD) && (new_pd & MCB_PB_CLK_PD))
+		new_pd &= ~MCB_PB_CLK_PD;
+
+	if (((d_update & MCDRV_POWINFO_D_PE_CLK_PD) && (new_pd & MCB_PE_CLK_PD))
+	    || ofc) {
+		new_pd &= ~MCB_PE_CLK_PD;
+		mc_e_registers_init();
+	}
+
+	if ((d_update & MCDRV_POWINFO_D_PF_CLK_PD)
+	    && (new_pd & MCB_PF_CLK_PD)) {
+		psw &= ~MCB_PSW_F;
+		rst &= ~MCB_RST_F;
+		new_pd &= ~MCB_PF_CLK_PD;
+	}
+
+	if ((d_update & MCDRV_POWINFO_D_PC_CLK_PD)
+	    && (new_pd & MCB_PC_CLK_PD)) {
+		psw &= ~MCB_PSW_C;
+		rst &= ~MCB_RST_C;
+		new_pd &= ~MCB_PC_CLK_PD;
+	}
+
+	rst_reg &= ~(MCB_PSW_M | MCB_PSW_F | MCB_PSW_C);
+	rst_reg |= psw;
+	mc_packet_add_write_if(MCI_RST, rst_reg);
+
+	if (!(ap & MCB_AP_LDOD))
+		mc_packet_add_wait_event(MCDRV_EVT_PSW_RESET | (MCI_RST << 8) |
+					 (~psw &
+					  (MCB_PSW_M | MCB_PSW_F | MCB_PSW_C)));
+
+	rst_reg &= ~(MCB_RST_M | MCB_RST_F | MCB_RST_C);
+	rst_reg |= rst;
+	mc_packet_add_write_if(MCI_RST, rst_reg);
+	mc_packet_add_write_a(MCI_PD, new_pd);
+
+	ret = mc_packet_execute();
+	if (ret < 0)
+		return ret;
+
+	if ((d_update & MCDRV_POWINFO_D_PM_CLK_PD)
+	    && (org_pd & MCB_PM_CLK_PD) && !(new_pd & MCB_PM_CLK_PD))
+		mblock_init();
+
+	if ((d_update & MCDRV_POWINFO_D_PB_CLK_PD)
+	    && (org_pd & MCB_PB_CLK_PD) && !(new_pd & MCB_PB_CLK_PD)) {
+		ret = mc_packet_execute();
+		if (ret < 0)
+			return ret;
+
+		mc_bdsp_init();
+	}
+
+	if (ofc || ((d_update & MCDRV_POWINFO_D_PE_CLK_PD)
+		    && (org_pd & MCB_PE_CLK_PD) && !(new_pd & MCB_PE_CLK_PD))) {
+		ret = mc_packet_execute();
+		if (ret < 0)
+			return ret;
+
+		mc_edsp_init();
+		e_registers_setup();
+		ret = mc_packet_execute();
+		if (ret < 0)
+			return ret;
+
+		if (ofc) {
+			ret = offset_cancel();
+			if (ret < 0)
+				return ret;
+
+			e_registers_setup();
+			ret = mc_packet_execute();
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	if ((d_update & MCDRV_POWINFO_D_PF_CLK_PD)
+	    && (org_pd & MCB_PF_CLK_PD) && !(new_pd & MCB_PF_CLK_PD)) {
+		ret = mc_packet_execute();
+		if (ret < 0)
+			return ret;
+
+		mc_fdsp_init(aec.fdsp_locate, info.wait_time.wait[5]);
+
+		val = MCB_IESERR | MCB_IEAMTBEG | MCB_IEAMTEND | MCB_IEFW;
+		mc_packet_add_force_write_if(MCI_IESERR, val);
+	}
+
+	if ((d_update & MCDRV_POWINFO_D_PC_CLK_PD)
+	    && (org_pd & MCB_PC_CLK_PD) && !(new_pd & MCB_PC_CLK_PD)) {
+		if (aec.vbox.cdsp_jtag_on == 1)
+			mc_packet_add_write_a(MCI_JTAGSEL, MCB_JTAGSEL);
+
+		ret = mc_packet_execute();
+		if (ret < 0)
+			return ret;
+
+		mc_cdsp_init();
+
+		val = MCB_ECDSP | MCB_EFFIFO | MCB_ERFIFO | MCB_EEFIFO
+		    | MCB_EOFIFO | MCB_EDFIFO | MCB_EENC | MCB_EDEC;
+		mc_packet_add_force_write_if(MCI_ECDSP, val);
+	}
+
+	add_dac_start();
+
+	if (!ofc) {
+		val = mc_cd_register_get_value(MCI_DP);
+		if (power_update->analog[1] & (MCB_AP_DA0R | MCB_AP_DA0L)) {
+			if (!(power_info->analog[1] & MCB_AP_DA0R)
+			    || !(power_info->analog[1] & MCB_AP_DA0L)) {
+				val &= ~(MCB_DP_DAC1 | MCB_DP_DAC0 |
+					 MCB_DP_PDMCK | MCB_DP_PDMDAC);
+				if (id == MCDRV_DEV_ID_80_90H)
+					val |= MCB_DP_DAC1;
+			}
+		}
+
+		if (power_update->analog[1] & (MCB_AP_DA1R | MCB_AP_DA1L))
+			if (!(power_info->analog[2] & MCB_AP_DA1R)
+			    || !(power_info->analog[2] & MCB_AP_DA1L))
+				val &= ~(MCB_DP_DAC1 | MCB_DP_PDMCK |
+					 MCB_DP_PDMDAC);
+		if (power_update->analog[4] &
+		    (MCB_AP_ADM | MCB_AP_ADR | MCB_AP_ADL))
+			if (!(power_info->analog[4] & MCB_AP_ADM)
+			    || !(power_info->analog[4] & MCB_AP_ADR)
+			    || !(power_info->analog[4] & MCB_AP_ADL))
+				val &= ~(MCB_DP_ADC | MCB_DP_PDMCK |
+					 MCB_DP_PDMADC);
+		if ((new_da1 &
+		     (MCB_AP_SPR2 | MCB_AP_SPR1 | MCB_AP_SPL2 | MCB_AP_SPL1))
+		    != (MCB_AP_SPR2 | MCB_AP_SPR1 | MCB_AP_SPL2 | MCB_AP_SPL1))
+			val &= ~(MCB_DP_ADC | MCB_DP_PDMADC);
+		mc_packet_add_write_cd(MCI_DP, val);
+	}
+
+	val = mc_ana_register_get_value(MCI_AP_MIC);
+	reg_change = ~(val & power_update->analog[3]);
+	reg_change |= power_info->analog[3];
+	reg_change &= val;
+	mc_packet_add_write_ana(MCI_AP_MIC, reg_change);
+	reg_change = ~reg_change & val;
+	wait_time = get_max_wait(reg_change);
+
+	val = mc_ana_register_get_value(MCI_AP_AD);
+	reg_change = ~(val & power_update->analog[4]);
+	reg_change |= power_info->analog[4];
+	reg_change &= val;
+	mc_packet_add_write_ana(MCI_AP_AD, reg_change);
+
+	if ((val & MCB_AP_LI) && !(reg_change & MCB_AP_LI))
+		wait_time = info.wait_time.wait[4];
+
+	mc_ana_register_set_value(MCI_AP_DA0, new_da0);
+	mc_ana_register_set_value(MCI_AP_DA1, new_da1);
+
+	if (wait_time > 0)
+		mc_packet_add_wait(wait_time);
+
+	return ret;
+}
+
+static inline void dac_stop(void)
+{
+	u8 val;
+
+	val = mc_e_register_get_value(MCI_LPF_THR);
+	if (!mc_source_is_used(MCDRV_DST_DAC0, MCDRV_DST_CH0)
+	    && !mc_source_is_used(MCDRV_DST_DAC0, MCDRV_DST_CH1))
+		val &= ~MCB_OSF0_ENB;
+	if (!mc_source_is_used(MCDRV_DST_DAC1, MCDRV_DST_CH0)
+	    && !mc_source_is_used(MCDRV_DST_DAC1, MCDRV_DST_CH1))
+		val &= ~MCB_OSF1_ENB;
+	mc_packet_add_write_e(MCI_LPF_THR, val);
+}
+
+int mc_packet_add_powerdown(struct mcdrv_power_info *power_info,
+			    struct mcdrv_power_update *power_update)
+{
+	struct mcdrv_dev_info info;
+	enum mcdrv_dev_id id;
+	u8 val, d_update, pd, rst_reg, ap, da0, da1;
+	u8 psw = 0, rst = 0, mk_det_en = 0, add_mk_det_en = 0, plug_det_db = 0;
+	int ret = 0;
+
+	id = mc_dev_id_get();
+	mc_dev_info_get(&info);
+
+	d_update = power_info->digital & power_update->digital;
+	rst_reg = mc_if_register_get_value(MCI_RST);
+	pd = mc_a_register_get_value(MCI_PD);
+	plug_det_db = mc_plug_detect_db_get();
+
+	if (info.power_mode == MCDRV_POWMODE_FULL)
+		if ((d_update & MCDRV_POWINFO_D_PLL_PD)
+		    && !(pd & (MCB_PLL_PD | MCB_PM_CLK_PD)))
+			mc_packet_add_wait_event(MCDRV_EVT_ALLMUTE);
+
+	da0 = mc_ana_register_get_value(MCI_AP_DA0);
+	da0 |= (power_info->analog[1] & power_update->analog[1]);
+	da1 = mc_ana_register_get_value(MCI_AP_DA1);
+	da1 |= (power_info->analog[2] & power_update->analog[2]);
+	mc_ana_register_set_value(MCI_AP_DA0, da0);
+	mc_ana_register_set_value(MCI_AP_DA1, da1);
+
+	val = mc_ana_register_get_value(MCI_AP_MIC);
+	val |= (power_info->analog[3] & power_update->analog[3]);
+	mc_packet_add_write_ana(MCI_AP_MIC, val);
+
+	val = mc_ana_register_get_value(MCI_AP_AD);
+	val |= (power_info->analog[4] & power_update->analog[4]);
+	mc_packet_add_write_ana(MCI_AP_AD, val);
+
+	if (d_update & MCDRV_POWINFO_D_PC_CLK_PD) {
+		if (!(pd & MCB_PC_CLK_PD)) {
+			mc_packet_add_force_write_if(MCI_ECDSP, 0);
+			ret = mc_packet_execute();
+			if (ret < 0)
+				return ret;
+
+			mc_cdsp_term();
+			pd |= MCB_PC_CLK_PD;
+		}
+		rst |= MCB_RST_C;
+		psw |= MCB_PSW_C;
+	}
+
+	if (d_update & MCDRV_POWINFO_D_PF_CLK_PD) {
+		if (!(pd & MCB_PF_CLK_PD)) {
+			mc_packet_add_force_write_if(MCI_IESERR, 0);
+			ret = mc_packet_execute();
+			if (ret < 0)
+				return ret;
+
+			mc_fdsp_term();
+			pd |= MCB_PF_CLK_PD;
+		}
+		rst |= MCB_RST_F;
+		psw |= MCB_PSW_F;
+	}
+
+	if ((d_update & MCDRV_POWINFO_D_PE_CLK_PD) && !(pd & MCB_PE_CLK_PD)) {
+		mc_packet_add_force_write_if(MCI_EEDSP, 0);
+		ret = mc_packet_execute();
+		if (ret < 0)
+			return ret;
+
+		mc_edsp_term();
+		pd |= MCB_PE_CLK_PD;
+	}
+
+	if ((d_update & MCDRV_POWINFO_D_PB_CLK_PD) && !(pd & MCB_PB_CLK_PD)) {
+		ret = mc_packet_execute();
+		if (ret < 0)
+			return ret;
+
+		mc_bdsp_term();
+		pd |= MCB_PB_CLK_PD;
+	}
+
+	if (d_update & MCDRV_POWINFO_D_PM_CLK_PD) {
+		if (!(pd & MCB_PM_CLK_PD)) {
+			mc_packet_add_write_ma(MCI_DSP_START, 0);
+			pd |= MCB_PM_CLK_PD;
+		}
+		rst |= MCB_RST_M;
+		psw |= MCB_PSW_M;
+	}
+
+	mc_packet_add_write_a(MCI_PD, pd);
+
+	rst_reg |= rst;
+	mc_packet_add_write_if(MCI_RST, rst_reg);
+
+	rst_reg |= psw;
+	mc_packet_add_write_if(MCI_RST, rst_reg);
+
+	ap = mc_ana_register_get_value(MCI_AP);
+
+	val = mc_cd_register_get_value(MCI_HSDETEN);
+	if (info.power_mode == MCDRV_POWMODE_FULL) {
+		if ((d_update & MCDRV_POWINFO_D_PLL_PD)
+		    && !(pd & MCB_PLL_PD)
+		    && (power_update->analog[0] & MCB_AP_LDOA)
+		    && (power_info->analog[0] & MCB_AP_LDOA)) {
+			if (val & MCB_MKDETEN) {
+				mk_det_en = val & MCB_MKDETEN;
+				val &= ~MCB_MKDETEN;
+				mc_packet_add_write_cd(MCI_HSDETEN, val);
+			}
+
+			if (id != MCDRV_DEV_ID_80_90H)
+				mc_packet_add_wait_event(MCDRV_EVT_AP_CP_A_SET |
+							 (91U << 8) | 0x2U);
+
+			pd |= MCB_ANACLK_PD;
+			mc_packet_add_write_a(MCI_PD, pd);
+		}
+	}
+
+	val = mc_cd_register_get_value(MCI_DP);
+	if ((power_update->analog[1] & (MCB_AP_DA0R | MCB_AP_DA0L))
+	    && (power_info->analog[1] & MCB_AP_DA0R)
+	    && (power_info->analog[1] & MCB_AP_DA0L))
+		val |= MCB_DP_DAC0;
+	if ((power_update->analog[1] & (MCB_AP_DA1R | MCB_AP_DA1L))
+	    && (power_info->analog[2] & MCB_AP_DA1R)
+	    && (power_info->analog[2] & MCB_AP_DA1L)) {
+		if (id == MCDRV_DEV_ID_80_90H)
+			val |= MCB_DP_DAC1;
+		else if (val & MCB_DP_DAC0)
+			val |= MCB_DP_DAC1;
+
+	}
+
+	if ((power_update->analog[4] & (MCB_AP_ADM | MCB_AP_ADR | MCB_AP_ADL))
+	    && (power_info->analog[4] & MCB_AP_ADM)
+	    && (power_info->analog[4] & MCB_AP_ADR)
+	    && (power_info->analog[4] & MCB_AP_ADL)
+	    && (da1 & (MCB_AP_SPR2 | MCB_AP_SPR1 | MCB_AP_SPL2 | MCB_AP_SPL1))
+	    == (MCB_AP_SPR2 | MCB_AP_SPR1 | MCB_AP_SPL2 | MCB_AP_SPL1))
+		val |= MCB_DP_ADC | MCB_DP_PDMADC;
+	if ((val & (MCB_DP_DAC0 | MCB_DP_DAC1))
+	    == (MCB_DP_DAC0 | MCB_DP_DAC1)) {
+		val |= MCB_DP_PDMDAC;
+		if (val & MCB_DP_PDMADC)
+			val = MCI_DP_DEF;
+	}
+	mc_packet_add_write_cd(MCI_DP, val);
+	dac_stop();
+
+	if (info.power_mode == MCDRV_POWMODE_FULL) {
+		if ((d_update & MCDRV_POWINFO_D_PLL_PD)
+		    && !(pd & MCB_PLL_PD)) {
+			mc_packet_add_force_write_if(MCI_IRQ, 0);
+			pd |= MCB_VCOOUT_PD;
+			pd |= MCB_PLL_PD;
+			mc_packet_add_write_a(MCI_PD, pd);
+
+			val = mc_a_register_get_value(MCI_CLK_MSK);
+			if (!(val & MCB_RTCI_MSK)) {
+				val = mc_cd_register_get_value(MCI_CKSEL);
+				if (id == MCDRV_DEV_ID_80_90H)
+					val |= MCB_HSDET;
+				else
+					val |= MCB_CRTC;
+				mc_packet_add_write_cd(MCI_CKSEL, val);
+			}
+
+			ret = mc_packet_execute();
+			if (ret < 0)
+				return ret;
+
+			mc_packet_add_write_if(MCI_RST_A, MCI_RST_A_DEF);
+			mc_a_registers_init();
+		}
+
+		if (pd & MCB_PLL_PD)
+			ap |= MCB_AP_LDOD;
+	}
+
+	if ((power_update->analog[0] & MCB_AP_LDOA)
+	    && (power_info->analog[0] & MCB_AP_LDOA)
+	    && !(ap & MCB_AP_LDOA)
+	    && (ap & MCB_AP_LDOD)) {
+		add_mk_det_en = mk_det_en;
+		ap |= (MCB_AP_LDOA | MCB_AP_VR);
+	} else
+		add_mk_det_en = 0;
+
+	if ((power_update->analog[0] & MCB_AP_HPDET)
+	    && (power_info->analog[0] & MCB_AP_HPDET))
+		ap |= MCB_AP_HPDET;
+
+	if (id != MCDRV_DEV_ID_81_92H) {
+		if ((ap & (MCB_AP_LDOA | MCB_AP_LDOD)) ==
+		    (MCB_AP_LDOA | MCB_AP_LDOD)
+		    && !(ap & MCB_AP_BGR)
+		    && !(plug_det_db & MCB_RPLUGDET_DB)) {
+			if (id != MCDRV_DEV_ID_80_90H) {
+				val = info.hp_hiz << 6 | info.sp_hiz << 4
+				    | info.rc_hiz << 3 | info.options[2];
+				mc_packet_add_write_ana(MCI_HIZ, val);
+				val = info.line_out2_hiz << 6
+				    | info.line_out1_hiz << 4;
+				mc_packet_add_write_ana(MCI_LO_HIZ, val);
+			}
+
+			ap |= MCB_AP_BGR;
+		}
+	} else {
+		if ((ap & (MCB_AP_LDOA | MCB_AP_LDOD)) ==
+		    (MCB_AP_LDOA | MCB_AP_LDOD)) {
+			ap |= MCB_AP_BGR;
+			if (!(plug_det_db & MCB_RPLUGDET_DB)) {
+				val = info.hp_hiz << 6 | info.sp_hiz << 4
+				    | info.rc_hiz << 3 | info.options[2];
+				mc_packet_add_write_ana(MCI_HIZ, val);
+			}
+		}
+	}
+
+	val = mc_ana_register_get_value(MCI_AP);
+	if ((ap & MCB_AP_HPDET) && !(val & MCB_AP_HPDET)) {
+		val |= MCB_AP_HPDET;
+		mc_packet_add_write_ana(MCI_AP, val);
+	}
+	if ((ap & MCB_AP_LDOA) && !(val & MCB_AP_LDOA)) {
+		val |= MCB_AP_LDOA;
+		if (id == MCDRV_DEV_ID_80_90H)
+			mc_packet_add_write_ana(MCI_AP, val);
+		val |= MCB_AP_VR;
+		mc_packet_add_write_ana(MCI_AP, val);
+	}
+	if ((ap & MCB_AP_LDOD) && !(val & MCB_AP_LDOD)) {
+		val |= MCB_AP_LDOD;
+		if ((ap & MCB_AP_BGR) && !(val & MCB_AP_BGR) && !mk_det_en)
+			val |= MCB_AP_BGR;
+		mc_packet_add_write_ana(MCI_AP, val);
+	}
+
+	if ((val & (MCB_AP_LDOA | MCB_AP_LDOD | MCB_AP_BGR)) ==
+	    (MCB_AP_LDOA | MCB_AP_LDOD)
+	    && (ap & MCB_AP_BGR) && !(plug_det_db & MCB_RPLUGDET_DB))
+		val |= MCB_AP_BGR;
+	mc_packet_add_write_ana(MCI_AP, val);
+
+	if (add_mk_det_en) {
+		ret = mc_packet_execute();
+		if (ret < 0)
+			return ret;
+
+		mc_packet_add_mic_key_detect_enable(false);
+	}
+
+	return ret;
+}
+
+static void get_di_state(u8 phys_port, u8 *is_used_dir, u8 *is_used_dit,
+			 u8 *lport)
+{
+	struct mcdrv_dio_path_info dio;
+
+	mc_dio_path_info_get(&dio);
+
+	if (!is_used_dir || !is_used_dit || !lport)
+		return;
+
+	*is_used_dir = 0;
+	*is_used_dit = 0;
+	*lport = 0xff;
+
+	if (dio.phys_port[0] == phys_port) {
+		if (mc_d1_source_is_used(MCDRV_D1SRC_MUSICIN_ON)) {
+			*is_used_dir = 1;
+			*lport = 0;
+		}
+
+		if (mc_source_is_used(MCDRV_DST_MUSICOUT, MCDRV_DST_CH0)
+		    || mc_source_is_used(MCDRV_DST_MUSICOUT, MCDRV_DST_CH1)) {
+			*is_used_dit = 1;
+			*lport = 0;
+		}
+	}
+
+	if (dio.phys_port[1] == phys_port) {
+		if (mc_d1_source_is_used(MCDRV_D1SRC_EXTIN_ON)) {
+			*is_used_dir = 1;
+			*lport = 1;
+		}
+
+		if (mc_source_is_used(MCDRV_DST_EXTOUT, MCDRV_DST_CH0)
+		    || mc_source_is_used(MCDRV_DST_EXTOUT, MCDRV_DST_CH1)) {
+			*is_used_dit = 1;
+			*lport = 1;
+		}
+	}
+
+	if (dio.phys_port[2] == phys_port) {
+		if (mc_source_is_used(MCDRV_DST_VBOXIOIN, MCDRV_DST_CH0)
+		    || mc_source_is_used(MCDRV_DST_VBOXHOSTIN, MCDRV_DST_CH0)) {
+			*is_used_dir = 1;
+			*lport = 2;
+		}
+
+		if (mc_source_is_used(MCDRV_DST_VOICEOUT, MCDRV_DST_CH0)) {
+			*is_used_dit = 1;
+			*lport = 2;
+		}
+	}
+
+	if (dio.phys_port[3] == phys_port) {
+		if (mc_d1_source_is_used(MCDRV_D1SRC_HIFIIN_ON)) {
+			*is_used_dir = 1;
+			*lport = 3;
+		}
+
+		if (mc_source_is_used(MCDRV_DST_HIFIOUT, MCDRV_DST_CH0)) {
+			*is_used_dit = 1;
+			*lport = 3;
+		}
+	}
+}
+
+static inline u8 get_logical_port(u8 phys_port)
+{
+	u8 is_used_dir, is_used_dit, lport = 0xff;
+
+	get_di_state(phys_port, &is_used_dir, &is_used_dit, &lport);
+
+	return lport;
+}
+
+static inline void add_di_pad(void)
+{
+	struct mcdrv_aec_info aec;
+	struct mcdrv_dev_info info;
+	struct mcdrv_path_info path;
+	struct mcdrv_dio_info dio;
+	u8 val, lport, is_used_dir, is_used_dit;
+
+	mc_aec_info_get(&aec);
+	mc_dev_info_get(&info);
+	mc_path_info_get(&path);
+	mc_dio_info_get(&dio);
+
+	is_used_dir = 0;
+	is_used_dit = 0;
+	lport = 0xff;
+	get_di_state(MCDRV_PHYSPORT_DIO0, &is_used_dir, &is_used_dit, &lport);
+
+	val = 0;
+	if (!is_used_dir)
+		val |= MCB_SDIN0_MSK;
+	if (!is_used_dit) {
+		if (!info.dio0_sdo_hiz)
+			val |= MCB_SDO0_DDR;
+	} else
+		val |= MCB_SDO0_DDR;
+
+	if (!is_used_dir && !is_used_dit) {
+		val |= MCB_BCLK0_MSK | MCB_LRCK0_MSK;
+		if (!info.dio0_clk_hiz)
+			val |= MCB_BCLK0_DDR | MCB_LRCK0_DDR;
+	} else {
+		if (lport == 3
+		    || (lport <= 2 &&
+			dio.port[lport].dio_common.master_slave ==
+			MCDRV_DIO_MASTER))
+			val |= MCB_BCLK0_DDR | MCB_LRCK0_DDR;
+	}
+	if (lport <= 3
+	    && dio.port[lport].dio_common.bck_invert == MCDRV_BCLK_INVERT)
+		val |= MCB_BCLK0_INV;
+	if (info.power_mode != MCDRV_POWMODE_CDSPDEBUG
+	    && aec.vbox.cdsp_jtag_on != 1)
+		mc_packet_add_write_a(MCI_DO0_DRV, val);
+
+	is_used_dir = 0;
+	is_used_dit = 0;
+	lport = 0xff;
+	get_di_state(MCDRV_PHYSPORT_DIO1, &is_used_dir, &is_used_dit, &lport);
+
+	val = 0;
+	if (!is_used_dir)
+		val |= MCB_SDIN1_MSK;
+	if (!is_used_dit) {
+		if (!info.dio1_sdo_hiz)
+			val |= MCB_SDO1_DDR;
+	} else
+		val |= MCB_SDO1_DDR;
+
+	if (!is_used_dir && !is_used_dit) {
+		val |= MCB_BCLK1_MSK | MCB_LRCK1_MSK;
+		if (!info.dio1_clk_hiz)
+			val |= MCB_BCLK1_DDR | MCB_LRCK1_DDR;
+	} else {
+		if (lport == 3
+		    || (lport <= 2 &&
+			dio.port[lport].dio_common.master_slave ==
+			MCDRV_DIO_MASTER))
+			val |= MCB_BCLK1_DDR | MCB_LRCK1_DDR;
+	}
+	if (lport <= 3
+	    && dio.port[lport].dio_common.bck_invert == MCDRV_BCLK_INVERT)
+		val |= MCB_BCLK1_INV;
+	if (info.power_mode != MCDRV_POWMODE_CDSPDEBUG
+	    && aec.vbox.cdsp_jtag_on != 1)
+		mc_packet_add_write_a(MCI_DO1_DRV, val);
+
+	is_used_dir = 0;
+	is_used_dit = 0;
+	lport = 0xff;
+	get_di_state(MCDRV_PHYSPORT_DIO2, &is_used_dir, &is_used_dit, &lport);
+
+	val = 0;
+	if (!is_used_dir)
+		val |= MCB_SDIN2_MSK;
+	if (!is_used_dit) {
+		if (!info.dio2_sdo_hiz)
+			val |= MCB_SDO2_DDR;
+	} else
+		val |= MCB_SDO2_DDR;
+
+	if (!is_used_dir && !is_used_dit
+	    && !mc_d1_source_is_used(MCDRV_D1SRC_VBOXOUT_ON)
+	    && !mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH0)
+	    && !mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH1)) {
+		val |= MCB_BCLK2_MSK | MCB_LRCK2_MSK;
+		if (!info.dio2_clk_hiz)
+			val |= MCB_BCLK2_DDR | MCB_LRCK2_DDR;
+	} else {
+		if (lport == 3
+		    || (lport <= 2 &&
+			dio.port[lport].dio_common.master_slave ==
+			MCDRV_DIO_MASTER))
+			val |= MCB_BCLK2_DDR | MCB_LRCK2_DDR;
+	}
+	if (lport <= 3
+	    && dio.port[lport].dio_common.bck_invert == MCDRV_BCLK_INVERT)
+		val |= MCB_BCLK2_INV;
+	mc_packet_add_write_a(MCI_DO2_DRV, val);
+}
+
+static inline void add_pad(void)
+{
+	struct mcdrv_dev_info info;
+	u32 hifi_src;
+	u8 val;
+
+	mc_dev_info_get(&info);
+
+	hifi_src = mc_source_get(MCDRV_DST_HIFIOUT, MCDRV_DST_CH0);
+
+	if (!mc_d2_source_is_used(MCDRV_D2SRC_PDM0_L_ON)
+	    && !mc_d2_source_is_used(MCDRV_D2SRC_PDM0_R_ON)
+	    && !mc_d2_source_is_used(MCDRV_D2SRC_PDM1_L_ON)
+	    && !mc_d2_source_is_used(MCDRV_D2SRC_PDM1_R_ON)
+	    && !(hifi_src & (MCDRV_D2SRC_PDM0_L_ON | MCDRV_D2SRC_PDM0_R_ON))
+	    && !(hifi_src & (MCDRV_D2SRC_PDM1_L_ON | MCDRV_D2SRC_PDM1_R_ON))
+	    && info.pa0_func == MCDRV_PA_PDMCK) {
+		val = mc_a_register_get_value(MCI_PA0);
+		val |= MCB_PA0_MSK;
+		mc_packet_add_write_a(MCI_PA0, val);
+	}
+
+	if (info.pa1_func == MCDRV_PA_PDMDI) {
+		val = mc_a_register_get_value(MCI_PA1);
+		if (!mc_d2_source_is_used(MCDRV_D2SRC_PDM0_L_ON)
+		    && !mc_d2_source_is_used(MCDRV_D2SRC_PDM0_R_ON)
+		    && !(hifi_src &
+			 (MCDRV_D2SRC_PDM0_L_ON | MCDRV_D2SRC_PDM0_R_ON)))
+			val |= MCB_PA1_MSK;
+		else
+			val &= ~MCB_PA1_MSK;
+		mc_packet_add_write_a(MCI_PA1, val);
+	}
+
+	if (info.pa2_func == MCDRV_PA_PDMDI) {
+		val = mc_a_register_get_value(MCI_PA2);
+		if (!mc_d2_source_is_used(MCDRV_D2SRC_PDM1_L_ON)
+		    && !mc_d2_source_is_used(MCDRV_D2SRC_PDM1_R_ON)
+		    && !(hifi_src &
+			 (MCDRV_D2SRC_PDM1_L_ON | MCDRV_D2SRC_PDM1_R_ON)))
+			val |= MCB_PA2_MSK;
+		else
+			val &= ~MCB_PA2_MSK;
+		mc_packet_add_write_a(MCI_PA2, val);
+	}
+}
+
+static u8 get_preinput(u32 src_on)
+{
+	u8 val = 0;
+
+	switch (src_on) {
+	case MCDRV_D2SRC_ADC0_L_ON:
+		val = MCB_DSF_PRE_INPUT_ADC_L;
+		break;
+	case MCDRV_D2SRC_ADC0_R_ON:
+		val = MCB_DSF_PRE_INPUT_ADC_R;
+		break;
+	case MCDRV_D2SRC_ADC1_ON:
+		val = MCB_DSF_PRE_INPUT_ADC_M;
+		break;
+	case MCDRV_D2SRC_PDM0_L_ON:
+		val = MCB_DSF_PRE_INPUT_PDM0_L;
+		break;
+	case MCDRV_D2SRC_PDM0_R_ON:
+		val = MCB_DSF_PRE_INPUT_PDM0_R;
+		break;
+	case MCDRV_D2SRC_PDM1_L_ON:
+		val = MCB_DSF_PRE_INPUT_PDM1_L;
+		break;
+	case MCDRV_D2SRC_PDM1_R_ON:
+		val = MCB_DSF_PRE_INPUT_PDM1_R;
+		break;
+	default:
+		break;
+	}
+
+	return val;
+}
+
+static u8 get_in_mix_value(u32 src_on)
+{
+	u8 val = 0;
+
+	if (src_on & MCDRV_D1SRC_MUSICIN_ON)
+		val |= MCB_IN_MIX_DIFI_0;
+	if (src_on & MCDRV_D1SRC_EXTIN_ON)
+		val |= MCB_IN_MIX_DIFI_1;
+	if (src_on & MCDRV_D1SRC_VBOXOUT_ON)
+		val |= MCB_IN_MIX_DIFI_2;
+	if (src_on & MCDRV_D1SRC_VBOXREFOUT_ON)
+		val |= MCB_IN_MIX_DIFI_3;
+	if (src_on & MCDRV_D1SRC_ADIF0_ON)
+		val |= MCB_IN_MIX_ADI_0;
+	if (src_on & MCDRV_D1SRC_ADIF1_ON)
+		val |= MCB_IN_MIX_ADI_1;
+	if (src_on & MCDRV_D1SRC_ADIF2_ON)
+		val |= MCB_IN_MIX_ADI_2;
+
+	return val;
+}
+
+static void add_in_mix_src(enum mcdrv_dst_type dst_type,
+			   u8 addr0, u8 addr1, u8 sep)
+{
+	u32 src;
+	u8 val0, val1, cur_val0, cur_val1;
+
+	cur_val0 = mc_ma_register_get_value(addr0);
+	cur_val0 &= ~sep;
+
+	cur_val1 = mc_ma_register_get_value(addr1);
+
+	src = mc_source_get(dst_type, MCDRV_DST_CH0);
+	val0 = get_in_mix_value(src);
+
+	src = mc_source_get(dst_type, MCDRV_DST_CH1);
+	val1 = get_in_mix_value(src);
+
+	if (val0 != cur_val0 || val1 != cur_val1) {
+		if (val0 == val1) {
+			mc_packet_add_force_write_ma(addr0, val0);
+			mc_ma_register_set_value(addr1, val1);
+		} else {
+			mc_packet_add_force_write_ma(addr0, val0 | sep);
+			mc_packet_add_force_write_ma(addr1, val1);
+		}
+	}
+}
+
+static u16 get_out_mix_value(u32 src_on)
+{
+	u16 val = 0;
+
+	if (src_on & MCDRV_D1SRC_MUSICIN_ON)
+		val |= MCB_OUT_MIX_DIFI_0;
+	if (src_on & MCDRV_D1SRC_EXTIN_ON)
+		val |= MCB_OUT_MIX_DIFI_1;
+	if (src_on & MCDRV_D1SRC_VBOXOUT_ON)
+		val |= MCB_OUT_MIX_DIFI_2;
+	if (src_on & MCDRV_D1SRC_VBOXREFOUT_ON)
+		val |= MCB_OUT_MIX_DIFI_3;
+	if (src_on & MCDRV_D1SRC_AE0_ON)
+		val |= MCB_OUT_MIX_AEO_0;
+	if (src_on & MCDRV_D1SRC_AE1_ON)
+		val |= MCB_OUT_MIX_AEO_1;
+	if (src_on & MCDRV_D1SRC_AE2_ON)
+		val |= MCB_OUT_MIX_AEO_2;
+	if (src_on & MCDRV_D1SRC_AE3_ON)
+		val |= MCB_OUT_MIX_AEO_3;
+	if (src_on & MCDRV_D1SRC_ADIF0_ON)
+		val |= MCB_OUT_MIX_ADI_0;
+	if (src_on & MCDRV_D1SRC_ADIF1_ON)
+		val |= MCB_OUT_MIX_ADI_1;
+	if (src_on & MCDRV_D1SRC_ADIF2_ON)
+		val |= MCB_OUT_MIX_ADI_2;
+
+	return val;
+}
+
+static void add_out_mix_src(enum mcdrv_dst_type dst_type,
+			    u8 addr0, u8 addr1, u8 sep)
+{
+	u32 src;
+	u16 val0, val1, cur_val0, cur_val1;
+
+	cur_val0 = (u16) mc_ma_register_get_value(addr0) << 8
+	    | mc_ma_register_get_value(addr0 + 1);
+	cur_val0 &= ~(sep << 8);
+
+	cur_val1 = (u16) mc_ma_register_get_value(addr1) << 8
+	    | mc_ma_register_get_value(addr1 + 1);
+
+	src = mc_source_get(dst_type, MCDRV_DST_CH0);
+	val0 = get_out_mix_value(src);
+
+	src = mc_source_get(dst_type, MCDRV_DST_CH1);
+	val1 = get_out_mix_value(src);
+
+	if (val0 != cur_val0 || val1 != cur_val1) {
+		if (val0 == val1) {
+			mc_packet_add_force_write_ma(addr0, val0 >> 8);
+			mc_packet_add_force_write_ma(addr0 + 1, val0);
+			mc_ma_register_set_value(addr1, val1 >> 8);
+			mc_ma_register_set_value(addr1 + 1, val1);
+		} else {
+			mc_packet_add_force_write_ma(addr0, (val0 >> 8) | sep);
+			mc_packet_add_force_write_ma(addr0 + 1, val0);
+			mc_packet_add_force_write_ma(addr1, val1 >> 8);
+			mc_packet_add_force_write_ma(addr1 + 1, val1);
+		}
+	}
+}
+
+static inline void add_out2_mix_src(void)
+{
+	u32 src;
+	u16 val0, val1, cur_val0, cur_val1;
+
+	cur_val0 = (u16) mc_ma_register_get_value(MCI_OUT2_MIX0_10_8) << 8
+	    | mc_ma_register_get_value(MCI_OUT2_MIX0_7_0);
+	cur_val0 &= ~(MCB_OUT2_MSEP << 8);
+
+	cur_val1 = (u16) mc_ma_register_get_value(MCI_OUT2_MIX1_10_8) << 8
+	    | mc_ma_register_get_value(MCI_OUT2_MIX1_7_0);
+	src = mc_source_get(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH0);
+	val0 = get_out_mix_value(src);
+
+	src = mc_source_get(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH1);
+	val1 = get_out_mix_value(src);
+
+	if (val0 != cur_val0 || val1 != cur_val1) {
+		if (val0 == val1) {
+			mc_packet_add_force_write_ma(MCI_OUT2_MIX0_10_8,
+						     val0 >> 8);
+			mc_packet_add_force_write_ma(MCI_OUT2_MIX0_7_0, val0);
+			mc_ma_register_set_value(MCI_OUT2_MIX1_10_8, val1 >> 8);
+			mc_ma_register_set_value(MCI_OUT2_MIX1_7_0, val1);
+		} else {
+			mc_packet_add_force_write_ma(MCI_OUT2_MIX0_10_8,
+						     (val0 >> 8) |
+						     MCB_OUT2_MSEP);
+			mc_packet_add_force_write_ma(MCI_OUT2_MIX0_7_0, val0);
+			mc_packet_add_force_write_ma(MCI_OUT2_MIX1_10_8,
+						     val1 >> 8);
+			mc_packet_add_force_write_ma(MCI_OUT2_MIX1_7_0, val1);
+		}
+	}
+
+	cur_val0 = (u16) mc_ma_register_get_value(MCI_OUT3_MIX0_10_8) << 8
+	    | mc_ma_register_get_value(MCI_OUT3_MIX0_7_0);
+	cur_val0 &= ~(MCB_OUT3_MSEP << 8);
+
+	cur_val1 = (u16) mc_ma_register_get_value(MCI_OUT3_MIX1_10_8) << 8
+	    | mc_ma_register_get_value(MCI_OUT3_MIX1_7_0);
+
+	src = mc_source_get(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH2);
+	val0 = get_out_mix_value(src);
+
+	src = mc_source_get(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH3);
+	val1 = get_out_mix_value(src);
+
+	if (val0 != cur_val0 || val1 != cur_val1) {
+		if (val0 == val1) {
+			mc_packet_add_force_write_ma(MCI_OUT3_MIX0_10_8,
+						     val0 >> 8);
+			mc_packet_add_force_write_ma(MCI_OUT3_MIX0_7_0, val0);
+			mc_ma_register_set_value(MCI_OUT3_MIX1_10_8, val1 >> 8);
+			mc_ma_register_set_value(MCI_OUT3_MIX1_7_0, val1);
+		} else {
+			mc_packet_add_force_write_ma(MCI_OUT3_MIX0_10_8,
+						     (val0 >> 8) |
+						     MCB_OUT3_MSEP);
+			mc_packet_add_force_write_ma(MCI_OUT3_MIX0_7_0, val0);
+			mc_packet_add_force_write_ma(MCI_OUT3_MIX1_10_8,
+						     val1 >> 8);
+			mc_packet_add_force_write_ma(MCI_OUT3_MIX1_7_0, val1);
+		}
+	}
+}
+
+static inline void add_source(void)
+{
+	struct mcdrv_aec_info aec;
+	u32 hifi_src, src;
+	u8 val, dsf0_preinput, dsf1_preinput, dsf2_preinput;
+
+	add_in_mix_src(MCDRV_DST_AE0, MCI_IN0_MIX0, MCI_IN0_MIX1, MCB_IN0_MSEP);
+	add_in_mix_src(MCDRV_DST_AE1, MCI_IN1_MIX0, MCI_IN1_MIX1, MCB_IN1_MSEP);
+	add_in_mix_src(MCDRV_DST_AE2, MCI_IN2_MIX0, MCI_IN2_MIX1, MCB_IN2_MSEP);
+	add_in_mix_src(MCDRV_DST_AE3, MCI_IN3_MIX0, MCI_IN3_MIX1, MCB_IN3_MSEP);
+
+	add_out_mix_src(MCDRV_DST_MUSICOUT, MCI_OUT0_MIX0_10_8,
+			MCI_OUT0_MIX1_10_8, MCB_OUT0_MSEP);
+	add_out_mix_src(MCDRV_DST_EXTOUT, MCI_OUT1_MIX0_10_8,
+			MCI_OUT1_MIX1_10_8, MCB_OUT1_MSEP);
+	add_out2_mix_src();
+	add_out_mix_src(MCDRV_DST_DAC0, MCI_OUT4_MIX0_10_8, MCI_OUT4_MIX1_10_8,
+			MCB_OUT4_MSEP);
+	add_out_mix_src(MCDRV_DST_DAC1, MCI_OUT5_MIX0_10_8, MCI_OUT5_MIX1_10_8,
+			MCB_OUT5_MSEP);
+
+	mc_aec_info_get(&aec);
+
+	dsf0_preinput = mc_e_register_get_value(MCI_DSF0_PRE_INPUT);
+	dsf1_preinput = mc_e_register_get_value(MCI_DSF1_PRE_INPUT);
+	dsf2_preinput = mc_e_register_get_value(MCI_DSF2_PRE_INPUT);
+
+	hifi_src = mc_source_get(MCDRV_DST_HIFIOUT, MCDRV_DST_CH0);
+
+	if (mc_source_is_used(MCDRV_DST_ADIF0, MCDRV_DST_CH0)
+	    || mc_source_is_used(MCDRV_DST_ADIF0, MCDRV_DST_CH1)) {
+		val = dsf0_preinput;
+		src = mc_source_get(MCDRV_DST_ADIF0, MCDRV_DST_CH0);
+		if (src) {
+			val &= ~0x0f;
+			val |= get_preinput(src);
+		}
+
+		src = mc_source_get(MCDRV_DST_ADIF0, MCDRV_DST_CH1);
+		if (src) {
+			val &= ~0xf0;
+			val |= get_preinput(src) << 4;
+		}
+
+		if (val != dsf0_preinput)
+			mc_packet_add_write_e(MCI_DSF0_PRE_INPUT, val);
+	}
+
+	if (mc_source_is_used(MCDRV_DST_ADIF1, MCDRV_DST_CH0)
+	    || mc_source_is_used(MCDRV_DST_ADIF1, MCDRV_DST_CH1)) {
+		val = dsf1_preinput;
+		src = mc_source_get(MCDRV_DST_ADIF1, MCDRV_DST_CH0);
+		if (src) {
+			val &= ~0x0f;
+			val |= get_preinput(src);
+		}
+
+		src = mc_source_get(MCDRV_DST_ADIF1, MCDRV_DST_CH1);
+		if (src) {
+			val &= ~0xf0;
+			val |= get_preinput(src) << 4;
+		}
+
+		if (val != dsf1_preinput)
+			mc_packet_add_write_e(MCI_DSF1_PRE_INPUT, val);
+	}
+
+	if (mc_source_is_used(MCDRV_DST_ADIF2, MCDRV_DST_CH0)
+	    || mc_source_is_used(MCDRV_DST_ADIF2, MCDRV_DST_CH1)) {
+		src = mc_source_get(MCDRV_DST_ADIF2, MCDRV_DST_CH0);
+		if (src != MCDRV_D2SRC_DAC0REF_ON
+		    && src != MCDRV_D2SRC_DAC1REF_ON) {
+			val = dsf2_preinput;
+			if (src) {
+				val &= ~0x0f;
+				val |= get_preinput(src);
+			}
+
+			src = mc_source_get(MCDRV_DST_ADIF2, MCDRV_DST_CH1);
+			if (src) {
+				val &= ~0xf0;
+				val |= get_preinput(src) << 4;
+			}
+
+			if (val != dsf2_preinput)
+				mc_packet_add_write_e(MCI_DSF2_PRE_INPUT, val);
+		}
+	}
+}
+
+static u8 get_mic_mixer_value(u32 src_on)
+{
+	u8 val = 0;
+
+	if (src_on & MCDRV_ASRC_MIC1_ON)
+		val |= MCB_AD_M1MIX;
+	if (src_on & MCDRV_ASRC_MIC2_ON)
+		val |= MCB_AD_M2MIX;
+	if (src_on & MCDRV_ASRC_MIC3_ON)
+		val |= MCB_AD_M3MIX;
+	if (src_on & MCDRV_ASRC_MIC4_ON)
+		val |= MCB_AD_M4MIX;
+
+	return val;
+}
+
+static inline void add_mixer(void)
+{
+	struct mcdrv_path_info path;
+	u8 val;
+
+	mc_path_info_get(&path);
+
+	val = get_mic_mixer_value(path.adc0[0]);
+	if (path.adc0[0] & MCDRV_ASRC_LINEIN1_L_ON)
+		val |= MCB_AD_LIMIX;
+	if (path.adc0[0] & MCDRV_ASRC_LINEIN1_M_ON)
+		val |= (MCB_MONO_AD_LI | MCB_AD_LIMIX);
+	mc_packet_add_write_ana(MCI_ADL_MIX, val);
+
+	val = get_mic_mixer_value(path.adc0[1]);
+	if (path.adc0[1] & MCDRV_ASRC_LINEIN1_R_ON)
+		val |= MCB_AD_LIMIX;
+	if (path.adc0[1] & MCDRV_ASRC_LINEIN1_M_ON)
+		val |= (MCB_MONO_AD_LI | MCB_AD_LIMIX);
+	mc_packet_add_write_ana(MCI_ADR_MIX, val);
+
+	val = get_mic_mixer_value(path.adc1[0]);
+	if (path.adc1[0] & MCDRV_ASRC_LINEIN1_M_ON)
+		val |= MCB_AD_LIMIX;
+	mc_packet_add_write_ana(MCI_ADM_MIX, val);
+}
+
+void mc_packet_add_path_set(void)
+{
+	u8 val;
+
+	val = mc_if_register_get_value(MCI_RST_A);
+	if (!(val & MCB_RST_A)) {
+		add_di_pad();
+		add_pad();
+		add_source();
+		add_mixer();
+	}
+}
+
+static u8 get_lp2_start(void)
+{
+	struct mcdrv_aec_info aec;
+	struct mcdrv_dio_info dio;
+	u8 start = 0;
+
+	mc_dio_info_get(&dio);
+	mc_aec_info_get(&aec);
+
+	if (mc_source_is_used(MCDRV_DST_VOICEOUT, MCDRV_DST_CH0)) {
+		if (dio.port[2].dio_common.master_slave == MCDRV_DIO_MASTER)
+			start |= MCB_LP2_TIM_START;
+		start |= MCB_LPT2_START_SRC | MCB_LPT2_START;
+	}
+
+	if (mc_source_is_used(MCDRV_DST_VBOXIOIN, MCDRV_DST_CH0)) {
+		if (dio.port[2].dio_common.master_slave == MCDRV_DIO_MASTER)
+			start |= MCB_LP2_TIM_START;
+		start |= MCB_LPR2_START_SRC | MCB_LPR2_START;
+	}
+
+	if (!start) {
+		/* LP2 not running */
+		if (mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH0) ||
+		    mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH1))
+			start |= MCB_LP2_TIM_START | MCB_LPT2_START_SRC |
+			    MCB_LPT2_START;
+
+		if (mc_d1_source_is_used(MCDRV_D1SRC_VBOXOUT_ON))
+			start |= MCB_LP2_TIM_START | MCB_LPR2_START_SRC |
+			    MCB_LPR2_START;
+
+		if (mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH2) ||
+		    mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH3) ||
+		    mc_d1_source_is_used(MCDRV_D1SRC_VBOXREFOUT_ON))
+			if (aec.vbox.src3_ctrl == 1 || aec.vbox.src3_ctrl == 2)
+				start |= MCB_LP2_TIM_START;
+
+		if (mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH0) ||
+		    mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH1) ||
+		    mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH2) ||
+		    mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH3) ||
+		    mc_d1_source_is_used(MCDRV_D1SRC_VBOXOUT_ON) ||
+		    mc_d1_source_is_used(MCDRV_D1SRC_VBOXREFOUT_ON) ||
+		    mc_source_is_used(MCDRV_DST_VBOXHOSTIN, MCDRV_DST_CH0) ||
+		    mc_source_is_used(MCDRV_DST_HOSTOUT, MCDRV_DST_CH0))
+			if (aec.fdsp_locate && aec.vbox.fdsp_on)
+				start |= MCB_LP2_TIM_START;
+	} else {
+		if (mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH0)
+		    || mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH1))
+			start |= MCB_LPT2_START_SRC | MCB_LPT2_START;
+
+		if (mc_d1_source_is_used(MCDRV_D1SRC_VBOXOUT_ON))
+			start |= MCB_LPR2_START_SRC | MCB_LPR2_START;
+
+	}
+
+	if (mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH2) ||
+	    mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH3) ||
+	    mc_d1_source_is_used(MCDRV_D1SRC_VBOXREFOUT_ON))
+		if (aec.vbox.src3_ctrl == 1 || aec.vbox.src3_ctrl == 2)
+			start |= MCB_LPT2_START_SRC | MCB_LPT2_START |
+			    MCB_LPR2_START_SRC | MCB_LPR2_START;
+
+	return start;
+}
+
+static u8 get_lp2_fs(u8 *thru)
+{
+	struct mcdrv_dio_info dio;
+	struct mcdrv_aec_info aec;
+	u8 fs = 0xff;
+
+	mc_dio_info_get(&dio);
+	mc_aec_info_get(&aec);
+
+	*thru = 0xff;
+
+	if (mc_source_is_used(MCDRV_DST_VOICEOUT, MCDRV_DST_CH0) ||
+	    mc_source_is_used(MCDRV_DST_VBOXIOIN, MCDRV_DST_CH0)) {
+		/* LP2 running */
+		*thru = dio.port[2].dio_common.src_thru << 5;
+		fs = dio.port[2].dio_common.fs;
+	} else {
+		if (mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH0) ||
+		    mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH1) ||
+		    mc_d1_source_is_used(MCDRV_D1SRC_VBOXOUT_ON)) {
+			*thru = aec.vbox.src2_thru << 5;
+			fs = aec.vbox.src2_fs;
+		}
+	}
+
+	if (aec.vbox.src3_ctrl == 1) {
+		if (*thru == 0xff) {
+			*thru = aec.vbox.src2_thru << 5;
+			fs = aec.vbox.src2_fs;
+		}
+	}
+
+	return fs;
+}
+
+void mc_packet_add_stop(void)
+{
+	u32 hifi_src, src;
+	u8 val, old, enable;
+
+	val = mc_mb_register_get_value(MCI_LP0_START);
+	old = val;
+	if (!mc_source_is_used(MCDRV_DST_MUSICOUT, MCDRV_DST_CH0)
+	    && !mc_source_is_used(MCDRV_DST_MUSICOUT, MCDRV_DST_CH1))
+		val &= ~(MCB_LPT0_START_SRC | MCB_LPT0_START);
+	if (!mc_d1_source_is_used(MCDRV_D1SRC_MUSICIN_ON))
+		val &= ~(MCB_LPR0_START_SRC | MCB_LPR0_START);
+	if (!(val & 0x0f))
+		val = 0;
+	mc_packet_add_write_mb(MCI_LP0_START, val);
+
+	if (val == 0 && val != old)
+		mc_packet_add_write_a(MCI_LP0_FP, MCDRV_PHYSPORT_NONE);
+
+	val = mc_mb_register_get_value(MCI_LP1_START);
+	old = val;
+	if (!mc_source_is_used(MCDRV_DST_EXTOUT, MCDRV_DST_CH0)
+	    && !mc_source_is_used(MCDRV_DST_EXTOUT, MCDRV_DST_CH1))
+		val &= ~(MCB_LPT1_START_SRC | MCB_LPT1_START);
+	if (!mc_d1_source_is_used(MCDRV_D1SRC_EXTIN_ON))
+		val &= ~(MCB_LPR1_START_SRC | MCB_LPR1_START);
+	if (!(val & 0x0f))
+		val = 0;
+	mc_packet_add_write_mb(MCI_LP1_START, val);
+
+	if (val == 0 && val != old)
+		mc_packet_add_write_a(MCI_LP1_FP, MCDRV_PHYSPORT_NONE);
+
+	old = mc_mb_register_get_value(MCI_LP2_START);
+	val = old & get_lp2_start();
+	mc_packet_add_write_mb(MCI_LP2_START, val);
+
+	if (val == 0 && val != old)
+		mc_packet_add_write_a(MCI_LP2_FP, MCDRV_PHYSPORT_NONE);
+
+	val = mc_mb_register_get_value(MCI_SRC3_START);
+	if (!mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH2)
+	    && !mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH3))
+		val &= ~MCB_OSRC3_START;
+	if (!mc_d1_source_is_used(MCDRV_D1SRC_VBOXREFOUT_ON))
+		val &= ~MCB_ISRC3_START;
+	if (!(val & 0x0f))
+		val = 0;
+	mc_packet_add_write_mb(MCI_SRC3_START, val);
+
+	enable = mc_e_register_get_value(MCI_DIRECTPATH_ENB);
+
+	val = mc_mb_register_get_value(MCI_LP3_START);
+	if (!mc_source_is_used(MCDRV_DST_HIFIOUT, MCDRV_DST_CH0)) {
+		val &= ~MCB_LPT3_START;
+		enable &= ~MCB_DIRECT_ENB_ADC;
+	}
+	if (!mc_d1_source_is_used(MCDRV_D1SRC_HIFIIN_ON)) {
+		val &= ~MCB_LPR3_START;
+		enable &= ~(MCB_DIRECT_ENB_DAC1 | MCB_DIRECT_ENB_DAC0);
+	} else {
+		src = mc_source_get(MCDRV_DST_DAC0, MCDRV_DST_CH0);
+		src |= mc_source_get(MCDRV_DST_DAC0, MCDRV_DST_CH1);
+		if (!(src & MCDRV_D1SRC_HIFIIN_ON))
+			enable &= ~MCB_DIRECT_ENB_DAC0;
+
+		src = mc_source_get(MCDRV_DST_DAC1, MCDRV_DST_CH0);
+		src |= mc_source_get(MCDRV_DST_DAC1, MCDRV_DST_CH1);
+		if (!(src & MCDRV_D1SRC_HIFIIN_ON))
+			enable &= ~MCB_DIRECT_ENB_DAC1;
+	}
+
+	if (!(val & 0x0f))
+		val = 0;
+	mc_packet_add_write_mb(MCI_LP3_START, val);
+
+	if (val == 0) {
+		mc_packet_add_write_e(MCI_DIRECTPATH_ENB, 0);
+		mc_packet_add_write_a(MCI_LP3_FP, MCDRV_PHYSPORT_NONE);
+	} else {
+		if (mc_dev_id_get() != MCDRV_DEV_ID_80_90H)
+			mc_packet_add_write_e(MCI_DIRECTPATH_ENB, enable);
+	}
+
+	/* ADC stop */
+	hifi_src = mc_source_get(MCDRV_DST_HIFIOUT, MCDRV_DST_CH0);
+	if (!mc_source_is_used(MCDRV_DST_ADIF0, MCDRV_DST_CH0)
+	    && !mc_source_is_used(MCDRV_DST_ADIF0, MCDRV_DST_CH1)) {
+		val = mc_e_register_get_value(MCI_DSF0_FLT_TYPE);
+		val &= ~MCB_DSF0ENB;
+		mc_packet_add_write_e(MCI_DSF0_FLT_TYPE, val);
+	}
+
+	if (!mc_source_is_used(MCDRV_DST_ADIF1, MCDRV_DST_CH0)
+	    && !mc_source_is_used(MCDRV_DST_ADIF1, MCDRV_DST_CH1)) {
+		val = mc_e_register_get_value(MCI_DSF1_FLT_TYPE);
+		val &= ~MCB_DSF1ENB;
+		mc_packet_add_write_e(MCI_DSF1_FLT_TYPE, val);
+	}
+
+	if (!mc_source_is_used(MCDRV_DST_ADIF2, MCDRV_DST_CH0)
+	    && !mc_source_is_used(MCDRV_DST_ADIF2, MCDRV_DST_CH1)) {
+		val = mc_e_register_get_value(MCI_DSF2_FLT_TYPE);
+		val &= ~MCB_DSF2ENB;
+		mc_packet_add_write_e(MCI_DSF2_FLT_TYPE, val);
+	}
+
+	/* PDM Stop */
+	val = mc_e_register_get_value(MCI_PDM_LOAD_TIM);
+	if (!mc_d2_source_is_used(MCDRV_D2SRC_PDM0_L_ON)
+	    && !mc_d2_source_is_used(MCDRV_D2SRC_PDM0_R_ON)
+	    && !(hifi_src & (MCDRV_D2SRC_PDM0_L_ON | MCDRV_D2SRC_PDM0_R_ON)))
+		val &= ~MCB_PDM0_START;
+	if (!mc_d2_source_is_used(MCDRV_D2SRC_PDM1_L_ON)
+	    && !mc_d2_source_is_used(MCDRV_D2SRC_PDM1_R_ON)
+	    && !(hifi_src & (MCDRV_D2SRC_PDM1_L_ON | MCDRV_D2SRC_PDM1_R_ON)))
+		val &= ~MCB_PDM1_START;
+	mc_packet_add_write_e(MCI_PDM_LOAD_TIM, val);
+}
+
+static inline u8 get_spath(void)
+{
+	u32 src;
+	u8 val = 0x7f;
+
+	src = mc_source_get(MCDRV_DST_DAC0, MCDRV_DST_CH0);
+	if (src & MCDRV_D1SRC_MUSICIN_ON)
+		val |= MCB_SPATH_ON;
+
+	src = mc_source_get(MCDRV_DST_DAC0, MCDRV_DST_CH1);
+	if (src & MCDRV_D1SRC_MUSICIN_ON)
+		val |= MCB_SPATH_ON;
+
+	src = mc_source_get(MCDRV_DST_MUSICOUT, MCDRV_DST_CH0);
+	if (src & MCDRV_D1SRC_ADIF0_ON)
+		val |= MCB_SPATH_ON;
+
+	src = mc_source_get(MCDRV_DST_MUSICOUT, MCDRV_DST_CH1);
+	if (src & MCDRV_D1SRC_ADIF0_ON)
+		val |= MCB_SPATH_ON;
+
+	if (mc_source_is_used(MCDRV_DST_AE0, MCDRV_DST_CH0)
+	    || mc_source_is_used(MCDRV_DST_AE0, MCDRV_DST_CH1)
+	    || mc_source_is_used(MCDRV_DST_AE1, MCDRV_DST_CH0)
+	    || mc_source_is_used(MCDRV_DST_AE1, MCDRV_DST_CH1)
+	    || mc_source_is_used(MCDRV_DST_AE2, MCDRV_DST_CH0)
+	    || mc_source_is_used(MCDRV_DST_AE2, MCDRV_DST_CH1)
+	    || mc_source_is_used(MCDRV_DST_AE3, MCDRV_DST_CH0)
+	    || mc_source_is_used(MCDRV_DST_AE3, MCDRV_DST_CH1))
+		val &= ~MCB_SPATH_ON;
+	else
+		val &= ~MCB_IN_MIX_ON;
+
+	if (!mc_source_is_used(MCDRV_DST_MUSICOUT, MCDRV_DST_CH0)
+	    && !mc_source_is_used(MCDRV_DST_MUSICOUT, MCDRV_DST_CH1))
+		val &= ~MCB_OUT_MIX_ON_0;
+
+	if (!mc_source_is_used(MCDRV_DST_EXTOUT, MCDRV_DST_CH0)
+	    && !mc_source_is_used(MCDRV_DST_EXTOUT, MCDRV_DST_CH1))
+		val &= ~MCB_OUT_MIX_ON_1;
+	else
+		val &= ~MCB_SPATH_ON;
+
+	if (!mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH0)
+	    && !mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH1))
+		val &= ~MCB_OUT_MIX_ON_2;
+	else
+		val &= ~MCB_SPATH_ON;
+
+	if (!mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH2)
+	    && !mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH3))
+		val &= ~MCB_OUT_MIX_ON_3;
+	else
+		val &= ~MCB_SPATH_ON;
+
+	src = mc_source_get(MCDRV_DST_DAC0, MCDRV_DST_CH0);
+	if (!(src & ~MCDRV_D1SRC_HIFIIN_ON)) {
+		src = mc_source_get(MCDRV_DST_DAC0, MCDRV_DST_CH1);
+		if (!(src & ~MCDRV_D1SRC_HIFIIN_ON))
+			val &= ~MCB_OUT_MIX_ON_4;
+	}
+
+	src = mc_source_get(MCDRV_DST_DAC1, MCDRV_DST_CH0);
+	if (!(src & ~MCDRV_D1SRC_HIFIIN_ON)) {
+		src = mc_source_get(MCDRV_DST_DAC1, MCDRV_DST_CH1);
+		if (!(src & ~MCDRV_D1SRC_HIFIIN_ON))
+			val &= ~MCB_OUT_MIX_ON_5;
+	}
+
+	if (!(val & (MCB_OUT_MIX_ON_4 | MCB_OUT_MIX_ON_0))
+	    || (val & (MCB_IN_MIX_ON | MCB_OUT_MIX_ON_5321)))
+		val &= ~MCB_SPATH_ON;
+
+	if ((val & (MCB_SPATH_ON | MCB_OUT_MIX_ON_0))
+	    == (MCB_SPATH_ON | MCB_OUT_MIX_ON_0)) {
+		src = mc_source_get(MCDRV_DST_MUSICOUT, MCDRV_DST_CH0);
+		src |= mc_source_get(MCDRV_DST_MUSICOUT, MCDRV_DST_CH1);
+		if (src != MCDRV_D1SRC_ADIF0_ON)
+			val &= ~MCB_SPATH_ON;
+	}
+	if ((val & (MCB_SPATH_ON | MCB_OUT_MIX_ON_4))
+	    == (MCB_SPATH_ON | MCB_OUT_MIX_ON_4)) {
+		src = mc_source_get(MCDRV_DST_DAC0, MCDRV_DST_CH0);
+		src |= mc_source_get(MCDRV_DST_DAC0, MCDRV_DST_CH1);
+		if (src != MCDRV_D1SRC_MUSICIN_ON)
+			val &= ~MCB_SPATH_ON;
+	}
+
+	return val;
+}
+
+void mc_packet_add_dsp_start_and_stop(u8 started)
+{
+	struct mcdrv_aec_info aec;
+	struct mcdrv_dio_info dio;
+	struct mcdrv_fdsp_mute mute;
+	enum mc_cdsp_fifo_sel fifo_sel;
+	u8 val, start, e1_cmd, lp2_fs, thru;
+	int i;
+
+	mc_aec_info_get(&aec);
+
+	start = mc_dsp_get_running();
+	if (start & MCDRV_DSP_START_E) {
+		e1_cmd = 0;
+		val = mc_e_register_get_value(MCI_E1COMMAND);
+		if (!mc_source_is_used(MCDRV_DST_DAC1, MCDRV_DST_CH0)
+		    && !mc_source_is_used(MCDRV_DST_DAC1, MCDRV_DST_CH1)
+		    && !mc_source_is_used(MCDRV_DST_ADIF0, MCDRV_DST_CH0)
+		    && !mc_source_is_used(MCDRV_DST_ADIF0, MCDRV_DST_CH1)
+		    && !mc_source_is_used(MCDRV_DST_ADIF1, MCDRV_DST_CH0)
+		    && !mc_source_is_used(MCDRV_DST_ADIF1, MCDRV_DST_CH1)
+		    && !mc_source_is_used(MCDRV_DST_ADIF2, MCDRV_DST_CH0)
+		    && !mc_source_is_used(MCDRV_DST_ADIF2, MCDRV_DST_CH1))
+			e1_cmd = E1COMMAND_PD;
+
+		if (!(started & MCDRV_DSP_START_E)) {
+			mc_packet_add_write_e(MCI_E1DSP_CTRL, 0);
+			e1_cmd |= E1COMMAND_RUN_MODE;
+			mc_packet_add_write_e(MCI_E1COMMAND, e1_cmd);
+
+			mc_edsp_start();
+		} else if ((val & E1COMMAND_PD) != (e1_cmd & E1COMMAND_PD)) {
+			e1_cmd |= E1COMMAND_ADDITIONAL;
+			mc_packet_add_write_e(MCI_E1COMMAND, e1_cmd);
+		}
+	} else if (started & MCDRV_DSP_START_E) {
+		mc_packet_add_force_write_e(MCI_E1COMMAND,
+					    E1COMMAND_SLEEP_MODE);
+		mc_edsp_stop();
+	}
+
+	if (start & MCDRV_DSP_START_B) {
+		if (!(started & MCDRV_DSP_START_B))
+			mc_bdsp_start();
+	} else if (started & MCDRV_DSP_START_B)
+		mc_bdsp_stop();
+
+	if (start & MCDRV_DSP_START_F) {
+		if (!(started & MCDRV_DSP_START_F)) {
+			for (i = 0; i < FDSP_MUTE_NUM; i++) {
+				mute.in_mute[i] = FDSP_MUTE_OFF;
+				mute.out_mute[i] = FDSP_MUTE_OFF;
+			}
+
+			mc_fdsp_start();
+			mc_fdsp_set_mute(&mute);
+		}
+	}
+
+	if (start & MCDRV_DSP_START_C) {
+		if (!mc_source_is_used(MCDRV_DST_VBOXHOSTIN, MCDRV_DST_CH0))
+			fifo_sel = CDSP_FIFO_SEL_PORT;
+		else
+			fifo_sel = CDSP_FIFO_SEL_HOST;
+		mc_cdsp_set_dfifo_sel(fifo_sel);
+
+		if (!mc_source_is_used(MCDRV_DST_HOSTOUT, MCDRV_DST_CH0))
+			fifo_sel = CDSP_FIFO_SEL_PORT;
+		else
+			fifo_sel = CDSP_FIFO_SEL_HOST;
+		mc_cdsp_set_rfifo_sel(fifo_sel);
+
+		if (!(started & MCDRV_DSP_START_C)) {
+			mc_dio_info_get(&dio);
+			lp2_fs = get_lp2_fs(&thru);
+			if (aec.vbox.cdsp_func_a_on) {
+				if (aec.vbox.src3_ctrl == 3
+				    && aec.vbox.cdsp_func_a_on == 0x11)
+					val =
+					    mc_mb_register_get_value(MCI_SRC3);
+				else
+					val = lp2_fs;
+				mc_cdsp_set_fs(CDSP_DECODER, val & 0x0f);
+				mc_cdsp_start(CDSP_DECODER);
+			}
+
+			if (aec.vbox.cdsp_func_b_on) {
+				if (aec.vbox.src3_ctrl == 3
+				    && aec.vbox.cdsp_func_b_on == 0x11)
+					val =
+					    mc_mb_register_get_value(MCI_SRC3);
+				else
+					val = lp2_fs;
+				mc_cdsp_set_fs(CDSP_ENCODER, val & 0x0f);
+				mc_cdsp_start(CDSP_ENCODER);
+			}
+		}
+	} else if (started & MCDRV_DSP_START_C) {
+		if (aec.vbox.cdsp_func_a_on)
+			mc_cdsp_stop(CDSP_DECODER);
+		if (aec.vbox.cdsp_func_b_on)
+			mc_cdsp_stop(CDSP_ENCODER);
+	}
+
+	if (start & MCDRV_DSP_START_M) {
+		mc_packet_add_write_ma(MCI_SPATH_ON, get_spath());
+		if (!(started & MCDRV_DSP_START_M))
+			mc_packet_add_write_ma(MCI_DSP_START, MCB_DSP_START);
+	} else if (started & MCDRV_DSP_START_M)
+		mc_packet_add_write_ma(MCI_SPATH_ON, 0);
+}
+
+void mc_packet_add_fdsp_stop(u8 started)
+{
+	u8 start = mc_dsp_get_running();
+
+	if (!(start & MCDRV_DSP_START_F) && (started & MCDRV_DSP_START_F))
+		mc_fdsp_stop();
+}
+
+static inline void add_di_start(void)
+{
+	struct mcdrv_dio_info dio;
+	struct mcdrv_dio_path_info path_info;
+	struct mcdrv_aec_info aec;
+	enum mcdrv_dev_id id;
+	u8 start, val = 0;
+	u8 thru = 0xff, fs = 0xff;
+
+	id = mc_dev_id_get();
+	mc_dio_info_get(&dio);
+	mc_aec_info_get(&aec);
+	mc_dio_path_info_get(&path_info);
+
+	start = 0;
+	if (mc_source_is_used(MCDRV_DST_MUSICOUT, MCDRV_DST_CH0)
+	    || mc_source_is_used(MCDRV_DST_MUSICOUT, MCDRV_DST_CH1)) {
+		if (dio.port[0].dio_common.master_slave == MCDRV_DIO_MASTER)
+			start |= MCB_LP0_TIM_START;
+		start |= MCB_LPT0_START_SRC | MCB_LPT0_START;
+	}
+
+	if (mc_d1_source_is_used(MCDRV_D1SRC_MUSICIN_ON)) {
+		if (dio.port[0].dio_common.master_slave == MCDRV_DIO_MASTER)
+			start |= MCB_LP0_TIM_START;
+		start |= MCB_LPR0_START_SRC | MCB_LPR0_START;
+	}
+
+	if (start) {
+		mc_packet_add_write_a(MCI_LP0_FP, path_info.phys_port[0]);
+		if (id != MCDRV_DEV_ID_80_90H) {
+			mc_packet_add_write_ma(MCI_LINK_LOCK, MCB_LINK_LOCK);
+			mc_packet_add_write_mb(MCI_T_DPLL_FAST,
+					       MCB_T_DPLL_FAST |
+					       MCB_VOLREL_TIME);
+		}
+		mc_packet_add_write_mb(MCI_LP0_START, start);
+	}
+
+	start = 0;
+	if (mc_source_is_used(MCDRV_DST_EXTOUT, MCDRV_DST_CH0)
+	    || mc_source_is_used(MCDRV_DST_EXTOUT, MCDRV_DST_CH1)) {
+		if (dio.port[1].dio_common.master_slave == MCDRV_DIO_MASTER)
+			start |= MCB_LP1_TIM_START;
+		start |= MCB_LPT1_START_SRC | MCB_LPT1_START;
+	}
+
+	if (mc_d1_source_is_used(MCDRV_D1SRC_EXTIN_ON)) {
+		if (dio.port[1].dio_common.master_slave == MCDRV_DIO_MASTER)
+			start |= MCB_LP1_TIM_START;
+		start |= MCB_LPR1_START_SRC | MCB_LPR1_START;
+	}
+
+	if (start) {
+		mc_packet_add_write_a(MCI_LP1_FP, path_info.phys_port[1]);
+		if (id != MCDRV_DEV_ID_80_90H) {
+			mc_packet_add_write_ma(MCI_LINK_LOCK, MCB_LINK_LOCK);
+			mc_packet_add_write_mb(MCI_T_DPLL_FAST,
+					       MCB_T_DPLL_FAST |
+					       MCB_VOLREL_TIME);
+		}
+		mc_packet_add_write_mb(MCI_LP1_START, start);
+	}
+
+	start = get_lp2_start();
+	if (start) {
+		fs = get_lp2_fs(&thru);
+		if (thru != 0xff) {
+			if (id == MCDRV_DEV_ID_80_90H) {
+				val = mc_mb_register_get_value(MCI_LP2_MODE);
+				if ((val & MCB_LP2_SRC_THRU) != thru) {
+					mc_packet_add_write_mb(MCI_LP2_START,
+							       0);
+					val = (val & ~MCB_LP2_SRC_THRU) | thru;
+					mc_packet_add_write_mb(MCI_LP2_MODE,
+							       val);
+				}
+			}
+
+			val = mc_mb_register_get_value(MCI_LP2_BCK);
+			if ((val & 0x0f) != fs) {
+				mc_packet_add_write_mb(MCI_LP2_START, 0);
+				val = (val & 0xf0) | fs;
+				mc_packet_add_write_mb(MCI_LP2_BCK, val);
+			}
+		}
+		if (mc_source_is_used(MCDRV_DST_VOICEOUT, MCDRV_DST_CH0) ||
+		    mc_source_is_used(MCDRV_DST_VBOXIOIN, MCDRV_DST_CH0))
+			mc_packet_add_write_a(MCI_LP2_FP,
+					      path_info.phys_port[2]);
+		else {
+			/* LP2 not running */
+			val = mc_mb_register_get_value(MCI_LP2_START);
+			if (val)
+				mc_packet_add_write_a(MCI_LP2_FP,
+						      MCDRV_PHYSPORT_NONE);
+		}
+
+		if (id != MCDRV_DEV_ID_80_90H) {
+			mc_packet_add_write_mb(MCI_LP2_START, 0);
+			val = (val & 0xf0) | fs;
+			mc_packet_add_write_mb(MCI_LP2_BCK, val);
+		}
+
+		mc_packet_add_write_mb(MCI_LP2_START, start);
+	}
+
+	start = 0;
+	thru = 0xff;
+	fs = 0xff;
+	if (mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH2)
+	    || mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH3)) {
+		start |= MCB_SRC3_TIM_START | MCB_OSRC3_START;
+		thru = aec.vbox.src3_thru << 5;
+		fs = aec.vbox.src3_fs;
+	}
+
+	if (mc_d1_source_is_used(MCDRV_D1SRC_VBOXREFOUT_ON)) {
+		start |= MCB_SRC3_TIM_START | MCB_ISRC3_START;
+		thru = aec.vbox.src3_thru << 5;
+		fs = aec.vbox.src3_fs;
+	}
+
+	if (start && aec.vbox.src3_ctrl == 3)
+		mc_packet_add_write_mb(MCI_SRC3, (thru << 4) | fs);
+	mc_packet_add_write_mb(MCI_SRC3_START, start);
+
+	start = 0;
+	if (mc_source_is_used(MCDRV_DST_HIFIOUT, MCDRV_DST_CH0))
+		start |= MCB_LP3_TIM_START | MCB_LPT3_START;
+	if (mc_d1_source_is_used(MCDRV_D1SRC_HIFIIN_ON))
+		start |= MCB_LP3_TIM_START | MCB_LPR3_START;
+	if (start) {
+		mc_packet_add_write_a(MCI_LP3_FP, path_info.phys_port[3]);
+		if (id != MCDRV_DEV_ID_80_90H) {
+			mc_packet_add_write_ma(MCI_LINK_LOCK, MCB_LINK_LOCK);
+			mc_packet_add_write_mb(MCI_T_DPLL_FAST,
+					       MCB_T_DPLL_FAST |
+					       MCB_VOLREL_TIME);
+		}
+		mc_packet_add_write_mb(MCI_LP3_START, start);
+	}
+}
+
+void mc_packet_add_start(void)
+{
+	u32 src, hifi_src;
+	u8 val, dsf0, dsf1, dsf2;
+
+	/* DIR*_START, DIT*_START */
+	add_di_start();
+
+	/* ADC Start */
+	dsf0 = mc_e_register_get_value(MCI_DSF0_FLT_TYPE);
+	dsf1 = mc_e_register_get_value(MCI_DSF1_FLT_TYPE);
+	dsf2 = mc_e_register_get_value(MCI_DSF2_FLT_TYPE);
+	hifi_src = mc_source_get(MCDRV_DST_HIFIOUT, MCDRV_DST_CH0);
+
+	if (mc_source_is_used(MCDRV_DST_ADIF0, MCDRV_DST_CH0)
+	    || mc_source_is_used(MCDRV_DST_ADIF0, MCDRV_DST_CH1)) {
+		dsf0 |= MCB_DSF0ENB;
+		val = mc_e_register_get_value(MCI_DSF0_PRE_INPUT);
+		if (val >> 4 == (val & 0x0f)
+		    || !mc_source_is_used(MCDRV_DST_ADIF0, MCDRV_DST_CH1))
+			dsf0 |= MCB_DSF0_MN;
+		else
+			dsf0 &= ~MCB_DSF0_MN;
+	}
+	mc_packet_add_write_e(MCI_DSF0_FLT_TYPE, dsf0);
+
+	if (mc_source_is_used(MCDRV_DST_ADIF1, MCDRV_DST_CH0)
+	    || mc_source_is_used(MCDRV_DST_ADIF1, MCDRV_DST_CH1)) {
+		dsf1 |= MCB_DSF1ENB;
+		val = mc_e_register_get_value(MCI_DSF1_PRE_INPUT);
+		if (val >> 4 == (val & 0x0f)
+		    || !mc_source_is_used(MCDRV_DST_ADIF1, MCDRV_DST_CH1))
+			dsf1 |= MCB_DSF1_MN;
+		else
+			dsf1 &= ~MCB_DSF1_MN;
+	}
+	mc_packet_add_write_e(MCI_DSF1_FLT_TYPE, dsf1);
+
+	if (mc_source_is_used(MCDRV_DST_ADIF2, MCDRV_DST_CH0)
+	    || mc_source_is_used(MCDRV_DST_ADIF2, MCDRV_DST_CH1)) {
+		dsf2 |= MCB_DSF2ENB;
+		src = mc_source_get(MCDRV_DST_ADIF2, MCDRV_DST_CH0);
+		if (src == MCDRV_D2SRC_DAC0REF_ON) {
+			dsf2 |= MCB_DSF2REFBACK;
+			dsf2 &= ~(MCB_DSF2REFSEL | MCB_DSF2_MN);
+		} else if (src == MCDRV_D2SRC_DAC1REF_ON) {
+			dsf2 |= MCB_DSF2REFBACK | MCB_DSF2REFSEL;
+			dsf2 &= ~MCB_DSF2_MN;
+		} else {
+			dsf2 &= ~MCB_DSF2REFBACK;
+			val = mc_e_register_get_value(MCI_DSF2_PRE_INPUT);
+			if (val >> 4 == (val & 0x0f)
+			    || !mc_source_is_used(MCDRV_DST_ADIF2,
+						  MCDRV_DST_CH1))
+				dsf2 |= MCB_DSF2_MN;
+			else
+				dsf2 &= ~MCB_DSF2_MN;
+		}
+	}
+	mc_packet_add_write_e(MCI_DSF2_FLT_TYPE, dsf2);
+
+	if (mc_dev_id_get() == MCDRV_DEV_ID_80_90H) {
+		if (mc_d1_source_is_used(MCDRV_D1SRC_HIFIIN_ON) ||
+		    mc_source_is_used(MCDRV_DST_HIFIOUT, MCDRV_DST_CH0))
+			mc_packet_add_write_e(MCI_DIRECTPATH_ENB,
+					      MCB_DIRECTPATH_ENB);
+	} else {
+		val = 0;
+		if (mc_source_is_used(MCDRV_DST_HIFIOUT, MCDRV_DST_CH0))
+			val |= MCB_DIRECT_ENB_ADC;
+
+		src = mc_source_get(MCDRV_DST_DAC0, MCDRV_DST_CH0);
+		src |= mc_source_get(MCDRV_DST_DAC0, MCDRV_DST_CH1);
+		if (src & MCDRV_D1SRC_HIFIIN_ON)
+			val |= MCB_DIRECT_ENB_DAC0;
+
+		src = mc_source_get(MCDRV_DST_DAC1, MCDRV_DST_CH0);
+		src |= mc_source_get(MCDRV_DST_DAC1, MCDRV_DST_CH1);
+		if (src & MCDRV_D1SRC_HIFIIN_ON)
+			val |= MCB_DIRECT_ENB_DAC1;
+		mc_packet_add_write_e(MCI_DIRECTPATH_ENB, val);
+	}
+
+	/* PDM Start */
+	val = mc_e_register_get_value(MCI_PDM_LOAD_TIM);
+	if (mc_d2_source_is_used(MCDRV_D2SRC_PDM0_L_ON)
+	    || mc_d2_source_is_used(MCDRV_D2SRC_PDM0_R_ON)
+	    || (hifi_src & (MCDRV_D2SRC_PDM0_L_ON | MCDRV_D2SRC_PDM0_R_ON)))
+		val |= MCB_PDM0_START;
+	if (mc_d2_source_is_used(MCDRV_D2SRC_PDM1_L_ON)
+	    || mc_d2_source_is_used(MCDRV_D2SRC_PDM1_R_ON)
+	    || (hifi_src & (MCDRV_D2SRC_PDM1_L_ON | MCDRV_D2SRC_PDM1_R_ON)))
+		val |= MCB_PDM1_START;
+	mc_packet_add_write_e(MCI_PDM_LOAD_TIM, val);
+}
+
+static void add_digital_volume(u8 vol_l, u8 vol_r, u32 reg_type, u8 vol_l_addr,
+			       u8 vsep, u8 vol_r_addr,
+			       enum mcdrv_volume_mode mode)
+{
+	u8 val_l, val_r;
+
+	val_l = mc_register_get_value(reg_type, vol_l_addr);
+	val_l &= ~vsep;
+	val_r = mc_register_get_value(reg_type, vol_r_addr);
+
+	if (mode == MCDRV_VOLUME_MUTE) {
+		if (vol_l != MCDRV_REG_MUTE)
+			vol_l = val_l;
+		if (vol_r != MCDRV_REG_MUTE)
+			vol_r = val_r;
+	}
+
+	if (vol_l == vol_r) {
+		if ((vol_l != val_l || vol_r != val_r)
+		    && (mode != MCDRV_VOLUME_MUTE || vol_l == MCDRV_REG_MUTE)) {
+			mc_packet_add_force_write(reg_type | vol_l_addr, vol_l);
+			mc_register_set_value(reg_type, vol_r_addr, vol_r);
+		}
+		return;
+	}
+
+	if (mode == MCDRV_VOLUME_MUTE) {
+		if (vol_l == MCDRV_REG_MUTE && vol_l != val_l) {
+			vol_l |= vsep;
+			mc_packet_add_force_write(reg_type | vol_l_addr, vol_l);
+			mc_packet_add_force_write(reg_type | vol_r_addr, val_r);
+		} else if (vol_r == MCDRV_REG_MUTE && vol_r != val_r) {
+			val_l |= vsep;
+			mc_packet_add_force_write(reg_type | vol_l_addr, val_l);
+			mc_packet_add_write(reg_type | vol_r_addr, vol_r);
+		}
+		return;
+	}
+
+	if (vol_l == val_l) {
+		if (vol_r != val_r) {
+			val_l |= vsep;
+			mc_packet_add_force_write(reg_type | vol_l_addr, val_l);
+			mc_packet_add_write(reg_type | vol_r_addr, vol_r);
+		}
+	} else {
+		vol_l |= vsep;
+		mc_packet_add_write(reg_type | vol_l_addr, vol_l);
+		mc_packet_add_force_write(reg_type | vol_r_addr, vol_r);
+	}
+}
+
+void mc_packet_add_volume(u32 update, enum mcdrv_volume_mode mode, u32 *status)
+{
+	struct mcdrv_dev_info info;
+	struct mcdrv_vol_info vol_info;
+	u8 val_l, val_r;
+	u8 vol_l, vol_r;
+
+	mc_dev_info_get(&info);
+	mc_volume_info_get(&vol_info);
+
+	if (update & MCDRV_VOLUPDATE_ANA_IN) {
+		vol_l = vol_info.a_line_in1[0];
+		vol_r = vol_info.a_line_in1[1];
+
+		val_l = mc_ana_register_get_value(MCI_LIVOL_L);
+		val_l &= ~MCB_ALAT_LI;
+		val_r = mc_ana_register_get_value(MCI_LIVOL_R);
+		if (vol_l != val_l
+		    && (mode != MCDRV_VOLUME_MUTE || vol_l == MCDRV_REG_MUTE)) {
+			if (vol_r != val_r
+			    && (mode != MCDRV_VOLUME_MUTE
+				|| vol_r == MCDRV_REG_MUTE))
+				vol_l |= MCB_ALAT_LI;
+			mc_packet_add_write_ana(MCI_LIVOL_L, vol_l);
+		}
+
+		if (vol_r != val_r
+		    && (mode != MCDRV_VOLUME_MUTE || vol_r == MCDRV_REG_MUTE))
+			mc_packet_add_write_ana(MCI_LIVOL_R, vol_r);
+
+		vol_l = vol_info.a_mic1[0];
+		val_l = mc_ana_register_get_value(MCI_MC1VOL);
+		if (vol_l != val_l
+		    && (mode != MCDRV_VOLUME_MUTE || vol_l == MCDRV_REG_MUTE))
+			mc_packet_add_write_ana(MCI_MC1VOL, vol_l);
+
+		vol_l = vol_info.a_mic2[0];
+		val_l = mc_ana_register_get_value(MCI_MC2VOL);
+		if (vol_l != val_l
+		    && (mode != MCDRV_VOLUME_MUTE || vol_l == MCDRV_REG_MUTE))
+			mc_packet_add_write_ana(MCI_MC2VOL, vol_l);
+
+		vol_l = vol_info.a_mic3[0];
+		val_l = mc_ana_register_get_value(MCI_MC3VOL);
+		if (vol_l != val_l
+		    && (mode != MCDRV_VOLUME_MUTE || vol_l == MCDRV_REG_MUTE))
+			mc_packet_add_write_ana(MCI_MC3VOL, vol_l);
+
+		vol_l = vol_info.a_mic4[0];
+		val_l = mc_ana_register_get_value(MCI_MC4VOL);
+		if (vol_l != val_l
+		    && (mode != MCDRV_VOLUME_MUTE || vol_l == MCDRV_REG_MUTE))
+			mc_packet_add_write_ana(MCI_MC4VOL, vol_l);
+	}
+
+	if (update & MCDRV_VOLUPDATE_DIN0)
+		add_digital_volume(vol_info.d_music_in[0] & ~MCB_DIFI0_VSEP,
+				   vol_info.d_music_in[1],
+				   MCDRV_PACKET_REGTYPE_MA,
+				   MCI_DIFI0_VOL0,
+				   MCB_DIFI0_VSEP, MCI_DIFI0_VOL1, mode);
+
+	if (update & MCDRV_VOLUPDATE_DIN1)
+		add_digital_volume(vol_info.d_ext_in[0] & ~MCB_DIFI1_VSEP,
+				   vol_info.d_ext_in[1],
+				   MCDRV_PACKET_REGTYPE_MA,
+				   MCI_DIFI1_VOL0,
+				   MCB_DIFI1_VSEP, MCI_DIFI1_VOL1, mode);
+	if (update & MCDRV_VOLUPDATE_DIN2)
+		add_digital_volume(vol_info.d_voice_in[0] & ~MCB_DIFI2_VSEP,
+				   vol_info.d_voice_in[1],
+				   MCDRV_PACKET_REGTYPE_MA,
+				   MCI_DIFI2_VOL0,
+				   MCB_DIFI2_VSEP, MCI_DIFI2_VOL1, mode);
+	if (update & MCDRV_VOLUPDATE_DIN3)
+		add_digital_volume(vol_info.d_ref_in[0] & ~MCB_DIFI3_VSEP,
+				   vol_info.d_ref_in[1],
+				   MCDRV_PACKET_REGTYPE_MA,
+				   MCI_DIFI3_VOL0,
+				   MCB_DIFI3_VSEP, MCI_DIFI3_VOL1, mode);
+	if (update & MCDRV_VOLUPDATE_ADIF0)
+		add_digital_volume(vol_info.d_adif0_in[0] & ~MCB_ADI0_VSEP,
+				   vol_info.d_adif0_in[1],
+				   MCDRV_PACKET_REGTYPE_MA,
+				   MCI_ADI0_VOL0,
+				   MCB_ADI0_VSEP, MCI_ADI0_VOL1, mode);
+	if (update & MCDRV_VOLUPDATE_ADIF1)
+		add_digital_volume(vol_info.d_adif1_in[0] & ~MCB_ADI1_VSEP,
+				   vol_info.d_adif1_in[1],
+				   MCDRV_PACKET_REGTYPE_MA,
+				   MCI_ADI1_VOL0,
+				   MCB_ADI1_VSEP, MCI_ADI1_VOL1, mode);
+	if (update & MCDRV_VOLUPDATE_ADIF2)
+		add_digital_volume(vol_info.d_adif2_in[0] & ~MCB_ADI2_VSEP,
+				   vol_info.d_adif2_in[1],
+				   MCDRV_PACKET_REGTYPE_MA,
+				   MCI_ADI2_VOL0,
+				   MCB_ADI2_VSEP, MCI_ADI2_VOL1, mode);
+	if (update & MCDRV_VOLUPDATE_DOUT0)
+		add_digital_volume(vol_info.d_music_out[0] & ~MCB_DIFO0_VSEP,
+				   vol_info.d_music_out[1],
+				   MCDRV_PACKET_REGTYPE_MA,
+				   MCI_DIFO0_VOL0,
+				   MCB_DIFO0_VSEP, MCI_DIFO0_VOL1, mode);
+	if (update & MCDRV_VOLUPDATE_DOUT1)
+		add_digital_volume(vol_info.d_ext_out[0] & ~MCB_DIFO1_VSEP,
+				   vol_info.d_ext_out[1],
+				   MCDRV_PACKET_REGTYPE_MA,
+				   MCI_DIFO1_VOL0,
+				   MCB_DIFO1_VSEP, MCI_DIFO1_VOL1, mode);
+	if (update & MCDRV_VOLUPDATE_DOUT2)
+		add_digital_volume(vol_info.d_voice_out[0] & ~MCB_DIFO2_VSEP,
+				   vol_info.d_voice_out[1],
+				   MCDRV_PACKET_REGTYPE_MA,
+				   MCI_DIFO2_VOL0,
+				   MCB_DIFO2_VSEP, MCI_DIFO2_VOL1, mode);
+	if (update & MCDRV_VOLUPDATE_DOUT3)
+		add_digital_volume(vol_info.d_ref_out[0] & ~MCB_DIFO3_VSEP,
+				   vol_info.d_ref_out[1],
+				   MCDRV_PACKET_REGTYPE_MA,
+				   MCI_DIFO3_VOL0,
+				   MCB_DIFO3_VSEP, MCI_DIFO3_VOL1, mode);
+	if (update & MCDRV_VOLUPDATE_DAC0)
+		add_digital_volume(vol_info.d_dac0_out[0] & ~MCB_DAO0_VSEP,
+				   vol_info.d_dac0_out[1],
+				   MCDRV_PACKET_REGTYPE_MA,
+				   MCI_DAO0_VOL0,
+				   MCB_DAO0_VSEP, MCI_DAO0_VOL1, mode);
+	if (update & MCDRV_VOLUPDATE_DAC1)
+		add_digital_volume(vol_info.d_dac1_out[0] & ~MCB_DAO1_VSEP,
+				   vol_info.d_dac1_out[1],
+				   MCDRV_PACKET_REGTYPE_MA,
+				   MCI_DAO1_VOL0,
+				   MCB_DAO1_VSEP, MCI_DAO1_VOL1, mode);
+	if (update & MCDRV_VOLUPDATE_DPATHDA)
+		add_digital_volume(vol_info.d_dpath_da[0] & ~MCB_DPATH_DA_VSEP,
+				   vol_info.d_dpath_da[1],
+				   MCDRV_PACKET_REGTYPE_E,
+				   MCI_DPATH_DA_VOL_L,
+				   MCB_DPATH_DA_VSEP, MCI_DPATH_DA_VOL_R, mode);
+	if (update & MCDRV_VOLUPDATE_DIN)
+		add_digital_volume(vol_info.d_dpath_ad[0] & ~MCB_DPATH_AD_VSEP,
+				   vol_info.d_dpath_ad[1],
+				   MCDRV_PACKET_REGTYPE_E,
+				   MCI_DPATH_AD_VOL_L,
+				   MCB_DPATH_AD_VSEP, MCI_DPATH_AD_VOL_R, mode);
+
+	if ((update & MCDRV_VOLUPDATE_ANA_OUT) && status != NULL) {
+		*status = 0;
+
+		vol_l = vol_info.a_hp[0];
+		vol_r = vol_info.a_hp[1];
+
+		val_l = mc_ana_register_get_value(MCI_HPVOL_L);
+		val_l &= ~MCB_ALAT_HP;
+		val_r = mc_ana_register_get_value(MCI_HPVOL_R);
+		if (vol_l != val_l
+		    && (mode != MCDRV_VOLUME_MUTE || vol_l == MCDRV_REG_MUTE)) {
+			if (vol_r != val_r
+			    && (mode != MCDRV_VOLUME_MUTE
+				|| vol_r == MCDRV_REG_MUTE))
+				vol_l |= MCB_ALAT_HP;
+
+			mc_packet_add_write_ana(MCI_HPVOL_L, vol_l);
+
+			if (vol_l == MCDRV_REG_MUTE)
+				*status |= MCB_HPL_BUSY << 8;
+		}
+
+		if (vol_r != val_r
+		    && (mode != MCDRV_VOLUME_MUTE || vol_r == MCDRV_REG_MUTE)) {
+			mc_packet_add_write_ana(MCI_HPVOL_R, vol_r);
+			if (vol_r == MCDRV_REG_MUTE)
+				*status |= MCB_HPR_BUSY << 8;
+		}
+
+		vol_l = vol_info.a_sp[0];
+		vol_r = vol_info.a_sp[1];
+
+		val_l = mc_ana_register_get_value(MCI_SPVOL_L);
+		val_l &= ~MCB_ALAT_SP;
+		val_r = mc_ana_register_get_value(MCI_SPVOL_R);
+		if (vol_l != val_l
+		    && (mode != MCDRV_VOLUME_MUTE || vol_l == MCDRV_REG_MUTE)) {
+			if (vol_r != val_r
+			    && (mode != MCDRV_VOLUME_MUTE
+				|| vol_r == MCDRV_REG_MUTE))
+				vol_l |= MCB_ALAT_SP;
+
+			mc_packet_add_write_ana(MCI_SPVOL_L, vol_l);
+
+			if (vol_l == MCDRV_REG_MUTE)
+				*status |= MCB_SPL_BUSY << 8;
+		}
+		if (vol_r != val_r
+		    && (mode != MCDRV_VOLUME_MUTE || vol_r == MCDRV_REG_MUTE)) {
+			mc_packet_add_write_ana(MCI_SPVOL_R, vol_r);
+			if (vol_r == MCDRV_REG_MUTE)
+				*status |= MCB_SPR_BUSY << 8;
+		}
+
+		vol_l = vol_info.a_rc[0];
+		val_l = mc_ana_register_get_value(MCI_RCVOL);
+		if (vol_l != val_l
+		    && (mode != MCDRV_VOLUME_MUTE || vol_l == MCDRV_REG_MUTE)) {
+			mc_packet_add_write_ana(MCI_RCVOL, vol_l);
+			if (vol_l == MCDRV_REG_MUTE)
+				*status |= MCB_RC_BUSY;
+		}
+
+		vol_l = vol_info.a_line_out1[0];
+		vol_r = vol_info.a_line_out1[1];
+		val_l = mc_ana_register_get_value(MCI_LO1VOL_L);
+		val_l &= ~MCB_ALAT_LO1;
+		val_r = mc_ana_register_get_value(MCI_LO1VOL_R);
+		if (vol_l != val_l
+		    && (mode != MCDRV_VOLUME_MUTE || vol_l == MCDRV_REG_MUTE)) {
+			if (vol_r != val_r
+			    && (mode != MCDRV_VOLUME_MUTE
+				|| vol_r == MCDRV_REG_MUTE))
+				vol_l |= MCB_ALAT_LO1;
+
+			mc_packet_add_write_ana(MCI_LO1VOL_L, vol_l);
+
+			if (vol_l == MCDRV_REG_MUTE)
+				*status |= MCB_LO1L_BUSY;
+		}
+
+		if (vol_r != val_r
+		    && (mode != MCDRV_VOLUME_MUTE || vol_r == MCDRV_REG_MUTE)) {
+			mc_packet_add_write_ana(MCI_LO1VOL_R, vol_r);
+			if (vol_r == MCDRV_REG_MUTE)
+				*status |= MCB_LO1R_BUSY;
+		}
+
+		vol_l = vol_info.a_line_out2[0];
+		vol_r = vol_info.a_line_out2[1];
+		val_l = mc_ana_register_get_value(MCI_LO2VOL_L);
+		val_l &= ~MCB_ALAT_LO2;
+		val_r = mc_ana_register_get_value(MCI_LO2VOL_R);
+		if (vol_l != val_l
+		    && (mode != MCDRV_VOLUME_MUTE || vol_l == MCDRV_REG_MUTE)) {
+			if (vol_r != val_r
+			    && (mode != MCDRV_VOLUME_MUTE
+				|| vol_r == MCDRV_REG_MUTE))
+				vol_l |= MCB_ALAT_LO2;
+
+			mc_packet_add_write_ana(MCI_LO2VOL_L, vol_l);
+
+			if (vol_l == MCDRV_REG_MUTE)
+				*status |= MCB_LO2L_BUSY;
+		}
+
+		if (vol_r != val_r
+		    && (mode != MCDRV_VOLUME_MUTE || vol_r == MCDRV_REG_MUTE)) {
+			mc_packet_add_write_ana(MCI_LO2VOL_R, vol_r);
+			if (vol_r == MCDRV_REG_MUTE)
+				*status |= MCB_LO2R_BUSY;
+		}
+
+		if (mc_dev_id_get() == MCDRV_DEV_ID_80_90H) {
+			vol_l = vol_info.a_hp_det[0];
+			val_l = mc_ana_register_get_value(MCI_HPDETVOL);
+			if (vol_l != val_l
+			    && (mode != MCDRV_VOLUME_MUTE
+				|| vol_l == MCDRV_REG_MUTE))
+				mc_packet_add_write_ana(MCI_HPDETVOL, vol_l);
+		}
+	}
+}
+
+void mc_packet_add_dac0_mute(void)
+{
+	mc_packet_add_write_ana(MCI_HPVOL_L, MCDRV_REG_MUTE);
+	mc_packet_add_write_ana(MCI_HPVOL_R, MCDRV_REG_MUTE);
+	mc_packet_add_write_ana(MCI_RCVOL, MCDRV_REG_MUTE);
+	mc_packet_add_write_ana(MCI_LO1VOL_L, MCDRV_REG_MUTE);
+	mc_packet_add_write_ana(MCI_LO1VOL_R, MCDRV_REG_MUTE);
+}
+
+void mc_packet_add_dac1_mute(void)
+{
+	mc_packet_add_write_ana(MCI_SPVOL_L, MCDRV_REG_MUTE);
+	mc_packet_add_write_ana(MCI_SPVOL_R, MCDRV_REG_MUTE);
+	mc_packet_add_write_ana(MCI_LO2VOL_L, MCDRV_REG_MUTE);
+	mc_packet_add_write_ana(MCI_LO2VOL_R, MCDRV_REG_MUTE);
+}
+
+void mc_packet_add_dout_mute(void)
+{
+	mc_packet_add_write_ma(MCI_DIFO0_VOL0, MCDRV_REG_MUTE);
+	mc_packet_add_write_ma(MCI_DIFO0_VOL1, MCDRV_REG_MUTE);
+	mc_packet_add_write_ma(MCI_DIFO1_VOL0, MCDRV_REG_MUTE);
+	mc_packet_add_write_ma(MCI_DIFO1_VOL1, MCDRV_REG_MUTE);
+	mc_packet_add_write_ma(MCI_DIFO2_VOL0, MCDRV_REG_MUTE);
+	mc_packet_add_write_ma(MCI_DIFO2_VOL1, MCDRV_REG_MUTE);
+	mc_packet_add_write_ma(MCI_DIFO3_VOL0, MCDRV_REG_MUTE);
+	mc_packet_add_write_ma(MCI_DIFO3_VOL1, MCDRV_REG_MUTE);
+	mc_packet_add_write_ma(MCI_DAO0_VOL0, MCDRV_REG_MUTE);
+	mc_packet_add_write_ma(MCI_DAO0_VOL1, MCDRV_REG_MUTE);
+	mc_packet_add_write_ma(MCI_DAO1_VOL0, MCDRV_REG_MUTE);
+	mc_packet_add_write_ma(MCI_DAO1_VOL1, MCDRV_REG_MUTE);
+}
+
+void mc_packet_add_adif_mute(void)
+{
+	mc_packet_add_write_ma(MCI_ADI0_VOL0, MCDRV_REG_MUTE);
+	mc_packet_add_write_ma(MCI_ADI0_VOL1, MCDRV_REG_MUTE);
+	mc_packet_add_write_ma(MCI_ADI1_VOL0, MCDRV_REG_MUTE);
+	mc_packet_add_write_ma(MCI_ADI1_VOL1, MCDRV_REG_MUTE);
+	mc_packet_add_write_ma(MCI_ADI2_VOL0, MCDRV_REG_MUTE);
+	mc_packet_add_write_ma(MCI_ADI2_VOL1, MCDRV_REG_MUTE);
+}
+
+void mc_packet_add_dpath_da_mute(void)
+{
+	mc_packet_add_write_e(MCI_DPATH_DA_VOL_L, MCDRV_REG_MUTE);
+	mc_packet_add_write_e(MCI_DPATH_DA_VOL_R, MCDRV_REG_MUTE);
+}
+
+static void add_dio_common(enum dio_port port)
+{
+	struct mcdrv_dio_info dio;
+	u8 val, offset;
+
+	mc_dio_info_get(&dio);
+
+	if (port == DIO_0)
+		offset = 0;
+	else if (port == DIO_1)
+		offset = MCI_LP1_MODE - MCI_LP0_MODE;
+	else if (port == DIO_2)
+		offset = MCI_LP2_MODE - MCI_LP0_MODE;
+	else
+		return;
+
+	val = mc_mb_register_get_value(MCI_LP0_MODE + offset);
+	val = (val & 0x0c)
+	    | dio.port[port].dit.st_mode << 7
+	    | dio.port[port].dio_common.auto_fs << 6
+	    | dio.port[port].dit.edge << 4;
+	if (dio.port[port].dio_common.master_slave == MCDRV_DIO_MASTER
+	    && dio.port[port].dio_common.fs == MCDRV_FS_48000) {
+		if (mc_dev_id_get() == MCDRV_DEV_ID_80_90H)
+			val |= dio.port[port].dio_common.src_thru << 5;
+	}
+
+	val |= dio.port[port].dio_common.interface;
+	mc_packet_add_write_mb(MCI_LP0_MODE + offset, val);
+
+	val = dio.port[port].dio_common.bck_fs << 4
+	    | dio.port[port].dio_common.fs;
+	mc_packet_add_write_mb(MCI_LP0_BCK + offset, val);
+
+	if (dio.port[port].dio_common.interface == MCDRV_DIO_PCM) {
+		val = dio.port[port].dio_common.pcm_hiz_transition << 7
+		    | dio.port[port].dio_common.pcm_frame << 5
+		    | dio.port[port].dio_common.pcm_high_period;
+		mc_packet_add_write_mb(MCI_LP0_PCM + offset, val);
+	}
+}
+
+static void add_dio_dir(enum dio_port port)
+{
+	struct mcdrv_dio_info dio;
+	u8 val, offset;
+
+	mc_dio_info_get(&dio);
+
+	if (port == DIO_0)
+		offset = 0;
+	else if (port == DIO_1)
+		offset = MCI_LP1_MODE - MCI_LP0_MODE;
+	else if (port == DIO_2)
+		offset = MCI_LP2_MODE - MCI_LP0_MODE;
+	else
+		return;
+
+	if (dio.port[port].dio_common.interface == MCDRV_DIO_DA) {
+		val = dio.port[port].dit.da_format.mode << 6
+		    | dio.port[port].dit.da_format.bit_sel << 4
+		    | dio.port[port].dir.da_format.mode << 2
+		    | dio.port[port].dir.da_format.bit_sel;
+		mc_packet_add_write_mb(MCI_LP0_FMT + offset, val);
+	} else {
+		val = dio.port[port].dir.pcm_format.mono << 7
+		    | dio.port[port].dir.pcm_format.order << 4
+		    | dio.port[port].dir.pcm_format.law << 2
+		    | dio.port[port].dir.pcm_format.bit_sel;
+		mc_packet_add_write_mb(MCI_LPR0_PCM + offset, val);
+	}
+}
+
+static void add_dio_dit(enum dio_port port)
+{
+	struct mcdrv_dio_info dio;
+	u8 val, offset;
+
+	mc_dio_info_get(&dio);
+
+	if (port == DIO_0)
+		offset = 0;
+	else if (port == DIO_1)
+		offset = MCI_LP1_MODE - MCI_LP0_MODE;
+	else if (port == DIO_2)
+		offset = MCI_LP2_MODE - MCI_LP0_MODE;
+	else
+		return;
+
+	if (dio.port[port].dio_common.interface == MCDRV_DIO_DA) {
+		val = dio.port[port].dit.da_format.mode << 6
+		    | dio.port[port].dit.da_format.bit_sel << 4
+		    | dio.port[port].dir.da_format.mode << 2
+		    | dio.port[port].dir.da_format.bit_sel;
+		mc_packet_add_write_mb(MCI_LP0_FMT + offset, val);
+	} else {
+		val = dio.port[port].dit.pcm_format.mono << 7
+		    | dio.port[port].dit.pcm_format.order << 4
+		    | dio.port[port].dit.pcm_format.law << 2
+		    | dio.port[port].dit.pcm_format.bit_sel;
+		mc_packet_add_write_mb(MCI_LPT0_PCM + offset, val);
+	}
+}
+
+void mc_packet_add_digital_io(u32 update)
+{
+	struct mcdrv_aec_info aec;
+	struct mcdrv_dev_info dev;
+	struct mcdrv_dio_info dio;
+	u8 val, lport;
+
+	mc_dev_info_get(&dev);
+	mc_aec_info_get(&aec);
+
+	val = mc_if_register_get_value(MCI_RST);
+	if (val & (MCB_PSW_M | MCB_RST_M))
+		return;
+
+	val = mc_a_register_get_value(MCI_PD);
+	if (val & MCB_PM_CLK_PD)
+		return;
+
+	mc_dio_info_get(&dio);
+	val = mc_a_register_get_value(MCI_DO0_DRV);
+	lport = get_logical_port(MCDRV_PHYSPORT_DIO0);
+	if (lport <= 3) {
+		if (dio.port[lport].dio_common.bck_invert == MCDRV_BCLK_INVERT)
+			val |= MCB_BCLK0_INV;
+		else
+			val &= ~MCB_BCLK0_INV;
+	}
+	if (dev.power_mode != MCDRV_POWMODE_CDSPDEBUG
+	    && aec.vbox.cdsp_jtag_on != 1)
+		mc_packet_add_write_a(MCI_DO0_DRV, val);
+
+	val = mc_a_register_get_value(MCI_DO1_DRV);
+	lport = get_logical_port(MCDRV_PHYSPORT_DIO1);
+	if (lport <= 3) {
+		if (dio.port[lport].dio_common.bck_invert == MCDRV_BCLK_INVERT)
+			val |= MCB_BCLK1_INV;
+		else
+			val &= ~MCB_BCLK1_INV;
+	}
+	if (dev.power_mode != MCDRV_POWMODE_CDSPDEBUG
+	    && aec.vbox.cdsp_jtag_on != 1)
+		mc_packet_add_write_a(MCI_DO1_DRV, val);
+
+	lport = get_logical_port(MCDRV_PHYSPORT_DIO2);
+	if (lport <= 3) {
+		if (dio.port[lport].dio_common.bck_invert == MCDRV_BCLK_INVERT)
+			val |= MCB_BCLK2_INV;
+		else
+			val &= ~MCB_BCLK2_INV;
+	}
+	mc_packet_add_write_a(MCI_DO2_DRV, val);
+
+	if (update & MCDRV_MUSIC_COM_UPDATE_FLAG)
+		add_dio_common(DIO_0);
+
+	if (update & MCDRV_MUSIC_DIR_UPDATE_FLAG)
+		add_dio_dir(DIO_0);
+
+	if (update & MCDRV_MUSIC_DIT_UPDATE_FLAG)
+		add_dio_dit(DIO_0);
+
+	if (update & MCDRV_EXT_COM_UPDATE_FLAG)
+		add_dio_common(DIO_1);
+
+	if (update & MCDRV_EXT_DIR_UPDATE_FLAG)
+		add_dio_dir(DIO_1);
+
+	if (update & MCDRV_EXT_DIT_UPDATE_FLAG)
+		add_dio_dit(DIO_1);
+
+	if (update & MCDRV_VOICE_COM_UPDATE_FLAG)
+		add_dio_common(DIO_2);
+
+	if (update & MCDRV_VOICE_DIR_UPDATE_FLAG)
+		add_dio_dir(DIO_2);
+
+	if (update & MCDRV_VOICE_DIT_UPDATE_FLAG)
+		add_dio_dit(DIO_2);
+
+	if ((update & MCDRV_HIFI_DIR_UPDATE_FLAG)
+	    || (update & MCDRV_HIFI_DIT_UPDATE_FLAG)) {
+		val = dio.port[DIO_3].dit.st_mode << 7
+		    | dio.port[DIO_3].dit.edge << 4;
+		mc_packet_add_write_mb(MCI_LPT3_STMODE, val);
+	}
+
+	if (update & MCDRV_HIFI_COM_UPDATE_FLAG) {
+		val = dio.port[DIO_3].dio_common.bck_fs << 4
+		    | dio.port[DIO_3].dio_common.fs;
+		mc_packet_add_write_mb(MCI_LP3_BCK, val);
+	}
+
+	if ((update & MCDRV_HIFI_DIR_UPDATE_FLAG)
+	    || (update & MCDRV_HIFI_DIT_UPDATE_FLAG)) {
+		if (dio.port[DIO_3].dio_common.interface == MCDRV_DIO_DA) {
+			val = dio.port[DIO_3].dit.da_format.mode << 6
+			    | dio.port[DIO_3].dit.da_format.bit_sel << 4
+			    | dio.port[DIO_3].dir.da_format.mode << 2
+			    | dio.port[DIO_3].dir.da_format.bit_sel;
+			mc_packet_add_write_mb(MCI_LP3_FMT, val);
+		}
+	}
+}
+
+void mc_packet_add_digital_io_path(void)
+{
+	struct mcdrv_dio_path_info path_info;
+	u8 val;
+
+	val = mc_if_register_get_value(MCI_RST);
+	if (val & (MCB_PSW_M | MCB_RST_M))
+		return;
+
+	val = mc_a_register_get_value(MCI_PD);
+	if (val & MCB_PM_CLK_PD)
+		return;
+
+	mc_dio_path_info_get(&path_info);
+
+	val = mc_if_register_get_value(MCI_RST);
+	if (path_info.phys_port[0] >= 4 || path_info.phys_port[1] >= 4
+	    || path_info.phys_port[2] >= 4 || path_info.phys_port[3] >= 4) {
+		if (val & MCB_PSW_S) {
+			val &= MCB_PSW_S;
+			mc_packet_add_write_if(MCI_RST, val);
+
+			mc_packet_add_wait_event(MCDRV_EVT_PSW_RESET |
+						 (MCI_RST << 8) | MCB_PSW_S);
+
+			val &= ~MCB_RST_S;
+			mc_packet_add_write_if(MCI_RST, val);
+		}
+	} else {
+		if (!(val & MCB_PSW_S)) {
+			val |= MCB_RST_S;
+			mc_packet_add_write_if(MCI_RST, val);
+			val |= MCB_PSW_S;
+			mc_packet_add_write_if(MCI_RST, val);
+		}
+	}
+
+	val = mc_mb_register_get_value(MCI_LP0_MODE);
+	val &= MCB_LP0_STMODE | MCB_LP0_AUTO_FS | MCB_LP0_SRC_THRU
+	    | MCB_LPT0_EDGE | MCB_LP0_MODE;
+	val |= path_info.music_ch << 2;
+	mc_packet_add_write_mb(MCI_LP0_MODE, val);
+
+	val = path_info.music_rslot[0]
+	    | path_info.music_rslot[1] << 2 | path_info.music_rslot[2] << 4;
+	mc_packet_add_write_mb(MCI_LPR0_SLOT, val);
+
+	val = path_info.music_tslot[0]
+	    | path_info.music_tslot[1] << 2 | path_info.music_tslot[2] << 4;
+	mc_packet_add_write_mb(MCI_LPT0_SLOT, val);
+}
+
+void mc_packet_add_switch_clock(u8 clock)
+{
+	struct mcdrv_dev_info info;
+	struct mcdrv_hsdet_info hsdet;
+	u8 val, mask;
+
+	mc_dev_info_get(&info);
+	mc_hsdet_info_get(&hsdet);
+
+	val = mc_a_register_get_value(MCI_PD);
+	if ((val & MCB_PLL_PD) != MCB_PLL_PD) {
+		val = mc_a_register_get_value(MCI_CLK_MSK);
+		if (clock == MCDRV_CLKSW_CLKA) {
+			/* CLKB->CLKA */
+			if (info.clk_input == MCDRV_CKINPUT_CLKI0_CLKI1
+			    || info.clk_input == MCDRV_CKINPUT_CLKI0_RTCK
+			    || info.clk_input == MCDRV_CKINPUT_CLKI0_SBCK)
+				val &= ~MCB_CLKI0_MSK;
+			else if (info.clk_input == MCDRV_CKINPUT_CLKI1_CLKI0
+				 || info.clk_input == MCDRV_CKINPUT_CLKI1_RTCK
+				 || info.clk_input == MCDRV_CKINPUT_CLKI1_SBCK)
+				val &= ~MCB_CLKI1_MSK;
+			else
+				val &= ~MCB_RTCI_MSK;
+			mc_packet_add_write_a(MCI_CLK_MSK, val);
+
+			val = mc_a_register_get_value(MCI_CLKSRC);
+			if (val & MCB_CLK_INPUT)
+				val |= MCB_CLKSRC;
+			else
+				val &= ~MCB_CLKSRC;
+			mc_packet_add_write_a(MCI_CLKSRC, val);
+
+			mc_packet_add_wait_event(MCDRV_EVT_CLKBUSY_RESET);
+
+			val = MCI_CLK_MSK_DEF;
+			if (info.clk_input == MCDRV_CKINPUT_CLKI0_CLKI1
+			    || info.clk_input == MCDRV_CKINPUT_CLKI0_RTCK
+			    || info.clk_input == MCDRV_CKINPUT_CLKI0_SBCK)
+				val &= ~MCB_CLKI0_MSK;
+			else if (info.clk_input == MCDRV_CKINPUT_CLKI1_CLKI0
+				 || info.clk_input == MCDRV_CKINPUT_CLKI1_RTCK
+				 || info.clk_input == MCDRV_CKINPUT_CLKI1_SBCK)
+				val &= ~MCB_CLKI1_MSK;
+			else
+				val &= ~MCB_RTCI_MSK;
+			mc_packet_add_write_a(MCI_CLK_MSK, val);
+			mask = val;
+		} else {
+			/* CLKA->CLKB */
+			if (info.clk_input == MCDRV_CKINPUT_CLKI1_CLKI0
+			    || info.clk_input == MCDRV_CKINPUT_RTC_CLKI0
+			    || info.clk_input == MCDRV_CKINPUT_SBCK_CLKI0)
+				val &= ~MCB_CLKI0_MSK;
+			else if (info.clk_input == MCDRV_CKINPUT_CLKI0_CLKI1
+				 || info.clk_input == MCDRV_CKINPUT_RTC_CLKI1
+				 || info.clk_input == MCDRV_CKINPUT_SBCK_CLKI1)
+				val &= ~MCB_CLKI1_MSK;
+			else
+				val &= ~MCB_RTCI_MSK;
+			mc_packet_add_write_a(MCI_CLK_MSK, val);
+
+			val = mc_a_register_get_value(MCI_CLKSRC);
+			if (!(val & MCB_CLK_INPUT))
+				val |= MCB_CLKSRC;
+			else
+				val &= ~MCB_CLKSRC;
+			mc_packet_add_write_a(MCI_CLKSRC, val);
+
+			mc_packet_add_wait_event(MCDRV_EVT_CLKBUSY_RESET);
+
+			val = MCI_CLK_MSK_DEF;
+			if (info.clk_input == MCDRV_CKINPUT_CLKI1_CLKI0
+			    || info.clk_input == MCDRV_CKINPUT_RTC_CLKI0
+			    || info.clk_input == MCDRV_CKINPUT_SBCK_CLKI0)
+				val &= ~MCB_CLKI0_MSK;
+			else if (info.clk_input == MCDRV_CKINPUT_CLKI0_CLKI1
+				 || info.clk_input == MCDRV_CKINPUT_RTC_CLKI1
+				 || info.clk_input == MCDRV_CKINPUT_SBCK_CLKI1)
+				val &= ~MCB_CLKI1_MSK;
+			else
+				val &= ~MCB_RTCI_MSK;
+			mc_packet_add_write_a(MCI_CLK_MSK, val);
+			mask = val;
+		}
+
+		val = mc_cd_register_get_value(MCI_CKSEL);
+		if (mc_dev_id_get() == MCDRV_DEV_ID_80_90H) {
+			if (!(mask & MCB_RTCI_MSK))
+				val &= ~MCB_HSDET;
+			else if (hsdet.en_plug_det_db == MCDRV_PLUGDETDB_DISABLE
+				 && hsdet.en_dly_key_off == MCDRV_KEYEN_D_D_D
+				 && hsdet.en_dly_key_on == MCDRV_KEYEN_D_D_D
+				 && hsdet.en_mic_det == MCDRV_MICDET_DISABLE
+				 && hsdet.en_key_off == MCDRV_KEYEN_D_D_D
+				 && hsdet.en_key_on == MCDRV_KEYEN_D_D_D)
+				val |= MCB_HSDET;
+		} else {
+			if (!(mask & MCB_RTCI_MSK))
+				val &= ~MCB_CRTC;
+			else
+				val |= MCB_CRTC;
+		}
+		mc_packet_add_write_cd(MCI_CKSEL, val);
+	} else {
+		val = mc_a_register_get_value(MCI_CLKSRC);
+		if (clock == MCDRV_CLKSW_CLKA) {
+			if (val & MCB_CLKSRC)
+				val |= MCB_CLK_INPUT;
+			else
+				val &= ~MCB_CLK_INPUT;
+		} else {
+			if (!(val & MCB_CLKSRC))
+				val |= MCB_CLK_INPUT;
+			else
+				val &= ~MCB_CLK_INPUT;
+		}
+		mc_packet_add_write_a(MCI_CLKSRC, val);
+	}
+}
+
+void mc_packet_add_swap(u32 update)
+{
+	struct mcdrv_swap_info info;
+	u8 val;
+
+	val = mc_if_register_get_value(MCI_RST);
+	if (val & (MCB_PSW_M | MCB_RST_M))
+		return;
+
+	val = mc_a_register_get_value(MCI_PD);
+	if (val & MCB_PM_CLK_PD)
+		return;
+
+	mc_swap_info_get(&info);
+
+	val = mc_ma_register_get_value(MCI_ADI_SWAP);
+	if (update & MCDRV_SWAP_ADIF0_UPDATE_FLAG)
+		val = (val & 0xf0) | info.adif0;
+	if (update & MCDRV_SWAP_ADIF1_UPDATE_FLAG)
+		val = (val & 0x0f) | info.adif1 << 4;
+	mc_packet_add_write_ma(MCI_ADI_SWAP, val);
+
+	if (update & MCDRV_SWAP_ADIF2_UPDATE_FLAG)
+		mc_packet_add_write_ma(MCI_ADI2_SWAP, info.adif2);
+
+	val = mc_ma_register_get_value(MCI_DAO_SWAP);
+	if (update & MCDRV_SWAP_DAC0_UPDATE_FLAG)
+		val = (val & 0xf0) | info.dac0;
+	if (update & MCDRV_SWAP_DAC1_UPDATE_FLAG)
+		val = (val & 0x0f) | info.dac1 << 4;
+	mc_packet_add_write_ma(MCI_DAO_SWAP, val);
+
+	val = mc_mb_register_get_value(MCI_LPR0_SWAP);
+	if (update & MCDRV_SWAP_MUSICIN0_UPDATE_FLAG)
+		val = (val & ~0x03) | info.music_in0;
+	if (update & MCDRV_SWAP_MUSICIN1_UPDATE_FLAG)
+		val = (val & ~0x0c) | info.music_in1 << 2;
+	if (update & MCDRV_SWAP_MUSICIN2_UPDATE_FLAG)
+		val = (val & ~0x30) | info.music_in2 << 4;
+	mc_packet_add_write_mb(MCI_LPR0_SWAP, val);
+
+	val = mc_mb_register_get_value(MCI_LPT0_SWAP);
+	if (update & MCDRV_SWAP_MUSICOUT0_UPDATE_FLAG)
+		val = (val & ~0x07) | info.music_out0;
+	if (update & MCDRV_SWAP_MUSICOUT1_UPDATE_FLAG)
+		val = (val & ~0x18) | info.music_out1 << 3;
+	if (update & MCDRV_SWAP_MUSICOUT2_UPDATE_FLAG)
+		val = (val & ~0x60) | info.music_out2 << 5;
+	mc_packet_add_write_mb(MCI_LPT0_SWAP, val);
+
+	if (update & MCDRV_SWAP_EXTIN_UPDATE_FLAG)
+		mc_packet_add_write_mb(MCI_LPR1_SWAP, info.ext_in);
+
+	if (update & MCDRV_SWAP_EXTOUT_UPDATE_FLAG)
+		mc_packet_add_write_mb(MCI_LPT1_SWAP, info.ext_out);
+
+	if (update & MCDRV_SWAP_VOICEIN_UPDATE_FLAG)
+		mc_packet_add_write_mb(MCI_LPR2_SWAP, info.voice_in);
+
+	if (update & MCDRV_SWAP_VOICEOUT_UPDATE_FLAG)
+		mc_packet_add_write_mb(MCI_LPT2_SWAP, info.voice_out);
+
+	if (update & MCDRV_SWAP_HIFIIN_UPDATE_FLAG)
+		mc_packet_add_write_mb(MCI_LPR3_SWAP, info.hifi_in);
+
+	if (update & MCDRV_SWAP_HIFIOUT_UPDATE_FLAG)
+		mc_packet_add_write_mb(MCI_LPT3_SWAP, info.hifi_out);
+}
+
+void mc_packet_add_hsdet(void)
+{
+	struct mcdrv_dev_info info;
+	struct mcdrv_hsdet_info hsdet;
+	enum mcdrv_dev_id id;
+	u8 val, mask, data[2];
+
+	id = mc_dev_id_get();
+	mc_dev_info_get(&info);
+	mc_hsdet_info_get(&hsdet);
+
+	if (hsdet.en_plug_det_db == MCDRV_PLUGDETDB_DISABLE
+	    && hsdet.en_dly_key_off == MCDRV_KEYEN_D_D_D
+	    && hsdet.en_dly_key_on == MCDRV_KEYEN_D_D_D
+	    && hsdet.en_mic_det == MCDRV_MICDET_DISABLE
+	    && hsdet.en_key_off == MCDRV_KEYEN_D_D_D
+	    && hsdet.en_key_on == MCDRV_KEYEN_D_D_D) {
+		mc_packet_add_write_cd(MCI_IRQHS, 0);
+		mc_packet_add_write_cd(MCI_EPLUGDET, hsdet.en_plug_det << 7);
+		mc_packet_add_write_cd(MCI_EDLYKEY, 0);
+		mc_packet_add_write_cd(MCI_EMICDET, 0);
+		mc_packet_add_write_cd(MCI_HSDETEN, hsdet.hs_det_dbnc);
+		mc_packet_add_write_ana(MCI_KDSET, info.mbs_disch << 4);
+		val = mc_cd_register_get_value(MCI_CKSEL);
+		val &= ~MCB_CKSEL0;
+		if (id == MCDRV_DEV_ID_80_90H) {
+			mask = mc_a_register_get_value(MCI_CLK_MSK);
+			if (mask & MCB_RTCI_MSK)
+				val |= MCB_HSDET;
+		} else
+			val |= MCB_HSDET;
+		mc_packet_add_write_cd(MCI_CKSEL, val);
+		mc_packet_add_write_cd(MCI_DP_OSC, MCB_DP_OSC);
+	} else {
+		if (hsdet.en_plug_det_db != MCDRV_PLUGDETDB_DISABLE
+		    || hsdet.en_dly_key_off != MCDRV_KEYEN_D_D_D
+		    || hsdet.en_dly_key_on != MCDRV_KEYEN_D_D_D
+		    || hsdet.en_mic_det != MCDRV_MICDET_DISABLE
+		    || hsdet.en_key_off != MCDRV_KEYEN_D_D_D
+		    || hsdet.en_key_on != MCDRV_KEYEN_D_D_D) {
+			val = mc_cd_register_get_value(MCI_HSDETEN);
+			if (!(val & MCB_HSDETEN)) {
+				if (info.hsdet_clk == MCDRV_HSDETCLK_OSC) {
+					mc_packet_add_write_cd(MCI_DP_OSC, 0);
+					mc_packet_add_wait(MCDRV_OSC_WAIT_TIME);
+				}
+				mc_packet_add_write_cd(MCI_HSDETEN,
+						       hsdet.hs_det_dbnc);
+				mc_packet_add_write_cd(MCI_HSDETMODE,
+						       hsdet.hs_det_mode);
+				val = hsdet.speriod << 3 | MCB_DBNC_LPERIOD;
+				mc_packet_add_write_cd(MCI_DBNC_PERIOD, val);
+
+				val = hsdet.dbnc_num_plug << 4
+				    | hsdet.dbnc_num_mic << 2
+				    | hsdet.dbnc_num_key;
+				mc_packet_add_write_cd(MCI_DBNC_NUM, val);
+
+				val = hsdet.key_off_mtim << 1
+				    | hsdet.key_on_mtim;
+				if (id != MCDRV_DEV_ID_80_90H)
+					val |= MCI_KEY_MTIM_DEF;
+				mc_packet_add_write_cd(MCI_KEY_MTIM, val);
+
+				val = hsdet.key0_on_dly_tim2 << 4
+				    | hsdet.key0_on_dly_tim;
+				mc_packet_add_write_cd(MCI_KEYONDLYTIM_K0, val);
+				mc_packet_add_write_cd(MCI_KEYOFFDLYTIM_K0,
+						       hsdet.key0_off_dly_tim);
+				val =
+				    hsdet.key1_on_dly_tim2 << 4 |
+				    hsdet.key1_on_dly_tim;
+				mc_packet_add_write_cd(MCI_KEYONDLYTIM_K1, val);
+				mc_packet_add_write_cd(MCI_KEYOFFDLYTIM_K1,
+						       hsdet.key1_off_dly_tim);
+				val =
+				    hsdet.key2_on_dly_tim2 << 4 |
+				    hsdet.key2_on_dly_tim;
+				mc_packet_add_write_cd(MCI_KEYONDLYTIM_K2, val);
+				mc_packet_add_write_cd(MCI_KEYOFFDLYTIM_K2,
+						       hsdet.key2_off_dly_tim);
+
+				val = mc_cd_register_get_value(MCI_CKSEL);
+				val &= ~MCB_HSDET;
+				if (info.hsdet_clk == MCDRV_HSDETCLK_OSC)
+					val |= MCB_CKSEL0;
+				mc_packet_add_write_cd(MCI_CKSEL, val);
+			}
+		}
+		mc_packet_add_write_cd(MCI_IRQHS, MCB_EIRQHS);
+
+		val = hsdet.en_plug_det << 7 | hsdet.en_plug_det_db;
+		mc_packet_add_write_cd(MCI_EPLUGDET, val);
+
+		val = hsdet.en_dly_key_off << 3 | hsdet.en_dly_key_on;
+		mc_packet_add_write_cd(MCI_EDLYKEY, val);
+
+		val = hsdet.en_mic_det << 6 | hsdet.en_key_off << 3
+		    | hsdet.en_key_on;
+		mc_packet_add_write_cd(MCI_EMICDET, val);
+		mc_packet_add_write_if(MCI_IRQR, MCB_EIRQR);
+	}
+
+	if (id == MCDRV_DEV_ID_80_90H)
+		mc_packet_add_write_cd(MCI_IRQTYPE, hsdet.irq_type);
+	else {
+		if (hsdet.irq_type == MCDRV_IRQTYPE_NORMAL)
+			val = 0;
+		else if (hsdet.irq_type == MCDRV_IRQTYPE_REF)
+			val = MCI_IRQTYPE_DEF;
+		else
+			val = hsdet.plug_det_irq_type << 7
+			    | hsdet.mic_det_irq_type << 6
+			    | hsdet.plug_undet_db_irq_type << 1
+			    | hsdet.plug_det_db_irq_type;
+		mc_packet_add_write_cd(MCI_IRQTYPE, val);
+	}
+	mc_packet_add_write_cd(MCI_DLYIRQSTOP, hsdet.dly_irq_stop);
+
+	val = hsdet.det_in_inv;
+	if (id != MCDRV_DEV_ID_80_90H) {
+		if (hsdet.irq_type == MCDRV_IRQTYPE_EX)
+			val |= hsdet.key2_on_irq_type << 7
+			    | hsdet.key1_on_irq_type << 6
+			    | hsdet.key0_on_irq_type << 5;
+		else
+			val |= hsdet.irq_type << 7
+			    | hsdet.irq_type << 6 | hsdet.irq_type << 5;
+	}
+	mc_packet_add_write_cd(MCI_DETIN_INV, val);
+
+	if (id != MCDRV_DEV_ID_80_90H) {
+		data[0] = MCI_CD_REG_A << 1;
+		data[1] = MCI_IRQM_KEYOFF;
+		mc_write_analog(data, 2);
+		mc_read_analog(MCI_CD_REG_D, &val, 1);
+		val &= 0x1;
+		if (hsdet.irq_type == MCDRV_IRQTYPE_EX)
+			val |= hsdet.key2_off_irq_type << 7
+			    | hsdet.key1_off_irq_type << 6
+			    | hsdet.key0_off_irq_type << 5;
+		else
+			val |= hsdet.irq_type << 7 | hsdet.irq_type << 6
+			    | hsdet.irq_type << 5;
+		mc_packet_add_write_cd(MCI_IRQM_KEYOFF, val);
+	}
+
+	mc_packet_add_write_cd(MCI_HSDETMODE, hsdet.hs_det_mode);
+
+	val = hsdet.speriod << 3 | MCB_DBNC_LPERIOD;
+	mc_packet_add_write_cd(MCI_DBNC_PERIOD, val);
+
+	val = hsdet.dbnc_num_plug << 4 | hsdet.dbnc_num_mic << 2
+	    | hsdet.dbnc_num_key;
+	mc_packet_add_write_cd(MCI_DBNC_NUM, val);
+
+	val = hsdet.key_off_mtim << 1 | hsdet.key_on_mtim;
+	if (id != MCDRV_DEV_ID_80_90H)
+		val |= MCI_KEY_MTIM_DEF;
+	mc_packet_add_write_cd(MCI_KEY_MTIM, val);
+
+	val = hsdet.key0_on_dly_tim2 << 4 | hsdet.key0_on_dly_tim;
+	mc_packet_add_write_cd(MCI_KEYONDLYTIM_K0, val);
+	mc_packet_add_write_cd(MCI_KEYOFFDLYTIM_K0, hsdet.key0_off_dly_tim);
+
+	val = hsdet.key1_on_dly_tim2 << 4 | hsdet.key1_on_dly_tim;
+	mc_packet_add_write_cd(MCI_KEYONDLYTIM_K1, val);
+	mc_packet_add_write_cd(MCI_KEYOFFDLYTIM_K1, hsdet.key1_off_dly_tim);
+
+	val = hsdet.key2_on_dly_tim2 << 4 | hsdet.key2_on_dly_tim;
+	mc_packet_add_write_cd(MCI_KEYONDLYTIM_K2, val);
+	mc_packet_add_write_cd(MCI_KEYOFFDLYTIM_K2, hsdet.key2_off_dly_tim);
+}
+
+void mc_packet_add_mic_key_detect_enable(bool check_plug_det_db)
+{
+	struct mcdrv_hsdet_info hsdet;
+	u8 val;
+
+	if (check_plug_det_db) {
+		val = mc_plug_detect_db_get();
+		if (!(val & MCB_RPLUGDET_DB))
+			return;
+	}
+
+	mc_hsdet_info_get(&hsdet);
+
+	val = mc_ana_register_get_value(MCI_AP);
+	val &= ~MCB_AP_BGR;
+	mc_packet_add_write_ana(MCI_AP, val);
+
+	val = mc_ana_register_get_value(MCI_KDSET);
+	val = (val & ~MCB_KDSET2) | MCB_KDSET1;
+	mc_packet_add_force_write_ana(MCI_KDSET, val);
+
+	mc_packet_add_wait(2000);
+
+	val &= ~MCB_KDSET1;
+	mc_packet_add_force_write_ana(MCI_KDSET, val);
+
+	val |= MCB_KDSET2;
+	mc_packet_add_force_write_ana(MCI_KDSET, val);
+
+	mc_packet_add_wait(4000);
+
+	val = MCB_HSDETEN | MCB_MKDETEN | hsdet.hs_det_dbnc;
+	mc_packet_add_write_cd(MCI_HSDETEN, val);
+}
+
+void mc_packet_add_aec(void)
+{
+	struct mcdrv_aec_info aec;
+	u8 val;
+
+	mc_aec_info_get(&aec);
+
+	if (aec.vbox.cdsp_jtag_on == 1) {
+		mc_packet_add_write_a(MCI_DO0_DRV, 0x01);
+		mc_packet_add_write_a(MCI_DO1_DRV, 0x22);
+	}
+
+	if (!aec.fdsp_locate)
+		val = MCB_FDSP_PI_SOURCE_AE;
+	else
+		val = MCB_FDSP_EX_SYNC | MCB_FDSP_PI_SOURCE_VDSP_EX;
+	mc_packet_add_write_ma(MCI_FDSP_PI_SOURCE, val);
+	mc_packet_add_write_ma(MCI_FDSP_PO_SOURCE, aec.vbox.fdsp_po_source);
+
+	val = aec.audio_engine.mixer_in3_src << 7
+	    | aec.audio_engine.mixer_in2_src << 6
+	    | aec.audio_engine.mixer_in1_src << 5
+	    | aec.audio_engine.mixer_in0_src << 4
+	    | aec.audio_engine.bdsp_ae1_src << 1
+	    | aec.audio_engine.bdsp_ae0_src;
+	mc_packet_add_write_ma(MCI_BDSP_SOURCE, val);
+
+	val = aec.vbox.lpt2_vsource << 5
+	    | aec.vbox.isrc3_vsource << 4
+	    | aec.vbox.isrc2_ch1_vsource << 3
+	    | aec.vbox.isrc2_vsource << 2 | aec.vbox.src3_ctrl;
+	mc_packet_add_write_ma(MCI_SRC_VSOURCE, val);
+
+	val = aec.vbox.lpt2_mix_vol_o << 4 | aec.vbox.lpt2_mix_vol_i;
+	mc_packet_add_write_ma(MCI_LPT2_MIX_VOL, val);
+
+	val = mc_a_register_get_value(MCI_PCMOUT_HIZ);
+	val = (val & (MCB_PCMOUT2_HIZ | MCB_PCMOUT1_HIZ | MCB_PCMOUT0_HIZ))
+	    | aec.pdm.pdm1_data_delay << 5 | aec.pdm.pdm0_data_delay << 4;
+	mc_packet_add_write_a(MCI_PCMOUT_HIZ, val);
+
+	e_registers_setup();
+
+	val = aec.output.dng_release << 4 | aec.output.dng_attack;
+	if (mc_dev_id_get() == MCDRV_DEV_ID_80_90H) {
+		mc_packet_add_write_ana(MCI_DNG_ES1, val);
+		mc_packet_add_write_ana(MCI_DNG_HP_ES1,
+					aec.output.dng_target[0]);
+		mc_packet_add_write_ana(MCI_DNG_SP_ES1,
+					aec.output.dng_target[1]);
+		mc_packet_add_write_ana(MCI_DNG_RC_ES1,
+					aec.output.dng_target_rc);
+		mc_packet_add_write_ana(MCI_DNG_LO1_ES1,
+					aec.output.dng_target_lineout[0]);
+		mc_packet_add_write_ana(MCI_DNG_LO2_ES1,
+					aec.output.dng_target_lineout[1]);
+	} else {
+		mc_packet_add_write_ana(MCI_DNG, val);
+		mc_packet_add_write_ana(MCI_DNG_HP, aec.output.dng_target[0]);
+		mc_packet_add_write_ana(MCI_DNG_SP, aec.output.dng_target[1]);
+		mc_packet_add_write_ana(MCI_DNG_RC, aec.output.dng_target_rc);
+		mc_packet_add_write_ana(MCI_DNG_LO1,
+					aec.output.dng_target_lineout[0]);
+		mc_packet_add_write_ana(MCI_DNG_LO2,
+					aec.output.dng_target_lineout[1]);
+	}
+}
+
+void mc_packet_add_gp_mode(void)
+{
+	struct mcdrv_dev_info info;
+	struct mcdrv_gp_mode gp_mode;
+	u8 val;
+
+	mc_dev_info_get(&info);
+	mc_gp_mode_get(&gp_mode);
+
+	if (info.pa0_func == MCDRV_PA_GPIO) {
+		val = mc_a_register_get_value(MCI_PA0);
+		if (gp_mode.gp_ddr[0] == MCDRV_GPDDR_IN)
+			val &= ~MCB_PA0_DDR;
+		else
+			val |= MCB_PA0_DDR;
+
+		if (gp_mode.gp_host[0] == MCDRV_GPHOST_CPU)
+			val &= ~MCB_PA0_OUTSEL;
+		else
+			val |= MCB_PA0_OUTSEL;
+
+		if (gp_mode.gp_invert[0] == MCDRV_GPINV_NORMAL)
+			val &= ~MCB_PA0_INV;
+		else
+			val |= MCB_PA0_INV;
+		mc_packet_add_write_a(MCI_PA0, val);
+	}
+
+	if (info.pa1_func == MCDRV_PA_GPIO) {
+		val = mc_a_register_get_value(MCI_PA1);
+		if (gp_mode.gp_ddr[1] == MCDRV_GPDDR_IN)
+			val &= ~MCB_PA1_DDR;
+		else
+			val |= MCB_PA1_DDR;
+
+		if (gp_mode.gp_host[1] == MCDRV_GPHOST_CPU)
+			val &= ~MCB_PA1_OUTSEL;
+		else
+			val |= MCB_PA1_OUTSEL;
+
+		if (gp_mode.gp_invert[1] == MCDRV_GPINV_NORMAL)
+			val &= ~MCB_PA1_INV;
+		else
+			val |= MCB_PA1_INV;
+		mc_packet_add_write_a(MCI_PA1, val);
+	}
+
+	if (info.pa2_func == MCDRV_PA_GPIO) {
+		val = mc_a_register_get_value(MCI_PA2);
+		if (gp_mode.gp_ddr[2] == MCDRV_GPDDR_IN)
+			val &= ~MCB_PA2_DDR;
+		else
+			val |= MCB_PA2_DDR;
+
+		if (gp_mode.gp_host[2] == MCDRV_GPHOST_CPU)
+			val &= ~MCB_PA2_OUTSEL;
+		else
+			val |= MCB_PA2_OUTSEL;
+
+		if (gp_mode.gp_invert[2] == MCDRV_GPINV_NORMAL)
+			val &= ~MCB_PA2_INV;
+		else
+			val |= MCB_PA2_INV;
+		mc_packet_add_write_a(MCI_PA2, val);
+	}
+}
+
+void mc_packet_add_gp_set(u32 pad_no)
+{
+	struct mcdrv_dev_info info;
+	struct mcdrv_gp_mode gp_mode;
+	u8 val;
+
+	mc_dev_info_get(&info);
+	mc_gp_mode_get(&gp_mode);
+
+	switch (pad_no) {
+	case 0:
+		if (info.pa0_func == MCDRV_PA_GPIO
+		    && gp_mode.gp_ddr[0] == MCDRV_GPDDR_OUT
+		    && gp_mode.gp_host[0] == MCDRV_GPHOST_CPU) {
+			val = mc_a_register_get_value(MCI_PA0);
+			val = val & ~MCB_PA0_DATA;
+			val |= mc_gp_pad_get(pad_no) << 4;
+			mc_packet_add_write_a(MCI_PA0, val);
+		}
+		break;
+	case 1:
+		if (info.pa1_func == MCDRV_PA_GPIO
+		    && gp_mode.gp_ddr[1] == MCDRV_GPDDR_OUT
+		    && gp_mode.gp_host[1] == MCDRV_GPHOST_CPU) {
+			val = mc_a_register_get_value(MCI_PA1);
+			val &= ~MCB_PA1_DATA;
+			val |= mc_gp_pad_get(pad_no) << 4;
+			mc_packet_add_write_a(MCI_PA1, val);
+		}
+		break;
+	case 2:
+		if (info.pa2_func == MCDRV_PA_GPIO
+		    && gp_mode.gp_ddr[2] == MCDRV_GPDDR_OUT
+		    && gp_mode.gp_host[2] == MCDRV_GPHOST_CPU) {
+			val = mc_a_register_get_value(MCI_PA2);
+			val &= ~MCB_PA2_DATA;
+			val |= mc_gp_pad_get(pad_no) << 4;
+			mc_packet_add_write_a(MCI_PA2, val);
+		}
+		break;
+	default:
+		break;
+	}
+}
diff --git a/sound/soc/codecs/ymu831/mcpacking.h b/sound/soc/codecs/ymu831/mcpacking.h
new file mode 100644
index 0000000..e5a2e62
--- /dev/null
+++ b/sound/soc/codecs/ymu831/mcpacking.h
@@ -0,0 +1,217 @@
+/****************************************************************************
+ *
+ * Copyright(c) 2012 Yamaha Corporation. All rights reserved.
+ *
+ * Module	: mcpacking.h
+ * Description	: MC device control packet packing driver header
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
+ * - some definitions move from mcdevif.h
+ */
+#ifndef _MCPACKING_H
+#define _MCPACKING_H
+
+#include <linux/types.h>
+
+/* packet type */
+#define	MCDRV_PACKET_TYPE_WRITE		0x10000000U
+#define	MCDRV_PACKET_TYPE_FORCE_WRITE	0x20000000U
+#define	MCDRV_PACKET_TYPE_TIMWAIT	0x30000000U
+#define	MCDRV_PACKET_TYPE_EVTWAIT	0x40000000U
+#define	MCDRV_PACKET_TYPE_TERMINATE	0xF0000000U
+#define	MCDRV_PACKET_TYPE_MASK		0xF0000000U
+
+/* register type */
+#define	MCDRV_PACKET_REGTYPE_IF		0x0000U
+#define	MCDRV_PACKET_REGTYPE_A		0x1000U
+#define	MCDRV_PACKET_REGTYPE_MA		0x2000U
+#define	MCDRV_PACKET_REGTYPE_MB		0x3000U
+#define	MCDRV_PACKET_REGTYPE_B		0x4000U
+#define	MCDRV_PACKET_REGTYPE_E		0x5000U
+#define	MCDRV_PACKET_REGTYPE_C		0x6000U
+#define	MCDRV_PACKET_REGTYPE_F		0x7000U
+#define	MCDRV_PACKET_REGTYPE_ANA	0x8000U
+#define	MCDRV_PACKET_REGTYPE_CD		0x9000U
+#define	MCDRV_PACKET_REGTYPE_MASK	0xF000U
+#define	MCDRV_PACKET_ADR_MASK		0x0FFFU
+
+/* event */
+#define	MCDRV_EVT_SVOL_DONE		0x00010000U
+#define	MCDRV_EVT_ALLMUTE		0x00020000U
+#define	MCDRV_EVT_DIRMUTE		0x00030000U
+#define	MCDRV_EVT_ADCMUTE		0x00040000U
+#define	MCDRV_EVT_DITMUTE		0x00050000U
+#define	MCDRV_EVT_DACMUTE		0x00060000U
+#define	MCDRV_EVT_PSW_RESET		0x00070000U
+#define	MCDRV_EVT_CLKBUSY_RESET		0x00080000U
+#define	MCDRV_EVT_OFFCAN_BSY_RESET	0x00090000U
+#define	MCDRV_EVT_ANA_RDY		0x000A0000U
+#define MCDRV_EVT_AP_CP_A_SET		0x000b0000U
+
+#define	MCDRV_EVT_IF_REG_FLAG_SET	0x01000000U
+#define	MCDRV_EVT_IF_REG_FLAG_RESET	0x02000000U
+#define	MCDRV_EVT_B_REG_FLAG_SET	0x03000000U
+#define	MCDRV_EVT_B_REG_FLAG_RESET	0x04000000U
+#define	MCDRV_EVT_E_REG_FLAG_SET	0x05000000U
+#define	MCDRV_EVT_E_REG_FLAG_RESET	0x06000000U
+#define	MCDRV_EVT_C_REG_FLAG_SET	0x07000000U
+#define	MCDRV_EVT_C_REG_FLAG_RESET	0x08000000U
+#define	MCDRV_EVT_F_REG_FLAG_SET	0x09000000U
+#define	MCDRV_EVT_F_REG_FLAG_RESET	0x0A000000U
+
+#define	MCDRV_PACKET_EVT_MASK		0x0FFF0000U
+#define	MCDRV_PACKET_EVTPRM_MASK	0x0000FFFFU
+
+/* timer */
+#define	MCDRV_PACKET_TIME_MASK		0x0FFFFFFFU
+
+#define MCDRV_MAX_PACKETS		255
+
+enum mcdrv_volume_mode {
+	MCDRV_VOLUME_MUTE,
+	MCDRV_VOLUME_SET,
+};
+
+#define MCDRV_VOLUPDATE_ALL	0xffffffffU
+#define MCDRV_VOLUPDATE_ANA_OUT	0x00000001U
+#define MCDRV_VOLUPDATE_ANA_IN	0x00000100U
+#define MCDRV_VOLUPDATE_DIN0	0x00010000U
+#define MCDRV_VOLUPDATE_DIN1	0x00020000U
+#define MCDRV_VOLUPDATE_DIN2	0x00040000U
+#define MCDRV_VOLUPDATE_DIN3	0x00080000U
+#define MCDRV_VOLUPDATE_ADIF0	0x00100000U
+#define MCDRV_VOLUPDATE_ADIF1	0x00200000U
+#define MCDRV_VOLUPDATE_ADIF2	0x00400000U
+#define MCDRV_VOLUPDATE_DIN	0x00ff0000U
+#define MCDRV_VOLUPDATE_DOUT0	0x01000000U
+#define MCDRV_VOLUPDATE_DOUT1	0x02000000U
+#define MCDRV_VOLUPDATE_DOUT2	0x04000000U
+#define MCDRV_VOLUPDATE_DOUT3	0x08000000U
+#define MCDRV_VOLUPDATE_DAC0	0x10000000U
+#define MCDRV_VOLUPDATE_DAC1	0x20000000U
+#define MCDRV_VOLUPDATE_DPATHDA	0x80000000U
+#define MCDRV_VOLUPDATE_DOUT	0xff000000U
+#define MCDRV_VOLUPDATE_DIG	0xffff0000U
+
+struct mcdrv_power_info {
+	u8 digital;
+	u8 analog[5];
+};
+
+#define MCDRV_POWINFO_D_PLL_PD		0x80
+#define MCDRV_POWINFO_D_PE_CLK_PD	0x20
+#define MCDRV_POWINFO_D_PB_CLK_PD	0x10
+#define MCDRV_POWINFO_D_PM_CLK_PD	0x08
+#define MCDRV_POWINFO_D_PF_CLK_PD	0x04
+#define MCDRV_POWINFO_D_PC_CLK_PD	0x02
+
+struct mcdrv_power_update {
+	u8 digital;
+	u8 analog[5];
+};
+
+#define MCDRV_POWUPDATE_D_ALL		0xff
+#define MCDRV_POWUPDATE_AP		0x3f
+#define MCDRV_POWUPDATE_AP_OUT0		0x7f
+#define MCDRV_POWUPDATE_AP_OUT1		0xff
+#define MCDRV_POWUPDATE_AP_MC		0xff
+#define MCDRV_POWUPDATE_AP_IN		0x87
+
+int mc_packet_init(void);
+void mc_packet_clear(void);
+void mc_packet_add(u32 desc, u8 data);
+int mc_packet_execute(void);
+
+#define mc_packet_add_wait(time)	\
+		mc_packet_add((time) | MCDRV_PACKET_TYPE_TIMWAIT, 0)
+#define mc_packet_add_wait_event(event)	\
+		mc_packet_add((event) | MCDRV_PACKET_TYPE_EVTWAIT, 0)
+#define mc_packet_add_write(reg, data)	\
+		mc_packet_add((reg) | MCDRV_PACKET_TYPE_WRITE, (data))
+#define mc_packet_add_write_if(reg, data)	\
+		mc_packet_add_write((reg) | MCDRV_PACKET_REGTYPE_IF, (data))
+#define mc_packet_add_write_a(reg, data)	\
+		mc_packet_add_write((reg) | MCDRV_PACKET_REGTYPE_A, (data))
+#define mc_packet_add_write_ma(reg, data)	\
+		mc_packet_add_write((reg) | MCDRV_PACKET_REGTYPE_MA, (data))
+#define mc_packet_add_write_mb(reg, data)	\
+		mc_packet_add_write((reg) | MCDRV_PACKET_REGTYPE_MB, (data))
+#define mc_packet_add_write_b(reg, data)	\
+		mc_packet_add_write((reg) | MCDRV_PACKET_REGTYPE_B, (data))
+#define mc_packet_add_write_e(reg, data)	\
+		mc_packet_add_write((reg) | MCDRV_PACKET_REGTYPE_E, (data))
+#define mc_packet_add_write_c(reg, data)	\
+		mc_packet_add_write((reg) | MCDRV_PACKET_REGTYPE_C, (data))
+#define mc_packet_add_write_f(reg, data)	\
+		mc_packet_add_write((reg) | MCDRV_PACKET_REGTYPE_F, (data))
+#define mc_packet_add_write_ana(reg, data)	\
+		mc_packet_add_write((reg) | MCDRV_PACKET_REGTYPE_ANA, (data))
+#define mc_packet_add_write_cd(reg, data)	\
+		mc_packet_add_write((reg) | MCDRV_PACKET_REGTYPE_CD, (data))
+#define mc_packet_add_force_write(reg, data)	\
+		mc_packet_add((reg) | MCDRV_PACKET_TYPE_FORCE_WRITE, (data))
+#define mc_packet_add_force_write_if(reg, data)	\
+	mc_packet_add_force_write((reg) | MCDRV_PACKET_REGTYPE_IF, (data))
+#define mc_packet_add_force_write_ma(reg, data)	\
+	mc_packet_add_force_write((reg) | MCDRV_PACKET_REGTYPE_MA, (data))
+#define mc_packet_add_force_write_b(reg, data)	\
+	mc_packet_add_force_write((reg) | MCDRV_PACKET_REGTYPE_B, (data))
+#define mc_packet_add_force_write_e(reg, data)	\
+	mc_packet_add_force_write((reg) | MCDRV_PACKET_REGTYPE_E, (data))
+#define mc_packet_add_force_write_c(reg, data)	\
+	mc_packet_add_force_write((reg) | MCDRV_PACKET_REGTYPE_C, (data))
+#define mc_packet_add_force_write_f(reg, data)	\
+	mc_packet_add_force_write((reg) | MCDRV_PACKET_REGTYPE_F, (data))
+#define mc_packet_add_force_write_ana(reg, data)	\
+	mc_packet_add_force_write((reg) | MCDRV_PACKET_REGTYPE_ANA, (data))
+#define mc_packet_add_force_write_cd(reg, data)	\
+	mc_packet_add_force_write((reg) | MCDRV_PACKET_REGTYPE_CD, (data))
+
+void mc_packet_add_switch_clock(u8 clk_switch);
+int mc_packet_add_powerup(struct mcdrv_power_info *power_info,
+			  struct mcdrv_power_update *power_update);
+int mc_packet_add_powerdown(struct mcdrv_power_info *power_info,
+			    struct mcdrv_power_update *power_update);
+void mc_packet_add_path_set(void);
+void mc_packet_add_start(void);
+void mc_packet_add_stop(void);
+void mc_packet_add_dsp_start_and_stop(u8 started);
+void mc_packet_add_fdsp_stop(u8 started);
+void mc_packet_add_volume(u32 update, enum mcdrv_volume_mode mode, u32 *status);
+void mc_packet_add_dac0_mute(void);
+void mc_packet_add_dac1_mute(void);
+void mc_packet_add_dout_mute(void);
+void mc_packet_add_adif_mute(void);
+void mc_packet_add_dpath_da_mute(void);
+void mc_packet_add_digital_io(u32 update);
+void mc_packet_add_digital_io_path(void);
+void mc_packet_add_swap(u32 update);
+void mc_packet_add_hsdet(void);
+void mc_packet_add_mic_key_detect_enable(bool check_plug_det_db);
+void mc_packet_add_aec(void);
+void mc_packet_add_gp_mode(void);
+void mc_packet_add_gp_set(u32 pad_no);
+
+#endif /* _MCPACKING_H */
-- 
1.7.9.5
