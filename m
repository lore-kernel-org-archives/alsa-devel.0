From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: [RFC PATCH 2/2] ASoC: add compress stream support
Date: Tue, 31 Jul 2012 12:11:40 +0530
Message-ID: <1343716900-23491-3-git-send-email-vinod.koul@linux.intel.com>
References: <1343716900-23491-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 203B3265CDA
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 08:41:02 +0200 (CEST)
In-Reply-To: <1343716900-23491-1-git-send-email-vinod.koul@linux.intel.com>
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
Cc: Vinod Koul <vinod.koul@linux.intel.com>, broonie@opensource.wolfsonmicro.com, pierre-louis.bossart@linux.intel.com, ramesh.babu@intel.com, namartax.kohli@intel.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

From: Namarta Kohli <namartax.kohli@intel.com>

This patch adds the support to parse the compress dai's and then also adds the
soc-compress.c file while handles the compress stream operations, mostly analogous 
to what is done in the soc-pcm.c and additional handling of the compress
operations

Signed-off-by: Namarta Kohli <namartax.kohli@intel.com>
Signed-off-by: Ramesh Babu K V <ramesh.babu@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
---
 sound/soc/Makefile       |    2 +-
 sound/soc/soc-compress.c |  297 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/soc-core.c     |   10 ++-
 3 files changed, 307 insertions(+), 2 deletions(-)
 create mode 100644 sound/soc/soc-compress.c

diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 00a555a..c126400 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -1,5 +1,5 @@
 snd-soc-core-objs := soc-core.o soc-dapm.o soc-jack.o soc-cache.o soc-utils.o
-snd-soc-core-objs += soc-pcm.o soc-io.o
+snd-soc-core-objs += soc-pcm.o soc-compress.o soc-io.o
 
 snd-soc-dmaengine-pcm-objs := soc-dmaengine-pcm.o
 obj-$(CONFIG_SND_SOC_DMAENGINE_PCM) += snd-soc-dmaengine-pcm.o
diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
new file mode 100644
index 0000000..573f9bc
--- /dev/null
+++ b/sound/soc/soc-compress.c
@@ -0,0 +1,297 @@
+/*
+ * soc-compress.c  --  ALSA SoC Compress
+ *
+ * Copyright (C) 2012 Intel Corp.
+ *
+ * Authors: Namarta Kohli <namartax.kohli@intel.com>
+ *          Ramesh Babu K V <ramesh.babu@linux.intel.com>
+ *          Vinod Koul <vinod.koul@linux.intel.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+#include <sound/core.h>
+#include <sound/compress_params.h>
+#include <sound/compress_driver.h>
+#include <sound/soc.h>
+#include <sound/initval.h>
+
+static int soc_compr_open(struct snd_compr_stream *cstream)
+{
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int ret = 0;
+
+	if (platform->driver->compr_ops && platform->driver->compr_ops->open) {
+		ret = platform->driver->compr_ops->open(cstream);
+		if (ret < 0) {
+			printk(KERN_ERR "asoc: can't open platform %s\n", platform->name);
+			goto out;
+		}
+	}
+
+	if (rtd->dai_link->compr_ops && rtd->dai_link->compr_ops->startup) {
+		ret = rtd->dai_link->compr_ops->startup(cstream);
+		if (ret < 0) {
+			printk(KERN_ERR "asoc: %s startup failed\n", rtd->dai_link->name);
+			goto machine_err;
+		}
+	}
+
+	if (cstream->direction == SND_COMPRESS_PLAYBACK) {
+		cpu_dai->playback_active++;
+		codec_dai->playback_active++;
+	} else {
+		cpu_dai->capture_active++;
+		codec_dai->capture_active++;
+	}
+	cpu_dai->active++;
+	codec_dai->active++;
+	rtd->codec->active++;
+
+	return 0;
+
+machine_err:
+	if (platform->driver->compr_ops && platform->driver->compr_ops->free)
+		platform->driver->compr_ops->free(cstream);
+out:
+	return ret;
+}
+
+static int soc_compr_free(struct snd_compr_stream *cstream)
+{
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_codec *codec = rtd->codec;
+
+	if (cstream->direction == SND_COMPRESS_PLAYBACK) {
+		cpu_dai->playback_active--;
+		codec_dai->playback_active--;
+	} else {
+		cpu_dai->capture_active--;
+		codec_dai->capture_active--;
+	}
+
+	cpu_dai->active--;
+	codec_dai->active--;
+	codec->active--;
+
+	if (!cpu_dai->active)
+		cpu_dai->rate = 0;
+
+	if (!codec_dai->active)
+		codec_dai->rate = 0;
+
+	/* Muting the DAC suppresses artifacts caused during digital
+	 * shutdown, for example from stopping clocks.
+	 */
+	if (cstream->direction == SND_COMPRESS_PLAYBACK)
+		snd_soc_dai_digital_mute(codec_dai, 1);
+
+	if (rtd->dai_link->compr_ops && rtd->dai_link->compr_ops->shutdown)
+		rtd->dai_link->compr_ops->shutdown(cstream);
+
+	if (platform->driver->compr_ops && platform->driver->compr_ops->free)
+		platform->driver->compr_ops->free(cstream);
+		cpu_dai->runtime = NULL;
+
+	if (cstream->direction == SND_COMPRESS_PLAYBACK) {
+		if (!rtd->pmdown_time || codec->ignore_pmdown_time ||
+		    rtd->dai_link->ignore_pmdown_time) {
+			snd_soc_dapm_stream_event(rtd,
+					SNDRV_PCM_STREAM_PLAYBACK,
+					SND_SOC_DAPM_STREAM_STOP);
+		} else
+			codec_dai->pop_wait = 1;
+			schedule_delayed_work(&rtd->delayed_work,
+				msecs_to_jiffies(rtd->pmdown_time));
+	} else {
+		/* capture streams can be powered down now */
+		snd_soc_dapm_stream_event(rtd,
+			SNDRV_PCM_STREAM_CAPTURE,
+			SND_SOC_DAPM_STREAM_STOP);
+	}
+
+	mutex_unlock(&rtd->pcm_mutex);
+	return 0;
+}
+
+static int soc_compr_trigger(struct snd_compr_stream *cstream, int cmd)
+{
+
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_soc_platform *platform = rtd->platform;
+	int ret = 0;
+
+	if (platform->driver->compr_ops && platform->driver->compr_ops->trigger) {
+		ret = platform->driver->compr_ops->trigger(cstream, cmd);
+		if (ret < 0)
+			return ret;
+	}
+	return ret;
+}
+int soc_compr_set_params(struct snd_compr_stream *cstream,
+					struct snd_compr_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int ret = 0;
+
+	/* first we call set_params for the platform driver
+	 * this should configure the soc side
+	 * if the machine has compressed ops then we call that as well
+	 * expectation is that platform and machine will configure everything
+	 * for this compress path, like configuring pcm port for codec
+	 */
+	if (platform->driver->compr_ops && platform->driver->compr_ops->set_params) {
+		ret = platform->driver->compr_ops->set_params(cstream, params);
+		if (ret < 0)
+			return ret;
+	}
+	if (rtd->dai_link->compr_ops && rtd->dai_link->compr_ops->set_params) {
+		ret = rtd->dai_link->compr_ops->set_params(cstream);
+		if (ret < 0)
+			return ret;
+	}
+
+	snd_soc_dapm_stream_event(rtd, SNDRV_PCM_STREAM_PLAYBACK,
+				SND_SOC_DAPM_STREAM_START);
+
+	snd_soc_dai_digital_mute(codec_dai, 0);
+	return ret;
+}
+
+int soc_compr_get_params(struct snd_compr_stream *cstream,
+					struct snd_codec *params)
+{
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_soc_platform *platform = rtd->platform;
+	int ret = 0;
+
+	if (platform->driver->compr_ops && platform->driver->compr_ops->get_params) {
+		ret = platform->driver->compr_ops->get_params(cstream, params);
+		if (ret < 0)
+			return ret;
+	}
+	return ret;
+}
+
+int soc_compr_get_caps(struct snd_compr_stream *cstream,
+				struct snd_compr_caps *caps)
+{
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_soc_platform *platform = rtd->platform;
+	int ret = 0;
+
+	if (platform->driver->compr_ops && platform->driver->compr_ops->get_caps) {
+		ret = platform->driver->compr_ops->get_caps(cstream, caps);
+		if (ret < 0)
+			return ret;
+	}
+	return ret;
+}
+
+int soc_compr_get_codec_caps(struct snd_compr_stream *cstream,
+				struct snd_compr_codec_caps *codec)
+{
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_soc_platform *platform = rtd->platform;
+	int ret = 0;
+
+	if (platform->driver->compr_ops && platform->driver->compr_ops->get_codec_caps)
+		ret = platform->driver->compr_ops->get_codec_caps(cstream, codec);
+		if (ret < 0)
+			return ret;
+	return ret;
+}
+
+int soc_compr_ack(struct snd_compr_stream *cstream, size_t bytes)
+{
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_soc_platform *platform = rtd->platform;
+	int ret = 0;
+
+	if (platform->driver->compr_ops && platform->driver->compr_ops->ack)
+		ret = platform->driver->compr_ops->ack(cstream, bytes);
+		if (ret < 0)
+			return ret;
+
+	return ret;
+}
+
+int soc_compr_pointer(struct snd_compr_stream *cstream,
+			struct snd_compr_tstamp *tstamp)
+{
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_soc_platform *platform = rtd->platform;
+
+	if (platform->driver->compr_ops && platform->driver->compr_ops->pointer)
+		platform->driver->compr_ops->pointer(cstream, tstamp);
+
+	return 0;
+}
+
+/* ASoC Compress operations */
+static struct snd_compr_ops soc_compr_ops = {
+	.open		= soc_compr_open,
+	.free		= soc_compr_free,
+	.set_params	= soc_compr_set_params,
+	.get_params	= soc_compr_get_params,
+	.trigger	= soc_compr_trigger,
+	.pointer	= soc_compr_pointer,
+	.ack		= soc_compr_ack,
+	.get_caps	= soc_compr_get_caps,
+	.get_codec_caps = soc_compr_get_codec_caps
+};
+
+/* create a new compress */
+int soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_compr *compr;
+	char new_name[64];
+	int ret = 0, direction = 0;
+
+	/* check client and interface hw capabilities */
+	snprintf(new_name, sizeof(new_name), "%s %s-%d",
+			rtd->dai_link->stream_name, codec_dai->name, num);
+	/* TODO add support for cature */
+	direction = SND_COMPRESS_PLAYBACK;
+	compr = kzalloc(sizeof(*compr), GFP_KERNEL);
+	if (compr == NULL) {
+		snd_printk(KERN_ERR "Cannot allocate compr\n");
+		return -ENOMEM;
+	}
+
+	compr->ops = &soc_compr_ops;
+	mutex_init(&compr->lock);
+	ret = snd_compress_new(rtd->card->snd_card, num, direction, compr);
+	if (ret < 0) {
+		printk(KERN_ERR "asoc: can't create pcm for codec %s\n", codec->name);
+		kfree(compr);
+		return ret;
+	}
+
+	rtd->compr = compr;
+	compr->private_data = rtd;
+
+	printk(KERN_INFO "asoc: %s <-> %s mapping ok\n", codec_dai->name,
+		cpu_dai->name);
+	return ret;
+}
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f219b2f..492275b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1388,7 +1388,15 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 	if (ret < 0)
 		pr_warn("asoc: failed to add pmdown_time sysfs:%d\n", ret);
 
-	if (!dai_link->params) {
+	if (cpu_dai->driver->compress_dai) {
+		/*create compress device*/
+		ret = soc_new_compress(rtd, num);
+		if (ret < 0 ) {
+			printk(KERN_ERR "asoc: can't create offload %s\n",
+					 dai_link->stream_name);
+			return ret;
+		}
+	} else if (!dai_link->params) {
 		/* create the pcm */
 		ret = soc_new_pcm(rtd, num);
 		if (ret < 0) {
-- 
1.7.0.4
