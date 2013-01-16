From: Yoichi Yuasa <yuasa@linux-mips.org>
Subject: [PATCH 07/19] ALSA: ymu831: add base driver
Date: Wed, 16 Jan 2013 17:33:03 +0900
Message-ID: <20130116173303.b729a83407513e9a41ef37db@linux-mips.org>
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
 sound/soc/codecs/ymu831/Makefile   |    3 +-
 sound/soc/codecs/ymu831/mcdriver.c | 2934 ++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ymu831/mcdriver.h | 1017 +++++++++++++
 3 files changed, 3953 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/codecs/ymu831/mcdriver.c
 create mode 100644 sound/soc/codecs/ymu831/mcdriver.h

diff --git a/sound/soc/codecs/ymu831/Makefile b/sound/soc/codecs/ymu831/Makefile
index 949640e..e908b6d 100644
--- a/sound/soc/codecs/ymu831/Makefile
+++ b/sound/soc/codecs/ymu831/Makefile
@@ -1,6 +1,7 @@
 snd-soc-ymu831-objs := \
 	mcbdspdrv.o	\
 	mccdspdrv.o	\
-	mcdevif.o
+	mcdevif.o	\
+	mcdriver.o
 
 obj-$(CONFIG_SND_SOC_YMU831) += snd-soc-ymu831.o
