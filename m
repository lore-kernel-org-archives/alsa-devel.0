From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: core checkpatch cleanups
Date: Mon, 19 May 2008 11:20:41 +0100
Message-ID: <1211192441-28912-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1211192441-28912-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1211192441-28912-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1211192441-28912-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2E310245F9
	for <alsa-devel@alsa-project.org>;
	Mon, 19 May 2008 12:20:43 +0200 (CEST)
In-Reply-To: <1211192441-28912-3-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |  100 +++++++++++++++++++++++++++-----------------------
 1 files changed, 54 insertions(+), 46 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a05b345..a3f091e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -108,9 +108,9 @@ static int soc_ac97_dev_register(struct snd_soc_codec *codec)
 }
 #endif
 
-static inline const char* get_dai_name(int type)
+static inline const char *get_dai_name(int type)
 {
-	switch(type) {
+	switch (type) {
 	case SND_SOC_DAI_AC97_BUS:
 	case SND_SOC_DAI_AC97:
 		return "AC97";
@@ -178,9 +178,11 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	/* Check that the codec and cpu DAI's are compatible */
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		runtime->hw.rate_min =
-			max(codec_dai->playback.rate_min, cpu_dai->playback.rate_min);
+			max(codec_dai->playback.rate_min,
+			    cpu_dai->playback.rate_min);
 		runtime->hw.rate_max =
-			min(codec_dai->playback.rate_max, cpu_dai->playback.rate_max);
+			min(codec_dai->playback.rate_max,
+			    cpu_dai->playback.rate_max);
 		runtime->hw.channels_min =
 			max(codec_dai->playback.channels_min,
 				cpu_dai->playback.channels_min);
@@ -193,9 +195,11 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 			codec_dai->playback.rates & cpu_dai->playback.rates;
 	} else {
 		runtime->hw.rate_min =
-			max(codec_dai->capture.rate_min, cpu_dai->capture.rate_min);
+			max(codec_dai->capture.rate_min,
+			    cpu_dai->capture.rate_min);
 		runtime->hw.rate_max =
-			min(codec_dai->capture.rate_max, cpu_dai->capture.rate_max);
+			min(codec_dai->capture.rate_max,
+			    cpu_dai->capture.rate_max);
 		runtime->hw.channels_min =
 			max(codec_dai->capture.channels_min,
 				cpu_dai->capture.channels_min);
@@ -225,7 +229,7 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 		goto machine_err;
 	}
 
-	dbg("asoc: %s <-> %s info:\n",codec_dai->name, cpu_dai->name);
+	dbg("asoc: %s <-> %s info:\n", codec_dai->name, cpu_dai->name);
 	dbg("asoc: rate mask 0x%x\n", runtime->hw.rates);
 	dbg("asoc: min ch %d max ch %d\n", runtime->hw.channels_min,
 		runtime->hw.channels_max);
@@ -272,7 +276,7 @@ static void close_delayed_work(struct work_struct *work)
 	int i;
 
 	mutex_lock(&pcm_mutex);
-	for(i = 0; i < codec->num_dai; i++) {
+	for (i = 0; i < codec->num_dai; i++) {
 		codec_dai = &codec->dai[i];
 
 		dbg("pop wq checking: %s status: %s waiting: %s\n",
@@ -511,7 +515,7 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (cpu_dai->ops.hw_params) {
 		ret = cpu_dai->ops.hw_params(substream, params);
 		if (ret < 0) {
-			printk(KERN_ERR "asoc: can't set interface %s hw params\n",
+			printk(KERN_ERR "asoc: interface %s hw params failed\n",
 				cpu_dai->name);
 			goto interface_err;
 		}
@@ -520,7 +524,7 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (platform->pcm_ops->hw_params) {
 		ret = platform->pcm_ops->hw_params(substream, params);
 		if (ret < 0) {
-			printk(KERN_ERR "asoc: can't set platform %s hw params\n",
+			printk(KERN_ERR "asoc: platform %s hw params failed\n",
 				platform->name);
 			goto platform_err;
 		}
@@ -539,7 +543,7 @@ interface_err:
 		codec_dai->ops.hw_free(substream);
 
 codec_err:
-	if(machine->ops && machine->ops->hw_free)
+	if (machine->ops && machine->ops->hw_free)
 		machine->ops->hw_free(substream);
 
 	mutex_unlock(&pcm_mutex);
@@ -628,15 +632,15 @@ static struct snd_pcm_ops soc_pcm_ops = {
 /* powers down audio subsystem for suspend */
 static int soc_suspend(struct platform_device *pdev, pm_message_t state)
 {
- 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
- 	struct snd_soc_machine *machine = socdev->machine;
- 	struct snd_soc_platform *platform = socdev->platform;
- 	struct snd_soc_codec_device *codec_dev = socdev->codec_dev;
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_machine *machine = socdev->machine;
+	struct snd_soc_platform *platform = socdev->platform;
+	struct snd_soc_codec_device *codec_dev = socdev->codec_dev;
 	struct snd_soc_codec *codec = socdev->codec;
 	int i;
 
 	/* mute any active DAC's */
-	for(i = 0; i < machine->num_links; i++) {
+	for (i = 0; i < machine->num_links; i++) {
 		struct snd_soc_codec_dai *dai = machine->dai_link[i].codec_dai;
 		if (dai->dai_ops.digital_mute && dai->playback.active)
 			dai->dai_ops.digital_mute(dai, 1);
@@ -649,7 +653,7 @@ static int soc_suspend(struct platform_device *pdev, pm_message_t state)
 	if (machine->suspend_pre)
 		machine->suspend_pre(pdev, state);
 
-	for(i = 0; i < machine->num_links; i++) {
+	for (i = 0; i < machine->num_links; i++) {
 		struct snd_soc_cpu_dai  *cpu_dai = machine->dai_link[i].cpu_dai;
 		if (cpu_dai->suspend && cpu_dai->type != SND_SOC_DAI_AC97)
 			cpu_dai->suspend(pdev, cpu_dai);
@@ -661,7 +665,7 @@ static int soc_suspend(struct platform_device *pdev, pm_message_t state)
 	run_delayed_work(&socdev->delayed_work);
 	codec->suspend_bias_level = codec->bias_level;
 
-	for(i = 0; i < codec->num_dai; i++) {
+	for (i = 0; i < codec->num_dai; i++) {
 		char *stream = codec->dai[i].playback.stream_name;
 		if (stream != NULL)
 			snd_soc_dapm_stream_event(codec, stream,
@@ -675,7 +679,7 @@ static int soc_suspend(struct platform_device *pdev, pm_message_t state)
 	if (codec_dev->suspend)
 		codec_dev->suspend(pdev, state);
 
-	for(i = 0; i < machine->num_links; i++) {
+	for (i = 0; i < machine->num_links; i++) {
 		struct snd_soc_cpu_dai *cpu_dai = machine->dai_link[i].cpu_dai;
 		if (cpu_dai->suspend && cpu_dai->type == SND_SOC_DAI_AC97)
 			cpu_dai->suspend(pdev, cpu_dai);
@@ -690,17 +694,17 @@ static int soc_suspend(struct platform_device *pdev, pm_message_t state)
 /* powers up audio subsystem after a suspend */
 static int soc_resume(struct platform_device *pdev)
 {
- 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
- 	struct snd_soc_machine *machine = socdev->machine;
- 	struct snd_soc_platform *platform = socdev->platform;
- 	struct snd_soc_codec_device *codec_dev = socdev->codec_dev;
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_machine *machine = socdev->machine;
+	struct snd_soc_platform *platform = socdev->platform;
+	struct snd_soc_codec_device *codec_dev = socdev->codec_dev;
 	struct snd_soc_codec *codec = socdev->codec;
 	int i;
 
 	if (machine->resume_pre)
 		machine->resume_pre(pdev);
 
-	for(i = 0; i < machine->num_links; i++) {
+	for (i = 0; i < machine->num_links; i++) {
 		struct snd_soc_cpu_dai *cpu_dai = machine->dai_link[i].cpu_dai;
 		if (cpu_dai->resume && cpu_dai->type == SND_SOC_DAI_AC97)
 			cpu_dai->resume(pdev, cpu_dai);
@@ -709,8 +713,8 @@ static int soc_resume(struct platform_device *pdev)
 	if (codec_dev->resume)
 		codec_dev->resume(pdev);
 
-	for(i = 0; i < codec->num_dai; i++) {
-		char* stream = codec->dai[i].playback.stream_name;
+	for (i = 0; i < codec->num_dai; i++) {
+		char *stream = codec->dai[i].playback.stream_name;
 		if (stream != NULL)
 			snd_soc_dapm_stream_event(codec, stream,
 				SND_SOC_DAPM_STREAM_RESUME);
@@ -720,14 +724,14 @@ static int soc_resume(struct platform_device *pdev)
 				SND_SOC_DAPM_STREAM_RESUME);
 	}
 
-	/* unmute any active DAC's */
-	for(i = 0; i < machine->num_links; i++) {
+	/* unmute any active DACs */
+	for (i = 0; i < machine->num_links; i++) {
 		struct snd_soc_codec_dai *dai = machine->dai_link[i].codec_dai;
 		if (dai->dai_ops.digital_mute && dai->playback.active)
 			dai->dai_ops.digital_mute(dai, 0);
 	}
 
-	for(i = 0; i < machine->num_links; i++) {
+	for (i = 0; i < machine->num_links; i++) {
 		struct snd_soc_cpu_dai *cpu_dai = machine->dai_link[i].cpu_dai;
 		if (cpu_dai->resume && cpu_dai->type != SND_SOC_DAI_AC97)
 			cpu_dai->resume(pdev, cpu_dai);
@@ -757,7 +761,7 @@ static int soc_probe(struct platform_device *pdev)
 
 	if (machine->probe) {
 		ret = machine->probe(pdev);
-		if(ret < 0)
+		if (ret < 0)
 			return ret;
 	}
 
@@ -765,20 +769,20 @@ static int soc_probe(struct platform_device *pdev)
 		struct snd_soc_cpu_dai *cpu_dai = machine->dai_link[i].cpu_dai;
 		if (cpu_dai->probe) {
 			ret = cpu_dai->probe(pdev);
-			if(ret < 0)
+			if (ret < 0)
 				goto cpu_dai_err;
 		}
 	}
 
 	if (codec_dev->probe) {
 		ret = codec_dev->probe(pdev);
-		if(ret < 0)
+		if (ret < 0)
 			goto cpu_dai_err;
 	}
 
 	if (platform->probe) {
 		ret = platform->probe(pdev);
-		if(ret < 0)
+		if (ret < 0)
 			goto platform_err;
 	}
 
@@ -865,7 +869,7 @@ static int soc_new_pcm(struct snd_soc_device *socdev,
 	codec_dai->codec = socdev->codec;
 
 	/* check client and interface hw capabilities */
-	sprintf(new_name, "%s %s-%s-%d",dai_link->stream_name, codec_dai->name,
+	sprintf(new_name, "%s %s-%s-%d", dai_link->stream_name, codec_dai->name,
 		get_dai_name(cpu_dai->type), num);
 
 	if (codec_dai->playback.channels_min)
@@ -876,7 +880,8 @@ static int soc_new_pcm(struct snd_soc_device *socdev,
 	ret = snd_pcm_new(codec->card, new_name, codec->pcm_devs++, playback,
 		capture, &pcm);
 	if (ret < 0) {
-		printk(KERN_ERR "asoc: can't create pcm for codec %s\n", codec->name);
+		printk(KERN_ERR "asoc: can't create pcm for codec %s\n",
+			codec->name);
 		kfree(rtd);
 		return ret;
 	}
@@ -925,8 +930,9 @@ static ssize_t codec_reg_show(struct device *dev,
 		step = codec->reg_cache_step;
 
 	count += sprintf(buf, "%s registers\n", codec->name);
-	for(i = 0; i < codec->reg_cache_size; i += step)
-		count += sprintf(buf + count, "%2x: %4x\n", i, codec->read(codec, i));
+	for (i = 0; i < codec->reg_cache_size; i += step)
+		count += sprintf(buf + count, "%2x: %4x\n", i,
+			codec->read(codec, i));
 
 	return count;
 }
@@ -1069,7 +1075,7 @@ int snd_soc_new_pcms(struct snd_soc_device *socdev, int idx, const char *xid)
 	strncpy(codec->card->driver, codec->name, sizeof(codec->card->driver));
 
 	/* create the pcms */
-	for(i = 0; i < machine->num_links; i++) {
+	for (i = 0; i < machine->num_links; i++) {
 		ret = soc_new_pcm(socdev, &machine->dai_link[i], i);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: can't create pcm %s\n",
@@ -1099,7 +1105,7 @@ int snd_soc_register_card(struct snd_soc_device *socdev)
 	struct snd_soc_machine *machine = socdev->machine;
 	int ret = 0, i, ac97 = 0, err = 0;
 
-	for(i = 0; i < machine->num_links; i++) {
+	for (i = 0; i < machine->num_links; i++) {
 		if (socdev->machine->dai_link[i].init) {
 			err = socdev->machine->dai_link[i].init(codec);
 			if (err < 0) {
@@ -1108,7 +1114,7 @@ int snd_soc_register_card(struct snd_soc_device *socdev)
 				continue;
 			}
 		}
-		if (socdev->machine->dai_link[i].codec_dai->type == 
+		if (socdev->machine->dai_link[i].codec_dai->type ==
 			SND_SOC_DAI_AC97_BUS)
 			ac97 = 1;
 	}
@@ -1119,7 +1125,7 @@ int snd_soc_register_card(struct snd_soc_device *socdev)
 
 	ret = snd_card_register(codec->card);
 	if (ret < 0) {
-		printk(KERN_ERR "asoc: failed to register soundcard for codec %s\n",
+		printk(KERN_ERR "asoc: failed to register soundcard for %s\n",
 				codec->name);
 		goto out;
 	}
@@ -1143,7 +1149,7 @@ int snd_soc_register_card(struct snd_soc_device *socdev)
 
 	err = device_create_file(socdev->dev, &dev_attr_codec_reg);
 	if (err < 0)
-		printk(KERN_WARNING "asoc: failed to add codec sysfs entries\n");
+		printk(KERN_WARNING "asoc: failed to add codec sysfs files\n");
 
 	mutex_unlock(&codec->mutex);
 
@@ -1169,7 +1175,7 @@ void snd_soc_free_pcms(struct snd_soc_device *socdev)
 
 	mutex_lock(&codec->mutex);
 #ifdef CONFIG_SND_SOC_AC97_BUS
-	for(i = 0; i < codec->num_dai; i++) {
+	for (i = 0; i < codec->num_dai; i++) {
 		codec_dai = &codec->dai[i];
 		if (codec_dai->type == SND_SOC_DAI_AC97_BUS && codec->ac97) {
 			soc_ac97_dev_unregister(codec);
@@ -1279,7 +1285,8 @@ int snd_soc_get_enum_double(struct snd_kcontrol *kcontrol,
 	for (bitmask = 1; bitmask < e->mask; bitmask <<= 1)
 		;
 	val = snd_soc_read(codec, e->reg);
-	ucontrol->value.enumerated.item[0] = (val >> e->shift_l) & (bitmask - 1);
+	ucontrol->value.enumerated.item[0]
+		= (val >> e->shift_l) & (bitmask - 1);
 	if (e->shift_l != e->shift_r)
 		ucontrol->value.enumerated.item[1] =
 			(val >> e->shift_r) & (bitmask - 1);
@@ -1573,7 +1580,8 @@ int snd_soc_put_volsw_2r(struct snd_kcontrol *kcontrol,
 	val = val << shift;
 	val2 = val2 << shift;
 
-	if ((err = snd_soc_update_bits(codec, reg, val_mask, val)) < 0)
+	err = snd_soc_update_bits(codec, reg, val_mask, val);
+	if (err < 0)
 		return err;
 
 	err = snd_soc_update_bits(codec, reg2, val_mask, val2);
@@ -1589,7 +1597,7 @@ static int __devinit snd_soc_init(void)
 
 static void snd_soc_exit(void)
 {
- 	platform_driver_unregister(&soc_driver);
+	platform_driver_unregister(&soc_driver);
 }
 
 module_init(snd_soc_init);
-- 
1.5.5.1
