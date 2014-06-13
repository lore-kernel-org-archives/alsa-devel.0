From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 07/19] ASoC: Intel: add mrfld pipelines
Date: Fri, 13 Jun 2014 18:03:56 +0530
Message-ID: <1402662848-24534-8-git-send-email-vinod.koul@intel.com>
References: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id EAC2D261A2F
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 14:32:58 +0200 (CEST)
In-Reply-To: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Merrifield DSP used various pipelines to identify the streams and processing
modules. Add these defination in the pcm driver and also add a table for device
entries to firmware pipeline id conversion

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 arch/x86/include/asm/platform_sst_audio.h |   78 ++++++++++++++++++++++
 sound/soc/intel/sst-atom-controls.h       |   30 +++++++++
 sound/soc/intel/sst-mfld-platform-pcm.c   |  100 ++++++++++++++++++++++++++---
 sound/soc/intel/sst-mfld-platform.h       |   18 +++++
 4 files changed, 217 insertions(+), 9 deletions(-)
 create mode 100644 arch/x86/include/asm/platform_sst_audio.h
 create mode 100644 sound/soc/intel/sst-atom-controls.h

diff --git a/arch/x86/include/asm/platform_sst_audio.h b/arch/x86/include/asm/platform_sst_audio.h
new file mode 100644
index 0000000..0a4e140
--- /dev/null
+++ b/arch/x86/include/asm/platform_sst_audio.h
@@ -0,0 +1,78 @@
+/*
+ * platform_sst_audio.h:  sst audio platform data header file
+ *
+ * Copyright (C) 2012-14 Intel Corporation
+ * Author: Jeeja KP <jeeja.kp@intel.com>
+ * 	Omair Mohammed Abdullah <omair.m.abdullah@intel.com>
+ *	Vinod Koul ,vinod.koul@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ */
+#ifndef _PLATFORM_SST_AUDIO_H_
+#define _PLATFORM_SST_AUDIO_H_
+
+#include <linux/sfi.h>
+
+enum sst_audio_task_id_mrfld {
+	SST_TASK_ID_NONE = 0,
+	SST_TASK_ID_SBA = 1,
+	SST_TASK_ID_MEDIA = 3,
+	SST_TASK_ID_MAX = SST_TASK_ID_MEDIA,
+};
+
+/* Device IDs for Merrifield are Pipe IDs,
+ * ref: DSP spec v0.75 */
+enum sst_audio_device_id_mrfld {
+	/* Output pipeline IDs */
+	PIPE_ID_OUT_START = 0x0,
+	PIPE_CODEC_OUT0 = 0x2,
+	PIPE_CODEC_OUT1 = 0x3,
+	PIPE_SPROT_LOOP_OUT = 0x4,
+	PIPE_MEDIA_LOOP1_OUT = 0x5,
+	PIPE_MEDIA_LOOP2_OUT = 0x6,
+	PIPE_VOIP_OUT = 0xC,
+	PIPE_PCM0_OUT = 0xD,
+	PIPE_PCM1_OUT = 0xE,
+	PIPE_PCM2_OUT = 0xF,
+	PIPE_MEDIA0_OUT = 0x12,
+	PIPE_MEDIA1_OUT = 0x13,
+/* Input Pipeline IDs */
+	PIPE_ID_IN_START = 0x80,
+	PIPE_CODEC_IN0 = 0x82,
+	PIPE_CODEC_IN1 = 0x83,
+	PIPE_SPROT_LOOP_IN = 0x84,
+	PIPE_MEDIA_LOOP1_IN = 0x85,
+	PIPE_MEDIA_LOOP2_IN = 0x86,
+	PIPE_VOIP_IN = 0x8C,
+	PIPE_PCM0_IN = 0x8D,
+	PIPE_PCM1_IN = 0x8E,
+	PIPE_MEDIA0_IN = 0x8F,
+	PIPE_MEDIA1_IN = 0x90,
+	PIPE_MEDIA2_IN = 0x91,
+	PIPE_RSVD = 0xFF,
+};
+
+/* The stream map for each platform consists of an array of the below
+ * stream map structure.
+ */
+struct sst_dev_stream_map {
+	u8 dev_num;		/* device id */
+	u8 subdev_num;		/* substream */
+	u8 direction;
+	u8 device_id;		/* fw id */
+	u8 task_id;		/* fw task */
+	u8 status;
+};
+
+struct sst_platform_data {
+	/* Intel software platform id*/
+	struct sst_dev_stream_map *pdev_strm_map;
+	unsigned int strm_map_size;
+};
+
+int add_sst_platform_device(void);
+#endif
+
diff --git a/sound/soc/intel/sst-atom-controls.h b/sound/soc/intel/sst-atom-controls.h
new file mode 100644
index 0000000..14063ab
--- /dev/null
+++ b/sound/soc/intel/sst-atom-controls.h
@@ -0,0 +1,30 @@
+/*
+ *  Copyright (C) 2013-14 Intel Corp
+ *  Author: Ramesh Babu <ramesh.babu.koul@intel.com>
+ *  	Omair M Abdullah <omair.m.abdullah@intel.com>
+ *  	Samreen Nilofer <samreen.nilofer@intel.com>
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
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ */
+
+#ifndef __SST_CONTROLS_V2_H__
+#define __SST_CONTROLS_V2_H__
+
+enum {
+	MERR_DPCM_AUDIO = 0,
+	MERR_DPCM_COMPR,
+};
+
+
+#endif
diff --git a/sound/soc/intel/sst-mfld-platform-pcm.c b/sound/soc/intel/sst-mfld-platform-pcm.c
index 6e7bfb1..7de8788 100644
--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -1,7 +1,7 @@
 /*
  *  sst_mfld_platform.c - Intel MID Platform driver
  *
- *  Copyright (C) 2010-2013 Intel Corp
+ *  Copyright (C) 2010-2014 Intel Corp
  *  Author: Vinod Koul <vinod.koul@intel.com>
  *  Author: Harsha Priya <priya.harsha@intel.com>
  *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -27,7 +27,9 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/compress_driver.h>
+#include <asm/platform_sst_audio.h>
 #include "sst-mfld-platform.h"
+#include "sst-atom-controls.h"
 
 struct sst_device *sst;
 static DEFINE_MUTEX(sst_lock);
@@ -92,6 +94,13 @@ static struct snd_pcm_hardware sst_platform_pcm_hw = {
 	.fifo_size = SST_FIFO_SIZE,
 };
 
+static struct sst_dev_stream_map dpcm_strm_map[] = {
+	{0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF}, /* Reserved, not in use */
+	{MERR_DPCM_AUDIO, 0, SNDRV_PCM_STREAM_PLAYBACK, PIPE_MEDIA1_IN, SST_TASK_ID_MEDIA, 0},
+	{MERR_DPCM_COMPR, 0, SNDRV_PCM_STREAM_PLAYBACK, PIPE_MEDIA0_IN, SST_TASK_ID_MEDIA, 0},
+	{MERR_DPCM_AUDIO, 0, SNDRV_PCM_STREAM_CAPTURE, PIPE_PCM1_OUT, SST_TASK_ID_MEDIA, 0},
+};
+
 /* MFLD - MSIC */
 static struct snd_soc_dai_driver sst_platform_dai[] = {
 {
@@ -175,12 +184,36 @@ static void sst_fill_pcm_params(struct snd_pcm_substream *substream,
 	memset(param->uc.pcm_params.channel_map, 0, sizeof(u8));
 
 }
+
+static int sst_get_stream_mapping(int dev, int sdev, int dir,
+	struct sst_dev_stream_map *map, int size)
+{
+	int i;
+
+	if (map == NULL)
+		return -EINVAL;
+
+
+	/* index 0 is not used in stream map */
+	for (i = 1; i < size; i++) {
+		if ((map[i].dev_num == dev) && (map[i].direction == dir))
+			return i;
+	}
+	return 0;
+}
+
 int sst_fill_stream_params(void *substream,
-	struct snd_sst_params *str_params, bool is_compress)
+	const struct sst_data *ctx, struct snd_sst_params *str_params, bool is_compress)
 {
+	int map_size;
+	int index;
+	struct sst_dev_stream_map *map;
 	struct snd_pcm_substream *pstream = NULL;
 	struct snd_compr_stream *cstream = NULL;
 
+	map = ctx->pdata->pdev_strm_map;
+	map_size = ctx->pdata->strm_map_size;
+
 	if (is_compress == true)
 		cstream = (struct snd_compr_stream *)substream;
 	else
@@ -189,11 +222,32 @@ int sst_fill_stream_params(void *substream,
 	str_params->stream_type = SST_STREAM_TYPE_MUSIC;
 
 	/* For pcm streams */
-	if (pstream)
+	if (pstream) {
+		index = sst_get_stream_mapping(pstream->pcm->device,
+					  pstream->number, pstream->stream,
+					  map, map_size);
+		if (index <= 0)
+			return -EINVAL;
+
+		str_params->stream_id = index;
+		str_params->device_type = map[index].device_id;
+		str_params->task = map[index].task_id;
+
 		str_params->ops = (u8)pstream->stream;
-	if (cstream)
-		str_params->ops = (u8)cstream->direction;
+	}
+
+	if (cstream) {
+		index = sst_get_stream_mapping(cstream->device->device,
+					       0, cstream->direction,
+					       map, map_size);
+		if (index <= 0)
+			return -EINVAL;
+		str_params->stream_id = index;
+		str_params->device_type = map[index].device_id;
+		str_params->task = map[index].task_id;
 
+		str_params->ops = (u8)cstream->direction;
+	}
 	return 0;
 }
 
@@ -206,6 +260,7 @@ static int sst_platform_alloc_stream(struct snd_pcm_substream *substream,
 	struct snd_sst_params str_params = {0};
 	struct snd_sst_alloc_params_ext alloc_params = {0};
 	int ret_val = 0;
+	struct sst_data *ctx = snd_soc_platform_get_drvdata(platform);
 
 	/* set codec params and inform SST driver the same */
 	sst_fill_pcm_params(substream, &param);
@@ -216,7 +271,7 @@ static int sst_platform_alloc_stream(struct snd_pcm_substream *substream,
 	str_params.codec = SST_CODEC_TYPE_PCM;
 
 	/* fill the device type and stream id to pass to SST driver */
-	ret_val = sst_fill_stream_params(substream, &str_params, false);
+	ret_val = sst_fill_stream_params(substream, ctx, &str_params, false);
 	if (ret_val < 0)
 		return ret_val;
 
@@ -321,7 +376,22 @@ static void sst_media_close(struct snd_pcm_substream *substream,
 		ret_val = stream->ops->close(str_id);
 	module_put(sst->dev->driver->owner);
 	kfree(stream);
-	return;
+}
+
+static inline unsigned int get_current_pipe_id(struct snd_soc_platform *platform,
+					       struct snd_pcm_substream *substream)
+{
+	struct sst_data *sst = snd_soc_platform_get_drvdata(platform);
+	struct sst_dev_stream_map *map = sst->pdata->pdev_strm_map;
+	struct sst_runtime_stream *stream =
+			substream->runtime->private_data;
+	u32 str_id = stream->stream_info.str_id;
+	unsigned int pipe_id;
+	pipe_id = map[str_id].device_id;
+
+	pr_debug("%s: got pipe_id = %#x for str_id = %d\n",
+		 __func__, pipe_id, str_id);
+	return pipe_id;
 }
 
 static int sst_media_prepare(struct snd_pcm_substream *substream,
@@ -498,10 +568,22 @@ static const struct snd_soc_component_driver sst_component = {
 
 static int sst_platform_probe(struct platform_device *pdev)
 {
+	struct sst_data *drv;
 	int ret;
+	struct sst_platform_data *pdata = pdev->dev.platform_data;
+
+	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
+	if (sst == NULL) {
+		pr_err("kzalloc failed\n");
+		return -ENOMEM;
+	}
+
+	pdata->pdev_strm_map = dpcm_strm_map;
+	pdata->strm_map_size = ARRAY_SIZE(dpcm_strm_map);
+	drv->pdata = pdata;
+	mutex_init(&drv->lock);
+	dev_set_drvdata(&pdev->dev, drv);
 
-	pr_debug("sst_platform_probe called\n");
-	sst = NULL;
 	ret = snd_soc_register_platform(&pdev->dev, &sst_soc_platform_drv);
 	if (ret) {
 		pr_err("registering soc platform failed\n");
diff --git a/sound/soc/intel/sst-mfld-platform.h b/sound/soc/intel/sst-mfld-platform.h
index aa5ddbb..33891a8 100644
--- a/sound/soc/intel/sst-mfld-platform.h
+++ b/sound/soc/intel/sst-mfld-platform.h
@@ -144,10 +144,28 @@ struct sst_device {
 	char *name;
 	struct device *dev;
 	struct sst_ops *ops;
+	struct platform_device *pdev;
 	struct compress_sst_ops *compr_ops;
 };
 
+struct sst_data;
+
 void sst_set_stream_status(struct sst_runtime_stream *stream, int state);
+struct sst_algo_int_control_v2 {
+	struct soc_mixer_control mc;
+	u16 module_id; /* module identifieer */
+	u16 pipe_id; /* location info: pipe_id + instance_id */
+	u16 instance_id;
+	unsigned int value; /* Value received is stored here */
+};
+
+struct sst_data {
+	struct platform_device *pdev;
+	struct sst_platform_data *pdata;
+	struct mutex lock;
+};
+
 int sst_register_dsp(struct sst_device *sst);
 int sst_unregister_dsp(struct sst_device *sst);
+
 #endif
-- 
1.7.0.4