diff --git a/sound/soc/codecs/ymu831/mcdriver.c b/sound/soc/codecs/ymu831/mcdriver.c
new file mode 100644
index 0000000..dbdce57
--- /dev/null
+++ b/sound/soc/codecs/ymu831/mcdriver.c
@@ -0,0 +1,2934 @@
+/****************************************************************************
+ *
+ * Copyright(c) 2012 Yamaha Corporation. All rights reserved.
+ *
+ * Module	: mcdriver.c
+ * Description	: MC base driver
+ * Version	: 1.0.1	Dec 20 2012
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
+#include <linux/delay.h>
+#include <linux/mutex.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include "mcbdspdrv.h"
+#include "mccdspdrv.h"
+#include "mcdefs.h"
+#include "mcdevif.h"
+#include "mcdriver.h"
+#include "mcedspdrv.h"
+#include "mcfdspdrv.h"
+#include "mcparser.h"
+#include "mcresctrl.h"
+
+#define LDO_WAIT_TIME			1	/* msec */
+#define VREF_WAIT_TIME_ES1		2	/* msec */
+#define VREF_WAIT_TIME			30	/* msec */
+#define MCDRV_DAC_MUTE_WAIT_TIME	20000
+#define MCDRV_MB4_WAIT_TIME		8000
+
+#define	T_CPMODE_IMPSENSE_BEFORE	0
+#define	T_CPMODE_IMPSENSE_AFTER		2
+
+static struct mcdrv_path_info path_alloff = {
+	.music_out = {0x00AAAAAA, 0x00AAAAAA},
+	.ext_out = {0x00AAAAAA, 0x00AAAAAA},
+	.hifi_out = {0x00AAAAAA},
+	.vbox_mix_in = {0x00AAAAAA, 0x00AAAAAA, 0x00AAAAAA, 0x00AAAAAA},
+	.ae0 = {0x00AAAAAA, 0x00AAAAAA},
+	.ae1 = {0x00AAAAAA, 0x00AAAAAA},
+	.ae2 = {0x00AAAAAA, 0x00AAAAAA},
+	.ae3 = {0x00AAAAAA, 0x00AAAAAA},
+	.dac0 = {0x00AAAAAA, 0x00AAAAAA},
+	.dac1 = {0x00AAAAAA, 0x00AAAAAA},
+	.voice_out = {0x00AAAAAA},
+	.vbox_io_in = {0x00AAAAAA},
+	.vbox_host_in = {0x00AAAAAA},
+	.host_out = {0x00AAAAAA},
+	.adif0 = {0x00AAAAAA, 0x00AAAAAA},
+	.adif1 = {0x00AAAAAA, 0x00AAAAAA},
+	.adif2 = {0x00AAAAAA, 0x00AAAAAA},
+	.adc0 = {0x002AAAAA, 0x002AAAAA},
+	.adc1 = {0x002AAAAA},
+	.sp = {0x002AAAAA, 0x002AAAAA},
+	.hp = {0x002AAAAA, 0x002AAAAA},
+	.rc = {0x002AAAAA},
+	.lout1 = {0x002AAAAA, 0x002AAAAA},
+	.lout2 = {0x002AAAAA, 0x002AAAAA},
+	.bias = {0x002AAAAA, 0x002AAAAA, 0x002AAAAA, 0x002AAAAA},
+};
+
+static DEFINE_MUTEX(mcdrv_mutex);
+
+#ifndef MCDRV_SKIP_IMPSENSE
+static inline int imp_sense_start(u8 *op_dac)
+{
+	struct mcdrv_power_info power_info;
+	struct mcdrv_power_update power_update;
+	struct mcdrv_hsdet_info hsdet_info;
+	struct mcdrv_dev_info info;
+	enum mcdrv_dev_id id;
+	u8 val, data[2];
+	int ret = 0;
+
+	id = mc_dev_id_get();
+	mc_power_info_get_current(&power_info);
+	power_info.digital &= ~(MCDRV_POWINFO_D_PM_CLK_PD |
+				MCDRV_POWINFO_D_PE_CLK_PD |
+				MCDRV_POWINFO_D_PLL_PD);
+	power_info.analog[0] &= ~(MCB_AP_LDOA | MCB_AP_BGR | MCB_AP_VR);
+
+	/* power up */
+	power_update.digital = MCDRV_POWUPDATE_D_ALL;
+	power_update.analog[0] = (u8) MCDRV_POWUPDATE_AP;
+	power_update.analog[1] = 0;
+	power_update.analog[2] = 0;
+	power_update.analog[3] = 0;
+	power_update.analog[4] = 0;
+	ret = mc_packet_add_powerup(&power_info, &power_update);
+	if (ret < 0)
+		goto exit;
+
+	ret = mc_packet_execute();
+	if (ret < 0)
+		goto exit;
+
+	mc_packet_add_force_write_if(MCI_IRQ, 0);
+	mc_packet_add_force_write_cd(MCI_IRQHS, 0);
+
+	mc_packet_add_write_e(MCI_E1DSP_CTRL, 0);
+
+	mc_packet_add_dac0_mute();
+
+	val = mc_e_register_get_value(MCI_LPF_THR);
+	val |= (MCB_OSF0_ENB | MCB_LPF0_PST_THR | MCB_LPF0_PRE_THR);
+	mc_packet_add_write_e(MCI_LPF_THR, val);
+
+	val = mc_cd_register_get_value(MCI_DP);
+	if (id == MCDRV_DEV_ID_80_90H) {
+		val &= ~(MCB_DP_ADC | MCB_DP_DAC0 | MCB_DP_PDMCK |
+			 MCB_DP_PDMADC | MCB_DP_PDMDAC);
+	} else {
+		val &= ~(MCB_DP_ADC | MCB_DP_DAC1 | MCB_DP_DAC0 |
+			 MCB_DP_PDMCK | MCB_DP_PDMADC | MCB_DP_PDMDAC);
+	}
+	mc_packet_add_write_cd(MCI_DP, val);
+
+	val = mc_e_register_get_value(MCI_DCL_GAIN);
+	val |= MCB_DCL0_OFF;
+	mc_packet_add_write_e(MCI_DCL_GAIN, val);
+
+	if (id == MCDRV_DEV_ID_80_90H) {
+		val = mc_e_register_get_value(MCI_DSF0_FLT_TYPE);
+		val |= MCB_DSF0ENB;
+		mc_packet_add_write_e(MCI_DSF0_FLT_TYPE, val);
+	} else {
+		val = mc_e_register_get_value(MCI_DSF2_FLT_TYPE);
+		val |= MCB_DSF2ENB;
+		mc_packet_add_write_e(MCI_DSF2_FLT_TYPE, val);
+	}
+
+	mc_hsdet_info_get(&hsdet_info);
+	val = hsdet_info.sgnl_peak << 4 | hsdet_info.sgnl_num << 2 |
+	    hsdet_info.sgnl_period;
+	mc_packet_add_write_e(MCI_IMPSEL, val);
+
+	mc_packet_add_write_if(MCI_IRQR, MCB_EIRQR);
+
+	mc_packet_add_write_cd(MCI_EIRQSENSE, MCB_EIRQSENSE);
+
+	if (id == MCDRV_DEV_ID_80_90H) {
+		*op_dac = mc_ana_register_get_value(19);
+		mc_packet_add_write_ana(19, 0);
+	}
+
+	mc_dev_info_get(&info);
+	if (id == MCDRV_DEV_ID_80_90H)
+		mc_packet_add_write_ana(MCI_HPDETVOL, 0x70);
+	else
+		mc_packet_add_write_ana(MCI_HPDETVOL, info.options[9]);
+
+	if (id == MCDRV_DEV_ID_80_90H) {
+		mc_packet_add_force_write_ana(78, T_CPMODE_IMPSENSE_BEFORE);
+		mc_packet_add_force_write_ana(87, 0x11);
+	} else {
+		mc_packet_add_force_write_if(31, 0xb5);
+		mc_packet_add_force_write_if(30, 0xd6);
+		mc_packet_add_force_write_ana(87, info.options[10]);
+	}
+
+	ret = mc_packet_execute();
+	if (ret < 0)
+		goto exit;
+
+	if (id == MCDRV_DEV_ID_80_90H) {
+		data[0] = MCI_ANA_REG_A << 1;
+		data[1] = 78;
+		mc_write_analog(data, 2);
+		mc_read_analog(MCI_ANA_REG_D, &val, 1);
+		if (val != T_CPMODE_IMPSENSE_BEFORE) {
+			ret = -EIO;
+			goto exit;
+		}
+	}
+
+	val = E1COMMAND_IMP_SENSE;
+	if (info.gnd_det == MCDRV_GNDDET_ON)
+		val |= E1COMMAND_GND_DET;
+	if (mc_a_source_is_used(MCDRV_ASRC_DAC1_L_ON) ||
+	    mc_a_source_is_used(MCDRV_ASRC_DAC1_R_ON) ||
+	    mc_d2_source_is_used(MCDRV_D2SRC_ADC0_L_ON) ||
+	    mc_d2_source_is_used(MCDRV_D2SRC_ADC0_R_ON) ||
+	    mc_d2_source_is_used(MCDRV_D2SRC_ADC1_ON) ||
+	    mc_d2_source_is_used(MCDRV_D2SRC_PDM0_L_ON) ||
+	    mc_d2_source_is_used(MCDRV_D2SRC_PDM0_R_ON) ||
+	    mc_d2_source_is_used(MCDRV_D2SRC_PDM1_L_ON) ||
+	    mc_d2_source_is_used(MCDRV_D2SRC_PDM1_R_ON))
+		val |= E1COMMAND_ADDITIONAL;
+	else if (mc_a_source_is_used(MCDRV_ASRC_DAC0_L_ON) ||
+		 mc_a_source_is_used(MCDRV_ASRC_DAC0_R_ON))
+		val |= E1COMMAND_ADDITIONAL | E1COMMAND_PD;
+
+	if (id == MCDRV_DEV_ID_80_90H)
+		mc_packet_add_wait(MCDRV_DAC_MUTE_WAIT_TIME);
+	else
+		val |= E1COMMAND_WAIT;
+	mc_packet_add_force_write_e(MCI_E1COMMAND, val);
+
+	ret = mc_packet_execute();
+
+exit:
+	return ret;
+}
+#endif
+
+static inline bool is_ldoa_on(void)
+{
+	if (mc_source_is_used(MCDRV_DST_ADC0, MCDRV_DST_CH0))
+		return true;
+
+	if (mc_source_is_used(MCDRV_DST_ADC0, MCDRV_DST_CH1))
+		return true;
+
+	if (mc_source_is_used(MCDRV_DST_ADC1, MCDRV_DST_CH0))
+		return true;
+
+	if (mc_source_is_used(MCDRV_DST_BIAS, MCDRV_DST_CH0))
+		return true;
+
+	if (mc_source_is_used(MCDRV_DST_BIAS, MCDRV_DST_CH1))
+		return true;
+
+	if (mc_source_is_used(MCDRV_DST_BIAS, MCDRV_DST_CH2))
+		return true;
+
+	if (mc_source_is_used(MCDRV_DST_BIAS, MCDRV_DST_CH3))
+		return true;
+
+	if (mc_a_source_is_used(MCDRV_ASRC_DAC0_L_ON))
+		return true;
+
+	if (mc_a_source_is_used(MCDRV_ASRC_DAC0_R_ON))
+		return true;
+
+	if (mc_a_source_is_used(MCDRV_ASRC_DAC1_L_ON))
+		return true;
+
+	if (mc_a_source_is_used(MCDRV_ASRC_DAC1_R_ON))
+		return true;
+
+	return false;
+}
+
+static inline void mask_irregular_path_info(struct mcdrv_path_info *path_info)
+{
+	u8 ch;
+
+	for (ch = 0; ch < MUSICOUT_PATH_CHANNELS; ch++)
+		path_info->music_out[ch] &= ~MCDRV_D1SRC_HIFIIN_ON;
+
+	for (ch = 0; ch < EXTOUT_PATH_CHANNELS; ch++)
+		path_info->ext_out[ch] &= ~MCDRV_D1SRC_HIFIIN_ON;
+
+	for (ch = 0; ch < HIFIOUT_PATH_CHANNELS; ch++)
+		path_info->hifi_out[ch] &=
+		    MCDRV_D1SRC_ADIF0_ON | MCDRV_D1SRC_ADIF0_OFF;
+
+	for (ch = 0; ch < VBOXMIXIN_PATH_CHANNELS; ch++)
+		path_info->vbox_mix_in[ch] &= ~MCDRV_D1SRC_HIFIIN_ON;
+
+	for (ch = 0; ch < AE_PATH_CHANNELS; ch++) {
+		path_info->ae0[ch] &= ~MCDRV_D1SRC_HIFIIN_ON;
+		path_info->ae1[ch] &= ~MCDRV_D1SRC_HIFIIN_ON;
+		path_info->ae2[ch] &= ~MCDRV_D1SRC_HIFIIN_ON;
+		path_info->ae3[ch] &= ~MCDRV_D1SRC_HIFIIN_ON;
+	}
+
+	for (ch = 0; ch < VOICEOUT_PATH_CHANNELS; ch++)
+		path_info->voice_out[ch] &=
+		    MCDRV_D2SRC_VBOXIOOUT_ON | MCDRV_D2SRC_VBOXIOOUT_OFF;
+
+	for (ch = 0; ch < VBOXIOIN_PATH_CHANNELS; ch++)
+		path_info->vbox_io_in[ch] &=
+		    MCDRV_D2SRC_VOICEIN_ON | MCDRV_D2SRC_VOICEIN_OFF;
+
+	for (ch = 0; ch < VBOXHOSTIN_PATH_CHANNELS; ch++)
+		path_info->vbox_host_in[ch] &=
+		    MCDRV_D2SRC_VOICEIN_ON | MCDRV_D2SRC_VOICEIN_OFF;
+
+	for (ch = 0; ch < HOSTOUT_PATH_CHANNELS; ch++)
+		path_info->host_out[ch] &=
+		    MCDRV_D2SRC_VBOXHOSTOUT_ON | MCDRV_D2SRC_VBOXHOSTOUT_OFF;
+
+	for (ch = 0; ch < ADIF0_PATH_CHANNELS; ch++)
+		path_info->adif0[ch] &= MCDRV_D2SRC_ADC0_L_ON
+		    | MCDRV_D2SRC_ADC0_L_OFF
+		    | MCDRV_D2SRC_ADC0_R_ON
+		    | MCDRV_D2SRC_ADC0_R_OFF
+		    | MCDRV_D2SRC_ADC1_ON
+		    | MCDRV_D2SRC_ADC1_OFF
+		    | MCDRV_D2SRC_PDM0_L_ON
+		    | MCDRV_D2SRC_PDM0_L_OFF
+		    | MCDRV_D2SRC_PDM0_R_ON
+		    | MCDRV_D2SRC_PDM0_R_OFF
+		    | MCDRV_D2SRC_PDM1_L_ON
+		    | MCDRV_D2SRC_PDM1_L_OFF
+		    | MCDRV_D2SRC_PDM1_R_ON | MCDRV_D2SRC_PDM1_R_OFF;
+
+	for (ch = 0; ch < ADIF1_PATH_CHANNELS; ch++)
+		path_info->adif1[ch] &= MCDRV_D2SRC_ADC0_L_ON
+		    | MCDRV_D2SRC_ADC0_L_OFF
+		    | MCDRV_D2SRC_ADC0_R_ON
+		    | MCDRV_D2SRC_ADC0_R_OFF
+		    | MCDRV_D2SRC_ADC1_ON
+		    | MCDRV_D2SRC_ADC1_OFF
+		    | MCDRV_D2SRC_PDM0_L_ON
+		    | MCDRV_D2SRC_PDM0_L_OFF
+		    | MCDRV_D2SRC_PDM0_R_ON
+		    | MCDRV_D2SRC_PDM0_R_OFF
+		    | MCDRV_D2SRC_PDM1_L_ON
+		    | MCDRV_D2SRC_PDM1_L_OFF
+		    | MCDRV_D2SRC_PDM1_R_ON | MCDRV_D2SRC_PDM1_R_OFF;
+
+	for (ch = 0; ch < ADIF2_PATH_CHANNELS; ch++)
+		path_info->adif2[ch] &= MCDRV_D2SRC_ADC0_L_ON
+		    | MCDRV_D2SRC_ADC0_L_OFF
+		    | MCDRV_D2SRC_ADC0_R_ON
+		    | MCDRV_D2SRC_ADC0_R_OFF
+		    | MCDRV_D2SRC_ADC1_ON
+		    | MCDRV_D2SRC_ADC1_OFF
+		    | MCDRV_D2SRC_PDM0_L_ON
+		    | MCDRV_D2SRC_PDM0_L_OFF
+		    | MCDRV_D2SRC_PDM0_R_ON
+		    | MCDRV_D2SRC_PDM0_R_OFF
+		    | MCDRV_D2SRC_PDM1_L_ON
+		    | MCDRV_D2SRC_PDM1_L_OFF
+		    | MCDRV_D2SRC_PDM1_R_ON
+		    | MCDRV_D2SRC_PDM1_R_OFF
+		    | MCDRV_D2SRC_DAC0REF_ON
+		    | MCDRV_D2SRC_DAC0REF_OFF
+		    | MCDRV_D2SRC_DAC1REF_ON | MCDRV_D2SRC_DAC1REF_OFF;
+
+	path_info->adc0[0] &= ~(MCDRV_ASRC_DAC0_L_ON | MCDRV_ASRC_DAC0_R_ON |
+				MCDRV_ASRC_DAC1_L_ON | MCDRV_ASRC_DAC1_R_ON |
+				MCDRV_ASRC_LINEIN1_R_ON);
+	path_info->adc0[1] &= ~(MCDRV_ASRC_DAC0_L_ON | MCDRV_ASRC_DAC0_R_ON |
+				MCDRV_ASRC_DAC1_L_ON | MCDRV_ASRC_DAC1_R_ON |
+				MCDRV_ASRC_LINEIN1_L_ON);
+
+	for (ch = 0; ch < ADC1_PATH_CHANNELS; ch++)
+		path_info->adc1[ch] &= ~(MCDRV_ASRC_DAC0_L_ON |
+					 MCDRV_ASRC_DAC0_R_ON |
+					 MCDRV_ASRC_DAC1_L_ON |
+					 MCDRV_ASRC_DAC1_R_ON |
+					 MCDRV_ASRC_LINEIN1_L_ON |
+					 MCDRV_ASRC_LINEIN1_R_ON);
+
+	path_info->sp[0] &= MCDRV_ASRC_DAC1_L_ON | MCDRV_ASRC_DAC1_L_OFF;
+	path_info->sp[1] &= MCDRV_ASRC_DAC1_R_ON | MCDRV_ASRC_DAC1_R_OFF;
+
+	path_info->hp[0] &= MCDRV_ASRC_DAC0_L_ON | MCDRV_ASRC_DAC0_L_OFF;
+	path_info->hp[1] &= MCDRV_ASRC_DAC0_R_ON | MCDRV_ASRC_DAC0_R_OFF;
+
+	path_info->rc[0] &= MCDRV_ASRC_DAC0_L_ON | MCDRV_ASRC_DAC0_L_OFF;
+
+	path_info->lout1[0] &= MCDRV_ASRC_DAC0_L_ON | MCDRV_ASRC_DAC0_L_OFF;
+	path_info->lout1[1] &= MCDRV_ASRC_DAC0_R_ON | MCDRV_ASRC_DAC0_R_OFF;
+
+	path_info->lout2[0] &= MCDRV_ASRC_DAC1_L_ON | MCDRV_ASRC_DAC1_L_OFF;
+	path_info->lout2[1] &= MCDRV_ASRC_DAC1_R_ON | MCDRV_ASRC_DAC1_R_OFF;
+
+	path_info->bias[0] &= MCDRV_ASRC_MIC1_ON | MCDRV_ASRC_MIC1_OFF;
+	path_info->bias[1] &= MCDRV_ASRC_MIC2_ON | MCDRV_ASRC_MIC2_OFF;
+	path_info->bias[2] &= MCDRV_ASRC_MIC3_ON | MCDRV_ASRC_MIC3_OFF;
+	path_info->bias[3] &= MCDRV_ASRC_MIC4_ON | MCDRV_ASRC_MIC4_OFF;
+}
+
+static inline bool is_valid_dio_path_info(struct mcdrv_dio_path_info
+					  *dio_path_info, unsigned int update)
+{
+	struct mcdrv_dio_path_info curr_dio_path_info;
+	u8 val;
+	bool LP0_start = false, LP1_start = false;
+	bool LP2_start = false, LP3_start = false;
+	bool ret = true;
+
+	val = mc_mb_register_get_value(MCI_LP0_START);
+	if (val & (MCB_LPR0_START | MCB_LPT0_START))
+		LP0_start = true;
+
+	val = mc_mb_register_get_value(MCI_LP1_START);
+	if (val & (MCB_LPR1_START | MCB_LPT1_START))
+		LP1_start = true;
+
+	val = mc_mb_register_get_value(MCI_LP2_START);
+	if (val & (MCB_LPR2_START | MCB_LPT2_START))
+		LP2_start = true;
+
+	val = mc_mb_register_get_value(MCI_LP3_START);
+	if (val & (MCB_LPR3_START | MCB_LPT3_START))
+		LP3_start = true;
+
+	mc_dio_path_info_get(&curr_dio_path_info);
+
+	if (update & MCDRV_MUSICNUM_UPDATE_FLAG) {
+		if (dio_path_info->music_ch > MCDRV_MUSIC_LAST) {
+			ret = false;
+			goto exit;
+		} else if (dio_path_info->music_ch !=
+			   curr_dio_path_info.music_ch) {
+			if (LP0_start) {
+				ret = false;
+				goto exit;
+			}
+		}
+	}
+
+	if (update & MCDRV_PHYS0_UPDATE_FLAG) {
+		if (dio_path_info->phys_port[0] > MCDRV_PHYSPORT_LAST) {
+			ret = false;
+			goto exit;
+		} else if (dio_path_info->phys_port[0] !=
+			   curr_dio_path_info.phys_port[0]) {
+			if (LP0_start) {
+				ret = false;
+				goto exit;
+			}
+		}
+	}
+
+	if (update & MCDRV_PHYS1_UPDATE_FLAG) {
+		if (dio_path_info->phys_port[1] > MCDRV_PHYSPORT_LAST) {
+			ret = false;
+			goto exit;
+		} else if (dio_path_info->phys_port[1] !=
+			   curr_dio_path_info.phys_port[1]) {
+			if (LP1_start) {
+				ret = false;
+				goto exit;
+			}
+		}
+	}
+
+	if (update & MCDRV_PHYS2_UPDATE_FLAG) {
+		if (dio_path_info->phys_port[2] > MCDRV_PHYSPORT_LAST) {
+			ret = false;
+			goto exit;
+		} else if (dio_path_info->phys_port[2] !=
+			   curr_dio_path_info.phys_port[2]) {
+			if (LP2_start) {
+				ret = false;
+				goto exit;
+			}
+		}
+	}
+
+	if (update & MCDRV_PHYS3_UPDATE_FLAG) {
+		if (dio_path_info->phys_port[3] > MCDRV_PHYSPORT_LAST) {
+			ret = false;
+			goto exit;
+		} else if (dio_path_info->phys_port[3] !=
+			   curr_dio_path_info.phys_port[3]) {
+			if (LP3_start) {
+				ret = false;
+				goto exit;
+			}
+		}
+	}
+
+	if (update & MCDRV_DIR0SLOT_UPDATE_FLAG) {
+		if (dio_path_info->music_rslot[0] > 3) {
+			ret = false;
+			goto exit;
+		} else if (dio_path_info->music_rslot[0] !=
+			   curr_dio_path_info.music_rslot[0]) {
+			if (LP0_start) {
+				ret = false;
+				goto exit;
+			}
+		}
+	}
+
+	if (update & MCDRV_DIR1SLOT_UPDATE_FLAG) {
+		if (dio_path_info->music_rslot[1] > 3) {
+			ret = false;
+		} else if (dio_path_info->music_rslot[1] !=
+			   curr_dio_path_info.music_rslot[1]) {
+			if (LP0_start) {
+				ret = false;
+				goto exit;
+			}
+		}
+	}
+
+	if (update & MCDRV_DIR2SLOT_UPDATE_FLAG) {
+		if (dio_path_info->music_rslot[2] > 3) {
+			ret = false;
+		} else if (dio_path_info->music_rslot[2] !=
+			   curr_dio_path_info.music_rslot[2]) {
+			if (LP0_start) {
+				ret = false;
+				goto exit;
+			}
+		}
+	}
+
+	if (update & MCDRV_DIT0SLOT_UPDATE_FLAG) {
+		if (dio_path_info->music_tslot[0] > 3) {
+			ret = false;
+		} else if (dio_path_info->music_tslot[0] !=
+			   curr_dio_path_info.music_tslot[0]) {
+			if (LP0_start) {
+				ret = false;
+				goto exit;
+			}
+		}
+	}
+
+	if (update & MCDRV_DIT1SLOT_UPDATE_FLAG) {
+		if (dio_path_info->music_tslot[1] > 3) {
+			ret = false;
+		} else if (dio_path_info->music_tslot[1] !=
+			   curr_dio_path_info.music_tslot[1]) {
+			if (LP0_start) {
+				ret = false;
+				goto exit;
+			}
+		}
+	}
+
+	if (update & MCDRV_DIT2SLOT_UPDATE_FLAG) {
+		if (dio_path_info->music_tslot[2] > 3) {
+			ret = false;
+		} else if (dio_path_info->music_tslot[2] !=
+			   curr_dio_path_info.music_tslot[2]) {
+			if (LP0_start) {
+				ret = false;
+				goto exit;
+			}
+		}
+	}
+
+exit:
+	return ret;
+}
+
+static inline bool is_valid_swap_info(struct mcdrv_swap_info *info,
+				      unsigned int update)
+{
+	bool ret = true;
+
+	if (update & MCDRV_SWAP_ADIF0_UPDATE_FLAG)
+		if (info->adif0 > MCDRV_SWAP_LAST)
+			ret = false;
+
+	if (update & MCDRV_SWAP_ADIF1_UPDATE_FLAG)
+		if (info->adif1 > MCDRV_SWAP_LAST)
+			ret = false;
+
+	if (update & MCDRV_SWAP_ADIF2_UPDATE_FLAG)
+		if (info->adif2 > MCDRV_SWAP_LAST)
+			ret = false;
+
+	if (update & MCDRV_SWAP_DAC0_UPDATE_FLAG)
+		if (info->dac0 > MCDRV_SWAP_LAST)
+			ret = false;
+
+	if (update & MCDRV_SWAP_DAC1_UPDATE_FLAG)
+		if (info->dac1 > MCDRV_SWAP_LAST)
+			ret = false;
+
+	if (update & MCDRV_SWAP_MUSICIN0_UPDATE_FLAG)
+		if (info->music_in0 > MCDRV_SWSWAP_LAST)
+			ret = false;
+
+	if (update & MCDRV_SWAP_MUSICIN1_UPDATE_FLAG)
+		if (info->music_in1 > MCDRV_SWSWAP_LAST)
+			ret = false;
+
+	if (update & MCDRV_SWAP_MUSICIN2_UPDATE_FLAG)
+		if (info->music_in2 > MCDRV_SWSWAP_LAST)
+			ret = false;
+
+	if (update & MCDRV_SWAP_EXTIN_UPDATE_FLAG)
+		if (info->ext_in > MCDRV_SWSWAP_LAST)
+			ret = false;
+
+	if (update & MCDRV_SWAP_VOICEIN_UPDATE_FLAG)
+		if (info->voice_in > MCDRV_SWSWAP_LAST)
+			ret = false;
+
+	if (update & MCDRV_SWAP_HIFIIN_UPDATE_FLAG)
+		if (info->hifi_in > MCDRV_SWSWAP_LAST)
+			ret = false;
+
+	if (update & MCDRV_SWAP_MUSICOUT0_UPDATE_FLAG)
+		if (info->music_out0 > MCDRV_SWAP_LAST)
+			ret = false;
+
+	if (update & MCDRV_SWAP_MUSICOUT1_UPDATE_FLAG)
+		if (info->music_out1 > MCDRV_SWSWAP_LAST)
+			ret = false;
+
+	if (update & MCDRV_SWAP_MUSICOUT2_UPDATE_FLAG)
+		if (info->music_out2 > MCDRV_SWSWAP_LAST)
+			ret = false;
+
+	if (update & MCDRV_SWAP_EXTOUT_UPDATE_FLAG)
+		if (info->ext_out > MCDRV_SWSWAP_LAST)
+			ret = false;
+
+	if (update & MCDRV_SWAP_VOICEOUT_UPDATE_FLAG)
+		if (info->voice_out > MCDRV_SWSWAP_LAST)
+			ret = false;
+
+	if (update & MCDRV_SWAP_HIFIOUT_UPDATE_FLAG)
+		if (info->hifi_out > MCDRV_SWSWAP_LAST)
+			ret = false;
+
+	return ret;
+}
+
+static inline bool is_valid_aec_info(struct mcdrv_aec_info *info)
+{
+	struct mcdrv_aec_info curr_info;
+	bool bdsp_used = false, cdsp_used = false, fdsp_used = false;
+	bool ret = true;
+
+	mc_aec_info_get(&curr_info);
+
+	if (mc_d1_source_is_used(MCDRV_D1SRC_AE0_ON | MCDRV_D1SRC_AE1_ON |
+				 MCDRV_D1SRC_AE2_ON | MCDRV_D1SRC_AE3_ON)) {
+		bdsp_used = true;
+		if (!curr_info.fdsp_locate)
+			fdsp_used = true;
+	}
+
+	if (mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH0) ||
+	    mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH1) ||
+	    mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH2) ||
+	    mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH3) ||
+	    mc_source_is_used(MCDRV_DST_VBOXHOSTIN, MCDRV_DST_CH0)) {
+		cdsp_used = true;
+		if (curr_info.fdsp_locate)
+			fdsp_used = true;
+	}
+
+	if (bdsp_used || cdsp_used || fdsp_used)
+		if (info->fdsp_locate != 0xFF)
+			if (info->fdsp_locate != curr_info.fdsp_locate) {
+				ret = false;
+				goto exit;
+			}
+
+	if (bdsp_used || fdsp_used)
+		if (info->audio_engine.enable) {
+			if (info->audio_engine.bdsp_ae0_src != 2 &&
+			    info->audio_engine.bdsp_ae0_src !=
+			    curr_info.audio_engine.bdsp_ae0_src) {
+				ret = false;
+				goto exit;
+			}
+
+			if (info->audio_engine.bdsp_ae1_src != 2 &&
+			    info->audio_engine.bdsp_ae1_src !=
+			    curr_info.audio_engine.bdsp_ae1_src) {
+				ret = false;
+				goto exit;
+			}
+			if (info->audio_engine.mixer_in0_src != 2 &&
+			    info->audio_engine.mixer_in0_src !=
+			    curr_info.audio_engine.mixer_in0_src) {
+				ret = false;
+				goto exit;
+			}
+
+			if (info->audio_engine.mixer_in1_src != 2 &&
+			    info->audio_engine.mixer_in1_src !=
+			    curr_info.audio_engine.mixer_in1_src) {
+				ret = false;
+				goto exit;
+			}
+			if (info->audio_engine.mixer_in2_src != 2 &&
+			    info->audio_engine.mixer_in2_src !=
+			    curr_info.audio_engine.mixer_in2_src) {
+				ret = false;
+				goto exit;
+			}
+
+			if (info->audio_engine.mixer_in3_src != 2 &&
+			    info->audio_engine.mixer_in3_src !=
+			    curr_info.audio_engine.mixer_in3_src) {
+				ret = false;
+				goto exit;
+			}
+		}
+
+	if (cdsp_used || fdsp_used)
+		if (info->vbox.enable) {
+			if (info->vbox.fdsp_po_source != 0xFF &&
+			    info->vbox.fdsp_po_source !=
+			    curr_info.vbox.fdsp_po_source) {
+				ret = false;
+				goto exit;
+			}
+
+			if (info->vbox.isrc2_vsource != 0xFF &&
+			    info->vbox.isrc2_vsource !=
+			    curr_info.vbox.isrc2_vsource) {
+				ret = false;
+				goto exit;
+			}
+
+			if (info->vbox.isrc2_ch1_vsource != 0xFF &&
+			    info->vbox.isrc2_ch1_vsource !=
+			    curr_info.vbox.isrc2_ch1_vsource) {
+				ret = false;
+				goto exit;
+			}
+
+			if (info->vbox.isrc3_vsource != 0xFF &&
+			    info->vbox.isrc3_vsource !=
+			    curr_info.vbox.isrc3_vsource) {
+				ret = false;
+				goto exit;
+			}
+
+			if (info->vbox.lpt2_vsource != 0xFF &&
+			    info->vbox.lpt2_vsource !=
+			    curr_info.vbox.lpt2_vsource) {
+				ret = false;
+				goto exit;
+			}
+		}
+
+	if (cdsp_used)
+		if (info->vbox.enable) {
+			if (info->vbox.src3_ctrl != 0xFF &&
+			    info->vbox.src3_ctrl != curr_info.vbox.src3_ctrl) {
+				ret = false;
+				goto exit;
+			}
+
+			if (info->vbox.src2_fs != 0xFF &&
+			    info->vbox.src2_fs != curr_info.vbox.src2_fs) {
+				ret = false;
+				goto exit;
+			}
+
+			if (info->vbox.src2_thru != 0xFF &&
+			    info->vbox.src2_thru != curr_info.vbox.src2_thru) {
+				ret = false;
+				goto exit;
+			}
+
+			if (info->vbox.src3_fs != 0xFF &&
+			    info->vbox.src3_fs != curr_info.vbox.src3_fs) {
+				ret = false;
+				goto exit;
+			}
+
+			if (info->vbox.src3_thru != 0xFF &&
+			    info->vbox.src3_thru != curr_info.vbox.src3_thru) {
+				ret = false;
+				goto exit;
+			}
+		}
+
+exit:
+	return ret;
+}
+
+static bool is_valid_hsdet_info(struct mcdrv_hsdet_info *info,
+				unsigned int update)
+{
+	struct mcdrv_hsdet_info hsdet_info;
+
+	mc_hsdet_info_get(&hsdet_info);
+
+	if (update & MCDRV_ENPLUGDET_UPDATE_FLAG)
+		if (info->en_plug_det_db > MCDRV_PLUGDETDB_LAST)
+			return false;
+
+	if (update & MCDRV_ENDLYKEYOFF_UPDATE_FLAG)
+		if (info->en_dly_key_off > MCDRV_KEYEN_LAST)
+			return false;
+
+	if (update & MCDRV_ENDLYKEYON_UPDATE_FLAG)
+		if (info->en_dly_key_on > MCDRV_KEYEN_LAST)
+			return false;
+
+	if (update & MCDRV_ENKEYOFF_UPDATE_FLAG)
+		if (info->en_key_off > MCDRV_KEYEN_LAST)
+			return false;
+
+	if (update & MCDRV_ENKEYON_UPDATE_FLAG)
+		if (info->en_key_on > MCDRV_KEYEN_LAST)
+			return false;
+
+	if (update & MCDRV_HSDETDBNC_UPDATE_FLAG)
+		if (info->hs_det_dbnc > MCDRV_DETDBNC_LAST)
+			return false;
+
+	if (update & MCDRV_KEYOFFMTIM_UPDATE_FLAG)
+		hsdet_info.key_off_mtim = info->key_off_mtim;
+
+	if (update & MCDRV_KEYONMTIM_UPDATE_FLAG)
+		hsdet_info.key_on_mtim = info->key_on_mtim;
+
+	if (update & MCDRV_KEY0OFFDLYTIM_UPDATE_FLAG) {
+		if (info->key0_off_dly_tim > MC_DRV_KEYOFFDLYTIM_MAX)
+			return false;
+		else if (hsdet_info.key_off_mtim == MCDRV_KEYOFF_MTIM_63 &&
+			 info->key0_off_dly_tim == 1)
+			return false;
+	}
+
+	if (update & MCDRV_KEY1OFFDLYTIM_UPDATE_FLAG) {
+		if (info->key1_off_dly_tim > MC_DRV_KEYOFFDLYTIM_MAX)
+			return false;
+		else if (hsdet_info.key_off_mtim == MCDRV_KEYOFF_MTIM_63 &&
+			 info->key1_off_dly_tim == 1)
+			return false;
+	}
+
+	if (update & MCDRV_KEY2OFFDLYTIM_UPDATE_FLAG) {
+		if (info->key2_off_dly_tim > MC_DRV_KEYOFFDLYTIM_MAX)
+			return false;
+		else if (hsdet_info.key_off_mtim == MCDRV_KEYOFF_MTIM_63 &&
+			 info->key2_off_dly_tim == 1)
+			return false;
+	}
+
+	if (update & MCDRV_KEY0ONDLYTIM_UPDATE_FLAG) {
+		if (info->key0_on_dly_tim > MC_DRV_KEYONDLYTIM_MAX)
+			return false;
+		else if (hsdet_info.key_on_mtim == MCDRV_KEYON_MTIM_250 &&
+			 (info->key0_on_dly_tim == 1 ||
+			  info->key0_on_dly_tim == 2 ||
+			  info->key0_on_dly_tim == 3))
+			return false;
+	}
+
+	if (update & MCDRV_KEY1ONDLYTIM_UPDATE_FLAG) {
+		if (info->key1_on_dly_tim > MC_DRV_KEYONDLYTIM_MAX)
+			return false;
+		else if (hsdet_info.key_on_mtim == MCDRV_KEYON_MTIM_250 &&
+			 (info->key1_on_dly_tim == 1 ||
+			  info->key1_on_dly_tim == 2 ||
+			  info->key1_on_dly_tim == 3))
+			return false;
+	}
+
+	if (update & MCDRV_KEY2ONDLYTIM_UPDATE_FLAG) {
+		if (info->key2_on_dly_tim > MC_DRV_KEYONDLYTIM_MAX)
+			return false;
+		else if (hsdet_info.key_on_mtim == MCDRV_KEYON_MTIM_250 &&
+			 (info->key2_on_dly_tim == 1 ||
+			  info->key2_on_dly_tim == 2 ||
+			  info->key2_on_dly_tim == 3))
+			return false;
+	}
+
+	if (update & MCDRV_KEY0ONDLYTIM2_UPDATE_FLAG) {
+		if (info->key0_on_dly_tim2 > MC_DRV_KEYONDLYTIM2_MAX)
+			return false;
+		else if (hsdet_info.key_on_mtim == MCDRV_KEYON_MTIM_250 &&
+			 (info->key0_on_dly_tim2 == 1 ||
+			  info->key0_on_dly_tim2 == 2 ||
+			  info->key0_on_dly_tim2 == 3))
+			return false;
+	}
+
+	if (update & MCDRV_KEY1ONDLYTIM2_UPDATE_FLAG) {
+		if (info->key1_on_dly_tim2 > MC_DRV_KEYONDLYTIM2_MAX)
+			return false;
+		else if (hsdet_info.key_on_mtim == MCDRV_KEYON_MTIM_250 &&
+			 (info->key1_on_dly_tim2 == 1 ||
+			  info->key1_on_dly_tim2 == 2 ||
+			  info->key1_on_dly_tim2 == 3))
+			return false;
+	}
+
+	if (update & MCDRV_KEY2ONDLYTIM2_UPDATE_FLAG) {
+		if (info->key2_on_dly_tim2 > MC_DRV_KEYONDLYTIM2_MAX)
+			return false;
+		else if (hsdet_info.key_on_mtim == MCDRV_KEYON_MTIM_250 &&
+			 (info->key2_on_dly_tim2 == 1 ||
+			  info->key2_on_dly_tim2 == 2 ||
+			  info->key2_on_dly_tim2 == 3))
+			return false;
+	}
+
+	if (update & MCDRV_IRQTYPE_UPDATE_FLAG) {
+		if (info->irq_type == MCDRV_IRQTYPE_EX) {
+			if (info->plug_det_db_irq_type > MCDRV_IRQTYPE_REF)
+				return false;
+			if (info->plug_undet_db_irq_type > MCDRV_IRQTYPE_REF)
+				return false;
+			if (info->mic_det_irq_type > MCDRV_IRQTYPE_REF)
+				return false;
+			if (info->plug_det_irq_type > MCDRV_IRQTYPE_REF)
+				return false;
+			if (info->key0_on_irq_type > MCDRV_IRQTYPE_REF)
+				return false;
+			if (info->key1_on_irq_type > MCDRV_IRQTYPE_REF)
+				return false;
+			if (info->key2_on_irq_type > MCDRV_IRQTYPE_REF)
+				return false;
+			if (info->key0_off_irq_type > MCDRV_IRQTYPE_REF)
+				return false;
+			if (info->key1_off_irq_type > MCDRV_IRQTYPE_REF)
+				return false;
+			if (info->key2_off_irq_type > MCDRV_IRQTYPE_REF)
+				return false;
+		} else if (info->irq_type > MCDRV_IRQTYPE_LAST)
+			return false;
+	}
+
+	if (update & MCDRV_DETINV_UPDATE_FLAG)
+		if (info->det_in_inv > MCDRV_DET_IN_LAST)
+			return false;
+
+	if (update & MCDRV_HSDETMODE_UPDATE_FLAG)
+		if (info->hs_det_mode != MCDRV_HSDET_MODE_DETIN_A &&
+		    info->hs_det_mode != MCDRV_HSDET_MODE_DETIN_B)
+			return false;
+
+	if (update & MCDRV_SPERIOD_UPDATE_FLAG)
+		if (info->speriod > MCDRV_SPERIOD_LAST)
+			return false;
+
+	if (update & MCDRV_LPERIOD_UPDATE_FLAG)
+		if (info->lperiod > MCDRV_LPERIOD_LAST)
+			return false;
+
+	if (update & MCDRV_DBNCNUMPLUG_UPDATE_FLAG)
+		if (info->dbnc_num_plug > MCDRV_DBNC_NUM_LAST)
+			return false;
+
+	if (update & MCDRV_DBNCNUMMIC_UPDATE_FLAG)
+		if (info->dbnc_num_mic > MCDRV_DBNC_NUM_LAST)
+			return false;
+
+	if (update & MCDRV_DBNCNUMKEY_UPDATE_FLAG)
+		if (info->dbnc_num_key > MCDRV_DBNC_NUM_LAST)
+			return false;
+
+	if (update & MCDRV_SGNL_UPDATE_FLAG) {
+		if (info->sgnl_period > MCDRV_SGNLPERIOD_LAST)
+			return false;
+
+		if (info->sgnl_num != MCDRV_SGNLNUM_NONE
+		    && info->sgnl_num > MCDRV_SGNLNUM_LAST)
+			return false;
+
+		if (info->sgnl_peak > MCDRV_SGNLPEAK_LAST)
+			return false;
+	}
+
+	return true;
+}
+
+static bool check_dio_common(struct mcdrv_dio_info *dio_info, u8 port)
+{
+	struct mcdrv_dio_common *dio_common;
+	bool ret = true;
+
+	dio_common = &dio_info->port[port].dio_common;
+
+	if (port == 3) {
+		if (dio_common->fs != MCDRV_FS_48000 &&
+		    dio_common->fs != MCDRV_FS_192000 &&
+		    dio_common->fs != MCDRV_FS_96000) {
+			ret = false;
+			goto exit;
+		}
+
+		if (dio_common->bck_fs != MCDRV_BCKFS_64 &&
+		    dio_common->bck_fs != MCDRV_BCKFS_48 &&
+		    dio_common->bck_fs != MCDRV_BCKFS_32)
+			ret = false;
+		goto exit;
+	}
+
+	if (dio_common->fs > MCDRV_FS_LAST ||
+	    dio_common->fs == MCDRV_FS_NONE1 ||
+	    dio_common->fs == MCDRV_FS_NONE2 ||
+	    dio_common->fs == MCDRV_FS_NONE3)
+		ret = false;
+	else if (dio_common->bck_fs > MCDRV_BCKFS_LAST ||
+		 dio_common->bck_fs == MCDRV_BCKFS_NONE1 ||
+		 dio_common->bck_fs == MCDRV_BCKFS_NONE2 ||
+		 dio_common->bck_fs == MCDRV_BCKFS_NONE3 ||
+		 dio_common->bck_fs == MCDRV_BCKFS_NONE4)
+		ret = false;
+	else if (dio_common->interface == MCDRV_DIO_PCM &&
+		 dio_common->pcm_high_period > 31)
+		ret = false;
+
+	if (dio_common->interface == MCDRV_DIO_PCM) {
+		if (dio_common->fs != MCDRV_FS_8000 &&
+		    dio_common->fs != MCDRV_FS_16000)
+			ret = false;
+
+		if (dio_common->bck_fs == MCDRV_BCKFS_512 &&
+		    dio_common->fs != MCDRV_FS_8000)
+			ret = false;
+
+		if (dio_common->bck_fs == MCDRV_BCKFS_256 &&
+		    (dio_common->fs != MCDRV_FS_8000 &&
+		     dio_common->fs != MCDRV_FS_16000))
+			ret = false;
+
+		if (dio_common->master_slave == MCDRV_DIO_MASTER &&
+		    dio_common->bck_fs == MCDRV_BCKFS_SLAVE)
+			ret = false;
+	} else {
+		if (port == 0 || port == 1) {
+			if (dio_common->fs == MCDRV_FS_192000 ||
+			    dio_common->fs == MCDRV_FS_96000)
+				ret = false;
+		}
+
+		if (dio_common->bck_fs != MCDRV_BCKFS_64 &&
+		    dio_common->bck_fs != MCDRV_BCKFS_48 &&
+		    dio_common->bck_fs != MCDRV_BCKFS_32)
+			ret = false;
+	}
+
+exit:
+	return ret;
+}
+
+static bool check_da_format(struct mcdrv_da_format *da_format)
+{
+	bool ret = true;
+
+	if (da_format->bit_sel > MCDRV_BITSEL_LAST)
+		ret = false;
+	else if (da_format->mode > MCDRV_DAMODE_LAST)
+		ret = false;
+
+	return ret;
+}
+
+static bool check_pcm_format(struct mcdrv_pcm_format *pcm_format)
+{
+	bool ret = true;
+
+	if (pcm_format->law > MCDRV_PCM_LAST)
+		ret = false;
+	else if (pcm_format->bit_sel > MCDRV_PCM_BITSEL_LAST)
+		ret = false;
+	else if ((pcm_format->law == MCDRV_PCM_ALAW ||
+		  pcm_format->law == MCDRV_PCM_MULAW) &&
+		 pcm_format->bit_sel != MCDRV_PCM_BITSEL_8)
+		ret = false;
+
+	return ret;
+}
+
+static bool check_dio_dir(struct mcdrv_dio_info *dio_info,
+			  u8 port, u8 interface)
+{
+	bool ret = true;
+
+	if (interface == MCDRV_DIO_PCM)
+		ret = check_pcm_format(&dio_info->port[port].dir.pcm_format);
+	else {
+		ret = check_da_format(&dio_info->port[port].dir.da_format);
+		if (dio_info->port[port].dir.da_format.bit_sel ==
+		    MCDRV_BITSEL_32)
+			ret = false;
+	}
+
+	return ret;
+}
+
+static bool check_dio_dit(struct mcdrv_dio_info *dio_info,
+			  u8 port, u8 interface)
+{
+	bool ret = true;
+
+	if (interface == MCDRV_DIO_PCM)
+		ret = check_pcm_format(&dio_info->port[port].dit.pcm_format);
+	else {
+		ret = check_da_format(&dio_info->port[port].dit.da_format);
+		if (dio_info->port[port].dit.da_format.bit_sel ==
+		    MCDRV_BITSEL_32 && port != 2)
+			ret = false;
+	}
+
+	return ret;
+}
+
+static inline bool is_valid_dio_info(struct mcdrv_dio_info *dio_info,
+				     unsigned int update)
+{
+	struct mcdrv_dio_info curr_dio_info;
+	u8 val;
+	bool LPR0_start = 0, LPT0_start = 0;
+	bool LPR1_start = 0, LPT1_start = 0;
+	bool LPR2_start = 0, LPT2_start = 0;
+	bool LPR3_start = 0, LPT3_start = 0;
+	bool ret = true;
+
+	mc_dio_info_get(&curr_dio_info);
+
+	val = mc_mb_register_get_value(MCI_LP0_START);
+	if (val & MCB_LPR0_START)
+		LPR0_start = true;
+	if (val & MCB_LPT0_START)
+		LPT0_start = true;
+
+	val = mc_mb_register_get_value(MCI_LP1_START);
+	if (val & MCB_LPR1_START)
+		LPR1_start = true;
+	if (val & MCB_LPT1_START)
+		LPT1_start = true;
+
+	val = mc_mb_register_get_value(MCI_LP2_START);
+	if (val & MCB_LPR2_START)
+		LPR2_start = true;
+	if (val & MCB_LPT2_START)
+		LPT2_start = true;
+
+	val = mc_mb_register_get_value(MCI_LP3_START);
+	if (val & MCB_LPR3_START)
+		LPR3_start = true;
+	if (val & MCB_LPT3_START)
+		LPT3_start = true;
+
+	if ((update & MCDRV_MUSIC_COM_UPDATE_FLAG) ||
+	    (update & MCDRV_MUSIC_DIR_UPDATE_FLAG)) {
+		if (LPR0_start)
+			ret = false;
+	}
+
+	if ((update & MCDRV_MUSIC_COM_UPDATE_FLAG) ||
+	    (update & MCDRV_MUSIC_DIT_UPDATE_FLAG)) {
+		if (LPT0_start)
+			ret = false;
+	}
+
+	if ((update & MCDRV_EXT_COM_UPDATE_FLAG) ||
+	    (update & MCDRV_EXT_DIR_UPDATE_FLAG)) {
+		if (LPR1_start)
+			ret = false;
+	}
+
+	if ((update & MCDRV_EXT_COM_UPDATE_FLAG) ||
+	    (update & MCDRV_EXT_DIT_UPDATE_FLAG)) {
+		if (LPT1_start)
+			ret = false;
+	}
+
+	if ((update & MCDRV_VOICE_COM_UPDATE_FLAG) ||
+	    (update & MCDRV_VOICE_DIR_UPDATE_FLAG)) {
+		if (LPR2_start)
+			ret = false;
+	}
+
+	if ((update & MCDRV_VOICE_COM_UPDATE_FLAG) ||
+	    (update & MCDRV_VOICE_DIT_UPDATE_FLAG)) {
+		if (LPT2_start)
+			ret = false;
+	}
+
+	if ((update & MCDRV_HIFI_COM_UPDATE_FLAG) ||
+	    (update & MCDRV_HIFI_DIR_UPDATE_FLAG)) {
+		if (LPR3_start)
+			ret = false;
+	}
+
+	if ((update & MCDRV_HIFI_COM_UPDATE_FLAG) ||
+	    (update & MCDRV_HIFI_DIT_UPDATE_FLAG)) {
+		if (LPT3_start)
+			ret = false;
+	}
+
+	if (ret && (update & MCDRV_MUSIC_COM_UPDATE_FLAG)) {
+		ret = check_dio_common(dio_info, 0);
+		if (ret)
+			curr_dio_info.port[0].dio_common.interface
+			    = dio_info->port[0].dio_common.interface;
+	}
+
+	if (ret && (update & MCDRV_EXT_COM_UPDATE_FLAG)) {
+		ret = check_dio_common(dio_info, 1);
+		if (ret)
+			curr_dio_info.port[1].dio_common.interface
+			    = dio_info->port[1].dio_common.interface;
+	}
+
+	if (ret && (update & MCDRV_VOICE_COM_UPDATE_FLAG)) {
+		ret = check_dio_common(dio_info, 2);
+		if (ret)
+			curr_dio_info.port[2].dio_common.interface
+			    = dio_info->port[2].dio_common.interface;
+	}
+
+	if (ret && (update & MCDRV_HIFI_COM_UPDATE_FLAG)) {
+		ret = check_dio_common(dio_info, 3);
+		if (ret)
+			curr_dio_info.port[3].dio_common.interface
+			    = dio_info->port[3].dio_common.interface;
+	}
+
+	if (ret && (update & MCDRV_MUSIC_DIR_UPDATE_FLAG)) {
+		ret = check_dio_dir(dio_info, 0,
+				    curr_dio_info.port[0].dio_common.interface);
+	}
+
+	if (ret && (update & MCDRV_EXT_DIR_UPDATE_FLAG)) {
+		ret = check_dio_dir(dio_info, 1,
+				    curr_dio_info.port[1].dio_common.interface);
+	}
+
+	if (ret && (update & MCDRV_VOICE_DIR_UPDATE_FLAG)) {
+		ret = check_dio_dir(dio_info, 2,
+				    curr_dio_info.port[2].dio_common.interface);
+	}
+
+	if (ret && (update & MCDRV_MUSIC_DIT_UPDATE_FLAG)) {
+		ret = check_dio_dit(dio_info, 0,
+				    curr_dio_info.port[0].dio_common.interface);
+	}
+
+	if (ret && (update & MCDRV_EXT_DIT_UPDATE_FLAG))
+		ret = check_dio_dit(dio_info, 1,
+				    curr_dio_info.port[1].dio_common.interface);
+
+	if (ret && (update & MCDRV_VOICE_DIT_UPDATE_FLAG))
+		ret = check_dio_dit(dio_info, 2,
+				    curr_dio_info.port[2].dio_common.interface);
+
+	return ret;
+}
+
+static inline int set_vol(u32 update, enum mcdrv_volume_mode mode, u32 *status)
+{
+	mc_packet_add_volume(update, mode, status);
+
+	return mc_packet_execute();
+}
+
+static inline void get_mute(u8 *dir_mute, u8 *adc_mute,
+			    u8 *dit_mute, u8 *dac_mute)
+{
+	u8 vol;
+
+	*dir_mute = 0;
+	*adc_mute = 0;
+	*dit_mute = 0;
+	*dac_mute = 0;
+
+	if (!mc_d1_source_is_used(MCDRV_D1SRC_MUSICIN_ON)) {
+		vol = mc_ma_register_get_value(MCI_DIFI0_VOL0);
+		if (vol & ~MCB_DIFI0_VSEP)
+			*dir_mute |= MCB_DIFI0_VFLAG0;
+
+		vol = mc_ma_register_get_value(MCI_DIFI0_VOL1);
+		if (vol)
+			*dir_mute |= MCB_DIFI0_VFLAG1;
+	}
+
+	if (!mc_d1_source_is_used(MCDRV_D1SRC_EXTIN_ON)) {
+		vol = mc_ma_register_get_value(MCI_DIFI1_VOL0);
+		if (vol & ~MCB_DIFI1_VSEP)
+			*dir_mute |= MCB_DIFI1_VFLAG0;
+
+		vol = mc_ma_register_get_value(MCI_DIFI1_VOL1);
+		if (vol)
+			*dir_mute |= MCB_DIFI1_VFLAG1;
+	}
+
+	if (!mc_d1_source_is_used(MCDRV_D1SRC_VBOXOUT_ON)) {
+		vol = mc_ma_register_get_value(MCI_DIFI2_VOL0);
+		if (vol & ~MCB_DIFI2_VSEP)
+			*dir_mute |= MCB_DIFI2_VFLAG0;
+
+		vol = mc_ma_register_get_value(MCI_DIFI2_VOL1);
+		if (vol)
+			*dir_mute |= MCB_DIFI2_VFLAG1;
+	}
+
+	if (!mc_d1_source_is_used(MCDRV_D1SRC_VBOXREFOUT_ON)) {
+		vol = mc_ma_register_get_value(MCI_DIFI3_VOL0);
+		if (vol & ~MCB_DIFI3_VSEP)
+			*dir_mute |= MCB_DIFI3_VFLAG0;
+
+		vol = mc_ma_register_get_value(MCI_DIFI3_VOL1);
+		if (vol)
+			*dir_mute |= MCB_DIFI3_VFLAG1;
+	}
+
+	if (!mc_source_is_used(MCDRV_DST_DAC0, MCDRV_DST_CH0)) {
+		vol = mc_ma_register_get_value(MCI_DAO0_VOL0);
+		if (vol & ~MCB_DAO0_VSEP)
+			*dac_mute |= MCB_DAO0_VFLAG0;
+	}
+
+	if (!mc_source_is_used(MCDRV_DST_DAC0, MCDRV_DST_CH1)) {
+		vol = mc_ma_register_get_value(MCI_DAO0_VOL1);
+		if (vol)
+			*dac_mute |= MCB_DAO0_VFLAG1;
+	}
+
+	if (!mc_source_is_used(MCDRV_DST_DAC1, MCDRV_DST_CH0)) {
+		vol = mc_ma_register_get_value(MCI_DAO1_VOL0);
+		if (vol & ~MCB_DAO1_VSEP)
+			*dac_mute |= MCB_DAO1_VFLAG0;
+	}
+
+	if (!mc_source_is_used(MCDRV_DST_DAC1, MCDRV_DST_CH1)) {
+		vol = mc_ma_register_get_value(MCI_DAO1_VOL1);
+		if (vol)
+			*dac_mute |= MCB_DAO1_VFLAG1;
+	}
+
+	if (!mc_source_is_used(MCDRV_DST_MUSICOUT, MCDRV_DST_CH0)) {
+		vol = mc_ma_register_get_value(MCI_DIFO0_VOL0);
+		if (vol & ~MCB_DIFO0_VSEP)
+			*dit_mute |= MCB_DIFO0_VFLAG0;
+	}
+
+	if (!mc_source_is_used(MCDRV_DST_MUSICOUT, MCDRV_DST_CH1)) {
+		vol = mc_ma_register_get_value(MCI_DIFO0_VOL1);
+		if (vol)
+			*dit_mute |= MCB_DIFO0_VFLAG1;
+
+	}
+
+	if (!mc_source_is_used(MCDRV_DST_EXTOUT, MCDRV_DST_CH0)) {
+		vol = mc_ma_register_get_value(MCI_DIFO1_VOL0);
+		if (vol & ~MCB_DIFO1_VSEP)
+			*dit_mute |= MCB_DIFO1_VFLAG0;
+	}
+
+	if (!mc_source_is_used(MCDRV_DST_EXTOUT, MCDRV_DST_CH1)) {
+		vol = mc_ma_register_get_value(MCI_DIFO1_VOL1);
+		if (vol)
+			*dit_mute |= MCB_DIFO1_VFLAG1;
+	}
+
+	if (!mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH0)) {
+		vol = mc_ma_register_get_value(MCI_DIFO2_VOL0);
+		if (vol & ~MCB_DIFO2_VSEP)
+			*dit_mute |= MCB_DIFO2_VFLAG0;
+	}
+
+	if (!mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH1)) {
+		vol = mc_ma_register_get_value(MCI_DIFO2_VOL1);
+		if (vol)
+			*dit_mute |= MCB_DIFO2_VFLAG1;
+	}
+
+	if (!mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH2)) {
+		vol = mc_ma_register_get_value(MCI_DIFO3_VOL0);
+		if (vol & ~MCB_DIFO2_VSEP)
+			*dit_mute |= MCB_DIFO3_VFLAG0;
+	}
+
+	if (!mc_source_is_used(MCDRV_DST_VBOXMIXIN, MCDRV_DST_CH3)) {
+		vol = mc_ma_register_get_value(MCI_DIFO3_VOL1);
+		if (vol)
+			*dit_mute |= MCB_DIFO3_VFLAG1;
+	}
+
+	if (!mc_d1_source_is_used(MCDRV_D1SRC_ADIF0_ON)) {
+		vol = mc_ma_register_get_value(MCI_ADI0_VOL0);
+		if (vol & ~MCB_ADI0_VSEP)
+			*adc_mute |= MCB_ADI0_VFLAG0;
+		vol = mc_ma_register_get_value(MCI_ADI0_VOL1);
+		if (vol)
+			*adc_mute |= MCB_ADI0_VFLAG1;
+	}
+
+	if (!mc_d1_source_is_used(MCDRV_D1SRC_ADIF1_ON)) {
+		vol = mc_ma_register_get_value(MCI_ADI1_VOL1);
+		if (vol & ~MCB_ADI1_VSEP)
+			*adc_mute |= MCB_ADI1_VFLAG0;
+		vol = mc_ma_register_get_value(MCI_ADI1_VOL1);
+		if (vol)
+			*adc_mute |= MCB_ADI1_VFLAG1;
+	}
+
+	if (!mc_d1_source_is_used(MCDRV_D1SRC_ADIF2_ON)) {
+		vol = mc_ma_register_get_value(MCI_ADI2_VOL1);
+		if (vol & ~MCB_ADI2_VSEP)
+			*adc_mute |= MCB_ADI2_VFLAG0;
+
+		vol = mc_ma_register_get_value(MCI_ADI2_VOL1);
+		if (vol)
+			*adc_mute |= MCB_ADI2_VFLAG1;
+	}
+}
+
+static int save_power(void)
+{
+	struct mcdrv_power_info power;
+	struct mcdrv_power_update update;
+	int ret;
+
+	/*      unused path power down  */
+	mc_power_info_get(&power);
+
+	update.digital = MCDRV_POWUPDATE_D_ALL;
+	update.analog[0] = MCDRV_POWUPDATE_AP;
+	update.analog[1] = MCDRV_POWUPDATE_AP_OUT0;
+	update.analog[2] = MCDRV_POWUPDATE_AP_OUT1;
+	update.analog[3] = MCDRV_POWUPDATE_AP_MC;
+	update.analog[4] = MCDRV_POWUPDATE_AP_IN;
+
+	ret = mc_packet_add_powerdown(&power, &update);
+	if (!ret)
+		ret = mc_packet_execute();
+
+	return ret;
+}
+
+static inline bool is_valid_clock(u8 clock)
+{
+	if (clock != MCDRV_CLKSW_CLKA && clock != MCDRV_CLKSW_CLKB)
+		return false;
+
+	return true;
+}
+
+static inline int get_clock(u8 *clock)
+{
+
+	mc_clock_get(clock);
+
+	return 0;
+}
+
+static inline int set_clock(u8 *clock)
+{
+	u8 old_clock;
+
+	if (!is_valid_clock(*clock))
+		return -EINVAL;
+
+	mc_clock_get(&old_clock);
+	if (*clock == old_clock)
+		return 0;
+
+	return mc_clock_set(*clock);
+}
+
+static inline int get_path(struct mcdrv_path_info *path_info)
+{
+	if (!path_info)
+		return -EINVAL;
+
+	mc_path_info_get_virtual(path_info);
+
+	return 0;
+}
+
+static int set_path(struct mcdrv_path_info *path_info)
+{
+	struct mcdrv_power_info power;
+	struct mcdrv_power_update update;
+	u32 status;
+	u8 val, dir_mute, adc_mute, dit_mute, dac_mute, hp_vol_l, hp_vol_r;
+	u8 dsp_started = mc_dsp_get_running();
+	int ret;
+
+	if (!path_info)
+		return -EINVAL;
+
+	mask_irregular_path_info(path_info);
+
+	ret = mc_path_info_set(path_info);
+	if (ret < 0)
+		return ret;
+
+	hp_vol_l = mc_ana_register_get_value(MCI_HPVOL_L);
+	hp_vol_l &= ~MCB_ALAT_HP;
+	hp_vol_r = mc_ana_register_get_value(MCI_HPVOL_R);
+
+	/* unused analog out volume mute */
+	ret = set_vol(MCDRV_VOLUPDATE_ANA_OUT, MCDRV_VOLUME_MUTE, &status);
+	if (ret < 0)
+		return ret;
+
+	if (status)
+		mc_packet_add_wait_event(MCDRV_EVT_SVOL_DONE | status);
+
+	get_mute(&dir_mute, &adc_mute, &dit_mute, &dac_mute);
+
+	/* unused volume mute */
+	ret = set_vol(MCDRV_VOLUPDATE_DIG, MCDRV_VOLUME_MUTE, NULL);
+	if (ret < 0)
+		return ret;
+
+	/* set volume */
+	ret = set_vol(MCDRV_VOLUPDATE_ANA_IN, MCDRV_VOLUME_SET, NULL);
+	if (ret < 0)
+		return ret;
+
+	if (dir_mute)
+		mc_packet_add_wait_event(MCDRV_EVT_DIRMUTE | dir_mute);
+
+	if (adc_mute)
+		mc_packet_add_wait_event(MCDRV_EVT_ADCMUTE | adc_mute);
+
+	if (dit_mute)
+		mc_packet_add_wait_event(MCDRV_EVT_DITMUTE | dit_mute);
+
+	if (dac_mute)
+		mc_packet_add_wait_event(MCDRV_EVT_DACMUTE | dac_mute);
+
+	mc_packet_add_fdsp_stop(dsp_started);
+	ret = mc_packet_execute();
+	if (ret < 0)
+		return ret;
+
+	/* stop unused path */
+	mc_packet_add_stop();
+	ret = mc_packet_execute();
+	if (ret < 0)
+		return ret;
+
+	mc_power_info_get(&power);
+
+	/* unused analog out path power down */
+	update.digital = 0;
+	update.analog[0] = 0;
+	update.analog[1] = MCDRV_POWUPDATE_AP_OUT0;
+	update.analog[2] = MCDRV_POWUPDATE_AP_OUT1;
+	update.analog[3] = 0;
+	update.analog[4] = 0;
+	ret = mc_packet_add_powerdown(&power, &update);
+	if (ret < 0)
+		return ret;
+
+	ret = mc_packet_execute();
+	if (ret < 0)
+		return ret;
+
+	/* used path power up */
+	update.digital = MCDRV_POWUPDATE_D_ALL;
+	update.analog[0] = MCDRV_POWUPDATE_AP;
+	update.analog[1] = MCDRV_POWUPDATE_AP_OUT0;
+	update.analog[2] = MCDRV_POWUPDATE_AP_OUT1;
+	update.analog[3] = MCDRV_POWUPDATE_AP_MC;
+	update.analog[4] = MCDRV_POWUPDATE_AP_IN;
+	ret = mc_packet_add_powerup(&power, &update);
+	if (ret < 0)
+		return ret;
+
+	ret = mc_packet_execute();
+	if (ret < 0)
+		return ret;
+
+	/* set mixer */
+	mc_packet_add_path_set();
+	ret = mc_packet_execute();
+	if (ret < 0)
+		return ret;
+
+	/* DSP start */
+	mc_packet_add_dsp_start_and_stop(dsp_started);
+	ret = mc_packet_execute();
+	if (ret < 0)
+		return ret;
+
+	if ((hp_vol_l || hp_vol_r)
+	    && (!hp_vol_l || (status & (MCB_HPL_BUSY << 8)))
+	    && (!hp_vol_r || (status & (MCB_HPR_BUSY << 8)))
+	    && (power.analog[3] & MCB_MB4)) {
+		val = mc_ana_register_get_value(MCI_AP_MIC);
+		if (!(val & MCB_MB4))
+			mc_packet_add_wait(MCDRV_MB4_WAIT_TIME);
+	}
+
+	/* unused path power down */
+	update.digital = MCDRV_POWUPDATE_D_ALL;
+	update.analog[0] = MCDRV_POWUPDATE_AP;
+	update.analog[1] = MCDRV_POWUPDATE_AP_OUT0;
+	update.analog[2] = MCDRV_POWUPDATE_AP_OUT1;
+	update.analog[3] = MCDRV_POWUPDATE_AP_MC;
+	update.analog[4] = MCDRV_POWUPDATE_AP_IN;
+	ret = mc_packet_add_powerdown(&power, &update);
+	if (ret < 0)
+		return ret;
+
+	ret = mc_packet_execute();
+	if (ret < 0)
+		return ret;
+
+	mc_packet_add_start();
+	ret = mc_packet_execute();
+	if (ret < 0)
+		return ret;
+
+	/*      set volume      */
+	ret = set_vol(MCDRV_VOLUPDATE_DIG, MCDRV_VOLUME_SET, NULL);
+	if (ret < 0)
+		return ret;
+
+	return set_vol(MCDRV_VOLUPDATE_ANA_OUT, MCDRV_VOLUME_SET, &status);
+}
+
+static inline int get_volume(struct mcdrv_vol_info *vol_info)
+{
+	if (!vol_info)
+		return -EINVAL;
+
+	mc_vol_info_get(vol_info);
+
+	return 0;
+}
+
+static inline int set_volume(struct mcdrv_vol_info *vol_info)
+{
+	struct mcdrv_path_info path_info;
+
+	if (!vol_info)
+		return -EINVAL;
+
+	mc_vol_info_set(vol_info);
+
+	mc_path_info_get_virtual(&path_info);
+
+	return set_path(&path_info);
+}
+
+static inline int get_digitalio(struct mcdrv_dio_info *dio_info)
+{
+	if (!dio_info)
+		return -EINVAL;
+
+	mc_dio_info_get(dio_info);
+
+	return 0;
+}
+
+static inline int set_digitalio(struct mcdrv_dio_info *dio_info,
+				unsigned int update)
+{
+	if (!dio_info)
+		return -EINVAL;
+
+	if (!is_valid_dio_info(dio_info, update))
+		return -EINVAL;
+
+	mc_dio_info_set(dio_info, update);
+
+	mc_packet_add_digital_io(update);
+
+	return mc_packet_execute();
+}
+
+static inline int get_digitalio_path(struct mcdrv_dio_path_info *dio_path_info)
+{
+	if (!dio_path_info)
+		return -EINVAL;
+
+	mc_dio_path_info_get(dio_path_info);
+
+	return 0;
+}
+
+static inline int set_digitalio_path(struct mcdrv_dio_path_info *dio_path_info,
+				     unsigned int update)
+{
+	if (!dio_path_info)
+		return -EINVAL;
+
+	if (!is_valid_dio_path_info(dio_path_info, update))
+		return -EINVAL;
+
+	mc_dio_path_info_set(dio_path_info, update);
+
+	mc_packet_add_digital_io_path();
+
+	return mc_packet_execute();
+}
+
+static inline int get_swap(struct mcdrv_swap_info *info)
+{
+	if (!info)
+		return -EINVAL;
+
+	mc_swap_info_get(info);
+
+	return 0;
+}
+
+static inline int set_swap(struct mcdrv_swap_info *info, unsigned int update)
+{
+	if (!info)
+		return -EINVAL;
+
+	if (!is_valid_swap_info(info, update))
+		return -EINVAL;
+
+	mc_swap_info_set(info, update);
+
+	mc_packet_add_swap(update);
+
+	return mc_packet_execute();
+}
+
+static inline bool is_path_alloff(void)
+{
+	struct mcdrv_path_info info;
+
+	mc_path_info_get_virtual(&info);
+	if (memcmp(&info, &path_alloff, sizeof(struct mcdrv_path_info)))
+		return false;
+
+	return true;
+}
+
+static int set_dsp(u8 *data, unsigned int size)
+{
+	struct mcdrv_aec_info info, curr_info;
+	struct mcdrv_power_info power;
+	struct mcdrv_power_update update;
+	static struct mcdrv_path_info path_info;
+	enum mcdrv_dev_id id;
+	static u8 g_lp2_start, g_src3_start;
+	u32 mute_flag;
+	int ret = 0;
+
+	if (!data || !size)
+		return -EINVAL;
+
+	id = mc_dev_id_get();
+
+	mc_aec_info_get(&info);
+	curr_info = info;
+
+	ret = mc_parser_d7_data_analyze(data, size, &info);
+	if (ret < 0)
+		return ret;
+
+	if (!is_valid_aec_info(&info))
+		return -EINVAL;
+
+	mc_aec_info_set(&info);
+	mc_aec_info_get(&info);
+
+	info.vbox.cdsp_func_a_on &= 0x01;
+	info.vbox.cdsp_func_b_on &= 0x01;
+
+	if (info.control.command == 1) {
+		if (!info.control.param[0] && !is_path_alloff()) {
+			mc_path_info_get_virtual(&path_info);
+
+			ret = set_path(&path_alloff);
+			if (ret < 0)
+				goto exit;
+		}
+	} else if (info.control.command == 2) {
+		if (!info.control.param[0]) {
+			g_lp2_start = mc_mb_register_get_value(MCI_LP2_START);
+			mc_packet_add_write_mb(MCI_LP2_START, 0);
+			g_src3_start = mc_mb_register_get_value(MCI_SRC3_START);
+			mc_packet_add_write_mb(MCI_SRC3_START, 0);
+			ret = mc_packet_execute();
+			if (ret < 0)
+				goto exit;
+		}
+	} else if (info.control.command == 3) {
+		if (id == MCDRV_DEV_ID_81_91H) {
+			mc_packet_add_dout_mute();
+			mute_flag = MCB_DIFO3_VFLAG1 | MCB_DIFO3_VFLAG0 |
+			    MCB_DIFO2_VFLAG1 | MCB_DIFO2_VFLAG0 |
+			    MCB_DIFO1_VFLAG1 | MCB_DIFO1_VFLAG0 |
+			    MCB_DIFO0_VFLAG1 | MCB_DIFO0_VFLAG0;
+			mc_packet_add_wait_event(MCDRV_EVT_DITMUTE | mute_flag);
+			mute_flag = MCB_DAO1_VFLAG1 | MCB_DAO1_VFLAG0 |
+			    MCB_DAO0_VFLAG1 | MCB_DAO0_VFLAG0;
+			mc_packet_add_wait_event(MCDRV_EVT_DACMUTE | mute_flag);
+			mc_packet_add_write_ma(MCI_CLK_SEL,
+					       info.control.param[0]);
+			mc_clock_select_set(info.control.param[0]);
+
+			ret = mc_packet_execute();
+			if (ret < 0)
+				goto exit;
+
+			ret = set_vol(MCDRV_VOLUPDATE_DOUT,
+				      MCDRV_VOLUME_SET, NULL);
+			if (ret < 0)
+				goto exit;
+		}
+	} else if (info.control.command == 4) {
+		if (id == MCDRV_DEV_ID_81_91H) {
+			u32 status = 0;
+
+			mc_packet_add_dac0_mute();
+			mc_packet_add_dac1_mute();
+			mc_packet_add_adif_mute();
+			mc_packet_add_dpath_da_mute();
+			mute_flag = MCB_ADI2_VFLAG1 | MCB_ADI2_VFLAG0 |
+			    MCB_ADI1_VFLAG1 | MCB_ADI1_VFLAG0 |
+			    MCB_ADI0_VFLAG1 | MCB_ADI0_VFLAG0;
+			mc_packet_add_wait_event(MCDRV_EVT_ADCMUTE | mute_flag);
+
+			mute_flag = MCB_SPR_BUSY << 8 | MCB_SPL_BUSY << 8 |
+			    MCB_HPR_BUSY << 8 | MCB_HPL_BUSY << 8 |
+			    MCB_LO2R_BUSY | MCB_LO2L_BUSY |
+			    MCB_LO1R_BUSY | MCB_LO1L_BUSY | MCB_RC_BUSY;
+			mc_packet_add_wait_event(MCDRV_EVT_SVOL_DONE |
+						 mute_flag);
+			mc_packet_add_write_e(MCI_ECLK_SEL,
+					      info.control.param[0]);
+			mc_e_clock_select_set(info.control.param[0]);
+
+			ret = mc_packet_execute();
+			if (ret < 0)
+				goto exit;
+
+			ret = set_vol(MCDRV_VOLUPDATE_ANA_OUT |
+				      MCDRV_VOLUPDATE_ADIF0 |
+				      MCDRV_VOLUPDATE_ADIF1 |
+				      MCDRV_VOLUPDATE_ADIF2 |
+				      MCDRV_VOLUPDATE_DPATHDA,
+				      MCDRV_VOLUME_SET, &status);
+			if (ret < 0)
+				goto exit;
+		}
+
+	}
+
+	mc_power_info_get(&power);
+	update.digital = MCDRV_POWUPDATE_D_ALL;
+	update.analog[0] = MCDRV_POWUPDATE_AP;
+	update.analog[1] = MCDRV_POWUPDATE_AP_OUT0;
+	update.analog[2] = MCDRV_POWUPDATE_AP_OUT1;
+	update.analog[3] = MCDRV_POWUPDATE_AP_MC;
+	update.analog[4] = MCDRV_POWUPDATE_AP_IN;
+	ret = mc_packet_add_powerup(&power, &update);
+	if (ret < 0)
+		goto exit;
+
+	ret = mc_packet_execute();
+	if (ret < 0)
+		goto exit;
+
+	mc_packet_add_aec();
+	ret = mc_packet_execute();
+	if (ret < 0)
+		goto exit;
+
+	ret = mc_bdsp_set_dsp(&info);
+	if (ret < 0)
+		goto exit;
+
+	ret = mc_cdsp_set_dsp(&info);
+	if (ret < 0)
+		goto exit;
+
+	ret = mc_edsp_set_dsp(&info);
+	if (ret < 0)
+		goto exit;
+
+	ret = mc_fdsp_set_dsp(&info);
+	if (ret < 0)
+		goto exit;
+
+	if (info.control.command == 1) {
+		if (info.control.param[0] == 1) {
+			ret = set_path(&path_info);
+			if (ret < 0)
+				goto exit;
+		}
+	} else if (info.control.command == 2) {
+		if (info.control.param[0] == 1) {
+			mc_packet_add_write_mb(MCI_LP2_START, g_lp2_start);
+			mc_packet_add_write_mb(MCI_SRC3_START, g_src3_start);
+		}
+	}
+
+	mc_power_info_get(&power);
+
+	ret = mc_packet_add_powerdown(&power, &update);
+	if (ret < 0)
+		goto exit;
+
+	return mc_packet_execute();
+
+exit:
+	mc_aec_info_replace(&curr_info);
+	save_power();
+
+	return ret;
+}
+
+static inline int get_hsdet(struct mcdrv_hsdet_info *info)
+{
+	if (!info)
+		return -EINVAL;
+
+	mc_hsdet_info_get(info);
+
+	info->dly_irq_stop = 0;
+
+	return 0;
+}
+
+static int set_hsdet(struct mcdrv_hsdet_info *hsdet, unsigned int update)
+{
+	struct mcdrv_hsdet_info curr_hsdet;
+	struct mcdrv_path_info path_info, tmp_path_info;
+	struct mcdrv_hsdet_res hsdet_res;
+	enum mcdrv_dev_id id;
+	u8 val, data[2], plug_det_db;
+	int ret = 0;
+
+	if (!hsdet)
+		return -EINVAL;
+
+	curr_hsdet = *hsdet;
+	if (!is_valid_hsdet_info(&curr_hsdet, update))
+		return -EINVAL;
+
+	id = mc_dev_id_get();
+	if (id == MCDRV_DEV_ID_80_90H)
+		curr_hsdet.det_in_inv &= 1;
+
+	mc_hsdet_info_set(&curr_hsdet, update);
+	mc_packet_add_hsdet();
+	ret = mc_packet_execute();
+	if (ret < 0)
+		return ret;
+
+	mc_hsdet_info_get(&curr_hsdet);
+	if (curr_hsdet.en_plug_det_db != MCDRV_PLUGDETDB_DISABLE ||
+	    curr_hsdet.en_dly_key_off != MCDRV_KEYEN_D_D_D ||
+	    curr_hsdet.en_dly_key_on != MCDRV_KEYEN_D_D_D ||
+	    curr_hsdet.en_mic_det != MCDRV_MICDET_DISABLE ||
+	    curr_hsdet.en_key_off != MCDRV_KEYEN_D_D_D ||
+	    curr_hsdet.en_key_on != MCDRV_KEYEN_D_D_D) {
+		val = mc_cd_register_get_value(MCI_HSDETEN);
+		if (!(val & MCB_MKDETEN)) {
+			val = MCB_HSDETEN | curr_hsdet.hs_det_dbnc;
+			mc_packet_add_write_cd(MCI_HSDETEN, val);
+
+			if (curr_hsdet.en_dly_key_off != MCDRV_KEYEN_D_D_D ||
+			    curr_hsdet.en_dly_key_on != MCDRV_KEYEN_D_D_D ||
+			    curr_hsdet.en_mic_det != MCDRV_MICDET_DISABLE ||
+			    curr_hsdet.en_key_off != MCDRV_KEYEN_D_D_D ||
+			    curr_hsdet.en_key_on != MCDRV_KEYEN_D_D_D) {
+				bool do_set_path = false;
+
+				if (is_ldoa_on()) {
+					mc_path_info_get_virtual(&path_info);
+					tmp_path_info = path_info;
+					tmp_path_info.adc0[0] = 0x00aaaaaa;
+					tmp_path_info.adc0[1] = 0x00aaaaaa;
+
+					tmp_path_info.adc1[0] = 0x00aaaaaa;
+
+					tmp_path_info.dac0[0] = 0x00aaaaaa;
+					tmp_path_info.dac0[1] = 0x00aaaaaa;
+					tmp_path_info.dac1[0] = 0x00aaaaaa;
+					tmp_path_info.dac1[1] = 0x00aaaaaa;
+
+					tmp_path_info.bias[0] = 0x002aaaaa;
+					tmp_path_info.bias[1] = 0x002aaaaa;
+					tmp_path_info.bias[2] = 0x002aaaaa;
+					tmp_path_info.bias[3] = 0x002aaaaa;
+					ret = set_path(&tmp_path_info);
+					if (ret < 0)
+						return ret;
+
+					do_set_path = true;
+				}
+
+				mc_packet_add_mic_key_detect_enable(true);
+
+				if (do_set_path)
+					ret = set_path(&path_info);
+			}
+		} else {
+			val = MCB_HSDETEN | curr_hsdet.hs_det_dbnc;
+			if (curr_hsdet.en_dly_key_off != MCDRV_KEYEN_D_D_D ||
+			    curr_hsdet.en_dly_key_on != MCDRV_KEYEN_D_D_D ||
+			    curr_hsdet.en_mic_det != MCDRV_MICDET_DISABLE ||
+			    curr_hsdet.en_key_off != MCDRV_KEYEN_D_D_D ||
+			    curr_hsdet.en_key_on != MCDRV_KEYEN_D_D_D) {
+				plug_det_db = mc_plug_detect_db_get();
+				if (plug_det_db & MCB_RPLUGDET_DB)
+					val |= MCB_MKDETEN;
+			}
+
+			mc_packet_add_write_cd(MCI_HSDETEN, val);
+
+			if (!(val & MCB_MKDETEN)) {
+				val = mc_ana_register_get_value(MCI_KDSET);
+				val &= ~(MCB_KDSET2 | MCB_KDSET1);
+				mc_packet_add_force_write_ana(MCI_KDSET, val);
+			}
+		}
+	}
+
+	if (!ret)
+		ret = mc_packet_execute();
+
+	if (!ret) {
+		if ((update & MCDRV_ENPLUGDETDB_UPDATE_FLAG) &&
+		    (curr_hsdet.en_plug_det_db &
+		     MCDRV_PLUGDETDB_UNDET_ENABLE) && curr_hsdet.cbfunc) {
+			data[0] = MCI_CD_REG_A << 1;
+			data[1] = MCI_PLUGDET;
+			mc_write_analog(data, 2);
+			mc_read_analog(MCI_CD_REG_D, &val, 1);
+			if (!(val & MCB_PLUGDET)) {
+				hsdet_res.key_cnt0 = 0;
+				hsdet_res.key_cnt1 = 0;
+				hsdet_res.key_cnt2 = 0;
+				mutex_unlock(&mcdrv_mutex);
+				(*curr_hsdet.
+				 cbfunc) (MCDRV_HSDET_EVT_PLUGUNDET_DB_FLAG,
+					  &hsdet_res);
+				mutex_lock(&mcdrv_mutex);
+			}
+		}
+
+		ret = save_power();
+	}
+
+	return ret;
+}
+
+static inline void enable_irqhs(u8 *data)
+{
+	data[1] = MCI_IRQHS;
+	data[3] = MCB_EIRQHS;
+	mc_write_analog(data, 4);
+
+	mc_cd_register_set_value(MCI_IRQHS, MCB_EIRQHS);
+}
+
+int mc_do_irq(void)
+{
+	struct mcdrv_aec_info aec;
+	struct mcdrv_path_info path;
+	struct mcdrv_hsdet_info hsdet;
+	struct mcdrv_hsdet_res hsdet_res;
+	enum mcdrv_dev_id id;
+	u32 flag_det = 0;
+	u8 val, splug_det, plug_det, sensefin, eirq, data[4];
+	u8 flag_dlykey = 0, flag_key = 0;
+	static u8 s_op_dac, s_hp_det;
+	unsigned long interval;
+	int cycles, timeout, ret = 0;
+
+	mutex_lock(&mcdrv_mutex);
+
+	id = mc_dev_id_get();
+	mc_hsdet_info_get(&hsdet);
+
+	eirq = mc_if_register_get_value(MCI_IRQ);
+	val = mc_cd_register_get_value(MCI_EIRQSENSE);
+	if (val & MCB_EIRQSENSE) {
+		/* IRQ Disable */
+		data[0] = MCI_IRQR << 1;
+		data[1] = 0;
+		mc_write_digital(data, 2);
+
+		data[0] = MCI_CD_REG_A << 1;
+		data[1] = MCI_SSENSEFIN;
+		mc_write_analog(data, 2);
+		mc_read_analog(MCI_CD_REG_D, &sensefin, 1);
+		if (sensefin & MCB_SSENSEFIN) {
+			data[1] = MCI_EIRQSENSE;
+			data[2] = MCI_CD_REG_D << 1;
+			data[3] = 0;
+			mc_write_analog(data, 4);
+
+			mc_cd_register_set_value(MCI_EIRQSENSE, 0);
+			data[1] = MCI_SSENSEFIN;
+			data[3] = val;
+			mc_write_analog(data, 4);
+		} else {
+			/* IRQ Enable */
+			data[0] = MCI_IRQR << 1;
+			data[1] = MCB_EIRQR;
+			mc_write_digital(data, 2);
+
+			mutex_unlock(&mcdrv_mutex);
+
+			return 0;
+		}
+
+		/*      PLUGDET, PLUGUNDETDB, PLUGDETDB */
+		data[0] = MCI_CD_REG_A << 1;
+		data[1] = MCI_PLUGDET;
+		mc_write_analog(data, 2);
+		mc_read_analog(MCI_CD_REG_D, &val, 1);
+
+		/*      clear   */
+		flag_det = val;
+		data[2] = MCI_CD_REG_D << 1;
+		data[3] = val;
+		mc_write_analog(data, 4);
+
+		/*      set reference   */
+		data[1] = MCI_PLUGDET_DB;
+		mc_write_analog(data, 2);
+		mc_read_analog(MCI_CD_REG_D, &val, 1);
+		mc_plug_detect_db_set(val);
+
+		data[1] = MCI_RPLUGDET;
+		data[3] = (flag_det & MCB_PLUGDET) | val;
+		mc_write_analog(data, 4);
+		flag_det = data[3];
+
+		data[1] = MCI_MICDET;
+		mc_write_analog(data, 2);
+		mc_read_analog(MCI_CD_REG_D, &val, 1);
+
+		data[1] = MCI_RMICDET;
+		data[3] = val;
+		mc_write_analog(data, 4);
+		flag_key = val & MCB_MICDET;
+
+		data[1] = MCI_SMICDET;
+		mc_write_analog(data, 2);
+		mc_read_analog(MCI_CD_REG_D, &val, 1);
+
+		data[3] = val;
+		mc_write_analog(data, 4);
+
+		hsdet_res.key_cnt0 = 0;
+		hsdet_res.key_cnt1 = 0;
+		hsdet_res.key_cnt2 = 0;
+
+		data[0] = MCI_E_REG_A << 1;
+		data[1] = MCI_PLUG_REV;
+		mc_write_digital(data, 2);
+		mc_read_digital(MCI_E_REG_D, &val, 1);
+		hsdet_res.plug_rev = val >> 7;
+		hsdet_res.hp_imp_class = val & 0x07;
+		data[1] = MCI_HPIMP_15_8;
+		mc_write_digital(data, 2);
+		mc_read_digital(MCI_E_REG_D, &val, 1);
+		hsdet_res.hp_imp = val << 8;
+		data[1] = MCI_HPIMP_7_0;
+		mc_write_digital(data, 2);
+		mc_read_digital(MCI_E_REG_D, &val, 1);
+		hsdet_res.hp_imp |= val;
+
+		val = mc_e_register_get_value(MCI_LPF_THR);
+		val &=
+		    (MCB_OSF1_MN | MCB_OSF0_MN | MCB_OSF1_ENB | MCB_OSF0_ENB);
+		mc_aec_info_get(&aec);
+		val |= aec.output.lpf_post_thru[1] << 7
+		    | aec.output.lpf_post_thru[0] << 6
+		    | aec.output.lpf_pre_thru[1] << 5
+		    | aec.output.lpf_pre_thru[0] << 4;
+		mc_packet_add_write_e(MCI_LPF_THR, val);
+
+		val = aec.output.dcl_on[1] << 7 | aec.output.dcl_gain[1] << 4
+		    | aec.output.dcl_on[0] << 3 | aec.output.dcl_gain[0];
+		mc_packet_add_write_e(MCI_DCL_GAIN, val);
+
+		if (id == MCDRV_DEV_ID_80_90H)
+			mc_packet_add_write_ana(19, s_op_dac);
+
+		mc_packet_add_write_ana(MCI_HPDETVOL, s_hp_det);
+		if (id == MCDRV_DEV_ID_80_90H) {
+			mc_packet_add_force_write_ana(78,
+						      T_CPMODE_IMPSENSE_AFTER);
+			mc_packet_add_force_write_ana(87, 0);
+			data[0] = MCI_ANA_REG_A << 1;
+			data[1] = 78;
+			mc_write_analog(data, 2);
+			mc_read_analog(MCI_ANA_REG_D, &val, 1);
+		} else {
+			mc_packet_add_force_write_ana(87, 0);
+			mc_packet_add_force_write_if(31, 0);
+			mc_packet_add_force_write_if(30, 0);
+		}
+
+		mc_path_info_get_virtual(&path);
+		ret = set_path(&path);
+
+		if (hsdet.cbfunc) {
+			if (flag_det & MCB_SPLUGUNDET_DB)
+				flag_det = MCB_PLUGUNDET_DB;
+			else
+				flag_det |= MCDRV_HSDET_EVT_SENSEFIN_FLAG;
+
+			mutex_unlock(&mcdrv_mutex);
+
+			(*hsdet.cbfunc) (flag_det | (flag_key << 16),
+					 &hsdet_res);
+			mutex_lock(&mcdrv_mutex);
+		}
+
+		/*      Enable IRQ      */
+		data[0] = MCI_CD_REG_A << 1;
+		data[2] = MCI_CD_REG_D << 1;
+		enable_irqhs(data);
+
+		data[0] = MCI_IRQR << 1;
+		data[1] = MCB_EIRQR;
+		mc_write_digital(data, 2);
+
+		val = mc_if_register_get_value(MCI_RST_A);
+		if (!val) {
+			data[0] = MCI_IRQ << 1;
+			data[1] = MCB_EIRQ;
+			mc_write_digital(data, 2);
+			mc_if_register_set_value(MCI_IRQ, MCB_EIRQ);
+		}
+
+		mutex_unlock(&mcdrv_mutex);
+
+		return 0;
+	}
+
+	if (mc_state_get() != MCDRV_STATE_READY) {
+		ret = -EBUSY;
+		goto exit;
+	}
+
+	if (eirq & MCB_EIRQ) {
+		mc_read_digital(MCI_EDSP, &val, 1);
+		if (val) {
+			/* Disable IRQ */
+			mc_packet_add_force_write_if(MCI_EEDSP, 0);
+
+			ret = mc_packet_execute();
+			if (ret < 0)
+				goto exit;
+
+			if (val & MCB_E2DSP_STA)
+				mc_edsp_irq();
+
+			/* Clear IRQ */
+			mc_packet_add_force_write_if(MCI_EDSP, val);
+
+			/* Enable IRQ */
+			mc_packet_add_force_write_if(MCI_EEDSP, MCB_EE2DSP);
+		}
+
+		mc_read_digital(MCI_CDSP, &val, 1);
+		if (val) {
+			/* Disable IRQ */
+			mc_packet_add_force_write_if(MCI_ECDSP, 0);
+
+			ret = mc_packet_execute();
+			if (ret < 0)
+				goto exit;
+
+			mc_cdsp_irq();
+
+			/* Clear IRQ */
+			mc_packet_add_force_write_if(MCI_CDSP, val);
+
+			/* Enable IRQ */
+			val = MCB_ECDSP | MCB_EFFIFO | MCB_ERFIFO | MCB_EEFIFO |
+			    MCB_EOFIFO | MCB_EDFIFO | MCB_EENC | MCB_EDEC;
+			mc_packet_add_force_write_if(MCI_ECDSP, val);
+		}
+
+		mc_read_digital(MCI_IRSERR, &val, 1);
+		if (val) {
+			/* Disable IRQ */
+			mc_packet_add_force_write_if(MCI_IESERR, 0);
+
+			ret = mc_packet_execute();
+			if (ret < 0)
+				goto exit;
+
+			mc_fdsp_irq();
+
+			/* Clear IRQ */
+			mc_packet_add_force_write_if(MCI_IRSERR, val);
+			/* Enable IRQ */
+			val =
+			    MCB_IESERR | MCB_IEAMTBEG | MCB_IEAMTEND | MCB_IEFW;
+			mc_packet_add_force_write_if(MCI_IESERR, val);
+		}
+
+		ret = mc_packet_execute();
+		if (ret < 0)
+			goto exit;
+	}
+
+	data[0] = MCI_CD_REG_A << 1;
+	data[1] = MCI_IRQHS;
+	mc_write_analog(data, 2);
+	mc_read_analog(MCI_CD_REG_D, &val, 1);
+	if (val == (MCB_EIRQHS | MCB_IRQHS)) {
+		/* Disable EIRQHS */
+		data[2] = MCI_CD_REG_D << 1;
+		data[3] = 0;
+		mc_write_analog(data, 4);
+		mc_cd_register_set_value(MCI_IRQHS, 0);
+
+		/* PLUGDET, SPLUGUNDETDB, SPLUGDETDB */
+		data[1] = MCI_PLUGDET;
+		mc_write_analog(data, 2);
+		mc_read_analog(MCI_CD_REG_D, &splug_det, 1);
+		flag_det = splug_det & MCB_PLUGDET;
+
+		data[1] = MCI_PLUGDET_DB;
+		mc_write_analog(data, 2);
+		mc_read_analog(MCI_CD_REG_D, &plug_det, 1);
+		flag_det |= plug_det;
+		if (flag_det & MCB_PLUGUNDET_DB)
+			mc_plug_detect_db_set(0);
+
+		if (hsdet.en_plug_det_db & MCDRV_PLUGDETDB_DET_ENABLE) {
+			if (id == MCDRV_DEV_ID_81_91H) {
+				data[1] = MCI_RPLUGDET;
+				mc_write_analog(data, 2);
+				mc_read_analog(MCI_CD_REG_D, &val, 1);
+				val = ~val & plug_det;
+			} else
+				val = splug_det;
+
+			if (val & MCB_SPLUGDET_DB) {
+				mc_plug_detect_db_set(val);
+
+				if (id != MCDRV_DEV_ID_81_92H) {
+					val = mc_ana_register_get_value(MCI_AP);
+					val &= ~MCB_AP_BGR;
+					mc_packet_add_write_ana(MCI_AP, val);
+				}
+
+				val = mc_ana_register_get_value(MCI_HIZ);
+				val |= MCB_HPR_HIZ | MCB_HPL_HIZ;
+				mc_packet_add_write_ana(MCI_HIZ, val);
+
+				mc_path_info_get_virtual(&path);
+				path.bias[3] |= MCDRV_ASRC_MIC4_ON;
+				ret = set_path(&path);
+				if (ret < 0) {
+					enable_irqhs(data);
+					goto exit;
+				}
+
+				if (hsdet.en_dly_key_off != MCDRV_KEYEN_D_D_D
+				    || hsdet.en_dly_key_on != MCDRV_KEYEN_D_D_D
+				    || hsdet.en_mic_det != MCDRV_MICDET_DISABLE
+				    || hsdet.en_key_off != MCDRV_KEYEN_D_D_D
+				    || hsdet.en_key_on != MCDRV_KEYEN_D_D_D)
+					mc_packet_add_mic_key_detect_enable
+					    (false);
+
+				ret = mc_packet_execute();
+				if (ret < 0) {
+					enable_irqhs(data);
+					goto exit;
+				}
+
+				if (hsdet.sgnl_num != MCDRV_SGNLNUM_NONE) {
+					s_hp_det =
+					    mc_ana_register_get_value
+					    (MCI_HPDETVOL);
+					ret = imp_sense_start(&s_op_dac);
+					if (ret == 0) {
+						mutex_unlock(&mcdrv_mutex);
+						return ret;
+					}
+
+					enable_irqhs(data);
+					goto exit;
+				}
+			}
+		}
+
+		/*      clear   */
+		data[1] = MCI_PLUGDET;
+		data[3] = splug_det;
+		mc_write_analog(data, 4);
+
+		/*      set reference   */
+		data[1] = MCI_RPLUGDET;
+		data[3] = flag_det;
+		mc_write_analog(data, 4);
+
+		/*      DLYKEYON, DLYKEYOFF     */
+		data[1] = MCI_SDLYKEY;
+		mc_write_analog(data, 2);
+		mc_read_analog(MCI_CD_REG_D, &val, 1);
+		flag_dlykey = val;
+		/*      clear   */
+		data[1] = MCI_SDLYKEY;
+		data[3] = val;
+		mc_write_analog(data, 4);
+
+		/*      MICDET, KEYON, KEYOFF   */
+		data[1] = MCI_SMICDET;
+		mc_write_analog(data, 2);
+		mc_read_analog(MCI_CD_REG_D, &val, 1);
+		flag_key = val & ~MCB_SMICDET;
+		/*      clear   */
+		data[1] = MCI_SMICDET;
+		data[3] = val;
+		mc_write_analog(data, 4);
+
+		/* set reference */
+		data[1] = MCI_MICDET;
+		mc_write_analog(data, 2);
+		if (hsdet.sgnl_num == MCDRV_SGNLNUM_NONE) {
+			if (flag_det & MCB_PLUGDET_DB) {
+				switch (hsdet.speriod) {
+				case MCDRV_SPERIOD_488:
+					interval = 488;
+					break;
+				case MCDRV_SPERIOD_977:
+					interval = 977;
+					break;
+				case MCDRV_SPERIOD_1953:
+					interval = 1953;
+					break;
+				case MCDRV_SPERIOD_3906:
+					interval = 3906;
+					break;
+				case MCDRV_SPERIOD_7813:
+					interval = 7813;
+					break;
+				case MCDRV_SPERIOD_15625:
+					interval = 15625;
+					break;
+				case MCDRV_SPERIOD_31250:
+					interval = 31250;
+					break;
+				default:
+					interval = 244;
+					break;
+				}
+
+				timeout = 1;
+				switch (hsdet.dbnc_num_mic) {
+				case MCDRV_DBNC_NUM_3:
+					timeout += 3;
+					break;
+				case MCDRV_DBNC_NUM_4:
+					timeout += 4;
+					break;
+				case MCDRV_DBNC_NUM_7:
+					timeout += 7;
+					break;
+				default:
+					break;
+				}
+
+				cycles = 0;
+				while (cycles < timeout) {
+					mc_read_analog(MCI_CD_REG_D,
+								 &val, 1);
+					if (val & (MCB_MICDET | 0x07))
+						break;
+
+					udelay(interval);
+					cycles++;
+				}
+			}
+		} else
+			mc_read_analog(MCI_CD_REG_D, &val, 1);
+		flag_key |= val & MCB_MICDET;
+		data[1] = MCI_RMICDET;
+		data[3] = val;
+		mc_write_analog(data, 4);
+
+		if (hsdet.cbfunc) {
+			/*      KeyCnt0 */
+			data[1] = MCI_KEYCNTCLR0;
+			mc_write_analog(data, 2);
+			mc_read_analog(MCI_CD_REG_D,
+						 &hsdet_res.key_cnt0, 1);
+			data[1] = MCI_KEYCNTCLR0;
+			data[3] = MCB_KEYCNTCLR0;
+			mc_write_analog(data, 4);
+
+			/*      KeyCnt1 */
+			data[1] = MCI_KEYCNTCLR1;
+			mc_write_analog(data, 2);
+			mc_read_analog(MCI_CD_REG_D,
+						 &hsdet_res.key_cnt1, 1);
+			data[1] = MCI_KEYCNTCLR1;
+			data[3] = MCB_KEYCNTCLR1;
+			mc_write_analog(data, 4);
+
+			/*      KeyCnt2 */
+			data[1] = MCI_KEYCNTCLR2;
+			mc_write_analog(data, 2);
+			mc_read_analog(MCI_CD_REG_D,
+						 &hsdet_res.key_cnt2, 1);
+			data[1] = MCI_KEYCNTCLR2;
+			data[3] = MCB_KEYCNTCLR2;
+			mc_write_analog(data, 4);
+
+			data[0] = MCI_IRQ << 1;
+			data[1] = 0;
+			mc_write_analog(data, 2);
+			mc_if_register_set_value(MCI_IRQ, 0);
+
+			data[0] = MCI_IRQR << 1;
+			data[1] = 0;
+			mc_write_analog(data, 2);
+
+			mutex_unlock(&mcdrv_mutex);
+
+			(*hsdet.cbfunc) (flag_det | (u32) flag_dlykey << 8 |
+					 (u32) flag_key << 16, &hsdet_res);
+
+			mutex_lock(&mcdrv_mutex);
+
+			data[0] = MCI_IRQR << 1;
+			data[1] = MCB_EIRQR;
+			mc_write_analog(data, 2);
+		}
+		/* Enable IRQ */
+		data[0] = MCI_CD_REG_A << 1;
+		data[2] = MCI_CD_REG_D << 1;
+		enable_irqhs(data);
+	}
+
+exit:
+	val = mc_if_register_get_value(MCI_RST_A);
+	if (!val) {
+		val = mc_if_register_get_value(MCI_IRQ);
+		if (val != MCB_EIRQ) {
+			data[0] = MCI_IRQ << 1;
+			data[1] = MCB_EIRQ;
+			mc_write_analog(data, 2);
+			mc_if_register_set_value(MCI_IRQ, MCB_EIRQ);
+		}
+	}
+
+	mutex_unlock(&mcdrv_mutex);
+
+	return ret;
+}
+
+static inline bool is_valid_mcdrv_dev_info(struct mcdrv_dev_info *info)
+{
+	enum mcdrv_dev_id id;
+
+	id = mc_dev_id_get();
+
+	if (info->clk_sel > MCDRV_CKSEL_LAST)
+		return false;
+
+	if (info->clk_input > MCDRV_CKINPUT_LAST ||
+	    info->clk_input == MCDRV_CKINPUT_NONE0 ||
+	    info->clk_input == MCDRV_CKINPUT_NONE1 ||
+	    info->clk_input == MCDRV_CKINPUT_NONE2)
+		return false;
+
+	if (info->pll_mode_a > MCDRV_PLLMODE_MAX)
+		return false;
+
+	if (info->pll_prev_div_a > MCDRV_PLLPREV_DIV_MAX)
+		return false;
+
+	if (info->pll_fb_div_a > MCDRV_PLLFB_DIV_MAX)
+		return false;
+
+	if (info->pll_mode_b > MCDRV_PLLMODE_MAX)
+		return false;
+
+	if (info->pll_prev_div_b > MCDRV_PLLPREV_DIV_MAX)
+		return false;
+
+	if (info->pll_fb_div_b > MCDRV_PLLFB_DIV_MAX)
+		return false;
+
+	if (info->power_mode != MCDRV_POWMODE_FULL &&
+	    info->power_mode != MCDRV_POWMODE_CDSPDEBUG)
+		return false;
+
+	if (info->mb_sel1 > MCDRV_MBSEL_LAST)
+		return false;
+
+	if (info->mb_sel2 > MCDRV_MBSEL_LAST)
+		return false;
+
+	if (info->mb_sel3 > MCDRV_MBSEL_LAST)
+		return false;
+
+	if (info->mb_sel4 > MCDRV_MBSEL_LAST)
+		return false;
+
+	if (info->mbs_disch > MCDRV_MBSDISCH_LAST)
+		return false;
+
+	if (info->sp_hiz > MCDRV_WL_LAST)
+		return false;
+
+	if (info->hp_hiz > MCDRV_IMP_LAST)
+		return false;
+
+	if (info->line_out1_hiz > MCDRV_IMP_LAST)
+		return false;
+
+	if (info->line_out2_hiz > MCDRV_IMP_LAST)
+		return false;
+
+	if (info->wait_time.wait[0] > MCDRV_WAIT_MAX ||
+	    info->wait_time.wait[1] > MCDRV_WAIT_MAX ||
+	    info->wait_time.wait[2] > MCDRV_WAIT_MAX ||
+	    info->wait_time.wait[3] > MCDRV_WAIT_MAX ||
+	    info->wait_time.wait[4] > MCDRV_WAIT_MAX)
+		return false;
+
+	if (id == MCDRV_DEV_ID_81_91H) {
+		if (info->options[0] > MCDRV_DOA_DRV_LAST)
+			return false;
+		if (info->options[1] > MCDRV_SCKMSK_LAST)
+			return false;
+		if (info->options[2] > MCDRV_SPMN_LAST)
+			return false;
+		if (info->options[3] > 0x0f)
+			return false;
+		if (info->options[4] > 0xf8)
+			return false;
+		if (info->options[5] > 0xf8)
+			return false;
+		if (info->options[6] > 0x31)
+			return false;
+		if (info->options[7] > 0x7f)
+			return false;
+		if (info->options[9] > 0x7f)
+			return false;
+		if (info->options[10] > 0x11)
+			return false;
+		if (info->options[11] > 0xf3)
+			return false;
+		if (info->options[12] > 0x07)
+			return false;
+	}
+
+	return true;
+}
+
+int mc_init(struct mcdrv_dev_info *info)
+{
+	struct mcdrv_power_info power_info;
+	struct mcdrv_power_update power_update;
+	enum mcdrv_state state;
+	u8 analog_id, digital_id, ap = MCI_AP_DEF, data[4];
+	int ret;
+
+	if (!info)
+		return -EINVAL;
+
+	state = mc_state_get();
+	if (state == MCDRV_STATE_READY)
+		return -EBUSY;
+
+	mutex_lock(&mcdrv_mutex);
+
+	mc_resource_init();
+
+	data[0] = MCI_ANA_REG_A << 1;
+	data[1] = MCI_ANA_ID;
+	mc_write_analog(data, 2);
+	mc_read_analog(MCI_ANA_REG_D, &analog_id, 1);
+
+	if ((analog_id & MCDRV_DEVID_MASK) == MCDRV_DEVID_ANA) {
+		/* reset */
+		data[0] = MCI_ANA_REG_A << 1;
+		data[1] = MCI_ANA_RST;
+		data[2] = MCI_ANA_REG_D << 1;
+		data[3] = MCI_ANA_RST_DEF;
+		mc_write_analog(data, 4);
+
+		data[3] = 0;
+		mc_write_analog(data, 4);
+
+		if (!(analog_id & MCDRV_VERID_MASK)) {
+			data[1] = MCI_AP;
+			data[3] = MCI_AP_DEF & ~(MCB_AP_LDOD | MCB_AP_BGR);
+			mc_write_analog(data, 4);
+
+			data[3] &= ~MCB_AP_VR;
+			mc_write_analog(data, 4);
+
+			msleep(VREF_WAIT_TIME_ES1);
+
+			data[3] &= ~MCB_AP_LDOA;
+			mc_write_analog(data, 4);
+
+			msleep(LDO_WAIT_TIME);
+
+			ap = data[3];
+		} else {
+			data[1] = MCI_HIZ;
+			data[3] = 0;
+			mc_write_analog(data, 4);
+
+			data[1] = MCI_LO_HIZ;
+			data[3] = 0;
+			mc_write_analog(data, 4);
+
+			data[1] = MCI_AP;
+			ap &= ~(MCB_AP_LDOD | MCB_AP_BGR);
+			data[3] = ap;
+			mc_write_analog(data, 4);
+
+			ap &= ~MCB_AP_LDOA;
+			data[3] = ap;
+			mc_write_analog(data, 4);
+
+			msleep(LDO_WAIT_TIME);
+
+			data[1] = 62;
+			data[3] = 0x20;
+			mc_write_analog(data, 4);
+
+			data[1] = MCI_AP;
+			ap &= ~MCB_AP_VR;
+			data[3] = ap;
+			mc_write_analog(data, 4);
+
+			msleep(VREF_WAIT_TIME);
+
+			data[1] = 62;
+			data[3] = 0;
+			mc_write_analog(data, 4);
+		}
+
+		data[0] = MCI_RST_A << 1;
+		data[1] = MCI_RST_A_DEF & ~MCB_RST_A;
+		mc_write_digital(data, 2);
+
+		data[0] = MCI_A_REG_A << 1;
+		data[1] = MCI_A_DEV_ID;
+		mc_write_digital(data, 2);
+		mc_read_digital(MCI_A_REG_D, &digital_id, 1);
+		ret = mc_id_set(digital_id, analog_id);
+		if (!ret) {
+			if (is_valid_mcdrv_dev_info(info)) {
+				mc_ana_register_set_value(MCI_AP, ap);
+				mc_dev_info_set(info);
+				mc_packet_clear();
+				ret = mc_packet_init();
+				if (ret == 0)
+					ret = mc_packet_execute();
+			} else
+				ret = -EINVAL;
+		}
+
+		if (!ret && info->power_mode == MCDRV_POWMODE_CDSPDEBUG) {
+			mc_power_info_get(&power_info);
+
+			/*      used path power up      */
+			power_update.digital = MCDRV_POWUPDATE_D_ALL;
+			power_update.analog[0] = 0;
+			power_update.analog[1] = 0;
+			power_update.analog[2] = 0;
+			power_update.analog[3] = 0;
+			power_update.analog[4] = 0;
+			ret = mc_packet_add_powerup(&power_info, &power_update);
+		}
+
+		if (!ret) {
+			mc_state_update(MCDRV_STATE_READY);
+			save_power();
+		}
+	} else
+		ret = -EIO;
+
+	mutex_unlock(&mcdrv_mutex);
+
+	return ret;
+}
+
+int mc_term(void)
+{
+	struct mcdrv_dev_info info;
+	struct mcdrv_power_info power_info;
+	struct mcdrv_power_update power_update;
+	struct mcdrv_hsdet_info hsdet_info;
+	enum mcdrv_state state;
+	u32 flags;
+	int ret = 0;
+
+	state = mc_state_get();
+	if (state != MCDRV_STATE_READY)
+		return -EBUSY;
+
+	mutex_lock(&mcdrv_mutex);
+
+	mc_dev_info_get(&info);
+	info.power_mode = MCDRV_POWMODE_FULL;
+	mc_dev_info_set(&info);
+
+	ret = set_path(&path_alloff);
+	if (!ret) {
+		power_info.digital = 0xff;
+		power_info.analog[0] = 0xff;
+		power_info.analog[1] = 0xff;
+		power_info.analog[2] = 0xff;
+		power_info.analog[3] = 0xff;
+		power_info.analog[4] = 0xff;
+
+		power_update.digital = MCDRV_POWUPDATE_D_ALL;
+		power_update.analog[0] = MCDRV_POWUPDATE_AP;
+		power_update.analog[1] = MCDRV_POWUPDATE_AP_OUT0;
+		power_update.analog[2] = (u8) MCDRV_POWUPDATE_AP_OUT1;
+		power_update.analog[3] = (u8) MCDRV_POWUPDATE_AP_MC;
+		power_update.analog[4] = (u8) MCDRV_POWUPDATE_AP_IN;
+
+		ret = mc_packet_add_powerdown(&power_info,
+						       &power_update);
+		if (!ret)
+			ret = mc_packet_execute();
+	}
+
+	hsdet_info.en_plug_det = MCDRV_PLUGDET_DISABLE;
+	hsdet_info.en_plug_det_db = MCDRV_PLUGDETDB_DISABLE;
+	hsdet_info.en_dly_key_off = MCDRV_KEYEN_D_D_D;
+	hsdet_info.en_dly_key_on = MCDRV_KEYEN_D_D_D;
+	hsdet_info.en_mic_det = MCDRV_MICDET_DISABLE;
+	hsdet_info.en_key_off = MCDRV_KEYEN_D_D_D;
+	hsdet_info.en_key_on = MCDRV_KEYEN_D_D_D;
+	flags = MCDRV_ENPLUGDET_UPDATE_FLAG | MCDRV_ENPLUGDETDB_UPDATE_FLAG |
+	    MCDRV_ENDLYKEYOFF_UPDATE_FLAG | MCDRV_ENDLYKEYON_UPDATE_FLAG |
+	    MCDRV_ENMICDET_UPDATE_FLAG | MCDRV_ENKEYOFF_UPDATE_FLAG |
+	    MCDRV_ENKEYON_UPDATE_FLAG;
+
+	ret = set_hsdet(&hsdet_info, flags);
+
+	mc_state_update(MCDRV_STATE_NOTINIT);
+
+	mutex_unlock(&mcdrv_mutex);
+
+	return ret;
+}
+
+int mc_control(unsigned int cmd, unsigned long arg, unsigned int flags)
+{
+	int ret;
+
+	if (mc_state_get() != MCDRV_STATE_READY)
+		return -EBUSY;
+
+	mutex_lock(&mcdrv_mutex);
+
+	switch (cmd) {
+	case MCDRV_GET_CLOCKSW:
+		ret = get_clock((u8 *) arg);
+		break;
+	case MCDRV_SET_CLOCKSW:
+		ret = set_clock((u8 *) arg);
+		break;
+	case MCDRV_GET_PATH:
+		ret = get_path((struct mcdrv_path_info *)arg);
+		break;
+	case MCDRV_SET_PATH:
+		ret = set_path((struct mcdrv_path_info *)arg);
+		break;
+	case MCDRV_GET_VOLUME:
+		ret = get_volume((struct mcdrv_vol_info *)arg);
+		break;
+	case MCDRV_SET_VOLUME:
+		ret = set_volume((struct mcdrv_vol_info *)arg);
+		break;
+	case MCDRV_GET_DIGITALIO:
+		ret = get_digitalio((struct mcdrv_dio_info *)arg);
+		break;
+	case MCDRV_SET_DIGITALIO:
+		ret = set_digitalio((struct mcdrv_dio_info *)arg, flags);
+		break;
+	case MCDRV_GET_DIGITALIO_PATH:
+		ret = get_digitalio_path((struct mcdrv_dio_path_info *)arg);
+		break;
+	case MCDRV_SET_DIGITALIO_PATH:
+		ret =
+		    set_digitalio_path((struct mcdrv_dio_path_info *)arg,
+				       flags);
+		break;
+	case MCDRV_GET_SWAP:
+		ret = get_swap((struct mcdrv_swap_info *)arg);
+		break;
+	case MCDRV_SET_SWAP:
+		ret = set_swap((struct mcdrv_swap_info *)arg, flags);
+		break;
+	case MCDRV_SET_DSP:
+		ret = set_dsp((u8 *) arg, flags);
+		break;
+	case MCDRV_GET_HSDET:
+		ret = get_hsdet((struct mcdrv_hsdet_info *)arg);
+		break;
+	case MCDRV_SET_HSDET:
+		ret = set_hsdet((struct mcdrv_hsdet_info *)arg, flags);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	mutex_unlock(&mcdrv_mutex);
+
+	return ret;
+}
+
+int mc_version_id_get(void)
+{
+	u8 data[2], val;
+
+	mutex_lock(&mcdrv_mutex);
+
+	data[0] = MCI_ANA_REG_A << 1;
+	data[1] = MCI_ANA_ID;
+	mc_write_analog(data, 2);
+	mc_read_analog(MCI_ANA_REG_D, &val, 1);
+
+	mutex_unlock(&mcdrv_mutex);
+
+	return val & 0x7;
+}
diff --git a/sound/soc/codecs/ymu831/mcdriver.h b/sound/soc/codecs/ymu831/mcdriver.h
new file mode 100644
index 0000000..d583e87
--- /dev/null
+++ b/sound/soc/codecs/ymu831/mcdriver.h
@@ -0,0 +1,1017 @@
+/****************************************************************************
+ *
+ * Copyright(c) 2012 Yamaha Corporation. All rights reserved.
+ *
+ * Module	: mcdriver.h
+ * Description	: MC driver header
+ * Version	: 1.0.0 Dec 13 2012
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
+#ifndef _MCDRIVER_H
+#define _MCDRIVER_H
+
+#include <linux/types.h>
+
+/* mc_control command */
+enum mc_command {
+	MCDRV_GET_CLOCKSW,
+	MCDRV_SET_CLOCKSW,
+	MCDRV_GET_PATH,
+	MCDRV_SET_PATH,
+	MCDRV_GET_VOLUME,
+	MCDRV_SET_VOLUME,
+	MCDRV_GET_DIGITALIO,
+	MCDRV_SET_DIGITALIO,
+	MCDRV_GET_DIGITALIO_PATH,
+	MCDRV_SET_DIGITALIO_PATH,
+	MCDRV_GET_SWAP,
+	MCDRV_SET_SWAP,
+	MCDRV_SET_DSP,
+	MCDRV_GET_HSDET,
+	MCDRV_SET_HSDET,
+};
+
+#define MCDRV_WAIT_MAX			268435455U
+
+struct mcdrv_wait_time {
+	u32 wait[7];
+	u32 poll_interval[6];
+	u32 poll_timeout[6];
+};
+
+/*	mcdrv_dev_info clk_sel setting	*/
+#define	MCDRV_CKSEL_CMOS_CMOS		0x00
+#define	MCDRV_CKSEL_TCXO_CMOS		0x01
+#define	MCDRV_CKSEL_CMOS_TCXO		0x02
+#define	MCDRV_CKSEL_TCXO_TCXO		0x03
+#define	MCDRV_CKSEL_LAST		MCDRV_CKSEL_TCXO_TCXO
+
+/*	mcdrv_dev_info clk_input setting	*/
+#define MCDRV_CKINPUT_NONE0		0x00
+#define	MCDRV_CKINPUT_CLKI1_CLKI0	0x01
+#define	MCDRV_CKINPUT_RTC_CLKI0		0x02
+#define	MCDRV_CKINPUT_SBCK_CLKI0	0x03
+#define	MCDRV_CKINPUT_CLKI0_CLKI1	0x04
+#define MCDRV_CKINPUT_NONE1		0x05
+#define	MCDRV_CKINPUT_RTC_CLKI1		0x06
+#define	MCDRV_CKINPUT_SBCK_CLKI1	0x07
+#define	MCDRV_CKINPUT_CLKI0_RTCK	0x08
+#define	MCDRV_CKINPUT_CLKI1_RTCK	0x09
+#define MCDRV_CKINPUT_NONE2		0x0A
+#define	MCDRV_CKINPUT_SBCK_RTC		0x0B
+#define	MCDRV_CKINPUT_CLKI0_SBCK	0x0C
+#define	MCDRV_CKINPUT_CLKI1_SBCK	0x0D
+#define	MCDRV_CKINPUT_RTC_SBCK		0x0E
+#define MCDRV_CKINPUT_LAST		MCDRV_CKINPUT_RTC_SBCK
+
+#define MCDRV_PLLMODE_MAX		7
+
+#define MCDRV_PLLPREV_DIV_MAX		0x3f
+
+#define MCDRV_PLLFB_DIV_MAX		0x3fff
+
+/*	mcdrv_dev_info pll_freq_* setting	*/
+#define	MCDRV_PLLFREQ_73		0
+#define	MCDRV_PLLFREQ_147		1
+
+/*	mcdrv_dev_info hsdet_clk setting	*/
+#define	MCDRV_HSDETCLK_RTC		false
+#define	MCDRV_HSDETCLK_OSC		true
+
+/*	mcdrv_dev_info XXX_hiz setting	*/
+#define	MCDRV_DAHIZ_LOW			0
+#define	MCDRV_DAHIZ_HIZ			1
+
+/*	mcdrv_dev_info pcm_hiz setting	*/
+#define	MCDRV_PCMHIZ_LOW		0
+#define	MCDRV_PCMHIZ_HIZ		1
+
+/*	mcdrv_dev_info paX_func setting	*/
+#define	MCDRV_PA_GPIO			false
+#define	MCDRV_PA_PDMCK			true
+#define	MCDRV_PA_PDMDI			true
+
+/*	mcdrv_dev_info power_mode setting	*/
+#define	MCDRV_POWMODE_FULL		0
+#define	MCDRV_POWMODE_CDSPDEBUG		255
+
+/*	mcdrv_dev_info mb_sel setting	*/
+#define	MCDRV_MBSEL_20			0
+#define	MCDRV_MBSEL_21			1
+#define	MCDRV_MBSEL_22			2
+#define	MCDRV_MBSEL_23			3
+#define	MCDRV_MBSEL_LAST		MCDRV_MBSEL_23
+
+/*	mcdrv_dev_info mbs_disch setting	*/
+#define	MCDRV_MBSDISCH_0000		0
+#define	MCDRV_MBSDISCH_0001		1
+#define	MCDRV_MBSDISCH_0010		2
+#define	MCDRV_MBSDISCH_0011		3
+#define	MCDRV_MBSDISCH_0100		4
+#define	MCDRV_MBSDISCH_0101		5
+#define	MCDRV_MBSDISCH_0110		6
+#define	MCDRV_MBSDISCH_0111		7
+#define	MCDRV_MBSDISCH_1000		8
+#define	MCDRV_MBSDISCH_1001		9
+#define	MCDRV_MBSDISCH_1010		10
+#define	MCDRV_MBSDISCH_1011		11
+#define	MCDRV_MBSDISCH_1100		12
+#define	MCDRV_MBSDISCH_1101		13
+#define	MCDRV_MBSDISCH_1110		14
+#define	MCDRV_MBSDISCH_1111		15
+#define	MCDRV_MBSDISCH_LAST		MCDRV_MBSDISCH_1111
+
+/*	mcdrv_dev_info nonclip setting	*/
+#define	MCDRV_NONCLIP_OFF		false
+#define	MCDRV_NONCLIP_ON		true
+
+/*	mcdrv_dev_info line_*_dif setting	*/
+#define	MCDRV_LINE_STEREO		false
+#define	MCDRV_LINE_DIF			true
+
+/*	mcdrv_dev_info micX_single setting	*/
+#define	MCDRV_MIC_DIF			false
+#define	MCDRV_MIC_SINGLE		true
+
+/*	mcdrv_dev_info zc_line_outX/zc_rc/zc_sp/zc_hp setting	*/
+#define	MCDRV_ZC_ON			false
+#define	MCDRV_ZC_OFF			true
+
+/*	mcdrv_dev_info svol_line_outX/svol_rc/svol_sp/svol_hp setting	*/
+#define	MCDRV_SVOL_OFF			false
+#define	MCDRV_SVOL_ON			true
+
+/*	mcdrv_dev_info rc_hiz setting	*/
+#define	MCDRV_RCIMP_FIXLOW		0
+#define	MCDRV_RCIMP_WL			1
+
+/*	mcdrv_dev_info sp_hiz setting	*/
+#define	MCDRV_WL_LOFF_ROFF		0
+#define	MCDRV_WL_LON_ROFF		1
+#define	MCDRV_WL_LOFF_RON		2
+#define	MCDRV_WL_LON_RON		3
+#define	MCDRV_WL_LAST			MCDRV_WL_LON_RON
+
+/*	mcdrv_dev_info hp_hiz/line_outX_hiz setting	*/
+#define	MCDRV_IMP_LFIXLOW_RFIXLOW	0
+#define	MCDRV_IMP_LWL_RFIXLOW		1
+#define	MCDRV_IMP_LFIXLOW_RWL		2
+#define	MCDRV_IMP_LWL_RWL		3
+#define	MCDRV_IMP_LAST			MCDRV_IMP_LWL_RWL
+
+/*	mcdrv_dev_info cp_mod setting	*/
+#define	MCDRV_CPMOD_HI			0
+#define	MCDRV_CPMOD_MID			1
+
+/*	mcdrv_dev_info rb_sel setting	*/
+#define	MCDRV_RBSEL_2_2K		0
+#define	MCDRV_RBSEL_50			1
+
+/*	mcdrv_dev_info plug_sel setting	*/
+#define	MCDRV_PLUG_LRGM			0
+#define	MCDRV_PLUG_LRMG			1
+
+/*	mcdrv_dev_info gnd_det setting	*/
+#define	MCDRV_GNDDET_OFF		0
+#define	MCDRV_GNDDET_ON			1
+
+/*	mcdrv_dev_info ppd_* setting	*/
+#define	MCDRV_PPD_OFF			0
+#define	MCDRV_PPD_ON			1
+
+/*	mcdrv_dev_info option[0] setting	*/
+#define MCDRV_DOA_DRV_LOW		0
+#define MCDRV_DOA_DRV_HIGH		1
+#define MCDRV_DOA_DRV_LAST		MCDRV_DOA_DRV_HIGH
+
+/*	mcdrv_dev_info option[1] setting	*/
+#define MCDRV_SCKMSK_OFF		0
+#define MCDRV_SCKMSK_ON			1
+#define MCDRV_SCKMSK_LAST		MCDRV_SCKMSK_ON
+
+/*	mcdrv_dev_info option[2] setting	*/
+#define MCDRV_SPMN_8_9_10		0
+#define MCDRV_SPMN_5_6_7		1
+#define MCDRV_SPMN_4_5_6		2
+#define MCDRV_SPMN_OFF_9		3
+#define MCDRV_SPMN_OFF_6		4
+#define MCDRV_SPMN_LAST			MCDRV_SPMN_OFF_6
+
+struct mcdrv_dev_info {
+	u8 clk_sel;
+	u8 clk_input;
+	u8 pll_mode_a;
+	u8 pll_prev_div_a;
+	u16 pll_fb_div_a;
+	u16 pll_frac_a;
+	bool pll_freq_a;
+	u8 pll_mode_b;
+	u8 pll_prev_div_b;
+	u16 pll_fb_div_b;
+	u16 pll_frac_b;
+	bool pll_freq_b;
+	bool hsdet_clk;
+	bool dio0_sdo_hiz;
+	bool dio1_sdo_hiz;
+	bool dio2_sdo_hiz;
+	bool dio0_clk_hiz;
+	bool dio1_clk_hiz;
+	bool dio2_clk_hiz;
+	bool dio0_pcm_hiz;
+	bool dio1_pcm_hiz;
+	bool dio2_pcm_hiz;
+	bool pa0_func;
+	bool pa1_func;
+	bool pa2_func;
+	u8 power_mode;
+	u8 mb_sel1;
+	u8 mb_sel2;
+	u8 mb_sel3;
+	u8 mb_sel4;
+	u8 mbs_disch;
+	bool nonclip;
+	bool line_in1_dif;
+	bool line_out1_dif;
+	bool line_out2_dif;
+	bool mic1_single;
+	bool mic2_single;
+	bool mic3_single;
+	bool mic4_single;
+	bool zc_line_out1;
+	bool zc_line_out2;
+	bool zc_rc;
+	bool zc_sp;
+	bool zc_hp;
+	bool svol_line_out1;
+	bool svol_line_out2;
+	bool svol_rc;
+	bool svol_sp;
+	bool svol_hp;
+	bool rc_hiz;
+	u8 sp_hiz;
+	u8 hp_hiz;
+	u8 line_out1_hiz;
+	u8 line_out2_hiz;
+	bool cp_mod;
+	bool rb_sel;
+	bool plug_sel;
+	bool gnd_det;
+	bool ppd_rc;
+	bool ppd_sp;
+	bool ppd_hp;
+	bool ppd_line_out1;
+	bool ppd_line_out2;
+	u8 options[20];
+	struct mcdrv_wait_time wait_time;
+};
+
+/*	set/get clock switch	*/
+#define	MCDRV_CLKSW_CLKA		0
+#define	MCDRV_CLKSW_CLKB		1
+
+/*	set/get path	*/
+#define	MCDRV_D1SRC_MUSICIN_ON		0x00000001
+#define	MCDRV_D1SRC_MUSICIN_OFF		0x00000002
+#define	MCDRV_D1SRC_EXTIN_ON		0x00000004
+#define	MCDRV_D1SRC_EXTIN_OFF		0x00000008
+#define	MCDRV_D1SRC_VBOXOUT_ON		0x00000010
+#define	MCDRV_D1SRC_VBOXOUT_OFF		0x00000020
+#define	MCDRV_D1SRC_VBOXREFOUT_ON	0x00000040
+#define	MCDRV_D1SRC_VBOXREFOUT_OFF	0x00000080
+#define	MCDRV_D1SRC_AE0_ON		0x00000100
+#define	MCDRV_D1SRC_AE0_OFF		0x00000200
+#define	MCDRV_D1SRC_AE1_ON		0x00000400
+#define	MCDRV_D1SRC_AE1_OFF		0x00000800
+#define	MCDRV_D1SRC_AE2_ON		0x00001000
+#define	MCDRV_D1SRC_AE2_OFF		0x00002000
+#define	MCDRV_D1SRC_AE3_ON		0x00004000
+#define	MCDRV_D1SRC_AE3_OFF		0x00008000
+#define MCDRV_D1SRC_AE_ALL_ON				\
+	(MCDRV_D1SRC_AE0_ON | MCDRV_D1SRC_AE1_ON |	\
+	 MCDRV_D1SRC_AE2_ON | MCDRV_D1SRC_AE3_ON)
+#define	MCDRV_D1SRC_ADIF0_ON		0x00010000
+#define	MCDRV_D1SRC_ADIF0_OFF		0x00020000
+#define	MCDRV_D1SRC_ADIF1_ON		0x00040000
+#define	MCDRV_D1SRC_ADIF1_OFF		0x00080000
+#define	MCDRV_D1SRC_ADIF2_ON		0x00100000
+#define	MCDRV_D1SRC_ADIF2_OFF		0x00200000
+#define	MCDRV_D1SRC_HIFIIN_ON		0x00400000
+#define	MCDRV_D1SRC_HIFIIN_OFF		0x00800000
+#define MCDRV_D1SRC_ALL_ON		0x00555555
+
+#define	MCDRV_D2SRC_VOICEIN_ON		0x00000001
+#define	MCDRV_D2SRC_VOICEIN_OFF		0x00000002
+#define	MCDRV_D2SRC_VBOXIOOUT_ON	0x00000004
+#define	MCDRV_D2SRC_VBOXIOOUT_OFF	0x00000008
+#define	MCDRV_D2SRC_VBOXHOSTOUT_ON	0x00000010
+#define	MCDRV_D2SRC_VBOXHOSTOUT_OFF	0x00000020
+#define	MCDRV_D2SRC_ADC0_L_ON		0x00000040
+#define	MCDRV_D2SRC_ADC0_L_OFF		0x00000080
+#define	MCDRV_D2SRC_ADC0_R_ON		0x00000100
+#define	MCDRV_D2SRC_ADC0_R_OFF		0x00000200
+#define	MCDRV_D2SRC_ADC0_ON	\
+	(MCDRV_D2SRC_ADC0_L_ON | MCDRV_D2SRC_ADC0_R_ON)
+#define	MCDRV_D2SRC_ADC0_OFF	\
+	(MCDRV_D2SRC_ADC0_L_OFF | MCDRV_D2SRC_ADC0_R_OFF)
+#define	MCDRV_D2SRC_ADC1_ON		0x00000400
+#define	MCDRV_D2SRC_ADC1_OFF		0x00000800
+#define	MCDRV_D2SRC_PDM0_L_ON		0x00001000
+#define	MCDRV_D2SRC_PDM0_L_OFF		0x00002000
+#define	MCDRV_D2SRC_PDM0_R_ON		0x00004000
+#define	MCDRV_D2SRC_PDM0_R_OFF		0x00008000
+#define MCDRV_D2SRC_PDM0_ON	\
+	(MCDRV_D2SRC_PDM0_L_ON | MCDRV_D2SRC_PDM0_R_ON)
+#define	MCDRV_D2SRC_PDM1_L_ON		0x00010000
+#define	MCDRV_D2SRC_PDM1_L_OFF		0x00020000
+#define	MCDRV_D2SRC_PDM1_R_ON		0x00040000
+#define	MCDRV_D2SRC_PDM1_R_OFF		0x00080000
+#define MCDRV_D2SRC_PDM1_ON	\
+	(MCDRV_D2SRC_PDM1_L_ON | MCDRV_D2SRC_PDM1_R_ON)
+#define	MCDRV_D2SRC_DAC0REF_ON		0x00100000
+#define	MCDRV_D2SRC_DAC0REF_OFF		0x00200000
+#define	MCDRV_D2SRC_DAC1REF_ON		0x00400000
+#define	MCDRV_D2SRC_DAC1REF_OFF		0x00800000
+
+#define	MCDRV_ASRC_DAC0_L_ON		0x00000001
+#define	MCDRV_ASRC_DAC0_L_OFF		0x00000002
+#define	MCDRV_ASRC_DAC0_R_ON		0x00000004
+#define	MCDRV_ASRC_DAC0_R_OFF		0x00000008
+#define	MCDRV_ASRC_DAC1_L_ON		0x00000010
+#define	MCDRV_ASRC_DAC1_L_OFF		0x00000020
+#define	MCDRV_ASRC_DAC1_R_ON		0x00000040
+#define	MCDRV_ASRC_DAC1_R_OFF		0x00000080
+#define	MCDRV_ASRC_MIC1_ON		0x00000100
+#define	MCDRV_ASRC_MIC1_OFF		0x00000200
+#define	MCDRV_ASRC_MIC2_ON		0x00000400
+#define	MCDRV_ASRC_MIC2_OFF		0x00000800
+#define	MCDRV_ASRC_MIC3_ON		0x00001000
+#define	MCDRV_ASRC_MIC3_OFF		0x00002000
+#define	MCDRV_ASRC_MIC4_ON		0x00004000
+#define	MCDRV_ASRC_MIC4_OFF		0x00008000
+#define MCDRV_ASRC_MIC_ALL_ON				\
+	(MCDRV_ASRC_MIC1_ON | MCDRV_ASRC_MIC2_ON |	\
+	 MCDRV_ASRC_MIC3_ON | MCDRV_ASRC_MIC4_ON)
+#define	MCDRV_ASRC_LINEIN1_L_ON		0x00010000
+#define	MCDRV_ASRC_LINEIN1_L_OFF	0x00020000
+#define	MCDRV_ASRC_LINEIN1_R_ON		0x00040000
+#define	MCDRV_ASRC_LINEIN1_R_OFF	0x00080000
+#define	MCDRV_ASRC_LINEIN1_M_ON		0x00100000
+#define	MCDRV_ASRC_LINEIN1_M_OFF	0x00200000
+#define MCDRV_ASRC_LINEIN1_ALL_ON				\
+	(MCDRV_ASRC_LINEIN1_L_ON | MCDRV_ASRC_LINEIN1_R_ON |	\
+	 MCDRV_ASRC_LINEIN1_M_ON)
+
+#define	MUSICOUT_PATH_CHANNELS		2
+#define	EXTOUT_PATH_CHANNELS		2
+#define	HIFIOUT_PATH_CHANNELS		1
+#define	VBOXMIXIN_PATH_CHANNELS		4
+#define	AE_PATH_CHANNELS		2
+#define	DAC0_PATH_CHANNELS		2
+#define	DAC1_PATH_CHANNELS		2
+#define	VOICEOUT_PATH_CHANNELS		1
+#define	VBOXIOIN_PATH_CHANNELS		1
+#define	VBOXHOSTIN_PATH_CHANNELS	1
+#define	HOSTOUT_PATH_CHANNELS		1
+#define	ADIF0_PATH_CHANNELS		2
+#define	ADIF1_PATH_CHANNELS		2
+#define	ADIF2_PATH_CHANNELS		2
+#define	ADC0_PATH_CHANNELS		2
+#define	ADC1_PATH_CHANNELS		1
+#define	SP_PATH_CHANNELS		2
+#define	HP_PATH_CHANNELS		2
+#define	RC_PATH_CHANNELS		1
+#define	LOUT1_PATH_CHANNELS		2
+#define	LOUT2_PATH_CHANNELS		2
+#define	BIAS_PATH_CHANNELS		4
+
+struct mcdrv_path_info {
+	u32 music_out[MUSICOUT_PATH_CHANNELS];
+	u32 ext_out[EXTOUT_PATH_CHANNELS];
+	u32 hifi_out[HIFIOUT_PATH_CHANNELS];
+	u32 vbox_mix_in[VBOXMIXIN_PATH_CHANNELS];
+	u32 ae0[AE_PATH_CHANNELS];
+	u32 ae1[AE_PATH_CHANNELS];
+	u32 ae2[AE_PATH_CHANNELS];
+	u32 ae3[AE_PATH_CHANNELS];
+	u32 dac0[DAC0_PATH_CHANNELS];
+	u32 dac1[DAC1_PATH_CHANNELS];
+	u32 voice_out[VOICEOUT_PATH_CHANNELS];
+	u32 vbox_io_in[VBOXIOIN_PATH_CHANNELS];
+	u32 vbox_host_in[VBOXHOSTIN_PATH_CHANNELS];
+	u32 host_out[HOSTOUT_PATH_CHANNELS];
+	u32 adif0[ADIF0_PATH_CHANNELS];
+	u32 adif1[ADIF1_PATH_CHANNELS];
+	u32 adif2[ADIF2_PATH_CHANNELS];
+	u32 adc0[ADC0_PATH_CHANNELS];
+	u32 adc1[ADC1_PATH_CHANNELS];
+	u32 sp[SP_PATH_CHANNELS];
+	u32 hp[HP_PATH_CHANNELS];
+	u32 rc[RC_PATH_CHANNELS];
+	u32 lout1[LOUT1_PATH_CHANNELS];
+	u32 lout2[LOUT2_PATH_CHANNELS];
+	u32 bias[BIAS_PATH_CHANNELS];
+};
+
+/*	set/get vol	*/
+#define	MCDRV_VOL_UPDATE		0x0001
+
+#define	MUSICIN_VOL_CHANNELS		2
+#define	EXTIN_VOL_CHANNELS		2
+#define	VOICEIN_VOL_CHANNELS		2
+#define	REFIN_VOL_CHANNELS		2
+#define	ADIF0IN_VOL_CHANNELS		2
+#define	ADIF1IN_VOL_CHANNELS		2
+#define	ADIF2IN_VOL_CHANNELS		2
+#define	MUSICOUT_VOL_CHANNELS		2
+#define	EXTOUT_VOL_CHANNELS		2
+#define	VOICEOUT_VOL_CHANNELS		2
+#define	REFOUT_VOL_CHANNELS		2
+#define	DAC0OUT_VOL_CHANNELS		2
+#define	DAC1OUT_VOL_CHANNELS		2
+#define	DPATH_VOL_CHANNELS		2
+#define	LINEIN1_VOL_CHANNELS		2
+#define	MIC1_VOL_CHANNELS		1
+#define	MIC2_VOL_CHANNELS		1
+#define	MIC3_VOL_CHANNELS		1
+#define	MIC4_VOL_CHANNELS		1
+#define	HP_VOL_CHANNELS			2
+#define	SP_VOL_CHANNELS			2
+#define	RC_VOL_CHANNELS			1
+#define	LINEOUT1_VOL_CHANNELS		2
+#define	LINEOUT2_VOL_CHANNELS		2
+#define	HPDET_VOL_CHANNELS		1
+
+struct mcdrv_vol_info {
+	s16 d_music_in[MUSICIN_VOL_CHANNELS];
+	s16 d_ext_in[EXTIN_VOL_CHANNELS];
+	s16 d_voice_in[VOICEIN_VOL_CHANNELS];
+	s16 d_ref_in[REFIN_VOL_CHANNELS];
+	s16 d_adif0_in[ADIF0IN_VOL_CHANNELS];
+	s16 d_adif1_in[ADIF1IN_VOL_CHANNELS];
+	s16 d_adif2_in[ADIF2IN_VOL_CHANNELS];
+	s16 d_music_out[MUSICOUT_VOL_CHANNELS];
+	s16 d_ext_out[EXTOUT_VOL_CHANNELS];
+	s16 d_voice_out[VOICEOUT_VOL_CHANNELS];
+	s16 d_ref_out[REFOUT_VOL_CHANNELS];
+	s16 d_dac0_out[DAC0OUT_VOL_CHANNELS];
+	s16 d_dac1_out[DAC1OUT_VOL_CHANNELS];
+	s16 d_dpath_da[DPATH_VOL_CHANNELS];
+	s16 d_dpath_ad[DPATH_VOL_CHANNELS];
+	s16 a_line_in1[LINEIN1_VOL_CHANNELS];
+	s16 a_mic1[MIC1_VOL_CHANNELS];
+	s16 a_mic2[MIC2_VOL_CHANNELS];
+	s16 a_mic3[MIC3_VOL_CHANNELS];
+	s16 a_mic4[MIC4_VOL_CHANNELS];
+	s16 a_hp[HP_VOL_CHANNELS];
+	s16 a_sp[SP_VOL_CHANNELS];
+	s16 a_rc[RC_VOL_CHANNELS];
+	s16 a_line_out1[LINEOUT1_VOL_CHANNELS];
+	s16 a_line_out2[LINEOUT2_VOL_CHANNELS];
+	s16 a_hp_det[HPDET_VOL_CHANNELS];
+};
+
+/*	set/get digitalio	*/
+#define	MCDRV_MUSIC_COM_UPDATE_FLAG	0x00000001U
+#define	MCDRV_MUSIC_DIR_UPDATE_FLAG	0x00000002U
+#define	MCDRV_MUSIC_DIT_UPDATE_FLAG	0x00000004U
+#define	MCDRV_EXT_COM_UPDATE_FLAG	0x00000008U
+#define	MCDRV_EXT_DIR_UPDATE_FLAG	0x00000010U
+#define	MCDRV_EXT_DIT_UPDATE_FLAG	0x00000020U
+#define	MCDRV_VOICE_COM_UPDATE_FLAG	0x00000040U
+#define	MCDRV_VOICE_DIR_UPDATE_FLAG	0x00000080U
+#define	MCDRV_VOICE_DIT_UPDATE_FLAG	0x00000100U
+#define	MCDRV_HIFI_COM_UPDATE_FLAG	0x00000200U
+#define	MCDRV_HIFI_DIR_UPDATE_FLAG	0x00000400U
+#define	MCDRV_HIFI_DIT_UPDATE_FLAG	0x00000800U
+#define	MCDRV_ALL_DIO_UPDATE_FLAG	0x00000fffU
+
+/*	mcdrv_dio_common master_slave setting	*/
+#define	MCDRV_DIO_SLAVE			0
+#define	MCDRV_DIO_MASTER		1
+
+/*	mcdrv_dio_common bDigitalAutoFs setting	*/
+#define	MCDRV_AUTOFS_OFF		0
+#define	MCDRV_AUTOFS_ON			1
+
+/*	mcdrv_dio_common fs setting	*/
+#define	MCDRV_FS_48000			0
+#define	MCDRV_FS_44100			1
+#define	MCDRV_FS_32000			2
+#define	MCDRV_FS_NONE1			3
+#define	MCDRV_FS_24000			4
+#define	MCDRV_FS_22050			5
+#define	MCDRV_FS_16000			6
+#define	MCDRV_FS_NONE2			7
+#define	MCDRV_FS_12000			8
+#define	MCDRV_FS_11025			9
+#define	MCDRV_FS_8000			10
+#define	MCDRV_FS_NONE3			11
+#define	MCDRV_FS_192000			12
+#define	MCDRV_FS_96000			13
+#define	MCDRV_FS_LAST			MCDRV_FS_96000
+
+/*	mcdrv_dio_common bck_fs setting	*/
+#define	MCDRV_BCKFS_64			0
+#define	MCDRV_BCKFS_48			1
+#define	MCDRV_BCKFS_32			2
+#define	MCDRV_BCKFS_NONE1		3
+#define	MCDRV_BCKFS_512			4
+#define	MCDRV_BCKFS_256			5
+#define	MCDRV_BCKFS_192			6
+#define	MCDRV_BCKFS_128			7
+#define	MCDRV_BCKFS_96			8
+#define	MCDRV_BCKFS_24			9
+#define	MCDRV_BCKFS_16			10
+#define	MCDRV_BCKFS_8			11
+#define	MCDRV_BCKFS_NONE2		12
+#define	MCDRV_BCKFS_NONE3		13
+#define	MCDRV_BCKFS_NONE4		14
+#define	MCDRV_BCKFS_SLAVE		15
+#define	MCDRV_BCKFS_LAST		MCDRV_BCKFS_SLAVE
+
+/*	mcdrv_dio_common interface setting	*/
+#define	MCDRV_DIO_DA			0
+#define	MCDRV_DIO_PCM			1
+
+/*	mcdrv_dio_common bck_invert setting	*/
+#define	MCDRV_BCLK_NORMAL		0
+#define	MCDRV_BCLK_INVERT		1
+
+/*	mcdrv_dio_common src_thru setting	*/
+#define	MCDRV_SRC_NOT_THRU		0
+#define	MCDRV_SRC_THRU			1
+
+/*	mcdrv_dio_common pcm_hiz_transition setting	*/
+#define	MCDRV_PCMHIZTRANS_FALLING	0
+#define	MCDRV_PCMHIZTRANS_RISING	1
+
+/*	mcdrv_dio_common pcm_frame setting	*/
+#define	MCDRV_PCM_SHORTFRAME		0
+#define	MCDRV_PCM_LONGFRAME		1
+
+struct mcdrv_dio_common {
+	bool master_slave;
+	bool auto_fs;
+	u8 fs;
+	u8 bck_fs;
+	bool interface;
+	bool bck_invert;
+	bool src_thru;
+	bool pcm_hiz_transition;
+	bool pcm_frame;
+	u8 pcm_high_period;
+};
+
+/*	mcdrv_da_format bit_sel setting	*/
+#define	MCDRV_BITSEL_16			0
+#define	MCDRV_BITSEL_20			1
+#define	MCDRV_BITSEL_24			2
+#define	MCDRV_BITSEL_32			3
+#define	MCDRV_BITSEL_LAST		MCDRV_BITSEL_32
+
+/*	mcdrv_da_format mode setting	*/
+#define	MCDRV_DAMODE_HEADALIGN		0
+#define	MCDRV_DAMODE_I2S		1
+#define	MCDRV_DAMODE_TAILALIGN		2
+#define	MCDRV_DAMODE_LAST		MCDRV_DAMODE_TAILALIGN
+
+struct mcdrv_da_format {
+	u8 bit_sel;
+	u8 mode;
+};
+
+/*	mcdrv_pcm_format mono setting	*/
+#define	MCDRV_PCM_STEREO		0
+#define	MCDRV_PCM_MONO			1
+
+/*	mcdrv_pcm_format order setting	*/
+#define	MCDRV_PCM_MSB_FIRST		0
+#define	MCDRV_PCM_LSB_FIRST		1
+
+/*	mcdrv_pcm_format law setting	*/
+#define	MCDRV_PCM_LINEAR		0
+#define	MCDRV_PCM_ALAW			1
+#define	MCDRV_PCM_MULAW			2
+#define	MCDRV_PCM_LAST			MCDRV_PCM_MULAW
+
+/*	mcdrv_pcm_format bit_sel setting	*/
+#define	MCDRV_PCM_BITSEL_8		0
+#define	MCDRV_PCM_BITSEL_16		1
+#define	MCDRV_PCM_BITSEL_24		2
+#define	MCDRV_PCM_BITSEL_LAST		MCDRV_PCM_BITSEL_24
+
+struct mcdrv_pcm_format {
+	bool mono;
+	bool order;
+	u8 law;
+	u8 bit_sel;
+};
+
+struct mcdrv_dio_dir {
+	struct mcdrv_da_format da_format;
+	struct mcdrv_pcm_format pcm_format;
+};
+
+/*	mcdrv_dio_dit st_mode setting	*/
+#define	MCDRV_STMODE_ZERO		0
+#define	MCDRV_STMODE_HOLD		1
+
+/*	mcdrv_dio_dit edge setting	*/
+#define	MCDRV_SDOUT_NORMAL		0
+#define	MCDRV_SDOUT_AHEAD		1
+
+struct mcdrv_dio_dit {
+	bool st_mode;
+	bool edge;
+	struct mcdrv_da_format da_format;
+	struct mcdrv_pcm_format pcm_format;
+};
+
+struct mcdrv_dio_port {
+	struct mcdrv_dio_common dio_common;
+	struct mcdrv_dio_dir dir;
+	struct mcdrv_dio_dit dit;
+};
+
+struct mcdrv_dio_info {
+	struct mcdrv_dio_port port[4];
+};
+
+/*	set/get digitalio_path	*/
+#define	MCDRV_PHYS0_UPDATE_FLAG		0x00000001U
+#define	MCDRV_PHYS1_UPDATE_FLAG		0x00000002U
+#define	MCDRV_PHYS2_UPDATE_FLAG		0x00000004U
+#define	MCDRV_PHYS3_UPDATE_FLAG		0x00000008U
+#define	MCDRV_MUSICNUM_UPDATE_FLAG	0x00000010U
+#define	MCDRV_DIR0SLOT_UPDATE_FLAG	0x00000020U
+#define	MCDRV_DIR1SLOT_UPDATE_FLAG	0x00000040U
+#define	MCDRV_DIR2SLOT_UPDATE_FLAG	0x00000080U
+#define	MCDRV_DIT0SLOT_UPDATE_FLAG	0x00000100U
+#define	MCDRV_DIT1SLOT_UPDATE_FLAG	0x00000200U
+#define	MCDRV_DIT2SLOT_UPDATE_FLAG	0x00000400U
+
+/*	mcdrv_dio_path_info phys_port setting	*/
+#define	MCDRV_PHYSPORT_DIO0		0
+#define	MCDRV_PHYSPORT_DIO1		1
+#define	MCDRV_PHYSPORT_DIO2		2
+#define	MCDRV_PHYSPORT_NONE		3
+#define	MCDRV_PHYSPORT_SLIM0		4
+#define	MCDRV_PHYSPORT_SLIM1		5
+#define	MCDRV_PHYSPORT_SLIM2		6
+#define	MCDRV_PHYSPORT_LAST		MCDRV_PHYSPORT_SLIM2
+
+/*	mcdrv_dio_path_info music_ch setting	*/
+#define	MCDRV_MUSIC_2CH			0
+#define	MCDRV_MUSIC_4CH			1
+#define	MCDRV_MUSIC_6CH			2
+#define	MCDRV_MUSIC_LAST		MCDRV_MUSIC_6CH
+
+struct mcdrv_dio_path_info {
+	u8 phys_port[4];
+	u8 music_ch;
+	u8 music_rslot[3];
+	u8 music_tslot[3];
+};
+
+/*	set/get swap	*/
+#define	MCDRV_SWAP_ADIF0_UPDATE_FLAG		0x00000001U
+#define	MCDRV_SWAP_ADIF1_UPDATE_FLAG		0x00000002U
+#define	MCDRV_SWAP_ADIF2_UPDATE_FLAG		0x00000004U
+#define	MCDRV_SWAP_DAC0_UPDATE_FLAG		0x00000008U
+#define	MCDRV_SWAP_DAC1_UPDATE_FLAG		0x00000010U
+#define	MCDRV_SWAP_MUSICIN0_UPDATE_FLAG		0x00000020U
+#define	MCDRV_SWAP_MUSICIN1_UPDATE_FLAG		0x00000040U
+#define	MCDRV_SWAP_MUSICIN2_UPDATE_FLAG		0x00000080U
+#define	MCDRV_SWAP_EXTIN_UPDATE_FLAG		0x00000100U
+#define	MCDRV_SWAP_VOICEIN_UPDATE_FLAG		0x00000200U
+#define	MCDRV_SWAP_HIFIIN_UPDATE_FLAG		0x00000400U
+#define	MCDRV_SWAP_MUSICOUT0_UPDATE_FLAG	0x00000800U
+#define	MCDRV_SWAP_MUSICOUT1_UPDATE_FLAG	0x00001000U
+#define	MCDRV_SWAP_MUSICOUT2_UPDATE_FLAG	0x00002000U
+#define	MCDRV_SWAP_EXTOUT_UPDATE_FLAG		0x00004000U
+#define	MCDRV_SWAP_VOICEOUT_UPDATE_FLAG		0x00008000U
+#define	MCDRV_SWAP_HIFIOUT_UPDATE_FLAG		0x00010000U
+#define	MCDRV_SWAP_ALL_UPDATE_FLAG		0x0001ffffU
+
+/*	mcdrv_swap_info adif/dac setting	*/
+#define	MCDRV_SWAP_NORMAL		0
+#define	MCDRV_SWAP_SWAP			1
+#define	MCDRV_SWAP_MUTE			2
+#define	MCDRV_SWAP_CENTER		3
+#define	MCDRV_SWAP_MIX			4
+#define	MCDRV_SWAP_MONOMIX		5
+#define	MCDRV_SWAP_BOTHL		6
+#define	MCDRV_SWAP_BOTHR		7
+#define	MCDRV_SWAP_LAST			MCDRV_SWAP_BOTHR
+
+/*	mcdrv_swap_info
+	music_in/ext_in/voice_in/hifi_in/music_out/ext_out/voice_out/hifi_out
+	setting	*/
+#define	MCDRV_SWSWAP_NORMAL		0
+#define	MCDRV_SWSWAP_BOTH1		1
+#define	MCDRV_SWSWAP_BOTH0		2
+#define	MCDRV_SWSWAP_SWAP		3
+#define	MCDRV_SWSWAP_LAST		MCDRV_SWSWAP_SWAP
+
+struct mcdrv_swap_info {
+	u8 adif0;
+	u8 adif1;
+	u8 adif2;
+	u8 dac0;
+	u8 dac1;
+	u8 music_in0;
+	u8 music_in1;
+	u8 music_in2;
+	u8 ext_in;
+	u8 voice_in;
+	u8 hifi_in;
+	u8 music_out0;
+	u8 music_out1;
+	u8 music_out2;
+	u8 ext_out;
+	u8 voice_out;
+	u8 hifi_out;
+};
+
+/*	get transition	*/
+#define	MCDRV_DSPTYPE_FDSP		0
+#define	MCDRV_DSPTYPE_BDSP		1
+
+/*	register dsp cb	*/
+#define	MCDRV_AE_EVT_STOP		1
+#define	MCDRV_AE_EVT_APPSTOP		2
+#define	MCDRV_AE_EVT_APPREQ		3
+#define	MCDRV_AE_EVT_COEFDONE		4
+#define	MCDRV_AE_EVT_ERROR		5
+#define	MCDRV_CDSP_EVT_ERROR		11
+#define	MCDRV_CDSP_EVT_PARAM		12
+#define	MCDRV_CDSP_ENV_END		13
+#define	MCDRV_CDSP_EVT_FIFO		14
+#define	MCDRV_EDSP_EVT_E2PARAM		21
+
+/*	set/get hsdet	*/
+#define	MCDRV_ENPLUGDET_UPDATE_FLAG	0x00000001U
+#define	MCDRV_ENPLUGDETDB_UPDATE_FLAG	0x00000002U
+#define	MCDRV_ENDLYKEYOFF_UPDATE_FLAG	0x00000004U
+#define	MCDRV_ENDLYKEYON_UPDATE_FLAG	0x00000008U
+#define	MCDRV_ENMICDET_UPDATE_FLAG	0x00000010U
+#define	MCDRV_ENKEYOFF_UPDATE_FLAG	0x00000020U
+#define	MCDRV_ENKEYON_UPDATE_FLAG	0x00000040U
+#define	MCDRV_HSDETDBNC_UPDATE_FLAG	0x00000080U
+#define	MCDRV_KEYOFFMTIM_UPDATE_FLAG	0x00000100U
+#define	MCDRV_KEYONMTIM_UPDATE_FLAG	0x00000200U
+#define	MCDRV_KEY0OFFDLYTIM_UPDATE_FLAG	0x00000400U
+#define	MCDRV_KEY1OFFDLYTIM_UPDATE_FLAG	0x00000800U
+#define	MCDRV_KEY2OFFDLYTIM_UPDATE_FLAG	0x00001000U
+#define	MCDRV_KEY0ONDLYTIM_UPDATE_FLAG	0x00002000U
+#define	MCDRV_KEY1ONDLYTIM_UPDATE_FLAG	0x00004000U
+#define	MCDRV_KEY2ONDLYTIM_UPDATE_FLAG	0x00008000U
+#define	MCDRV_KEY0ONDLYTIM2_UPDATE_FLAG	0x00010000U
+#define	MCDRV_KEY1ONDLYTIM2_UPDATE_FLAG	0x00020000U
+#define	MCDRV_KEY2ONDLYTIM2_UPDATE_FLAG	0x00040000U
+#define	MCDRV_IRQTYPE_UPDATE_FLAG	0x00080000U
+#define	MCDRV_DETINV_UPDATE_FLAG	0x00100000U
+#define	MCDRV_HSDETMODE_UPDATE_FLAG	0x00200000U
+#define	MCDRV_SPERIOD_UPDATE_FLAG	0x00400000U
+#define	MCDRV_LPERIOD_UPDATE_FLAG	0x00800000U
+#define	MCDRV_DBNCNUMPLUG_UPDATE_FLAG	0x01000000U
+#define	MCDRV_DBNCNUMMIC_UPDATE_FLAG	0x02000000U
+#define	MCDRV_DBNCNUMKEY_UPDATE_FLAG	0x04000000U
+#define	MCDRV_SGNL_UPDATE_FLAG		0x08000000U
+#define	MCDRV_IMPSEL_UPDATE_FLAG	0x10000000U
+#define	MCDRV_DLYIRQSTOP_UPDATE_FLAG	0x20000000U
+#define	MCDRV_CBFUNC_UPDATE_FLAG	0x40000000U
+
+/*	mcdrv_hsdet_info en_plug_det setting	*/
+#define	MCDRV_PLUGDET_DISABLE		0
+#define	MCDRV_PLUGDET_ENABLE		1
+
+/*	mcdrv_hsdet_info en_plug_det_db setting	*/
+#define	MCDRV_PLUGDETDB_DISABLE		0
+#define	MCDRV_PLUGDETDB_DET_ENABLE	1
+#define	MCDRV_PLUGDETDB_UNDET_ENABLE	2
+#define	MCDRV_PLUGDETDB_BOTH_ENABLE	3
+#define	MCDRV_PLUGDETDB_LAST		MCDRV_PLUGDETDB_BOTH_ENABLE
+
+/*	mcdrv_hsdet_info
+	en_dly_key_off/en_dly_key_on/en_key_off/en_key_on setting	*/
+#define	MCDRV_KEYEN_D_D_D		0
+#define	MCDRV_KEYEN_D_D_E		1
+#define	MCDRV_KEYEN_D_E_D		2
+#define	MCDRV_KEYEN_D_E_E		3
+#define	MCDRV_KEYEN_E_D_D		4
+#define	MCDRV_KEYEN_E_D_E		5
+#define	MCDRV_KEYEN_E_E_D		6
+#define	MCDRV_KEYEN_E_E_E		7
+#define	MCDRV_KEYEN_LAST		MCDRV_KEYEN_E_E_E
+
+/*	mcdrv_hsdet_info en_mic_det setting	*/
+#define	MCDRV_MICDET_DISABLE		0
+#define	MCDRV_MICDET_ENABLE		1
+
+/*	mcdrv_hsdet_info hs_det_dbnc setting	*/
+#define	MCDRV_DETDBNC_27		0
+#define	MCDRV_DETDBNC_55		1
+#define	MCDRV_DETDBNC_109		2
+#define	MCDRV_DETDBNC_219		3
+#define	MCDRV_DETDBNC_438		4
+#define	MCDRV_DETDBNC_875		5
+#define	MCDRV_DETDBNC_1313		6
+#define	MCDRV_DETDBNC_1750		7
+#define	MCDRV_DETDBNC_LAST		MCDRV_DETDBNC_1750
+
+/*	mcdrv_hsdet_info key_off_mtim setting	*/
+#define	MCDRV_KEYOFF_MTIM_63		0
+#define	MCDRV_KEYOFF_MTIM_16		1
+
+/*	mcdrv_hsdet_info key_on_mtim setting	*/
+#define	MCDRV_KEYON_MTIM_63		0
+#define	MCDRV_KEYON_MTIM_250		1
+
+/*	mcdrv_hsdet_info key_off_dly_tim setting	*/
+#define	MC_DRV_KEYOFFDLYTIM_MAX		15
+
+/*	mcdrv_hsdet_info key_on_dly_tim setting	*/
+#define	MC_DRV_KEYONDLYTIM_MAX		15
+
+/*	mcdrv_hsdet_info key_on_dly_tim2 setting	*/
+#define	MC_DRV_KEYONDLYTIM2_MAX		15
+
+/*	mcdrv_hsdet_info irq_type setting	*/
+#define	MCDRV_IRQTYPE_NORMAL		0
+#define	MCDRV_IRQTYPE_REF		1
+#define MCDRV_IRQTYPE_EX		2
+#define MCDRV_IRQTYPE_LAST		MCDRV_IRQTYPE_EX
+
+/*	mcdrv_hsdet_info det_in_inv setting	*/
+#define	MCDRV_DET_IN_NORMAL		0
+#define	MCDRV_DET_IN_INV		1
+#define MCDRV_DET_IN_NORMAL_NORMAL	4
+#define MCDRV_DET_IN_INV_NORMAL		5
+#define MCDRV_DET_IN_NORMAL_INV		6
+#define MCDRV_DET_IN_INV_INV		7
+#define MCDRV_DET_IN_LAST		MCDRV_DET_IN_INV_INV
+
+/*	mcdrv_hsdet_info hs_det_mode setting	*/
+#define	MCDRV_HSDET_MODE_DETIN_A	4
+#define	MCDRV_HSDET_MODE_DETIN_B	6
+
+/*	mcdrv_hsdet_info speriod setting	*/
+#define	MCDRV_SPERIOD_244		0
+#define	MCDRV_SPERIOD_488		1
+#define	MCDRV_SPERIOD_977		2
+#define	MCDRV_SPERIOD_1953		3
+#define	MCDRV_SPERIOD_3906		4
+#define	MCDRV_SPERIOD_7813		5
+#define	MCDRV_SPERIOD_15625		6
+#define	MCDRV_SPERIOD_31250		7
+#define	MCDRV_SPERIOD_LAST		MCDRV_SPERIOD_31250
+
+/*	mcdrv_hsdet_info lperiod setting	*/
+#define	MCDRV_LPERIOD_3906		0
+#define	MCDRV_LPERIOD_62500		1
+#define	MCDRV_LPERIOD_125000		2
+#define	MCDRV_LPERIOD_250000		3
+#define	MCDRV_LPERIOD_LAST		MCDRV_LPERIOD_250000
+
+/*	mcdrv_hsdet_info dbnc_num setting	*/
+#define	MCDRV_DBNC_NUM_2		0
+#define	MCDRV_DBNC_NUM_3		1
+#define	MCDRV_DBNC_NUM_4		2
+#define	MCDRV_DBNC_NUM_7		3
+#define	MCDRV_DBNC_NUM_LAST		MCDRV_DBNC_NUM_7
+
+/*	mcdrv_hsdet_info sgnl_period setting	*/
+#define	MCDRV_SGNLPERIOD_61		0
+#define	MCDRV_SGNLPERIOD_79		1
+#define	MCDRV_SGNLPERIOD_97		2
+#define	MCDRV_SGNLPERIOD_151		3
+#define	MCDRV_SGNLPERIOD_LAST		MCDRV_SGNLPERIOD_151
+
+/*	mcdrv_hsdet_info sgnl_num setting	*/
+#define	MCDRV_SGNLNUM_1			0
+#define	MCDRV_SGNLNUM_4			1
+#define	MCDRV_SGNLNUM_6			2
+#define	MCDRV_SGNLNUM_8			3
+#define	MCDRV_SGNLNUM_LAST		MCDRV_SGNLNUM_8
+#define MCDRV_SGNLNUM_NONE		0xff
+
+/*	mcdrv_hsdet_info sgnl_peak setting	*/
+#define	MCDRV_SGNLPEAK_500		0
+#define	MCDRV_SGNLPEAK_730		1
+#define	MCDRV_SGNLPEAK_960		2
+#define	MCDRV_SGNLPEAK_1182		3
+#define	MCDRV_SGNLPEAK_LAST		MCDRV_SGNLPEAK_1182
+
+/*	mcdrv_hsdet_info imp_sel setting	*/
+#define	MCDRV_IMPSEL_MOSTFREQ		0
+#define	MCDRV_IMPSEL_MIN		1
+
+/*	mcdrv_hsdet_info dly_irq_stop setting	*/
+#define	MCDRV_DLYIRQ_DONTCARE		0
+#define	MCDRV_DLYIRQ_STOP		1
+
+#define	MCDRV_HSDET_EVT_PLUGDET_DB_FLAG		0x00000001
+#define	MCDRV_HSDET_EVT_PLUGUNDET_DB_FLAG	0x00000002
+#define	MCDRV_HSDET_EVT_PLUGDET_FLAG		0x00000080
+#define	MCDRV_HSDET_EVT_DLYKEYON0_FLAG		0x00000100
+#define	MCDRV_HSDET_EVT_DLYKEYON1_FLAG		0x00000200
+#define	MCDRV_HSDET_EVT_DLYKEYON2_FLAG		0x00000400
+#define	MCDRV_HSDET_EVT_DLYKEYOFF0_FLAG		0x00000800
+#define	MCDRV_HSDET_EVT_DLYKEYOFF1_FLAG		0x00001000
+#define	MCDRV_HSDET_EVT_DLYKEYOFF2_FLAG		0x00002000
+#define	MCDRV_HSDET_EVT_KEYON0_FLAG		0x00010000
+#define	MCDRV_HSDET_EVT_KEYON1_FLAG		0x00020000
+#define	MCDRV_HSDET_EVT_KEYON2_FLAG		0x00040000
+#define	MCDRV_HSDET_EVT_KEYOFF0_FLAG		0x00080000
+#define	MCDRV_HSDET_EVT_KEYOFF1_FLAG		0x00100000
+#define	MCDRV_HSDET_EVT_KEYOFF2_FLAG		0x00200000
+#define	MCDRV_HSDET_EVT_MICDET_FLAG		0x00400000
+#define	MCDRV_HSDET_EVT_SENSEFIN_FLAG		0x80000000
+
+struct mcdrv_hsdet_res {
+	u8 key_cnt0;
+	u8 key_cnt1;
+	u8 key_cnt2;
+	u8 plug_rev;
+	u8 hp_imp_class;
+	u16 hp_imp;
+};
+
+typedef void (*callback_function) (u32 flags, struct mcdrv_hsdet_res *res);
+
+struct mcdrv_hsdet_info {
+	bool en_plug_det;
+	u8 en_plug_det_db;
+	u8 en_dly_key_off;
+	u8 en_dly_key_on;
+	bool en_mic_det;
+	u8 en_key_off;
+	u8 en_key_on;
+	u8 hs_det_dbnc;
+	bool key_off_mtim;
+	bool key_on_mtim;
+	u8 key0_off_dly_tim;
+	u8 key1_off_dly_tim;
+	u8 key2_off_dly_tim;
+	u8 key0_on_dly_tim;
+	u8 key1_on_dly_tim;
+	u8 key2_on_dly_tim;
+	u8 key0_on_dly_tim2;
+	u8 key1_on_dly_tim2;
+	u8 key2_on_dly_tim2;
+	u8 irq_type;
+	u8 plug_det_db_irq_type;
+	u8 plug_undet_db_irq_type;
+	u8 mic_det_irq_type;
+	u8 plug_det_irq_type;
+	u8 key0_on_irq_type;
+	u8 key1_on_irq_type;
+	u8 key2_on_irq_type;
+	u8 key0_off_irq_type;
+	u8 key1_off_irq_type;
+	u8 key2_off_irq_type;
+	u8 det_in_inv;
+	u8 hs_det_mode;
+	u8 speriod;
+	u8 lperiod;
+	u8 dbnc_num_plug;
+	u8 dbnc_num_mic;
+	u8 dbnc_num_key;
+	u8 sgnl_period;
+	u8 sgnl_num;
+	u8 sgnl_peak;
+	bool imp_sel;
+	bool dly_irq_stop;
+	callback_function cbfunc;
+};
+
+int mc_init(struct mcdrv_dev_info *info);
+int mc_term(void);
+int mc_do_irq(void);
+int mc_control(unsigned int cmd, unsigned long arg, unsigned int flags);
+int mc_version_id_get(void);
+
+#endif /* _MCDRIVER_H */
-- 
1.7.9.5
