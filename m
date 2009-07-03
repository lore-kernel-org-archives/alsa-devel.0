From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] [RFC 9/13] Intel SST sound card vendor0 module
Date: Fri,  3 Jul 2009 11:53:21 +0530
Message-ID: <1246602201-10757-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id A3F551038B8
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 08:14:23 +0200 (CEST)
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

	new file:   sound/pci/sst/intelmid_v0_control.c
---
 sound/pci/sst/intelmid_v0_control.c |  529 +++++++++++++++++++++++++++++++++++
 1 files changed, 529 insertions(+), 0 deletions(-)
 create mode 100644 sound/pci/sst/intelmid_v0_control.c

diff --git a/sound/pci/sst/intelmid_v0_control.c b/sound/pci/sst/intelmid_v0_control.c
new file mode 100644
index 0000000..cbab23a
--- /dev/null
+++ b/sound/pci/sst/intelmid_v0_control.c
@@ -0,0 +1,529 @@
+/*
+ *  intelmid_v0_control.c - Intel SST Driver for audio engine
+ *
+ *  Copyright (C) 2008-09 	Intel Corporation
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
+ *  This file contains the control operations of vendor 1
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
+#include <asm/ipc_defs.h>
+
+enum _reg_v1 {
+	VOICEPORT1 = 0x180,
+	VOICEPORT2 = 0x181,
+	AUDIOPORT1 = 0x182,
+	AUDIOPORT2 = 0x183,
+	MISCVOICECTRL = 0x184,
+	MISCAUDCTRL = 0x185,
+	DMICCTRL1 = 0x186,
+	DMICCTRL2 = 0x187,
+	MICCTRL = 0x188,
+	MICLICTRL1 = 0x189,
+	MICLICTRL2 = 0x18A,
+	MICLICTRL3 = 0x18B,
+	VOICEDACCTRL1 = 0x18C,
+	STEREOADCCTRL = 0x18D,
+	AUD15 = 0x18E,
+	AUD16 = 0x18F,
+	AUD17 = 0x190,
+	AUD18 = 0x191,
+	RMIXOUTSEL = 0x192,
+	ANALOGLBR = 0x193,
+	ANALOGLBL = 0x194,
+	AUD22 = 0x195,
+	POWERCTRL2 = 0x196,
+	HEADSETDETECTINT = 0x197,
+	HEADSETDETECTINTMASK = 0x198,
+	TRIMENABLE = 0x199,
+};
+
+int rev_id = 0x20;
+
+int fs_init_card(void)
+{
+
+	struct sc_reg_access sc_access[17] = {{0,},};
+	int retval = 0;
+
+	sst_dbg("FS-B0 initializing card...\n");
+
+	/*send message to SCU to get the PMIC vendor-*/
+	sc_access[0].reg_addr = 0;
+	retval = sst_sc_reg_access(sc_access, PMIC_READ, 1);
+	if (0 != retval) {
+		/*pmic communication fails*/
+		sst_err("pmic commn failed \n");
+		return retval;
+	}
+	rev_id = sc_access[0].value;
+	sst_dbg("value of reg 0:0x%02x \n", rev_id);
+
+
+	sc_access[0].reg_addr  =  0x184;
+	sc_access[0].value = 0x1c;
+	sc_access[1].reg_addr  =  0x185;
+	if (rev_id == 0x20)
+		sc_access[1].value = 0x4A;/*FS-B0*/
+	else
+		sc_access[1].value = 0x48;
+
+	sc_access[2].reg_addr = 0x187 ;
+	sc_access[2].value = 0x39;
+	sc_access[3].reg_addr = 0x196 ;
+	sc_access[3].value = 0x7F;
+	sc_access[4].reg_addr = 0x180;
+	sc_access[4].value = 0xF5;
+	sc_access[5].reg_addr = 0x181;
+	sc_access[5].value = 0x26;
+	sc_access[6].reg_addr = 0x182;
+	if (rev_id == 0x20)
+		sc_access[6].value = 0xE8;/*FS-B0*/
+	else
+		sc_access[6].value = 0xD8;
+	sc_access[7].reg_addr  = 0x183;
+	sc_access[7].value = 0x19;
+	sc_access[8].reg_addr  = 0x186;
+	sc_access[8].value = 0x79;
+	sc_access[9].reg_addr  = 0x189;
+	sc_access[9].value = 0xB9;
+	sc_access[10].reg_addr  = 0x18a;
+	sc_access[10].value = 0xB9;
+	sc_access[11].reg_addr  = 0x18e;
+	sc_access[11].value = 0x39;
+	sc_access[12].reg_addr  = 0x18f;
+	sc_access[12].value = 0x39;
+	sc_access[13].reg_addr  = 0x190;
+	sc_access[13].value = 0x39;
+	sc_access[14].reg_addr  = 0x191;
+	sc_access[14].value = 0x11;
+	sc_access[15].reg_addr  = 0x192;
+	sc_access[15].value = 0x0E;
+	sc_access[16].reg_addr  = 0x195;
+	sc_access[16].value = 0x06;
+
+	retval = sst_sc_reg_access(sc_access, PMIC_WRITE, 17);
+	if (0 != retval) {
+		/*pmic communication fails*/
+		sst_err("pmic commn failed \n");
+		return retval;
+	}
+
+	sst_dbg("Initialisation complete!!\n");
+	return 0;
+}
+
+
+int fs_init_capture_card(void)
+{
+	return 0;
+}
+
+void fs_set_pcm_params(int sfreq, int word_size)
+{
+	int config1 = 0, retval = 0;
+	struct sc_reg_access sc_access[2];
+
+	switch (sfreq) {
+	case 8000:
+		config1 = 0x10;
+		break;
+	case 11025:
+		config1 = 0x11;
+		break;
+	case 12000:
+		config1 = 0x12;
+		break;
+	case 16000:
+		config1 = 0x13;
+		break;
+	case 22050:
+		config1 = 0x14;
+		break;
+	case 24000:
+		config1 = 0x15;
+		break;
+	case 26000:
+		config1 = 0x16;
+		break;
+	case 32000:
+		config1 = 0x17;
+		break;
+	case 44100:
+		config1 = 0x18;
+		break;
+	case 48000:
+		config1 = 0x19;
+		break;
+	}
+
+	sst_dbg("sfreq:%d, Register value = %x\n", sfreq, config1);
+
+	sc_access[0].reg_addr  = AUDIOPORT2;
+	sc_access[0].value = config1;
+
+	sst_dbg("Setting word size ...\n");
+	switch (word_size) {
+	case 16:
+		if (rev_id == 0x20)
+			config1 = 0xE8; /* FS B0 */
+		else
+			config1 = 0xD8; /* FS A0 */
+		break;
+	case 24:
+		if (rev_id == 0x20)
+			config1 = 0xEB; /* FS B0 */
+		else
+			config1 = 0xDB; /* FS A0 */
+		break;
+	} /* switch (word_size) */
+
+	sst_dbg("rev_id:0x%2x, pcm_wd_sz:%d, Register_value= %x\n",
+			rev_id, word_size, config1);
+
+	sc_access[1].reg_addr  = AUDIOPORT1;
+	sc_access[1].value = config1;
+	retval = sst_sc_reg_access(sc_access, PMIC_WRITE, 2);
+	if (0 != retval)
+		sst_err("pmic commn failed \n");
+	return;
+}
+
+int fs_set_selected_input_dev(int value)
+{
+
+	return 0;
+}
+
+int fs_set_selected_output_dev(int value)
+{
+	struct sc_reg_access sc_access[2];
+	int retval = 0;
+
+	sc_access[0].reg_addr = AUD22;
+	sc_access[0].mask = MASK6|MASK7|MASK4|MASK3|MASK2|MASK1|MASK0;
+
+	switch (value) {
+	case STEREO_HEADPHONE:
+		sc_access[0].value = VALUE2|VALUE1;
+		sc_access[0].mask = MASK2|MASK1;
+		sc_access[1].reg_addr = 0x192;
+		sc_access[1].mask = MASK2;
+		sc_access[1].value = 1;
+		break;
+
+	case INTERNAL_SPKR:
+		break;
+
+	case MONO_HS:
+		sc_access[0].value = VALUE7;
+		sc_access[0].mask = MASK7;
+		sc_access[1].reg_addr = 0x192;
+		sc_access[1].mask = MASK2;
+		sc_access[1].value = 0;
+		break;
+	}
+	sst_dbg("dev_id:0x%2x reg:0x%2x value:0x%2x\n",
+		value, sc_access[0].reg_addr, sc_access[0].value);
+	retval = sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 2);
+	if (0 != retval)
+		sst_err("pmic commn failed \n");
+
+	return retval;
+}
+
+int fs_set_mute(int dev_id, int value)
+{
+	struct sc_reg_access sc_access[1] = {{0,},};
+	int retval = 0;
+
+	sst_dbg("dev_id:0x%2x value:0x%2x", dev_id, value);
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
+	case PMIC_SND_LEFT_HP_MUTE:
+		sc_access[0].reg_addr = AUD18;
+		sc_access[0].mask = MASK2;
+		if (value == MUTE)
+			sc_access[0].value = VALUE2;
+		else
+			sc_access[0].value = 0x00;
+		break;
+
+	case PMIC_SND_LEFT_SPEAKER_MUTE:
+		break;
+
+	case PMIC_SND_RIGHT_SPEAKER_MUTE:
+		break;
+
+	case PMIC_SND_RIGHT_HP_MUTE:
+		sc_access[0].reg_addr = AUD18;
+		sc_access[0].mask = MASK1;
+		if (value == MUTE)
+			sc_access[0].value = VALUE1;
+		else
+			sc_access[0].value = 0x00;
+		break;
+
+
+	case PMIC_SND_MONO_EARPIECE_MUTE:
+		sc_access[0].reg_addr = AUD18;
+		sc_access[0].mask = MASK0;
+		if (value == MUTE)
+			sc_access[0].value = VALUE0;
+		else
+			sc_access[0].value = 0x00;
+		break;
+	default:
+		sst_err("rcvd illegal request");
+		/*Illegal case*/
+		return -EINVAL;
+	}
+
+	sst_dbg("dev_id:0x%02x arg_value:%d reg:0x%02x value:0x%02x\n", dev_id,
+		value, sc_access[0].reg_addr, sc_access[0].value);
+
+	retval = sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 1);
+	if (0 != retval)
+		sst_err("pmic commn failed \n");
+
+	return retval;
+}
+
+int fs_set_vol(int dev_id, int value)
+{
+	struct sc_reg_access sc_access[2] = {{0,},};
+	int retval = 0;
+
+	switch (dev_id) {
+	case PMIC_SND_INPUT_VOL_MIC1:
+		break;
+
+	case PMIC_SND_INPUT_VOL_MIC2:
+		break;
+
+	case PMIC_SND_INPUT_VOL_DMIC:
+		break;
+
+	case PMIC_SND_INPUT_VOL_RIGHT_LINE_IN:
+		break;
+
+	case PMIC_SND_INPUT_VOL_LEFT_LINE_IN:
+		break;
+
+	case PMIC_SND_LEFT_SPEAKER_VOL:
+		break;
+
+	case PMIC_SND_RIGHT_SPEAKER_VOL:
+		break;
+
+	case PMIC_SND_MONO_EARPIECE_VOL:
+		sc_access[0].reg_addr = AUD16;
+		sc_access[0].mask = MASK5|MASK4|MASK3|MASK2|MASK1|MASK0;
+		sc_access[0].value = (value - MIN_VOL_PMIC_VENDOR0);
+		sc_access[1].reg_addr = AUD17;
+		sc_access[1].mask = MASK5|MASK4|MASK3|MASK2|MASK1|MASK0;
+		sc_access[1].value = (value - MIN_VOL_PMIC_VENDOR0);
+
+		sst_dbg("dev_id:0x%02x arg_value:%d reg:0x%02x value:0x%02x\n",
+			dev_id, value, sc_access[0].reg_addr,
+			sc_access[0].value);
+		sst_dbg("reg2:0x%02x value2:0x%02x\n",
+				sc_access[1].reg_addr, sc_access[1].value);
+		retval = sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 2);
+		if (0 != retval)
+			sst_err("pmic commn failed \n");
+		return retval;
+
+	case PMIC_SND_LEFT_HP_VOL:
+		sc_access[0].reg_addr = AUD16;
+		sc_access[0].mask = MASK5|MASK4|MASK3|MASK2|MASK1|MASK0;
+		sc_access[0].value = (value - MIN_VOL_PMIC_VENDOR0);
+		break;
+
+	case PMIC_SND_RIGHT_HP_VOL:
+		sc_access[0].reg_addr = AUD17;
+		sc_access[0].mask = MASK5|MASK4|MASK3|MASK2|MASK1|MASK0;
+		sc_access[0].value = (value - MIN_VOL_PMIC_VENDOR0);
+		break;
+
+	default:
+		sst_err("rcvd illegal request");
+		/*Illegal case*/
+		return -EINVAL;
+	}
+
+	sst_dbg("dev_id:0x%2x arg_value:%d reg:0x%2x value:0x%2x\n", dev_id,
+		value, sc_access[0].reg_addr, sc_access[0].value);
+
+	retval = sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, 1);
+	if (0 != retval)
+		sst_err("pmic commn failed \n");
+	return retval;
+}
+
+int fs_get_selected_input_dev(int *value)
+{
+	return 0;
+}
+
+int fs_get_selected_output_dev(int *value)
+{
+	return 0;
+}
+
+int fs_get_mute(int dev_id, int *value)
+{
+	struct sc_reg_access sc_access[1] = {{0,},};
+
+	int retval = 0, temp_value = 0, mask = 0;
+
+	switch (dev_id) {
+	case PMIC_SND_INPUT_MUTE_LINE_IN:
+		break;
+	case PMIC_SND_INPUT_MUTE_MIC1:
+		break;
+	case PMIC_SND_INPUT_MUTE_MIC2:
+		break;
+	case PMIC_SND_INPUT_MUTE_DMIC:
+		break;
+	case PMIC_SND_LEFT_SPEAKER_MUTE:
+		break;
+	case PMIC_SND_RIGHT_SPEAKER_MUTE:
+		break;
+	case PMIC_SND_LEFT_HP_MUTE:
+		mask = MASK2;
+		break;
+	case PMIC_SND_RIGHT_HP_MUTE:
+		mask = MASK1;
+		break;
+	case PMIC_SND_MONO_EARPIECE_MUTE:
+		mask = MASK0;
+		break;
+	/*line out mute not supported*/
+	default:
+		sst_err("rcvd illegal request");
+		/*Illegal case*/
+		return -EINVAL;
+	}
+	sc_access[0].reg_addr = AUD18;
+
+	retval = sst_sc_reg_access(sc_access, PMIC_READ, 1);
+	if (0 != retval) {
+		sst_err("pmic commn failed \n");
+		return retval;
+	}
+	temp_value = sc_access[0].value & mask;
+	if (0 == temp_value)
+		*value = UNMUTE;
+	else
+		*value = MUTE;
+	return retval;
+}
+
+int fs_get_vol(int dev_id, int *value)
+{
+	struct sc_reg_access sc_access[2] = {{0,},};
+	int retval = 0, mask = 0, temp_value = 0;
+
+	switch (dev_id) {
+	case PMIC_SND_INPUT_VOL_MIC1:
+		break;
+
+	case PMIC_SND_INPUT_VOL_MIC2:
+		break;
+
+	case PMIC_SND_INPUT_VOL_DMIC:
+		break;
+
+	case PMIC_SND_INPUT_VOL_RIGHT_LINE_IN:
+		break;
+
+	case PMIC_SND_INPUT_VOL_LEFT_LINE_IN:
+		break;
+
+	case PMIC_SND_LEFT_SPEAKER_VOL:
+		break;
+
+	case PMIC_SND_RIGHT_SPEAKER_VOL:
+		break;
+
+	case PMIC_SND_LEFT_HP_VOL:
+		sc_access[0].reg_addr = AUD16;
+		mask = (MASK5|MASK4|MASK3|MASK2|MASK1|MASK0);
+		break;
+	case PMIC_SND_RIGHT_HP_VOL:
+		sc_access[0].reg_addr = AUD17;
+		mask = (MASK5|MASK4|MASK3|MASK2|MASK1|MASK0);
+		break;
+	case PMIC_SND_MONO_EARPIECE_VOL:
+		sc_access[0].reg_addr = AUD17;
+		mask = (MASK5|MASK4|MASK3|MASK2|MASK1|MASK0);
+		break;
+	default:
+		sst_err("rcvd illegal request");
+		/*Illegal case*/
+		return -EINVAL;
+	}
+
+	retval = sst_sc_reg_access(sc_access, PMIC_READ, 1);
+	if (0 != retval) {
+		sst_err("pmic commn failed \n");
+		return retval;
+	}
+
+	temp_value = sc_access[0].value & mask;
+	*value = temp_value + MIN_VOL_PMIC_VENDOR0;
+
+	return retval;
+} /* fs_get_vol */
-- 
1.5.4.5
