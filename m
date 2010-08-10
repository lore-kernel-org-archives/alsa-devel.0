From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 3/5] ASoC: multi-component - ASoC Core
Date: Tue, 10 Aug 2010 18:02:23 +0100
Message-ID: <1281459745-28846-3-git-send-email-lrg@slimlogic.co.uk>
References: <1281459745-28846-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 45E69103859
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Aug 2010 19:02:45 +0200 (CEST)
Received: by eye27 with SMTP id 27so3776661eye.38
	for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2010 10:02:41 -0700 (PDT)
In-Reply-To: <1281459745-28846-1-git-send-email-lrg@slimlogic.co.uk>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

This patch adds multi-component support to the ASoC core and
reflects the new ASoC driver/device structure model defined in soc.h
and soc-dai.h. i.e.

 struct snd_soc_codec    --->  struct snd_soc_codec (device data)
                          +->  struct snd_soc_codec_driver (driver data)

 struct snd_soc_platform --->  struct snd_soc_platform (device data)
                          +->  struct snd_soc_platform_driver (driver data)

 struct snd_soc_dai      --->  struct snd_soc_dai (device data)
                          +->  struct snd_soc_dai_driver (driver data)

 struct snd_soc_device   --->  deleted

Other notable multi-component changes:-

 * Stream operations now de-reference less structures.
 * close_delayed work() now runs on a DAI basis rather than looping all DAIs
   in a card.
 * PM suspend()/resume() operations can now handle N CODECs and Platforms
   per sound card.
 * Added soc_bind_dai_link() to bind the component devices to the sound card.
 * Added soc_dai_link_probe() and soc_dai_link_remove() to probe and remove
   DAI link components.
 * sysfs entries can now be registered per component per card.
 * snd_soc_new_pcms() functionailty rolled into dai_link_probe().
 * snd_soc_register_codec() now does all the codec list and mutex init.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/soc-core.c | 1665 ++++++++++++++++++++++++++++++--------------------
 1 files changed, 994 insertions(+), 671 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 5299932..8afa271 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3,6 +3,8 @@
  *
  * Copyright 2005 Wolfson Microelectronics PLC.
  * Copyright 2005 Openedhand Ltd.
+ * Copyright (C) 2010 Slimlogic Ltd.
+ * Copyright (C) 2010 Texas Instruments Inc.
  *
  * Author: Liam Girdwood <lrg@slimlogic.co.uk>
  *         with code, comments and ideas from :-
@@ -37,6 +39,8 @@
 #include <sound/soc-dapm.h>
 #include <sound/initval.h>
 
+#define NAME_SIZE	32
+
 static DEFINE_MUTEX(pcm_mutex);
 static DECLARE_WAIT_QUEUE_HEAD(soc_pm_waitq);
 
@@ -52,6 +56,7 @@ static LIST_HEAD(codec_list);
 
 static int snd_soc_register_card(struct snd_soc_card *card);
 static int snd_soc_unregister_card(struct snd_soc_card *card);
+static int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num);
 
 /*
  * This is a timeout to do a DAPM powerdown after a stream is closed().
@@ -86,30 +91,30 @@ static ssize_t soc_codec_reg_show(struct snd_soc_codec *codec, char *buf)
 {
 	int ret, i, step = 1, count = 0;
 
-	if (!codec->reg_cache_size)
+	if (!codec->driver->reg_cache_size)
 		return 0;
 
-	if (codec->reg_cache_step)
-		step = codec->reg_cache_step;
+	if (codec->driver->reg_cache_step)
+		step = codec->driver->reg_cache_step;
 
 	count += sprintf(buf, "%s registers\n", codec->name);
-	for (i = 0; i < codec->reg_cache_size; i += step) {
-		if (codec->readable_register && !codec->readable_register(i))
+	for (i = 0; i < codec->driver->reg_cache_size; i += step) {
+		if (codec->driver->readable_register && !codec->driver->readable_register(i))
 			continue;
 
 		count += sprintf(buf + count, "%2x: ", i);
 		if (count >= PAGE_SIZE - 1)
 			break;
 
-		if (codec->display_register) {
-			count += codec->display_register(codec, buf + count,
+		if (codec->driver->display_register) {
+			count += codec->driver->display_register(codec, buf + count,
 							 PAGE_SIZE - count, i);
 		} else {
 			/* If the read fails it's almost certainly due to
 			 * the register being volatile and the device being
 			 * powered off.
 			 */
-			ret = codec->read(codec, i);
+			ret = codec->driver->read(codec, i);
 			if (ret >= 0)
 				count += snprintf(buf + count,
 						  PAGE_SIZE - count,
@@ -137,8 +142,10 @@ static ssize_t soc_codec_reg_show(struct snd_soc_codec *codec, char *buf)
 static ssize_t codec_reg_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
-	struct snd_soc_device *devdata = dev_get_drvdata(dev);
-	return soc_codec_reg_show(devdata->card->codec, buf);
+	struct snd_soc_pcm_runtime *rtd =
+			container_of(dev, struct snd_soc_pcm_runtime, dev);
+
+	return soc_codec_reg_show(rtd->codec, buf);
 }
 
 static DEVICE_ATTR(codec_reg, 0444, codec_reg_show, NULL);
@@ -146,20 +153,20 @@ static DEVICE_ATTR(codec_reg, 0444, codec_reg_show, NULL);
 static ssize_t pmdown_time_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	struct snd_soc_device *socdev = dev_get_drvdata(dev);
-	struct snd_soc_card *card = socdev->card;
+	struct snd_soc_pcm_runtime *rtd =
+			container_of(dev, struct snd_soc_pcm_runtime, dev);
 
-	return sprintf(buf, "%ld\n", card->pmdown_time);
+	return sprintf(buf, "%ld\n", rtd->pmdown_time);
 }
 
 static ssize_t pmdown_time_set(struct device *dev,
 			       struct device_attribute *attr,
 			       const char *buf, size_t count)
 {
-	struct snd_soc_device *socdev = dev_get_drvdata(dev);
-	struct snd_soc_card *card = socdev->card;
+	struct snd_soc_pcm_runtime *rtd =
+			container_of(dev, struct snd_soc_pcm_runtime, dev);
 
-	strict_strtol(buf, 10, &card->pmdown_time);
+	strict_strtol(buf, 10, &rtd->pmdown_time);
 
 	return count;
 }
@@ -203,19 +210,19 @@ static ssize_t codec_reg_write_file(struct file *file,
 		return -EFAULT;
 	buf[buf_size] = 0;
 
-	if (codec->reg_cache_step)
-		step = codec->reg_cache_step;
+	if (codec->driver->reg_cache_step)
+		step = codec->driver->reg_cache_step;
 
 	while (*start == ' ')
 		start++;
 	reg = simple_strtoul(start, &start, 16);
-	if ((reg >= codec->reg_cache_size) || (reg % step))
+	if ((reg >= codec->driver->reg_cache_size) || (reg % step))
 		return -EINVAL;
 	while (*start == ' ')
 		start++;
 	if (strict_strtoul(start, 16, &value))
 		return -EINVAL;
-	codec->write(codec, reg, value);
+	codec->driver->write(codec, reg, value);
 	return buf_size;
 }
 
