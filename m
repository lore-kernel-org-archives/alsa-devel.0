From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] [RFC 11/13] Intel SST sound card vendor2 module
Date: Fri,  3 Jul 2009 11:54:03 +0530
Message-ID: <1246602243-11259-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 085C81038CD
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 08:15:14 +0200 (CEST)
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
patch implements these settings for one of the vendor

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
Signed-off-by: R Dharageswari <dharageswari.r@intel.com>

	new file:   sound/pci/sst/intelmid_v2_control.c
---
 sound/pci/sst/intelmid_v2_control.c |  629 +++++++++++++++++++++++++++++++++++
 1 files changed, 629 insertions(+), 0 deletions(-)
 create mode 100644 sound/pci/sst/intelmid_v2_control.c

diff --git a/sound/pci/sst/intelmid_v2_control.c b/sound/pci/sst/intelmid_v2_control.c
new file mode 100644
index 0000000..21e3cdb
--- /dev/null
+++ b/sound/pci/sst/intelmid_v2_control.c
@@ -0,0 +1,629 @@
+/*
+ *  intelmid_v2_control.c - Intel Sound card driver for MID
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
+enum reg_v3 {
+	VAUDIOCNT = 0x51,
+	VOICEPORT1 = 0x100,
+	VOICEPORT2 = 0x101,
+	AUDIOPORT1 = 0x102,
+	AUDIOPORT2 = 0x103,
+	ADCSAMPLERATE = 0x104,
+	DMICCTRL1 = 0x105,
+	DMICCTRL2 = 0x106,
+	MICCTRL = 0x107,
+	MICSELVOL = 0x108,
+	LILSEL = 0x109,
+	LIRSEL = 0x10a,
+	VOICEVOL = 0x10b,
+	AUDIOLVOL = 0x10c,
+	AUDIORVOL = 0x10d,
+	LMUTE = 0x10e,
+	RMUTE = 0x10f,
+	POWERCTRL1 = 0x110,
+	POWERCTRL2 = 0x111,
+	DRVPOWERCTRL = 0x112,
+	VREFPLL = 0x113,
+	PCMBUFCTRL = 0x114,
+	SOFTMUTE = 0x115,
+	DTMFPATH = 0x116,
+	DTMFVOL = 0x117,
+	DTMFFREQ = 0x118,
+	DTMFHFREQ = 0x119,
+	DTMFLFREQ = 0x11a,
+	DTMFCTRL = 0x11b,
+	DTMFASON = 0x11c,
+	DTMFASOFF = 0x11d,
+	DTMFASINUM = 0x11e,
+	CLASSDVOL = 0x11f,
+	VOICEDACAVOL = 0x120,
+	AUDDACAVOL = 0x121,
+	LOMUTEVOL = 0x122,
+	HPLVOL = 0x123,
+	HPRVOL = 0x124,
+	MONOVOL = 0x125,
+	LINEOUTMIXVOL = 0x126,
+	EPMIXVOL = 0x127,
+	LINEOUTLSEL = 0x128,
+	LINEOUTRSEL = 0x129,
+	EPMIXOUTSEL = 0x12a,
+	HPLMIXSEL = 0x12b,
+	HPRMIXSEL = 0x12c,
+	LOANTIPOP = 0x12d,
+};
+
+
+int nc_init_card(void)
+{
+	struct sc_reg_access sc_access[] = {
+
+		{VAUDIOCNT, 0x27, 0},
+		{VOICEPORT1, 0xd5, 0},
+		{VOICEPORT2, 0x08, 0},
+		{AUDIOPORT1, 0x98, 0},
+		{AUDIOPORT2, 0x09, 0},
+		{AUDIOLVOL, 0x0e, 0},
+		{AUDIORVOL, 0x0e, 0},
+		{LMUTE, 0x03, 0},
+		{RMUTE, 0x03, 0},
+		{POWERCTRL1, 0xff, 0},
+		{POWERCTRL2, 0xff, 0},
+		{DRVPOWERCTRL, 0xff, 0},
+		{VREFPLL, 0xff , 0},
+		{HPLMIXSEL, 0xef, 0},
+		{HPRMIXSEL, 0xf7, 0},
+		{VAUDIOCNT, 0x27, 0},
+		{PCMBUFCTRL, 0x13, 0},
+		{DTMFPATH, 0x02, 0},
+		{DTMFCTRL, 0x00, 0},
+		{VOICEPORT1, 0xd5, 0},
+		{VOICEPORT2, 0x08, 0},
+		{VREFPLL, 0x3f, 0},
+		{POWERCTRL1, 0xff, 0},
+		{POWERCTRL2, 0xff, 0},
+		{DRVPOWERCTRL, 0xff, 0},
+		{HPLMIXSEL, 0xde, 0},
+		{HPRMIXSEL, 0xde, 0},
+		{VOICEVOL, 0x0e, 0},
+		{LMUTE, 0x01, 0},
+		{AUDIOPORT1, 0xa8, 0},
+		{AUDIOPORT2, 0x17, 0},
+		{AUDIOLVOL, 0x0e, 0},
+		{AUDIORVOL, 0x0e, 0},
+		{LMUTE, 0x03, 0},
+		{RMUTE, 0x03, 0},
+		{HPLMIXSEL, 0xef, 0},
+		{HPRMIXSEL, 0xf7, 0},
+	};
+	sst_sc_reg_access(sc_access, PMIC_WRITE, 37);
+	sst_dbg("complete!!\n");
+	return 0;
+}
+
+int nc_init_capture_card(void)
+{
+	struct sc_reg_access sc_access_capture[] = {
+		/*voice port enabling workaorund*/
+		{0x03A, 0x05, 0x00},
+		{0x051, 0x27, 0x00},
+		{0x113, 0x3A, 0x00},
+		{0x100, 0x90, 0x00},
+		{0x101, 0x07, 0x00},
+		{0x114, 0x33, 0x00},
+		{0x107, 0x10, 0x00},
+		{0x104, 0x83, 0x00},
+		{0x12B, 0xDE, 0x00},
+		{0x12C, 0xDE, 0x00},
+		{0x108, 0x53, 0x00},
+		{0x10A, 0x0C, 0x00},
+		{0x10B, 0x0E, 0x00},
+		{0x123, 0x0C, 0x00},
+		{0x124, 0x0C, 0x00},
+		{0x10E, 0x03, 0x00},
+		{0x10F, 0x03, 0x00},
+		{0x110, 0xD4, 0x00},
+		{0x111, 0x0C, 0x00},
+		{0x112, 0x06, 0x00},
+
+		/*audio port*/
+		{0x051, 0x27, 0x00},
+		{0x113, 0x35, 0x00},
+		{0x102, 0x90, 0x00},
+		{0x103, 0x00, 0x00},
+		{0x114, 0x33, 0x00},
+		{0x107, 0x11, 0x00},
+		{0x104, 0x83, 0x00},
+		{0x12B, 0xE6, 0x00},
+		{0x12C, 0xE6, 0x00},
+		{0x108, 0x53, 0x00},
+		{0x10A, 0x0C, 0x00},
+		{0x10B, 0x0E, 0x00},
+		{0x123, 0x0C, 0x00},
+		{0x124, 0x0C, 0x00},
+		{0x10E, 0x03, 0x00},
+		{0x10F, 0x03, 0x00},
+		{0x110, 0xFF, 0x00},
+		{0x111, 0x0C, 0x00},
+		{0x112, 0x06, 0x00},
+	};
+	sst_dbg("calling capture init\n");
+	sst_sc_reg_access(sc_access_capture, PMIC_WRITE, 39);
+	sst_dbg("complete!!\n");
+	return 0;
+}
+
+void nc_set_pcm_params(int sfreq, int word_size)
+{
+	int config2 = 0;
+	struct sc_reg_access sc_access;
+
+	switch (word_size) {
+	case 16:
+		switch (sfreq) {
+		case 8000:
+			config2 = 0x00;
+			break;
+		case 11025:
+			config2 = 0x01;
+			break;
+		case 12000:
+			config2 = 0x02;
+			break;
+		case 16000:
+			config2 = 0x03;
+			break;
+		case 22050:
+			config2 = 0x04;
+			break;
+		case 24000:
+			config2 = 0x05;
+			break;
+		case 32000:
+			config2 = 0x07;
+			break;
+		case 44100:
+			config2 = 0x08;
+			break;
+		case 48000:
+			config2 = 0x09;
+			break;
+		}
+		sst_dbg("word_size = %d\n", word_size);
+		sc_access.reg_addr = AUDIOPORT1;
+		sc_access.value = 0x98;
+		sst_sc_reg_access(&sc_access, PMIC_WRITE, 1);
+		sc_access.reg_addr = AUDIOPORT2;
+		sc_access.value = config2;
+		sst_sc_reg_access(&sc_access, PMIC_WRITE, 1);
+		break;
+	case 24:
+		switch (sfreq) {
+		case 8000:
+			config2 = 0x10;
+			break;
+		case 11025:
+			config2 = 0x11;
+			break;
+		case 12000:
+			config2 = 0x12;
+			break;
+		case 16000:
+			config2 = 0x13;
+			break;
+		case 22050:
+			config2 = 0x14;
+			break;
+		case 24000:
+			config2 = 0x15;
+			break;
+		case 32000:
+			config2 = 0x17;
+			break;
+		case 44100:
+			config2 = 0x18;
+			break;
+		case 48000:
+			config2 = 0x19;
+			break;
+		}
+		sst_dbg("word_size = %d\n", word_size);
+		sc_access.reg_addr = AUDIOPORT1;
+		sc_access.value = 0xAB;
+		sst_sc_reg_access(&sc_access, PMIC_WRITE, 1);
+		sc_access.reg_addr = AUDIOPORT2;
+		sc_access.value = config2;
+		sst_sc_reg_access(&sc_access, PMIC_WRITE, 1);
+		break;
+
+	}
+	sst_dbg("config2 = 0x%x\n", config2);
+	return;
+
+}
+int nc_set_selected_output_dev(int value)
+{
+	int retval = 0;
+	struct sc_reg_access sc_access_MHS[] = {
+	{RMUTE, 0X02, 0},
+	{POWERCTRL2, 0Xff, 0},
+	{DRVPOWERCTRL, 0xff, 0},
+	{VREFPLL, 0xff, 0},
+	{LMUTE, 0x02, 0},
+	{HPLMIXSEL, 0x00, 0},
+	{HPRMIXSEL, 0x00, 0},
+	{POWERCTRL1, 0xFF, 0},
+	{AUDIOLVOL, 0x00, 0},
+	{AUDIORVOL, 0x00, 0},
+	{LOMUTEVOL, 0x00, 0}
+	};
+
+	struct sc_reg_access sc_access_SH[] = {
+		{LMUTE, 0x03, 0x00},
+		{RMUTE, 0x02, 0x00}
+	};
+
+	struct sc_reg_access sc_access_IS[] = {
+		{LMUTE, 0x05, 0x00},
+		{RMUTE, 0x04, 0x00}
+	};
+
+
+	sst_dbg("nc set selected output:%d", value);
+
+	switch (value) {
+	case STEREO_HEADPHONE:
+		retval = sst_sc_reg_access(sc_access_SH, PMIC_WRITE, 2);
+		break;
+
+	case INTERNAL_SPKR:
+		retval = sst_sc_reg_access(sc_access_IS, PMIC_WRITE, 2);
+		break;
+
+	case MONO_HS:
+		retval = sst_sc_reg_access(sc_access_MHS, PMIC_WRITE, 11);
+		break;
+	default:
+		sst_err("rcvd illegal request:");
+		return -EINVAL;
+	}
+	return retval;
+}
+
+int nc_set_mute(int dev_id, int value)
+{
+	int retval = 0;
+	struct sc_reg_access sc_access;
+
+	sst_dbg("set device id::%d\n", dev_id);
+	sst_dbg("set device value::%d\n", value);
+	switch (dev_id) {
+	case PMIC_SND_INPUT_MUTE_MIC1:
+		sst_dbg("PMIC_SND_INPUT_MUTE_MIC1: value::%d", value);
+		if (value == UNMUTE) {
+			/* unmute the system, set the 6th bit to one */
+			sc_access.value = 0x00;
+		} else {
+			/* mute the system, reset the 6th bit to zero */
+			sc_access.value = 0x40;
+		}
+		sc_access.reg_addr = LILSEL;
+		sc_access.mask = MASK6;
+		break;
+	case PMIC_SND_INPUT_MUTE_MIC2:
+		sst_dbg("PMIC_SND_INPUT_MUTE_MIC2: value::%d", value);
+		if (value == UNMUTE) {
+			/* unmute the system, set the 6th bit to one */
+			sc_access.value = 0x00;
+		} else {
+			/* mute the system, reset the 6th bit to zero */
+			sc_access.value = 0x40;
+		}
+		sc_access.reg_addr = LIRSEL;
+		sc_access.mask = MASK6;
+		break;
+	case PMIC_SND_INPUT_MUTE_DMIC:
+		sst_dbg("PMIC_SND_INPUT_MUTE_DMIC: value::%d", value);
+		if (value == UNMUTE) {
+			/* unmute the system, set the 6th bit to one */
+			sc_access.value = 0x00;
+		} else {
+			/* mute the system, reset the 6th bit to zero */
+			sc_access.value = 0x40;
+		}
+		sc_access.reg_addr = DMICCTRL1;
+		sc_access.mask = MASK6;
+		break;
+	case PMIC_SND_LEFT_HP_MUTE:
+	case PMIC_SND_RIGHT_HP_MUTE:
+		if (value == UNMUTE)
+			sc_access.value = 0x0;
+		else
+			sc_access.value = 0x04;
+		if (dev_id == PMIC_SND_LEFT_HP_MUTE) {
+			sc_access.reg_addr = LMUTE;
+			sst_dbg("PMIC_SND_LEFT_HP_MUTE:: value::%d\n",
+					sc_access.value);
+		} else {
+			sc_access.reg_addr = RMUTE;
+			sst_dbg("PMIC_SND_RIGHT_HP_MUTE:: value::%d\n",
+					sc_access.value);
+		}
+		sc_access.mask = MASK2;
+		break;
+	case PMIC_SND_MONO_EARPIECE_MUTE:
+		if (value == UNMUTE)
+			sc_access.value = 0x00;
+		else
+			sc_access.value = 0x02;
+		sc_access.reg_addr = LMUTE;
+		sst_dbg("PMIC_SND_MONO_EARPIECE_MUTE::%d\n", sc_access.value);
+		sc_access.mask = MASK1;
+		break;
+	default:
+		sst_dbg("Invalid Device_id\n");
+		return -EINVAL;
+	}
+	retval = sst_sc_reg_access(&sc_access, PMIC_READ_MODIFY, 1);
+	return retval;
+
+}
+
+int nc_set_vol(int dev_id, int value)
+{
+	int retval = 0, MAX_VOL = 6;
+	struct sc_reg_access sc_access;
+
+	sst_dbg("set volume:%d", dev_id);
+	switch (dev_id) {
+	case PMIC_SND_INPUT_VOL_MIC1:
+		sst_dbg("PMIC_SND_INPUT_VOL_MIC1:: value::%d", value);
+		sc_access.value = abs(value);
+		sc_access.reg_addr = LILSEL;
+		sc_access.mask = MASK0|MASK1|MASK2|MASK3|MASK4|MASK5;
+		break;
+	case PMIC_SND_INPUT_VOL_MIC2:
+		sst_dbg("PMIC_SND_INPUT_VOL_MIC2:: value::%d", value);
+		sc_access.value = abs(value);
+		sc_access.reg_addr = LIRSEL;
+		sc_access.mask = MASK0|MASK1|MASK2|MASK3|MASK4|MASK5;
+		break;
+	case PMIC_SND_INPUT_VOL_DMIC:
+		sst_dbg("PMIC_SND_INPUT_VOL_DMIC:: value::%d", value);
+		sc_access.value =  abs(value);
+		sc_access.reg_addr = DMICCTRL1;
+		sc_access.mask = MASK0|MASK1|MASK3|MASK4|MASK5|MASK6;
+		break;
+	case PMIC_SND_INPUT_VOL_RIGHT_LINE_IN:
+		break;
+	case PMIC_SND_INPUT_VOL_LEFT_LINE_IN:
+		break;
+	case PMIC_SND_LEFT_HP_VOL:
+		sc_access.value = MAX_VOL - value;
+		sst_dbg("PMIC_SND_LEFT_HP_VOL:%d", value);
+		sc_access.reg_addr  = HPLVOL;
+		sc_access.mask = (MASK0|MASK1|MASK2|MASK3|MASK4);
+		break;
+
+	case PMIC_SND_RIGHT_HP_VOL:
+		sc_access.value = MAX_VOL-value;
+		sst_dbg("PMIC_SND_RIGHT_HP_VOL: value::%d\n", value);
+		sc_access.reg_addr  = HPRVOL;
+		sc_access.mask = (MASK0|MASK1|MASK2|MASK3|MASK4);
+		break;
+
+	case PMIC_SND_MONO_EARPIECE_VOL:
+		sc_access.value = MAX_VOL-value;
+		sst_dbg("PMIC_MONO_EARPIECE_VOL: value::%d", value);
+		sc_access.reg_addr = MONOVOL;
+		sc_access.mask = (MASK0|MASK1|MASK2|MASK3|MASK4);
+		break;
+	default:
+		sst_dbg("Invalid Device_id\n");
+		return -EINVAL;;
+
+	}
+	/*sst_sc_read_modify(&reg_adrs, &difference, 1);*/
+	retval = sst_sc_reg_access(&sc_access, PMIC_READ_MODIFY, 1);
+	return retval;
+}
+
+int nc_set_selected_input_dev(int value)
+{
+	struct sc_reg_access sc_access[3];
+	int retval = 0;
+	u8 num_val;
+
+	sst_dbg("nc set selected input:%d", value);
+
+	switch (value) {
+	case MIC1:
+		sst_dbg("MIC1\n");
+		sc_access[0].reg_addr = LILSEL;
+		sc_access[0].mask = MASK7;
+		sc_access[0].value = 0x00;
+		num_val = 1;
+		break;
+
+	case MIC2:
+		sst_dbg("MIC2\n");
+		sc_access[0].reg_addr = LIRSEL;
+		sc_access[0].value = 0x06;
+		sc_access[0].mask = MASK0|MASK1|MASK2|MASK3|MASK4|
+							MASK5|MASK6|MASK7;
+
+		sc_access[1].reg_addr = MICSELVOL;
+		sc_access[1].value = 0x13;
+		sc_access[1].mask = MASK0|MASK1|MASK4 ;
+
+		sc_access[2].reg_addr = MICCTRL;
+		sc_access[2].value = 0x10;
+		sc_access[2].mask = MASK4;
+		num_val = 3;
+
+		break;
+
+	case DMIC:
+		sst_dbg("DMIC\n");
+		sc_access[0].reg_addr = DMICCTRL1;
+		sc_access[0].value = 0x40;
+		sc_access[0].mask = MASK6;
+		num_val = 1;
+
+		break;
+	default:
+		sst_err("rcvd illegal request:");
+		return -EINVAL;
+	}
+	retval = sst_sc_reg_access(sc_access, PMIC_READ_MODIFY, num_val);
+	return retval;
+}
+
+int nc_get_selected_output_dev(int *value)
+{
+	return 0;
+}
+
+int nc_get_mute(int dev_id, int *value)
+{
+	int retval = 0, mask = 0;
+	struct sc_reg_access sc_access = {0,};
+
+	sst_dbg("get mute::%d\n", dev_id);
+
+	switch (dev_id) {
+	case PMIC_SND_INPUT_MUTE_MIC1:
+		sst_dbg("PMIC_SND_INPUT_MUTE_MIC1\n");
+		sc_access.reg_addr = LILSEL;
+		mask = MASK6;
+		break;
+	case PMIC_SND_INPUT_MUTE_MIC2:
+		sst_dbg("PMIC_SND_INPUT_MUTE_MIC2\n");
+		sc_access.reg_addr = LIRSEL;
+		mask = MASK6;
+		break;
+	case PMIC_SND_LEFT_HP_MUTE:
+	case PMIC_SND_RIGHT_HP_MUTE:
+		mask = MASK2;
+		sst_dbg("PMIC_SN_LEFT/RIGHT_HP_MUTE\n");
+		if (dev_id == PMIC_SND_RIGHT_HP_MUTE)
+			sc_access.reg_addr = RMUTE;
+		else
+			sc_access.reg_addr = LMUTE;
+		break;
+
+	case PMIC_SND_MONO_EARPIECE_MUTE:
+		sst_dbg("PMIC_MONO_EARPIECE_MUTE\n");
+		sc_access.reg_addr = RMUTE;
+		mask = MASK1;
+		break;
+	default:
+		sst_dbg("Invalid Device_id\n");
+		return -EINVAL;
+
+	}
+	retval = sst_sc_reg_access(&sc_access, PMIC_READ_MODIFY, 1);
+	sst_dbg("reg value = %d\n", sc_access.value);
+	if (retval != 0)
+		return retval;
+	*value = (sc_access.value) & mask;
+	if (*value)
+		*value = 0;
+	else
+		*value = 1;
+	sst_dbg("value returned = 0x%x\n", *value);
+	return retval;
+}
+
+int nc_get_vol(int dev_id, int *value)
+{
+	int retval = 0, mask = 0, MAX_VOL = 6;
+	struct sc_reg_access sc_access = {0,};
+
+	switch (dev_id) {
+	case PMIC_SND_INPUT_VOL_MIC1:
+		sst_dbg("PMIC_SND_INPUT_VOL_MIC1\n");
+		sc_access.reg_addr =  LILSEL;
+		mask = (MASK0|MASK1|MASK2|MASK3|MASK4|MASK5);
+		break;
+	case PMIC_SND_INPUT_VOL_MIC2:
+		sst_dbg("PMIC_SND_INPUT_VOL_MIC2\n");
+		sc_access.reg_addr =  LIRSEL;
+		mask = (MASK0|MASK1|MASK2|MASK3|MASK4|MASK5);
+		break;
+	case PMIC_SND_INPUT_VOL_DMIC:
+		sst_dbg("PMIC_SND_INPUT_VOL_DMIC\n");
+		break;
+	case PMIC_SND_LEFT_HP_VOL:
+		sst_dbg("GET_VOLUME_PMIC_LEFT_HP_VOL\n");
+		sc_access.reg_addr = HPLVOL;
+		mask = (MASK0|MASK1|MASK2|MASK3|MASK4);
+		break;
+	case PMIC_SND_RIGHT_HP_VOL:
+		sst_dbg("GET_VOLUME_PMIC_RIGHT_HP_VOL\n");
+		sc_access.reg_addr = HPRVOL;
+		mask = (MASK0|MASK1|MASK2|MASK3|MASK4);
+		break;
+	case PMIC_SND_MONO_EARPIECE_VOL:
+		sst_dbg("GET_VOLUME_MONOEARPIECE_VOL\n");
+		sc_access.reg_addr = MONOVOL;
+		mask = (MASK0|MASK1|MASK2|MASK3|MASK4);
+		break;
+	default:
+		sst_dbg("Invalid Device_id = %d\n", dev_id);
+		return -EINVAL;
+
+	}
+	retval = sst_sc_reg_access(&sc_access, PMIC_READ, 1);
+	*value = (sc_access.value) & mask;
+	*value = MAX_VOL - *value;
+	sst_dbg("value returned = 0x%x\n", *value);
+	return retval;
+}
+
-- 
1.5.4.5
