From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] [RFC 10/13] Intel SST sound card vendor2 module
Date: Fri,  3 Jul 2009 11:53:44 +0530
Message-ID: <1246602224-11147-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 2837B1038D3
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 08:14:43 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@intel.com>, R Dharageswari <dharageswari.r@intel.com>, Harsha Priya <priya.harsha@intel.com>
List-Id: alsa-devel@alsa-project.org

This adds the support for vendor PMICs for widget control
and configurations. The MID platform supports three
different vendor implementation of PMIC.
The sound card, ie all analog components like DAC,
ADC, mixer settings are different for three vendors. This
patch implements these settings for one of the vendor.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
Signed-off-by: R Dharageswari <dharageswari.r@intel.com>

	new file:   sound/pci/sst/intelmid_v1_control.c
---
 sound/pci/sst/intelmid_v1_control.c |  637 +++++++++++++++++++++++++++++++++++
 1 files changed, 637 insertions(+), 0 deletions(-)
 create mode 100644 sound/pci/sst/intelmid_v1_control.c

diff --git a/sound/pci/sst/intelmid_v1_control.c b/sound/pci/sst/intelmid_v1_control.c
new file mode 100644
index 0000000..32c2c51
--- /dev/null
+++ b/sound/pci/sst/intelmid_v1_control.c
@@ -0,0 +1,637 @@
+/*
+ *  intelmid_v1_control.c - Intel SST Driver for audio engine
+ *
+ *  Copyright (C) 2008-09 Intel Corp
+ *  Authors:	Vinod Koul <vinod.koul@intel.com>
+ *  		Harsha Priya <priya.harsha@intel.com>
+ *  		R Dharageswari <dharageswari.r@intel.com>
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
+ *  This file contains the control operations of vendor 3
+ */
+
+#include <linux/cdev.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/syscalls.h>
+#include <linux/file.h>
+#include <linux/fcntl.h>
+#include <linux/uaccess.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include <linux/workqueue.h>
+#include <linux/pci.h>
+#include <linux/firmware.h>
+#include <sound/intel_sst.h>
+#include <sound/intel_sst_ioctl.h>
+#include "intel_sst_fw_ipc.h"
+#include "intel_sst_common.h"
+#include "intel_sst_pvt.h"
+#include "intelmid_snd_control.h"
+
+#include <asm/ipc_defs.h>
+enum _reg_v2 {
+
+	MASTER_CLOCK_PRESCALAR  = 0x205,
+	SET_MASTER_AND_LR_CLK1	= 0x20b,
+	SET_MASTER_AND_LR_CLK2	= 0x20c,
+	MASTER_MODE_AND_DATA_DELAY = 0x20d,
+	DIGITAL_INTERFACE_TO_DAI2 = 0x20e,
+	CLK_AND_FS1 = 0x208,
+	CLK_AND_FS2 = 0x209,
+	DAI2_TO_DAC_HP = 0x210,
+	HP_OP_SINGLE_ENDED = 0x224,
+	ENABLE_OPDEV_CTRL = 0x226,
+	ENABLE_DEV_AND_USE_XTAL = 0x227,
+
+	/* Max audio subsystem (PQ49) MAX 8921 */
+	AS_IP_MODE_CTL = 0xF9,
+	AS_LEFT_SPKR_VOL_CTL = 0xFA, /* Mono Earpiece volume control */
+	AS_RIGHT_SPKR_VOL_CTL = 0xFB,
+	AS_LEFT_HP_VOL_CTL = 0xFC,
+	AS_RIGHT_HP_VOL_CTL = 0xFD,
+	AS_OP_MIX_CTL = 0xFE,
+	AS_CONFIG = 0xFF,
+
+	/* Headphone volume control & mute registers */
+	VOL_CTRL_LT = 0x21c,
+	VOL_CTRL_RT = 0x21d,
+
+};
+
+/* Headphone volume control values in dB */
+int mx_hp_vol[MAX_HP_VOL_INDX_PMIC_VENDOR1] =
+{
+	(+6),
+	(+6),	/* +5.5,  commented as this is not an integer */
+	(+5),
+	(+5),     /* +4.5,  commented as this is not an integer */
+	(+4),
+	(+4),     /* +3.5,  commented as this is not an integer */
+	(+3),
+	(+2),
+	(+1),
+	0,
+	(-1),
+	(-2),
+	(-3),
+	(-4),
+	(-5),
+	(-6),
+	(-8),
+	(-10),
+	(-12),
+	(-14),
+	(-16),
+	(-18),
+	(-20),
+	(-22),
+	(-26),
+	(-30),
+	(-34),
+	(-38),
+	(-42),
+	(-46),
+	(-50),
+	(-54),
+	(-58),
+	(-62),
+	(-66),
+	(-70),
+	(-74),
+	(-78),
+	(-82),
+	(-84)
+}; /* mx_hp_vol[] */
+
+/* Mono Earpiece volume control values in dB */
+int mx_ep_vol[MAX_EP_VOL_INDX_PMIC_VENDOR1] =
+{
+	(-75),
+	(-71),
+	(-67),
+	(-63),
+	(-59),
+	(-55),
+	(-51),
+	(-47),
+	(-44),
+	(-41),
+	(-38),
+	(-35),
+	(-32),
+	(-29),
+	(-26),
+	(-23),
+	(-21),
+	(-19),
+	(-17),
+	(-15),
+	(-13),
+	(-11),
+	(-9),
+	(-7),
+	(-6),
+	(-5),
+	(-4),
+	(-3),
+	(-2),
+	(-1),
+	(0)
+}; /* mx_ep_vol[] */
+
+int mx_init_card(void)
+{
+
+	struct sc_reg_access sc_access[17] = {{0,},};
+	int retval = 0;
+	sst_dbg("mx initializing card...\n");
+
+	sc_access[0].reg_addr = MASTER_CLOCK_PRESCALAR;
+	sc_access[0].value = 0x10;
+	sc_access[1].reg_addr = SET_MASTER_AND_LR_CLK1;
+	sc_access[1].value = 0x60;
+	sc_access[2].reg_addr = SET_MASTER_AND_LR_CLK2;
+	sc_access[2].value = 0x00;
+	sc_access[3].reg_addr = MASTER_MODE_AND_DATA_DELAY ;
+	sc_access[3].value = 0x90;
+	sc_access[4].reg_addr = DIGITAL_INTERFACE_TO_DAI2;
+	sc_access[4].value = 0x51;
+	sc_access[5].reg_addr = CLK_AND_FS1;
+	sc_access[5].value = 0x90;
+	sc_access[6].reg_addr = CLK_AND_FS2;
+	sc_access[6].value = 0x51;/*Mx fix for 50Mhz*/
+	sc_access[7].reg_addr = DAI2_TO_DAC_HP;
+	sc_access[7].value = 0x21;
+	sc_access[8].reg_addr = VOL_CTRL_LT;
+	sc_access[8].value = 0x09;
+	sc_access[9].reg_addr = VOL_CTRL_RT;
+	sc_access[9].value = 0x00;
+	sc_access[10].reg_addr = HP_OP_SINGLE_ENDED;
+	sc_access[10].value = 0x04;
+	sc_access[11].reg_addr = ENABLE_OPDEV_CTRL;
+	sc_access[11].value = 0x0c;
+	sc_access[12].reg_addr = ENABLE_DEV_AND_USE_XTAL ;
+	sc_access[12].value = 0x88;
+	/* mono earpiece - default register configuration */
+	/* Input mode control - zero crossing detection
+		* enabled */
+	sc_access[13].reg_addr = AS_IP_MODE_CTL;
+	sc_access[13].value = 0x40;
+
+	/* Left speaker volume (Mono EP) (-6) dB */
+	sc_access[14].reg_addr = AS_LEFT_SPKR_VOL_CTL;
+	sc_access[14].value = 0x19;
+
+	/* output mixer -INA1 + INA2 enabled */
+	sc_access[15].reg_addr = AS_OP_MIX_CTL;
+	sc_access[15].value = 0x60;
+	/* configuration - Disable the audio subsytem (Max 8921) */
+	sc_access[16].reg_addr = AS_CONFIG;
+	sc_access[16].value = 0x00;
+
+	retval = sst_sc_reg_access(sc_access, PMIC_WRITE, 17);
+	if (0 != retval) {
+		sst_dbg("pmic communication failed \n");
+		return retval;
+	}
+
+	sst_dbg("mx Initilaisation complete!!\n");
+	return 0;
+}
+
+int mx_init_capture_card(void)
+{
+	return 0;
+}
+
+void mx_set_pcm_params(int sfreq, int word_size)
+{
+	int config1 = 0, config2 = 0;
+	int retval = 0;
+	struct sc_reg_access sc_access[4] = {{0,},};
+
+	switch (sfreq) {
+	case 8000:
+		config1 = 0x10;
+		config2 = 0x00;
+		break;
+	case 11025:
+		config1 = 0x16;
+		config2 = 0x0d;
+		break;
+	case 12000:
+		config1 = 0x18;
+		config2 = 0x00;
+		break;
+	case 16000:
+		config1 = 0x20;
+		config2 = 0x00;
+		break;
+	case 22050:
+		config1 = 0x2c;
+		config2 = 0x1a;
+		break;
+	case 24000:
+		config1 = 0x30;
+		config2 = 0x00;
+		break;
+	case 32000:
+		config1 = 0x40;
+		config2 = 0x00;
+		break;
+	case 44100:
+		config1 = 0x58;
+		config2 = 0x33;
+		break;
+	case 48000:
+		config1 = 0x60;
+		config2 = 0x00;
+		break;
+	}
+
+	sc_access[0].reg_addr =	SET_MASTER_AND_LR_CLK1;
+	sc_access[0].value = config1;
+	sc_access[1].reg_addr = SET_MASTER_AND_LR_CLK2;
+	sc_access[1].value = config2;
+	switch (word_size) {
+	case 16:
+		config1 = 0x51;
+		config2 = 0x31;
+		break;
+	case 24:
+		config1 = 0x52;
+		config2 = 0x32;
+		break;
+	}
+
+	sst_dbg("config1 = %x\n", config1);
+	sst_dbg("config2 = %x\n", config2);
+	sc_access[2].reg_addr = DIGITAL_INTERFACE_TO_DAI2;
+	sc_access[2].value = config1;
+	sc_access[3].reg_addr = CLK_AND_FS2;
+	sc_access[3].value = config2;
+	retval = sst_sc_reg_access(sc_access, PMIC_WRITE, 4);
+	if (0 != retval)
+		sst_dbg("pmic communication failed \n");
+	return;
+} /* mx_set_pcm_params */
+
+int mx_set_selected_output_dev(int dev_id)
+{
+	struct sc_reg_access sc_access[4] = {{0,},};
+	int retval = 0;
+
+	sst_dbg("mx_set_selected_input_dev dev_id:0x%x\n", dev_id);
+	switch (dev_id) {
+	case INTERNAL_SPKR:
+		break;
+
+	case STEREO_HEADPHONE:
+		/* Enable stereo headphones  - Begin */
+		/* Volume Left Un-Mute */
+		sc_access[0].reg_addr = VOL_CTRL_LT;
+		sc_access[0].value = 0x00;
+		sc_access[0].mask = MASK6;
+		/* Volume right Un-Mute */
+		sc_access[1].reg_addr = VOL_CTRL_RT;
+		sc_access[1].value = 0x00;
+		sc_access[1].mask = MASK6;
+		/* Enable stereo headphones  - End */
+
+		/* Disable Mono earpiece - Begin */
+		/* configuration - AS Disable */
+		sc_access[2].reg_addr = AS_CONFIG;
+		sc_access[2].value = 0x00;
+		sc_access[2].mask = MASK7;
+
+		/* Line output (L&R) Disable */
+		sc_access[3].reg_addr = ENABLE_OPDEV_CTRL;
+		sc_access[3].value = 0x00;
+		sc_access[3].mask = MASK4|MASK5;
+		retval = sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 4);
+		if (0 != retval)
+			return retval;
+		/* Disable Mono earpiece - End */
+		break;
+
+	case MONO_HS:
+		/* select mono earpiece - Begin */
+		/* configuration - AS enable, left speaker enable */
+		sc_access[0].reg_addr = AS_CONFIG;
+		sc_access[0].value = 0xA0;
+		sc_access[0].mask = (MASK5|MASK7);
+		/* Line output (L&R), DAC output (L&R) enable */
+		sc_access[1].reg_addr = ENABLE_OPDEV_CTRL;
+		sc_access[1].value = 0x3C;
+		sc_access[1].mask = (MASK2|MASK3|MASK4|MASK5);
+		retval = sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 2);
+		if (0 != retval)
+			return retval;
+		/* select mono earpiece -end */
+		break;
+	} /* switch (dev_id) */
+
+	return retval;
+} /* mx_set_selected_output_dev */
+
+int mx_set_selected_input_dev(int value)
+{
+	return 0;
+} /* mx_set_selected_input_dev */
+
+int mx_set_mute(int dev_id, int value)
+{
+	struct sc_reg_access sc_access[1] = {{0,},};
+	int retval = 0;
+
+	sst_dbg("mx_set_mute dev_id:0x%x , value:%d \n", dev_id, value);
+
+	/* MAD passes value:0 for mute, value:1 for unmute */
+	switch (dev_id) {
+	case PMIC_SND_INPUT_MUTE_LINE_IN:
+		break;
+
+	case PMIC_SND_INPUT_MUTE_MIC1:
+		break;
+
+	case PMIC_SND_INPUT_MUTE_MIC2:
+		break;
+
+	case PMIC_SND_INPUT_MUTE_DMIC:
+		break;
+
+	case PMIC_SND_LEFT_SPEAKER_MUTE:
+		break;
+
+	case PMIC_SND_RIGHT_SPEAKER_MUTE:
+		break;
+
+	case PMIC_SND_LEFT_HP_MUTE:
+		sc_access[0].reg_addr =	VOL_CTRL_LT;
+		if (value == MUTE)
+			sc_access[0].value = 0x40;
+		else
+			sc_access[0].value = 0x00;
+		sc_access[0].mask = MASK6;
+		retval = sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 1);
+		break;
+
+	case PMIC_SND_RIGHT_HP_MUTE:
+		sc_access[0].reg_addr = VOL_CTRL_RT;
+		if (value == MUTE)
+			sc_access[0].value = 0x40;
+		else
+			sc_access[0].value = 0x00;
+		sc_access[0].mask = MASK6;
+		retval = sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 1);
+		break;
+
+	case PMIC_SND_MONO_EARPIECE_MUTE:
+		sc_access[0].reg_addr = AS_LEFT_SPKR_VOL_CTL;
+		if (value == MUTE)
+			sc_access[0].value = 0x00;
+		else
+			sc_access[0].value = 0x19;
+		sc_access[0].mask = (MASK0|MASK1|MASK2|MASK3|MASK4);
+		retval = sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 1);
+		break;
+	} /* switch (dev_id) */
+
+	return retval;
+} /* mx_set_mute */
+
+int mx_set_vol(int dev_id, int value)
+{
+	struct sc_reg_access sc_access[1] = {{0,},};
+	int retval = 0, i;
+
+	sst_dbg("mx_set_vol dev_id:0x%x , value:%d \n", dev_id, value);
+	switch (dev_id) {
+	case PMIC_SND_INPUT_VOL_MIC1:
+	case PMIC_SND_INPUT_VOL_MIC2:
+		break;
+	case PMIC_SND_INPUT_VOL_DMIC:
+		break;
+	case PMIC_SND_LEFT_SPEAKER_VOL:
+		break;
+	case PMIC_SND_RIGHT_SPEAKER_VOL:
+		break;
+	case PMIC_SND_LEFT_HP_VOL:
+		for (i = 0; i < MAX_HP_VOL_INDX_PMIC_VENDOR1; i++) {
+			if (value >= mx_hp_vol[i]) {
+				sc_access[0].value = i;
+				break;  /* exit out of the for loop */
+			} /* if(value >= mx_hp_vol[i]) */
+
+		} /* for(i=0; i< MAX_HP_VOL_INDX_PMIC_VENDOR1; i++) */
+		sc_access[0].reg_addr = VOL_CTRL_LT;
+		sc_access[0].mask = (MASK0|MASK1|MASK2|MASK3|MASK4|MASK5);
+		break;
+	case PMIC_SND_RIGHT_HP_VOL:
+		for (i = 0; i < MAX_HP_VOL_INDX_PMIC_VENDOR1; i++) {
+			if (value >= mx_hp_vol[i]) {
+				sc_access[0].value = i;
+				break;  /* exit out of the for loop */
+			} /* if(value >= mx_hp_vol[i]) */
+		} /* for(i=0; i< MAX_HP_VOL_INDX_PMIC_VENDOR1; i++) */
+		sc_access[0].reg_addr = VOL_CTRL_RT;
+		sc_access[0].mask = (MASK0|MASK1|MASK2|MASK3|MASK4|MASK5);
+		break;
+	case PMIC_SND_MONO_EARPIECE_VOL:
+		for (i = 0; i < MAX_EP_VOL_INDX_PMIC_VENDOR1; i++) {
+			if (value <= mx_ep_vol[i]) {
+				sc_access[0].value = i;
+				break;  /* exit out of the for loop */
+			} /* if(value >= mx_ep_vol[i]) */
+		} /* for(i=0; i< MAX_EP_VOL_INDX_PMIC_VENDOR1; i++) */
+		sc_access[0].reg_addr = AS_LEFT_SPKR_VOL_CTL;
+		sc_access[0].mask = (MASK0|MASK1|MASK2|MASK3|MASK4);
+		break;
+	} /* switch (dev_id) */
+	retval = sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 1);
+	return retval;
+} /* mx_set_vol */
+
+
+int mx_get_selected_input_dev(int *value)
+{
+	return 0;
+} /* mx_get_selected_input_dev */
+
+int mx_get_selected_output_dev(int *value)
+{
+	struct sc_reg_access sc_access[1] = {{0,},};
+	int retval = 0, temp_value;
+
+	sc_access[0].reg_addr = AS_CONFIG;
+	retval = sst_sc_reg_access(sc_access, PMIC_READ, 1);
+	if (0 != retval) {
+		/*pmic communication fails*/
+		sst_err("pmic commn failed \n");
+		return retval;
+	}
+	temp_value = sc_access[0].value;
+	if (0 == temp_value)
+		/* Max 8921 is disabled hence Mono earpiece is disabled */
+		*value = STEREO_HEADPHONE;
+	else
+		*value = MONO_HS;
+	return 0;
+} /* mx_get_selected_output_dev */
+
+int mx_get_mute(int dev_id, int *value)
+{
+	struct sc_reg_access sc_access[1] = {{0,},};
+	int retval = 0, temp_value;
+
+	switch (dev_id) {
+	case PMIC_SND_INPUT_MUTE_LINE_IN:
+		break;
+
+	case PMIC_SND_INPUT_MUTE_MIC1:
+		break;
+
+	case PMIC_SND_INPUT_MUTE_MIC2:
+		break;
+
+	case PMIC_SND_INPUT_MUTE_DMIC:
+		break;
+
+	case PMIC_SND_LEFT_SPEAKER_MUTE:
+		break;
+
+	case PMIC_SND_RIGHT_SPEAKER_MUTE:
+		break;
+
+	case PMIC_SND_LEFT_HP_MUTE:
+		sc_access[0].reg_addr = VOL_CTRL_LT;
+		retval = sst_sc_reg_access(sc_access, PMIC_READ, 1);
+		if (0 != retval) {
+			/*pmic communication fails*/
+			sst_err("pmic commn failed \n");
+			return retval;
+		}
+		temp_value = sc_access[0].value & (MASK6);
+		if (0 == temp_value)
+			*value = UNMUTE;
+		else
+			*value = MUTE;
+		break;
+	case PMIC_SND_RIGHT_HP_MUTE:
+		sc_access[0].reg_addr = VOL_CTRL_RT;
+		retval = sst_sc_reg_access(sc_access, PMIC_READ, 1);
+		if (0 != retval) {
+			/*pmic communication fails*/
+			sst_err("pmic commn failed \n");
+			return retval;
+		}
+		temp_value = sc_access[0].value &
+				(MASK6);
+		if (0 == temp_value)
+			*value = UNMUTE;
+		else
+			*value = MUTE;
+		break;
+	case PMIC_SND_MONO_EARPIECE_MUTE:
+		sc_access[0].reg_addr =	AS_LEFT_SPKR_VOL_CTL;
+		retval = sst_sc_reg_access(sc_access, PMIC_READ, 1);
+		if (0 != retval) {
+			/*pmic communication fails*/
+			sst_err("pmic commn failed \n");
+			return retval;
+		}
+		temp_value = sc_access[0].value &
+			(MASK0|MASK1|MASK2|MASK3|MASK4);
+
+		if (0 == temp_value)
+			*value = UNMUTE;
+		else
+			*value = MUTE;
+		break;
+	} /* switch (dev_id) */
+
+	sst_dbg("dev id:0x%2x, :0x%2x \n", dev_id, *value);
+	return retval;
+} /* mx_get_mute */
+
+int mx_get_vol(int dev_id, int *value)
+{
+	struct sc_reg_access sc_access[1] = {{0,},};
+	int retval = 0, temp_value = 0;
+
+	switch (dev_id) {
+	case PMIC_SND_INPUT_VOL_MIC1:
+	case PMIC_SND_INPUT_VOL_MIC2:
+		break;
+	case PMIC_SND_INPUT_VOL_DMIC:
+		break;
+	case PMIC_SND_LEFT_SPEAKER_VOL:
+		break;
+	case PMIC_SND_RIGHT_SPEAKER_VOL:
+		break;
+	case PMIC_SND_LEFT_HP_VOL:
+		sc_access[0].reg_addr = VOL_CTRL_LT;
+		retval = sst_sc_reg_access(sc_access, PMIC_READ, 1);
+		if (0 != retval) {
+			/*pmic communication fails*/
+			sst_err("pmic commn failed \n");
+			return retval;
+		}
+		temp_value = sc_access[0].value
+			& (MASK0|MASK1|MASK2|MASK3|MASK4|MASK5);
+		*value = mx_hp_vol[temp_value];
+		break;
+	case PMIC_SND_RIGHT_HP_VOL:
+		sc_access[0].reg_addr = VOL_CTRL_RT;
+		retval = sst_sc_reg_access(sc_access, PMIC_READ, 1);
+		if (0 != retval) {
+			/*pmic communication fails*/
+			sst_err("pmic commn failed \n");
+			return retval;
+		}
+		temp_value = sc_access[0].value
+			& (MASK0|MASK1|MASK2|MASK3|MASK4|MASK5);
+		*value = mx_hp_vol[temp_value];
+		break;
+	case PMIC_SND_MONO_EARPIECE_VOL:
+		sc_access[0].reg_addr = AS_LEFT_SPKR_VOL_CTL;
+		retval = sst_sc_reg_access(sc_access, PMIC_READ, 1);
+		if (0 != retval) {
+			/*pmic communication fails*/
+			sst_err("pmic commn failed \n");
+			return retval;
+		}
+		temp_value = sc_access[0].value
+			& (MASK0|MASK1|MASK2|MASK3|MASK4);
+		*value = mx_ep_vol[temp_value];
+		break;
+	} /* switch (dev_id) */
+
+	sst_dbg("value read from the register:0x%2x\n", temp_value);
+	sst_dbg("dev_id:0x%2x , volume:0x%2x in dB\n", dev_id, *value);
+
+	return retval;
+} /* mx_get_vol() */
+
+
+
-- 
1.5.4.5
