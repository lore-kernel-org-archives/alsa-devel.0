From: Yoichi Yuasa <yuasa@linux-mips.org>
Subject: [PATCH 12/19] ALSA: ymu831: add resource control driver
Date: Wed, 16 Jan 2013 17:38:09 +0900
Message-ID: <20130116173809.ca9b864d2f025cdedd60f824@linux-mips.org>
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
 sound/soc/codecs/ymu831/mcresctrl.c | 4062 +++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ymu831/mcresctrl.h |  394 ++++
 3 files changed, 4458 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/codecs/ymu831/mcresctrl.c
 create mode 100644 sound/soc/codecs/ymu831/mcresctrl.h

diff --git a/sound/soc/codecs/ymu831/Makefile b/sound/soc/codecs/ymu831/Makefile
index 820dec7..3fd53fe 100644
--- a/sound/soc/codecs/ymu831/Makefile
+++ b/sound/soc/codecs/ymu831/Makefile
@@ -6,6 +6,7 @@ snd-soc-ymu831-objs := \
 	mcedspdrv.o	\
 	mcfdspdrv.o	\
 	mcpacking.o	\
-	mcparser.o
+	mcparser.o	\
+	mcresctrl.o
 
 obj-$(CONFIG_SND_SOC_YMU831) += snd-soc-ymu831.o
