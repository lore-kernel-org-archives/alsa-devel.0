From: ramesh.babu@intel.com
Subject: [PATCH 2/5] [RFC]intel_hdmi_audio: interface module
Date: Mon, 22 Nov 2010 19:09:43 +0530
Message-ID: <1290433186-31628-2-git-send-email-ramesh.babu@intel.com>
References: <1290433186-31628-1-git-send-email-ramesh.babu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id B77391039D6
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 14:34:17 +0100 (CET)
In-Reply-To: <1290433186-31628-1-git-send-email-ramesh.babu@intel.com>
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
Cc: Sailaja Bandarupalli <sailaja.bandarupalli@intel.com>, Ramesh Babu K V <ramesh.babu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Ramesh Babu K V <ramesh.babu@intel.com>

This patch creates intel_mid_hdmi_audio_if.c file.  This
interface module of the driver communicates with client driver
(HDMI display module) for receiving hot plug/unplug and other
events such as Buffer complete interrupt.  ALSA sound card
will be created dynamically when hot plug event received and
removed when unplug event is received.

Signed-off-by: Ramesh Babu K V <ramesh.babu@intel.com>
Signed-off-by: Sailaja Bandarupalli <sailaja.bandarupalli@intel.com>
---
 .../intel_mid_hdmi/intel_mid_hdmi_audio_if.c       |  224 ++++++++++++++++++++
 1 files changed, 224 insertions(+), 0 deletions(-)
 create mode 100644 sound/drivers/intel_mid_hdmi/intel_mid_hdmi_audio_if.c

