From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] [RFC 8/13] Intel SST sound card driver
Date: Fri,  3 Jul 2009 12:36:15 +0530
Message-ID: <1246604775-12960-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 8AB112476D
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 08:57:14 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@intel.com>, Harsha Priya <priya.harsha@intel.com>
List-Id: alsa-devel@alsa-project.org

This adds support for Moorestown ALSA Sound card driver.
This is an ALSA driver for supporting PCM playback/capture
in traditional ALSA way. Anyone who chooses not to use DSP
for decoding/encoding can use ALSA path to
play/capture (in non low power mode).
This driver registers the control interface and PCM
interface with the LPE driver which finally sends it to
the hardware. This driver allows any subsystem in OS
which wants to use the audio-subsystems to be routed
through the ALSA

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>

	new file:   sound/pci/sst/intelmid.c
---
 sound/pci/sst/intelmid.c | 1761 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 1761 insertions(+), 0 deletions(-)
 create mode 100644 sound/pci/sst/intelmid.c

diff --git a/sound/pci/sst/intelmid.c b/sound/pci/sst/intelmid.c
new file mode 100644
index 0000000..28a6dcc
--- /dev/null
+++ b/sound/pci/sst/intelmid.c
@@ -0,0 +1,1761 @@
+/*
+ *   intelmid.c - Intel Sound card driver for MID
+ *
+ *  Copyright (C) 2008-09 Intel Corp
+ *  Authors:	Harsha Priya <priya.harsha@intel.com>
+ *		Vinod Koul <vinod.koul@intel.com>
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
+ * ALSA driver for Intel MID sound card chipset
+ */
+#include <sound/core.h>
+#include <sound/control.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/info.h>
+#include <sound/initval.h>
+#include <sound/pcm-indirect.h>
+#include <sound/intel_sst.h>
+#include <sound/intel_sst_ioctl.h>
+#include "intelmid_snd_control.h"
+#include "intelmid.h"
+#include "intelmid_pvt.h"
+#include <linux/spi/spi.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/moduleparam.h>
+#include <linux/sched.h>
+#include <linux/gpe.h>
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+MODULE_AUTHOR("Harsha Priya <priya.harsha@intel.com>");
+MODULE_AUTHOR("Vinod Koul <vinod.koul@intel.com>");
+MODULE_DESCRIPTION("Intel MAD Sound card driver");
+MODULE_LICENSE("GPL v2");
+MODULE_SUPPORTED_DEVICE("{Intel,Intel_MAD}");
+
+static int 	card_index = SNDRV_DEFAULT_IDX1;/* Index 0-MAX */
+static char *card_id = SNDRV_DEFAULT_STR1;	/* ID for this card */
+static int	vendor_id;
+static unsigned int audio_event_seqnum;
+static int	cum_bytes;
+
+
+#ifdef FULL_CTRL
+static char *out_names[] = {"Headphones",
+				"Internal speakers",
+				"EarPiece"};
+static char *in_names[] = {	"DMIC",
+				"MIC1",
+				"MIC2",
+				"Line_in"};
+#endif
+static struct genl_family audio_event_genl_family = {
+	.id = GENL_ID_GENERATE,
+	.name = "audio events",
+	.version = 0x01,
+	.maxattr = 0,
+};
+
+static struct genl_multicast_group audio_event_mcgrp = {
+	.name = "audio_group",
+};
+
+/*control path functionalities*/
+/**
+* snd_intelmad_mute_info - provides information about the mute controls
+* @kcontrol:	pointer to the control
+* @uinfo: 	pointer to the structure where the control's info need
+*		to be filled
+* This function is called when a mixer application requests for control's info
+*/
+static int snd_intelmad_mute_info(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_info *uinfo)
+{
+	WARN_ON(!uinfo);
+	WARN_ON(!kcontrol);
+
+	/*set up the mute as a boolean mono control with min-max values*/
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = MONO_CNTL;
+	uinfo->value.integer.min = MIN_MUTE;
+	uinfo->value.integer.max = MAX_MUTE;
+	return 0;
+}
+
+#ifdef FULL_CTRL
+/**
+* snd_intelmad_volume_line_info - provides information about the volume control
+* @kcontrol:	pointer to the control
+* @uinfo: 	pointer to the structure where the control's info need
+*		to be filled
+* This function is called when a mixer application requests for control's info
+*/
+static int snd_intelmad_line_volume_info(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_info *uinfo)
+
+{
+	snd_intelmad_volume_info(uinfo, STEREO_CNTL,
+					ctrl_val[vendor_id].linein_vol_max,
+					ctrl_val[vendor_id].linein_vol_min);
+	return 0;
+}
+
+/**
+* snd_intelmad_mic1_volume_info - provides information about the volume control
+* @kcontrol:	pointer to the control
+* @uinfo: 	pointer to the structure where the control's info need
+*		to be filled
+* This function is called when a mixer application requests for control's info
+*/
+static int snd_intelmad_mic1_volume_info(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_info *uinfo)
+{
+	snd_intelmad_volume_info(uinfo, STEREO_CNTL,
+					ctrl_val[vendor_id].mic1_vol_max,
+					ctrl_val[vendor_id].mic1_vol_min);
+	return 0;
+}
+
+/**
+* snd_intelmad_mic2_volume_info - provides information about the volume control
+* @kcontrol:	pointer to the control
+* @uinfo: 	pointer to the structure where the control's info need
+*		to be filled
+* This function is called when a mixer application requests for control's info
+*/
+static int snd_intelmad_mic2_volume_info(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_info *uinfo)
+{
+	snd_intelmad_volume_info(uinfo, STEREO_CNTL,
+					ctrl_val[vendor_id].mic2_vol_max,
+					ctrl_val[vendor_id].mic2_vol_min);
+	return 0;
+}
+
+/**
+* snd_intelmad_dmic_volume_info - provides information about the volume control
+* @kcontrol:	pointer to the control
+* @uinfo: 	pointer to the structure where the control's info need
+*		to be filled
+* This function is called when a mixer application requests for control's info
+*/
+static int snd_intelmad_dmic_volume_info(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_info *uinfo)
+{
+	snd_intelmad_volume_info(uinfo, STEREO_CNTL,
+					ctrl_val[vendor_id].dmic_vol_max,
+					ctrl_val[vendor_id].dmic_vol_min);
+	return 0;
+}
+#endif
+/**
+* snd_intelmad_hp_volume_info - provides information about the volume control
+* @kcontrol:	pointer to the control
+* @uinfo: 	pointer to the structure where the control's info need
+*		to be filled
+* This function is called when a mixer application requests for control's info
+*/
+static int snd_intelmad_hp_volume_info(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_info *uinfo)
+{
+	snd_intelmad_volume_info(uinfo, STEREO_CNTL,
+					ctrl_val[vendor_id].hp_vol_max,
+					ctrl_val[vendor_id].hp_vol_min);
+	return 0;
+}
+
+#ifdef FULL_CTRL
+/**
+* snd_intelmad_speaker_volume_info - provides information about the volume control
+* @kcontrol:	pointer to the control
+* @uinfo: 	pointer to the structure where the control's info need
+*		to be filled
+* This function is called when a mixer application requests for control's info
+*/
+static int snd_intelmad_speaker_volume_info(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_info *uinfo)
+{
+	snd_intelmad_volume_info(uinfo, STEREO_CNTL,
+					ctrl_val[vendor_id].speaker_vol_max,
+					ctrl_val[vendor_id].speaker_vol_min);
+	return 0;
+}
+
+/**
+* snd_intelmad_earpiece_volume_info - provides information about the volume control
+* @kcontrol:	pointer to the control
+* @uinfo: 	pointer to the structure where the control's info need
+*		to be filled
+* This function is called when a mixer application requests for control's info
+*/
+static int snd_intelmad_earpiece_volume_info(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_info *uinfo)
+{
+	snd_intelmad_volume_info(uinfo, MONO_CNTL,
+					ctrl_val[vendor_id].earpiece_vol_max,
+					ctrl_val[vendor_id].earpiece_vol_min);
+	return 0;
+}
+
+/**
+* snd_intelmad_device_info - provides information about the devices available
+* @kcontrol:	pointer to the control
+* @uinfo: 	pointer to the structure where the devices's info need
+*		to be filled
+* This function is called when a mixer application requests for device's info
+*/
+static int snd_intelmad_device_info(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_info *uinfo)
+{
+	WARN_ON(!kcontrol);
+	WARN_ON(!uinfo);
+	/*setup device select as drop down controls with different values*/
+	if (OUTPUT_SEL == kcontrol->id.numid)
+		uinfo->value.enumerated.items = ARRAY_SIZE(out_names);
+	else
+		uinfo->value.enumerated.items = ARRAY_SIZE(in_names);
+	uinfo->count = MONO_CNTL;
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+
+	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
+		uinfo->value.enumerated.item = 1;
+	if (OUTPUT_SEL == kcontrol->id.numid)
+		strncpy(uinfo->value.enumerated.name,
+			out_names[uinfo->value.enumerated.item],
+			strlen(out_names[uinfo->value.enumerated.item]));
+	else
+		strncpy(uinfo->value.enumerated.name,
+			in_names[uinfo->value.enumerated.item],
+			strlen(in_names[uinfo->value.enumerated.item]));
+	return 0;
+}
+#endif
+
+/**
+* snd_intelmad_volume_get - gets the current volume for the control
+* @kcontrol:	pointer to the control
+* @uval:	pointer to the structure where the control's info need
+*		to be filled
+* This function is called when .get function of a control is invoked from app
+*/
+static int snd_intelmad_volume_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *uval)
+{
+	int ret_val = 0, cntl_list[2] = {0,}, value = 0;
+	struct snd_intelmad *intelmaddata = NULL;
+	struct snd_pmic_ops *scard_ops = NULL;
+
+	sst_dbg("called\n");
+
+	WARN_ON(!uval);
+	WARN_ON(!kcontrol);
+
+	intelmaddata = kcontrol->private_data;
+
+	WARN_ON(!intelmaddata->sstdrv_ops);
+
+	if (PMIC_UNINIT == intelmaddata->pmic_status) {
+		ret_val = intelmaddata->sstdrv_ops->scard_ops->init_card();
+		intelmaddata->pmic_status = PMIC_INIT;
+	}
+
+	if (0 != ret_val)
+		return ret_val;
+
+	scard_ops = intelmaddata->sstdrv_ops->scard_ops;
+
+	WARN_ON(!scard_ops);
+
+	switch (kcontrol->id.numid) {
+	case HEADPHONES_VOL:
+		cntl_list[0] = PMIC_SND_RIGHT_HP_VOL;
+		cntl_list[1] = PMIC_SND_LEFT_HP_VOL;
+		break;
+#ifdef FULL_CTRL
+	case INTERNAL_SPEAKERS_VOL:
+		cntl_list[0] = PMIC_SND_RIGHT_SPEAKER_VOL;
+		cntl_list[1] = PMIC_SND_LEFT_SPEAKER_VOL;
+		break;
+	case LINE_IN_VOL:
+		cntl_list[0] = PMIC_SND_INPUT_VOL_RIGHT_LINE_IN;
+		cntl_list[1] = PMIC_SND_INPUT_VOL_LEFT_LINE_IN;
+		break;
+	case EARPIECE_VOL:
+		cntl_list[0] = PMIC_SND_MONO_EARPIECE_VOL;
+		break;
+	case MIC1_VOL:
+		cntl_list[0] = PMIC_SND_INPUT_VOL_MIC1;
+		break;
+	case MIC2_VOL:
+		cntl_list[0] = PMIC_SND_INPUT_VOL_MIC2;
+		break;
+	case DMIC_VOL:
+		cntl_list[0] = PMIC_SND_INPUT_VOL_DMIC;
+		break;
+#endif
+	default:
+		return -EINVAL;
+	}
+
+	ret_val = scard_ops->get_vol(cntl_list[0], &value);
+	uval->value.integer.value[0] = value;
+
+	if (0 != ret_val)
+		return ret_val;
+#ifdef FULL_CTRL
+	if (HEADPHONES_VOL == kcontrol->id.numid
+		|| INTERNAL_SPEAKERS_VOL == kcontrol->id.numid ||
+		LINE_IN_VOL == kcontrol->id.numid) {
+#else
+	if (1) {
+#endif
+
+		ret_val = scard_ops->get_vol(cntl_list[1], &value);
+		uval->value.integer.value[1] = value;
+
+		if (0 != ret_val)
+			return ret_val;
+	}
+	return ret_val;
+}
+
+/**
+* snd_intelmad_mute_get - gets the current mute status for the control
+* @kcontrol:	pointer to the control
+* @uval: 	pointer to the structure where the control's info need
+*		to be filled
+* This function is called when .get function of a control is invoked from app
+*/
+static int snd_intelmad_mute_get(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *uval)
+{
+
+	int cntl_list = 0, ret_val = 0, value = 0;
+	struct snd_intelmad *intelmaddata = NULL;
+	struct snd_pmic_ops *scard_ops = NULL;
+
+	sst_dbg("called\n");
+
+	WARN_ON(!uval);
+	WARN_ON(!kcontrol);
+
+	intelmaddata = kcontrol->private_data;
+
+	WARN_ON(!intelmaddata->sstdrv_ops);
+
+	if (PMIC_UNINIT == intelmaddata->pmic_status) {
+		ret_val = intelmaddata->sstdrv_ops->scard_ops->init_card();
+		intelmaddata->pmic_status = PMIC_INIT;
+	}
+
+	if (0 != ret_val)
+		return ret_val;
+
+	scard_ops = intelmaddata->sstdrv_ops->scard_ops;
+
+	WARN_ON(!scard_ops);
+
+	switch (kcontrol->id.numid) {
+	case HEADPHONES_MUTE:
+		cntl_list = PMIC_SND_LEFT_HP_MUTE;
+		break;
+#ifdef FULL_CTRL
+	case INTERNAL_SPEAKERS_MUTE:
+		cntl_list = PMIC_SND_LEFT_SPEAKER_MUTE;
+		break;
+	case EARPIECE_MUTE:
+		cntl_list = PMIC_SND_MONO_EARPIECE_MUTE;
+		break;
+	case LINE_IN_MUTE:
+		cntl_list = PMIC_SND_INPUT_MUTE_LINE_IN;
+		break;
+	case MIC1_MUTE:
+		cntl_list = PMIC_SND_INPUT_MUTE_MIC1;
+		break;
+	case MIC2_MUTE:
+		cntl_list = PMIC_SND_INPUT_MUTE_MIC2;
+		break;
+	case DMIC_MUTE:
+		cntl_list = PMIC_SND_INPUT_MUTE_DMIC;
+		break;
+	case MASTER_MUTE:
+		uval->value.integer.value[0] = kcontrol->private_value;
+		return 0;
+#endif
+
+	default:
+		return -EINVAL;
+	}
+
+	ret_val = scard_ops->get_mute(cntl_list, &value);
+	uval->value.integer.value[0] = value;
+	return ret_val;
+}
+
+/**
+* snd_intelmad_volume_set - sets the volume control's info
+* @kcontrol:	pointer to the control
+* @uval: 	pointer to the structure where the control's info is
+*		available to be set
+* This function is called when .set function of a control is invoked from app
+*/
+static int snd_intelmad_volume_set(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *uval)
+{
+
+	int ret_val = 0, cntl_list[2] = {0,};
+	struct snd_intelmad *intelmaddata = NULL;
+	struct snd_pmic_ops *scard_ops = NULL;
+
+	sst_dbg("volume set called\n:%ld %ld",
+			uval->value.integer.value[0],
+			uval->value.integer.value[1]);
+
+	WARN_ON(!uval);
+	WARN_ON(!kcontrol);
+
+	intelmaddata = kcontrol->private_data;
+
+	WARN_ON(!intelmaddata->sstdrv_ops);
+
+	if (PMIC_UNINIT == intelmaddata->pmic_status) {
+		ret_val = intelmaddata->sstdrv_ops->scard_ops->init_card();
+		intelmaddata->pmic_status = PMIC_INIT;
+	}
+
+	if (0 != ret_val)
+		return ret_val;
+
+	scard_ops = intelmaddata->sstdrv_ops->scard_ops;
+
+	WARN_ON(!scard_ops);
+
+	switch (kcontrol->id.numid) {
+	case HEADPHONES_VOL:
+		cntl_list[0] = PMIC_SND_RIGHT_HP_VOL;
+		cntl_list[1] = PMIC_SND_LEFT_HP_VOL;
+		break;
+#ifdef FULL_CTRL
+	case INTERNAL_SPEAKERS_VOL:
+		cntl_list[0] = PMIC_SND_RIGHT_SPEAKER_VOL;
+		cntl_list[1] = PMIC_SND_LEFT_SPEAKER_VOL;
+		break;
+	case LINE_IN_VOL:
+		cntl_list[0] = PMIC_SND_INPUT_VOL_RIGHT_LINE_IN;
+		cntl_list[1] = PMIC_SND_INPUT_VOL_LEFT_LINE_IN;
+		break;
+	case EARPIECE_VOL:
+		cntl_list[0] = PMIC_SND_MONO_EARPIECE_VOL;
+		break;
+	case MIC1_VOL:
+		cntl_list[0] = PMIC_SND_INPUT_VOL_MIC1;
+		break;
+	case MIC2_VOL:
+		cntl_list[0] = PMIC_SND_INPUT_VOL_MIC2;
+		break;
+	case DMIC_VOL:
+		cntl_list[0] = PMIC_SND_INPUT_VOL_DMIC;
+		break;
+#endif
+	default:
+		return -EINVAL;
+	}
+
+	ret_val = scard_ops->set_vol(cntl_list[0],
+				uval->value.integer.value[0]);
+	if (0 != ret_val)
+		return ret_val;
+#ifdef FULL_CTRL
+	if (HEADPHONES_VOL == kcontrol->id.numid
+			|| INTERNAL_SPEAKERS_VOL == kcontrol->id.numid ||
+			LINE_IN_VOL == kcontrol->id.numid) {
+#else
+	if (1) {
+#endif
+		ret_val = scard_ops->set_vol(cntl_list[1],
+				uval->value.integer.value[1]);
+		if (0 != ret_val)
+			return ret_val;
+	}
+	kcontrol->private_value = uval->value.integer.value[0];
+	return ret_val;
+}
+
+
+
+/**
+* snd_intelmad_mute_set - sets the mute control's info
+* @kcontrol:	pointer to the control
+* @uval:	pointer to the structure where the control's info is
+*		available to be set
+* This function is called when .set function of a control is invoked from app
+*/
+static int snd_intelmad_mute_set(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *uval)
+{
+	int cntl_list[2] = {0,}, ret_val = 0;
+	struct snd_intelmad *intelmaddata = NULL;
+	struct snd_pmic_ops *scard_ops = NULL;
+
+	sst_dbg("called\n");
+
+	WARN_ON(!uval);
+	WARN_ON(!kcontrol);
+
+	intelmaddata = kcontrol->private_data;
+
+	WARN_ON(!intelmaddata->sstdrv_ops);
+
+	if (PMIC_UNINIT == intelmaddata->pmic_status) {
+		ret_val = intelmaddata->sstdrv_ops->scard_ops->init_card();
+		intelmaddata->pmic_status = PMIC_INIT;
+	}
+
+	if (0 != ret_val)
+		return ret_val;
+
+	scard_ops = intelmaddata->sstdrv_ops->scard_ops;
+
+	WARN_ON(!scard_ops);
+
+	kcontrol->private_value = uval->value.integer.value[0];
+
+	switch (kcontrol->id.numid) {
+	case HEADPHONES_MUTE:
+		cntl_list[0] = PMIC_SND_LEFT_HP_MUTE;
+		cntl_list[1] = PMIC_SND_RIGHT_HP_MUTE;
+		break;
+#ifdef FULL_CTRL
+	case INTERNAL_SPEAKERS_MUTE:
+		cntl_list[0] = PMIC_SND_LEFT_SPEAKER_MUTE;
+		cntl_list[1] = PMIC_SND_RIGHT_SPEAKER_MUTE;
+		break;
+	case EARPIECE_MUTE:
+		cntl_list[0] = PMIC_SND_MONO_EARPIECE_MUTE;
+		break;
+	case LINE_IN_MUTE:
+		cntl_list[0] = PMIC_SND_INPUT_MUTE_LINE_IN;
+		break;
+	case MIC1_MUTE:
+		cntl_list[0] = PMIC_SND_INPUT_MUTE_MIC1;
+		break;
+	case MIC2_MUTE:
+		cntl_list[0] = PMIC_SND_INPUT_MUTE_MIC2;
+		break;
+	case DMIC_MUTE:
+		cntl_list[0] = PMIC_SND_INPUT_MUTE_DMIC;
+		break;
+	case MASTER_MUTE:
+		mute_all(kcontrol, uval);
+		kcontrol->private_value = uval->value.integer.value[0];
+		return 0;
+#endif
+	default:
+		return -EINVAL;
+	}
+
+	ret_val = scard_ops->set_mute(cntl_list[0],
+				uval->value.integer.value[0]);
+	if (0 != ret_val)
+		return ret_val;
+
+#ifdef FULL_CTRL
+	if (HEADPHONES_MUTE == kcontrol->id.numid
+		|| INTERNAL_SPEAKERS_MUTE == kcontrol->id.numid)
+#endif
+		ret_val = scard_ops->set_mute(cntl_list[1],
+					uval->value.integer.value[0]);
+	kcontrol->private_value = uval->value.integer.value[0];
+	return ret_val;
+}
+
+#ifdef FULL_CTRL
+/**
+* snd_intelmad_device_get - get the device select control's info
+* @kcontrol:	pointer to the control
+* @uval:	pointer to the structure where the control's info is
+*		to be filled
+* This function is called when .get function of a control is invoked from app
+*/
+static int snd_intelmad_device_get(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *uval)
+{
+	sst_dbg("called\n");
+
+	WARN_ON(!uval);
+	WARN_ON(!kcontrol);
+
+	uval->value.enumerated.item[0] = kcontrol->private_value;
+	return 0;
+}
+
+/**
+* snd_intelmad_device_set - set the device select control's info
+* @kcontrol:	pointer to the control
+* @uval: 	pointer to the structure where the control's info is
+*		available to be set
+* This function is called when .set function of a control is invoked from app
+*/
+static int snd_intelmad_device_set(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *uval)
+{
+	struct snd_intelmad *intelmaddata = NULL;
+	struct snd_pmic_ops *scard_ops = NULL;
+	int ret_val = 0;
+
+	sst_dbg("called\n");
+
+	WARN_ON(!uval);
+	WARN_ON(!kcontrol);
+
+	intelmaddata = kcontrol->private_data;
+
+	WARN_ON(!intelmaddata->sstdrv_ops);
+
+	if (PMIC_UNINIT == intelmaddata->pmic_status) {
+		ret_val = intelmaddata->sstdrv_ops->scard_ops->init_card();
+		intelmaddata->pmic_status = PMIC_INIT;
+	}
+
+	if (0 != ret_val)
+		return ret_val;
+
+	scard_ops = intelmaddata->sstdrv_ops->scard_ops;
+
+	WARN_ON(!scard_ops);
+
+	/*store value with driver*/
+	kcontrol->private_value = uval->value.enumerated.item[0];
+
+	switch (kcontrol->id.numid) {
+	case OUTPUT_SEL:
+		ret_val = scard_ops->set_output_dev(
+				uval->value.enumerated.item[0]);
+		break;
+	case INPUT_SEL:
+		ret_val = scard_ops->set_input_dev(
+				uval->value.enumerated.item[0]);
+		break;
+	default:
+		return -EINVAL;
+	}
+	kcontrol->private_value = uval->value.enumerated.item[0];
+	return ret_val;
+}
+#endif
+
+/*structure of all the controls of the sound card that is exposed*/
+static struct snd_kcontrol_new snd_intelmad_controls[] __devinitdata = {
+#ifdef FULL_CTRL
+{
+	.iface 		=	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name 		=	"Line Volume",
+	.access 	=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info 		=	snd_intelmad_line_volume_info,
+	.get 		=	snd_intelmad_volume_get,
+	.put		=	snd_intelmad_volume_set,
+	.private_value	=	0,
+},
+{
+	.iface 		=	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name 		=	"Line Capture Switch",
+	.access 	=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info 		=	snd_intelmad_mute_info,
+	.get 		=	snd_intelmad_mute_get,
+	.put		=	snd_intelmad_mute_set,
+	.private_value 	=	0,
+},
+{
+	.iface 		=	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name 		=	"DMIC Volume",
+	.access 	=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info 		=	snd_intelmad_dmic_volume_info,
+	.get 		=	snd_intelmad_volume_get,
+	.put		=	snd_intelmad_volume_set,
+	.private_value 	=	0,
+},
+{
+	.iface 		=	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name 		=	"DMIC Capture Switch",
+	.access 	=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info 		=	snd_intelmad_mute_info,
+	.get 		=	snd_intelmad_mute_get,
+	.put		=	snd_intelmad_mute_set,
+	.private_value 	=	0,
+},
+{
+	.iface 		=	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name 		=	"Mic1 Volume",
+	.access 	=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info 		=	snd_intelmad_mic1_volume_info,
+	.get 		=	snd_intelmad_volume_get,
+	.put		=	snd_intelmad_volume_set,
+	.private_value 	=	0,
+},
+{
+	.iface 		=	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name 		=	"Mic1 Capture Switch",
+	.access 	=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info 		=	snd_intelmad_mute_info,
+	.get 		=	snd_intelmad_mute_get,
+	.put		=	snd_intelmad_mute_set,
+	.private_value 	=	0,
+},
+{
+	.iface 		=	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name 		=	"Mic2 Volume",
+	.access 	=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info 		=	snd_intelmad_mic2_volume_info,
+	.get 		=	snd_intelmad_volume_get,
+	.put		=	snd_intelmad_volume_set,
+	.private_value 	=	0,
+},
+{
+	.iface 		=	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name 		=	"Mic2 Capture Switch",
+	.access 	=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info 		=	snd_intelmad_mute_info,
+	.get 		=	snd_intelmad_mute_get,
+	.put		=	snd_intelmad_mute_set,
+	.private_value 	=	0,
+},
+{
+	.iface 		=	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name 		=	"Master Capture Source",
+	.access 	=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info 		=	snd_intelmad_device_info,
+	.get 		=	snd_intelmad_device_get,
+	.put		=	snd_intelmad_device_set,
+	.private_value 	=	0,
+},
+#endif
+{
+	.iface 		=	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name 		=	"Headphone Playback Volume",
+	.access 	=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info 		=	snd_intelmad_hp_volume_info,
+	.get 		=	snd_intelmad_volume_get,
+	.put		=	snd_intelmad_volume_set,
+	.private_value 	=	0,
+},
+{
+	.iface 		=	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name 		=	"Headphone Playback Switch",
+	.access 	=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info 		=	snd_intelmad_mute_info,
+	.get 		=	snd_intelmad_mute_get,
+	.put		=	snd_intelmad_mute_set,
+	.private_value	=	0,
+},
+#ifdef FULL_CTRL
+{
+	.iface 		=	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name 		=	"Internal Speaker Playback Volume",
+	.access 	=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info 		=	snd_intelmad_speaker_volume_info,
+	.get 		=	snd_intelmad_volume_get,
+	.put		=	snd_intelmad_volume_set,
+	.private_value	=	0,
+},
+{
+	.iface 		=	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name 		=	"Internal Speaker Playback Switch",
+	.access 	=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info 		=	snd_intelmad_mute_info,
+	.get 		=	snd_intelmad_mute_get,
+	.put		=	snd_intelmad_mute_set,
+	.private_value	=	0,
+},
+{
+	.iface 		=	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name 		=	"Mono Earpiece Playback Volume",
+	.access 	=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info 		=	snd_intelmad_earpiece_volume_info,
+	.get 		=	snd_intelmad_volume_get,
+	.put		=	snd_intelmad_volume_set,
+	.private_value	=	0,
+},
+{
+	.iface 		=	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name 		=	"Mono Earpiece Playback Switch",
+	.access 	=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info 		=	snd_intelmad_mute_info,
+	.get 		=	snd_intelmad_mute_get,
+	.put		=	snd_intelmad_mute_set,
+	.private_value	=	0,
+},
+{
+	.iface 		=	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name 		=	"Master Playback Source",
+	.access 	=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info 		=	snd_intelmad_device_info,
+	.get 		=	snd_intelmad_device_get,
+	.put		=	snd_intelmad_device_set,
+	.private_value	=	0,
+},
+{
+	.iface 		=	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name 		=	"Master Mute Switch",
+	.access 	=	SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info 		=	snd_intelmad_mute_info,
+	.get 		=	snd_intelmad_mute_get,
+	.put		=	snd_intelmad_mute_set,
+	.private_value	=	0,
+},
+#endif
+};
+
+/*Data path functionalities*/
+static struct snd_pcm_hardware snd_intelmad_stream = {
+	.info =	(SNDRV_PCM_INFO_INTERLEAVED |
+			SNDRV_PCM_INFO_DOUBLE |
+			SNDRV_PCM_INFO_PAUSE |
+			SNDRV_PCM_INFO_RESUME |
+			SNDRV_PCM_INFO_MMAP|
+			SNDRV_PCM_INFO_MMAP_VALID |
+			SNDRV_PCM_INFO_SYNC_START),
+	.formats = (SNDRV_PCM_FMTBIT_S16 | SNDRV_PCM_FMTBIT_U16 |
+			/*SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_U8 |*/
+			SNDRV_PCM_FMTBIT_S24 | SNDRV_PCM_FMTBIT_U24),
+	.rates = (SNDRV_PCM_RATE_8000|
+			SNDRV_PCM_RATE_44100 |
+			SNDRV_PCM_RATE_48000),
+	.rate_min = MIN_RATE,
+
+	.rate_max = MAX_RATE,
+	.channels_min =	MIN_CHANNEL,
+	.channels_max =	MAX_CHANNEL,
+	.buffer_bytes_max = MAX_BUFFER,
+	.period_bytes_min = MIN_PERIOD_BYTES,
+	.period_bytes_max = MAX_PERIOD_BYTES,
+	.periods_min = MIN_PERIODS,
+	.periods_max = MAX_PERIODS,
+	.fifo_size = FIFO_SIZE,
+};
+
+static void send_buffer_to_sst(struct snd_pcm_substream *substream,
+			struct snd_pcm_indirect *rec, size_t bytes)
+{
+	struct snd_intelmad *intelmaddata = snd_pcm_substream_chip(substream);
+	struct stream_buffer buffer_to_sst = {0,};
+	struct mad_stream_pvt *stream = substream->runtime->private_data;
+	int ret_val = 0;
+	/*sends data to SST to be processed*/
+
+	cum_bytes += bytes;
+	sst_dbg("bytes = %d \n", bytes);
+	sst_dbg("cum_bytes = 0x%x, \n", cum_bytes);
+	buffer_to_sst.length = bytes;
+	buffer_to_sst.addr = (unsigned long) substream->runtime->dma_area +
+					rec->sw_data;
+	/*SST API to actually send the buffer to be played*/
+	ret_val = intelmaddata->sstdrv_ops->send_buffer(stream->stream_id,
+			&buffer_to_sst);
+	sst_dbg("send_buffer ret_val = 0x%x \n", ret_val);
+	return;
+}
+
+void start_capture(struct work_struct *work)
+{
+	int ret_val = 0;
+	struct mad_capture_wq *stream_work =
+			container_of(work, struct mad_capture_wq, wq);
+	struct stream_buffer *buffer_to_sst = &stream_work->buffer_to_sst;
+	struct snd_pcm_substream *substream = stream_work->substream;
+	struct mad_stream_pvt *stream = substream->runtime->private_data;
+	struct snd_intelmad *intelmaddata = snd_pcm_substream_chip(substream);
+
+	ret_val = intelmaddata->sstdrv_ops->send_buffer(stream->stream_id,
+			buffer_to_sst);
+	sst_dbg("send_buffer ret_val = 0x%x \n", ret_val);
+	return;
+}
+
+void snd_card_pcm_wq_function(struct work_struct *work)
+{
+	struct mad_wq *stream_work =
+			container_of(work, struct mad_wq, wq);
+	struct snd_pcm_substream *substream;
+	struct snd_pcm_indirect *rec = NULL;
+	struct mad_stream_pvt *stream;
+
+	mutex_lock(&stream_work->wq_lock);
+	substream = stream_work->substream;
+	if (substream == NULL || substream->runtime == NULL) {
+		sst_err("subsream structure is null \n");
+		mutex_unlock(&stream_work->wq_lock);
+		return;
+	}
+	stream = substream->runtime->private_data;
+	sst_dbg("called %d\n", stream->stream_status);
+	if (stream == NULL) {
+		sst_err("stream is null in wq function \n");
+		mutex_unlock(&stream_work->wq_lock);
+		return;
+	}
+
+	if (stream->stream_status != INIT) {
+		rec = &stream->pcm_indirect;
+		if (substream->stream == STREAM_OPS_PLAYBACK)
+			snd_pcm_indirect_playback_transfer(substream, rec,
+				send_buffer_to_sst);
+		else if (substream->stream == STREAM_OPS_CAPTURE) {
+			sst_dbg("calling indirect capture transfer\n");
+			snd_pcm_indirect_capture_transfer(substream, rec,
+				send_buffer_to_sst);
+		}
+		stream->stream_status = RUNNING;
+	}
+	mutex_unlock(&stream_work->wq_lock);
+	return;
+}
+
+static int snd_intelmad_pcm_ack(struct snd_pcm_substream *substream)
+{
+	struct mad_stream_pvt *stream;
+
+	stream = substream->runtime->private_data;
+	sst_dbg("...called\n");
+	stream->mad_msg_wq.substream = substream;
+	schedule_work(&stream->mad_msg_wq.wq);
+	return 0;
+}
+
+/**
+* snd_intelmad_pcm_trigger - stream activities are handled here
+* @substream:substream for which the stream function is called
+*@cmd:the stream commamd thats requested from upper layer
+* This function is called whenever an a stream activity is invoked
+*/
+static int snd_intelmad_pcm_trigger(struct snd_pcm_substream *substream,
+					int cmd)
+{
+	int ret_val = 0, stream_type = 0/*, sample_size = 0*/;
+	struct snd_intelmad *intelmaddata = NULL;
+	struct mad_stream_pvt *stream = NULL;
+
+	sst_dbg("called\n");
+
+	WARN_ON(!substream);
+
+	intelmaddata = snd_pcm_substream_chip(substream);
+	stream_type = substream->stream;
+	stream = substream->runtime->private_data;
+
+	if (PMIC_UNINIT == intelmaddata->pmic_status) {
+		ret_val = intelmaddata->sstdrv_ops->scard_ops->init_card();
+		intelmaddata->pmic_status = PMIC_INIT;
+	}
+
+	if (0 != ret_val)
+		return ret_val;
+
+	WARN_ON(!intelmaddata->sstdrv_ops);
+	WARN_ON(!intelmaddata->sstdrv_ops->scard_ops);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_RESUME:
+		/*invoked on a power managment -resume operation*/
+		/*stream parameters and context resuming to be done here*/
+		/*TBD*/
+		sst_dbg("in resume\n");
+		break;
+	case SNDRV_PCM_TRIGGER_START:
+		stream->substream = substream;
+		stream->pcm_size = snd_pcm_lib_buffer_bytes(substream);
+		sst_dbg("pcm_size=%d\n", stream->pcm_size);
+#ifdef TIMER_TS
+		bps = (substream->runtime->sample_bits/8)
+			* (substream->runtime->channels)
+			* (substream->runtime->rate);
+		stream->pcm_jiffie = ((bps * ELAPSED_PERIOD) / HZ);
+		stream->pcm_buf_pos = 0;
+		sst_dbg("pcm_jiffie=%d \n", stream->pcm_jiffie);
+#endif
+		stream->stream_status = STARTED;
+		if (substream->stream == STREAM_OPS_PLAYBACK)
+			snd_intelmad_pcm_ack(substream);
+		else if (substream->stream == STREAM_OPS_CAPTURE) {
+			stream->mad_capture_wq.substream = substream;
+			stream->mad_capture_wq.buffer_to_sst.length =
+				frames_to_bytes(substream->runtime,
+				substream->runtime->period_size);
+			stream->mad_capture_wq.buffer_to_sst.addr =
+				(unsigned long) substream->runtime->dma_area;
+			schedule_work(&stream->mad_capture_wq.wq);
+			cum_bytes = stream->mad_capture_wq.buffer_to_sst.length;
+			stream->stream_status = RUNNING;
+		}
+		break;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		/*invoked on suspend - power management event*/
+		/*stream parameters and context to be saved*/
+		/*TBD*/
+		sst_dbg("in suspend\n");
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		sst_dbg("in stop\n");
+		/*ret_val = intelmaddata->sstdrv_ops->control_set(SST_SND_DROP,
+				&stream->stream_id);
+		if (0 != ret_val)
+			return ret_val;*/
+		stream->stream_status = DROPPED;
+		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		sst_dbg("in pause\n");
+		ret_val = intelmaddata->sstdrv_ops->control_set(SST_SND_PAUSE,
+				&stream->stream_id);
+		if (0 != ret_val)
+			return ret_val;
+		stream->stream_status = PAUSED;
+		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		sst_dbg("in pause release \n");
+		ret_val = intelmaddata->sstdrv_ops->control_set(SST_SND_RESUME,
+						&stream->stream_id);
+		if (0 != ret_val)
+			return ret_val;
+		stream->stream_status = RUNNING;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return ret_val;
+}
+
+/**
+* snd_intelmad_pcm_prepare- internal preparation before starting a stream
+* @substream:  substream for which the function is called
+* This function is called when a stream is started for internal preparation.
+*/
+static int snd_intelmad_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct mad_stream_pvt *stream = NULL;
+	int ret_val = 0;
+
+	sst_dbg("called \n");
+
+	WARN_ON(!substream);
+
+	stream = substream->runtime->private_data;
+
+	sst_dbg("format = %d \n", substream->runtime->format);
+	if (stream->stream_id == 0) {
+		ret_val = snd_intelmad_alloc_stream(substream);
+		cum_bytes = 0;
+		if (ret_val < 0)
+			return ret_val;
+		ret_val = snd_intelmad_init_stream(substream);
+		if (0 != ret_val)
+			return ret_val;
+		sst_dbg("period size = %d \n",
+			(int)substream->runtime->period_size);
+		sst_dbg("buf size = %d \n",
+				(int)substream->runtime->buffer_size);
+		memset(&stream->pcm_indirect, 0, sizeof(stream->pcm_indirect));
+		stream->pcm_indirect.hw_buffer_size =
+			snd_pcm_lib_buffer_bytes(substream);
+		stream->pcm_indirect.sw_buffer_size =
+			stream->pcm_indirect.hw_buffer_size;
+		/*return back the stream id*/
+		snprintf(substream->pcm->id, sizeof(substream->pcm->id),
+			"%d", stream->stream_id);
+		sst_dbg("stream id to user = %s\n", substream->pcm->id);
+	}
+	return ret_val;
+}
+
+static int snd_intelmad_hw_params(struct snd_pcm_substream *substream,
+				    struct snd_pcm_hw_params *hw_params)
+{
+	int ret_val = 0;
+
+	sst_dbg("called\n");
+	ret_val = snd_pcm_lib_malloc_pages(substream,
+			params_buffer_bytes(hw_params));
+	memset(substream->runtime->dma_area, 0, params_buffer_bytes(hw_params));
+	return ret_val;
+}
+
+static int snd_intelmad_hw_free(struct snd_pcm_substream *substream)
+{
+	sst_dbg("called\n");
+	return snd_pcm_lib_free_pages(substream);
+}
+
+/**
+* snd_intelmad_pcm_pointer- to send the current buffer pointer processed by hw
+* @substream:  substream for which the function is called
+* This function is called by ALSA framework to get the current hw buffer ptr
+* when a period is elapsed
+*/
+static snd_pcm_uframes_t snd_intelmad_pcm_pointer
+			(struct snd_pcm_substream *substream)
+{
+	/*struct snd_pcm_runtime *runtime = substream->runtime;*/
+	struct mad_stream_pvt *stream = NULL;
+	struct snd_intelmad *intelmaddata = NULL;
+	int ret_val = 0;
+	unsigned long buf_size = 0;
+
+	WARN_ON(!substream);
+
+	intelmaddata = snd_pcm_substream_chip(substream);
+	stream = substream->runtime->private_data;
+	if (stream->stream_status == INIT)
+		return 0;
+
+	stream->buf_ptr.str_id = stream->stream_id;
+
+#ifndef TIMER_TS
+	ret_val = intelmaddata->sstdrv_ops->control_set(SST_SND_BUFFER_POINTER,
+				&stream->buf_ptr);
+	if (0 != ret_val) {
+		sst_err("error code = 0x%x \n", ret_val);
+		return ret_val;
+	}
+	sst_dbg("samples reported out 0x%lx \n", stream->buf_ptr.buffer_ptr);
+	buf_size = frames_to_bytes(substream->runtime,
+				stream->buf_ptr.buffer_ptr);
+	sst_dbg(" bytes reported out = 0x%lx\n", buf_size);
+	if (buf_size > cum_bytes)
+		sst_err("excess reported\n");
+
+	if (substream->stream == STREAM_OPS_PLAYBACK)
+		stream->period_elapsed_ptr = snd_pcm_indirect_playback_pointer(
+			substream, &stream->pcm_indirect, buf_size);
+	else
+		stream->period_elapsed_ptr = snd_pcm_indirect_capture_pointer(
+			substream, &stream->pcm_indirect, buf_size);
+
+	sst_dbg("indirect value = 0x%lx\n", stream->period_elapsed_ptr);
+
+	return stream->period_elapsed_ptr;
+#else
+	stream->pcm_buf_pos += stream->pcm_jiffie;
+	stream->pcm_buf_pos %= stream->pcm_size;
+	return snd_pcm_indirect_playback_pointer(substream,
+		&stream->pcm_indirect, stream->pcm_buf_pos);
+#endif
+
+}
+
+/**
+* snd_intelmad_close- to free parameteres when stream is stopped
+* @substream:  substream for which the function is called
+* This function is called by ALSA framework when stream is stopped
+*/
+static int snd_intelmad_close(struct snd_pcm_substream *substream)
+{
+	struct snd_intelmad *intelmaddata = NULL;
+	struct mad_stream_pvt *stream = NULL;
+	int ret_val = 0;
+
+	WARN_ON(!substream);
+
+	stream = substream->runtime->private_data;
+
+	sst_dbg("called \n");
+	intelmaddata = snd_pcm_substream_chip(substream);
+	mutex_lock(&stream->mad_msg_wq.wq_lock);
+	sst_dbg("str id = %d\n", stream->stream_id);
+	/*SST API to actually stop/free the stream*/
+	ret_val = intelmaddata->sstdrv_ops->control_set(SST_SND_FREE,
+				&stream->stream_id);
+	kfree(substream->runtime->private_data);
+	mutex_unlock(&stream->mad_msg_wq.wq_lock);
+	return ret_val;
+}
+
+/**
+* snd_intelmad_open- to set runtime parameters during stream start
+* @substream:  substream for which the function is called
+* This function is called by ALSA framework when stream is started
+*/
+static int snd_intelmad_open(struct snd_pcm_substream *substream)
+{
+	struct snd_intelmad *intelmaddata;
+	struct snd_pcm_runtime *runtime;
+	struct mad_stream_pvt *stream;
+
+	WARN_ON(!substream);
+
+	sst_dbg("called \n");
+
+	intelmaddata = snd_pcm_substream_chip(substream);
+	runtime = substream->runtime;
+	/*set the runtime hw parameter with our local snd_pcm_hardware struct*/
+	runtime->hw = snd_intelmad_stream;
+	/*setup the internal datastruture stream pointers based on it being
+	playback or capture stream*/
+	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
+	if (NULL == stream)
+		return -ENOMEM;
+	stream->stream_id = 0;
+	stream->stream_status = INIT;
+	INIT_WORK(&stream->mad_msg_wq.wq, snd_card_pcm_wq_function);
+	INIT_WORK(&stream->mad_capture_wq.wq, start_capture);
+	mutex_init(&stream->mad_msg_wq.wq_lock);
+	runtime->private_data = stream;
+	return 0;
+}
+
+static struct snd_pcm_ops snd_intelmad_playback_ops = {
+	.open =	snd_intelmad_open,
+	.close = snd_intelmad_close,
+	.ioctl = snd_pcm_lib_ioctl,
+	.hw_params = snd_intelmad_hw_params,
+	.hw_free = snd_intelmad_hw_free,
+	.prepare = snd_intelmad_pcm_prepare,
+	.trigger = snd_intelmad_pcm_trigger,
+	.pointer = snd_intelmad_pcm_pointer,
+	.ack = snd_intelmad_pcm_ack,
+};
+
+static struct snd_pcm_ops snd_intelmad_capture_ops = {
+	.open = snd_intelmad_open,
+	.close = snd_intelmad_close,
+	.ioctl = snd_pcm_lib_ioctl,
+	.hw_params = snd_intelmad_hw_params,
+	.hw_free = snd_intelmad_hw_free,
+	.prepare = snd_intelmad_pcm_prepare,
+	.trigger = snd_intelmad_pcm_trigger,
+	.pointer = snd_intelmad_pcm_pointer,
+	.ack = snd_intelmad_pcm_ack,
+};
+
+int snd_intelmad_generate_netlink(u32 orig, enum eaudio_events event)
+{
+	struct sk_buff *skb = NULL;
+	struct nlattr *attr = NULL;
+	struct audio_genl_event *aud_event = NULL;
+	void *msg_header = NULL;
+	int size = 0, ret_val = 0;
+
+	/* allocate memory */
+	size = nla_total_size(sizeof(struct audio_genl_event)) + \
+				nla_total_size(0);
+
+	skb = genlmsg_new(size, GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+
+	/* add the genetlink message header */
+	msg_header = genlmsg_put(skb, 0, audio_event_seqnum++,
+				 &audio_event_genl_family, 0,
+				 AUDIO_GENL_CMD_EVENT);
+	if (!msg_header) {
+		nlmsg_free(skb);
+		return -ENOMEM;
+	}
+
+	/* fill the data */
+	attr = nla_reserve(skb, AUDIO_GENL_ATTR_EVENT, \
+			sizeof(struct audio_genl_event));
+
+	if (!attr) {
+		nlmsg_free(skb);
+		return -EINVAL;
+	}
+
+	aud_event = nla_data(attr);
+	if (!aud_event) {
+		nlmsg_free(skb);
+		return -EINVAL;
+	}
+
+	memset(aud_event, 0, sizeof(struct audio_genl_event));
+
+	aud_event->orig = orig;
+	aud_event->event = event;
+
+	/* send multicast genetlink message */
+	ret_val = genlmsg_end(skb, msg_header);
+	if (ret_val < 0) {
+		nlmsg_free(skb);
+		return ret_val;
+	}
+
+	ret_val = genlmsg_multicast(skb, 0, audio_event_mcgrp.id, GFP_ATOMIC);
+
+	if (ret_val)
+		printk(KERN_INFO "Failed to send a Genetlink message!\n");
+	return 0;
+}
+
+#ifdef REG_IRQ
+/**
+* snd_intelmad_intr_handler- interrupt handler
+*@irq :  irq number of the interrupt received
+*@dev: device context
+* This function is called when an interrupt is raised at the sound card
+*/
+static irqreturn_t snd_intelmad_intr_handler(int irq, void *dev)
+{
+	struct snd_intelmad *intelmaddata =
+			(struct snd_intelmad *)dev;
+	struct sc_reg_access pmic_reg = {0,};
+	int ret_val = 0;
+	u8 intsts = 0;
+	memcpy_fromio(&intsts,
+			((void *)(intelmaddata->int_base)),
+			sizeof(u8));
+	if (intsts != 0)
+		sst_dbg("intstatus = 0x%x\n", intsts);
+	switch (intelmaddata->sstdrv_ops->vendor_id) {
+	case SND_FS:
+		if (intsts & 0x1) {
+			/*send long push*/
+			ret_val = snd_intelmad_generate_netlink(1,
+						AUDIO_EVENT_LONG_PRESS);
+		}
+		if (intsts & 0x2) {
+			/*send short push*/
+			ret_val = snd_intelmad_generate_netlink(1,
+						AUDIO_EVENT_SHORT_PRESS);
+		}
+		if (intsts & 0x4) {
+			/*send headphone detect*/
+			ret_val = snd_intelmad_generate_netlink(1,
+						AUDIO_EVENT_HP_DETECT);
+		}
+		if (intsts & 0x8) {
+			/*send headset detect*/
+			ret_val = snd_intelmad_generate_netlink(1,
+						AUDIO_EVENT_HS_DETECT);
+		}
+		break;
+	case SND_MX:
+		if (intsts & 0x2) {
+			pmic_reg.reg_addr = 0x201;
+			ret_val = sst_sc_reg_access(&pmic_reg, PMIC_READ, 1);
+			if (0 != ret_val) {
+				/*pmic communication fails*/
+				sst_err("pmic commn failed \n");
+				return IRQ_HANDLED;
+			}
+			intsts = pmic_reg.value;
+			if (intsts & 0xc0)
+				/*send jack detect/undetect*/
+				sst_dbg("to handle jack sensing\n");
+		}
+		break;
+	case SND_NC:
+		if (intsts & 0x1) {
+			/*send headset detect/undetect*/
+			ret_val = snd_intelmad_generate_netlink(1,
+						AUDIO_EVENT_HS_DETECT);
+		}
+		if (intsts & 0x2) {
+			/*send headphone detect/undetect*/
+			ret_val = snd_intelmad_generate_netlink(1,
+						AUDIO_EVENT_HP_DETECT);
+		}
+		if (intsts & 0x4) {
+			/*send short push*/
+			ret_val = snd_intelmad_generate_netlink(1,
+						AUDIO_EVENT_SHORT_PRESS);
+		}
+		if (intsts & 0x8) {
+			/*send long push*/
+			ret_val = snd_intelmad_generate_netlink(1,
+						AUDIO_EVENT_LONG_PRESS);
+		}
+		break;
+	}
+	return IRQ_HANDLED;
+}
+static int __devinit snd_intelmad_register_irq(
+					struct snd_intelmad *intelmaddata)
+{
+	int ret_val = 0;
+	u32 regbase = AUDINT_BASE, regsize = 8;
+
+	/* interpret irq field */
+	sst_dbg("irq = 0x%x\n", intelmaddata->irq);
+
+	if ((intelmaddata->irq) & PMIC_SOUND_IRQ_TYPE_MASK) {
+		/* irq -> GPE_ID */
+		intelmaddata->irq = intelmaddata->irq &
+				(~PMIC_SOUND_IRQ_TYPE_MASK);
+		sst_dbg("gpe = 0x%x\n", intelmaddata->irq);
+		ret_val = request_gpe(intelmaddata->irq,
+				(gpio_function_t)snd_intelmad_intr_handler,
+				intelmaddata, 0);
+		if (ret_val) {
+			sst_dbg("cannot register gpe\n");
+			return ret_val;
+		}
+
+	} else {
+		/* irq -> system irq */
+		ret_val = request_irq(intelmaddata->irq,
+					snd_intelmad_intr_handler,
+					IRQF_SHARED, DRIVER_NAME,
+					intelmaddata);
+		if (0 != ret_val) {
+			sst_dbg("cannot register IRQ\n");
+			return ret_val;
+		}
+	}
+
+	intelmaddata->int_base = ioremap_nocache(regbase, regsize);
+	return ret_val;
+}
+static int __devinit snd_intelmad_register_netlink(void)
+{
+	int ret_val = 0;
+
+	ret_val = genl_register_family(&audio_event_genl_family);
+	if (0 != ret_val) {
+		sst_dbg("netlink registration failed\n");
+		return ret_val;
+	}
+	ret_val = genl_register_mc_group(&audio_event_genl_family,
+					&audio_event_mcgrp);
+	if (ret_val) {
+		sst_dbg("netlink group registration failed\n");
+		genl_unregister_family(&audio_event_genl_family);
+		return ret_val;
+	}
+	return ret_val;
+}
+#endif
+
+static int __devinit snd_intelmad_sst_register(
+					struct snd_intelmad *intelmaddata)
+{
+	int ret_val = 0;
+	struct sc_reg_access pmic_reg = {0,};
+
+	pmic_reg.reg_addr = 0;
+	ret_val = sst_sc_reg_access(&pmic_reg, PMIC_READ, 1);
+
+	if (0 != ret_val)
+		return ret_val;
+
+	vendor_id = pmic_reg.value & (MASK2|MASK1|MASK0);
+	sst_info("orginal reg n extrated vendor id  = 0x%x %d\n",
+		pmic_reg.value, vendor_id);
+	if (vendor_id < 0 || vendor_id > 2) {
+		sst_err("vendor card not supported!!\n");
+		return -EIO;
+	}
+	intelmaddata->sstdrv_ops->module_name = SST_CARD_NAMES;
+	intelmaddata->sstdrv_ops->vendor_id = vendor_id;
+	intelmaddata->sstdrv_ops->scard_ops = &v[vendor_id];
+
+	/*registering with SST driver to get access to SST APIs to use*/
+	ret_val = register_sst_card(intelmaddata->sstdrv_ops);
+	if (0 != ret_val) {
+			sst_err("sst card registration failed\n");
+			return ret_val;
+	}
+
+	vendor_id = intelmaddata->sstdrv_ops->vendor_id;
+	intelmaddata->pmic_status = PMIC_UNINIT;
+	return ret_val;
+}
+
+/*Driver Init/exit functionalities*/
+/**
+* snd_intelmad_pcm- to setup pcm for the card
+* @card:  pointer to the sound card structure
+*@intelmaddata: pointer to internal context
+* This function is called from probe function to set up pcm params and functions
+*/
+static int __devinit snd_intelmad_pcm(struct snd_card *card,
+				struct snd_intelmad *intelmaddata)
+{
+	struct snd_pcm *pcm;
+	int i, ret_val = 0;
+	char name[32] = INTEL_MAD;
+
+	WARN_ON(!card);
+	WARN_ON(!intelmaddata);
+
+	for (i = 0; i < MAX_DEVICES; i++) {
+		ret_val = snd_pcm_new(card, name, i, PLAYBACK_COUNT,
+				CAPTURE_COUNT, &pcm);
+		if (0 != ret_val)
+			break;
+		/*setup the ops for playback and capture streams*/
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
+				&snd_intelmad_playback_ops);
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
+				&snd_intelmad_capture_ops);
+		/*setup private data which can be retrieved when required*/
+		pcm->private_data = intelmaddata;
+		pcm->info_flags = 0;
+		strncpy(pcm->name, card->shortname, strlen(card->shortname));
+		/*allocate dma pages for ALSA stream operations*/
+		snd_pcm_lib_preallocate_pages_for_all(pcm,
+			SNDRV_DMA_TYPE_CONTINUOUS,
+			snd_dma_continuous_data(GFP_KERNEL),
+			MIN_BUFFER, MAX_BUFFER);
+	}
+	return ret_val;
+}
+
+/**
+* snd_intelmad_mixer- to setup mixer settings of the card
+*@intelmaddata: pointer to internal context
+* This function is called from probe function to set up mixer controls
+*/
+static int __devinit snd_intelmad_mixer(struct snd_intelmad *intelmaddata)
+{
+	struct snd_card *card = NULL;
+	unsigned int idx;
+	int ret_val = 0;
+	char *mixername = "IntelMAD Controls";
+
+	WARN_ON(!intelmaddata);
+
+	card = intelmaddata->card;
+
+	strncpy(card->mixername, mixername, strlen(mixername));
+	/*add all widget controls and expose the same*/
+	for (idx = 0; idx < ARRAY_SIZE(snd_intelmad_controls); idx++) {
+		ret_val = snd_ctl_add(card,
+				snd_ctl_new1(&snd_intelmad_controls[idx],
+				intelmaddata));
+		sst_dbg("mixer[idx]=%d added \n", idx);
+		if (0 != ret_val)
+			break;
+	}
+	return ret_val;
+}
+
+/**
+* snd_intelmad_dev_free- to free device
+*@device:     pointer to the device
+* This function is called when driver module is removed
+*/
+static int snd_intelmad_dev_free(struct snd_device *device)
+{
+	struct snd_intelmad *intelmaddata;
+
+	WARN_ON(!device);
+
+	intelmaddata = device->device_data;
+
+	sst_dbg("called\n");
+	snd_card_free(intelmaddata->card);
+	genl_unregister_family(&audio_event_genl_family);
+	unregister_sst_card(intelmaddata->sstdrv_ops);
+
+	/*free allocated memory for internal context*/
+	kfree(intelmaddata->sstdrv_ops);
+	kfree(intelmaddata);
+	return 0;
+}
+
+/**
+* snd_intelmad_create- called from probe to create a snd device
+*@intelmaddata :  pointer to the internal context
+*@card :  pointer to the sound card
+* This function is called when driver module is started
+*/
+static int __devinit snd_intelmad_create(
+		struct snd_intelmad *intelmaddata,
+		struct snd_card *card)
+{
+	int ret_val = 0;
+	static struct snd_device_ops ops = {
+		.dev_free =	snd_intelmad_dev_free,
+	};
+
+	WARN_ON(!intelmaddata);
+	WARN_ON(!card);
+	/*ALSA api to register for the device*/
+	ret_val = snd_device_new(card, SNDRV_DEV_LOWLEVEL, intelmaddata, &ops);
+	return ret_val;
+}
+
+/*********************************************************************
+ *		SPI Functions
+ *********************************************************************/
+
+
+/**
+* snd_intelmad_probe- function registred for init
+*@spi :  pointer to the spi device context
+* This function is called when the device is initialized
+*/
+int __devinit snd_intelmad_probe(struct spi_device *spi)
+{
+	struct snd_card *card = NULL;
+	int ret_val = 0;
+	struct snd_intelmad *intelmaddata = NULL;
+
+	sst_dbg("called \n");
+
+	/*allocate memory for saving internal context and working*/
+	intelmaddata = kzalloc(sizeof(*intelmaddata), GFP_KERNEL);
+	if (NULL == intelmaddata)
+		return -ENOMEM;
+
+	/*allocate memory for LPE API set*/
+	intelmaddata->sstdrv_ops = kzalloc(sizeof(struct intel_sst_card_ops),
+					GFP_KERNEL);
+	if (NULL == intelmaddata->sstdrv_ops) {
+		sst_err("mem alloctn fail \n");
+		kfree(intelmaddata);
+		return -ENOMEM;
+	}
+
+	/*create a card instance with ALSA framework*/
+	card = snd_card_new(card_index, card_id, THIS_MODULE, 0);
+	if (NULL == card)
+		return -ENOMEM;
+
+	intelmaddata->spi = spi;
+	intelmaddata->irq = spi->irq;
+	dev_set_drvdata(&spi->dev, intelmaddata);
+	intelmaddata->card = card;
+	intelmaddata->card_id = card_id;
+	intelmaddata->card_index = card_index;
+	strncpy(card->driver, INTEL_MAD, strlen(INTEL_MAD));
+	strncpy(card->shortname, INTEL_MAD, strlen(INTEL_MAD));
+
+#ifdef REG_IRQ
+	ret_val = snd_intelmad_register_irq(intelmaddata);
+	if (0 != ret_val) {
+		sst_err("snd_intelmad_register_irq fail\n");
+		goto free_allocs;
+	}
+	ret_val = snd_intelmad_register_netlink();
+		if (0 == ret_val) {
+			sst_dbg("...complete\n");
+			return ret_val;
+	}
+#endif
+
+	/*internal function call to register device with ALSA*/
+	ret_val = snd_intelmad_create(intelmaddata, card);
+	if (0 != ret_val) {
+		sst_err("snd_intelmad_create failed\n");
+		goto free_allocs;
+	}
+
+	ret_val = snd_intelmad_pcm(card, intelmaddata);
+	if (0 != ret_val) {
+		sst_err("snd_intelmad_pcm failed\n");
+		goto free_allocs;
+	}
+
+	ret_val = snd_intelmad_mixer(intelmaddata);
+	if (0 != ret_val) {
+		sst_err("snd_intelmad_mixer failed\n");
+		goto free_allocs;
+	}
+
+	card->private_data = &intelmaddata;
+	snd_card_set_dev(card, &spi->dev);
+	ret_val = snd_card_register(card);
+	if (0 != ret_val)
+		goto free_allocs;
+
+
+	intelmaddata->sstdrv_ops->module_name = SST_CARD_NAMES;
+	/*registering with LPE driver to get access to LPE APIsito use*/
+	ret_val = snd_intelmad_sst_register(intelmaddata);
+	if (0 == ret_val) {
+		ret_val = intelmaddata->sstdrv_ops->scard_ops->init_card();
+		intelmaddata->pmic_status = PMIC_INIT;
+		sst_dbg("...complete\n");
+		return ret_val;
+	}
+
+	sst_err("registering with LPE failed \n");
+
+free_allocs:
+	/*TODO: unregister IRQ*/
+	sst_err("probe failed\n");
+	/*snd_card_free(card);*/
+	kfree(intelmaddata->sstdrv_ops);
+	kfree(intelmaddata);
+	return ret_val;
+}
+
+
+/**
+* snd_intelmad_remove- function registred for exit
+*@spi :  pointer to the spi device context
+* This function is called when the device is uninitialized
+*/
+static int snd_intelmad_remove(struct spi_device *spi)
+{
+	struct snd_intelmad *intelmaddata =
+				dev_get_drvdata(&spi->dev);
+	/*
+	 * TODO:: de-register interrupt handler
+	 */
+
+	if (intelmaddata) {
+		snd_card_free(intelmaddata->card);
+		genl_unregister_family(&audio_event_genl_family);
+		unregister_sst_card(intelmaddata->sstdrv_ops);
+		/*free allocated memory for internal context*/
+		kfree(intelmaddata->sstdrv_ops);
+		kfree(intelmaddata);
+	}
+	return 0;
+}
+
+/*********************************************************************
+ *		Driver initialization and exit
+ *********************************************************************/
+
+static struct spi_driver snd_intelmad_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.bus = &spi_bus_type,
+		.owner = THIS_MODULE,
+	},
+	.probe = snd_intelmad_probe,
+	.remove = __devexit_p(snd_intelmad_remove),
+};
+
+/*
+* alsa_card_intelmad_init- driver init function
+* This function is called when driver module is inserted
+*/
+static int __init alsa_card_intelmad_init(void)
+{
+	sst_dbg("called\n");
+	return spi_register_driver(&snd_intelmad_driver);
+}
+
+/**
+* alsa_card_intelmad_exit- driver exit function
+* This function is called when driver module is removed
+*/
+static void __exit alsa_card_intelmad_exit(void)
+{
+	sst_dbg("called\n");
+	spi_unregister_driver(&snd_intelmad_driver);
+}
+
+module_init(alsa_card_intelmad_init)
+module_exit(alsa_card_intelmad_exit)
+
-- 
1.5.4.5