diff --git a/sound/soc/codecs/ymu831/mcresctrl.c b/sound/soc/codecs/ymu831/mcresctrl.c
new file mode 100644
index 0000000..9a7787e
--- /dev/null
+++ b/sound/soc/codecs/ymu831/mcresctrl.c
@@ -0,0 +1,4062 @@
+/****************************************************************************
+ *
+ * Copyright(c) 2012 Yamaha Corporation. All rights reserved.
+ *
+ * Module	: mcresctrl.c
+ * Description	: MC resource control driver
+ * Version	: 1.0.1	Dec 18 2012
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
+#include <linux/bug.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include "mcdefs.h"
+#include "mcdevif.h"
+#include "mcdriver.h"
+#include "mcresctrl.h"
+
+#define BURST_WRITE_ENABLE	0x01
+
+#define D1SRC_ALL_OFF	(MCDRV_D1SRC_MUSICIN_OFF	\
+			| MCDRV_D1SRC_EXTIN_OFF		\
+			| MCDRV_D1SRC_VBOXOUT_OFF	\
+			| MCDRV_D1SRC_VBOXREFOUT_OFF	\
+			| MCDRV_D1SRC_AE0_OFF		\
+			| MCDRV_D1SRC_AE1_OFF		\
+			| MCDRV_D1SRC_AE2_OFF		\
+			| MCDRV_D1SRC_AE3_OFF		\
+			| MCDRV_D1SRC_ADIF0_OFF		\
+			| MCDRV_D1SRC_ADIF1_OFF		\
+			| MCDRV_D1SRC_ADIF2_OFF		\
+			| MCDRV_D1SRC_HIFIIN_OFF)
+#define D2SRC_ALL_OFF	(MCDRV_D2SRC_VOICEIN_OFF	\
+			| MCDRV_D2SRC_VBOXIOOUT_OFF	\
+			| MCDRV_D2SRC_VBOXHOSTOUT_OFF	\
+			| MCDRV_D2SRC_ADC0_L_OFF	\
+			| MCDRV_D2SRC_ADC0_R_OFF	\
+			| MCDRV_D2SRC_ADC1_OFF		\
+			| MCDRV_D2SRC_PDM0_L_OFF	\
+			| MCDRV_D2SRC_PDM0_R_OFF	\
+			| MCDRV_D2SRC_PDM1_L_OFF	\
+			| MCDRV_D2SRC_PDM1_R_OFF	\
+			| MCDRV_D2SRC_DAC0REF_OFF	\
+			| MCDRV_D2SRC_DAC1REF_OFF)
+
+#define ASRC_ALL_OFF	(MCDRV_ASRC_DAC0_L_OFF		\
+			| MCDRV_ASRC_DAC0_R_OFF		\
+			| MCDRV_ASRC_DAC1_L_OFF		\
+			| MCDRV_ASRC_DAC1_R_OFF		\
+			| MCDRV_ASRC_MIC1_OFF		\
+			| MCDRV_ASRC_MIC2_OFF		\
+			| MCDRV_ASRC_MIC3_OFF		\
+			| MCDRV_ASRC_MIC4_OFF		\
+			| MCDRV_ASRC_LINEIN1_L_OFF	\
+			| MCDRV_ASRC_LINEIN1_R_OFF	\
+			| MCDRV_ASRC_LINEIN1_M_OFF)
+
+/* control packet for serial host interface */
+#define MCDRV_MAX_CTRL_DATA_NUM	(MCDRV_MAX_PACKETS * 4)
+
+struct mcdrv_packet {
+	u8 data[MCDRV_MAX_CTRL_DATA_NUM];
+	u16 data_size;
+};
+
+/* Register available num */
+#define MCDRV_REG_NUM_IF	59
+#define MCDRV_REG_NUM_A		68
+#define MCDRV_REG_NUM_MA	85
+#define MCDRV_REG_NUM_MB	86
+#define MCDRV_REG_NUM_B		72
+#define MCDRV_REG_NUM_E		101
+#define MCDRV_REG_NUM_C		160
+#define MCDRV_REG_NUM_F		128
+#define MCDRV_REG_NUM_ANA	116
+#define MCDRV_REG_NUM_CD	53
+
+struct mcdrv_info {
+	u8 id;
+	enum mcdrv_dev_id device_id;
+	enum mcdrv_state state;
+
+	u8 if_registers[MCDRV_REG_NUM_IF];
+	u8 a_registers[MCDRV_REG_NUM_A];
+	u8 ma_registers[MCDRV_REG_NUM_MA];
+	u8 mb_registers[MCDRV_REG_NUM_MB];
+	u8 b_registers[MCDRV_REG_NUM_B];
+	u8 e_registers[MCDRV_REG_NUM_E];
+	u8 c_registers[MCDRV_REG_NUM_C];
+	u8 f_registers[MCDRV_REG_NUM_F];
+	u8 ana_registers[MCDRV_REG_NUM_ANA];
+	u8 cd_registers[MCDRV_REG_NUM_CD];
+
+	struct mcdrv_dev_info dev_info;
+	struct mcdrv_path_info path_info;
+	struct mcdrv_path_info path_info_virtual;
+	struct mcdrv_vol_info vol_info;
+	struct mcdrv_dio_info dio_info;
+	struct mcdrv_dio_path_info dio_path_info;
+	struct mcdrv_swap_info swap_info;
+	struct mcdrv_hsdet_info hsdet_info;
+	struct mcdrv_aec_info aec_info;
+	struct mcdrv_gp_mode gp_mode;
+
+	u8 clk;
+	u8 clk_sel;
+	u8 eclk_sel;
+	u8 plug_det_db;
+
+	struct mcdrv_packet packet;
+	u16 slave_addr;
+	u16 type;
+	u16 addr;
+	u16 data_count;
+	u16 prev_addr_index;
+};
+
+static struct mcdrv_info mc_info = {
+	.device_id = MCDRV_DEV_ID_UNKNOWN,
+	.state = MCDRV_STATE_NOTINIT,
+};
+
+/* register next address */
+static const u16 mc_next_addr_list[256] = {
+	0, 1, 2, 3, 4, 5, 6, 7,
+	8, 9, 10, 11, 12, 13, 14, 15,
+	16, 17, 18, 19, 20, 21, 22, 23,
+	24, 25, 26, 27, 28, 29, 30, 31,
+	32, 33, 34, 35, 36, 37, 38, 39,
+	40, 41, 42, 43, 44, 45, 46, 47,
+	48, 49, 50, 51, 52, 53, 54, 55,
+	56, 57, 58, 59, 60, 61, 62, 63,
+	64, 65, 66, 67, 68, 69, 70, 71,
+	72, 73, 74, 75, 76, 77, 78, 79,
+	80, 81, 82, 83, 84, 85, 86, 87,
+	88, 89, 90, 91, 92, 93, 94, 95,
+	96, 97, 98, 99, 100, 101, 102, 103,
+	104, 105, 106, 107, 108, 109, 110, 111,
+	112, 113, 114, 115, 116, 117, 118, 119,
+	120, 121, 122, 123, 124, 125, 126, 127,
+	128, 129, 130, 131, 132, 133, 134, 135,
+	136, 137, 138, 139, 140, 141, 142, 143,
+	144, 145, 146, 147, 148, 149, 150, 151,
+	152, 153, 154, 155, 156, 157, 158, 159,
+	160, 161, 162, 163, 164, 165, 166, 167,
+	168, 169, 170, 171, 172, 173, 174, 175,
+	176, 177, 178, 179, 180, 181, 182, 183,
+	184, 185, 186, 187, 188, 189, 190, 191,
+	192, 193, 194, 195, 196, 197, 198, 199,
+	200, 201, 202, 203, 204, 205, 206, 207,
+	208, 209, 210, 211, 212, 213, 214, 215,
+	216, 217, 218, 219, 220, 221, 222, 223,
+	224, 225, 226, 227, 228, 229, 230, 231,
+	232, 233, 234, 235, 236, 237, 238, 239,
+	240, 241, 242, 243, 244, 245, 246, 247,
+	248, 249, 250, 251, 252, 253, 254, 255
+};
+
+static const u16 mc_next_addr_list_inc[256] = {
+	1, 2, 3, 4, 5, 6, 7, 8,
+	9, 10, 11, 12, 13, 14, 15, 16,
+	17, 18, 19, 20, 21, 22, 23, 24,
+	25, 26, 27, 28, 29, 30, 31, 32,
+	33, 34, 35, 36, 37, 38, 39, 40,
+	41, 42, 43, 44, 45, 46, 47, 48,
+	49, 50, 51, 52, 53, 54, 55, 56,
+	57, 58, 59, 60, 61, 62, 63, 64,
+	65, 66, 67, 68, 69, 70, 71, 72,
+	73, 74, 75, 76, 77, 78, 79, 80,
+	81, 82, 83, 84, 85, 86, 87, 88,
+	89, 90, 91, 92, 93, 94, 95, 96,
+	97, 98, 99, 100, 101, 102, 103, 104,
+	105, 106, 107, 108, 109, 110, 111, 112,
+	113, 114, 115, 116, 117, 118, 119, 120,
+	121, 122, 123, 124, 125, 126, 127, 128,
+	129, 130, 131, 132, 133, 134, 135, 136,
+	137, 138, 139, 140, 141, 142, 143, 144,
+	145, 146, 147, 148, 149, 150, 151, 152,
+	153, 154, 155, 156, 157, 158, 159, 160,
+	161, 162, 163, 164, 165, 166, 167, 168,
+	169, 170, 171, 172, 173, 174, 175, 176,
+	177, 178, 179, 180, 181, 182, 183, 184,
+	185, 186, 187, 188, 189, 190, 191, 192,
+	193, 194, 195, 196, 197, 198, 199, 200,
+	201, 202, 203, 204, 205, 206, 207, 208,
+	209, 210, 211, 212, 213, 214, 215, 216,
+	217, 218, 219, 220, 221, 222, 223, 224,
+	225, 226, 227, 228, 229, 230, 231, 232,
+	233, 234, 235, 236, 237, 238, 239, 240,
+	241, 242, 243, 244, 245, 246, 247, 248,
+	249, 250, 251, 252, 253, 254, 255, 0xffff
+};
+
+static inline void registers_set_default(enum mcdrv_dev_id id)
+{
+	memset(mc_info.if_registers, 0, MCDRV_REG_NUM_IF);
+
+	mc_info.if_registers[MCI_RST_A] = MCI_RST_A_DEF;
+	mc_info.if_registers[MCI_RST] = MCI_RST_DEF;
+
+	mc_a_registers_init();
+	mc_mblock_registers_init();
+
+	memset(mc_info.c_registers, 0, MCDRV_REG_NUM_C);
+	memset(mc_info.f_registers, 0, MCDRV_REG_NUM_F);
+	memset(mc_info.ana_registers, 0, MCDRV_REG_NUM_ANA);
+
+	mc_info.ana_registers[MCI_ANA_ID] = MCI_ANA_ID_DEF;
+	mc_info.ana_registers[MCI_ANA_RST] = MCI_ANA_RST_DEF;
+	mc_info.ana_registers[MCI_AP] = MCI_AP_DEF;
+	mc_info.ana_registers[MCI_AP_DA0] = MCI_AP_DA0_DEF;
+	mc_info.ana_registers[MCI_AP_DA1] = MCI_AP_DA1_DEF;
+	mc_info.ana_registers[MCI_AP_MIC] = MCI_AP_MIC_DEF;
+	mc_info.ana_registers[MCI_AP_AD] = MCI_AP_AD_DEF;
+
+	if (id == MCDRV_DEV_ID_81_91H)
+		mc_info.ana_registers[10] = 0x06;
+	mc_info.ana_registers[MCI_NONCLIP] = MCI_NONCLIP_DEF;
+
+	mc_info.ana_registers[MCI_SVOL] = MCI_SVOL_DEF;
+
+	if (id == MCDRV_DEV_ID_81_91H) {
+		mc_info.ana_registers[MCI_HIZ] = MCI_HIZ_DEF;
+		mc_info.ana_registers[MCI_LO_HIZ] = MCI_LO_HIZ_DEF;
+	}
+
+	if (id == MCDRV_DEV_ID_80_90H)
+		mc_info.ana_registers[MCI_ZCOFF] = MCI_ZCOFF_DEF_ES1;
+
+	switch (id) {
+	case MCDRV_DEV_ID_80_90H:
+		mc_info.ana_registers[MCI_CPMOD] = MCI_CPMOD_DEF_ES1;
+		mc_info.ana_registers[MCI_DNG_ES1] = MCI_DNG_DEF_ES1;
+		mc_info.ana_registers[MCI_DNG_HP_ES1] = MCI_DNG_HP_DEF_ES1;
+		mc_info.ana_registers[MCI_DNG_SP_ES1] = MCI_DNG_SP_DEF_ES1;
+		mc_info.ana_registers[MCI_DNG_RC_ES1] = MCI_DNG_RC_DEF_ES1;
+		mc_info.ana_registers[MCI_DNG_LO1_ES1] = MCI_DNG_LO1_DEF_ES1;
+		mc_info.ana_registers[MCI_DNG_LO2_ES1] = MCI_DNG_LO2_DEF_ES1;
+		break;
+	case MCDRV_DEV_ID_81_91H:
+		mc_info.ana_registers[MCI_CPMOD] = MCI_CPMOD_DEF;
+		mc_info.ana_registers[MCI_DNG] = MCI_DNG_DEF;
+		mc_info.ana_registers[MCI_DNG_HP] = MCI_DNG_HP_DEF;
+		mc_info.ana_registers[MCI_DNG_SP] = MCI_DNG_SP_DEF;
+		mc_info.ana_registers[MCI_DNG_RC] = MCI_DNG_RC_DEF;
+		mc_info.ana_registers[MCI_DNG_LO1] = MCI_DNG_LO1_DEF;
+		mc_info.ana_registers[MCI_DNG_LO2] = MCI_DNG_LO2_DEF;
+		mc_info.ana_registers[114] = 0x31;
+		mc_info.ana_registers[115] = 0x8B;
+		break;
+	default:
+		break;
+	}
+
+	memset(mc_info.cd_registers, 0, MCDRV_REG_NUM_CD);
+
+	mc_info.cd_registers[MCI_HW_ID] = MCI_HW_ID_DEF;
+	mc_info.cd_registers[MCI_CD_RST] = MCI_CD_RST_DEF;
+	mc_info.cd_registers[MCI_DP] = MCI_DP_DEF;
+	mc_info.cd_registers[MCI_DP_OSC] = MCI_DP_OSC_DEF;
+
+	switch (id) {
+	case MCDRV_DEV_ID_80_90H:
+		mc_info.cd_registers[MCI_CKSEL] = MCI_CKSEL_DEF_ES1;
+		break;
+	case MCDRV_DEV_ID_81_91H:
+		mc_info.cd_registers[MCI_CKSEL] = MCI_CKSEL_DEF;
+		break;
+	default:
+		break;
+	}
+
+	mc_info.cd_registers[MCI_MICDET] = MCI_MICDET_DEF;
+	mc_info.cd_registers[MCI_HSDETEN] = MCI_HSDETEN_DEF;
+
+	switch (id) {
+	case MCDRV_DEV_ID_80_90H:
+		mc_info.cd_registers[MCI_DETIN_INV] = MCI_DETIN_INV_DEF_ES1;
+		break;
+	case MCDRV_DEV_ID_81_91H:
+		mc_info.cd_registers[MCI_IRQTYPE] = MCI_IRQTYPE_DEF;
+		mc_info.cd_registers[MCI_DETIN_INV] = MCI_DETIN_INV_DEF;
+		break;
+	default:
+		break;
+	}
+
+	mc_info.cd_registers[MCI_HSDETMODE] = MCI_HSDETMODE_DEF;
+	mc_info.cd_registers[MCI_DBNC_PERIOD] = MCI_DBNC_PERIOD_DEF;
+
+	switch (id) {
+	case MCDRV_DEV_ID_80_90H:
+		mc_info.cd_registers[MCI_DBNC_NUM] = MCI_DBNC_NUM_DEF_ES1;
+		break;
+	case MCDRV_DEV_ID_UNKNOWN:
+		break;
+	default:
+		mc_info.cd_registers[MCI_DBNC_NUM] = MCI_DBNC_NUM_DEF;
+		mc_info.cd_registers[MCI_KEY_MTIM] = MCI_KEY_MTIM_DEF;
+		mc_info.cd_registers[39] = 0x21;
+		break;
+	}
+}
+
+int mc_id_set(u8 digital_id, u8 analog_id)
+{
+	if ((digital_id & MCDRV_DEVID_MASK) == MCDRV_DEVID_DIG
+	    && (analog_id & MCDRV_DEVID_MASK) == MCDRV_DEVID_ANA) {
+		if ((digital_id & MCDRV_VERID_MASK) == 1) {
+			if ((analog_id & MCDRV_VERID_MASK) == 2)
+				mc_info.device_id = MCDRV_DEV_ID_81_92H;
+			else
+				mc_info.device_id = MCDRV_DEV_ID_81_91H;
+		} else
+			mc_info.device_id = MCDRV_DEV_ID_80_90H;
+
+		mc_info.id = digital_id;
+		registers_set_default(mc_info.device_id);
+		mc_info.a_registers[MCI_A_DEV_ID] = mc_info.id;
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+enum mcdrv_dev_id mc_dev_id_get(void)
+{
+	return mc_info.device_id;
+}
+
+static inline void path_info_init(void)
+{
+	struct mcdrv_path_info *path_info;
+
+	path_info = &mc_info.path_info;
+
+	memset(path_info->music_out, D1SRC_ALL_OFF, MUSICOUT_PATH_CHANNELS);
+	memset(path_info->ext_out, D1SRC_ALL_OFF, EXTOUT_PATH_CHANNELS);
+	memset(path_info->hifi_out, D1SRC_ALL_OFF, HIFIOUT_PATH_CHANNELS);
+	memset(path_info->vbox_mix_in, D1SRC_ALL_OFF, VBOXMIXIN_PATH_CHANNELS);
+	memset(path_info->ae0, D1SRC_ALL_OFF, AE_PATH_CHANNELS);
+	memset(path_info->ae1, D1SRC_ALL_OFF, AE_PATH_CHANNELS);
+	memset(path_info->ae2, D1SRC_ALL_OFF, AE_PATH_CHANNELS);
+	memset(path_info->ae3, D1SRC_ALL_OFF, AE_PATH_CHANNELS);
+	memset(path_info->dac0, D1SRC_ALL_OFF, DAC0_PATH_CHANNELS);
+	memset(path_info->dac1, D1SRC_ALL_OFF, DAC1_PATH_CHANNELS);
+
+	memset(path_info->voice_out, D2SRC_ALL_OFF, VOICEOUT_PATH_CHANNELS);
+	memset(path_info->vbox_io_in, D2SRC_ALL_OFF, VBOXIOIN_PATH_CHANNELS);
+	memset(path_info->vbox_host_in, D2SRC_ALL_OFF,
+	       VBOXHOSTIN_PATH_CHANNELS);
+	memset(path_info->host_out, D2SRC_ALL_OFF, HOSTOUT_PATH_CHANNELS);
+	memset(path_info->adif0, D2SRC_ALL_OFF, ADIF0_PATH_CHANNELS);
+	memset(path_info->adif1, D2SRC_ALL_OFF, ADIF1_PATH_CHANNELS);
+	memset(path_info->adif2, D2SRC_ALL_OFF, ADIF2_PATH_CHANNELS);
+
+	memset(path_info->adc0, ASRC_ALL_OFF, ADC0_PATH_CHANNELS);
+	memset(path_info->adc1, ASRC_ALL_OFF, ADC1_PATH_CHANNELS);
+	memset(path_info->sp, ASRC_ALL_OFF, SP_PATH_CHANNELS);
+	memset(path_info->hp, ASRC_ALL_OFF, HP_PATH_CHANNELS);
+	memset(path_info->rc, ASRC_ALL_OFF, RC_PATH_CHANNELS);
+	memset(path_info->lout1, ASRC_ALL_OFF, LOUT1_PATH_CHANNELS);
+	memset(path_info->lout2, ASRC_ALL_OFF, LOUT2_PATH_CHANNELS);
+	memset(path_info->bias, ASRC_ALL_OFF, BIAS_PATH_CHANNELS);
+
+	mc_info.path_info_virtual = mc_info.path_info;
+}
+
+static inline void vol_info_init(void)
+{
+	struct mcdrv_vol_info *vol_info;
+
+	vol_info = &mc_info.vol_info;
+
+	memset(vol_info, MCDRV_LOGICAL_VOL_MUTE, sizeof(struct mcdrv_vol_info));
+}
+
+static inline void dio_info_init(void)
+{
+	struct mcdrv_dio_port *port;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mc_info.dio_info.port); i++) {
+		port = &mc_info.dio_info.port[i];
+		port->dio_common.master_slave = MCDRV_DIO_SLAVE;
+		port->dio_common.auto_fs = MCDRV_AUTOFS_ON;
+		port->dio_common.fs = MCDRV_FS_48000;
+		port->dio_common.bck_fs = MCDRV_BCKFS_64;
+		port->dio_common.interface = MCDRV_DIO_DA;
+		port->dio_common.bck_invert = MCDRV_BCLK_NORMAL;
+		port->dio_common.src_thru = MCDRV_SRC_NOT_THRU;
+		port->dio_common.pcm_hiz_transition = MCDRV_PCMHIZTRANS_FALLING;
+		port->dio_common.pcm_frame = MCDRV_PCM_SHORTFRAME;
+		port->dio_common.pcm_high_period = 0;
+
+		port->dir.da_format.bit_sel = MCDRV_BITSEL_16;
+		port->dir.da_format.mode = MCDRV_DAMODE_HEADALIGN;
+		port->dir.pcm_format.mono = MCDRV_PCM_MONO;
+		port->dir.pcm_format.order = MCDRV_PCM_MSB_FIRST;
+		port->dir.pcm_format.law = MCDRV_PCM_LINEAR;
+		port->dir.pcm_format.bit_sel = MCDRV_PCM_BITSEL_8;
+
+		port->dit.st_mode = MCDRV_STMODE_ZERO;
+		port->dit.edge = MCDRV_SDOUT_NORMAL;
+		port->dit.da_format.bit_sel = MCDRV_BITSEL_16;
+		port->dit.da_format.mode = MCDRV_DAMODE_HEADALIGN;
+		port->dit.pcm_format.mono = MCDRV_PCM_MONO;
+		port->dit.pcm_format.order = MCDRV_PCM_MSB_FIRST;
+		port->dit.pcm_format.law = MCDRV_PCM_LINEAR;
+		port->dit.pcm_format.bit_sel = MCDRV_PCM_BITSEL_8;
+	}
+}
+
+static inline void dio_path_info_init(void)
+{
+	mc_info.dio_path_info.phys_port[0] = MCDRV_PHYSPORT_DIO0;
+	mc_info.dio_path_info.phys_port[1] = MCDRV_PHYSPORT_DIO1;
+	mc_info.dio_path_info.phys_port[2] = MCDRV_PHYSPORT_DIO2;
+	mc_info.dio_path_info.phys_port[3] = MCDRV_PHYSPORT_NONE;
+	mc_info.dio_path_info.music_ch = MCDRV_MUSIC_2CH;
+	mc_info.dio_path_info.music_rslot[0] = 0;
+	mc_info.dio_path_info.music_rslot[1] = 1;
+	mc_info.dio_path_info.music_rslot[2] = 2;
+	mc_info.dio_path_info.music_tslot[0] = 0;
+	mc_info.dio_path_info.music_tslot[1] = 1;
+	mc_info.dio_path_info.music_tslot[2] = 2;
+}
+
+static inline void swap_info_init(void)
+{
+	mc_info.swap_info.adif0 = MCDRV_SWAP_NORMAL;
+	mc_info.swap_info.adif1 = MCDRV_SWAP_NORMAL;
+	mc_info.swap_info.adif2 = MCDRV_SWAP_NORMAL;
+	mc_info.swap_info.dac0 = MCDRV_SWAP_NORMAL;
+	mc_info.swap_info.dac1 = MCDRV_SWAP_NORMAL;
+
+	mc_info.swap_info.music_in0 = MCDRV_SWSWAP_NORMAL;
+	mc_info.swap_info.music_in1 = MCDRV_SWSWAP_NORMAL;
+	mc_info.swap_info.music_in2 = MCDRV_SWSWAP_NORMAL;
+	mc_info.swap_info.ext_in = MCDRV_SWSWAP_NORMAL;
+	mc_info.swap_info.voice_in = MCDRV_SWSWAP_NORMAL;
+	mc_info.swap_info.hifi_in = MCDRV_SWSWAP_NORMAL;
+	mc_info.swap_info.music_out0 = MCDRV_SWSWAP_NORMAL;
+	mc_info.swap_info.music_out1 = MCDRV_SWSWAP_NORMAL;
+	mc_info.swap_info.music_out2 = MCDRV_SWSWAP_NORMAL;
+	mc_info.swap_info.ext_out = MCDRV_SWSWAP_NORMAL;
+	mc_info.swap_info.voice_out = MCDRV_SWSWAP_NORMAL;
+	mc_info.swap_info.hifi_out = MCDRV_SWSWAP_NORMAL;
+}
+
+static inline void hsdet_info_init(void)
+{
+	struct mcdrv_hsdet_info *hsdet;
+
+	hsdet = &mc_info.hsdet_info;
+	hsdet->en_plug_det = MCDRV_PLUGDET_DISABLE;
+	hsdet->en_plug_det_db = MCDRV_PLUGDETDB_DISABLE;
+	hsdet->en_dly_key_off = MCDRV_KEYEN_D_D_D;
+	hsdet->en_dly_key_on = MCDRV_KEYEN_D_D_D;
+	hsdet->en_mic_det = MCDRV_MICDET_DISABLE;
+	hsdet->en_key_off = MCDRV_KEYEN_D_D_D;
+	hsdet->en_key_on = MCDRV_KEYEN_D_D_D;
+	hsdet->hs_det_dbnc = MCDRV_DETDBNC_875;
+	hsdet->key_off_mtim = MCDRV_KEYOFF_MTIM_63;
+	hsdet->key_on_mtim = MCDRV_KEYON_MTIM_63;
+	hsdet->key0_off_dly_tim = 0;
+	hsdet->key1_off_dly_tim = 0;
+	hsdet->key2_off_dly_tim = 0;
+	hsdet->key0_on_dly_tim = 0;
+	hsdet->key1_on_dly_tim = 0;
+	hsdet->key2_on_dly_tim = 0;
+	hsdet->key0_on_dly_tim2 = 0;
+	hsdet->key1_on_dly_tim2 = 0;
+	hsdet->key2_on_dly_tim2 = 0;
+	if (mc_info.device_id == MCDRV_DEV_ID_81_91H)
+		hsdet->irq_type = MCDRV_IRQTYPE_REF;
+	else
+		hsdet->irq_type = MCDRV_IRQTYPE_NORMAL;
+	hsdet->plug_det_db_irq_type = MCDRV_IRQTYPE_REF;
+	hsdet->plug_undet_db_irq_type = MCDRV_IRQTYPE_REF;
+	hsdet->mic_det_irq_type = MCDRV_IRQTYPE_REF;
+	hsdet->plug_det_irq_type = MCDRV_IRQTYPE_REF;
+	hsdet->key0_on_irq_type = MCDRV_IRQTYPE_REF;
+	hsdet->key1_on_irq_type = MCDRV_IRQTYPE_REF;
+	hsdet->key2_on_irq_type = MCDRV_IRQTYPE_REF;
+	hsdet->key0_off_irq_type = MCDRV_IRQTYPE_REF;
+	hsdet->key1_off_irq_type = MCDRV_IRQTYPE_REF;
+	hsdet->key2_off_irq_type = MCDRV_IRQTYPE_REF;
+	hsdet->det_in_inv = MCDRV_DET_IN_INV;
+	hsdet->hs_det_mode = MCDRV_HSDET_MODE_DETIN_A;
+	hsdet->speriod = MCDRV_SPERIOD_3906;
+	hsdet->lperiod = MCDRV_LPERIOD_125000;
+	hsdet->dbnc_num_plug = MCDRV_DBNC_NUM_7;
+	hsdet->dbnc_num_mic = MCDRV_DBNC_NUM_7;
+	hsdet->dbnc_num_key = MCDRV_DBNC_NUM_7;
+	hsdet->sgnl_period = MCDRV_SGNLPERIOD_97;
+	hsdet->sgnl_num = MCDRV_SGNLNUM_8;
+	hsdet->sgnl_peak = MCDRV_SGNLPEAK_1182;
+	hsdet->imp_sel = MCDRV_IMPSEL_MOSTFREQ;
+	hsdet->dly_irq_stop = MCDRV_DLYIRQ_DONTCARE;
+	hsdet->cbfunc = NULL;
+}
+
+static inline void aec_info_init(void)
+{
+	struct mcdrv_aec_info *aec_info;
+	int i;
+
+	aec_info = &mc_info.aec_info;
+	memset(aec_info, 0, sizeof(struct mcdrv_aec_info));
+
+	aec_info->output.lpf_pre_thru[0] = 1;
+	aec_info->output.lpf_post_thru[0] = 1;
+
+	for (i = 0; i < MCDRV_AEC_OUTPUT_N; i++) {
+		aec_info->output.dcc_sel[i] = 2;
+		aec_info->output.osf_sel[i] = 3;
+		aec_info->output.dcl_limit[i][0] = 0x7f;
+		aec_info->output.dcl_limit[i][1] = 0xff;
+		aec_info->output.dc_dither_level[i] = 3;
+		aec_info->output.dng_fw[i] = 1;
+	}
+	aec_info->output.dng_zero[0] = 31;
+	aec_info->output.dng_zero[1] = 9;
+	aec_info->output.dng_time[1] = 2;
+	aec_info->output.osf_gain[0][0] = MCI_OSF_GAIN0_15_8_DEF;
+	aec_info->output.osf_gain[0][1] = MCI_OSF_GAIN0_7_0_DEF;
+	aec_info->output.osf_gain[1][0] = MCI_OSF_GAIN1_15_8_DEF;
+	aec_info->output.osf_gain[1][1] = MCI_OSF_GAIN1_7_0_DEF;
+	aec_info->output.dng_attack = 1;
+	aec_info->output.dng_release = 3;
+	aec_info->output.dng_target[0] = 0x84;
+	if (mc_info.device_id == MCDRV_DEV_ID_80_90H) {
+		aec_info->output.dng_target[1] = MCI_DNG_SP_DEF_ES1;
+		aec_info->output.dng_target_lineout[0] = MCI_DNG_LO1_DEF_ES1;
+		aec_info->output.dng_target_lineout[1] = MCI_DNG_LO2_DEF_ES1;
+		aec_info->output.dng_target_rc = MCI_DNG_RC_DEF_ES1;
+	} else {
+		aec_info->output.dng_target[1] = MCI_DNG_SP_DEF;
+		aec_info->output.dng_target_lineout[0] = MCI_DNG_LO1_DEF;
+		aec_info->output.dng_target_lineout[1] = MCI_DNG_LO2_DEF;
+		aec_info->output.dng_target_rc = MCI_DNG_RC_DEF;
+	}
+
+	for (i = 0; i < MCDRV_AEC_INPUT_N; i++) {
+		aec_info->input.dsf32_l_type[i] = 1;
+		aec_info->input.dsf32_r_type[i] = 1;
+		aec_info->input.dsf4_sel[i] = 1;
+		if (mc_info.device_id == MCDRV_DEV_ID_80_90H)
+			aec_info->input.dcc_sel[i] = 2;
+		else
+			aec_info->input.dcc_sel[i] = 1;
+		aec_info->input.dng_att[i] = 3;
+		aec_info->input.dng_rel[i] = 2;
+		aec_info->input.depop_att[i] = 2;
+		aec_info->input.depop_wait[i] = 2;
+	}
+
+	aec_info->pdm.st_wait = 2;
+
+	aec_info->adj.hold = 24;
+	aec_info->adj.cnt = 10;
+	aec_info->adj.max[0] = 2;
+}
+
+void mc_resource_init(void)
+{
+	path_info_init();
+	vol_info_init();
+	dio_info_init();
+	dio_path_info_init();
+	swap_info_init();
+	hsdet_info_init();
+	aec_info_init();
+
+	mc_info.clk = MCDRV_CLKSW_CLKA;
+	mc_info.clk_sel = 0;
+	mc_info.eclk_sel = 0;
+	mc_info.plug_det_db = 0;
+
+	mc_resource_clear();
+}
+
+void mc_a_registers_init(void)
+{
+	memset(mc_info.a_registers, 0, MCDRV_REG_NUM_A);
+
+	mc_info.a_registers[MCI_A_DEV_ID] = mc_info.id;
+	mc_info.a_registers[MCI_CLK_MSK] = MCI_CLK_MSK_DEF;
+	mc_info.a_registers[MCI_PD] = MCI_PD_DEF;
+	mc_info.a_registers[MCI_DO0_DRV] = MCI_DO0_DRV_DEF;
+	mc_info.a_registers[MCI_DO1_DRV] = MCI_DO1_DRV_DEF;
+	mc_info.a_registers[MCI_DO2_DRV] = MCI_DO2_DRV_DEF;
+	mc_info.a_registers[MCI_PA0] = MCI_PA0_DEF;
+	mc_info.a_registers[MCI_PA1] = MCI_PA1_DEF;
+	mc_info.a_registers[MCI_PA2] = MCI_PA2_DEF;
+	if (mc_info.device_id != MCDRV_DEV_ID_80_90H)
+		mc_info.a_registers[MCI_DOA_DRV] = MCI_DOA_DRV_DEF;
+	mc_info.a_registers[MCI_LP1_FP] = MCI_LP1_FP_DEF;
+	mc_info.a_registers[MCI_LP2_FP] = MCI_LP2_FP_DEF;
+	mc_info.a_registers[MCI_LP3_FP] = MCI_LP3_FP_DEF;
+	mc_info.a_registers[MCI_CLKSRC] = MCI_CLKSRC_DEF;
+	mc_info.a_registers[MCI_FREQ73M] = MCI_FREQ73M_DEF;
+	mc_info.a_registers[MCI_PLL_MODE_A] = MCI_PLL_MODE_A_DEF;
+	mc_info.a_registers[MCI_PLL_MODE_B] = MCI_PLL_MODE_B_DEF;
+}
+
+void mc_mblock_registers_init(void)
+{
+	memset(mc_info.ma_registers, 0, MCDRV_REG_NUM_MA);
+
+	mc_info.ma_registers[MCI_I_VINTP] = MCI_I_VINTP_DEF;
+	mc_info.ma_registers[MCI_O_VINTP] = MCI_O_VINTP_DEF;
+
+	memset(mc_info.mb_registers, 0, MCDRV_REG_NUM_MB);
+
+	mc_info.mb_registers[MCI_LP0_MODE] = MCI_LP0_MODE_DEF;
+	mc_info.mb_registers[MCI_LPR0_SLOT] = MCI_LPR0_SLOT_DEF;
+	mc_info.mb_registers[MCI_LPT0_SLOT] = MCI_LPT0_SLOT_DEF;
+	mc_info.mb_registers[MCI_LPR0_PCM] = MCI_LPR0_PCM_DEF;
+	mc_info.mb_registers[MCI_LPT0_PCM] = MCI_LPT0_PCM_DEF;
+	mc_info.mb_registers[MCI_LP1_MODE] = MCI_LP1_MODE_DEF;
+	mc_info.mb_registers[MCI_LPR1_PCM] = MCI_LPR1_PCM_DEF;
+	mc_info.mb_registers[MCI_LPT1_PCM] = MCI_LPT1_PCM_DEF;
+	mc_info.mb_registers[MCI_LP2_MODE] = MCI_LP2_MODE_DEF;
+	mc_info.mb_registers[MCI_LPR2_PCM] = MCI_LPR2_PCM_DEF;
+	mc_info.mb_registers[MCI_LPT2_PCM] = MCI_LPT2_PCM_DEF;
+
+	memset(mc_info.b_registers, 0, MCDRV_REG_NUM_B);
+
+	mc_e_registers_init();
+}
+
+void mc_e_registers_init(void)
+{
+	memset(mc_info.e_registers, 0, MCDRV_REG_NUM_E);
+
+	mc_info.e_registers[MCI_E1DSP_CTRL] = MCI_E1DSP_CTRL_DEF;
+	mc_info.e_registers[MCI_LPF_THR] = MCI_LPF_THR_DEF;
+	mc_info.e_registers[MCI_DAC_DCC_SEL] = MCI_DAC_DCC_SEL_DEF;
+	if (mc_info.device_id == MCDRV_DEV_ID_81_91H)
+		mc_info.e_registers[MCI_OSF_SEL] = MCI_OSF_SEL_DEF;
+	mc_info.e_registers[MCI_OSF_GAIN0_15_8] = MCI_OSF_GAIN0_15_8_DEF;
+	mc_info.e_registers[MCI_OSF_GAIN0_7_0] = MCI_OSF_GAIN0_7_0_DEF;
+	mc_info.e_registers[MCI_OSF_GAIN1_15_8] = MCI_OSF_GAIN1_15_8_DEF;
+	mc_info.e_registers[MCI_OSF_GAIN1_7_0] = MCI_OSF_GAIN1_7_0_DEF;
+	mc_info.e_registers[MCI_DCL0_LMT_14_8] = MCI_DCL0_LMT_14_8_DEF;
+	mc_info.e_registers[MCI_DCL0_LMT_7_0] = MCI_DCL0_LMT_7_0_DEF;
+	mc_info.e_registers[MCI_DCL1_LMT_14_8] = MCI_DCL1_LMT_14_8_DEF;
+	mc_info.e_registers[MCI_DCL1_LMT_7_0] = MCI_DCL1_LMT_7_0_DEF;
+	switch (mc_info.device_id) {
+	case MCDRV_DEV_ID_80_90H:
+		mc_info.e_registers[MCI_DITHER0] = MCI_DITHER0_DEF;
+		mc_info.e_registers[MCI_DITHER1] = MCI_DITHER1_DEF;
+		mc_info.e_registers[MCI_DNG0_ES1] = MCI_DNG0_DEF_ES1;
+		mc_info.e_registers[MCI_DNG1_ES1] = MCI_DNG1_DEF_ES1;
+		break;
+	case MCDRV_DEV_ID_81_91H:
+		mc_info.e_registers[MCI_DITHER0] = 0x30;
+		mc_info.e_registers[MCI_DITHER1] = 0x30;
+		mc_info.e_registers[MCI_DNG0] = MCI_DNG0_DEF;
+		mc_info.e_registers[MCI_DNG1] = MCI_DNG1_DEF;
+		break;
+	default:
+		break;
+	}
+	mc_info.e_registers[MCI_DPATH_DA_V] = MCI_DPATH_DA_V_DEF;
+	mc_info.e_registers[MCI_DPATH_AD_V] = MCI_DPATH_AD_V_DEF;
+	if (mc_info.device_id == MCDRV_DEV_ID_81_91H)
+		mc_info.e_registers[39] = 0xf4;
+	mc_info.e_registers[MCI_DSF0_PRE_INPUT] = MCI_DSF0_PRE_INPUT_DEF;
+	mc_info.e_registers[MCI_DSF1_FLT_TYPE] = MCI_DSF1_FLT_TYPE_DEF;
+	mc_info.e_registers[MCI_DSF1_PRE_INPUT] = MCI_DSF1_PRE_INPUT_DEF;
+	mc_info.e_registers[MCI_DSF2_PRE_INPUT] = MCI_DSF2_PRE_INPUT_DEF;
+	switch (mc_info.device_id) {
+	case MCDRV_DEV_ID_80_90H:
+		mc_info.e_registers[MCI_ADC_DCC_SEL] = MCI_ADC_DCC_SEL_DEF_ES1;
+		break;
+	case MCDRV_DEV_ID_81_91H:
+		mc_info.e_registers[MCI_ADC_DCC_SEL] = MCI_ADC_DCC_SEL_DEF;
+		break;
+	default:
+		break;
+	}
+	mc_info.e_registers[MCI_ADC_DNG0_FW] = MCI_ADC_DNG0_FW_DEF;
+	mc_info.e_registers[MCI_ADC_DNG1_FW] = MCI_ADC_DNG1_FW_DEF;
+	mc_info.e_registers[MCI_ADC_DNG2_FW] = MCI_ADC_DNG2_FW_DEF;
+	mc_info.e_registers[MCI_DEPOP0] = MCI_DEPOP0_DEF;
+	mc_info.e_registers[MCI_DEPOP1] = MCI_DEPOP1_DEF;
+	mc_info.e_registers[MCI_DEPOP2] = MCI_DEPOP2_DEF;
+	mc_info.e_registers[MCI_PDM_MODE] = MCI_PDM_MODE_DEF;
+	mc_info.e_registers[MCI_E2DSP] = MCI_E2DSP_DEF;
+	if (mc_info.device_id == MCDRV_DEV_ID_81_91H) {
+		mc_info.e_registers[99] = 0xc9;
+		mc_info.e_registers[100] = 0x01;
+	}
+}
+
+void mc_state_update(enum mcdrv_state state)
+{
+	mc_info.state = state;
+}
+
+enum mcdrv_state mc_state_get(void)
+{
+	return mc_info.state;
+}
+
+u8 mc_register_get_value(u16 type, u16 addr)
+{
+	u8 val = 0;
+
+	switch (type) {
+	case MCDRV_PACKET_REGTYPE_IF:
+		val = mc_info.if_registers[addr];
+		break;
+	case MCDRV_PACKET_REGTYPE_A:
+		val = mc_info.a_registers[addr];
+		break;
+	case MCDRV_PACKET_REGTYPE_MA:
+		val = mc_info.ma_registers[addr];
+		break;
+	case MCDRV_PACKET_REGTYPE_MB:
+		val = mc_info.mb_registers[addr];
+		break;
+	case MCDRV_PACKET_REGTYPE_E:
+		val = mc_info.e_registers[addr];
+		break;
+	case MCDRV_PACKET_REGTYPE_ANA:
+		val = mc_info.ana_registers[addr];
+		break;
+	case MCDRV_PACKET_REGTYPE_CD:
+		val = mc_info.cd_registers[addr];
+		break;
+
+	default:
+		break;
+	}
+
+	return val;
+}
+
+void mc_register_set_value(u16 type, u16 addr, u8 val)
+{
+	switch (type) {
+	case MCDRV_PACKET_REGTYPE_IF:
+		mc_info.if_registers[addr] = val;
+		break;
+	case MCDRV_PACKET_REGTYPE_A:
+		mc_info.a_registers[addr] = val;
+		break;
+	case MCDRV_PACKET_REGTYPE_MA:
+		mc_info.ma_registers[addr] = val;
+		break;
+	case MCDRV_PACKET_REGTYPE_MB:
+		mc_info.mb_registers[addr] = val;
+		break;
+	case MCDRV_PACKET_REGTYPE_E:
+		mc_info.e_registers[addr] = val;
+		break;
+	case MCDRV_PACKET_REGTYPE_ANA:
+		mc_info.ana_registers[addr] = val;
+		break;
+	case MCDRV_PACKET_REGTYPE_CD:
+		mc_info.cd_registers[addr] = val;
+		break;
+	default:
+		break;
+	}
+}
+
+void mc_dev_info_set(struct mcdrv_dev_info *dev_info)
+{
+	mc_info.dev_info = *dev_info;
+}
+
+void mc_dev_info_get(struct mcdrv_dev_info *dev_info)
+{
+	*dev_info = mc_info.dev_info;
+}
+
+int mc_clock_set(u8 clock)
+{
+	mc_info.clk = clock;
+
+	mc_packet_add_switch_clock(clock);
+
+	return mc_packet_execute();
+}
+
+void mc_clock_get(u8 *clock)
+{
+	*clock = mc_info.clk;
+}
+
+static void source_set_onoff(u32 src, u32 *dst, u32 on, u32 off)
+{
+	if (dst) {
+		if (src & on) {
+			*dst &= ~off;
+			*dst |= on;
+		} else if ((src & (on | off)) == off) {
+			*dst &= ~on;
+			*dst |= off;
+		}
+	}
+}
+
+static void d1_source_set_onoff(u32 *src, u32 *dst, u8 channels)
+{
+	int i, j;
+
+	struct {
+		u32 on;
+		u32 off;
+	} d1_src[] = {
+		{ MCDRV_D1SRC_MUSICIN_ON, MCDRV_D1SRC_MUSICIN_OFF },
+		{ MCDRV_D1SRC_EXTIN_ON, MCDRV_D1SRC_EXTIN_OFF },
+		{ MCDRV_D1SRC_VBOXOUT_ON, MCDRV_D1SRC_VBOXOUT_OFF },
+		{ MCDRV_D1SRC_VBOXREFOUT_ON, MCDRV_D1SRC_VBOXREFOUT_OFF },
+		{ MCDRV_D1SRC_AE0_ON, MCDRV_D1SRC_AE0_OFF },
+		{ MCDRV_D1SRC_AE1_ON, MCDRV_D1SRC_AE1_OFF },
+		{ MCDRV_D1SRC_AE2_ON, MCDRV_D1SRC_AE2_OFF },
+		{ MCDRV_D1SRC_AE3_ON, MCDRV_D1SRC_AE3_OFF },
+		{ MCDRV_D1SRC_ADIF0_ON, MCDRV_D1SRC_ADIF0_OFF },
+		{ MCDRV_D1SRC_ADIF1_ON, MCDRV_D1SRC_ADIF1_OFF },
+		{ MCDRV_D1SRC_ADIF2_ON, MCDRV_D1SRC_ADIF2_OFF },
+		{ MCDRV_D1SRC_HIFIIN_ON, MCDRV_D1SRC_HIFIIN_OFF }
+	};
+
+	for (i = 0; i < channels; i++) {
+		for (j = 0; j < ARRAY_SIZE(d1_src); j++)
+			source_set_onoff(src[i], &dst[i],
+					 d1_src[j].on, d1_src[j].off);
+	}
+}
+
+static void d2_source_set_onoff(u32 *src, u32 *dst, u8 channels)
+{
+	u32 on, off;
+	int i, j;
+
+	struct {
+		u32 on;
+		u32 off;
+	} d2_src[] = {
+		{ MCDRV_D2SRC_VOICEIN_ON, MCDRV_D2SRC_VOICEIN_OFF },
+		{ MCDRV_D2SRC_VBOXIOOUT_ON, MCDRV_D2SRC_VBOXIOOUT_OFF },
+		{ MCDRV_D2SRC_VBOXHOSTOUT_ON, MCDRV_D2SRC_VBOXHOSTOUT_OFF },
+		{ MCDRV_D2SRC_ADC0_L_ON, MCDRV_D2SRC_ADC0_L_OFF },
+		{ MCDRV_D2SRC_ADC0_R_ON, MCDRV_D2SRC_ADC0_R_OFF },
+		{ MCDRV_D2SRC_ADC1_ON, MCDRV_D2SRC_ADC1_OFF },
+		{ MCDRV_D2SRC_PDM0_L_ON, MCDRV_D2SRC_PDM0_L_OFF },
+		{ MCDRV_D2SRC_PDM0_R_ON, MCDRV_D2SRC_PDM0_R_OFF },
+		{ MCDRV_D2SRC_PDM1_L_ON, MCDRV_D2SRC_PDM1_L_OFF },
+		{ MCDRV_D2SRC_PDM1_R_ON, MCDRV_D2SRC_PDM1_R_OFF },
+		{ MCDRV_D2SRC_DAC0REF_ON, MCDRV_D2SRC_DAC0REF_OFF },
+		{ MCDRV_D2SRC_DAC1REF_ON, MCDRV_D2SRC_DAC1REF_OFF }
+	};
+
+	for (i = 0; i < channels; i++) {
+		for (j = 0; j < ARRAY_SIZE(d2_src); j++) {
+			on = d2_src[j].on;
+			off = d2_src[j].off;
+			if ((src[i] & on)
+			    && (on == MCDRV_D2SRC_PDM0_L_ON ||
+				on == MCDRV_D2SRC_PDM0_R_ON ||
+				on == MCDRV_D2SRC_PDM1_L_ON ||
+				on == MCDRV_D2SRC_PDM1_R_ON)
+			    && mc_info.dev_info.pa0_func != MCDRV_PA_PDMCK)
+				break;
+
+			source_set_onoff(src[i], &dst[i], on, off);
+		}
+	}
+}
+
+static void a_source_set_onoff(u32 *src, u32 *dst, u8 channels)
+{
+	int i, j;
+
+	struct {
+		u32 on;
+		u32 off;
+	} a_src[] = {
+		{ MCDRV_ASRC_DAC0_L_ON, MCDRV_ASRC_DAC0_L_OFF },
+		{ MCDRV_ASRC_DAC0_R_ON, MCDRV_ASRC_DAC0_R_OFF },
+		{ MCDRV_ASRC_DAC1_L_ON, MCDRV_ASRC_DAC1_L_OFF },
+		{ MCDRV_ASRC_DAC1_R_ON, MCDRV_ASRC_DAC1_R_OFF },
+		{ MCDRV_ASRC_MIC1_ON, MCDRV_ASRC_MIC1_OFF },
+		{ MCDRV_ASRC_MIC2_ON, MCDRV_ASRC_MIC2_OFF },
+		{ MCDRV_ASRC_MIC3_ON, MCDRV_ASRC_MIC3_OFF },
+		{ MCDRV_ASRC_MIC4_ON, MCDRV_ASRC_MIC4_OFF },
+		{ MCDRV_ASRC_LINEIN1_L_ON, MCDRV_ASRC_LINEIN1_L_OFF },
+		{ MCDRV_ASRC_LINEIN1_R_ON, MCDRV_ASRC_LINEIN1_R_OFF },
+		{ MCDRV_ASRC_LINEIN1_M_ON, MCDRV_ASRC_LINEIN1_M_OFF }
+	};
+
+	for (i = 0; i < channels; i++) {
+		for (j = 0; j < ARRAY_SIZE(a_src); j++)
+			source_set_onoff(src[i], &dst[i],
+					 a_src[j].on, a_src[j].off);
+	}
+}
+
+static inline void bias_source_set_onoff(struct mcdrv_path_info *path_info)
+{
+	int i, j;
+
+	struct {
+		u32 on;
+		u32 off;
+	} bias[] = {
+		{ MCDRV_ASRC_MIC1_ON, MCDRV_ASRC_MIC1_OFF },
+		{ MCDRV_ASRC_MIC2_ON, MCDRV_ASRC_MIC2_OFF },
+		{ MCDRV_ASRC_MIC3_ON, MCDRV_ASRC_MIC3_OFF },
+		{ MCDRV_ASRC_MIC4_ON, MCDRV_ASRC_MIC4_OFF }
+	};
+
+	for (i = 0; i < BIAS_PATH_CHANNELS; i++) {
+		for (j = 0; j < ARRAY_SIZE(bias); j++) {
+			source_set_onoff(path_info->bias[i],
+					 &mc_info.path_info.bias[i],
+					 bias[j].on, bias[j].off);
+		}
+	}
+}
+
+static inline int is_valid_path(void)
+{
+	u32 dac[2], adif[2], src;
+	int used, i;
+
+	dac[0] = mc_info.path_info.dac0[0];
+	dac[1] = mc_info.path_info.dac0[1];
+
+	if ((dac[0] & MCDRV_D1SRC_HIFIIN_ON)
+	    || (dac[1] & MCDRV_D1SRC_HIFIIN_ON)) {
+		if ((dac[0] & (MCDRV_D1SRC_ALL_ON & ~MCDRV_D1SRC_HIFIIN_ON))
+		    || (dac[1] & (MCDRV_D1SRC_ALL_ON & ~MCDRV_D1SRC_HIFIIN_ON)))
+			return -EINVAL;
+
+		if (mc_info.device_id == MCDRV_DEV_ID_80_90H) {
+			for (i = 0; i < MUSICOUT_PATH_CHANNELS; i++) {
+				src = mc_info.path_info.music_out[i];
+				if (src & MCDRV_D1SRC_ADIF0_ON)
+					return -EINVAL;
+			}
+
+			for (i = 0; i < EXTOUT_PATH_CHANNELS; i++) {
+				src = mc_info.path_info.ext_out[i];
+				if (src & MCDRV_D1SRC_ADIF0_ON)
+					return -EINVAL;
+			}
+
+			for (i = 0; i < VBOXMIXIN_PATH_CHANNELS; i++) {
+				src = mc_info.path_info.vbox_mix_in[i];
+				if (src & MCDRV_D1SRC_ADIF0_ON)
+					return -EINVAL;
+			}
+
+			for (i = 0; i < AE_PATH_CHANNELS; i++) {
+				src = mc_info.path_info.ae0[i];
+				if (src & MCDRV_D1SRC_ADIF0_ON)
+					return -EINVAL;
+
+				src = mc_info.path_info.ae1[i];
+				if (src & MCDRV_D1SRC_ADIF0_ON)
+					return -EINVAL;
+
+				src = mc_info.path_info.ae2[i];
+				if (src & MCDRV_D1SRC_ADIF0_ON)
+					return -EINVAL;
+
+				src = mc_info.path_info.ae3[i];
+				if (src & MCDRV_D1SRC_ADIF0_ON)
+					return -EINVAL;
+			}
+
+			for (i = 0; i < DAC1_PATH_CHANNELS; i++) {
+				src = mc_info.path_info.dac1[i];
+				if (src & MCDRV_D1SRC_ADIF0_ON)
+					return -EINVAL;
+			}
+		}
+	}
+
+	dac[0] = mc_info.path_info.dac1[0];
+	dac[1] = mc_info.path_info.dac1[1];
+
+	if ((dac[0] & MCDRV_D1SRC_HIFIIN_ON)
+	    || (dac[1] & MCDRV_D1SRC_HIFIIN_ON)) {
+		if ((dac[0] & (MCDRV_D1SRC_ALL_ON & ~MCDRV_D1SRC_HIFIIN_ON))
+		    || (dac[1] & (MCDRV_D1SRC_ALL_ON & ~MCDRV_D1SRC_HIFIIN_ON)))
+			return -EINVAL;
+	}
+
+	for (i = 0; i < ADIF0_PATH_CHANNELS; i++) {
+		adif[i] = mc_info.path_info.adif0[i];
+
+		used = 0;
+		if (adif[i] & MCDRV_D2SRC_ADC0_L_ON)
+			used++;
+		if (adif[i] & MCDRV_D2SRC_ADC0_R_ON)
+			used++;
+		if (adif[i] & MCDRV_D2SRC_ADC1_ON)
+			used++;
+		if (adif[i] & MCDRV_D2SRC_PDM0_L_ON)
+			used++;
+		if (adif[i] & MCDRV_D2SRC_PDM0_R_ON)
+			used++;
+		if (adif[i] & MCDRV_D2SRC_PDM1_L_ON)
+			used++;
+		if (adif[i] & MCDRV_D2SRC_PDM1_R_ON)
+			used++;
+		if (used > 1)
+			return -EINVAL;
+	}
+
+	if (adif[0] == D2SRC_ALL_OFF && adif[1] != D2SRC_ALL_OFF)
+		return -EINVAL;
+
+	for (i = 0; i < ADIF1_PATH_CHANNELS; i++) {
+		adif[i] = mc_info.path_info.adif1[i];
+
+		used = 0;
+		if (adif[i] & MCDRV_D2SRC_ADC0_L_ON)
+			used++;
+		if (adif[i] & MCDRV_D2SRC_ADC0_R_ON)
+			used++;
+		if (adif[i] & MCDRV_D2SRC_ADC1_ON)
+			used++;
+		if (adif[i] & MCDRV_D2SRC_PDM0_L_ON)
+			used++;
+		if (adif[i] & MCDRV_D2SRC_PDM0_R_ON)
+			used++;
+		if (adif[i] & MCDRV_D2SRC_PDM1_L_ON)
+			used++;
+		if (adif[i] & MCDRV_D2SRC_PDM1_R_ON)
+			used++;
+		if (used > 1)
+			return -EINVAL;
+	}
+
+	if (adif[0] == D2SRC_ALL_OFF && adif[1] != D2SRC_ALL_OFF)
+		return -EINVAL;
+
+	for (i = 0; i < ADIF2_PATH_CHANNELS; i++) {
+		if (!i)
+			adif[i] = mc_source_get(MCDRV_DST_ADIF2, MCDRV_DST_CH0);
+		else
+			adif[i] = mc_source_get(MCDRV_DST_ADIF2, MCDRV_DST_CH1);
+
+		used = 0;
+		if (adif[i] & MCDRV_D2SRC_ADC0_L_ON)
+			used++;
+		if (adif[i] & MCDRV_D2SRC_ADC0_R_ON)
+			used++;
+		if (adif[i] & MCDRV_D2SRC_ADC1_ON)
+			used++;
+		if (adif[i] & MCDRV_D2SRC_PDM0_L_ON)
+			used++;
+		if (adif[i] & MCDRV_D2SRC_PDM0_R_ON)
+			used++;
+		if (adif[i] & MCDRV_D2SRC_PDM1_L_ON)
+			used++;
+		if (adif[i] & MCDRV_D2SRC_PDM1_R_ON)
+			used++;
+		if (adif[i] & MCDRV_D2SRC_DAC0REF_ON)
+			used++;
+		if (adif[i] & MCDRV_D2SRC_DAC1REF_ON)
+			used++;
+		if (used > 1)
+			return -EINVAL;
+	}
+
+	if (!(adif[0] & ~D2SRC_ALL_OFF)
+	    && (adif[1] & ~D2SRC_ALL_OFF))
+		return -EINVAL;
+
+	if ((adif[0] & MCDRV_D2SRC_DAC0REF_ON)
+	    && (adif[1] & ~MCDRV_D2SRC_DAC0REF_ON))
+		return -EINVAL;
+
+	if ((adif[1] & MCDRV_D2SRC_DAC0REF_ON)
+	    && (adif[0] & ~MCDRV_D2SRC_DAC0REF_ON))
+		return -EINVAL;
+
+	if ((adif[0] & MCDRV_D2SRC_DAC1REF_ON)
+	    && (adif[1] & ~MCDRV_D2SRC_DAC1REF_ON))
+		return -EINVAL;
+
+	if ((adif[1] & MCDRV_D2SRC_DAC1REF_ON)
+	    && (adif[0] & ~MCDRV_D2SRC_DAC1REF_ON))
+		return -EINVAL;
+
+	for (i = 0; i < ADC0_PATH_CHANNELS; i++) {
+		used = 0;
+		src = mc_info.path_info.adc0[i];
+		if (src & MCDRV_ASRC_LINEIN1_L_ON)
+			used++;
+		if (src & MCDRV_ASRC_LINEIN1_R_ON)
+			used++;
+		if (src & MCDRV_ASRC_LINEIN1_M_ON)
+			used++;
+		if (used > 1)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static inline int phys_port_check(void)
+{
+	u32 port[4] = { MCDRV_PHYSPORT_NONE, MCDRV_PHYSPORT_NONE,
+		MCDRV_PHYSPORT_NONE, MCDRV_PHYSPORT_NONE
+	};
+	int i, j;
+
+	if (mc_source_is_used(MCDRV_DST_MUSICOUT, MCDRV_DST_CH0)
+	    || mc_source_is_used(MCDRV_DST_MUSICOUT, MCDRV_DST_CH1)
+	    || mc_d1_source_is_used(MCDRV_D1SRC_MUSICIN_ON)) {
+		port[0] = mc_info.dio_path_info.phys_port[0];
+		if (port[0] == MCDRV_PHYSPORT_NONE)
+			return -EINVAL;
+	}
+
+	if (mc_source_is_used(MCDRV_DST_EXTOUT, MCDRV_DST_CH0)
+	    || mc_source_is_used(MCDRV_DST_EXTOUT, MCDRV_DST_CH1)
+	    || mc_d1_source_is_used(MCDRV_D1SRC_EXTIN_ON)) {
+		port[1] = mc_info.dio_path_info.phys_port[1];
+		if (port[1] == MCDRV_PHYSPORT_NONE)
+			return -EINVAL;
+	}
+
+	if (mc_source_is_used(MCDRV_DST_VOICEOUT, MCDRV_DST_CH0)
+	    || mc_source_is_used(MCDRV_DST_VBOXIOIN, MCDRV_DST_CH0)
+	    || mc_source_is_used(MCDRV_DST_VBOXIOIN, MCDRV_DST_CH0)) {
+		port[2] = mc_info.dio_path_info.phys_port[2];
+		if (port[2] == MCDRV_PHYSPORT_NONE)
+			return -EINVAL;
+	}
+
+	if (mc_source_is_used(MCDRV_DST_HIFIOUT, MCDRV_DST_CH0)
+	    || mc_d1_source_is_used(MCDRV_D1SRC_HIFIIN_ON)) {
+		port[3] = mc_info.dio_path_info.phys_port[3];
+		if (port[3] == MCDRV_PHYSPORT_NONE)
+			return -EINVAL;
+	}
+
+	for (i = 0; i < 4; i++) {
+		if (port[i] == MCDRV_PHYSPORT_NONE)
+			continue;
+
+		for (j = i + 1; j < 4; j++) {
+			if (port[i] == port[j])
+				return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static inline int adc_validate(void)
+{
+	struct mcdrv_path_info *path_info;
+	u32 hifi_out;
+	int has_src, i, ret = 0;
+
+	path_info = &mc_info.path_info;
+
+	has_src = 0;
+	if (mc_source_is_used(MCDRV_DST_ADIF0, MCDRV_DST_CH0)
+	    || mc_source_is_used(MCDRV_DST_ADIF0, MCDRV_DST_CH1))
+		has_src = 1;
+
+	hifi_out = path_info->hifi_out[0];
+
+	if ((mc_d1_source_is_used(MCDRV_D1SRC_ADIF0_ON)
+	     || (hifi_out & MCDRV_D1SRC_ADIF0_ON)) && !has_src) {
+		for (i = 0; i < MUSICOUT_PATH_CHANNELS; i++) {
+			path_info->music_out[i] &= ~MCDRV_D1SRC_ADIF0_ON;
+			path_info->music_out[i] |= MCDRV_D1SRC_ADIF0_OFF;
+		}
+
+		for (i = 0; i < EXTOUT_PATH_CHANNELS; i++) {
+			path_info->ext_out[i] &= ~MCDRV_D1SRC_ADIF0_ON;
+			path_info->ext_out[i] |= MCDRV_D1SRC_ADIF0_OFF;
+		}
+
+		for (i = 0; i < HIFIOUT_PATH_CHANNELS; i++) {
+			path_info->hifi_out[i] &= ~MCDRV_D1SRC_ADIF0_ON;
+			path_info->hifi_out[i] |= MCDRV_D1SRC_ADIF0_OFF;
+		}
+
+		for (i = 0; i < VBOXMIXIN_PATH_CHANNELS; i++) {
+			path_info->vbox_mix_in[i] &= ~MCDRV_D1SRC_ADIF0_ON;
+			path_info->vbox_mix_in[i] |= MCDRV_D1SRC_ADIF0_OFF;
+		}
+
+		for (i = 0; i < AE_PATH_CHANNELS; i++) {
+			path_info->ae0[i] &= ~MCDRV_D1SRC_ADIF0_ON;
+			path_info->ae0[i] |= MCDRV_D1SRC_ADIF0_OFF;
+			path_info->ae1[i] &= ~MCDRV_D1SRC_ADIF0_ON;
+			path_info->ae1[i] |= MCDRV_D1SRC_ADIF0_OFF;
+			path_info->ae2[i] &= ~MCDRV_D1SRC_ADIF0_ON;
+			path_info->ae2[i] |= MCDRV_D1SRC_ADIF0_OFF;
+			path_info->ae3[i] &= ~MCDRV_D1SRC_ADIF0_ON;
+			path_info->ae3[i] |= MCDRV_D1SRC_ADIF0_OFF;
+		}
+
+		for (i = 0; i < DAC0_PATH_CHANNELS; i++) {
+			path_info->dac0[i] &= ~MCDRV_D1SRC_ADIF0_ON;
+			path_info->dac0[i] |= MCDRV_D1SRC_ADIF0_OFF;
+		}
+
+		for (i = 0; i < DAC1_PATH_CHANNELS; i++) {
+			path_info->dac1[i] &= ~MCDRV_D1SRC_ADIF0_ON;
+			path_info->dac1[i] |= MCDRV_D1SRC_ADIF0_OFF;
+		}
+
+		ret = 1;
+	}
+
+	has_src = 0;
+	if (mc_source_is_used(MCDRV_DST_ADIF1, MCDRV_DST_CH0)
+	    || mc_source_is_used(MCDRV_DST_ADIF1, MCDRV_DST_CH1))
+		has_src = 1;
+	if (mc_d1_source_is_used(MCDRV_D1SRC_ADIF1_ON) && !has_src) {
+		for (i = 0; i < MUSICOUT_PATH_CHANNELS; i++) {
+			path_info->music_out[i] &= ~MCDRV_D1SRC_ADIF1_ON;
+			path_info->music_out[i] |= MCDRV_D1SRC_ADIF1_OFF;
+		}
+
+		for (i = 0; i < EXTOUT_PATH_CHANNELS; i++) {
+			path_info->ext_out[i] &= ~MCDRV_D1SRC_ADIF1_ON;
+			path_info->ext_out[i] |= MCDRV_D1SRC_ADIF1_OFF;
+		}
+
+		for (i = 0; i < HIFIOUT_PATH_CHANNELS; i++) {
+			path_info->hifi_out[i] &= ~MCDRV_D1SRC_ADIF1_ON;
+			path_info->hifi_out[i] |= MCDRV_D1SRC_ADIF1_OFF;
+		}
+
+		for (i = 0; i < VBOXMIXIN_PATH_CHANNELS; i++) {
+			path_info->vbox_mix_in[i] &= ~MCDRV_D1SRC_ADIF1_ON;
+			path_info->vbox_mix_in[i] |= MCDRV_D1SRC_ADIF1_OFF;
+		}
+
+		for (i = 0; i < AE_PATH_CHANNELS; i++) {
+			path_info->ae0[i] &= ~MCDRV_D1SRC_ADIF1_ON;
+			path_info->ae0[i] |= MCDRV_D1SRC_ADIF1_OFF;
+			path_info->ae1[i] &= ~MCDRV_D1SRC_ADIF1_ON;
+			path_info->ae1[i] |= MCDRV_D1SRC_ADIF1_OFF;
+			path_info->ae2[i] &= ~MCDRV_D1SRC_ADIF1_ON;
+			path_info->ae2[i] |= MCDRV_D1SRC_ADIF1_OFF;
+			path_info->ae3[i] &= ~MCDRV_D1SRC_ADIF1_ON;
+			path_info->ae3[i] |= MCDRV_D1SRC_ADIF1_OFF;
+		}
+
+		for (i = 0; i < DAC0_PATH_CHANNELS; i++) {
+			path_info->dac0[i] &= ~MCDRV_D1SRC_ADIF1_ON;
+			path_info->dac0[i] |= MCDRV_D1SRC_ADIF1_OFF;
+		}
+
+		for (i = 0; i < DAC1_PATH_CHANNELS; i++) {
+			path_info->dac1[i] &= ~MCDRV_D1SRC_ADIF1_ON;
+			path_info->dac1[i] |= MCDRV_D1SRC_ADIF1_OFF;
+		}
+
+		ret = 1;
+	}
+
+	has_src = 0;
+	if (mc_source_is_used(MCDRV_DST_ADIF2, MCDRV_DST_CH0)
+	    || mc_source_is_used(MCDRV_DST_ADIF2, MCDRV_DST_CH1))
+		has_src = 1;
+	if (mc_d1_source_is_used(MCDRV_D1SRC_ADIF2_ON) && !has_src) {
+		for (i = 0; i < MUSICOUT_PATH_CHANNELS; i++) {
+			path_info->music_out[i] &= ~MCDRV_D1SRC_ADIF2_ON;
+			path_info->music_out[i] |= MCDRV_D1SRC_ADIF2_OFF;
+		}
+
+		for (i = 0; i < EXTOUT_PATH_CHANNELS; i++) {
+			path_info->ext_out[i] &= ~MCDRV_D1SRC_ADIF2_ON;
+			path_info->ext_out[i] |= MCDRV_D1SRC_ADIF2_OFF;
+		}
+
+		for (i = 0; i < HIFIOUT_PATH_CHANNELS; i++) {
+			path_info->hifi_out[i] &= ~MCDRV_D1SRC_ADIF2_ON;
+			path_info->hifi_out[i] |= MCDRV_D1SRC_ADIF2_OFF;
+		}
+
+		for (i = 0; i < VBOXMIXIN_PATH_CHANNELS; i++) {
+			path_info->vbox_mix_in[i] &= ~MCDRV_D1SRC_ADIF2_ON;
+			path_info->vbox_mix_in[i] |= MCDRV_D1SRC_ADIF2_OFF;
+		}
+
+		for (i = 0; i < AE_PATH_CHANNELS; i++) {
+			path_info->ae0[i] &= ~MCDRV_D1SRC_ADIF2_ON;
+			path_info->ae0[i] |= MCDRV_D1SRC_ADIF2_OFF;
+			path_info->ae1[i] &= ~MCDRV_D1SRC_ADIF2_ON;
+			path_info->ae1[i] |= MCDRV_D1SRC_ADIF2_OFF;
+			path_info->ae2[i] &= ~MCDRV_D1SRC_ADIF2_ON;
+			path_info->ae2[i] |= MCDRV_D1SRC_ADIF2_OFF;
+			path_info->ae3[i] &= ~MCDRV_D1SRC_ADIF2_ON;
+			path_info->ae3[i] |= MCDRV_D1SRC_ADIF2_OFF;
+		}
+
+		for (i = 0; i < DAC0_PATH_CHANNELS; i++) {
+			path_info->dac0[i] &= ~MCDRV_D1SRC_ADIF2_ON;
+			path_info->dac0[i] |= MCDRV_D1SRC_ADIF2_OFF;
+		}
+
+		for (i = 0; i < DAC1_PATH_CHANNELS; i++) {
+			path_info->dac1[i] &= ~MCDRV_D1SRC_ADIF2_ON;
+			path_info->dac1[i] |= MCDRV_D1SRC_ADIF2_OFF;
+		}
+
+		ret = 1;
+	}
+
+	has_src = 0;
+	if (mc_source_is_used(MCDRV_DST_ADC0, MCDRV_DST_CH0))
+		has_src = 1;
+	if (!mc_d2_source_is_used(MCDRV_D2SRC_ADC0_L_ON)) {
+		if (has_src) {
+			path_info->adc0[0] = D2SRC_ALL_OFF;
+			ret = 1;
+		}
+	} else if (!has_src) {
+		for (i = 0; i < ADIF0_PATH_CHANNELS; i++) {
+			path_info->adif0[i] &= ~MCDRV_D2SRC_ADC0_L_ON;
+			path_info->adif0[i] |= MCDRV_D2SRC_ADC0_L_OFF;
+		}
+
+		for (i = 0; i < ADIF1_PATH_CHANNELS; i++) {
+			path_info->adif1[i] &= ~MCDRV_D2SRC_ADC0_L_ON;
+			path_info->adif1[i] |= MCDRV_D2SRC_ADC0_L_OFF;
+		}
+
+		for (i = 0; i < ADIF2_PATH_CHANNELS; i++) {
+			path_info->adif2[i] &= ~MCDRV_D2SRC_ADC0_L_ON;
+			path_info->adif2[i] |= MCDRV_D2SRC_ADC0_L_OFF;
+		}
+
+		ret = 1;
+	}
+
+	has_src = 0;
+	if (mc_source_is_used(MCDRV_DST_ADC0, MCDRV_DST_CH1))
+		has_src = 1;
+	if (!mc_d2_source_is_used(MCDRV_D2SRC_ADC0_R_ON)) {
+		if (has_src) {
+			path_info->adc0[1] = D2SRC_ALL_OFF;
+			ret = 1;
+		}
+	} else if (!has_src) {
+		for (i = 0; i < ADIF0_PATH_CHANNELS; i++) {
+			path_info->adif0[i] &= ~MCDRV_D2SRC_ADC0_R_ON;
+			path_info->adif0[i] |= MCDRV_D2SRC_ADC0_R_OFF;
+		}
+
+		for (i = 0; i < ADIF1_PATH_CHANNELS; i++) {
+			path_info->adif1[i] &= ~MCDRV_D2SRC_ADC0_R_ON;
+			path_info->adif1[i] |= MCDRV_D2SRC_ADC0_R_OFF;
+		}
+
+		for (i = 0; i < ADIF2_PATH_CHANNELS; i++) {
+			path_info->adif2[i] &= ~MCDRV_D2SRC_ADC0_R_ON;
+			path_info->adif2[i] |= MCDRV_D2SRC_ADC0_R_OFF;
+		}
+
+		ret = 1;
+	}
+
+	has_src = 0;
+	if (mc_source_is_used(MCDRV_DST_ADC1, MCDRV_DST_CH0))
+		has_src = 1;
+	if (!mc_d2_source_is_used(MCDRV_D2SRC_ADC1_ON)) {
+		if (has_src) {
+			for (i = 0; i < ADC1_PATH_CHANNELS; i++)
+				path_info->adc1[i] = D2SRC_ALL_OFF;
+			ret = 1;
+		}
+	} else if (!has_src) {
+		for (i = 0; i < ADIF0_PATH_CHANNELS; i++) {
+			path_info->adif0[i] &= ~MCDRV_D2SRC_ADC1_ON;
+			path_info->adif0[i] |= MCDRV_D2SRC_ADC1_OFF;
+		}
+
+		for (i = 0; i < ADIF1_PATH_CHANNELS; i++) {
+			path_info->adif1[i] &= ~MCDRV_D2SRC_ADC1_ON;
+			path_info->adif1[i] |= MCDRV_D2SRC_ADC1_OFF;
+		}
+
+		for (i = 0; i < ADIF2_PATH_CHANNELS; i++) {
+			path_info->adif2[i] &= ~MCDRV_D2SRC_ADC1_ON;
+			path_info->adif2[i] |= MCDRV_D2SRC_ADC1_OFF;
+		}
+
+		ret = 1;
+	}
+
+	return ret;
+}
+
+static inline int dac_validate(void)
+{
+	struct mcdrv_path_info *path_info;
+	int has_src, used, i, ret = 0;
+
+	path_info = &mc_info.path_info;
+
+	has_src = 0;
+	used = 0;
+	if (mc_source_is_used(MCDRV_DST_DAC0, MCDRV_DST_CH0)
+	    || mc_source_is_used(MCDRV_DST_DAC0, MCDRV_DST_CH1))
+		has_src = 1;
+
+	if (mc_a_source_is_used(MCDRV_ASRC_DAC0_L_ON)
+	    || mc_a_source_is_used(MCDRV_ASRC_DAC0_R_ON))
+		used = 1;
+	else {
+		for (i = 0; i < ADIF2_PATH_CHANNELS; i++) {
+			if (path_info->adif2[i] & MCDRV_D2SRC_DAC0REF_ON)
+				used = 1;
+		}
+	}
+	if (!has_src) {
+		if (used) {
+			for (i = 0; i < HP_PATH_CHANNELS; i++) {
+				path_info->hp[i] &= ~MCDRV_ASRC_DAC0_L_ON;
+				path_info->hp[i] |= MCDRV_ASRC_DAC0_L_OFF;
+				path_info->hp[i] &= ~MCDRV_ASRC_DAC0_R_ON;
+				path_info->hp[i] |= MCDRV_ASRC_DAC0_R_OFF;
+			}
+
+			for (i = 0; i < RC_PATH_CHANNELS; i++) {
+				path_info->rc[i] &= ~MCDRV_ASRC_DAC0_L_ON;
+				path_info->rc[i] |= MCDRV_ASRC_DAC0_L_OFF;
+				path_info->rc[i] &= ~MCDRV_ASRC_DAC0_R_ON;
+				path_info->rc[i] |= MCDRV_ASRC_DAC0_R_OFF;
+			}
+
+			for (i = 0; i < LOUT1_PATH_CHANNELS; i++) {
+				path_info->lout1[i] &= ~MCDRV_ASRC_DAC0_L_ON;
+				path_info->lout1[i] |= MCDRV_ASRC_DAC0_L_OFF;
+				path_info->lout1[i] &= ~MCDRV_ASRC_DAC0_R_ON;
+				path_info->lout1[i] |= MCDRV_ASRC_DAC0_R_OFF;
+			}
+
+			ret = 1;
+		}
+
+		for (i = 0; i < ADIF2_PATH_CHANNELS; i++) {
+			if (path_info->adif2[i] & MCDRV_D2SRC_DAC0REF_ON) {
+				path_info->adif2[i] &= ~MCDRV_D2SRC_DAC0REF_ON;
+				ret = 1;
+			}
+		}
+	}
+
+	has_src = 0;
+	used = 0;
+	if (mc_source_is_used(MCDRV_DST_DAC1, MCDRV_DST_CH0)
+	    || mc_source_is_used(MCDRV_DST_DAC1, MCDRV_DST_CH1))
+		has_src = 1;
+	if (mc_a_source_is_used(MCDRV_ASRC_DAC1_L_ON)
+	    || mc_a_source_is_used(MCDRV_ASRC_DAC1_R_ON))
+		used = 1;
+	else {
+		for (i = 0; i < ADIF2_PATH_CHANNELS; i++) {
+			if (path_info->adif2[i] & MCDRV_D2SRC_DAC1REF_ON)
+				used = 1;
+		}
+	}
+	if (!has_src) {
+		if (used) {
+			ret = 1;
+			for (i = 0; i < SP_PATH_CHANNELS; i++) {
+				path_info->sp[i] &= ~MCDRV_ASRC_DAC1_L_ON;
+				path_info->sp[i] |= MCDRV_ASRC_DAC1_L_OFF;
+				path_info->sp[i] &= ~MCDRV_ASRC_DAC1_R_ON;
+				path_info->sp[i] |= MCDRV_ASRC_DAC1_R_OFF;
+			}
+
+			for (i = 0; i < LOUT2_PATH_CHANNELS; i++) {
+				path_info->lout2[i] &= ~MCDRV_ASRC_DAC1_L_ON;
+				path_info->lout2[i] |= MCDRV_ASRC_DAC1_L_OFF;
+				path_info->lout2[i] &= ~MCDRV_ASRC_DAC1_R_ON;
+				path_info->lout2[i] |= MCDRV_ASRC_DAC1_R_OFF;
+			}
+		}
+
+		for (i = 0; i < ADIF2_PATH_CHANNELS; i++) {
+			if (path_info->adif2[i] & MCDRV_D2SRC_DAC1REF_ON) {
+				path_info->adif2[i] &= ~MCDRV_D2SRC_DAC1REF_ON;
+				ret = 1;
+			}
+		}
+	}
+
+	return ret;
+}
+
+int mc_path_info_set(struct mcdrv_path_info *path_info)
+{
+	struct mcdrv_path_info old_path_info;
+	int cont, i, ret;
+
+	old_path_info = mc_info.path_info;
+	mc_info.path_info = mc_info.path_info_virtual;
+
+	d1_source_set_onoff(path_info->music_out,
+			    mc_info.path_info.music_out,
+			    MUSICOUT_PATH_CHANNELS);
+	d1_source_set_onoff(path_info->ext_out,
+			    mc_info.path_info.ext_out, EXTOUT_PATH_CHANNELS);
+	d1_source_set_onoff(path_info->hifi_out,
+			    mc_info.path_info.hifi_out, HIFIOUT_PATH_CHANNELS);
+	d1_source_set_onoff(path_info->vbox_mix_in,
+			    mc_info.path_info.vbox_mix_in,
+			    VBOXMIXIN_PATH_CHANNELS);
+	d1_source_set_onoff(path_info->ae0,
+			    mc_info.path_info.ae0, AE_PATH_CHANNELS);
+	d1_source_set_onoff(path_info->ae1,
+			    mc_info.path_info.ae1, AE_PATH_CHANNELS);
+	d1_source_set_onoff(path_info->ae2,
+			    mc_info.path_info.ae2, AE_PATH_CHANNELS);
+	d1_source_set_onoff(path_info->ae3,
+			    mc_info.path_info.ae3, AE_PATH_CHANNELS);
+	d1_source_set_onoff(path_info->dac0,
+			    mc_info.path_info.dac0, DAC0_PATH_CHANNELS);
+	d1_source_set_onoff(path_info->dac1,
+			    mc_info.path_info.dac1, DAC1_PATH_CHANNELS);
+
+	d2_source_set_onoff(path_info->voice_out,
+			    mc_info.path_info.voice_out,
+			    VOICEOUT_PATH_CHANNELS);
+	d2_source_set_onoff(path_info->vbox_io_in,
+			    mc_info.path_info.vbox_io_in,
+			    VBOXIOIN_PATH_CHANNELS);
+	d2_source_set_onoff(path_info->vbox_host_in,
+			    mc_info.path_info.vbox_host_in,
+			    VBOXHOSTIN_PATH_CHANNELS);
+	d2_source_set_onoff(path_info->host_out,
+			    mc_info.path_info.host_out, HOSTOUT_PATH_CHANNELS);
+	d2_source_set_onoff(path_info->adif0,
+			    mc_info.path_info.adif0, ADIF0_PATH_CHANNELS);
+	d2_source_set_onoff(path_info->adif1,
+			    mc_info.path_info.adif1, ADIF1_PATH_CHANNELS);
+	d2_source_set_onoff(path_info->adif2,
+			    mc_info.path_info.adif2, ADIF2_PATH_CHANNELS);
+
+	a_source_set_onoff(path_info->adc0,
+			   mc_info.path_info.adc0, ADC0_PATH_CHANNELS);
+	a_source_set_onoff(path_info->adc1,
+			   mc_info.path_info.adc1, ADC1_PATH_CHANNELS);
+	a_source_set_onoff(path_info->sp,
+			   mc_info.path_info.sp, SP_PATH_CHANNELS);
+	a_source_set_onoff(path_info->hp,
+			   mc_info.path_info.hp, HP_PATH_CHANNELS);
+	a_source_set_onoff(path_info->rc,
+			   mc_info.path_info.rc, RC_PATH_CHANNELS);
+	a_source_set_onoff(path_info->lout1,
+			   mc_info.path_info.lout1, LOUT1_PATH_CHANNELS);
+	a_source_set_onoff(path_info->lout2,
+			   mc_info.path_info.lout2, LOUT2_PATH_CHANNELS);
+
+	bias_source_set_onoff(path_info);
+
+	ret = is_valid_path();
+	if (ret < 0) {
+		mc_info.path_info = old_path_info;
+		return ret;
+	}
+
+	ret = phys_port_check();
+	if (ret < 0) {
+		mc_info.path_info = old_path_info;
+		return ret;
+	}
+
+	mc_info.path_info_virtual = mc_info.path_info;
+
+	for (i = 0, cont = 1; i < 3 && cont; i++) {
+		cont = adc_validate();
+		cont |= dac_validate();
+	}
+
+	return 0;
+}
+
+void mc_path_info_get(struct mcdrv_path_info *path_info)
+{
+	*path_info = mc_info.path_info;
+}
+
+void mc_path_info_get_virtual(struct mcdrv_path_info *path_info)
+{
+	*path_info = mc_info.path_info_virtual;
+}
+
+void mc_vol_info_set(struct mcdrv_vol_info *vol_info)
+{
+	int i;
+
+	for (i = 0; i < MUSICIN_VOL_CHANNELS; i++) {
+		if (vol_info->d_music_in[i] & 1)
+			mc_info.vol_info.d_music_in[i] =
+			    vol_info->d_music_in[i] & ~1;
+	}
+
+	for (i = 0; i < EXTIN_VOL_CHANNELS; i++) {
+		if (vol_info->d_ext_in[i] & 1)
+			mc_info.vol_info.d_ext_in[i] =
+			    vol_info->d_ext_in[i] & ~1;
+	}
+
+	for (i = 0; i < VOICEIN_VOL_CHANNELS; i++) {
+		if (vol_info->d_voice_in[i] & 1)
+			mc_info.vol_info.d_voice_in[i] =
+			    vol_info->d_voice_in[i] & ~1;
+	}
+
+	for (i = 0; i < REFIN_VOL_CHANNELS; i++) {
+		if (vol_info->d_ref_in[i] & 1)
+			mc_info.vol_info.d_ref_in[i] =
+			    vol_info->d_ref_in[i] & ~1;
+	}
+
+	for (i = 0; i < ADIF0IN_VOL_CHANNELS; i++) {
+		if (vol_info->d_adif0_in[i] & 1)
+			mc_info.vol_info.d_adif0_in[i] =
+			    vol_info->d_adif0_in[i] & ~1;
+	}
+
+	for (i = 0; i < ADIF1IN_VOL_CHANNELS; i++) {
+		if (vol_info->d_adif1_in[i] & 1)
+			mc_info.vol_info.d_adif1_in[i] =
+			    vol_info->d_adif1_in[i] & ~1;
+	}
+
+	for (i = 0; i < ADIF2IN_VOL_CHANNELS; i++) {
+		if (vol_info->d_adif2_in[i] & 1)
+			mc_info.vol_info.d_adif2_in[i] =
+			    vol_info->d_adif2_in[i] & ~1;
+	}
+
+	for (i = 0; i < MUSICOUT_VOL_CHANNELS; i++) {
+		if (vol_info->d_music_out[i] & 1)
+			mc_info.vol_info.d_music_out[i] =
+			    vol_info->d_music_out[i] & ~1;
+	}
+
+	for (i = 0; i < EXTOUT_VOL_CHANNELS; i++) {
+		if (vol_info->d_ext_out[i] & 1)
+			mc_info.vol_info.d_ext_out[i] =
+			    vol_info->d_ext_out[i] & ~1;
+	}
+
+	for (i = 0; i < VOICEOUT_VOL_CHANNELS; i++) {
+		if (vol_info->d_voice_out[i] & 1)
+			mc_info.vol_info.d_voice_out[i] =
+			    vol_info->d_voice_out[i] & ~1;
+	}
+
+	for (i = 0; i < REFOUT_VOL_CHANNELS; i++) {
+		if (vol_info->d_ref_out[i] & 1)
+			mc_info.vol_info.d_ref_out[i] =
+			    vol_info->d_ref_out[i] & ~1;
+	}
+
+	for (i = 0; i < DAC0OUT_VOL_CHANNELS; i++) {
+		if (vol_info->d_dac0_out[i] & 1)
+			mc_info.vol_info.d_dac0_out[i] =
+			    vol_info->d_dac0_out[i] & ~1;
+	}
+
+	for (i = 0; i < DAC1OUT_VOL_CHANNELS; i++) {
+		if (vol_info->d_dac1_out[i] & 1)
+			mc_info.vol_info.d_dac1_out[i] =
+			    vol_info->d_dac1_out[i] & ~1;
+	}
+
+	for (i = 0; i < DPATH_VOL_CHANNELS; i++) {
+		if (vol_info->d_dpath_da[i] & 1)
+			mc_info.vol_info.d_dpath_da[i] =
+			    vol_info->d_dpath_da[i] & ~1;
+
+		if (vol_info->d_dpath_ad[i] & 1)
+			mc_info.vol_info.d_dpath_ad[i] =
+			    vol_info->d_dpath_ad[i] & ~1;
+	}
+
+	for (i = 0; i < LINEIN1_VOL_CHANNELS; i++) {
+		if (vol_info->a_line_in1[i] & 1)
+			mc_info.vol_info.a_line_in1[i] =
+			    vol_info->a_line_in1[i] & ~1;
+	}
+
+	for (i = 0; i < MIC1_VOL_CHANNELS; i++) {
+		if (vol_info->a_mic1[i] & 1)
+			mc_info.vol_info.a_mic1[i] = vol_info->a_mic1[i] & ~1;
+	}
+
+	for (i = 0; i < MIC2_VOL_CHANNELS; i++) {
+		if (vol_info->a_mic2[i] & 1)
+			mc_info.vol_info.a_mic2[i] = vol_info->a_mic2[i] & ~1;
+	}
+
+	for (i = 0; i < MIC3_VOL_CHANNELS; i++) {
+		if (vol_info->a_mic3[i] & 1)
+			mc_info.vol_info.a_mic3[i] = vol_info->a_mic3[i] & ~1;
+	}
+
+	for (i = 0; i < MIC4_VOL_CHANNELS; i++) {
+		if (vol_info->a_mic4[i] & 1)
+			mc_info.vol_info.a_mic4[i] = vol_info->a_mic4[i] & ~1;
+	}
+
+	for (i = 0; i < HP_VOL_CHANNELS; i++) {
+		if (vol_info->a_hp[i] & 1)
+			mc_info.vol_info.a_hp[i] = vol_info->a_hp[i] & ~1;
+	}
+
+	for (i = 0; i < SP_VOL_CHANNELS; i++) {
+		if (vol_info->a_sp[i] & 1)
+			mc_info.vol_info.a_sp[i] = vol_info->a_sp[i] & ~1;
+	}
+
+	for (i = 0; i < RC_VOL_CHANNELS; i++) {
+		if (vol_info->a_rc[i] & 1)
+			mc_info.vol_info.a_rc[i] = vol_info->a_rc[i] & ~1;
+	}
+
+	for (i = 0; i < LINEOUT1_VOL_CHANNELS; i++) {
+		if (vol_info->a_line_out1[i] & 1)
+			mc_info.vol_info.a_line_out1[i] =
+			    vol_info->a_line_out1[i] & ~1;
+	}
+
+	for (i = 0; i < LINEOUT2_VOL_CHANNELS; i++) {
+		if (vol_info->a_line_out2[i] & 1)
+			mc_info.vol_info.a_line_out2[i] =
+			    vol_info->a_line_out2[i] & ~1;
+	}
+
+	for (i = 0; i < HPDET_VOL_CHANNELS; i++) {
+		if (vol_info->a_hp_det[i] & 1)
+			mc_info.vol_info.a_hp_det[i] =
+			    vol_info->a_hp_det[i] & ~1;
+	}
+}
+
+void mc_vol_info_get(struct mcdrv_vol_info *vol_info)
+{
+	*vol_info = mc_info.vol_info;
+}
+
+static void dio_common_set(struct mcdrv_dio_common *dio_common, u8 port)
+{
+	struct mcdrv_dio_common *common;
+
+	common = &mc_info.dio_info.port[port].dio_common;
+
+	common->master_slave = dio_common->master_slave;
+	common->auto_fs = dio_common->auto_fs;
+	common->fs = dio_common->fs;
+	common->bck_fs = dio_common->bck_fs;
+	common->interface = dio_common->interface;
+	common->bck_invert = dio_common->bck_invert;
+	common->src_thru = dio_common->src_thru;
+
+	if (dio_common->interface == MCDRV_DIO_PCM) {
+		common->pcm_hiz_transition = dio_common->pcm_hiz_transition;
+		common->pcm_frame = dio_common->pcm_frame;
+		common->pcm_high_period = dio_common->pcm_high_period;
+	}
+}
+
+static void dio_dir_set(struct mcdrv_dio_dir *dio_dir, u8 port)
+{
+	struct mcdrv_dio_dir *dir;
+
+	dir = &mc_info.dio_info.port[port].dir;
+
+	if (mc_info.dio_info.port[port].dio_common.interface == MCDRV_DIO_DA) {
+		dir->da_format.bit_sel = dio_dir->da_format.bit_sel;
+		dir->da_format.mode = dio_dir->da_format.mode;
+	} else {
+		dir->pcm_format.mono = dio_dir->pcm_format.mono;
+		dir->pcm_format.order = dio_dir->pcm_format.order;
+		dir->pcm_format.law = dio_dir->pcm_format.law;
+		dir->pcm_format.bit_sel = dio_dir->pcm_format.bit_sel;
+	}
+}
+
+static void dio_dit_set(struct mcdrv_dio_dit *dio_dit, u8 port)
+{
+	struct mcdrv_dio_dit *dit;
+
+	dit = &mc_info.dio_info.port[port].dit;
+
+	dit->st_mode = dio_dit->st_mode;
+	dit->edge = dio_dit->edge;
+	if (mc_info.dio_info.port[port].dio_common.interface == MCDRV_DIO_DA) {
+		dit->da_format.bit_sel = dio_dit->da_format.bit_sel;
+		dit->da_format.mode = dio_dit->da_format.mode;
+	} else {
+		dit->pcm_format.mono = dio_dit->pcm_format.mono;
+		dit->pcm_format.order = dio_dit->pcm_format.order;
+		dit->pcm_format.law = dio_dit->pcm_format.law;
+		dit->pcm_format.bit_sel = dio_dit->pcm_format.bit_sel;
+	}
+}
+
+void mc_dio_info_set(struct mcdrv_dio_info *dio_info, u32 update)
+{
+	if (update & MCDRV_MUSIC_COM_UPDATE_FLAG)
+		dio_common_set(&dio_info->port[0].dio_common, 0);
+
+	if (update & MCDRV_EXT_COM_UPDATE_FLAG)
+		dio_common_set(&dio_info->port[1].dio_common, 1);
+
+	if (update & MCDRV_VOICE_COM_UPDATE_FLAG)
+		dio_common_set(&dio_info->port[2].dio_common, 2);
+
+	if (update & MCDRV_HIFI_COM_UPDATE_FLAG)
+		dio_common_set(&dio_info->port[3].dio_common, 3);
+
+	if (update & MCDRV_MUSIC_DIR_UPDATE_FLAG)
+		dio_dir_set(&dio_info->port[0].dir, 0);
+
+	if (update & MCDRV_EXT_DIR_UPDATE_FLAG)
+		dio_dir_set(&dio_info->port[1].dir, 1);
+
+	if (update & MCDRV_VOICE_DIR_UPDATE_FLAG)
+		dio_dir_set(&dio_info->port[2].dir, 2);
+
+	if (update & MCDRV_HIFI_DIR_UPDATE_FLAG)
+		dio_dir_set(&dio_info->port[3].dir, 3);
+
+	if (update & MCDRV_MUSIC_DIT_UPDATE_FLAG)
+		dio_dit_set(&dio_info->port[0].dit, 0);
+
+	if (update & MCDRV_EXT_DIT_UPDATE_FLAG)
+		dio_dit_set(&dio_info->port[1].dit, 1);
+
+	if (update & MCDRV_VOICE_DIT_UPDATE_FLAG)
+		dio_dit_set(&dio_info->port[2].dit, 2);
+
+	if (update & MCDRV_HIFI_DIT_UPDATE_FLAG)
+		dio_dit_set(&dio_info->port[3].dit, 3);
+}
+
+void mc_dio_info_get(struct mcdrv_dio_info *dio_info)
+{
+	*dio_info = mc_info.dio_info;
+}
+
+void mc_dio_path_info_set(struct mcdrv_dio_path_info *dio_path_info, u32 update)
+{
+	if (update & MCDRV_MUSICNUM_UPDATE_FLAG)
+		mc_info.dio_path_info.music_ch = dio_path_info->music_ch;
+
+	if (update & MCDRV_PHYS0_UPDATE_FLAG)
+		mc_info.dio_path_info.phys_port[0]
+		    = dio_path_info->phys_port[0];
+
+	if (update & MCDRV_PHYS1_UPDATE_FLAG)
+		mc_info.dio_path_info.phys_port[1]
+		    = dio_path_info->phys_port[1];
+
+	if (update & MCDRV_PHYS2_UPDATE_FLAG)
+		mc_info.dio_path_info.phys_port[2]
+		    = dio_path_info->phys_port[2];
+
+	if (update & MCDRV_PHYS3_UPDATE_FLAG)
+		mc_info.dio_path_info.phys_port[3]
+		    = dio_path_info->phys_port[3];
+
+	if (update & MCDRV_DIR0SLOT_UPDATE_FLAG)
+		mc_info.dio_path_info.music_rslot[0]
+		    = dio_path_info->music_rslot[0];
+
+	if (update & MCDRV_DIR1SLOT_UPDATE_FLAG)
+		mc_info.dio_path_info.music_rslot[1]
+		    = dio_path_info->music_rslot[1];
+
+	if (update & MCDRV_DIR2SLOT_UPDATE_FLAG)
+		mc_info.dio_path_info.music_rslot[2]
+		    = dio_path_info->music_rslot[2];
+
+	if (update & MCDRV_DIT0SLOT_UPDATE_FLAG)
+		mc_info.dio_path_info.music_tslot[0]
+		    = dio_path_info->music_tslot[0];
+
+	if (update & MCDRV_DIT1SLOT_UPDATE_FLAG)
+		mc_info.dio_path_info.music_tslot[1]
+		    = dio_path_info->music_tslot[1];
+
+	if (update & MCDRV_DIT2SLOT_UPDATE_FLAG)
+		mc_info.dio_path_info.music_tslot[2]
+		    = dio_path_info->music_tslot[2];
+}
+
+void mc_dio_path_info_get(struct mcdrv_dio_path_info *dio_path_info)
+{
+	*dio_path_info = mc_info.dio_path_info;
+}
+
+void mc_swap_info_set(struct mcdrv_swap_info *swap_info, u32 update)
+{
+	if (update & MCDRV_SWAP_ADIF0_UPDATE_FLAG)
+		mc_info.swap_info.adif0 = swap_info->adif0;
+
+	if (update & MCDRV_SWAP_ADIF1_UPDATE_FLAG)
+		mc_info.swap_info.adif1 = swap_info->adif1;
+
+	if (update & MCDRV_SWAP_ADIF2_UPDATE_FLAG)
+		mc_info.swap_info.adif2 = swap_info->adif2;
+
+	if (update & MCDRV_SWAP_DAC0_UPDATE_FLAG)
+		mc_info.swap_info.dac0 = swap_info->dac0;
+
+	if (update & MCDRV_SWAP_DAC1_UPDATE_FLAG)
+		mc_info.swap_info.dac1 = swap_info->dac1;
+
+	if (update & MCDRV_SWAP_MUSICIN0_UPDATE_FLAG)
+		mc_info.swap_info.music_in0 = swap_info->music_in0;
+
+	if (update & MCDRV_SWAP_MUSICIN1_UPDATE_FLAG)
+		mc_info.swap_info.music_in1 = swap_info->music_in1;
+
+	if (update & MCDRV_SWAP_MUSICIN2_UPDATE_FLAG)
+		mc_info.swap_info.music_in2 = swap_info->music_in2;
+
+	if (update & MCDRV_SWAP_EXTIN_UPDATE_FLAG)
+		mc_info.swap_info.ext_in = swap_info->ext_in;
+
+	if (update & MCDRV_SWAP_VOICEIN_UPDATE_FLAG)
+		mc_info.swap_info.voice_in = swap_info->voice_in;
+
+	if (update & MCDRV_SWAP_HIFIIN_UPDATE_FLAG)
+		mc_info.swap_info.hifi_in = swap_info->hifi_in;
+
+	if (update & MCDRV_SWAP_MUSICOUT0_UPDATE_FLAG)
+		mc_info.swap_info.music_out0 = swap_info->music_out0;
+
+	if (update & MCDRV_SWAP_MUSICOUT1_UPDATE_FLAG)
+		mc_info.swap_info.music_out1 = swap_info->music_out1;
+
+	if (update & MCDRV_SWAP_MUSICOUT2_UPDATE_FLAG)
+		mc_info.swap_info.music_out2 = swap_info->music_out2;
+
+	if (update & MCDRV_SWAP_EXTOUT_UPDATE_FLAG)
+		mc_info.swap_info.ext_out = swap_info->ext_out;
+
+	if (update & MCDRV_SWAP_VOICEOUT_UPDATE_FLAG)
+		mc_info.swap_info.voice_out = swap_info->voice_out;
+
+	if (update & MCDRV_SWAP_HIFIOUT_UPDATE_FLAG)
+		mc_info.swap_info.hifi_out = swap_info->hifi_out;
+}
+
+void mc_swap_info_get(struct mcdrv_swap_info *swap_info)
+{
+	*swap_info = mc_info.swap_info;
+}
+
+void mc_hsdet_info_set(struct mcdrv_hsdet_info *hsdet_info, u32 update)
+{
+	struct mcdrv_hsdet_info *hsdet;
+
+	hsdet = &mc_info.hsdet_info;
+
+	if (update & MCDRV_ENPLUGDET_UPDATE_FLAG)
+		hsdet->en_plug_det = hsdet_info->en_plug_det;
+
+	if (update & MCDRV_ENPLUGDETDB_UPDATE_FLAG)
+		hsdet->en_plug_det_db = hsdet_info->en_plug_det_db;
+
+	if (update & MCDRV_ENDLYKEYOFF_UPDATE_FLAG)
+		hsdet->en_dly_key_off = hsdet_info->en_dly_key_off;
+
+	if (update & MCDRV_ENDLYKEYON_UPDATE_FLAG)
+		hsdet->en_dly_key_on = hsdet_info->en_dly_key_on;
+
+	if (update & MCDRV_ENMICDET_UPDATE_FLAG)
+		hsdet->en_mic_det = hsdet_info->en_mic_det;
+
+	if (update & MCDRV_ENKEYOFF_UPDATE_FLAG)
+		hsdet->en_key_off = hsdet_info->en_key_off;
+
+	if (update & MCDRV_ENKEYON_UPDATE_FLAG)
+		hsdet->en_key_on = hsdet_info->en_key_on;
+
+	if (update & MCDRV_HSDETDBNC_UPDATE_FLAG)
+		hsdet->hs_det_dbnc = hsdet_info->hs_det_dbnc;
+
+	if (update & MCDRV_KEYOFFMTIM_UPDATE_FLAG)
+		hsdet->key_off_mtim = hsdet_info->key_off_mtim;
+
+	if (update & MCDRV_KEYONMTIM_UPDATE_FLAG)
+		hsdet->key_on_mtim = hsdet_info->key_on_mtim;
+
+	if (update & MCDRV_KEY0OFFDLYTIM_UPDATE_FLAG)
+		hsdet->key0_off_dly_tim = hsdet_info->key0_off_dly_tim;
+
+	if (update & MCDRV_KEY1OFFDLYTIM_UPDATE_FLAG)
+		hsdet->key1_off_dly_tim = hsdet_info->key1_off_dly_tim;
+
+	if (update & MCDRV_KEY2OFFDLYTIM_UPDATE_FLAG)
+		hsdet->key2_off_dly_tim = hsdet_info->key2_off_dly_tim;
+
+	if (update & MCDRV_KEY0ONDLYTIM_UPDATE_FLAG)
+		hsdet->key0_on_dly_tim = hsdet_info->key0_on_dly_tim;
+
+	if (update & MCDRV_KEY1ONDLYTIM_UPDATE_FLAG)
+		hsdet->key1_on_dly_tim = hsdet_info->key1_on_dly_tim;
+
+	if (update & MCDRV_KEY2ONDLYTIM_UPDATE_FLAG)
+		hsdet->key2_on_dly_tim = hsdet_info->key2_on_dly_tim;
+
+	if (update & MCDRV_KEY0ONDLYTIM2_UPDATE_FLAG)
+		hsdet->key0_on_dly_tim2 = hsdet_info->key0_on_dly_tim2;
+
+	if (update & MCDRV_KEY1ONDLYTIM2_UPDATE_FLAG)
+		hsdet->key1_on_dly_tim2 = hsdet_info->key1_on_dly_tim2;
+
+	if (update & MCDRV_KEY2ONDLYTIM2_UPDATE_FLAG)
+		hsdet->key2_on_dly_tim2 = hsdet_info->key2_on_dly_tim2;
+
+	if (update & MCDRV_IRQTYPE_UPDATE_FLAG) {
+		hsdet->irq_type = hsdet_info->irq_type;
+		hsdet->plug_det_db_irq_type = hsdet_info->plug_det_db_irq_type;
+		hsdet->plug_undet_db_irq_type
+		    = hsdet_info->plug_undet_db_irq_type;
+		hsdet->mic_det_irq_type = hsdet_info->mic_det_irq_type;
+		hsdet->plug_det_irq_type = hsdet_info->plug_det_irq_type;
+		hsdet->key0_on_irq_type = hsdet_info->key0_on_irq_type;
+		hsdet->key1_on_irq_type = hsdet_info->key1_on_irq_type;
+		hsdet->key2_on_irq_type = hsdet_info->key2_on_irq_type;
+		hsdet->key0_off_irq_type = hsdet_info->key0_off_irq_type;
+		hsdet->key1_off_irq_type = hsdet_info->key1_off_irq_type;
+		hsdet->key2_off_irq_type = hsdet_info->key2_off_irq_type;
+	}
+
+	if (update & MCDRV_DETINV_UPDATE_FLAG)
+		hsdet->det_in_inv = hsdet_info->det_in_inv;
+
+	if (update & MCDRV_HSDETMODE_UPDATE_FLAG)
+		hsdet->hs_det_mode = hsdet_info->hs_det_mode;
+
+	if (update & MCDRV_SPERIOD_UPDATE_FLAG)
+		hsdet->speriod = hsdet_info->speriod;
+
+	if (update & MCDRV_LPERIOD_UPDATE_FLAG)
+		hsdet->lperiod = hsdet_info->lperiod;
+
+	if (update & MCDRV_DBNCNUMPLUG_UPDATE_FLAG)
+		hsdet->dbnc_num_plug = hsdet_info->dbnc_num_plug;
+
+	if (update & MCDRV_DBNCNUMMIC_UPDATE_FLAG)
+		hsdet->dbnc_num_mic = hsdet_info->dbnc_num_mic;
+
+	if (update & MCDRV_DBNCNUMKEY_UPDATE_FLAG)
+		hsdet->dbnc_num_key = hsdet_info->dbnc_num_key;
+
+	if (update & MCDRV_SGNL_UPDATE_FLAG) {
+		hsdet->sgnl_period = hsdet_info->sgnl_period;
+		hsdet->sgnl_num = hsdet_info->sgnl_num;
+		hsdet->sgnl_peak = hsdet_info->sgnl_peak;
+	}
+
+	if (update & MCDRV_IMPSEL_UPDATE_FLAG)
+		hsdet->imp_sel = hsdet_info->imp_sel;
+
+	if (update & MCDRV_DLYIRQSTOP_UPDATE_FLAG)
+		hsdet->dly_irq_stop = hsdet_info->dly_irq_stop;
+
+	if (update & MCDRV_CBFUNC_UPDATE_FLAG)
+		hsdet->cbfunc = hsdet_info->cbfunc;
+}
+
+void mc_hsdet_info_get(struct mcdrv_hsdet_info *hsdet_info)
+{
+	*hsdet_info = mc_info.hsdet_info;
+}
+
+void mc_aec_info_set(struct mcdrv_aec_info *aec_info)
+{
+	struct mcdrv_aec_info *aec;
+	struct mcdrv_aec_output *out;
+	struct mcdrv_aec_input *in;
+	int i;
+
+	aec = &mc_info.aec_info;
+
+	if (aec_info->fdsp_locate != 0xff)
+		aec->fdsp_locate = aec_info->fdsp_locate;
+
+	aec->audio_engine.enable = aec_info->audio_engine.enable;
+	if (aec_info->audio_engine.enable) {
+		struct mcdrv_aec_audio_engine *ae = &aec->audio_engine;
+
+		if (aec_info->audio_engine.on != 2)
+			ae->on = aec_info->audio_engine.on;
+		if (aec_info->audio_engine.fdsp_on != 2)
+			ae->fdsp_on = aec_info->audio_engine.fdsp_on;
+		if (aec_info->audio_engine.bdsp_ae0_src != 2)
+			ae->bdsp_ae0_src = aec_info->audio_engine.bdsp_ae0_src;
+		if (aec_info->audio_engine.bdsp_ae1_src != 2)
+			ae->bdsp_ae1_src = aec_info->audio_engine.bdsp_ae1_src;
+		if (aec_info->audio_engine.mixer_in0_src != 2)
+			ae->mixer_in0_src =
+			    aec_info->audio_engine.mixer_in0_src;
+		if (aec_info->audio_engine.mixer_in1_src != 2)
+			ae->mixer_in1_src =
+			    aec_info->audio_engine.mixer_in1_src;
+		if (aec_info->audio_engine.mixer_in2_src != 2)
+			ae->mixer_in2_src =
+			    aec_info->audio_engine.mixer_in2_src;
+		if (aec_info->audio_engine.mixer_in3_src != 2)
+			ae->mixer_in3_src =
+			    aec_info->audio_engine.mixer_in3_src;
+	}
+
+	aec->audio_engine.bdsp = aec_info->audio_engine.bdsp;
+	aec->audio_engine.fdsp = aec_info->audio_engine.fdsp;
+
+	aec->vbox.enable = aec_info->vbox.enable;
+	if (aec_info->vbox.enable) {
+		struct mcdrv_aec_vbox *vb = &mc_info.aec_info.vbox;
+
+		if (aec_info->vbox.cdsp_func_a_on != 2)
+			vb->cdsp_func_a_on = aec_info->vbox.cdsp_func_a_on;
+
+		if (aec_info->vbox.cdsp_func_b_on != 2)
+			vb->cdsp_func_b_on = aec_info->vbox.cdsp_func_b_on;
+
+		if (aec_info->vbox.fdsp_on != 2)
+			vb->fdsp_on = aec_info->vbox.fdsp_on;
+
+		if (aec_info->vbox.fdsp_po_source != 0xff)
+			vb->fdsp_po_source = aec_info->vbox.fdsp_po_source;
+
+		if (aec_info->vbox.isrc2_vsource != 0xff)
+			vb->isrc2_vsource = aec_info->vbox.isrc2_vsource;
+
+		if (aec_info->vbox.isrc2_ch1_vsource != 0xff)
+			vb->isrc2_ch1_vsource =
+			    aec_info->vbox.isrc2_ch1_vsource;
+		if (aec_info->vbox.isrc3_vsource != 0xff)
+			vb->isrc3_vsource = aec_info->vbox.isrc3_vsource;
+
+		if (aec_info->vbox.lpt2_vsource != 0xff)
+			vb->lpt2_vsource = aec_info->vbox.lpt2_vsource;
+
+		if (aec_info->vbox.lpt2_mix_vol_o != 0xff)
+			vb->lpt2_mix_vol_o = aec_info->vbox.lpt2_mix_vol_o;
+
+		if (aec_info->vbox.lpt2_mix_vol_i != 0xff)
+			vb->lpt2_mix_vol_i = aec_info->vbox.lpt2_mix_vol_i;
+
+		if (aec_info->vbox.src3_ctrl != 0xff)
+			vb->src3_ctrl = aec_info->vbox.src3_ctrl;
+
+		if (aec_info->vbox.src2_fs != 0xff)
+			vb->src2_fs = aec_info->vbox.src2_fs;
+
+		if (aec_info->vbox.src2_thru != 0xff)
+			vb->src2_thru = aec_info->vbox.src2_thru;
+
+		if (aec_info->vbox.src3_fs != 0xff)
+			vb->src3_fs = aec_info->vbox.src3_fs;
+
+		if (aec_info->vbox.src3_thru != 0xff)
+			vb->src3_thru = aec_info->vbox.src3_thru;
+
+		if (aec_info->vbox.cdsp_jtag_on != 0xff)
+			vb->cdsp_jtag_on = aec_info->vbox.cdsp_jtag_on;
+	}
+
+	aec->vbox.cdsp_a = aec_info->vbox.cdsp_a;
+	aec->vbox.cdsp_b = aec_info->vbox.cdsp_b;
+	aec->vbox.fdsp = aec_info->vbox.fdsp;
+
+	out = &aec->output;
+
+	for (i = 0; i < MCDRV_AEC_OUTPUT_N; i++) {
+
+		if (aec_info->output.lpf_pre_thru[i] != 0xff) {
+			out->lpf_pre_thru[i] = aec_info->output.lpf_pre_thru[i];
+			out->lpf_post_thru[i]
+			    = aec_info->output.lpf_post_thru[i];
+			out->dcc_sel[i] = aec_info->output.dcc_sel[i];
+			out->power_detect_level[i]
+			    = aec_info->output.power_detect_level[i];
+			out->osf_sel[i] = aec_info->output.osf_sel[i];
+			out->syseq_enb[i] = aec_info->output.syseq_enb[i];
+			out->syseq_coef_a0[i][0]
+			    = aec_info->output.syseq_coef_a0[i][0];
+			out->syseq_coef_a0[i][1]
+			    = aec_info->output.syseq_coef_a0[i][1];
+			out->syseq_coef_a0[i][2]
+			    = aec_info->output.syseq_coef_a0[i][2];
+			out->syseq_coef_a1[i][0]
+			    = aec_info->output.syseq_coef_a1[i][0];
+			out->syseq_coef_a1[i][1]
+			    = aec_info->output.syseq_coef_a1[i][1];
+			out->syseq_coef_a1[i][2]
+			    = aec_info->output.syseq_coef_a1[i][2];
+			out->syseq_coef_a2[i][0]
+			    = aec_info->output.syseq_coef_a2[i][0];
+			out->syseq_coef_a2[i][1]
+			    = aec_info->output.syseq_coef_a2[i][1];
+			out->syseq_coef_a2[i][2]
+			    = aec_info->output.syseq_coef_a2[i][2];
+			out->syseq_coef_b1[i][0]
+			    = aec_info->output.syseq_coef_b1[i][0];
+			out->syseq_coef_b1[i][1]
+			    = aec_info->output.syseq_coef_b1[i][1];
+			out->syseq_coef_b1[i][2]
+			    = aec_info->output.syseq_coef_b1[i][2];
+			out->syseq_coef_b2[i][0]
+			    = aec_info->output.syseq_coef_b2[i][0];
+			out->syseq_coef_b2[i][1]
+			    = aec_info->output.syseq_coef_b2[i][1];
+			out->syseq_coef_b2[i][2]
+			    = aec_info->output.syseq_coef_b2[i][2];
+			out->clip_md[i] = aec_info->output.clip_md[i];
+			out->clip_att[i] = aec_info->output.clip_att[i];
+			out->clip_rel[i] = aec_info->output.clip_rel[i];
+			out->clip_g[i] = aec_info->output.clip_g[i];
+			out->osf_gain[i][0] = aec_info->output.osf_gain[i][0];
+			out->osf_gain[i][1] = aec_info->output.osf_gain[i][1];
+			out->dcl_on[i] = aec_info->output.dcl_on[i];
+			out->dcl_gain[i] = aec_info->output.dcl_gain[i];
+			out->dcl_limit[i][0] = aec_info->output.dcl_limit[i][0];
+			out->dcl_limit[i][1] = aec_info->output.dcl_limit[i][1];
+			out->random_dither_on[i]
+			    = aec_info->output.random_dither_on[i];
+			out->random_dither_level[i]
+			    = aec_info->output.random_dither_level[i];
+			out->random_dither_pos[i]
+			    = aec_info->output.random_dither_pos[i];
+			out->dc_dither_on[i] = aec_info->output.dc_dither_on[i];
+			out->dc_dither_level[i]
+			    = aec_info->output.dc_dither_level[i];
+			out->dither_type[i] = aec_info->output.dither_type[i];
+			out->dng_on[i] = aec_info->output.dng_on[i];
+			out->dng_zero[i] = aec_info->output.dng_zero[i];
+			out->dng_time[i] = aec_info->output.dng_time[i];
+			out->dng_fw[i] = aec_info->output.dng_fw[i];
+			out->dng_target[i] = aec_info->output.dng_target[i];
+			out->dng_target_lineout[i]
+			    = aec_info->output.dng_target_lineout[i];
+		}
+		if (aec_info->output.syseq_ex[i].enable)
+			memcpy(&out->syseq_ex[i], &aec_info->output.syseq_ex[i],
+			       sizeof(struct mcdrv_aec_syseq_ex));
+	}
+
+	out->signal_detect_level = aec_info->output.signal_detect_level;
+	out->dng_attack = aec_info->output.dng_attack;
+	out->dng_release = aec_info->output.dng_release;
+	out->dng_target_rc = aec_info->output.dng_target_rc;
+
+	in = &aec->input;
+
+	for (i = 0; i < MCDRV_AEC_INPUT_N; i++) {
+		if (aec_info->input.dsf32_l_type[i] != 0xff) {
+			in->dsf32_l_type[i] = aec_info->input.dsf32_l_type[i];
+			in->dsf32_r_type[i] = aec_info->input.dsf32_r_type[i];
+			in->dsf4_sel[i] = aec_info->input.dsf4_sel[i];
+			in->dcc_sel[i] = aec_info->input.dcc_sel[i];
+			in->dng_on[i] = aec_info->input.dng_on[i];
+			in->dng_att[i] = aec_info->input.dng_att[i];
+			in->dng_rel[i] = aec_info->input.dng_rel[i];
+			in->dng_fw[i] = aec_info->input.dng_fw[i];
+			in->dng_time[i] = aec_info->input.dng_time[i];
+			in->dng_zero[i][0] = aec_info->input.dng_zero[i][0];
+			in->dng_zero[i][1] = aec_info->input.dng_zero[i][1];
+			in->dng_target[i][0] = aec_info->input.dng_target[i][0];
+			in->dng_target[i][1] = aec_info->input.dng_target[i][1];
+			in->depop_att[i] = aec_info->input.depop_att[i];
+			in->depop_wait[i] = aec_info->input.depop_wait[i];
+		}
+	}
+
+	in->ref_sel = aec_info->input.ref_sel;
+
+	if (aec_info->pdm.mode != 0xff)
+		aec->pdm = aec_info->pdm;
+
+	aec->e2.enable = aec_info->e2.enable;
+	if (aec_info->e2.enable) {
+		if (aec_info->e2.da_sel != 4)
+			aec->e2.da_sel = aec_info->e2.da_sel;
+		if (aec_info->e2.ad_sel != 8)
+			aec->e2.ad_sel = aec_info->e2.ad_sel;
+		aec->e2.on = aec_info->e2.on;
+	}
+	aec->e2.config = aec_info->e2.config;
+
+	if (aec_info->adj.hold != 0xff)
+		aec->adj = aec_info->adj;
+
+	if (aec_info->edsp_misc.i2s_out_enable != 0xff)
+		aec->edsp_misc = aec_info->edsp_misc;
+
+	if (aec_info->control.command == 0xff)
+		memset(&aec->control, 0, sizeof(struct mcdrv_aec_control));
+	else
+		aec->control = aec_info->control;
+
+	if (!aec->fdsp_locate)
+		aec->vbox.fdsp_on = 0;
+	else
+		aec->audio_engine.fdsp_on = 0;
+}
+
+void mc_aec_info_replace(struct mcdrv_aec_info *aec_info)
+{
+	mc_info.aec_info = *aec_info;
+}
+
+void mc_aec_info_get(struct mcdrv_aec_info *aec_info)
+{
+	*aec_info = mc_info.aec_info;
+}
+
+void mc_gp_mode_set(struct mcdrv_gp_mode *mode)
+{
+	mc_info.gp_mode = *mode;
+}
+
+void mc_gp_mode_get(struct mcdrv_gp_mode *mode)
+{
+	*mode = mc_info.gp_mode;
+}
+
+bool mc_gp_pad_get(u32 pad_no)
+{
+	if (pad_no > 2)
+		return 0;
+
+	return mc_info.gp_mode.gp_ddr[pad_no];
+}
+
+void mc_clock_select_set(u8 clk_sel)
+{
+	mc_info.clk_sel = clk_sel;
+}
+
+u8 mc_clock_select_get(void)
+{
+	return mc_info.clk_sel;
+}
+
+void mc_e_clock_select_set(u8 eclk_sel)
+{
+	mc_info.eclk_sel = eclk_sel;
+}
+
+u8 mc_e_clock_select_get(void)
+{
+	return mc_info.eclk_sel;
+}
+
+void mc_plug_detect_db_set(u8 plug_det_db)
+{
+	mc_info.plug_det_db = plug_det_db;
+}
+
+u8 mc_plug_detect_db_get(void)
+{
+	return mc_info.plug_det_db;
+}
+
+static s16 digital_volume(int vol)
+{
+	int ret;
+
+	if (vol < (-95 * 256))
+		ret = 0;
+	else if (vol < 0)
+		ret = 96 + (vol - 128) / 256;
+	else
+		ret = 96 + (vol + 128) / 256;
+
+	if (ret > 114)
+		ret = 114;
+
+	return (s16) ret;
+}
+
+static s16 analog_in_volume(s16 vol)
+{
+	s16 ret;
+
+	if (vol < (-30 * 256))
+		ret = 0;
+	else if (vol < 0)
+		ret = 0x21 + (vol - 128) / 256;
+	else if (vol <= (21 * 256))
+		ret = 0x21 + (vol + 128) / 256;
+	else if (vol < 6080)	/* 6080 = 23.75 * 256 */
+		ret = 0x36 + ((vol + 64) / 128 - (21 * 2));
+	else
+		ret = 0x3c + (vol / 256 - 23) / 2;
+
+	if (ret < 0)
+		ret = 0;
+	else if (ret > 0x3f)
+		ret = 0x3f;
+
+	return ret;
+}
+
+static s16 analog_out_volume(s16 vol)
+{
+	s16 ret;
+
+	if (vol < (-36 * 256))
+		ret = 0;
+	else if (vol < -4032)	/* -4032:-15.75*256 */
+		ret = 0x42 + (vol - 128) / 256 + 17;
+	else if (vol < -1504)	/* -1504:-5.875*256 */
+		ret = 0x57 + ((vol - 64) / 128 + 6 * 2);
+	else
+		ret = 0x6f + ((vol - 32) / 64);
+
+	if (ret < 0)
+		ret = 0;
+	else if (ret > 0x6f)
+		ret = 0x6f;
+
+	return ret;
+}
+
+static inline s16 sp_volume(s16 vol)
+{
+	s16 ret;
+
+	if (vol < (-36 * 256))
+		ret = 0;
+	else if (vol < -4032)	/* -4032:-15.75*256 */
+		ret = 0x42 + (vol - 128) / 256 + 17;
+	else if (vol < -1504)	/* -1504:-5.875*256 */
+		ret = 0x57 + ((vol - 64) / 128 + 6 * 2);
+	else if (vol < 32)
+		ret = 0x6f + ((vol - 32) / 64);
+	else
+		ret = 0x70 + ((vol - 32) / 64);
+
+	if (ret < 0)
+		ret = 0;
+	else if (ret > 0x7f)
+		ret = 0x7f;
+
+	return ret;
+}
+
+static s16 lineout_volume(s16 vol)
+{
+	s16 ret;
+
+	if (vol < (-38 * 256))
+		ret = 0;
+	else if (vol < -9344)	/* -9344:-15.75 * 256 */
+		ret = 0x2e;
+	else if (vol < -4032)	/* -4032:-15.75 * 256 */
+		ret = 0x42 + (vol - 128) / 256 + 17;
+	else if (vol < -1504)	/* -1504:-5.875 * 256 */
+		ret = 0x57 + ((vol - 64) / 128 + 6 * 2);
+	else if (vol < 32)
+		ret = 0x6f + ((vol - 32) / 64);
+	else
+		ret = 0x70 + ((vol - 32) / 64);
+
+	if (ret < 0)
+		ret = 0;
+	else if (ret > 0x77)
+		ret = 0x77;
+
+	return ret;
+}
+
+static inline s16 hp_volume(s16 vol)
+{
+	s16 ret;
+
+	if (vol < (-36 * 256))
+		ret = 0;
+	else if (vol < -4032)	/* -4032:-15.75 * 256 */
+		ret = 0x43 + (vol - 128) / 256 + 16;
+	else if (vol < -1504)	/* -1504:-5.875 * 256 */
+		ret = 0x43 + ((vol - 64) / 128 + 16 * 2);
+	else if (vol < 0)
+		ret = 0x57 + ((vol - 32) / 64 + 6 * 4);
+	else
+		ret = 0x6f + ((vol + 32) / 64);
+
+	if (ret < 0)
+		ret = 0;
+	else if (ret > 0x7f)
+		ret = 0x7f;
+
+	return ret;
+}
+
+static u32 d1_get_source(u32 *d1, enum mcdrv_dst_ch ch)
+{
+	u32 src = 0;
+
+	if (d1) {
+		if (d1[ch] & MCDRV_D1SRC_MUSICIN_ON)
+			src |= MCDRV_D1SRC_MUSICIN_ON;
+		if (d1[ch] & MCDRV_D1SRC_EXTIN_ON)
+			src |= MCDRV_D1SRC_EXTIN_ON;
+		if (d1[ch] & MCDRV_D1SRC_VBOXOUT_ON)
+			src |= MCDRV_D1SRC_VBOXOUT_ON;
+		if (d1[ch] & MCDRV_D1SRC_VBOXREFOUT_ON)
+			src |= MCDRV_D1SRC_VBOXREFOUT_ON;
+		if (d1[ch] & MCDRV_D1SRC_AE0_ON)
+			src |= MCDRV_D1SRC_AE0_ON;
+		if (d1[ch] & MCDRV_D1SRC_AE1_ON)
+			src |= MCDRV_D1SRC_AE1_ON;
+		if (d1[ch] & MCDRV_D1SRC_AE2_ON)
+			src |= MCDRV_D1SRC_AE2_ON;
+		if (d1[ch] & MCDRV_D1SRC_AE3_ON)
+			src |= MCDRV_D1SRC_AE3_ON;
+		if (d1[ch] & MCDRV_D1SRC_ADIF0_ON)
+			src |= MCDRV_D1SRC_ADIF0_ON;
+		if (d1[ch] & MCDRV_D1SRC_ADIF1_ON)
+			src |= MCDRV_D1SRC_ADIF1_ON;
+		if (d1[ch] & MCDRV_D1SRC_ADIF2_ON)
+			src |= MCDRV_D1SRC_ADIF2_ON;
+		if (d1[ch] & MCDRV_D1SRC_HIFIIN_ON)
+			src |= MCDRV_D1SRC_HIFIIN_ON;
+	}
+
+	return src;
+}
+
+void mc_volume_info_get(struct mcdrv_vol_info *vol_info)
+{
+	enum mcdrv_dst_ch ch, dst_ch[] = { MCDRV_DST_CH0, MCDRV_DST_CH1 };
+	s16 val1, val2;
+	int i, src;
+
+	*vol_info = mc_info.vol_info;
+
+	if (!mc_d1_source_is_used(MCDRV_D1SRC_MUSICIN_ON)) {
+		val1 = MCDRV_REG_MUTE;
+		val2 = MCDRV_REG_MUTE;
+	} else {
+		val1 = digital_volume(vol_info->d_music_in[0]);
+		val2 = digital_volume(vol_info->d_music_in[1]);
+	}
+	vol_info->d_music_in[0] = val1;
+	vol_info->d_music_in[1] = val2;
+
+	if (!mc_d1_source_is_used(MCDRV_D1SRC_EXTIN_ON)) {
+		val1 = MCDRV_REG_MUTE;
+		val2 = MCDRV_REG_MUTE;
+	} else {
+		val1 = digital_volume(vol_info->d_ext_in[0]);
+		val2 = digital_volume(vol_info->d_ext_in[1]);
+	}
+	vol_info->d_ext_in[0] = val1;
+	vol_info->d_ext_in[1] = val2;
+
+	if (!mc_d1_source_is_used(MCDRV_D1SRC_VBOXOUT_ON)) {
+		val1 = MCDRV_REG_MUTE;
+		val2 = MCDRV_REG_MUTE;
+	} else {
+		val1 = digital_volume(vol_info->d_voice_in[0]);
+		val2 = digital_volume(vol_info->d_voice_in[1]);
+	}
+	vol_info->d_voice_in[0] = val1;
+	vol_info->d_voice_in[1] = val2;
+
+	if (!mc_d1_source_is_used(MCDRV_D1SRC_VBOXREFOUT_ON)) {
+		val1 = MCDRV_REG_MUTE;
+		val2 = MCDRV_REG_MUTE;
+	} else {
+		val1 = digital_volume(vol_info->d_ref_in[0]);
+		val2 = digital_volume(vol_info->d_ref_in[1]);
+	}
+	vol_info->d_ref_in[0] = val1;
+	vol_info->d_ref_in[1] = val2;
+
+	if (!mc_d1_source_is_used(MCDRV_D1SRC_ADIF0_ON)) {
+		val1 = MCDRV_REG_MUTE;
+		val2 = MCDRV_REG_MUTE;
+	} else {
+		val1 = digital_volume(vol_info->d_adif0_in[0]);
+		val2 = digital_volume(vol_info->d_adif0_in[1]);
+	}
+	vol_info->d_adif0_in[0] = val1;
+	vol_info->d_adif0_in[1] = val2;
+
+	if (!mc_d1_source_is_used(MCDRV_D1SRC_ADIF1_ON)) {
+		val1 = MCDRV_REG_MUTE;
+		val2 = MCDRV_REG_MUTE;
+	} else {
+		val1 = digital_volume(vol_info->d_adif1_in[0]);
+		val2 = digital_volume(vol_info->d_adif1_in[1]);
+	}
+	vol_info->d_adif1_in[0] = val1;
+	vol_info->d_adif1_in[1] = val2;
+
+	if (!mc_d1_source_is_used(MCDRV_D1SRC_ADIF2_ON)) {
+		val1 = MCDRV_REG_MUTE;
+		val2 = MCDRV_REG_MUTE;
+	} else {
+		val1 = digital_volume(vol_info->d_adif2_in[0]);
+		val2 = digital_volume(vol_info->d_adif2_in[1]);
+	}
+	vol_info->d_adif2_in[0] = val1;
+	vol_info->d_adif2_in[1] = val2;
+
+	for (i = 0; i < ARRAY_SIZE(dst_ch); i++) {
+		ch = dst_ch[i];
+		if (!mc_source_is_used(MCDRV_DST_MUSICOUT, ch))
+			val1 = MCDRV_REG_MUTE;
+		else
+			val1 = digital_volume(vol_info->d_music_out[i]);
+
+		if (!mc_source_is_used(MCDRV_DST_EXTOUT, ch))
+			val2 = MCDRV_REG_MUTE;
+		else
+			val2 = digital_volume(vol_info->d_ext_out[i]);
+		vol_info->d_music_out[i] = val1;
+		vol_info->d_ext_out[i] = val2;
+	}
+
+	if (!mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH0))
+		val1 = MCDRV_REG_MUTE;
+	else
+		val1 = digital_volume(vol_info->d_voice_out[0]);
+	vol_info->d_voice_out[0] = val1;
+
+	if (!mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH1))
+		val1 = MCDRV_REG_MUTE;
+	else
+		val1 = digital_volume(vol_info->d_voice_out[1]);
+	vol_info->d_voice_out[1] = val1;
+
+	if (!mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH2))
+		val1 = MCDRV_REG_MUTE;
+	else
+		val1 = digital_volume(vol_info->d_ref_out[0]);
+	vol_info->d_ref_out[0] = val1;
+
+	if (!mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH3))
+		val1 = MCDRV_REG_MUTE;
+	else
+		val1 = digital_volume(vol_info->d_ref_out[1]);
+	vol_info->d_ref_out[1] = val1;
+
+	if (!mc_d1_source_is_used(MCDRV_D1SRC_HIFIIN_ON)) {
+		vol_info->d_dpath_da[0] = MCDRV_REG_MUTE;
+		vol_info->d_dpath_da[1] = MCDRV_REG_MUTE;
+	}
+
+	src = d1_get_source(mc_info.path_info.dac0, MCDRV_DST_CH0);
+	if (!(src & ~MCDRV_D1SRC_HIFIIN_ON))
+		val1 = MCDRV_REG_MUTE;
+	else
+		val1 = digital_volume(vol_info->d_dac0_out[0]);
+	vol_info->d_dac0_out[0] = val1;
+
+	if (src & MCDRV_D1SRC_HIFIIN_ON)
+		vol_info->d_dpath_da[0]
+		    = digital_volume(vol_info->d_dpath_da[0]);
+
+	src = d1_get_source(mc_info.path_info.dac0, MCDRV_DST_CH1);
+	if (!(src & ~MCDRV_D1SRC_HIFIIN_ON))
+		val1 = MCDRV_REG_MUTE;
+	else
+		val1 = digital_volume(vol_info->d_dac0_out[1]);
+	vol_info->d_dac0_out[1] = val1;
+
+	if (src & MCDRV_D1SRC_HIFIIN_ON)
+		vol_info->d_dpath_da[1]
+		    = digital_volume(vol_info->d_dpath_da[1]);
+
+	src = d1_get_source(mc_info.path_info.dac1, MCDRV_DST_CH0);
+	if (!(src & ~MCDRV_D1SRC_HIFIIN_ON))
+		val1 = MCDRV_REG_MUTE;
+	else
+		val1 = digital_volume(vol_info->d_dac1_out[0]);
+	vol_info->d_dac1_out[0] = val1;
+
+	if (src & MCDRV_D1SRC_HIFIIN_ON)
+		vol_info->d_dpath_da[0]
+		    = digital_volume(vol_info->d_dpath_da[0]);
+
+	src = d1_get_source(mc_info.path_info.dac1, MCDRV_DST_CH1);
+	if (!(src & ~MCDRV_D1SRC_HIFIIN_ON))
+		val1 = MCDRV_REG_MUTE;
+	else
+		val1 = digital_volume(vol_info->d_dac1_out[1]);
+	vol_info->d_dac1_out[1] = val1;
+
+	if (src & MCDRV_D1SRC_HIFIIN_ON)
+		vol_info->d_dpath_da[1]
+		    = digital_volume(vol_info->d_dpath_da[1]);
+
+	src = d1_get_source(mc_info.path_info.hifi_out, MCDRV_DST_CH0);
+	if (!src) {
+		val1 = MCDRV_REG_MUTE;
+		val2 = MCDRV_REG_MUTE;
+	} else {
+		if ((src & MCDRV_D2SRC_PDM0_ON)
+		    || (src & MCDRV_D2SRC_PDM1_ON)) {
+			val1 = digital_volume(vol_info->d_dpath_ad[0]);
+			val2 = digital_volume(vol_info->d_dpath_ad[1]);
+		} else {
+			if ((src & MCDRV_D2SRC_ADC1_ON)
+			    || mc_source_is_used(MCDRV_DST_ADC0, MCDRV_DST_CH0))
+				val1 = digital_volume(vol_info->d_dpath_ad[0]);
+			else
+				val1 = MCDRV_REG_MUTE;
+
+			if ((src & MCDRV_D2SRC_ADC0_ON)
+			    && mc_source_is_used(MCDRV_DST_ADC0, MCDRV_DST_CH1))
+				val2 = digital_volume(vol_info->d_dpath_ad[1]);
+			else
+				val2 = MCDRV_REG_MUTE;
+		}
+	}
+	vol_info->d_dpath_ad[0] = val1;
+	vol_info->d_dpath_ad[1] = val2;
+
+	if (mc_a_source_is_used(MCDRV_ASRC_LINEIN1_L_ON)
+	    || mc_a_source_is_used(MCDRV_ASRC_LINEIN1_M_ON))
+		val1 = analog_in_volume(mc_info.vol_info.a_line_in1[0]);
+	else
+		val1 = MCDRV_REG_MUTE;
+	vol_info->a_line_in1[0] = val1;
+
+	if (mc_a_source_is_used(MCDRV_ASRC_LINEIN1_R_ON)
+	    || mc_a_source_is_used(MCDRV_ASRC_LINEIN1_M_ON))
+		val1 = analog_in_volume(mc_info.vol_info.a_line_in1[1]);
+	else
+		val1 = MCDRV_REG_MUTE;
+	vol_info->a_line_in1[1] = val1;
+
+	if (mc_a_source_is_used(MCDRV_ASRC_MIC1_ON) != 0)
+		val1 = analog_in_volume(mc_info.vol_info.a_mic1[0]);
+	else
+		val1 = MCDRV_REG_MUTE;
+	vol_info->a_mic1[0] = val1;
+
+	if (mc_a_source_is_used(MCDRV_ASRC_MIC2_ON) != 0)
+		val1 = analog_in_volume(mc_info.vol_info.a_mic2[0]);
+	else
+		val1 = MCDRV_REG_MUTE;
+	vol_info->a_mic2[0] = val1;
+
+	if (mc_a_source_is_used(MCDRV_ASRC_MIC3_ON) != 0)
+		val1 = analog_in_volume(mc_info.vol_info.a_mic3[0]);
+	else
+		val1 = MCDRV_REG_MUTE;
+	vol_info->a_mic3[0] = val1;
+
+	if (mc_a_source_is_used(MCDRV_ASRC_MIC4_ON) != 0)
+		val1 = analog_in_volume(mc_info.vol_info.a_mic4[0]);
+	else
+		val1 = MCDRV_REG_MUTE;
+	vol_info->a_mic4[0] = val1;
+
+	for (i = 0; i < ARRAY_SIZE(dst_ch); i++) {
+		ch = dst_ch[i];
+		if (!mc_source_is_used(MCDRV_DST_HP, ch))
+			val1 = MCDRV_REG_MUTE;
+		else
+			val1 = hp_volume(mc_info.vol_info.a_hp[i]);
+		vol_info->a_hp[i] = val1;
+
+		if (!mc_source_is_used(MCDRV_DST_SP, ch))
+			val1 = MCDRV_REG_MUTE;
+		else
+			val1 = sp_volume(mc_info.vol_info.a_sp[i]);
+		vol_info->a_sp[i] = val1;
+
+		if (!mc_source_is_used(MCDRV_DST_LOUT1, dst_ch[i]))
+			val1 = MCDRV_REG_MUTE;
+		else
+			val1 = lineout_volume(mc_info.vol_info.a_line_out1[i]);
+		vol_info->a_line_out1[i] = val1;
+
+		if (!mc_source_is_used(MCDRV_DST_LOUT2, dst_ch[i]))
+			val1 = MCDRV_REG_MUTE;
+		else
+			val1 = lineout_volume(mc_info.vol_info.a_line_out2[i]);
+		vol_info->a_line_out2[i] = val1;
+	}
+
+	if (!mc_source_is_used(MCDRV_DST_RCV, MCDRV_DST_CH0))
+		val1 = MCDRV_REG_MUTE;
+	else
+		val1 = analog_out_volume(mc_info.vol_info.a_rc[0]);
+	vol_info->a_rc[0] = val1;
+
+	val1 = analog_out_volume(mc_info.vol_info.a_hp_det[0]);
+	vol_info->a_hp_det[0] = val1;
+}
+
+void mc_power_info_get(struct mcdrv_power_info *info)
+{
+	struct mcdrv_aec_info *aec;
+	u32 hifi_out;
+
+	info->digital = MCDRV_POWINFO_D_PLL_PD | MCDRV_POWINFO_D_PE_CLK_PD |
+	    MCDRV_POWINFO_D_PB_CLK_PD | MCDRV_POWINFO_D_PM_CLK_PD |
+	    MCDRV_POWINFO_D_PF_CLK_PD | MCDRV_POWINFO_D_PC_CLK_PD;
+
+	aec = &mc_info.aec_info;
+	hifi_out = mc_info.path_info.hifi_out[0];
+
+	if (aec->e2.on || (hifi_out & MCDRV_D1SRC_ADIF0_ON)
+	    || mc_d2_source_is_used(MCDRV_D2SRC_ADC0_ON)
+	    || mc_d2_source_is_used(MCDRV_D2SRC_ADC1_ON)
+	    || mc_d2_source_is_used(MCDRV_D2SRC_PDM0_ON)
+	    || mc_d2_source_is_used(MCDRV_D2SRC_PDM1_ON)
+	    || mc_source_is_used(MCDRV_DST_DAC0, MCDRV_DST_CH0)
+	    || mc_source_is_used(MCDRV_DST_DAC0, MCDRV_DST_CH1)
+	    || mc_source_is_used(MCDRV_DST_DAC1, MCDRV_DST_CH0)
+	    || mc_source_is_used(MCDRV_DST_DAC1, MCDRV_DST_CH1))
+		info->digital &= ~(MCDRV_POWINFO_D_PE_CLK_PD |
+				   MCDRV_POWINFO_D_PM_CLK_PD |
+				   MCDRV_POWINFO_D_PLL_PD);
+
+	if (aec->audio_engine.on == 1
+	    || mc_d1_source_is_used(MCDRV_D1SRC_AE_ALL_ON))
+		info->digital &= ~(MCDRV_POWINFO_D_PB_CLK_PD |
+				   MCDRV_POWINFO_D_PE_CLK_PD |
+				   MCDRV_POWINFO_D_PM_CLK_PD |
+				   MCDRV_POWINFO_D_PLL_PD);
+
+	if (mc_info.dev_info.power_mode == MCDRV_POWMODE_CDSPDEBUG
+	    || aec->vbox.cdsp_jtag_on
+	    || aec->vbox.cdsp_func_a_on || aec->vbox.cdsp_func_b_on)
+		info->digital &= ~(MCDRV_POWINFO_D_PC_CLK_PD |
+				   MCDRV_POWINFO_D_PE_CLK_PD |
+				   MCDRV_POWINFO_D_PM_CLK_PD |
+				   MCDRV_POWINFO_D_PLL_PD);
+
+	if (!aec->fdsp_locate && aec->audio_engine.fdsp_on)
+		info->digital &= ~(MCDRV_POWINFO_D_PE_CLK_PD |
+				   MCDRV_POWINFO_D_PF_CLK_PD |
+				   MCDRV_POWINFO_D_PM_CLK_PD |
+				   MCDRV_POWINFO_D_PLL_PD);
+
+	if (aec->fdsp_locate && aec->vbox.fdsp_on)
+		info->digital &= ~(MCDRV_POWINFO_D_PE_CLK_PD |
+				   MCDRV_POWINFO_D_PF_CLK_PD |
+				   MCDRV_POWINFO_D_PM_CLK_PD |
+				   MCDRV_POWINFO_D_PLL_PD);
+
+	if (info->digital & MCDRV_POWINFO_D_PM_CLK_PD) {
+		if (mc_d1_source_is_used(MCDRV_D1SRC_MUSICIN_ON)
+		    || mc_d1_source_is_used(MCDRV_D1SRC_EXTIN_ON)
+		    || mc_d1_source_is_used(MCDRV_D1SRC_VBOXOUT_ON)
+		    || mc_d1_source_is_used(MCDRV_D1SRC_VBOXREFOUT_ON)
+		    || mc_d2_source_is_used(MCDRV_D2SRC_VOICEIN_ON)
+		    || mc_d2_source_is_used(MCDRV_D2SRC_VBOXIOOUT_ON)
+		    || mc_source_is_used(MCDRV_DST_MUSICOUT, MCDRV_DST_CH0)
+		    || mc_source_is_used(MCDRV_DST_MUSICOUT, MCDRV_DST_CH1)
+		    || mc_source_is_used(MCDRV_DST_EXTOUT, MCDRV_DST_CH0)
+		    || mc_source_is_used(MCDRV_DST_EXTOUT, MCDRV_DST_CH1)
+		    || mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH0)
+		    || mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH1)
+		    || mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH2)
+		    || mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH3))
+			info->digital &= ~(MCDRV_POWINFO_D_PE_CLK_PD |
+					   MCDRV_POWINFO_D_PM_CLK_PD |
+					   MCDRV_POWINFO_D_PLL_PD);
+	}
+
+	info->analog[0] = MCI_AP_DEF;
+	info->analog[1] = MCI_AP_DA0_DEF;
+	info->analog[2] = MCI_AP_DA1_DEF;
+	info->analog[3] = MCI_AP_MIC_DEF;
+	info->analog[4] = MCI_AP_AD_DEF;
+
+	if (mc_a_source_is_used(MCDRV_ASRC_DAC0_L_ON))
+		info->analog[1] &= ~MCB_AP_DA0L;
+	if (mc_a_source_is_used(MCDRV_ASRC_DAC0_R_ON))
+		info->analog[1] &= ~MCB_AP_DA0R;
+	if (mc_source_is_used(MCDRV_DST_HP, MCDRV_DST_CH0)) {
+		info->analog[0] &= ~MCB_AP_CP;
+		info->analog[1] &= ~MCB_AP_HPL;
+	}
+	if (mc_source_is_used(MCDRV_DST_HP, MCDRV_DST_CH1)) {
+		info->analog[0] &= ~MCB_AP_CP;
+		info->analog[1] &= ~MCB_AP_HPR;
+	}
+	if (mc_source_is_used(MCDRV_DST_RCV, MCDRV_DST_CH0)) {
+		info->analog[0] &= ~MCB_AP_CP;
+		info->analog[1] &= ~MCB_AP_RC;
+	}
+	if (mc_source_is_used(MCDRV_DST_LOUT1, MCDRV_DST_CH0)) {
+		info->analog[0] &= ~MCB_AP_CP;
+		info->analog[1] &= ~MCB_AP_LO1L;
+	}
+	if (mc_source_is_used(MCDRV_DST_LOUT1, MCDRV_DST_CH1)) {
+		info->analog[0] &= ~MCB_AP_CP;
+		info->analog[1] &= ~MCB_AP_LO1R;
+	}
+	if (mc_a_source_is_used(MCDRV_ASRC_DAC1_L_ON))
+		info->analog[2] &= ~MCB_AP_DA1L;
+	if (mc_a_source_is_used(MCDRV_ASRC_DAC1_R_ON))
+		info->analog[2] &= ~MCB_AP_DA1R;
+	if (mc_source_is_used(MCDRV_DST_SP, MCDRV_DST_CH0)) {
+		info->analog[0] &= ~MCB_AP_CP;
+		info->analog[2] &= ~(MCB_AP_SPL2 | MCB_AP_SPL1);
+	}
+	if (mc_source_is_used(MCDRV_DST_SP, MCDRV_DST_CH1)) {
+		info->analog[0] &= ~MCB_AP_CP;
+		info->analog[2] &= ~(MCB_AP_SPR2 | MCB_AP_SPR1);
+	}
+	if (mc_source_is_used(MCDRV_DST_LOUT2, MCDRV_DST_CH0)) {
+		info->analog[0] &= ~MCB_AP_CP;
+		info->analog[2] &= ~MCB_AP_LO2L;
+	}
+	if (mc_source_is_used(MCDRV_DST_LOUT2, MCDRV_DST_CH1)) {
+		info->analog[0] &= ~MCB_AP_CP;
+		info->analog[2] &= ~MCB_AP_LO2R;
+	}
+	if (mc_a_source_is_used(MCDRV_ASRC_MIC1_ON))
+		info->analog[3] &= ~MCB_MC1;
+	if (mc_a_source_is_used(MCDRV_ASRC_MIC2_ON))
+		info->analog[3] &= ~MCB_MC2;
+	if (mc_a_source_is_used(MCDRV_ASRC_MIC3_ON))
+		info->analog[3] &= ~MCB_MC3;
+	if (mc_a_source_is_used(MCDRV_ASRC_MIC4_ON))
+		info->analog[3] &= ~MCB_MC4;
+	if ((mc_info.path_info.bias[0] & MCDRV_ASRC_MIC1_ON))
+		info->analog[3] &= ~MCB_MB1;
+	if ((mc_info.path_info.bias[1] & MCDRV_ASRC_MIC2_ON))
+		info->analog[3] &= ~MCB_MB2;
+	if ((mc_info.path_info.bias[2] & MCDRV_ASRC_MIC3_ON))
+		info->analog[3] &= ~MCB_MB3;
+	if ((mc_info.path_info.bias[3] & MCDRV_ASRC_MIC4_ON))
+		info->analog[3] &= ~MCB_MB4;
+	if (mc_source_is_used(MCDRV_DST_ADC0, MCDRV_DST_CH0))
+		info->analog[4] &= ~MCB_AP_ADL;
+	if (mc_source_is_used(MCDRV_DST_ADC0, MCDRV_DST_CH1))
+		info->analog[4] &= ~MCB_AP_ADR;
+	if (mc_source_is_used(MCDRV_DST_ADC1, MCDRV_DST_CH0))
+		info->analog[4] &= ~MCB_AP_ADM;
+	if (mc_a_source_is_used(MCDRV_ASRC_LINEIN1_L_ON)
+	    || mc_a_source_is_used(MCDRV_ASRC_LINEIN1_M_ON)
+	    || mc_a_source_is_used(MCDRV_ASRC_LINEIN1_R_ON))
+		info->analog[4] &= ~MCB_AP_LI;
+	if (info->analog[1] != MCI_AP_DA0_DEF
+	    || info->analog[2] != MCI_AP_DA1_DEF
+	    || info->analog[3] != MCI_AP_MIC_DEF
+	    || info->analog[4] != MCI_AP_AD_DEF)
+		info->analog[0] &= ~(MCB_AP_LDOA | MCB_AP_BGR | MCB_AP_VR);
+}
+
+void mc_power_info_get_current(struct mcdrv_power_info *info)
+{
+	u8 val;
+
+	info->digital = 0;
+
+	val = mc_info.a_registers[MCI_PD];
+	if (val & MCB_PLL_PD)
+		info->digital |= MCDRV_POWINFO_D_PLL_PD;
+	if (val & MCB_PE_CLK_PD)
+		info->digital |= MCDRV_POWINFO_D_PE_CLK_PD;
+	if (val & MCB_PB_CLK_PD)
+		info->digital |= MCDRV_POWINFO_D_PB_CLK_PD;
+	if (val & MCB_PM_CLK_PD)
+		info->digital |= MCDRV_POWINFO_D_PM_CLK_PD;
+	if (val & MCB_PF_CLK_PD)
+		info->digital |= MCDRV_POWINFO_D_PF_CLK_PD;
+	if (val & MCB_PC_CLK_PD)
+		info->digital |= MCDRV_POWINFO_D_PC_CLK_PD;
+
+	info->analog[0] = mc_info.ana_registers[MCI_AP];
+	info->analog[1] = mc_info.ana_registers[MCI_AP_DA0];
+	info->analog[2] = mc_info.ana_registers[MCI_AP_DA1];
+	info->analog[3] = mc_info.ana_registers[MCI_AP_MIC];
+	info->analog[4] = mc_info.ana_registers[MCI_AP_AD];
+}
+
+static u32 d2_get_source(u32 *d2, enum mcdrv_dst_ch ch)
+{
+	u32 src = 0;
+
+	if (d2) {
+		if (d2[ch] & MCDRV_D2SRC_VOICEIN_ON)
+			src |= MCDRV_D2SRC_VOICEIN_ON;
+		if (d2[ch] & MCDRV_D2SRC_VBOXIOOUT_ON)
+			src |= MCDRV_D2SRC_VBOXIOOUT_ON;
+		if (d2[ch] & MCDRV_D2SRC_VBOXHOSTOUT_ON)
+			src |= MCDRV_D2SRC_VBOXHOSTOUT_ON;
+		if (d2[ch] & MCDRV_D2SRC_ADC0_L_ON)
+			src |= MCDRV_D2SRC_ADC0_L_ON;
+		if (d2[ch] & MCDRV_D2SRC_ADC0_R_ON)
+			src |= MCDRV_D2SRC_ADC0_R_ON;
+		if (d2[ch] & MCDRV_D2SRC_ADC1_ON)
+			src |= MCDRV_D2SRC_ADC1_ON;
+		if (d2[ch] & MCDRV_D2SRC_PDM0_L_ON)
+			src |= MCDRV_D2SRC_PDM0_L_ON;
+		if (d2[ch] & MCDRV_D2SRC_PDM0_R_ON)
+			src |= MCDRV_D2SRC_PDM0_R_ON;
+		if (d2[ch] & MCDRV_D2SRC_PDM1_L_ON)
+			src |= MCDRV_D2SRC_PDM1_L_ON;
+		if (d2[ch] & MCDRV_D2SRC_PDM1_R_ON)
+			src |= MCDRV_D2SRC_PDM1_R_ON;
+		if (d2[ch] & MCDRV_D2SRC_DAC0REF_ON)
+			src |= MCDRV_D2SRC_DAC0REF_ON;
+		if (d2[ch] & MCDRV_D2SRC_DAC1REF_ON)
+			src |= MCDRV_D2SRC_DAC1REF_ON;
+	}
+
+	return src;
+}
+
+bool mc_d1_source_is_used(u32 mask)
+{
+	struct mcdrv_path_info *path;
+	int i;
+
+	path = &mc_info.path_info;
+
+	for (i = 0; i < MUSICOUT_PATH_CHANNELS; i++) {
+		if (path->music_out[i] & mask)
+			return true;
+	}
+
+	for (i = 0; i < EXTOUT_PATH_CHANNELS; i++) {
+		if (path->ext_out[i] & mask)
+			return true;
+	}
+
+	for (i = 0; i < VBOXMIXIN_PATH_CHANNELS; i++) {
+		if (path->vbox_mix_in[i] & mask)
+			return true;
+	}
+
+	for (i = 0; i < AE_PATH_CHANNELS; i++) {
+		if (path->ae0[i] & mask)
+			return true;
+		if (path->ae1[i] & mask)
+			return true;
+		if (path->ae2[i] & mask)
+			return true;
+		if (path->ae3[i] & mask)
+			return true;
+	}
+
+	for (i = 0; i < DAC0_PATH_CHANNELS; i++) {
+		if (path->dac0[i] & mask)
+			return true;
+	}
+
+	for (i = 0; i < DAC1_PATH_CHANNELS; i++) {
+		if (path->dac1[i] & mask)
+			return true;
+	}
+
+	return false;
+}
+
+bool mc_d2_source_is_used(u32 mask)
+{
+	struct mcdrv_path_info *path;
+	int i;
+
+	path = &mc_info.path_info;
+
+	for (i = 0; i < VOICEOUT_PATH_CHANNELS; i++) {
+		if (path->voice_out[i] & mask)
+			return true;
+	}
+
+	for (i = 0; i < VBOXIOIN_PATH_CHANNELS; i++) {
+		if (path->vbox_io_in[i] & mask)
+			return true;
+	}
+
+	for (i = 0; i < VBOXHOSTIN_PATH_CHANNELS; i++) {
+		if (path->vbox_host_in[i] & mask)
+			return true;
+	}
+
+	for (i = 0; i < HOSTOUT_PATH_CHANNELS; i++) {
+		if (path->host_out[i] & mask)
+			return true;
+	}
+
+	for (i = 0; i < ADIF0_PATH_CHANNELS; i++) {
+		if (path->adif0[i] & mask)
+			return true;
+	}
+
+	for (i = 0; i < ADIF1_PATH_CHANNELS; i++) {
+		if (path->adif1[i] & mask)
+			return true;
+	}
+
+	for (i = 0; i < ADIF2_PATH_CHANNELS; i++) {
+		if (path->adif2[i] & mask)
+			return true;
+	}
+
+	return false;
+}
+
+bool mc_a_source_is_used(u32 mask)
+{
+	struct mcdrv_path_info *path;
+	int i;
+
+	path = &mc_info.path_info;
+
+	for (i = 0; i < ADC0_PATH_CHANNELS; i++) {
+		if (path->adc0[i] & mask)
+			return true;
+	}
+
+	for (i = 0; i < ADC1_PATH_CHANNELS; i++) {
+		if (path->adc1[i] & mask)
+			return true;
+	}
+
+	for (i = 0; i < SP_PATH_CHANNELS; i++) {
+		if (path->sp[i] & mask)
+			return true;
+	}
+
+	for (i = 0; i < HP_PATH_CHANNELS; i++) {
+		if (path->hp[i] & mask)
+			return true;
+	}
+
+	for (i = 0; i < RC_PATH_CHANNELS; i++) {
+		if (path->rc[i] & mask)
+			return true;
+	}
+
+	for (i = 0; i < LOUT1_PATH_CHANNELS; i++) {
+		if (path->lout1[i] & mask)
+			return true;
+	}
+
+	for (i = 0; i < LOUT2_PATH_CHANNELS; i++) {
+		if (path->lout2[i] & mask)
+			return true;
+	}
+
+	return false;
+}
+
+bool mc_source_is_used(enum mcdrv_dst_type type, enum mcdrv_dst_ch ch)
+{
+	struct mcdrv_path_info *path;
+	u32 src;
+
+	path = &mc_info.path_info;
+
+	switch (type) {
+	case MCDRV_DST_MUSICOUT:
+		if (ch > MCDRV_DST_CH1)
+			break;
+		if (d1_get_source(path->music_out, ch))
+			return true;
+		break;
+	case MCDRV_DST_EXTOUT:
+		if (ch > MCDRV_DST_CH1)
+			break;
+		if (d1_get_source(path->ext_out, ch))
+			return true;
+		break;
+	case MCDRV_DST_HIFIOUT:
+		if (ch > MCDRV_DST_CH0)
+			break;
+		if (d1_get_source(path->hifi_out, ch))
+			return true;
+		break;
+	case MCDRV_DST_VBOXMIXIN:
+		if (d1_get_source(path->vbox_mix_in, ch))
+			return true;
+		break;
+	case MCDRV_DST_AE0:
+		if (ch > MCDRV_DST_CH1)
+			break;
+		if (d1_get_source(path->ae0, ch))
+			return true;
+		break;
+	case MCDRV_DST_AE1:
+		if (ch > MCDRV_DST_CH1)
+			break;
+		if (d1_get_source(path->ae1, ch))
+			return true;
+		break;
+	case MCDRV_DST_AE2:
+		if (ch > MCDRV_DST_CH1)
+			break;
+		if (d1_get_source(path->ae2, ch))
+			return true;
+		break;
+	case MCDRV_DST_AE3:
+		if (ch > MCDRV_DST_CH1)
+			break;
+		if (d1_get_source(path->ae3, ch))
+			return true;
+		break;
+	case MCDRV_DST_DAC0:
+		if (ch > MCDRV_DST_CH1)
+			break;
+		if (d1_get_source(path->dac0, ch))
+			return true;
+		break;
+	case MCDRV_DST_DAC1:
+		if (ch > MCDRV_DST_CH1)
+			break;
+		if (d1_get_source(path->dac1, ch))
+			return true;
+		break;
+	case MCDRV_DST_VOICEOUT:
+		if (ch > MCDRV_DST_CH0)
+			break;
+		if (d2_get_source(path->voice_out, ch))
+			return true;
+		break;
+	case MCDRV_DST_VBOXIOIN:
+		if (ch > MCDRV_DST_CH0)
+			break;
+		if (d2_get_source(path->vbox_io_in, ch))
+			return true;
+		break;
+	case MCDRV_DST_VBOXHOSTIN:
+		if (ch > MCDRV_DST_CH0)
+			break;
+		if (d2_get_source(path->vbox_host_in, ch))
+			return true;
+		break;
+	case MCDRV_DST_HOSTOUT:
+		if (ch > MCDRV_DST_CH0)
+			break;
+		if (d2_get_source(path->host_out, ch))
+			return true;
+		break;
+
+	case MCDRV_DST_ADIF0:
+		if (ch > MCDRV_DST_CH1)
+			break;
+		if (d2_get_source(path->adif0, ch))
+			return true;
+		break;
+	case MCDRV_DST_ADIF1:
+		if (ch > MCDRV_DST_CH1)
+			break;
+		if (d2_get_source(path->adif1, ch))
+			return true;
+		break;
+	case MCDRV_DST_ADIF2:
+		if (ch > MCDRV_DST_CH1)
+			break;
+		if (d2_get_source(path->adif2, ch))
+			return true;
+		break;
+	case MCDRV_DST_ADC0:
+		if (ch > MCDRV_DST_CH1)
+			break;
+		src = path->adc0[ch];
+		if (src & (MCDRV_ASRC_MIC_ALL_ON | MCDRV_ASRC_LINEIN1_ALL_ON))
+			return true;
+		break;
+	case MCDRV_DST_ADC1:
+		if (ch > MCDRV_DST_CH0)
+			break;
+		src = path->adc1[ch];
+		if (src & (MCDRV_ASRC_MIC_ALL_ON | MCDRV_ASRC_LINEIN1_ALL_ON))
+			return true;
+		break;
+	case MCDRV_DST_SP:
+		if (ch > MCDRV_DST_CH1)
+			break;
+		src = path->sp[ch];
+		if (src & (MCDRV_ASRC_DAC1_L_ON | MCDRV_ASRC_DAC1_R_ON))
+			return true;
+		break;
+	case MCDRV_DST_HP:
+		if (ch > MCDRV_DST_CH1)
+			break;
+		src = path->hp[ch];
+		if (src & (MCDRV_ASRC_DAC0_L_ON | MCDRV_ASRC_DAC0_R_ON))
+			return true;
+		break;
+	case MCDRV_DST_RCV:
+		if (ch > MCDRV_DST_CH0)
+			break;
+		src = path->rc[ch];
+		if (src & (MCDRV_ASRC_DAC0_L_ON | MCDRV_ASRC_DAC0_R_ON))
+			return true;
+		break;
+	case MCDRV_DST_LOUT1:
+		if (ch > MCDRV_DST_CH1)
+			break;
+		src = path->lout1[ch];
+		if (src & (MCDRV_ASRC_DAC0_L_ON | MCDRV_ASRC_DAC0_R_ON))
+			return true;
+		break;
+	case MCDRV_DST_LOUT2:
+		if (ch > MCDRV_DST_CH1)
+			break;
+		src = path->lout2[ch];
+		if (src & (MCDRV_ASRC_DAC1_L_ON | MCDRV_ASRC_DAC1_R_ON))
+			return true;
+		break;
+	case MCDRV_DST_BIAS:
+		if (ch > MCDRV_DST_CH3)
+			break;
+		src = path->bias[ch];
+		if (src & MCDRV_ASRC_MIC_ALL_ON)
+			return true;
+		break;
+	default:
+		break;
+	}
+
+	return false;
+}
+
+u32 mc_source_get(enum mcdrv_dst_type type, enum mcdrv_dst_ch ch)
+{
+	struct mcdrv_path_info *path;
+
+	path = &mc_info.path_info;
+
+	switch (type) {
+	case MCDRV_DST_MUSICOUT:
+		if (ch > MCDRV_DST_CH1)
+			break;
+		return d1_get_source(path->music_out, ch);
+	case MCDRV_DST_EXTOUT:
+		if (ch > MCDRV_DST_CH1)
+			break;
+		return d1_get_source(path->ext_out, ch);
+	case MCDRV_DST_HIFIOUT:
+		if (ch > MCDRV_DST_CH0)
+			break;
+		return d1_get_source(path->hifi_out, ch);
+	case MCDRV_DST_VBOXMIXIN:
+		return d1_get_source(path->vbox_mix_in, ch);
+	case MCDRV_DST_AE0:
+		if (ch > MCDRV_DST_CH1)
+			break;
+		return d1_get_source(path->ae0, ch);
+	case MCDRV_DST_AE1:
+		if (ch > MCDRV_DST_CH1)
+			break;
+		return d1_get_source(path->ae1, ch);
+	case MCDRV_DST_AE2:
+		if (ch > MCDRV_DST_CH1)
+			break;
+		return d1_get_source(path->ae2, ch);
+	case MCDRV_DST_AE3:
+		if (ch > MCDRV_DST_CH1)
+			break;
+		return d1_get_source(path->ae3, ch);
+	case MCDRV_DST_DAC0:
+		if (ch > MCDRV_DST_CH1)
+			break;
+		return d1_get_source(path->dac0, ch);
+	case MCDRV_DST_DAC1:
+		if (ch > MCDRV_DST_CH1)
+			break;
+		return d1_get_source(path->dac1, ch);
+	case MCDRV_DST_VOICEOUT:
+		if (ch > MCDRV_DST_CH0)
+			break;
+		return d2_get_source(path->voice_out, ch);
+	case MCDRV_DST_VBOXIOIN:
+		if (ch > MCDRV_DST_CH0)
+			break;
+		return d2_get_source(path->vbox_io_in, ch);
+	case MCDRV_DST_VBOXHOSTIN:
+		if (ch > MCDRV_DST_CH0)
+			break;
+		return d2_get_source(path->vbox_host_in, ch);
+	case MCDRV_DST_HOSTOUT:
+		if (ch > MCDRV_DST_CH0)
+			break;
+		return d2_get_source(path->host_out, ch);
+	case MCDRV_DST_ADIF0:
+		if (ch > MCDRV_DST_CH1)
+			break;
+		return d2_get_source(path->adif0, ch);
+	case MCDRV_DST_ADIF1:
+		if (ch > MCDRV_DST_CH1)
+			break;
+		return d2_get_source(path->adif1, ch);
+	case MCDRV_DST_ADIF2:
+		if (ch > MCDRV_DST_CH1)
+			break;
+		return d2_get_source(path->adif2, ch);
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+u8 mc_dsp_get_running(void)
+{
+	struct mcdrv_aec_info *aec;
+	u32 hifi_out;
+	u8 start = 0;
+
+	aec = &mc_info.aec_info;
+	hifi_out = mc_info.path_info.hifi_out[0];
+
+	if ((hifi_out & MCDRV_D1SRC_ADIF0_ON)
+	    || mc_d2_source_is_used(MCDRV_D2SRC_ADC0_ON)
+	    || mc_d2_source_is_used(MCDRV_D2SRC_ADC1_ON)
+	    || mc_d2_source_is_used(MCDRV_D2SRC_PDM0_ON)
+	    || mc_d2_source_is_used(MCDRV_D2SRC_PDM1_ON)
+	    || mc_source_is_used(MCDRV_DST_DAC0, MCDRV_DST_CH0)
+	    || mc_source_is_used(MCDRV_DST_DAC0, MCDRV_DST_CH1)
+	    || mc_source_is_used(MCDRV_DST_DAC1, MCDRV_DST_CH0)
+	    || mc_source_is_used(MCDRV_DST_DAC1, MCDRV_DST_CH1))
+		start |= MCDRV_DSP_START_E | MCDRV_DSP_START_M;
+
+	if (mc_d1_source_is_used(MCDRV_D1SRC_AE_ALL_ON)) {
+		start |= MCDRV_DSP_START_B | MCDRV_DSP_START_M;
+		if (!aec->fdsp_locate && aec->audio_engine.fdsp_on == 1)
+			start |= MCDRV_DSP_START_E | MCDRV_DSP_START_F;
+	}
+
+	if (mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH2)
+	    || mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH3)
+	    || mc_d1_source_is_used(MCDRV_D1SRC_VBOXREFOUT_ON)) {
+		start |= MCDRV_DSP_START_M;
+		if (aec->vbox.cdsp_func_a_on || aec->vbox.cdsp_func_b_on)
+			start |= MCDRV_DSP_START_C;
+		if (aec->fdsp_locate && aec->vbox.fdsp_on == 1)
+			start |= MCDRV_DSP_START_F;
+	} else {
+		if (mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH0)
+		    || mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH1)) {
+			start |= MCDRV_DSP_START_M;
+			if (aec->vbox.lpt2_vsource == 1) {
+				if (aec->vbox.cdsp_func_a_on
+				    || aec->vbox.cdsp_func_b_on)
+					start |= MCDRV_DSP_START_C;
+				if (aec->fdsp_locate && aec->vbox.fdsp_on == 1)
+					start |= MCDRV_DSP_START_F;
+			}
+		}
+
+		if (mc_d1_source_is_used(MCDRV_D1SRC_VBOXOUT_ON)) {
+			start |= MCDRV_DSP_START_M;
+			if (aec->vbox.isrc2_vsource == 1) {
+				if (aec->vbox.cdsp_func_a_on
+				    || aec->vbox.cdsp_func_b_on)
+					start |= MCDRV_DSP_START_C;
+				if (aec->fdsp_locate && aec->vbox.fdsp_on == 1)
+					start |= MCDRV_DSP_START_F;
+			}
+		}
+
+		if (mc_source_is_used(MCDRV_DST_VBOXHOSTIN, MCDRV_DST_CH0)
+		    || mc_source_is_used(MCDRV_DST_HOSTOUT, MCDRV_DST_CH0)) {
+			if (aec->vbox.cdsp_func_a_on
+			    || aec->vbox.cdsp_func_b_on)
+				start |= MCDRV_DSP_START_C;
+			if (aec->fdsp_locate && aec->vbox.fdsp_on == 1)
+				start |= MCDRV_DSP_START_F;
+		}
+
+		if (mc_source_is_used(MCDRV_DST_VOICEOUT, MCDRV_DST_CH0)
+		    && aec->vbox.lpt2_vsource == 1) {
+			if (aec->vbox.cdsp_func_a_on
+			    || aec->vbox.cdsp_func_b_on)
+				start |= MCDRV_DSP_START_C;
+			if (aec->fdsp_locate && aec->vbox.fdsp_on == 1)
+				start |= MCDRV_DSP_START_F;
+		}
+	}
+
+	if (mc_d1_source_is_used(MCDRV_D1SRC_MUSICIN_ON)
+	    || mc_d1_source_is_used(MCDRV_D1SRC_EXTIN_ON)
+	    || mc_source_is_used(MCDRV_DST_MUSICOUT, MCDRV_DST_CH0)
+	    || mc_source_is_used(MCDRV_DST_MUSICOUT, MCDRV_DST_CH1)
+	    || mc_source_is_used(MCDRV_DST_EXTOUT, MCDRV_DST_CH0)
+	    || mc_source_is_used(MCDRV_DST_EXTOUT, MCDRV_DST_CH1))
+		start |= MCDRV_DSP_START_M;
+
+	return start;
+}
+
+void mc_resource_clear(void)
+{
+	mc_info.packet.data_size = 0;
+	mc_info.slave_addr = 0xffff;
+	mc_info.type = 0xffff;
+	mc_info.addr = 0xffff;
+	mc_info.data_count = 0;
+	mc_info.prev_addr_index = 0;
+}
+
+void mc_bus_queue_add(u16 type, u16 addr, u8 data, enum mcdrv_update_mode mode)
+{
+	const u16 *next_list;
+	u16 size, next_addr, after_next_addr;
+	u16 index, prev_type, prev_addr, prev_slave_addr, slave_addr;
+	u8 *regs, *packet;
+	u8 packet_addr, packet_window, addr_inc_reg;
+	bool addr_inc;
+
+	prev_type = mc_info.type;
+	prev_slave_addr = mc_info.slave_addr;
+
+	slave_addr = MCDRV_SLAVE_ADDR_DIGITAL;
+
+	switch (type) {
+	case MCDRV_PACKET_REGTYPE_IF:
+		regs = mc_info.if_registers;
+		next_list = mc_next_addr_list;
+		addr_inc = false;
+		addr_inc_reg = 0;
+		packet_addr = addr;
+		packet_window = packet_addr;
+		break;
+	case MCDRV_PACKET_REGTYPE_A:
+		regs = mc_info.a_registers;
+		next_list = mc_next_addr_list_inc;
+		addr_inc = true;
+		addr_inc_reg = MCB_A_REG_AINC;
+		packet_addr = MCI_A_REG_A;
+		packet_window = MCI_A_REG_D;
+		break;
+	case MCDRV_PACKET_REGTYPE_MA:
+		regs = mc_info.ma_registers;
+		next_list = mc_next_addr_list_inc;
+		addr_inc = true;
+		addr_inc_reg = MCB_MA_REG_AINC;
+		packet_addr = MCI_MA_REG_A;
+		packet_window = MCI_MA_REG_D;
+		break;
+	case MCDRV_PACKET_REGTYPE_MB:
+		regs = mc_info.mb_registers;
+		next_list = mc_next_addr_list_inc;
+		addr_inc = true;
+		addr_inc_reg = MCB_MB_REG_AINC;
+		packet_addr = MCI_MB_REG_A;
+		packet_window = MCI_MB_REG_D;
+		break;
+	case MCDRV_PACKET_REGTYPE_B:
+		regs = mc_info.b_registers;
+		next_list = mc_next_addr_list_inc;
+		addr_inc = true;
+		addr_inc_reg = MCB_B_REG_AINC;
+		packet_addr = MCI_B_REG_A;
+		packet_window = MCI_B_REG_D;
+		break;
+	case MCDRV_PACKET_REGTYPE_E:
+		regs = mc_info.e_registers;
+		next_list = mc_next_addr_list_inc;
+		addr_inc = true;
+		addr_inc_reg = MCB_E_REG_AINC;
+		packet_addr = MCI_E_REG_A;
+		packet_window = MCI_E_REG_D;
+		break;
+	case MCDRV_PACKET_REGTYPE_C:
+		regs = mc_info.c_registers;
+		next_list = mc_next_addr_list_inc;
+		addr_inc = true;
+		addr_inc_reg = 0;
+		packet_addr = MCI_C_REG_A;
+		packet_window = MCI_C_REG_D;
+		break;
+	case MCDRV_PACKET_REGTYPE_F:
+		regs = mc_info.f_registers;
+		next_list = mc_next_addr_list_inc;
+		addr_inc = true;
+		addr_inc_reg = MCB_F_REG_AINC;
+		packet_addr = MCI_F_REG_A;
+		packet_window = MCI_F_REG_D;
+		break;
+	case MCDRV_PACKET_REGTYPE_ANA:
+		slave_addr = MCDRV_SLAVE_ADDR_ANALOG;
+		regs = mc_info.ana_registers;
+		next_list = mc_next_addr_list_inc;
+		addr_inc = true;
+		addr_inc_reg = MCB_ANA_REG_AINC;
+		packet_addr = MCI_ANA_REG_A;
+		packet_window = MCI_ANA_REG_D;
+		break;
+	case MCDRV_PACKET_REGTYPE_CD:
+		slave_addr = MCDRV_SLAVE_ADDR_ANALOG;
+		regs = mc_info.cd_registers;
+		next_list = mc_next_addr_list_inc;
+		addr_inc = true;
+		addr_inc_reg = MCB_CD_REG_AINC;
+		packet_addr = MCI_CD_REG_A;
+		packet_window = MCI_CD_REG_D;
+		break;
+	default:
+		return;
+	}
+
+	if ((prev_type != 0xffff && prev_type != type)
+	    || (prev_slave_addr != 0xffff && prev_slave_addr != slave_addr)) {
+		mc_bus_queue_flush();
+		mc_resource_clear();
+	}
+
+	if (mode != MCDRV_UPDATE_FORCE && data == regs[addr])
+		return;
+
+	if (mc_info.addr == 0xffff)
+		mc_info.addr = addr;
+
+	prev_addr = mc_info.addr;
+
+	if (mode != MCDRV_UPDATE_DUMMY) {
+		packet = mc_info.packet.data;
+		size = mc_info.packet.data_size;
+		index = mc_info.prev_addr_index;
+		next_addr = next_list[prev_addr];
+
+		if (size > MCDRV_MAX_CTRL_DATA_NUM - 8)
+			pr_warn("ymu831: remaining packet buffer too small\n");
+
+		if (slave_addr == prev_slave_addr && type == prev_type
+		    && next_addr != 0xffff && addr != next_addr && addr_inc) {
+			after_next_addr = next_list[next_addr];
+			if (after_next_addr == addr) {
+				if (!mc_info.data_count)
+					packet[index] |= BURST_WRITE_ENABLE;
+
+				packet[size++] = regs[next_addr];
+				mc_info.data_count++;
+				next_addr = after_next_addr;
+			} else if (after_next_addr != 0xffff
+				   && next_list[after_next_addr] == addr) {
+				if (!mc_info.data_count)
+					packet[index] |= BURST_WRITE_ENABLE;
+
+				packet[size++] = regs[next_addr];
+				packet[size++] = regs[after_next_addr];
+				mc_info.data_count += 2;
+				next_addr = next_list[after_next_addr];
+			}
+		}
+
+		if (!size || addr != next_addr) {
+			if (mc_info.data_count) {
+				mc_bus_queue_flush();
+				mc_resource_clear();
+				size = mc_info.packet.data_size;
+			}
+
+			if (MCDRV_PACKET_REGTYPE_IF == type) {
+				packet[size] = packet_addr << 1;
+				index = size++;
+			} else {
+				packet[size++] = packet_addr << 1;
+				packet[size++] = addr | addr_inc_reg;
+				packet[size] = packet_window << 1;
+				index = size++;
+			}
+
+			mc_info.prev_addr_index = index;
+		} else {
+			if (!mc_info.data_count)
+				packet[index] |= BURST_WRITE_ENABLE;
+
+			mc_info.data_count++;
+		}
+
+		packet[size++] = data;
+
+		mc_info.slave_addr = slave_addr;
+		mc_info.type = type;
+		mc_info.addr = addr;
+		mc_info.packet.data_size = size;
+	}
+
+	/* save register value */
+	regs[addr] = data;
+}
+
+void mc_bus_queue_flush(void)
+{
+	if (mc_info.packet.data_size) {
+		mc_write(mc_info.slave_addr,
+				   mc_info.packet.data,
+				   mc_info.packet.data_size);
+	}
+}
+
+static int wait_set_bit(u8 slave_addr, u16 addr, u8 mask,
+			u32 interval, u32 timeout)
+{
+	u8 val;
+
+	while (timeout > 0) {
+		mc_read(slave_addr, addr, &val, 1);
+		if ((val & mask) == mask)
+			return 0;
+
+		msleep(interval);
+		timeout--;
+	}
+
+	return -EAGAIN;
+}
+
+static int wait_release_bit(u8 slave_addr, u16 addr, u8 mask,
+			    u32 interval, u32 timeout)
+{
+	u8 val;
+
+	while (timeout > 0) {
+		mc_read(slave_addr, addr, &val, 1);
+		if (!(val & mask))
+			return 0;
+
+		msleep(interval);
+		timeout--;
+	}
+
+	return -EAGAIN;
+}
+
+static int wait_set_dspbit(u8 slave_addr, u8 addr_a, u8 addr_d, u8 addr,
+			   u8 mask, u32 interval, u32 timeout)
+{
+	u8 val, data[2];
+
+	data[0] = addr_a << 1;
+	data[1] = addr;
+
+	while (timeout > 0) {
+		mc_write(slave_addr, data, 2);
+		mc_read(slave_addr, addr_d, &val, 1);
+		if ((val & mask) == mask)
+			return 0;
+
+		msleep(interval);
+		timeout--;
+	}
+
+	return -EAGAIN;
+}
+
+static int wait_release_dspbit(u8 slave_addr, u8 addr_a, u8 addr_d, u8 addr,
+			       u8 mask, u32 interval, u32 timeout)
+{
+	u8 val, data[2];
+
+	data[0] = addr_a << 1;
+	data[1] = addr;
+
+	while (timeout > 0) {
+		mc_write(slave_addr, data, 2);
+		mc_read(slave_addr, addr_d, &val, 1);
+		if (!(val & mask))
+			return 0;
+
+		msleep(interval);
+		timeout--;
+	}
+
+	return -EAGAIN;
+}
+
+int mc_wait_event(u32 event, u32 param)
+{
+	u32 interval, timeout;
+	u8 data[2];
+	int ret = 0;
+
+	switch (event) {
+	case MCDRV_EVT_SVOL_DONE:
+		interval = mc_info.dev_info.wait_time.poll_interval[0];
+		timeout = mc_info.dev_info.wait_time.poll_timeout[0];
+
+		if (param >> 8) {
+			data[0] = MCI_ANA_REG_A << 1;
+			data[1] = MCI_BUSY1;
+			mc_write_analog(data, 2);
+			ret = wait_release_bit(MCDRV_SLAVE_ADDR_ANALOG,
+					       MCI_ANA_REG_D, param >> 8,
+					       interval, timeout);
+			if (ret < 0)
+				break;
+		}
+
+		if (param & 0xffU) {
+			data[0] = MCI_ANA_REG_A << 1;
+			data[1] = MCI_BUSY2;
+			mc_write_analog(data, 2);
+			ret = wait_release_bit(MCDRV_SLAVE_ADDR_ANALOG,
+					       MCI_ANA_REG_D, param & 0xff,
+					       interval, timeout);
+		}
+		break;
+	case MCDRV_EVT_ALLMUTE:
+		interval = mc_info.dev_info.wait_time.poll_interval[1];
+		timeout = mc_info.dev_info.wait_time.poll_timeout[1];
+
+		data[0] = MCI_MA_REG_A << 1;
+		data[1] = MCI_DIFI_VFLAG;
+		mc_write_digital(data, 2);
+		ret = wait_release_bit(MCDRV_SLAVE_ADDR_DIGITAL,
+				       MCI_MA_REG_D,
+				       (MCB_DIFI3_VFLAG1 | MCB_DIFI3_VFLAG0 |
+					MCB_DIFI2_VFLAG1 | MCB_DIFI2_VFLAG0 |
+					MCB_DIFI1_VFLAG1 | MCB_DIFI1_VFLAG0 |
+					MCB_DIFI1_VFLAG0 | MCB_DIFI0_VFLAG0),
+				       interval, timeout);
+		if (ret < 0)
+			break;
+
+		data[1] = MCI_ADI_VFLAG;
+		mc_write_digital(data, 2);
+		ret = wait_release_bit(MCDRV_SLAVE_ADDR_DIGITAL,
+				       MCI_MA_REG_D,
+				       (MCB_ADI2_VFLAG1 | MCB_ADI2_VFLAG0 |
+					MCB_ADI1_VFLAG1 | MCB_ADI1_VFLAG0 |
+					MCB_ADI0_VFLAG1 | MCB_ADI0_VFLAG0),
+				       interval, timeout);
+		if (ret < 0)
+			break;
+
+		data[1] = MCI_DIFO_VFLAG;
+		mc_write_digital(data, 2);
+		ret = wait_release_bit(MCDRV_SLAVE_ADDR_DIGITAL,
+				       MCI_MA_REG_D,
+				       (MCB_DIFO3_VFLAG1 | MCB_DIFO3_VFLAG0 |
+					MCB_DIFO2_VFLAG1 | MCB_DIFO2_VFLAG0 |
+					MCB_DIFO1_VFLAG1 | MCB_DIFO1_VFLAG0 |
+					MCB_DIFO1_VFLAG0 | MCB_DIFO0_VFLAG0),
+				       interval, timeout);
+		if (ret < 0)
+			break;
+
+		data[1] = MCI_DAO_VFLAG;
+		mc_write_digital(data, 2);
+		ret = wait_release_bit(MCDRV_SLAVE_ADDR_DIGITAL,
+				       MCI_MA_REG_D,
+				       (MCB_DAO1_VFLAG1 | MCB_DAO1_VFLAG0 |
+					MCB_DAO0_VFLAG1 | MCB_DAO0_VFLAG0),
+				       interval, timeout);
+		break;
+	case MCDRV_EVT_DIRMUTE:
+		interval = mc_info.dev_info.wait_time.poll_interval[1];
+		timeout = mc_info.dev_info.wait_time.poll_timeout[1];
+
+		data[0] = MCI_MA_REG_A << 1;
+		data[1] = MCI_DIFI_VFLAG;
+		mc_write_digital(data, 2);
+		ret = wait_release_bit(MCDRV_SLAVE_ADDR_DIGITAL,
+				       MCI_MA_REG_D, param, interval, timeout);
+		break;
+	case MCDRV_EVT_ADCMUTE:
+		interval = mc_info.dev_info.wait_time.poll_interval[1];
+		timeout = mc_info.dev_info.wait_time.poll_timeout[1];
+
+		data[0] = MCI_MA_REG_A << 1;
+		data[1] = MCI_ADI_VFLAG;
+		mc_write_digital(data, 2);
+		ret = wait_release_bit(MCDRV_SLAVE_ADDR_DIGITAL,
+				       MCI_MA_REG_D, param, interval, timeout);
+		break;
+	case MCDRV_EVT_DITMUTE:
+		interval = mc_info.dev_info.wait_time.poll_interval[1];
+		timeout = mc_info.dev_info.wait_time.poll_timeout[1];
+
+		data[0] = MCI_MA_REG_A << 1;
+		data[1] = MCI_DIFO_VFLAG;
+		mc_write_digital(data, 2);
+		ret = wait_release_bit(MCDRV_SLAVE_ADDR_DIGITAL,
+				       MCI_MA_REG_D, param, interval, timeout);
+		break;
+	case MCDRV_EVT_DACMUTE:
+		interval = mc_info.dev_info.wait_time.poll_interval[1];
+		timeout = mc_info.dev_info.wait_time.poll_timeout[1];
+
+		data[0] = MCI_MA_REG_A << 1;
+		data[1] = MCI_DAO_VFLAG;
+		mc_write_digital(data, 2);
+		ret = wait_release_bit(MCDRV_SLAVE_ADDR_DIGITAL,
+				       MCI_MA_REG_D, param, interval, timeout);
+		break;
+	case MCDRV_EVT_CLKBUSY_RESET:
+		interval = mc_info.dev_info.wait_time.poll_interval[2];
+		timeout = mc_info.dev_info.wait_time.poll_timeout[2];
+
+		data[0] = MCI_A_REG_A << 1;
+		data[1] = MCI_CLKSRC;
+		mc_write_digital(data, 2);
+		ret = wait_release_bit(MCDRV_SLAVE_ADDR_DIGITAL,
+				       MCI_A_REG_D, MCB_CLKBUSY, interval,
+				       timeout);
+		break;
+	case MCDRV_EVT_PSW_RESET:
+		interval = mc_info.dev_info.wait_time.poll_interval[4];
+		timeout = mc_info.dev_info.wait_time.poll_timeout[4];
+
+		ret = wait_release_bit(MCDRV_SLAVE_ADDR_DIGITAL,
+				       param >> 8, param & 0xff,
+				       interval, timeout);
+		break;
+	case MCDRV_EVT_OFFCAN_BSY_RESET:
+		interval = mc_info.dev_info.wait_time.poll_interval[3];
+		timeout = mc_info.dev_info.wait_time.poll_timeout[3];
+
+		data[0] = MCI_CD_REG_A << 1;
+		data[1] = MCI_SSENSEFIN;
+		mc_write_analog(data, 2);
+		ret = wait_release_bit(MCDRV_SLAVE_ADDR_ANALOG, MCI_CD_REG_D,
+				       MCB_OFFCAN_BSY, interval, timeout);
+		break;
+	case MCDRV_EVT_ANA_RDY:
+		interval = mc_info.dev_info.wait_time.poll_interval[5];
+		timeout = mc_info.dev_info.wait_time.poll_timeout[5];
+
+		data[0] = MCI_ANA_REG_A << 1;
+		data[1] = param >> 8;
+		mc_write_analog(data, 2);
+		ret = wait_set_bit(MCDRV_SLAVE_ADDR_ANALOG, MCI_ANA_REG_D,
+				   param & 0xff, interval, timeout);
+		break;
+	case MCDRV_EVT_AP_CP_A_SET:
+		interval = mc_info.dev_info.wait_time.poll_interval[5];
+		timeout = mc_info.dev_info.wait_time.poll_timeout[5];
+
+		data[0] = MCI_ANA_REG_A << 1;
+		data[1] = param >> 8;
+		mc_write_analog(data, 2);
+		ret = wait_set_bit(MCDRV_SLAVE_ADDR_ANALOG, MCI_ANA_REG_D,
+				   param & 0xff, interval, timeout);
+		break;
+	case MCDRV_EVT_IF_REG_FLAG_SET:
+		interval = mc_info.dev_info.wait_time.poll_interval[3];
+		timeout = mc_info.dev_info.wait_time.poll_timeout[3];
+
+		ret = wait_set_bit(MCDRV_SLAVE_ADDR_DIGITAL, param >> 8,
+				   param & 0xff, interval, timeout);
+		break;
+	case MCDRV_EVT_IF_REG_FLAG_RESET:
+		interval = mc_info.dev_info.wait_time.poll_interval[3];
+		timeout = mc_info.dev_info.wait_time.poll_timeout[3];
+
+		ret = wait_release_bit(MCDRV_SLAVE_ADDR_DIGITAL, param >> 8,
+				       param & 0xff, interval, timeout);
+		break;
+	case MCDRV_EVT_B_REG_FLAG_SET:
+		interval = mc_info.dev_info.wait_time.poll_interval[3];
+		timeout = mc_info.dev_info.wait_time.poll_timeout[3];
+
+		ret = wait_set_dspbit(MCDRV_SLAVE_ADDR_DIGITAL, MCI_B_REG_A,
+				      MCI_B_REG_D, param >> 8, param & 0xff,
+				      interval, timeout);
+		break;
+	case MCDRV_EVT_B_REG_FLAG_RESET:
+		interval = mc_info.dev_info.wait_time.poll_interval[3];
+		timeout = mc_info.dev_info.wait_time.poll_timeout[3];
+
+		ret = wait_release_dspbit(MCDRV_SLAVE_ADDR_DIGITAL, MCI_B_REG_A,
+					  MCI_B_REG_D, param >> 8, param & 0xff,
+					  interval, timeout);
+		break;
+	case MCDRV_EVT_E_REG_FLAG_SET:
+		interval = mc_info.dev_info.wait_time.poll_interval[3];
+		timeout = mc_info.dev_info.wait_time.poll_timeout[3];
+
+		ret = wait_set_dspbit(MCDRV_SLAVE_ADDR_DIGITAL, MCI_E_REG_A,
+				      MCI_E_REG_D, param >> 8, param & 0xff,
+				      interval, timeout);
+		break;
+	case MCDRV_EVT_E_REG_FLAG_RESET:
+		interval = mc_info.dev_info.wait_time.poll_interval[3];
+		timeout = mc_info.dev_info.wait_time.poll_timeout[3];
+
+		ret = wait_release_dspbit(MCDRV_SLAVE_ADDR_DIGITAL, MCI_E_REG_A,
+					  MCI_E_REG_D, param >> 8, param & 0xff,
+					  interval, timeout);
+		break;
+	case MCDRV_EVT_C_REG_FLAG_SET:
+		interval = mc_info.dev_info.wait_time.poll_interval[3];
+		timeout = mc_info.dev_info.wait_time.poll_timeout[3];
+
+		ret = wait_set_dspbit(MCDRV_SLAVE_ADDR_DIGITAL, MCI_C_REG_A,
+				      MCI_C_REG_D, param >> 8, param & 0xff,
+				      interval, timeout);
+		break;
+	case MCDRV_EVT_C_REG_FLAG_RESET:
+		interval = mc_info.dev_info.wait_time.poll_interval[3];
+		timeout = mc_info.dev_info.wait_time.poll_timeout[3];
+		ret = wait_release_dspbit(MCDRV_SLAVE_ADDR_DIGITAL, MCI_C_REG_A,
+					  MCI_C_REG_D, param >> 8, param & 0xff,
+					  interval, timeout);
+		break;
+	case MCDRV_EVT_F_REG_FLAG_SET:
+		interval = mc_info.dev_info.wait_time.poll_interval[3];
+		timeout = mc_info.dev_info.wait_time.poll_timeout[3];
+		ret = wait_set_dspbit(MCDRV_SLAVE_ADDR_DIGITAL, MCI_F_REG_A,
+				      MCI_F_REG_D, param >> 8, param & 0xff,
+				      interval, timeout);
+		break;
+	case MCDRV_EVT_F_REG_FLAG_RESET:
+		interval = mc_info.dev_info.wait_time.poll_interval[3];
+		timeout = mc_info.dev_info.wait_time.poll_timeout[3];
+
+		ret = wait_release_dspbit(MCDRV_SLAVE_ADDR_DIGITAL, MCI_F_REG_A,
+					  MCI_F_REG_D, param >> 8, param & 0xff,
+					  interval, timeout);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
diff --git a/sound/soc/codecs/ymu831/mcresctrl.h b/sound/soc/codecs/ymu831/mcresctrl.h
new file mode 100644
index 0000000..4494779
--- /dev/null
+++ b/sound/soc/codecs/ymu831/mcresctrl.h
@@ -0,0 +1,394 @@
+/****************************************************************************
+ *
+ * Copyright(c) 2012 Yamaha Corporation. All rights reserved.
+ *
+ * Module	: mcresctrl.h
+ * Description	: MC resource control driver header
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
+#ifndef _MCRESCTRL_H
+#define _MCRESCTRL_H
+
+#include "mcdriver.h"
+#include "mcpacking.h"
+
+#define MCDRV_DEVID_ANA			0x90
+#define MCDRV_DEVID_DIG			0x80
+#define MCDRV_DEVID_MASK		0xf8
+#define MCDRV_VERID_MASK		0x07
+
+enum mcdrv_state {
+	MCDRV_STATE_NOTINIT,
+	MCDRV_STATE_READY,
+};
+
+/* volume setting */
+#define MCDRV_LOGICAL_VOL_MUTE		-24576	/* -96dB */
+
+#define MCDRV_REG_MUTE			0x00
+
+/* Path destination channel */
+enum mcdrv_dst_ch {
+	MCDRV_DST_CH0 = 0,
+	MCDRV_DST_CH1,
+	MCDRV_DST_CH2,
+	MCDRV_DST_CH3
+};
+
+/* Path destination type */
+enum mcdrv_dst_type {
+	MCDRV_DST_MUSICOUT = 0,
+	MCDRV_DST_EXTOUT,
+	MCDRV_DST_HIFIOUT,
+	MCDRV_DST_VBOXMIXIN,
+	MCDRV_DST_AE0,
+	MCDRV_DST_AE1,
+	MCDRV_DST_AE2,
+	MCDRV_DST_AE3,
+	MCDRV_DST_DAC0,
+	MCDRV_DST_DAC1,
+	MCDRV_DST_VOICEOUT,
+	MCDRV_DST_VBOXIOIN,
+	MCDRV_DST_VBOXHOSTIN,
+	MCDRV_DST_HOSTOUT,
+	MCDRV_DST_ADIF0,
+	MCDRV_DST_ADIF1,
+	MCDRV_DST_ADIF2,
+	MCDRV_DST_ADC0,
+	MCDRV_DST_ADC1,
+	MCDRV_DST_SP,
+	MCDRV_DST_HP,
+	MCDRV_DST_RCV,
+	MCDRV_DST_LOUT1,
+	MCDRV_DST_LOUT2,
+	MCDRV_DST_BIAS
+};
+
+/* Register update parameter */
+enum mcdrv_update_mode {
+	MCDRV_UPDATE_NORMAL,
+	MCDRV_UPDATE_FORCE,
+	MCDRV_UPDATE_DUMMY
+};
+
+/* DSP Start */
+#define MCDRV_DSP_START_E	0x01
+#define MCDRV_DSP_START_B	0x02
+#define MCDRV_DSP_START_M	0x04
+#define MCDRV_DSP_START_F	0x08
+#define MCDRV_DSP_START_C	0x10
+
+struct mcdrv_aec_bdsp {
+	u8 *data;
+	u32 data_size;
+};
+
+struct mcdrv_aec_fdsp {
+	u8 *data;
+	u32 data_size;
+};
+
+struct mcdrv_aec_cdsp {
+	u8 *data;
+	u32 data_size;
+};
+
+struct mcdrv_aec_syseq_ex {
+	bool enable;
+	struct {
+		u8 coef_a0[3];
+		u8 coef_a1[3];
+		u8 coef_a2[3];
+		u8 coef_b1[3];
+		u8 coef_b2[3];
+	} band[2];
+};
+
+struct mcdrv_aec_e2_config {
+	u8 *data;
+	u32 data_size;
+};
+
+struct mcdrv_aec_audio_engine {
+	bool enable;
+	u8 on;
+	bool fdsp_on;
+	u8 bdsp_ae0_src;
+	u8 bdsp_ae1_src;
+	u8 mixer_in0_src;
+	u8 mixer_in1_src;
+	u8 mixer_in2_src;
+	u8 mixer_in3_src;
+	struct mcdrv_aec_bdsp bdsp;
+	struct mcdrv_aec_fdsp fdsp;
+};
+
+struct mcdrv_aec_vbox {
+	bool enable;
+	u8 cdsp_func_a_on;
+	u8 cdsp_func_b_on;
+	u8 cdsp_jtag_on;
+	bool fdsp_on;
+	u8 fdsp_po_source;
+	u8 isrc2_vsource;
+	u8 isrc2_ch1_vsource;
+	u8 isrc3_vsource;
+	u8 lpt2_vsource;
+	u8 lpt2_mix_vol_o;
+	u8 lpt2_mix_vol_i;
+	u8 src3_ctrl;
+	u8 src2_fs;
+	u8 src2_thru;
+	u8 src3_fs;
+	u8 src3_thru;
+	struct mcdrv_aec_cdsp cdsp_a;
+	struct mcdrv_aec_cdsp cdsp_b;
+	struct mcdrv_aec_fdsp fdsp;
+};
+
+#define	MCDRV_AEC_OUTPUT_N	2
+
+struct mcdrv_aec_output {
+	u8 lpf_pre_thru[MCDRV_AEC_OUTPUT_N];
+	u8 lpf_post_thru[MCDRV_AEC_OUTPUT_N];
+	u8 dcc_sel[MCDRV_AEC_OUTPUT_N];
+	u8 signal_detect_level;
+	u8 power_detect_level[MCDRV_AEC_OUTPUT_N];
+	u8 osf_sel[MCDRV_AEC_OUTPUT_N];
+	u8 syseq_enb[MCDRV_AEC_OUTPUT_N];
+	u8 syseq_coef_a0[MCDRV_AEC_OUTPUT_N][3];
+	u8 syseq_coef_a1[MCDRV_AEC_OUTPUT_N][3];
+	u8 syseq_coef_a2[MCDRV_AEC_OUTPUT_N][3];
+	u8 syseq_coef_b1[MCDRV_AEC_OUTPUT_N][3];
+	u8 syseq_coef_b2[MCDRV_AEC_OUTPUT_N][3];
+	u8 clip_md[MCDRV_AEC_OUTPUT_N];
+	u8 clip_att[MCDRV_AEC_OUTPUT_N];
+	u8 clip_rel[MCDRV_AEC_OUTPUT_N];
+	u8 clip_g[MCDRV_AEC_OUTPUT_N];
+	u8 osf_gain[MCDRV_AEC_OUTPUT_N][2];
+	u8 dcl_on[MCDRV_AEC_OUTPUT_N];
+	u8 dcl_gain[MCDRV_AEC_OUTPUT_N];
+	u8 dcl_limit[MCDRV_AEC_OUTPUT_N][2];
+	u8 random_dither_on[MCDRV_AEC_OUTPUT_N];
+	u8 random_dither_level[MCDRV_AEC_OUTPUT_N];
+	u8 random_dither_pos[MCDRV_AEC_OUTPUT_N];
+	u8 dc_dither_on[MCDRV_AEC_OUTPUT_N];
+	u8 dc_dither_level[MCDRV_AEC_OUTPUT_N];
+	u8 dither_type[MCDRV_AEC_OUTPUT_N];
+	u8 dng_on[MCDRV_AEC_OUTPUT_N];
+	u8 dng_zero[MCDRV_AEC_OUTPUT_N];
+	u8 dng_time[MCDRV_AEC_OUTPUT_N];
+	u8 dng_fw[MCDRV_AEC_OUTPUT_N];
+	u8 dng_attack;
+	u8 dng_release;
+	u8 dng_target[MCDRV_AEC_OUTPUT_N];
+	u8 dng_target_lineout[MCDRV_AEC_OUTPUT_N];
+	u8 dng_target_rc;
+	struct mcdrv_aec_syseq_ex syseq_ex[MCDRV_AEC_OUTPUT_N];
+};
+
+#define	MCDRV_AEC_INPUT_N	3
+
+struct mcdrv_aec_input {
+	u8 dsf32_l_type[MCDRV_AEC_INPUT_N];
+	u8 dsf32_r_type[MCDRV_AEC_INPUT_N];
+	u8 dsf4_sel[MCDRV_AEC_INPUT_N];
+	u8 dcc_sel[MCDRV_AEC_INPUT_N];
+	u8 dng_on[MCDRV_AEC_INPUT_N];
+	u8 dng_att[MCDRV_AEC_INPUT_N];
+	u8 dng_rel[MCDRV_AEC_INPUT_N];
+	u8 dng_fw[MCDRV_AEC_INPUT_N];
+	u8 dng_time[MCDRV_AEC_INPUT_N];
+	u8 dng_zero[MCDRV_AEC_INPUT_N][2];
+	u8 dng_target[MCDRV_AEC_INPUT_N][2];
+	u8 depop_att[MCDRV_AEC_INPUT_N];
+	u8 depop_wait[MCDRV_AEC_INPUT_N];
+	u8 ref_sel;
+};
+
+struct mcdrv_aec_pdm {
+	u8 mode;
+	u8 st_wait;
+	u8 pdm0_loadtime;
+	u8 pdm0_l_finedelay;
+	u8 pdm0_r_finedelay;
+	u8 pdm1_loadtime;
+	u8 pdm1_l_finedelay;
+	u8 pdm1_r_finedelay;
+	u8 pdm0_data_delay;
+	u8 pdm1_data_delay;
+};
+
+struct mcdrv_aec_e2 {
+	bool enable;
+	u8 da_sel;
+	u8 ad_sel;
+	bool on;
+	struct mcdrv_aec_e2_config config;
+};
+struct mcdrv_aec_adj {
+	u8 hold;
+	u8 cnt;
+	u8 max[2];
+};
+
+struct mcdrv_aec_edsp_misc {
+	u8 i2s_out_enable;
+	u8 ch_sel;
+	u8 loopback;
+};
+
+struct mcdrv_aec_control {
+	u8 command;
+	u8 param[4];
+};
+
+/* fdsp_locate */
+#define FDSP_LOCATE_AUDIOENGINE		0
+#define FDSP_LOCATE_V_BOX		1
+
+struct mcdrv_aec_info {
+	u8 fdsp_locate;
+	struct mcdrv_aec_audio_engine audio_engine;
+	struct mcdrv_aec_vbox vbox;
+	struct mcdrv_aec_output output;
+	struct mcdrv_aec_input input;
+	struct mcdrv_aec_pdm pdm;
+	struct mcdrv_aec_e2 e2;
+	struct mcdrv_aec_adj adj;
+	struct mcdrv_aec_edsp_misc edsp_misc;
+	struct mcdrv_aec_control control;
+};
+
+/* mcdrv_gp_mode gp_ddr setting */
+#define MCDRV_GPDDR_IN			0
+#define MCDRV_GPDDR_OUT			1
+
+/* mcdrv_gp_mode gp_host setting */
+#define MCDRV_GPHOST_CPU		0
+#define MCDRV_GPHOST_CDSP		1
+
+/* mcdrv_gp_mode gp_invert setting */
+#define MCDRV_GPINV_NORMAL		0
+#define MCDRV_GPINV_INVERT		1
+
+#define MCDRV_GP_PAD0			0
+#define MCDRV_GP_PAD1			1
+#define MCDRV_GP_PAD2			2
+#define MCDRV_GP_NUM			3
+
+struct mcdrv_gp_mode {
+	bool gp_ddr[MCDRV_GP_NUM];
+	bool gp_host[MCDRV_GP_NUM];
+	bool gp_invert[MCDRV_GP_NUM];
+};
+
+enum mcdrv_dev_id {
+	MCDRV_DEV_ID_UNKNOWN = 0,
+	MCDRV_DEV_ID_80_90H,
+	MCDRV_DEV_ID_81_91H,
+	MCDRV_DEV_ID_81_92H,
+};
+
+int mc_id_set(u8 digital_id, u8 analog_id);
+enum mcdrv_dev_id mc_dev_id_get(void);
+void mc_resource_init(void);
+void mc_a_registers_init(void);
+void mc_mblock_registers_init(void);
+void mc_e_registers_init(void);
+void mc_state_update(enum mcdrv_state state);
+enum mcdrv_state mc_state_get(void);
+u8 mc_register_get_value(u16 type, u16 addr);
+void mc_register_set_value(u16 type, u16 addr, u8 val);
+
+#define mc_if_register_get_value(addr)	\
+		mc_register_get_value(MCDRV_PACKET_REGTYPE_IF, (addr))
+#define mc_ma_register_get_value(addr)	\
+		mc_register_get_value(MCDRV_PACKET_REGTYPE_MA, (addr))
+#define mc_mb_register_get_value(addr)	\
+		mc_register_get_value(MCDRV_PACKET_REGTYPE_MB, (addr))
+#define mc_a_register_get_value(addr)	\
+		mc_register_get_value(MCDRV_PACKET_REGTYPE_A, (addr))
+#define mc_e_register_get_value(addr)	\
+		mc_register_get_value(MCDRV_PACKET_REGTYPE_E, (addr))
+#define mc_ana_register_get_value(addr)	\
+		mc_register_get_value(MCDRV_PACKET_REGTYPE_ANA, (addr))
+#define mc_cd_register_get_value(addr)	\
+		mc_register_get_value(MCDRV_PACKET_REGTYPE_CD, (addr))
+#define mc_if_register_set_value(addr, val)	\
+		mc_register_set_value(MCDRV_PACKET_REGTYPE_IF, (addr), (val))
+#define mc_ma_register_set_value(addr, val)	\
+		mc_register_set_value(MCDRV_PACKET_REGTYPE_MA, (addr), (val))
+#define mc_ana_register_set_value(addr, val)	\
+		mc_register_set_value(MCDRV_PACKET_REGTYPE_ANA, (addr), (val))
+#define mc_cd_register_set_value(addr, val)	\
+		mc_register_set_value(MCDRV_PACKET_REGTYPE_CD, (addr), (val))
+
+void mc_dev_info_set(struct mcdrv_dev_info *dev_info);
+void mc_dev_info_get(struct mcdrv_dev_info *dev_info);
+int mc_clock_set(u8 clock);
+void mc_clock_get(u8 *clock);
+int mc_path_info_set(struct mcdrv_path_info *path_info);
+void mc_path_info_get(struct mcdrv_path_info *path_info);
+void mc_path_info_get_virtual(struct mcdrv_path_info *path_info);
+void mc_vol_info_set(struct mcdrv_vol_info *vol_info);
+void mc_vol_info_get(struct mcdrv_vol_info *vol_info);
+void mc_dio_info_set(struct mcdrv_dio_info *dio_info, u32 update);
+void mc_dio_info_get(struct mcdrv_dio_info *dio_info);
+void mc_dio_path_info_set(struct mcdrv_dio_path_info *dio_path_info,
+			  u32 update);
+void mc_dio_path_info_get(struct mcdrv_dio_path_info *dio_path_info);
+void mc_swap_info_set(struct mcdrv_swap_info *swap_info, u32 update);
+void mc_swap_info_get(struct mcdrv_swap_info *swap_info);
+void mc_hsdet_info_set(struct mcdrv_hsdet_info *hsdet_info, u32 update);
+void mc_hsdet_info_get(struct mcdrv_hsdet_info *hsdet_info);
+void mc_aec_info_set(struct mcdrv_aec_info *aec_info);
+void mc_aec_info_replace(struct mcdrv_aec_info *aec_info);
+void mc_aec_info_get(struct mcdrv_aec_info *aec_info);
+void mc_gp_mode_set(struct mcdrv_gp_mode *mode);
+void mc_gp_mode_get(struct mcdrv_gp_mode *mode);
+bool mc_gp_pad_get(u32 pad_no);
+void mc_clock_select_set(u8 clk_sel);
+u8 mc_clock_select_get(void);
+void mc_e_clock_select_set(u8 eclk_sel);
+u8 mc_e_clock_select_get(void);
+void mc_plug_detect_db_set(u8 plug_det_db);
+u8 mc_plug_detect_db_get(void);
+void mc_volume_info_get(struct mcdrv_vol_info *vol_info);
+void mc_power_info_get(struct mcdrv_power_info *info);
+void mc_power_info_get_current(struct mcdrv_power_info *info);
+bool mc_d1_source_is_used(u32 mask);
+bool mc_d2_source_is_used(u32 mask);
+bool mc_a_source_is_used(u32 mask);
+bool mc_source_is_used(enum mcdrv_dst_type type, enum mcdrv_dst_ch ch);
+u32 mc_source_get(enum mcdrv_dst_type type, enum mcdrv_dst_ch ch);
+u8 mc_dsp_get_running(void);
+void mc_resource_clear(void);
+void mc_bus_queue_add(u16 type, u16 addr, u8 data, enum mcdrv_update_mode mode);
+void mc_bus_queue_flush(void);
+int mc_wait_event(u32 event, u32 param);
+
+#endif /* _MCRESCTRL_H */
-- 
1.7.9.5