diff --git a/sound/drivers/intel_mid_hdmi/intel_mid_hdmi_audio_if.c b/sound/drivers/intel_mid_hdmi/intel_mid_hdmi_audio_if.c
new file mode 100644
index 0000000..aac9335
--- /dev/null
+++ b/sound/drivers/intel_mid_hdmi/intel_mid_hdmi_audio_if.c
@@ -0,0 +1,224 @@
+/*
+ *   intel_mid_hdmi_audio_if.h - Intel HDMI audio driver for MID
+ *
+ *  Copyright (C) 2010 Intel Corp
+ *  Authors:	Sailaja Bandarupalli <sailaja.bandarupalli@intel.com>
+ *		Ramesh Babu K V <ramesh.babu@intel.com>
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
+ * ALSA driver for Intel MID HDMI audio controller.  This file contains
+ * interface functions exposed to HDMI Display driver and code to register
+ * with ALSA framework..
+ */
+
+#include <sound/initval.h>
+#include <sound/pcm.h>
+#include <sound/core.h>
+#include "intel_mid_hdmi_audio.h"
+#include "../../../drivers/staging/mrst/drv/psb_intel_hdmi.h"
+
+#define PCM_INDEX		0
+#define MAX_PB_STREAMS		1
+#define MAX_CAP_STREAMS		0
+
+/**
+ * snd_intelhad_dev_free - to free alsa card instance
+ *
+ * @device: pointer to device
+ *
+ * This function is called when the hdmi cable is un plugged
+ */
+static int snd_intelhad_dev_free(struct snd_device *device)
+{
+	struct snd_intelhad *intelhaddata;
+
+	BUG_ON(!device);
+	pr_debug("had: snd_intelhad_dev_free called\n");
+	intelhaddata = device->device_data;
+	return 0;
+}
+
+/**
+ * snd_intelhad_create - to crete alsa card instance
+ *
+ * @intelhaddata: pointer to internal context
+ * @card: pointer to card
+ *
+ * This function is called when the hdmi cable is plugged in
+ */
+static int __devinit snd_intelhad_create(
+		struct snd_intelhad *intelhaddata,
+		struct snd_card *card)
+{
+	int retval;
+	static struct snd_device_ops ops = {
+		.dev_free =	snd_intelhad_dev_free,
+	};
+
+	BUG_ON(!intelhaddata);
+	BUG_ON(!card);
+	/* ALSA api to register the device */
+	retval = snd_device_new(card, SNDRV_DEV_LOWLEVEL, intelhaddata, &ops);
+	return retval;
+}
+/**
+ * snd_intelhad_pcm_free - to free the memory allocated
+ *
+ * @pcm: pointer to pcm instance
+ * This function is called when the device is removed
+ */
+static void snd_intelhad_pcm_free(struct snd_pcm *pcm)
+{
+	pr_debug("had:Freeing PCM preallocated pages\n");
+	snd_pcm_lib_preallocate_free_for_all(pcm);
+}
+
+/**
+ * had_hot_plug - to create sound card instance for HDMI audio playabck
+ *
+ *
+ * This function is called when the hdmi cable is plugged in. This function
+ * creates and registers the sound card with ALSA
+ */
+static int had_hot_plug(void)
+{
+	int retval;
+	struct snd_pcm *pcm;
+	struct snd_card *card;
+
+	pr_debug("had: Hot plug event received\n");
+	/* create a card instance with ALSA framework */
+	retval = snd_card_create(hdmi_card_index, hdmi_card_id,
+				THIS_MODULE, 0, &card);
+	if (retval) {
+		pr_err("had:Error while creating snd card\n");
+		return retval;
+	}
+
+	intelhaddata->card = card;
+	intelhaddata->card_id = hdmi_card_id;
+	intelhaddata->card_index = card->number;
+	intelhaddata->playback_cnt = 0;
+	strncpy(card->driver, INTEL_HAD, strlen(INTEL_HAD));
+	strncpy(card->shortname, INTEL_HAD, strlen(INTEL_HAD));
+
+	retval = snd_pcm_new(card, INTEL_HAD, PCM_INDEX, MAX_PB_STREAMS,
+						MAX_CAP_STREAMS, &pcm);
+	if (retval) {
+		pr_err("had:_pcm_new failed\n");
+		goto err;
+	}
+	/* setup private data which can be retrieved when required */
+	pcm->private_data = intelhaddata;
+	pcm->private_free = snd_intelhad_pcm_free;
+	pcm->info_flags = 0;
+	strncpy(pcm->name, card->shortname, strlen(card->shortname));
+	/* setup the ops for palyabck */
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
+			    &snd_intelhad_playback_ops);
+	/* allocate dma pages for ALSA stream operations */
+	retval = snd_pcm_lib_preallocate_pages_for_all(pcm,
+			SNDRV_DMA_TYPE_CONTINUOUS,
+			snd_dma_continuous_data(GFP_KERNEL),
+			HAD_MIN_BUFFER, HAD_MAX_BUFFER);
+	if (retval) {
+		pr_err("had:preallocation failed\n");
+		goto err;
+	}
+	/* internal function call to register device with ALSA */
+	retval = snd_intelhad_create(intelhaddata, card);
+	if (retval)
+		goto err;
+	card->private_data = &intelhaddata;
+	retval = snd_card_register(card);
+	if (retval) {
+		pr_err("had: snd_card_register failed\n");
+		goto err;
+	}
+	intelhaddata->query_ops->hdmi_audio_get_caps(
+				HAD_GET_ELD, &intelhaddata->eeld);
+	retval = intelhaddata->reg_ops->hdmi_audio_write_register(
+						AUD_HDMI_STATUS, SET_BIT0);
+	return retval;
+err:
+	pr_err("had: Error returned from snd api\n");
+	snd_card_free(card);
+	return retval;
+}
+
+/**
+ * had_event_handler - Call back function to handle events
+ *
+ * @event_type: Event type to handle
+ * @data: data related to the event_type
+ *
+ * This function is invoked to handle HDMI events from client driver.
+ */
+int had_event_handler(enum had_event_type event_type, void *data)
+{
+	int retval = 0;
+	enum intel_had_aud_buf_type buf_id;
+	struct pcm_stream_info *stream;
+	u32 buf_size;
+
+	pr_debug("had:called _event_handler with event#%d\n", event_type);
+	switch (event_type) {
+	case HAD_EVENT_HOT_PLUG:
+		retval = had_hot_plug();
+		break;
+	case HAD_EVENT_HOT_UNPLUG:
+		retval = snd_card_free(intelhaddata->card);
+		break;
+	case HAD_EVENT_PM_CHANGING:
+		/*Run-time PM is not yet supported*/
+		retval = -EIO;
+		break;
+	case HAD_EVENT_AUDIO_BUFFER_DONE:
+		stream = &intelhaddata->stream_info;
+
+
+		buf_id = intelhaddata->curr_buf;
+		pr_debug("had:called _event_handler with BUFFER DONE event for\
+							 Buf#%d\n", buf_id);
+		buf_size =  intelhaddata->buf_info[buf_id].buf_size;
+		intelhaddata->stream_info.buffer_rendered += buf_size;
+		intelhaddata->buf_info[buf_id].is_valid = true;
+		stream->period_elapsed(stream->had_substream);
+		if (intelhaddata->valid_buf_cnt-1 == buf_id)
+			intelhaddata->curr_buf = HAD_BUF_TYPE_A;
+		else
+			intelhaddata->curr_buf++;
+		/*Reprogram the registers with addr and length*/
+		retval = intelhaddata->reg_ops->hdmi_audio_write_register(
+				AUD_BUF_A_LENGTH + (buf_id * REG_WIDTH),
+				buf_size);
+		retval = intelhaddata->reg_ops->hdmi_audio_write_register(
+				AUD_BUF_A_ADDR+(buf_id * REG_WIDTH),
+				intelhaddata->buf_info[buf_id].buf_addr|
+				REG_BIT_0 | REG_BIT_1);
+		break;
+	case HAD_EVENT_AUDIO_BUFFER_UNDERRUN:
+		/*To be handle  error handling*/
+		retval = -EIO;
+		break;
+	default:
+		pr_debug("had:error un-handled event !!\n");
+		retval = -EINVAL;
+		break;
+	}
+	return retval;
+}
-- 
1.6.2.5