@@ -305,7 +312,7 @@ static int soc_ac97_dev_register(struct snd_soc_codec *codec)
 	codec->ac97->dev.release = soc_ac97_device_release;
 
 	dev_set_name(&codec->ac97->dev, "%d-%d:%s",
-		     codec->card->number, 0, codec->name);
+		     codec->ac97->bus->card->number, 0, codec->name);
 	err = device_register(&codec->ac97->dev);
 	if (err < 0) {
 		snd_printk(KERN_ERR "Can't register ac97 bus\n");
@@ -319,24 +326,21 @@ static int soc_ac97_dev_register(struct snd_soc_codec *codec)
 static int soc_pcm_apply_symmetry(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_card *card = socdev->card;
-	struct snd_soc_dai_link *machine = rtd->dai;
-	struct snd_soc_dai *cpu_dai = machine->cpu_dai;
-	struct snd_soc_dai *codec_dai = machine->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	int ret;
 
-	if (codec_dai->symmetric_rates || cpu_dai->symmetric_rates ||
-	    machine->symmetric_rates) {
-		dev_dbg(card->dev, "Symmetry forces %dHz rate\n",
-			machine->rate);
+	if (codec_dai->driver->symmetric_rates || cpu_dai->driver->symmetric_rates ||
+			rtd->dai_link->symmetric_rates) {
+		dev_dbg(&rtd->dev, "Symmetry forces %dHz rate\n",
+				rtd->rate);
 
 		ret = snd_pcm_hw_constraint_minmax(substream->runtime,
 						   SNDRV_PCM_HW_PARAM_RATE,
-						   machine->rate,
-						   machine->rate);
+						   rtd->rate,
+						   rtd->rate);
 		if (ret < 0) {
-			dev_err(card->dev,
+			dev_err(&rtd->dev,
 				"Unable to apply rate symmetry constraint: %d\n", ret);
 			return ret;
 		}
@@ -353,20 +357,19 @@ static int soc_pcm_apply_symmetry(struct snd_pcm_substream *substream)
 static int soc_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_card *card = socdev->card;
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_soc_dai_link *machine = rtd->dai;
-	struct snd_soc_platform *platform = card->platform;
-	struct snd_soc_dai *cpu_dai = machine->cpu_dai;
-	struct snd_soc_dai *codec_dai = machine->codec_dai;
+	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai_driver *cpu_dai_drv = cpu_dai->driver;
+	struct snd_soc_dai_driver *codec_dai_drv = codec_dai->driver;
 	int ret = 0;
 
 	mutex_lock(&pcm_mutex);
 
 	/* startup the audio subsystem */
-	if (cpu_dai->ops->startup) {
-		ret = cpu_dai->ops->startup(substream, cpu_dai);
+	if (cpu_dai->driver->ops->startup) {
+		ret = cpu_dai->driver->ops->startup(substream, cpu_dai);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: can't open interface %s\n",
 				cpu_dai->name);
@@ -374,16 +377,16 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 		}
 	}
 
-	if (platform->pcm_ops->open) {
-		ret = platform->pcm_ops->open(substream);
+	if (platform->driver->ops->open) {
+		ret = platform->driver->ops->open(substream);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: can't open platform %s\n", platform->name);
 			goto platform_err;
 		}
 	}
 
-	if (codec_dai->ops->startup) {
-		ret = codec_dai->ops->startup(substream, codec_dai);
+	if (codec_dai->driver->ops->startup) {
+		ret = codec_dai->driver->ops->startup(substream, codec_dai);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: can't open codec %s\n",
 				codec_dai->name);
@@ -391,10 +394,10 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 		}
 	}
 
-	if (machine->ops && machine->ops->startup) {
-		ret = machine->ops->startup(substream);
+	if (rtd->dai_link->ops && rtd->dai_link->ops->startup) {
+		ret = rtd->dai_link->ops->startup(substream);
 		if (ret < 0) {
-			printk(KERN_ERR "asoc: %s startup failed\n", machine->name);
+			printk(KERN_ERR "asoc: %s startup failed\n", rtd->dai_link->name);
 			goto machine_err;
 		}
 	}
@@ -402,50 +405,50 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	/* Check that the codec and cpu DAI's are compatible */
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		runtime->hw.rate_min =
-			max(codec_dai->playback.rate_min,
-			    cpu_dai->playback.rate_min);
+			max(codec_dai_drv->playback.rate_min,
+			    cpu_dai_drv->playback.rate_min);
 		runtime->hw.rate_max =
-			min(codec_dai->playback.rate_max,
-			    cpu_dai->playback.rate_max);
+			min(codec_dai_drv->playback.rate_max,
+			    cpu_dai_drv->playback.rate_max);
 		runtime->hw.channels_min =
-			max(codec_dai->playback.channels_min,
-				cpu_dai->playback.channels_min);
+			max(codec_dai_drv->playback.channels_min,
+				cpu_dai_drv->playback.channels_min);
 		runtime->hw.channels_max =
-			min(codec_dai->playback.channels_max,
-				cpu_dai->playback.channels_max);
+			min(codec_dai_drv->playback.channels_max,
+				cpu_dai_drv->playback.channels_max);
 		runtime->hw.formats =
-			codec_dai->playback.formats & cpu_dai->playback.formats;
+			codec_dai_drv->playback.formats & cpu_dai_drv->playback.formats;
 		runtime->hw.rates =
-			codec_dai->playback.rates & cpu_dai->playback.rates;
-		if (codec_dai->playback.rates
+			codec_dai_drv->playback.rates & cpu_dai_drv->playback.rates;
+		if (codec_dai_drv->playback.rates
 			   & (SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_CONTINUOUS))
-			runtime->hw.rates |= cpu_dai->playback.rates;
-		if (cpu_dai->playback.rates
+			runtime->hw.rates |= cpu_dai_drv->playback.rates;
+		if (cpu_dai_drv->playback.rates
 			   & (SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_CONTINUOUS))
-			runtime->hw.rates |= codec_dai->playback.rates;
+			runtime->hw.rates |= codec_dai_drv->playback.rates;
 	} else {
 		runtime->hw.rate_min =
-			max(codec_dai->capture.rate_min,
-			    cpu_dai->capture.rate_min);
+			max(codec_dai_drv->capture.rate_min,
+			    cpu_dai_drv->capture.rate_min);
 		runtime->hw.rate_max =
-			min(codec_dai->capture.rate_max,
-			    cpu_dai->capture.rate_max);
+			min(codec_dai_drv->capture.rate_max,
+			    cpu_dai_drv->capture.rate_max);
 		runtime->hw.channels_min =
-			max(codec_dai->capture.channels_min,
-				cpu_dai->capture.channels_min);
+			max(codec_dai_drv->capture.channels_min,
+				cpu_dai_drv->capture.channels_min);
 		runtime->hw.channels_max =
-			min(codec_dai->capture.channels_max,
-				cpu_dai->capture.channels_max);
+			min(codec_dai_drv->capture.channels_max,
+				cpu_dai_drv->capture.channels_max);
 		runtime->hw.formats =
-			codec_dai->capture.formats & cpu_dai->capture.formats;
+			codec_dai_drv->capture.formats & cpu_dai_drv->capture.formats;
 		runtime->hw.rates =
-			codec_dai->capture.rates & cpu_dai->capture.rates;
-		if (codec_dai->capture.rates
+			codec_dai_drv->capture.rates & cpu_dai_drv->capture.rates;
+		if (codec_dai_drv->capture.rates
 			   & (SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_CONTINUOUS))
-			runtime->hw.rates |= cpu_dai->capture.rates;
-		if (cpu_dai->capture.rates
+			runtime->hw.rates |= cpu_dai_drv->capture.rates;
+		if (cpu_dai_drv->capture.rates
 			   & (SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_CONTINUOUS))
-			runtime->hw.rates |= codec_dai->capture.rates;
+			runtime->hw.rates |= codec_dai_drv->capture.rates;
 	}
 
 	snd_pcm_limit_hw_rates(runtime);
@@ -461,7 +464,7 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	}
 	if (!runtime->hw.channels_min || !runtime->hw.channels_max) {
 		printk(KERN_ERR "asoc: %s <-> %s No matching channels\n",
-			codec_dai->name, cpu_dai->name);
+				codec_dai->name, cpu_dai->name);
 		goto config_err;
 	}
 
@@ -472,7 +475,8 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 			goto config_err;
 	}
 
-	pr_debug("asoc: %s <-> %s info:\n", codec_dai->name, cpu_dai->name);
+	pr_debug("asoc: %s <-> %s info:\n",
+			codec_dai->name, cpu_dai->name);
 	pr_debug("asoc: rate mask 0x%x\n", runtime->hw.rates);
 	pr_debug("asoc: min ch %d max ch %d\n", runtime->hw.channels_min,
 		 runtime->hw.channels_max);
@@ -480,33 +484,33 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 		 runtime->hw.rate_max);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		cpu_dai->playback.active++;
-		codec_dai->playback.active++;
+		cpu_dai->playback_active++;
+		codec_dai->playback_active++;
 	} else {
-		cpu_dai->capture.active++;
-		codec_dai->capture.active++;
+		cpu_dai->capture_active++;
+		codec_dai->capture_active++;
 	}
 	cpu_dai->active++;
 	codec_dai->active++;
-	card->codec->active++;
+	rtd->codec->active++;
 	mutex_unlock(&pcm_mutex);
 	return 0;
 
 config_err:
-	if (machine->ops && machine->ops->shutdown)
-		machine->ops->shutdown(substream);
+	if (rtd->dai_link->ops && rtd->dai_link->ops->shutdown)
+		rtd->dai_link->ops->shutdown(substream);
 
 machine_err:
-	if (codec_dai->ops->shutdown)
-		codec_dai->ops->shutdown(substream, codec_dai);
+	if (codec_dai->driver->ops->shutdown)
+		codec_dai->driver->ops->shutdown(substream, codec_dai);
 
 codec_dai_err:
-	if (platform->pcm_ops->close)
-		platform->pcm_ops->close(substream);
+	if (platform->driver->ops->close)
+		platform->driver->ops->close(substream);
 
 platform_err:
-	if (cpu_dai->ops->shutdown)
-		cpu_dai->ops->shutdown(substream, cpu_dai);
+	if (cpu_dai->driver->ops->shutdown)
+		cpu_dai->driver->ops->shutdown(substream, cpu_dai);
 out:
 	mutex_unlock(&pcm_mutex);
 	return ret;
@@ -519,29 +523,25 @@ out:
  */
 static void close_delayed_work(struct work_struct *work)
 {
-	struct snd_soc_card *card = container_of(work, struct snd_soc_card,
-						 delayed_work.work);
-	struct snd_soc_codec *codec = card->codec;
-	struct snd_soc_dai *codec_dai;
-	int i;
+	struct snd_soc_pcm_runtime *rtd =
+			container_of(work, struct snd_soc_pcm_runtime, delayed_work.work);
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 
 	mutex_lock(&pcm_mutex);
-	for (i = 0; i < codec->num_dai; i++) {
-		codec_dai = &codec->dai[i];
-
-		pr_debug("pop wq checking: %s status: %s waiting: %s\n",
-			 codec_dai->playback.stream_name,
-			 codec_dai->playback.active ? "active" : "inactive",
-			 codec_dai->pop_wait ? "yes" : "no");
-
-		/* are we waiting on this codec DAI stream */
-		if (codec_dai->pop_wait == 1) {
-			codec_dai->pop_wait = 0;
-			snd_soc_dapm_stream_event(codec,
-				codec_dai->playback.stream_name,
-				SND_SOC_DAPM_STREAM_STOP);
-		}
+
+	pr_debug("pop wq checking: %s status: %s waiting: %s\n",
+		 codec_dai->driver->playback.stream_name,
+		 codec_dai->playback_active ? "active" : "inactive",
+		 codec_dai->pop_wait ? "yes" : "no");
+
+	/* are we waiting on this codec DAI stream */
+	if (codec_dai->pop_wait == 1) {
+		codec_dai->pop_wait = 0;
+		snd_soc_dapm_stream_event(rtd,
+			codec_dai->driver->playback.stream_name,
+			SND_SOC_DAPM_STREAM_STOP);
 	}
+
 	mutex_unlock(&pcm_mutex);
 }
 
@@ -553,22 +553,19 @@ static void close_delayed_work(struct work_struct *work)
 static int soc_codec_close(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_card *card = socdev->card;
-	struct snd_soc_dai_link *machine = rtd->dai;
-	struct snd_soc_platform *platform = card->platform;
-	struct snd_soc_dai *cpu_dai = machine->cpu_dai;
-	struct snd_soc_dai *codec_dai = machine->codec_dai;
-	struct snd_soc_codec *codec = card->codec;
+	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_codec *codec = rtd->codec;
 
 	mutex_lock(&pcm_mutex);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		cpu_dai->playback.active--;
-		codec_dai->playback.active--;
+		cpu_dai->playback_active--;
+		codec_dai->playback_active--;
 	} else {
-		cpu_dai->capture.active--;
-		codec_dai->capture.active--;
+		cpu_dai->capture_active--;
+		codec_dai->capture_active--;
 	}
 
 	cpu_dai->active--;
@@ -581,27 +578,28 @@ static int soc_codec_close(struct snd_pcm_substream *substream)
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		snd_soc_dai_digital_mute(codec_dai, 1);
 
-	if (cpu_dai->ops->shutdown)
-		cpu_dai->ops->shutdown(substream, cpu_dai);
+	if (cpu_dai->driver->ops->shutdown)
+		cpu_dai->driver->ops->shutdown(substream, cpu_dai);
 
-	if (codec_dai->ops->shutdown)
-		codec_dai->ops->shutdown(substream, codec_dai);
+	if (codec_dai->driver->ops->shutdown)
+		codec_dai->driver->ops->shutdown(substream, codec_dai);
 
-	if (machine->ops && machine->ops->shutdown)
-		machine->ops->shutdown(substream);
+	if (rtd->dai_link->ops && rtd->dai_link->ops->shutdown)
+		rtd->dai_link->ops->shutdown(substream);
 
-	if (platform->pcm_ops->close)
-		platform->pcm_ops->close(substream);
+	if (platform->driver->ops->close)
+		platform->driver->ops->close(substream);
+	cpu_dai->runtime = NULL;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		/* start delayed pop wq here for playback streams */
 		codec_dai->pop_wait = 1;
-		schedule_delayed_work(&card->delayed_work,
-			msecs_to_jiffies(card->pmdown_time));
+		schedule_delayed_work(&rtd->delayed_work,
+			msecs_to_jiffies(rtd->pmdown_time));
 	} else {
 		/* capture streams can be powered down now */
-		snd_soc_dapm_stream_event(codec,
-			codec_dai->capture.stream_name,
+		snd_soc_dapm_stream_event(rtd,
+			codec_dai->driver->capture.stream_name,
 			SND_SOC_DAPM_STREAM_STOP);
 	}
 
@@ -617,43 +615,39 @@ static int soc_codec_close(struct snd_pcm_substream *substream)
 static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_card *card = socdev->card;
-	struct snd_soc_dai_link *machine = rtd->dai;
-	struct snd_soc_platform *platform = card->platform;
-	struct snd_soc_dai *cpu_dai = machine->cpu_dai;
-	struct snd_soc_dai *codec_dai = machine->codec_dai;
-	struct snd_soc_codec *codec = card->codec;
+	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	int ret = 0;
 
 	mutex_lock(&pcm_mutex);
 
-	if (machine->ops && machine->ops->prepare) {
-		ret = machine->ops->prepare(substream);
+	if (rtd->dai_link->ops && rtd->dai_link->ops->prepare) {
+		ret = rtd->dai_link->ops->prepare(substream);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: machine prepare error\n");
 			goto out;
 		}
 	}
 
-	if (platform->pcm_ops->prepare) {
-		ret = platform->pcm_ops->prepare(substream);
+	if (platform->driver->ops->prepare) {
+		ret = platform->driver->ops->prepare(substream);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: platform prepare error\n");
 			goto out;
 		}
 	}
 
-	if (codec_dai->ops->prepare) {
-		ret = codec_dai->ops->prepare(substream, codec_dai);
+	if (codec_dai->driver->ops->prepare) {
+		ret = codec_dai->driver->ops->prepare(substream, codec_dai);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: codec DAI prepare error\n");
 			goto out;
 		}
 	}
 
-	if (cpu_dai->ops->prepare) {
-		ret = cpu_dai->ops->prepare(substream, cpu_dai);
+	if (cpu_dai->driver->ops->prepare) {
+		ret = cpu_dai->driver->ops->prepare(substream, cpu_dai);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: cpu DAI prepare error\n");
 			goto out;
@@ -664,16 +658,16 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
 	    codec_dai->pop_wait) {
 		codec_dai->pop_wait = 0;
-		cancel_delayed_work(&card->delayed_work);
+		cancel_delayed_work(&rtd->delayed_work);
 	}
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		snd_soc_dapm_stream_event(codec,
-					  codec_dai->playback.stream_name,
+		snd_soc_dapm_stream_event(rtd,
+					  codec_dai->driver->playback.stream_name,
 					  SND_SOC_DAPM_STREAM_START);
 	else
-		snd_soc_dapm_stream_event(codec,
-					  codec_dai->capture.stream_name,
+		snd_soc_dapm_stream_event(rtd,
+					  codec_dai->driver->capture.stream_name,
 					  SND_SOC_DAPM_STREAM_START);
 
 	snd_soc_dai_digital_mute(codec_dai, 0);
@@ -692,26 +686,23 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_dai_link *machine = rtd->dai;
-	struct snd_soc_card *card = socdev->card;
-	struct snd_soc_platform *platform = card->platform;
-	struct snd_soc_dai *cpu_dai = machine->cpu_dai;
-	struct snd_soc_dai *codec_dai = machine->codec_dai;
+	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	int ret = 0;
 
 	mutex_lock(&pcm_mutex);
 
-	if (machine->ops && machine->ops->hw_params) {
-		ret = machine->ops->hw_params(substream, params);
+	if (rtd->dai_link->ops && rtd->dai_link->ops->hw_params) {
+		ret = rtd->dai_link->ops->hw_params(substream, params);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: machine hw_params failed\n");
 			goto out;
 		}
 	}
 
-	if (codec_dai->ops->hw_params) {
-		ret = codec_dai->ops->hw_params(substream, params, codec_dai);
+	if (codec_dai->driver->ops->hw_params) {
+		ret = codec_dai->driver->ops->hw_params(substream, params, codec_dai);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: can't set codec %s hw params\n",
 				codec_dai->name);
@@ -719,8 +710,8 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 
-	if (cpu_dai->ops->hw_params) {
-		ret = cpu_dai->ops->hw_params(substream, params, cpu_dai);
+	if (cpu_dai->driver->ops->hw_params) {
+		ret = cpu_dai->driver->ops->hw_params(substream, params, cpu_dai);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: interface %s hw params failed\n",
 				cpu_dai->name);
@@ -728,8 +719,8 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 
-	if (platform->pcm_ops->hw_params) {
-		ret = platform->pcm_ops->hw_params(substream, params);
+	if (platform->driver->ops->hw_params) {
+		ret = platform->driver->ops->hw_params(substream, params);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: platform %s hw params failed\n",
 				platform->name);
@@ -737,23 +728,23 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 
-	machine->rate = params_rate(params);
+	rtd->rate = params_rate(params);
 
 out:
 	mutex_unlock(&pcm_mutex);
 	return ret;
 
 platform_err:
-	if (cpu_dai->ops->hw_free)
-		cpu_dai->ops->hw_free(substream, cpu_dai);
+	if (cpu_dai->driver->ops->hw_free)
+		cpu_dai->driver->ops->hw_free(substream, cpu_dai);
 
 interface_err:
-	if (codec_dai->ops->hw_free)
-		codec_dai->ops->hw_free(substream, codec_dai);
+	if (codec_dai->driver->ops->hw_free)
+		codec_dai->driver->ops->hw_free(substream, codec_dai);
 
 codec_err:
-	if (machine->ops && machine->ops->hw_free)
-		machine->ops->hw_free(substream);
+	if (rtd->dai_link->ops && rtd->dai_link->ops->hw_free)
+		rtd->dai_link->ops->hw_free(substream);
 
 	mutex_unlock(&pcm_mutex);
 	return ret;
@@ -765,13 +756,10 @@ codec_err:
 static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_dai_link *machine = rtd->dai;
-	struct snd_soc_card *card = socdev->card;
-	struct snd_soc_platform *platform = card->platform;
-	struct snd_soc_dai *cpu_dai = machine->cpu_dai;
-	struct snd_soc_dai *codec_dai = machine->codec_dai;
-	struct snd_soc_codec *codec = card->codec;
+	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_codec *codec = rtd->codec;
 
 	mutex_lock(&pcm_mutex);
 
@@ -780,19 +768,19 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 		snd_soc_dai_digital_mute(codec_dai, 1);
 
 	/* free any machine hw params */
-	if (machine->ops && machine->ops->hw_free)
-		machine->ops->hw_free(substream);
+	if (rtd->dai_link->ops && rtd->dai_link->ops->hw_free)
+		rtd->dai_link->ops->hw_free(substream);
 
 	/* free any DMA resources */
-	if (platform->pcm_ops->hw_free)
-		platform->pcm_ops->hw_free(substream);
+	if (platform->driver->ops->hw_free)
+		platform->driver->ops->hw_free(substream);
 
 	/* now free hw params for the DAI's  */
-	if (codec_dai->ops->hw_free)
-		codec_dai->ops->hw_free(substream, codec_dai);
+	if (codec_dai->driver->ops->hw_free)
+		codec_dai->driver->ops->hw_free(substream, codec_dai);
 
-	if (cpu_dai->ops->hw_free)
-		cpu_dai->ops->hw_free(substream, cpu_dai);
+	if (cpu_dai->driver->ops->hw_free)
+		cpu_dai->driver->ops->hw_free(substream, cpu_dai);
 
 	mutex_unlock(&pcm_mutex);
 	return 0;
@@ -801,28 +789,25 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_card *card= socdev->card;
-	struct snd_soc_dai_link *machine = rtd->dai;
-	struct snd_soc_platform *platform = card->platform;
-	struct snd_soc_dai *cpu_dai = machine->cpu_dai;
-	struct snd_soc_dai *codec_dai = machine->codec_dai;
+	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	int ret;
 
-	if (codec_dai->ops->trigger) {
-		ret = codec_dai->ops->trigger(substream, cmd, codec_dai);
+	if (codec_dai->driver->ops->trigger) {
+		ret = codec_dai->driver->ops->trigger(substream, cmd, codec_dai);
 		if (ret < 0)
 			return ret;
 	}
 
-	if (platform->pcm_ops->trigger) {
-		ret = platform->pcm_ops->trigger(substream, cmd);
+	if (platform->driver->ops->trigger) {
+		ret = platform->driver->ops->trigger(substream, cmd);
 		if (ret < 0)
 			return ret;
 	}
 
-	if (cpu_dai->ops->trigger) {
-		ret = cpu_dai->ops->trigger(substream, cmd, cpu_dai);
+	if (cpu_dai->driver->ops->trigger) {
+		ret = cpu_dai->driver->ops->trigger(substream, cmd, cpu_dai);
 		if (ret < 0)
 			return ret;
 	}
@@ -837,27 +822,24 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_card *card = socdev->card;
-	struct snd_soc_platform *platform = card->platform;
-	struct snd_soc_dai_link *machine = rtd->dai;
-	struct snd_soc_dai *cpu_dai = machine->cpu_dai;
-	struct snd_soc_dai *codec_dai = machine->codec_dai;
+	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_uframes_t offset = 0;
 	snd_pcm_sframes_t delay = 0;
 
-	if (platform->pcm_ops->pointer)
-		offset = platform->pcm_ops->pointer(substream);
+	if (platform->driver->ops->pointer)
+		offset = platform->driver->ops->pointer(substream);
 
-	if (cpu_dai->ops->delay)
-		delay += cpu_dai->ops->delay(substream, cpu_dai);
+	if (cpu_dai->driver->ops->delay)
+		delay += cpu_dai->driver->ops->delay(substream, cpu_dai);
 
-	if (codec_dai->ops->delay)
-		delay += codec_dai->ops->delay(substream, codec_dai);
+	if (codec_dai->driver->ops->delay)
+		delay += codec_dai->driver->ops->delay(substream, codec_dai);
 
-	if (platform->delay)
-		delay += platform->delay(substream, codec_dai);
+	if (platform->driver->delay)
+		delay += platform->driver->delay(substream, codec_dai);
 
 	runtime->delay = delay;
 
@@ -880,104 +862,111 @@ static struct snd_pcm_ops soc_pcm_ops = {
 static int soc_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_card *card = socdev->card;
-	struct snd_soc_platform *platform = card->platform;
-	struct snd_soc_codec_device *codec_dev = socdev->codec_dev;
-	struct snd_soc_codec *codec = card->codec;
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
 	int i;
 
 	/* If the initialization of this soc device failed, there is no codec
 	 * associated with it. Just bail out in this case.
 	 */
-	if (!codec)
+	if (list_empty(&card->codec_dev_list))
 		return 0;
 
 	/* Due to the resume being scheduled into a workqueue we could
 	* suspend before that's finished - wait for it to complete.
 	 */
-	snd_power_lock(codec->card);
-	snd_power_wait(codec->card, SNDRV_CTL_POWER_D0);
-	snd_power_unlock(codec->card);
+	snd_power_lock(card->snd_card);
+	snd_power_wait(card->snd_card, SNDRV_CTL_POWER_D0);
+	snd_power_unlock(card->snd_card);
 
 	/* we're going to block userspace touching us until resume completes */
-	snd_power_change_state(codec->card, SNDRV_CTL_POWER_D3hot);
+	snd_power_change_state(card->snd_card, SNDRV_CTL_POWER_D3hot);
 
 	/* mute any active DAC's */
-	for (i = 0; i < card->num_links; i++) {
-		struct snd_soc_dai *dai = card->dai_link[i].codec_dai;
+	for (i = 0; i < card->num_rtd; i++) {
+		struct snd_soc_dai *dai = card->rtd[i].codec_dai;
+		struct snd_soc_dai_driver *drv = dai->driver;
 
-		if (card->dai_link[i].ignore_suspend)
+		if (card->rtd[i].dai_link->ignore_suspend)
 			continue;
 
-		if (dai->ops->digital_mute && dai->playback.active)
-			dai->ops->digital_mute(dai, 1);
+		if (drv->ops->digital_mute && dai->playback_active)
+			drv->ops->digital_mute(dai, 1);
 	}
 
 	/* suspend all pcms */
-	for (i = 0; i < card->num_links; i++) {
-		if (card->dai_link[i].ignore_suspend)
+	for (i = 0; i < card->num_rtd; i++) {
+		if (card->rtd[i].dai_link->ignore_suspend)
 			continue;
 
-		snd_pcm_suspend_all(card->dai_link[i].pcm);
+		snd_pcm_suspend_all(card->rtd[i].pcm);
 	}
 
 	if (card->suspend_pre)
 		card->suspend_pre(pdev, PMSG_SUSPEND);
 
-	for (i = 0; i < card->num_links; i++) {
-		struct snd_soc_dai  *cpu_dai = card->dai_link[i].cpu_dai;
+	for (i = 0; i < card->num_rtd; i++) {
+		struct snd_soc_dai *cpu_dai = card->rtd[i].cpu_dai;
+		struct snd_soc_platform *platform = card->rtd[i].platform;
 
-		if (card->dai_link[i].ignore_suspend)
+		if (card->rtd[i].dai_link->ignore_suspend)
 			continue;
 
-		if (cpu_dai->suspend && !cpu_dai->ac97_control)
-			cpu_dai->suspend(cpu_dai);
-		if (platform->suspend)
-			platform->suspend(&card->dai_link[i]);
+		if (cpu_dai->driver->suspend && !cpu_dai->driver->ac97_control)
+			cpu_dai->driver->suspend(cpu_dai);
+		if (platform->driver->suspend && !platform->suspended) {
+			platform->driver->suspend(cpu_dai);
+			platform->suspended = 1;
+		}
 	}
 
 	/* close any waiting streams and save state */
-	run_delayed_work(&card->delayed_work);
-	codec->suspend_bias_level = codec->bias_level;
+	for (i = 0; i < card->num_rtd; i++) {
+		run_delayed_work(&card->rtd[i].delayed_work);
+		card->rtd[i].codec->suspend_bias_level = card->rtd[i].codec->bias_level;
+	}
 
-	for (i = 0; i < codec->num_dai; i++) {
-		char *stream = codec->dai[i].playback.stream_name;
+	for (i = 0; i < card->num_rtd; i++) {
+		struct snd_soc_dai_driver *driver = card->rtd[i].codec_dai->driver;
 
-		if (card->dai_link[i].ignore_suspend)
+		if (card->rtd[i].dai_link->ignore_suspend)
 			continue;
 
-		if (stream != NULL)
-			snd_soc_dapm_stream_event(codec, stream,
+		if (driver->playback.stream_name != NULL)
+			snd_soc_dapm_stream_event(&card->rtd[i], driver->playback.stream_name,
 				SND_SOC_DAPM_STREAM_SUSPEND);
-		stream = codec->dai[i].capture.stream_name;
-		if (stream != NULL)
-			snd_soc_dapm_stream_event(codec, stream,
+
+		if (driver->capture.stream_name != NULL)
+			snd_soc_dapm_stream_event(&card->rtd[i], driver->capture.stream_name,
 				SND_SOC_DAPM_STREAM_SUSPEND);
 	}
 
-	/* If there are paths active then the CODEC will be held with
-	 * bias _ON and should not be suspended. */
-	if (codec_dev->suspend) {
-		switch (codec->bias_level) {
-		case SND_SOC_BIAS_STANDBY:
-		case SND_SOC_BIAS_OFF:
-			codec_dev->suspend(pdev, PMSG_SUSPEND);
-			break;
-		default:
-			dev_dbg(socdev->dev, "CODEC is on over suspend\n");
-			break;
+	/* suspend all CODECs */
+	for (i = 0; i < card->num_rtd; i++) {
+		struct snd_soc_codec *codec = card->rtd[i].codec;
+		/* If there are paths active then the CODEC will be held with
+		 * bias _ON and should not be suspended. */
+		if (!codec->suspended && codec->driver->suspend) {
+			switch (codec->bias_level) {
+			case SND_SOC_BIAS_STANDBY:
+			case SND_SOC_BIAS_OFF:
+				codec->driver->suspend(codec, PMSG_SUSPEND);
+				codec->suspended = 1;
+				break;
+			default:
+				dev_dbg(codec->dev, "CODEC is on over suspend\n");
+				break;
+			}
 		}
 	}
 
-	for (i = 0; i < card->num_links; i++) {
-		struct snd_soc_dai *cpu_dai = card->dai_link[i].cpu_dai;
+	for (i = 0; i < card->num_rtd; i++) {
+		struct snd_soc_dai *cpu_dai = card->rtd[i].cpu_dai;
 
-		if (card->dai_link[i].ignore_suspend)
+		if (card->rtd[i].dai_link->ignore_suspend)
 			continue;
 
-		if (cpu_dai->suspend && cpu_dai->ac97_control)
-			cpu_dai->suspend(cpu_dai);
+		if (cpu_dai->driver->suspend && cpu_dai->driver->ac97_control)
+			cpu_dai->driver->suspend(cpu_dai);
 	}
 
 	if (card->suspend_post)
@@ -991,127 +980,127 @@ static int soc_suspend(struct device *dev)
  */
 static void soc_resume_deferred(struct work_struct *work)
 {
-	struct snd_soc_card *card = container_of(work,
-						 struct snd_soc_card,
-						 deferred_resume_work);
-	struct snd_soc_device *socdev = card->socdev;
-	struct snd_soc_platform *platform = card->platform;
-	struct snd_soc_codec_device *codec_dev = socdev->codec_dev;
-	struct snd_soc_codec *codec = card->codec;
-	struct platform_device *pdev = to_platform_device(socdev->dev);
+	struct snd_soc_card *card =
+			container_of(work, struct snd_soc_card, deferred_resume_work);
+	struct platform_device *pdev = to_platform_device(card->dev);
 	int i;
 
 	/* our power state is still SNDRV_CTL_POWER_D3hot from suspend time,
 	 * so userspace apps are blocked from touching us
 	 */
 
-	dev_dbg(socdev->dev, "starting resume work\n");
+	dev_dbg(card->dev, "starting resume work\n");
 
 	/* Bring us up into D2 so that DAPM starts enabling things */
-	snd_power_change_state(codec->card, SNDRV_CTL_POWER_D2);
+	snd_power_change_state(card->snd_card, SNDRV_CTL_POWER_D2);
 
 	if (card->resume_pre)
 		card->resume_pre(pdev);
 
-	for (i = 0; i < card->num_links; i++) {
-		struct snd_soc_dai *cpu_dai = card->dai_link[i].cpu_dai;
+	/* resume AC97 DAIs */
+	for (i = 0; i < card->num_rtd; i++) {
+		struct snd_soc_dai *cpu_dai = card->rtd[i].cpu_dai;
 
-		if (card->dai_link[i].ignore_suspend)
+		if (card->rtd[i].dai_link->ignore_suspend)
 			continue;
 
-		if (cpu_dai->resume && cpu_dai->ac97_control)
-			cpu_dai->resume(cpu_dai);
-	}
-
-	/* If the CODEC was idle over suspend then it will have been
-	 * left with bias OFF or STANDBY and suspended so we must now
-	 * resume.  Otherwise the suspend was suppressed.
-	 */
-	if (codec_dev->resume) {
-		switch (codec->bias_level) {
-		case SND_SOC_BIAS_STANDBY:
-		case SND_SOC_BIAS_OFF:
-			codec_dev->resume(pdev);
-			break;
-		default:
-			dev_dbg(socdev->dev, "CODEC was on over suspend\n");
-			break;
+		if (cpu_dai->driver->resume && cpu_dai->driver->ac97_control)
+			cpu_dai->driver->resume(cpu_dai);
+	}
+
+	for (i = 0; i < card->num_rtd; i++) {
+		struct snd_soc_codec *codec = card->rtd[i].codec;
+		/* If the CODEC was idle over suspend then it will have been
+		 * left with bias OFF or STANDBY and suspended so we must now
+		 * resume.  Otherwise the suspend was suppressed.
+		 */
+		if (codec->driver->resume && codec->suspended) {
+			switch (codec->bias_level) {
+			case SND_SOC_BIAS_STANDBY:
+			case SND_SOC_BIAS_OFF:
+				codec->driver->resume(codec);
+				codec->suspended = 0;
+				break;
+			default:
+				dev_dbg(codec->dev, "CODEC was on over suspend\n");
+				break;
+			}
 		}
 	}
 
-	for (i = 0; i < codec->num_dai; i++) {
-		char *stream = codec->dai[i].playback.stream_name;
+	for (i = 0; i < card->num_rtd; i++) {
+		struct snd_soc_dai_driver *driver = card->rtd[i].codec_dai->driver;
 
-		if (card->dai_link[i].ignore_suspend)
+		if (card->rtd[i].dai_link->ignore_suspend)
 			continue;
 
-		if (stream != NULL)
-			snd_soc_dapm_stream_event(codec, stream,
+		if (driver->playback.stream_name != NULL)
+			snd_soc_dapm_stream_event(&card->rtd[i], driver->playback.stream_name,
 				SND_SOC_DAPM_STREAM_RESUME);
-		stream = codec->dai[i].capture.stream_name;
-		if (stream != NULL)
-			snd_soc_dapm_stream_event(codec, stream,
+
+		if (driver->capture.stream_name != NULL)
+			snd_soc_dapm_stream_event(&card->rtd[i], driver->capture.stream_name,
 				SND_SOC_DAPM_STREAM_RESUME);
 	}
 
 	/* unmute any active DACs */
-	for (i = 0; i < card->num_links; i++) {
-		struct snd_soc_dai *dai = card->dai_link[i].codec_dai;
+	for (i = 0; i < card->num_rtd; i++) {
+		struct snd_soc_dai *dai = card->rtd[i].codec_dai;
+		struct snd_soc_dai_driver *drv = dai->driver;
 
-		if (card->dai_link[i].ignore_suspend)
+		if (card->rtd[i].dai_link->ignore_suspend)
 			continue;
 
-		if (dai->ops->digital_mute && dai->playback.active)
-			dai->ops->digital_mute(dai, 0);
+		if (drv->ops->digital_mute && dai->playback_active)
+			drv->ops->digital_mute(dai, 0);
 	}
 
-	for (i = 0; i < card->num_links; i++) {
-		struct snd_soc_dai *cpu_dai = card->dai_link[i].cpu_dai;
+	for (i = 0; i < card->num_rtd; i++) {
+		struct snd_soc_dai *cpu_dai = card->rtd[i].cpu_dai;
+		struct snd_soc_platform *platform = card->rtd[i].platform;
 
-		if (card->dai_link[i].ignore_suspend)
+		if (card->rtd[i].dai_link->ignore_suspend)
 			continue;
 
-		if (cpu_dai->resume && !cpu_dai->ac97_control)
-			cpu_dai->resume(cpu_dai);
-		if (platform->resume)
-			platform->resume(&card->dai_link[i]);
+		if (cpu_dai->driver->resume && !cpu_dai->driver->ac97_control)
+			cpu_dai->driver->resume(cpu_dai);
+		if (platform->driver->resume && platform->suspended) {
+			platform->driver->resume(cpu_dai);
+			platform->suspended = 0;
+		}
 	}
 
 	if (card->resume_post)
 		card->resume_post(pdev);
 
-	dev_dbg(socdev->dev, "resume work completed\n");
+	dev_dbg(card->dev, "resume work completed\n");
 
 	/* userspace can access us now we are back as we were before */
-	snd_power_change_state(codec->card, SNDRV_CTL_POWER_D0);
+	snd_power_change_state(card->snd_card, SNDRV_CTL_POWER_D0);
 }
 
 /* powers up audio subsystem after a suspend */
 static int soc_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_card *card = socdev->card;
-	struct snd_soc_dai *cpu_dai = card->dai_link[0].cpu_dai;
-
-	/* If the initialization of this soc device failed, there is no codec
-	 * associated with it. Just bail out in this case.
-	 */
-	if (!card->codec)
-		return 0;
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	int i;
 
 	/* AC97 devices might have other drivers hanging off them so
 	 * need to resume immediately.  Other drivers don't have that
 	 * problem and may take a substantial amount of time to resume
 	 * due to I/O costs and anti-pop so handle them out of line.
 	 */
-	if (cpu_dai->ac97_control) {
-		dev_dbg(socdev->dev, "Resuming AC97 immediately\n");
-		soc_resume_deferred(&card->deferred_resume_work);
-	} else {
-		dev_dbg(socdev->dev, "Scheduling resume work\n");
-		if (!schedule_work(&card->deferred_resume_work))
-			dev_err(socdev->dev, "resume work item may be lost\n");
+	for (i = 0; i < card->num_rtd; i++) {
+		struct snd_soc_dai *cpu_dai = card->rtd[i].cpu_dai;
+		if (cpu_dai->driver->ac97_control) {
+			dev_dbg(dev, "Resuming AC97 immediately\n");
+			soc_resume_deferred(&card->deferred_resume_work);
+		} else {
+			dev_dbg(dev, "Scheduling resume work\n");
+			if (!schedule_work(&card->deferred_resume_work))
+				dev_err(dev, "resume work item may be lost\n");
+		}
 	}
 
 	return 0;
@@ -1124,198 +1113,429 @@ static int soc_resume(struct device *dev)
 static struct snd_soc_dai_ops null_dai_ops = {
 };
 
-static void snd_soc_instantiate_card(struct snd_soc_card *card)
+static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 {
-	struct platform_device *pdev = container_of(card->dev,
-						    struct platform_device,
-						    dev);
-	struct snd_soc_codec_device *codec_dev = card->socdev->codec_dev;
+	struct snd_soc_dai_link *dai_link = &card->dai_link[num];
+	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
 	struct snd_soc_codec *codec;
 	struct snd_soc_platform *platform;
-	struct snd_soc_dai *dai;
-	int i, found, ret, ac97;
+	struct snd_soc_dai *codec_dai, *cpu_dai;
 
-	if (card->instantiated)
-		return;
+	if (rtd->complete)
+		return 1;
+	dev_dbg(card->dev, "binding %s at idx %d\n", dai_link->name, num);
 
-	found = 0;
-	list_for_each_entry(platform, &platform_list, list)
-		if (card->platform == platform) {
-			found = 1;
-			break;
+	/* do we already have the CPU DAI for this link ? */
+	if (rtd->cpu_dai) {
+		goto find_codec;
+	}
+	/* no, then find CPU DAI from registered DAIs*/
+	list_for_each_entry(cpu_dai, &dai_list, list) {
+		if (!strcmp(cpu_dai->name, dai_link->cpu_dai_name)) {
+
+			if (!try_module_get(cpu_dai->dev->driver->owner))
+				return -ENODEV;
+
+			rtd->cpu_dai = cpu_dai;
+			goto find_codec;
 		}
-	if (!found) {
-		dev_dbg(card->dev, "Platform %s not registered\n",
-			card->platform->name);
-		return;
 	}
+	dev_dbg(card->dev, "CPU DAI %s not registered\n",
+			dai_link->cpu_dai_name);
 
-	ac97 = 0;
-	for (i = 0; i < card->num_links; i++) {
-		found = 0;
-		list_for_each_entry(dai, &dai_list, list)
-			if (card->dai_link[i].cpu_dai == dai) {
-				found = 1;
-				break;
+find_codec:
+	/* do we already have the CODEC for this link ? */
+	if (rtd->codec) {
+		goto find_platform;
+	}
+
+	/* no, then find CODEC from registered CODECs*/
+	list_for_each_entry(codec, &codec_list, list) {
+		if (!strcmp(codec->name, dai_link->codec_name)) {
+			rtd->codec = codec;
+
+			if (!try_module_get(codec->dev->driver->owner))
+				return -ENODEV;
+
+			/* CODEC found, so find CODEC DAI from registered DAIs from this CODEC*/
+			list_for_each_entry(codec_dai, &dai_list, list) {
+				if (codec->dev == codec_dai->dev &&
+						!strcmp(codec_dai->name, dai_link->codec_dai_name)) {
+					rtd->codec_dai = codec_dai;
+					goto find_platform;
+				}
 			}
-		if (!found) {
-			dev_dbg(card->dev, "DAI %s not registered\n",
-				card->dai_link[i].cpu_dai->name);
-			return;
+			dev_dbg(card->dev, "CODEC DAI %s not registered\n",
+					dai_link->codec_dai_name);
+
+			goto find_platform;
 		}
+	}
+	dev_dbg(card->dev, "CODEC %s not registered\n",
+			dai_link->codec_name);
 
-		if (card->dai_link[i].cpu_dai->ac97_control)
-			ac97 = 1;
+find_platform:
+	/* do we already have the CODEC DAI for this link ? */
+	if (rtd->platform) {
+		goto out;
 	}
+	/* no, then find CPU DAI from registered DAIs*/
+	list_for_each_entry(platform, &platform_list, list) {
+		if (!strcmp(platform->name, dai_link->platform_name)) {
 
-	for (i = 0; i < card->num_links; i++) {
-		if (!card->dai_link[i].codec_dai->ops)
-			card->dai_link[i].codec_dai->ops = &null_dai_ops;
+			if (!try_module_get(platform->dev->driver->owner))
+				return -ENODEV;
+
+			rtd->platform = platform;
+			goto out;
+		}
 	}
 
-	/* If we have AC97 in the system then don't wait for the
-	 * codec.  This will need revisiting if we have to handle
-	 * systems with mixed AC97 and non-AC97 parts.  Only check for
-	 * DAIs currently; we can't do this per link since some AC97
-	 * codecs have non-AC97 DAIs.
-	 */
-	if (!ac97)
-		for (i = 0; i < card->num_links; i++) {
-			found = 0;
-			list_for_each_entry(dai, &dai_list, list)
-				if (card->dai_link[i].codec_dai == dai) {
-					found = 1;
-					break;
-				}
-			if (!found) {
-				dev_dbg(card->dev, "DAI %s not registered\n",
-					card->dai_link[i].codec_dai->name);
-				return;
-			}
+	dev_dbg(card->dev, "platform %s not registered\n",
+			dai_link->platform_name);
+	return 0;
+
+out:
+	/* mark rtd as complete if we found all 4 of our client devices */
+	if (rtd->codec && rtd->codec_dai && rtd->platform && rtd->cpu_dai) {
+		rtd->complete = 1;
+		card->num_rtd++;
+	}
+	return 1;
+}
+
+static void soc_remove_dai_link(struct snd_soc_card *card, int num)
+{
+	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
+	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai, *cpu_dai = rtd->cpu_dai;
+	int err;
+
+	/* unregister the rtd device */
+	if (rtd->dev_registered) {
+		device_remove_file(&rtd->dev, &dev_attr_pmdown_time);
+		device_unregister(&rtd->dev);
+		rtd->dev_registered = 0;
+	}
+
+	/* remove the CODEC DAI */
+	if (codec_dai && codec_dai->probed) {
+		if (codec_dai->driver->remove) {
+			err = codec_dai->driver->remove(codec_dai);
+			if (err < 0)
+				printk(KERN_ERR "asoc: failed to remove %s\n", codec_dai->name);
 		}
+		codec_dai->probed = 0;
+		list_del(&codec_dai->card_list);
+	}
 
-	/* Note that we do not current check for codec components */
+	/* remove the platform */
+	if (platform && platform->probed) {
+		if (platform->driver->remove) {
+			err = platform->driver->remove(platform);
+			if (err < 0)
+				printk(KERN_ERR "asoc: failed to remove %s\n", platform->name);
+		}
+		platform->probed = 0;
+		list_del(&platform->card_list);
+		module_put(platform->dev->driver->owner);
+	}
 
-	dev_dbg(card->dev, "All components present, instantiating\n");
+	/* remove the CODEC */
+	if (codec && codec->probed) {
+		if (codec->driver->remove) {
+			err = codec->driver->remove(codec);
+			if (err < 0)
+				printk(KERN_ERR "asoc: failed to remove %s\n", codec->name);
+		}
 
-	/* Found everything, bring it up */
-	card->pmdown_time = pmdown_time;
+		/* Make sure all DAPM widgets are freed */
+		snd_soc_dapm_free(codec);
 
-	if (card->probe) {
-		ret = card->probe(pdev);
-		if (ret < 0)
-			return;
+		soc_cleanup_codec_debugfs(codec);
+		device_remove_file(&rtd->dev, &dev_attr_codec_reg);
+		codec->probed = 0;
+		list_del(&codec->card_list);
+		module_put(codec->dev->driver->owner);
 	}
 
-	for (i = 0; i < card->num_links; i++) {
-		struct snd_soc_dai *cpu_dai = card->dai_link[i].cpu_dai;
-		if (cpu_dai->probe) {
-			ret = cpu_dai->probe(pdev, cpu_dai);
-			if (ret < 0)
-				goto cpu_dai_err;
+	/* remove the cpu_dai */
+	if (cpu_dai && cpu_dai->probed) {
+		if (cpu_dai->driver->remove) {
+			err = cpu_dai->driver->remove(cpu_dai);
+			if (err < 0)
+				printk(KERN_ERR "asoc: failed to remove %s\n", cpu_dai->name);
 		}
+		cpu_dai->probed = 0;
+		list_del(&cpu_dai->card_list);
+		module_put(cpu_dai->dev->driver->owner);
 	}
+}
 
-	if (codec_dev->probe) {
-		ret = codec_dev->probe(pdev);
-		if (ret < 0)
-			goto cpu_dai_err;
+static void rtd_release(struct device *dev) {}
+
+static int soc_probe_dai_link(struct snd_soc_card *card, int num)
+{
+	struct snd_soc_dai_link *dai_link = &card->dai_link[num];
+	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
+	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai, *cpu_dai = rtd->cpu_dai;
+	int ret;
+
+	dev_dbg(card->dev, "probe %s dai link %d\n", card->name, num);
+
+	/* config components */
+	platform->snd_card = codec->snd_card = card->snd_card;
+	codec_dai->codec = codec;
+	codec->card = card;
+	cpu_dai->platform = platform;
+	rtd->card = card;
+	rtd->dev.parent = card->dev;
+	codec_dai->card = card;
+	cpu_dai->card = card;
+
+	/* set default power off timeout */
+	rtd->pmdown_time = pmdown_time;
+
+	/* probe the cpu_dai */
+	if (!cpu_dai->probed) {
+		if (cpu_dai->driver->probe) {
+			ret = cpu_dai->driver->probe(cpu_dai);
+			if (ret < 0) {
+				printk(KERN_ERR "asoc: failed to probe CPU DAI %s\n",
+						cpu_dai->name);
+				return ret;
+			}
+		}
+		cpu_dai->probed = 1;
+		/* mark cpu_dai as probed and add to card cpu_dai list */
+		list_add(&cpu_dai->card_list, &card->dai_dev_list);
 	}
-	codec = card->codec;
 
-	if (platform->probe) {
-		ret = platform->probe(pdev);
-		if (ret < 0)
-			goto platform_err;
+	/* probe the CODEC */
+	if (!codec->probed) {
+		if (codec->driver->probe) {
+			ret = codec->driver->probe(codec);
+			if (ret < 0) {
+				printk(KERN_ERR "asoc: failed to probe CODEC %s\n",
+						codec->name);
+				return ret;
+			}
+		}
+		/* mark codec as probed and add to card codec list */
+		codec->probed = 1;
+		list_add(&codec->card_list, &card->codec_dev_list);
 	}
 
-	/* DAPM stream work */
-	INIT_DELAYED_WORK(&card->delayed_work, close_delayed_work);
-#ifdef CONFIG_PM
-	/* deferred resume work */
-	INIT_WORK(&card->deferred_resume_work, soc_resume_deferred);
-#endif
+	/* probe the platform */
+	if (!platform->probed) {
+		if (platform->driver->probe) {
+			ret = platform->driver->probe(platform);
+			if (ret < 0) {
+				printk(KERN_ERR "asoc: failed to probe platform %s\n",
+						platform->name);
+				return ret;
+			}
+		}
+		/* mark platform as probed and add to card platform list */
+		platform->probed = 1;
+		list_add(&platform->card_list, &card->platform_dev_list);
+	}
 
-	for (i = 0; i < card->num_links; i++) {
-		if (card->dai_link[i].init) {
-			ret = card->dai_link[i].init(codec);
+	/* probe the CODEC DAI */
+	if (!codec_dai->probed) {
+		if (codec_dai->driver->probe) {
+			ret = codec_dai->driver->probe(codec_dai);
 			if (ret < 0) {
-				printk(KERN_ERR "asoc: failed to init %s\n",
-					card->dai_link[i].stream_name);
-				continue;
+				printk(KERN_ERR "asoc: failed to probe CODEC DAI %s\n",
+						codec_dai->name);
+				return ret;
 			}
 		}
-		if (card->dai_link[i].codec_dai->ac97_control)
-			ac97 = 1;
+
+		/* mark cpu_dai as probed and add to card cpu_dai list */
+		codec_dai->probed = 1;
+		list_add(&codec_dai->card_list, &card->dai_dev_list);
 	}
 
-	snprintf(codec->card->shortname, sizeof(codec->card->shortname),
-		 "%s",  card->name);
-	snprintf(codec->card->longname, sizeof(codec->card->longname),
-		 "%s (%s)", card->name, codec->name);
+	/* DAPM dai link stream work */
+	INIT_DELAYED_WORK(&rtd->delayed_work, close_delayed_work);
+
+	/* now that all clients have probed, initialise the DAI link */
+	if (dai_link->init) {
+		ret = dai_link->init(rtd);
+		if (ret < 0) {
+			printk(KERN_ERR "asoc: failed to init %s\n", dai_link->stream_name);
+			return ret;
+		}
+	}
 
 	/* Make sure all DAPM widgets are instantiated */
 	snd_soc_dapm_new_widgets(codec);
+	snd_soc_dapm_sync(codec);
 
-	ret = snd_card_register(codec->card);
+	/* register the rtd device */
+	rtd->dev.init_name = rtd->dai_link->stream_name;
+	rtd->dev.release = rtd_release;
+	rtd->dev.init_name = dai_link->name;
+	ret = device_register(&rtd->dev);
 	if (ret < 0) {
-		printk(KERN_ERR "asoc: failed to register soundcard for %s\n",
-				codec->name);
-		goto card_err;
+		printk(KERN_ERR "asoc: failed to register DAI runtime device %d\n", ret);
+		return ret;
 	}
 
-	mutex_lock(&codec->mutex);
+	rtd->dev_registered = 1;
+	ret = device_create_file(&rtd->dev, &dev_attr_pmdown_time);
+	if (ret < 0)
+		printk(KERN_WARNING "asoc: failed to add pmdown_time sysfs\n");
+
+	/* add DAPM sysfs entries for this codec */
+	ret = snd_soc_dapm_sys_add(&rtd->dev);
+	if (ret < 0)
+		printk(KERN_WARNING "asoc: failed to add codec dapm sysfs entries\n");
+
+	/* add codec sysfs entries */
+	ret = device_create_file(&rtd->dev, &dev_attr_codec_reg);
+	if (ret < 0)
+		printk(KERN_WARNING "asoc: failed to add codec sysfs files\n");
+
+	soc_init_codec_debugfs(codec);
+
+	/* create the pcm */
+	ret = soc_new_pcm(rtd, num);
+	if (ret < 0) {
+		printk(KERN_ERR "asoc: can't create pcm %s\n", dai_link->stream_name);
+		return ret;
+	}
+
+	/* add platform data for AC97 devices */
+	if (rtd->codec_dai->driver->ac97_control)
+		snd_ac97_dev_add_pdata(codec->ac97, rtd->cpu_dai->ac97_pdata);
+
+	return 0;
+}
+
 #ifdef CONFIG_SND_SOC_AC97_BUS
+static int soc_register_ac97_dai_link(struct snd_soc_pcm_runtime *rtd)
+{
+	int ret;
+
 	/* Only instantiate AC97 if not already done by the adaptor
 	 * for the generic AC97 subsystem.
 	 */
-	if (ac97 && strcmp(codec->name, "AC97") != 0) {
-		ret = soc_ac97_dev_register(codec);
+	if (rtd->codec_dai->driver->ac97_control && !rtd->codec->ac97_registered) {
+
+		ret = soc_ac97_dev_register(rtd->codec);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: AC97 device register failed\n");
-			snd_card_free(codec->card);
-			mutex_unlock(&codec->mutex);
-			goto card_err;
+			return ret;
 		}
+
+		rtd->codec->ac97_registered = 1;
 	}
+	return 0;
+}
+
+static void soc_unregister_ac97_dai_link(struct snd_soc_codec *codec)
+{
+	if (codec->ac97_registered) {
+		soc_ac97_dev_unregister(codec);
+		codec->ac97_registered = 0;
+	}
+}
 #endif
 
-	ret = snd_soc_dapm_sys_add(card->socdev->dev);
-	if (ret < 0)
-		printk(KERN_WARNING "asoc: failed to add dapm sysfs entries\n");
+static void snd_soc_instantiate_card(struct snd_soc_card *card)
+{
+	struct platform_device *pdev = to_platform_device(card->dev);
+	int ret, i;
 
-	ret = device_create_file(card->socdev->dev, &dev_attr_pmdown_time);
-	if (ret < 0)
-		printk(KERN_WARNING "asoc: failed to add pmdown_time sysfs\n");
+	mutex_lock(&card->mutex);
 
-	ret = device_create_file(card->socdev->dev, &dev_attr_codec_reg);
-	if (ret < 0)
-		printk(KERN_WARNING "asoc: failed to add codec sysfs files\n");
+	if (card->instantiated) {
+		mutex_unlock(&card->mutex);
+		return;
+	}
 
-	soc_init_codec_debugfs(codec);
-	mutex_unlock(&codec->mutex);
+	/* bind DAIs */
+	for (i = 0; i < card->num_links; i++)
+		soc_bind_dai_link(card, i);
 
-	card->instantiated = 1;
+	/* bind completed ? */
+	if (card->num_rtd != card->num_links) {
+		mutex_unlock(&card->mutex);
+		return;
+	}
 
-	return;
+	/* card bind complete so register a sound card */
+	ret = snd_card_create(SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
+			card->owner, 0, &card->snd_card);
+	if (ret < 0) {
+		printk(KERN_ERR "asoc: can't create sound card for card %s\n",
+			card->name);
+		mutex_unlock(&card->mutex);
+		return;
+	}
+	card->snd_card->dev = card->dev;
+
+	/* initialise the sound card only once */
+	if (card->probe) {
+#ifdef CONFIG_PM
+		/* deferred resume work */
+		INIT_WORK(&card->deferred_resume_work, soc_resume_deferred);
+#endif
+		ret = card->probe(pdev);
+		if (ret < 0)
+			goto card_probe_error;
+	}
 
-card_err:
-	if (platform->remove)
-		platform->remove(pdev);
+	for (i = 0; i < card->num_links; i++) {
+		ret = soc_probe_dai_link(card, i);
+		if (ret < 0) {
+			printk(KERN_ERR "asoc: failed to instanciate card %s\n", card->name);
+			goto probe_dai_err;
+		}
+	}
 
-platform_err:
-	if (codec_dev->remove)
-		codec_dev->remove(pdev);
+	snprintf(card->snd_card->shortname, sizeof(card->snd_card->shortname),
+		 "%s",  card->name);
+	snprintf(card->snd_card->longname, sizeof(card->snd_card->longname),
+		 "%s", card->name);
 
-cpu_dai_err:
-	for (i--; i >= 0; i--) {
-		struct snd_soc_dai *cpu_dai = card->dai_link[i].cpu_dai;
-		if (cpu_dai->remove)
-			cpu_dai->remove(pdev, cpu_dai);
+	ret = snd_card_register(card->snd_card);
+	if (ret < 0) {
+		printk(KERN_ERR "asoc: failed to register soundcard for %s\n", card->name);
+		goto probe_dai_err;
 	}
 
+#ifdef CONFIG_SND_SOC_AC97_BUS
+	/* register any AC97 codecs */
+	for (i = 0; i < card->num_rtd; i++) {
+			ret = soc_register_ac97_dai_link(&card->rtd[i]);
+			if (ret < 0) {
+				printk(KERN_ERR "asoc: failed to register AC97 %s\n", card->name);
+				goto probe_dai_err;
+			}
+		}
+#endif
+
+	card->instantiated = 1;
+	mutex_unlock(&card->mutex);
+	return;
+
+probe_dai_err:
+	for (i = 0; i < card->num_links; i++)
+		soc_remove_dai_link(card, i);
+
+card_probe_error:
 	if (card->remove)
 		card->remove(pdev);
+
+	snd_card_free(card->snd_card);
+
+	mutex_unlock(&card->mutex);
 }
 
 /*
@@ -1332,15 +1552,15 @@ static void snd_soc_instantiate_cards(void)
 /* probes a new socdev */
 static int soc_probe(struct platform_device *pdev)
 {
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
 	int ret = 0;
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_card *card = socdev->card;
-
-	/* Bodge while we push things out of socdev */
-	card->socdev = socdev;
 
 	/* Bodge while we unpick instantiation */
 	card->dev = &pdev->dev;
+	INIT_LIST_HEAD(&card->dai_dev_list);
+	INIT_LIST_HEAD(&card->codec_dev_list);
+	INIT_LIST_HEAD(&card->platform_dev_list);
+
 	ret = snd_soc_register_card(card);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "Failed to register card\n");
@@ -1353,50 +1573,49 @@ static int soc_probe(struct platform_device *pdev)
 /* removes a socdev */
 static int soc_remove(struct platform_device *pdev)
 {
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
 	int i;
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_card *card = socdev->card;
-	struct snd_soc_platform *platform = card->platform;
-	struct snd_soc_codec_device *codec_dev = socdev->codec_dev;
-
-	if (card->instantiated) {
-		run_delayed_work(&card->delayed_work);
-
-		if (platform->remove)
-			platform->remove(pdev);
 
-		if (codec_dev->remove)
-			codec_dev->remove(pdev);
+		if (card->instantiated) {
 
-		for (i = 0; i < card->num_links; i++) {
-			struct snd_soc_dai *cpu_dai = card->dai_link[i].cpu_dai;
-			if (cpu_dai->remove)
-				cpu_dai->remove(pdev, cpu_dai);
+		/* make sure any delayed work runs */
+		for (i = 0; i < card->num_rtd; i++) {
+			struct snd_soc_pcm_runtime *rtd = &card->rtd[i];
+			run_delayed_work(&rtd->delayed_work);
 		}
 
+		/* remove and free each DAI */
+		for (i = 0; i < card->num_rtd; i++)
+			soc_remove_dai_link(card, i);
+
+		/* remove the card */
 		if (card->remove)
 			card->remove(pdev);
-	}
 
+		kfree(card->rtd);
+		snd_card_free(card->snd_card);
+	}
 	snd_soc_unregister_card(card);
-
 	return 0;
 }
 
 static int soc_poweroff(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_card *card = socdev->card;
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	int i;
 
 	if (!card->instantiated)
 		return 0;
 
 	/* Flush out pmdown_time work - we actually do want to run it
 	 * now, we're shutting down so no imminent restart. */
-	run_delayed_work(&card->delayed_work);
+	for (i = 0; i < card->num_rtd; i++) {
+		struct snd_soc_pcm_runtime *rtd = &card->rtd[i];
+		run_delayed_work(&rtd->delayed_work);
+	}
 
-	snd_soc_dapm_shutdown(socdev);
+	snd_soc_dapm_shutdown(card);
 
 	return 0;
 }
@@ -1419,53 +1638,42 @@ static struct platform_driver soc_driver = {
 };
 
 /* create a new pcm */
-static int soc_new_pcm(struct snd_soc_device *socdev,
-	struct snd_soc_dai_link *dai_link, int num)
-{
-	struct snd_soc_card *card = socdev->card;
-	struct snd_soc_codec *codec = card->codec;
-	struct snd_soc_platform *platform = card->platform;
-	struct snd_soc_dai *codec_dai = dai_link->codec_dai;
-	struct snd_soc_dai *cpu_dai = dai_link->cpu_dai;
-	struct snd_soc_pcm_runtime *rtd;
+static int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_pcm *pcm;
 	char new_name[64];
 	int ret = 0, playback = 0, capture = 0;
 
-	rtd = kzalloc(sizeof(struct snd_soc_pcm_runtime), GFP_KERNEL);
-	if (rtd == NULL)
-		return -ENOMEM;
-
-	rtd->dai = dai_link;
-	rtd->socdev = socdev;
-	codec_dai->codec = card->codec;
-
 	/* check client and interface hw capabilities */
 	snprintf(new_name, sizeof(new_name), "%s %s-%d",
-		 dai_link->stream_name, codec_dai->name, num);
+			rtd->dai_link->stream_name, codec_dai->name, num);
 
-	if (codec_dai->playback.channels_min)
+	if (codec_dai->driver->playback.channels_min)
 		playback = 1;
-	if (codec_dai->capture.channels_min)
+	if (codec_dai->driver->capture.channels_min)
 		capture = 1;
 
-	ret = snd_pcm_new(codec->card, new_name, codec->pcm_devs++, playback,
-		capture, &pcm);
+	dev_dbg(rtd->card->dev, "registered pcm #%d %s\n",num,new_name);
+	ret = snd_pcm_new(rtd->card->snd_card, new_name,
+			num, playback, capture, &pcm);
 	if (ret < 0) {
-		printk(KERN_ERR "asoc: can't create pcm for codec %s\n",
-			codec->name);
-		kfree(rtd);
+		printk(KERN_ERR "asoc: can't create pcm for codec %s\n", codec->name);
 		return ret;
 	}
 
-	dai_link->pcm = pcm;
+	rtd->pcm = pcm;
 	pcm->private_data = rtd;
-	soc_pcm_ops.mmap = platform->pcm_ops->mmap;
-	soc_pcm_ops.ioctl = platform->pcm_ops->ioctl;
-	soc_pcm_ops.copy = platform->pcm_ops->copy;
-	soc_pcm_ops.silence = platform->pcm_ops->silence;
-	soc_pcm_ops.ack = platform->pcm_ops->ack;
-	soc_pcm_ops.page = platform->pcm_ops->page;
+	soc_pcm_ops.mmap = platform->driver->ops->mmap;
+	soc_pcm_ops.pointer = platform->driver->ops->pointer;
+	soc_pcm_ops.ioctl = platform->driver->ops->ioctl;
+	soc_pcm_ops.copy = platform->driver->ops->copy;
+	soc_pcm_ops.silence = platform->driver->ops->silence;
+	soc_pcm_ops.ack = platform->driver->ops->ack;
+	soc_pcm_ops.page = platform->driver->ops->page;
 
 	if (playback)
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &soc_pcm_ops);
@@ -1473,14 +1681,13 @@ static int soc_new_pcm(struct snd_soc_device *socdev,
 	if (capture)
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &soc_pcm_ops);
 
-	ret = platform->pcm_new(codec->card, codec_dai, pcm);
+	ret = platform->driver->pcm_new(rtd->card->snd_card, codec_dai, pcm);
 	if (ret < 0) {
 		printk(KERN_ERR "asoc: platform pcm constructor failed\n");
-		kfree(rtd);
 		return ret;
 	}
 
-	pcm->private_free = platform->pcm_free;
+	pcm->private_free = platform->driver->pcm_free;
 	printk(KERN_INFO "asoc: %s <-> %s mapping ok\n", codec_dai->name,
 		cpu_dai->name);
 	return ret;
@@ -1496,8 +1703,8 @@ static int soc_new_pcm(struct snd_soc_device *socdev,
  */
 int snd_soc_codec_volatile_register(struct snd_soc_codec *codec, int reg)
 {
-	if (codec->volatile_register)
-		return codec->volatile_register(reg);
+	if (codec->driver->volatile_register)
+		return codec->driver->volatile_register(reg);
 	else
 		return 0;
 }
@@ -1532,7 +1739,6 @@ int snd_soc_new_ac97_codec(struct snd_soc_codec *codec,
 
 	codec->ac97->bus->ops = ops;
 	codec->ac97->num = num;
-	codec->dev = &codec->ac97->dev;
 	mutex_unlock(&codec->mutex);
 	return 0;
 }
@@ -1547,6 +1753,9 @@ EXPORT_SYMBOL_GPL(snd_soc_new_ac97_codec);
 void snd_soc_free_ac97_codec(struct snd_soc_codec *codec)
 {
 	mutex_lock(&codec->mutex);
+#ifdef CONFIG_SND_SOC_AC97_BUS
+	soc_unregister_ac97_dai_link(codec);
+#endif
 	kfree(codec->ac97->bus);
 	kfree(codec->ac97);
 	codec->ac97 = NULL;
@@ -1633,95 +1842,6 @@ int snd_soc_test_bits(struct snd_soc_codec *codec, unsigned short reg,
 EXPORT_SYMBOL_GPL(snd_soc_test_bits);
 
 /**
- * snd_soc_new_pcms - create new sound card and pcms
- * @socdev: the SoC audio device
- * @idx: ALSA card index
- * @xid: card identification
- *
- * Create a new sound card based upon the codec and interface pcms.
- *
- * Returns 0 for success, else error.
- */
-int snd_soc_new_pcms(struct snd_soc_device *socdev, int idx, const char *xid)
-{
-	struct snd_soc_card *card = socdev->card;
-	struct snd_soc_codec *codec = card->codec;
-	int ret, i;
-
-	mutex_lock(&codec->mutex);
-
-	/* register a sound card */
-	ret = snd_card_create(idx, xid, codec->owner, 0, &codec->card);
-	if (ret < 0) {
-		printk(KERN_ERR "asoc: can't create sound card for codec %s\n",
-			codec->name);
-		mutex_unlock(&codec->mutex);
-		return ret;
-	}
-
-	codec->socdev = socdev;
-	codec->card->dev = socdev->dev;
-	codec->card->private_data = codec;
-	strncpy(codec->card->driver, codec->name, sizeof(codec->card->driver));
-
-	/* create the pcms */
-	for (i = 0; i < card->num_links; i++) {
-		ret = soc_new_pcm(socdev, &card->dai_link[i], i);
-		if (ret < 0) {
-			printk(KERN_ERR "asoc: can't create pcm %s\n",
-				card->dai_link[i].stream_name);
-			mutex_unlock(&codec->mutex);
-			return ret;
-		}
-		/* Check for codec->ac97 to handle the ac97.c fun */
-		if (card->dai_link[i].codec_dai->ac97_control && codec->ac97) {
-			snd_ac97_dev_add_pdata(codec->ac97,
-				card->dai_link[i].cpu_dai->ac97_pdata);
-		}
-	}
-
-	mutex_unlock(&codec->mutex);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(snd_soc_new_pcms);
-
-/**
- * snd_soc_free_pcms - free sound card and pcms
- * @socdev: the SoC audio device
- *
- * Frees sound card and pcms associated with the socdev.
- * Also unregister the codec if it is an AC97 device.
- */
-void snd_soc_free_pcms(struct snd_soc_device *socdev)
-{
-	struct snd_soc_codec *codec = socdev->card->codec;
-#ifdef CONFIG_SND_SOC_AC97_BUS
-	struct snd_soc_dai *codec_dai;
-	int i;
-#endif
-
-	mutex_lock(&codec->mutex);
-	soc_cleanup_codec_debugfs(codec);
-#ifdef CONFIG_SND_SOC_AC97_BUS
-	for (i = 0; i < codec->num_dai; i++) {
-		codec_dai = &codec->dai[i];
-		if (codec_dai->ac97_control && codec->ac97 &&
-		    strcmp(codec->name, "AC97") != 0) {
-			soc_ac97_dev_unregister(codec);
-			goto free_card;
-		}
-	}
-free_card:
-#endif
-
-	if (codec->card)
-		snd_card_free(codec->card);
-	device_remove_file(socdev->dev, &dev_attr_codec_reg);
-	mutex_unlock(&codec->mutex);
-}
-EXPORT_SYMBOL_GPL(snd_soc_free_pcms);
-
-/**
  * snd_soc_set_runtime_hwparams - set the runtime hardware parameters
  * @substream: the pcm substream
  * @hw: the hardware parameters
@@ -1782,7 +1902,7 @@ EXPORT_SYMBOL_GPL(snd_soc_cnew);
 int snd_soc_add_controls(struct snd_soc_codec *codec,
 	const struct snd_kcontrol_new *controls, int num_controls)
 {
-	struct snd_card *card = codec->card;
+	struct snd_card *card = codec->snd_card;
 	int err, i;
 
 	for (i = 0; i < num_controls; i++) {
@@ -2337,7 +2457,7 @@ EXPORT_SYMBOL_GPL(snd_soc_put_volsw_s8);
 int snd_soc_limit_volume(struct snd_soc_codec *codec,
 	const char *name, int max)
 {
-	struct snd_card *card = codec->card;
+	struct snd_card *card = codec->snd_card;
 	struct snd_kcontrol *kctl;
 	struct soc_mixer_control *mc;
 	int found = 0;
@@ -2469,8 +2589,8 @@ EXPORT_SYMBOL_GPL(snd_soc_put_volsw_2r_sx);
 int snd_soc_dai_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	unsigned int freq, int dir)
 {
-	if (dai->ops && dai->ops->set_sysclk)
-		return dai->ops->set_sysclk(dai, clk_id, freq, dir);
+	if (dai->driver && dai->driver->ops->set_sysclk)
+		return dai->driver->ops->set_sysclk(dai, clk_id, freq, dir);
 	else
 		return -EINVAL;
 }
@@ -2489,8 +2609,8 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_sysclk);
 int snd_soc_dai_set_clkdiv(struct snd_soc_dai *dai,
 	int div_id, int div)
 {
-	if (dai->ops && dai->ops->set_clkdiv)
-		return dai->ops->set_clkdiv(dai, div_id, div);
+	if (dai->driver && dai->driver->ops->set_clkdiv)
+		return dai->driver->ops->set_clkdiv(dai, div_id, div);
 	else
 		return -EINVAL;
 }
@@ -2509,8 +2629,8 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_clkdiv);
 int snd_soc_dai_set_pll(struct snd_soc_dai *dai, int pll_id, int source,
 	unsigned int freq_in, unsigned int freq_out)
 {
-	if (dai->ops && dai->ops->set_pll)
-		return dai->ops->set_pll(dai, pll_id, source,
+	if (dai->driver && dai->driver->ops->set_pll)
+		return dai->driver->ops->set_pll(dai, pll_id, source,
 					 freq_in, freq_out);
 	else
 		return -EINVAL;
@@ -2526,8 +2646,8 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_pll);
  */
 int snd_soc_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	if (dai->ops && dai->ops->set_fmt)
-		return dai->ops->set_fmt(dai, fmt);
+	if (dai->driver && dai->driver->ops->set_fmt)
+		return dai->driver->ops->set_fmt(dai, fmt);
 	else
 		return -EINVAL;
 }
@@ -2547,8 +2667,8 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_fmt);
 int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
 	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
 {
-	if (dai->ops && dai->ops->set_tdm_slot)
-		return dai->ops->set_tdm_slot(dai, tx_mask, rx_mask,
+	if (dai->driver && dai->driver->ops->set_tdm_slot)
+		return dai->driver->ops->set_tdm_slot(dai, tx_mask, rx_mask,
 				slots, slot_width);
 	else
 		return -EINVAL;
@@ -2571,8 +2691,8 @@ int snd_soc_dai_set_channel_map(struct snd_soc_dai *dai,
 	unsigned int tx_num, unsigned int *tx_slot,
 	unsigned int rx_num, unsigned int *rx_slot)
 {
-	if (dai->ops && dai->ops->set_channel_map)
-		return dai->ops->set_channel_map(dai, tx_num, tx_slot,
+	if (dai->driver && dai->driver->ops->set_channel_map)
+		return dai->driver->ops->set_channel_map(dai, tx_num, tx_slot,
 			rx_num, rx_slot);
 	else
 		return -EINVAL;
@@ -2588,8 +2708,8 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_channel_map);
  */
 int snd_soc_dai_set_tristate(struct snd_soc_dai *dai, int tristate)
 {
-	if (dai->ops && dai->ops->set_tristate)
-		return dai->ops->set_tristate(dai, tristate);
+	if (dai->driver && dai->driver->ops->set_tristate)
+		return dai->driver->ops->set_tristate(dai, tristate);
 	else
 		return -EINVAL;
 }
@@ -2604,8 +2724,8 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_tristate);
  */
 int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute)
 {
-	if (dai->ops && dai->ops->digital_mute)
-		return dai->ops->digital_mute(dai, mute);
+	if (dai->driver && dai->driver->ops->digital_mute)
+		return dai->driver->ops->digital_mute(dai, mute);
 	else
 		return -EINVAL;
 }
@@ -2622,11 +2742,22 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_digital_mute);
  */
 static int snd_soc_register_card(struct snd_soc_card *card)
 {
+	int i;
+
 	if (!card->name || !card->dev)
 		return -EINVAL;
 
+	card->rtd = kzalloc(sizeof(struct snd_soc_pcm_runtime) * card->num_links,
+			GFP_KERNEL);
+	if (card->rtd == NULL)
+		return -ENOMEM;
+
+	for (i = 0; i < card->num_links; i++)
+		card->rtd[i].dai_link = &card->dai_link[i];
+
 	INIT_LIST_HEAD(&card->list);
 	card->instantiated = 0;
+	mutex_init(&card->mutex);
 
 	mutex_lock(&client_mutex);
 	list_add(&card->list, &card_list);
@@ -2652,30 +2783,97 @@ static int snd_soc_unregister_card(struct snd_soc_card *card)
 	mutex_lock(&client_mutex);
 	list_del(&card->list);
 	mutex_unlock(&client_mutex);
-
 	dev_dbg(card->dev, "Unregistered card '%s'\n", card->name);
 
 	return 0;
 }
 
+/*
+ * Simplify DAI link configuration by removing ".-1" from device names
+ * and sanitizing names.
+ */
+static inline char *fmt_single_name(struct device *dev, int *id)
+{
+	char *found, name[NAME_SIZE];
+	int id1, id2;
+
+	if (dev_name(dev) == NULL)
+		return NULL;
+
+	strncpy(name, dev_name(dev), NAME_SIZE);
+
+	/* are we a "%s.%d" name (platform and SPI components) */
+	found = strstr(name, dev->driver->name);
+	if (found) {
+		/* get ID */
+		if (sscanf(&found[strlen(dev->driver->name)], ".%d", id) == 1) {
+
+			/* discard ID from name if ID == -1 */
+			if (*id == -1)
+				found[strlen(dev->driver->name)] = '\0';
+		}
+
+	} else {
+		/* I2C component devices are named "bus-addr"  */
+		if (sscanf(name, "%x-%x", &id1, &id2) == 2) {
+			char tmp[NAME_SIZE];
+
+			/* create unique ID number from I2C addr and bus */
+			*id = ((id1 && 0xffff) << 16) + id2;
+
+			/* sanitize component name for DAI link creation */
+			snprintf(tmp, NAME_SIZE, "%s.%s", dev->driver->name, name);
+			strncpy(name, tmp, NAME_SIZE);
+		} else
+			*id = 0;
+	}
+
+	return kstrdup(name, GFP_KERNEL);
+}
+
+/*
+ * Simplify DAI link naming for single devices with multiple DAIs by removing
+ * any ".-1" and using the DAI name (instead of device name).
+ */
+static inline char *fmt_multiple_name(struct device *dev,
+		struct snd_soc_dai_driver *dai_drv)
+{
+	if (dai_drv->name == NULL) {
+		printk(KERN_ERR "asoc: error - multiple DAI %s registered with no name\n",
+				dev_name(dev));
+		return NULL;
+	}
+
+	return kstrdup(dai_drv->name, GFP_KERNEL);
+}
+
 /**
  * snd_soc_register_dai - Register a DAI with the ASoC core
  *
  * @dai: DAI to register
  */
-int snd_soc_register_dai(struct snd_soc_dai *dai)
+int snd_soc_register_dai(struct device *dev,
+		struct snd_soc_dai_driver *dai_drv)
 {
-	if (!dai->name)
-		return -EINVAL;
+	struct snd_soc_dai *dai;
 
-	/* The device should become mandatory over time */
-	if (!dai->dev)
-		printk(KERN_WARNING "No device for DAI %s\n", dai->name);
+	dev_dbg(dev, "dai register %s\n", dev_name(dev));
 
-	if (!dai->ops)
-		dai->ops = &null_dai_ops;
+	dai = kzalloc(sizeof(struct snd_soc_dai), GFP_KERNEL);
+	if (dai == NULL)
+			return -ENOMEM;
 
-	INIT_LIST_HEAD(&dai->list);
+	/* create DAI component name */
+	dai->name = fmt_single_name(dev, &dai->id);
+	if (dai->name == NULL) {
+		kfree(dai);
+		return -ENOMEM;
+	}
+
+	dai->dev = dev;
+	dai->driver = dai_drv;
+	if (!dai->driver->ops)
+		dai->driver->ops = &null_dai_ops;
 
 	mutex_lock(&client_mutex);
 	list_add(&dai->list, &dai_list);
@@ -2693,13 +2891,24 @@ EXPORT_SYMBOL_GPL(snd_soc_register_dai);
  *
  * @dai: DAI to unregister
  */
-void snd_soc_unregister_dai(struct snd_soc_dai *dai)
+void snd_soc_unregister_dai(struct device *dev)
 {
+	struct snd_soc_dai *dai;
+
+	list_for_each_entry(dai, &dai_list, list) {
+		if (dev == dai->dev)
+			goto found;
+	}
+	return;
+
+found:
 	mutex_lock(&client_mutex);
 	list_del(&dai->list);
 	mutex_unlock(&client_mutex);
 
 	pr_debug("Unregistered DAI '%s'\n", dai->name);
+	kfree(dai->name);
+	kfree(dai);
 }
 EXPORT_SYMBOL_GPL(snd_soc_unregister_dai);
 
@@ -2709,21 +2918,47 @@ EXPORT_SYMBOL_GPL(snd_soc_unregister_dai);
  * @dai: Array of DAIs to register
  * @count: Number of DAIs
  */
-int snd_soc_register_dais(struct snd_soc_dai *dai, size_t count)
+int snd_soc_register_dais(struct device *dev,
+		struct snd_soc_dai_driver *dai_drv, size_t count)
 {
-	int i, ret;
+	struct snd_soc_dai *dai;
+	int i, ret = 0;
+
+	dev_dbg(dev, "dai register %s #%d\n", dev_name(dev), count);
 
 	for (i = 0; i < count; i++) {
-		ret = snd_soc_register_dai(&dai[i]);
-		if (ret != 0)
+
+		dai = kzalloc(sizeof(struct snd_soc_dai), GFP_KERNEL);
+		if (dai == NULL)
+			return -ENOMEM;
+
+		/* create DAI component name */
+		dai->name = fmt_multiple_name(dev, &dai_drv[i]);
+		if (dai->name == NULL) {
+			kfree(dai);
+			ret = -EINVAL;
 			goto err;
+		}
+
+		dai->dev = dev;
+		dai->id = i;
+		dai->driver = &dai_drv[i];
+		if (!dai->driver->ops)
+			dai->driver->ops = &null_dai_ops;
+
+		mutex_lock(&client_mutex);
+		list_add(&dai->list, &dai_list);
+		mutex_unlock(&client_mutex);
+
+		pr_debug("Registered DAI '%s'\n", dai->name);
 	}
 
+	snd_soc_instantiate_cards();
 	return 0;
 
 err:
 	for (i--; i >= 0; i--)
-		snd_soc_unregister_dai(&dai[i]);
+		snd_soc_unregister_dai(dev);
 
 	return ret;
 }
@@ -2735,12 +2970,12 @@ EXPORT_SYMBOL_GPL(snd_soc_register_dais);
  * @dai: Array of DAIs to unregister
  * @count: Number of DAIs
  */
-void snd_soc_unregister_dais(struct snd_soc_dai *dai, size_t count)
+void snd_soc_unregister_dais(struct device *dev, size_t count)
 {
 	int i;
 
 	for (i = 0; i < count; i++)
-		snd_soc_unregister_dai(&dai[i]);
+		snd_soc_unregister_dai(dev);
 }
 EXPORT_SYMBOL_GPL(snd_soc_unregister_dais);
 
@@ -2749,12 +2984,26 @@ EXPORT_SYMBOL_GPL(snd_soc_unregister_dais);
  *
  * @platform: platform to register
  */
-int snd_soc_register_platform(struct snd_soc_platform *platform)
+int snd_soc_register_platform(struct device *dev,
+		struct snd_soc_platform_driver *platform_drv)
 {
-	if (!platform->name)
-		return -EINVAL;
+	struct snd_soc_platform *platform;
+
+	dev_dbg(dev, "platform register %s\n", dev_name(dev));
 
-	INIT_LIST_HEAD(&platform->list);
+	platform = kzalloc(sizeof(struct snd_soc_platform), GFP_KERNEL);
+	if (platform == NULL)
+			return -ENOMEM;
+
+	/* create platform component name */
+	platform->name = fmt_single_name(dev, &platform->id);
+	if (platform->name == NULL) {
+		kfree(platform);
+		return -ENOMEM;
+	}
+
+	platform->dev = dev;
+	platform->driver = platform_drv;
 
 	mutex_lock(&client_mutex);
 	list_add(&platform->list, &platform_list);
@@ -2772,13 +3021,24 @@ EXPORT_SYMBOL_GPL(snd_soc_register_platform);
  *
  * @platform: platform to unregister
  */
-void snd_soc_unregister_platform(struct snd_soc_platform *platform)
+void snd_soc_unregister_platform(struct device *dev)
 {
+	struct snd_soc_platform *platform;
+
+	list_for_each_entry(platform, &platform_list, list) {
+		if (dev == platform->dev)
+			goto found;
+	}
+	return;
+
+found:
 	mutex_lock(&client_mutex);
 	list_del(&platform->list);
 	mutex_unlock(&client_mutex);
 
 	pr_debug("Unregistered platform '%s'\n", platform->name);
+	kfree(platform->name);
+	kfree(platform);
 }
 EXPORT_SYMBOL_GPL(snd_soc_unregister_platform);
 
@@ -2820,32 +3080,78 @@ static void fixup_codec_formats(struct snd_soc_pcm_stream *stream)
  *
  * @codec: codec to register
  */
-int snd_soc_register_codec(struct snd_soc_codec *codec)
+int snd_soc_register_codec(struct device *dev,
+		struct snd_soc_codec_driver *codec_drv,
+		struct snd_soc_dai_driver *dai_drv, int num_dai)
 {
-	int i;
+	struct snd_soc_codec *codec;
+	int ret, i;
 
-	if (!codec->name)
-		return -EINVAL;
+	dev_dbg(dev, "codec register %s\n", dev_name(dev));
 
-	/* The device should become mandatory over time */
-	if (!codec->dev)
-		printk(KERN_WARNING "No device for codec %s\n", codec->name);
+	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
+	if (codec == NULL)
+		return -ENOMEM;
 
-	INIT_LIST_HEAD(&codec->list);
+	/* create CODEC component name */
+	codec->name = fmt_single_name(dev, &codec->id);
+	if (codec->name == NULL) {
+		kfree(codec);
+		return -ENOMEM;
+	}
 
-	for (i = 0; i < codec->num_dai; i++) {
-		fixup_codec_formats(&codec->dai[i].playback);
-		fixup_codec_formats(&codec->dai[i].capture);
+	/* allocate CODEC register cache */
+	if (codec_drv->reg_cache_size && codec_drv->reg_word_size) {
+
+		if (codec_drv->reg_cache_default)
+			codec->reg_cache = kmemdup(codec_drv->reg_cache_default,
+				codec_drv->reg_cache_size * codec_drv->reg_word_size, GFP_KERNEL);
+		else
+			codec->reg_cache = kzalloc(codec_drv->reg_cache_size *
+				codec_drv->reg_word_size, GFP_KERNEL);
+
+		if (codec->reg_cache == NULL) {
+			kfree(codec->name);
+			kfree(codec);
+			return -ENOMEM;
+		}
+	}
+
+	codec->dev = dev;
+	codec->driver = codec_drv;
+	codec->bias_level = SND_SOC_BIAS_OFF;
+	codec->num_dai = num_dai;
+	mutex_init(&codec->mutex);
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	for (i = 0; i < num_dai; i++) {
+		fixup_codec_formats(&dai_drv[i].playback);
+		fixup_codec_formats(&dai_drv[i].capture);
 	}
 
+	/* register DAIs */
+	ret = snd_soc_register_dais(dev, dai_drv, num_dai);
+	if (ret < 0)
+			goto error;
+
 	mutex_lock(&client_mutex);
 	list_add(&codec->list, &codec_list);
 	snd_soc_instantiate_cards();
 	mutex_unlock(&client_mutex);
 
 	pr_debug("Registered codec '%s'\n", codec->name);
-
 	return 0;
+
+error:
+	for (i--; i >= 0; i--)
+		snd_soc_unregister_dai(dev);
+
+	if (codec->reg_cache)
+		kfree(codec->reg_cache);
+	kfree(codec->name);
+	kfree(codec);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_register_codec);
 
@@ -2854,13 +3160,30 @@ EXPORT_SYMBOL_GPL(snd_soc_register_codec);
  *
  * @codec: codec to unregister
  */
-void snd_soc_unregister_codec(struct snd_soc_codec *codec)
+void snd_soc_unregister_codec(struct device *dev)
 {
+	struct snd_soc_codec *codec;
+	int i;
+
+	list_for_each_entry(codec, &codec_list, list) {
+		if (dev == codec->dev)
+			goto found;
+	}
+	return;
+
+found:
+	for (i = 0; i < codec->num_dai; i++)
+		snd_soc_unregister_dai(dev);
+
 	mutex_lock(&client_mutex);
 	list_del(&codec->list);
 	mutex_unlock(&client_mutex);
 
 	pr_debug("Unregistered codec '%s'\n", codec->name);
+
+	if (codec->reg_cache)
+		kfree(codec->reg_cache);
+	kfree(codec);
 }
 EXPORT_SYMBOL_GPL(snd_soc_unregister_codec);
 
-- 
1.7.0.4
