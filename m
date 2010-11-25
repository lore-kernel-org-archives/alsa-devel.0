From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [RFC don't apply] ASoC: Add support for optional
	auxiliary dailess codecs
Date: Thu, 25 Nov 2010 17:47:38 +0200
Message-ID: <1290700058-9270-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 00B33103832
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 16:47:31 +0100 (CET)
Received: by ewy19 with SMTP id 19so542428ewy.38
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 07:47:31 -0800 (PST)
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

This makes possible to register auxiliary dailess codecs in a machine
driver. Term dailess is used here for amplifiers and codecs without DAI or
DAI being unused.

Dailess auxiliary codecs are kept in struct snd_soc_aux_dev and those codecs
are probed after initializing the DAI links. There are no major differences
between DAI link codecs and dailess codecs in ASoC core point of view. DAPM
handles them equally and sysfs and debugfs directories for dailess codecs
are similar except the pmdown_time node is not created.

Only suspend and resume functions are modified to traverse all probed codecs
instead of DAI link codecs.

Example below shows a dailess codec registration.

struct snd_soc_aux_dev foo_aux_dev[] = {
	{
		.name = "Amp",
		.codec_name = "codec.2",
		.init = foo_init2,
	},
};

static struct snd_soc_card card = {
	...
	.aux_dev = foo_aux_dev,
	.num_aux_devs = ARRAY_SIZE(foo_aux_dev),
};

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
Idea sharing version, not to be applied. Needs at least cross-device DAPM
to be usuful and e.g. soc_probe_dai_link and soc_probe_aux_dev share a lot
of same code.

I'm not entirely sure of reusing struct snd_soc_pcm_runtime but having some
common struct on top of it for registering the sysfs nodes and passing to
snd_soc_dapm_sys_add didn't sound clear either.
Anyway suspend/resume is working with this version and doesn't need any other
modifications to soc_suspend/soc_resume than traversing through the registered
codecs instead of doing bunch of rtd->dailess etc hacks there.
---
 include/sound/soc.h  |   17 ++++++
 sound/soc/soc-core.c |  155 ++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 166 insertions(+), 6 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 346c59e..c62225e 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -583,6 +583,14 @@ struct snd_soc_prefix_map {
 	const char *name_prefix;
 };
 
+struct snd_soc_aux_dev {
+	const char *name;		/* Codec name */
+	const char *codec_name;		/* for multi-codec */
+
+	/* codec/machine specific init - e.g. add machine controls */
+	int (*init)(struct snd_soc_dapm_context *dapm);
+};
+
 /* SoC card */
 struct snd_soc_card {
 	const char *name;
@@ -624,6 +632,15 @@ struct snd_soc_card {
 	struct snd_soc_prefix_map *prefix_map;
 	int num_prefixes;
 
+	/*
+	 * optional auxiliary devices such as amplifiers or codecs with DAI
+	 * link unused
+	 */
+	struct snd_soc_aux_dev *aux_dev;
+	int num_aux_devs;
+	struct snd_soc_pcm_runtime *rtd_aux;
+	int num_aux_rtd;
+
 	struct work_struct deferred_resume_work;
 
 	/* lists of probed devices belonging to this card */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b0e1aea..d7fc3a6 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -986,6 +986,7 @@ static int soc_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec;
 	int i;
 
 	/* If the initialization of this soc device failed, there is no codec
@@ -1064,8 +1065,7 @@ static int soc_suspend(struct device *dev)
 	}
 
 	/* suspend all CODECs */
-	for (i = 0; i < card->num_rtd; i++) {
-		struct snd_soc_codec *codec = card->rtd[i].codec;
+	list_for_each_entry(codec, &card->codec_dev_list, card_list) {
 		/* If there are paths active then the CODEC will be held with
 		 * bias _ON and should not be suspended. */
 		if (!codec->suspended && codec->driver->suspend) {
@@ -1106,6 +1106,7 @@ static void soc_resume_deferred(struct work_struct *work)
 	struct snd_soc_card *card =
 			container_of(work, struct snd_soc_card, deferred_resume_work);
 	struct platform_device *pdev = to_platform_device(card->dev);
+	struct snd_soc_codec *codec;
 	int i;
 
 	/* our power state is still SNDRV_CTL_POWER_D3hot from suspend time,
@@ -1131,8 +1132,7 @@ static void soc_resume_deferred(struct work_struct *work)
 			cpu_dai->driver->resume(cpu_dai);
 	}
 
-	for (i = 0; i < card->num_rtd; i++) {
-		struct snd_soc_codec *codec = card->rtd[i].codec;
+	list_for_each_entry(codec, &card->codec_dev_list, card_list) {
 		/* If the CODEC was idle over suspend then it will have been
 		 * left with bias OFF or STANDBY and suspended so we must now
 		 * resume.  Otherwise the suspend was suppressed.
@@ -1604,6 +1604,130 @@ static void soc_unregister_ac97_dai_link(struct snd_soc_codec *codec)
 }
 #endif
 
+static int soc_probe_aux_dev(struct snd_soc_card *card, int num)
+{
+	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
+	struct snd_soc_pcm_runtime *rtd = &card->rtd_aux[num];
+	struct snd_soc_codec *codec;
+	const char *temp;
+	int ret = 0;
+
+	/* find CODEC from registered CODECs*/
+	list_for_each_entry(codec, &codec_list, list) {
+		if (!strcmp(codec->name, aux_dev->codec_name)) {
+			if (codec->probed) {
+				dev_err(codec->dev,
+					"asoc: codec already probed");
+				ret = -EBUSY;
+				goto out;
+			}
+			break;
+		}
+	}
+
+	if (!try_module_get(codec->dev->driver->owner))
+		return -ENODEV;
+
+	codec->card = card;
+	codec->dapm.card = card;
+
+	soc_set_name_prefix(card, codec);
+	if (codec->driver->probe) {
+		ret = codec->driver->probe(codec);
+		if (ret < 0) {
+			dev_err(codec->dev, "asoc: failed to probe CODEC");
+			return ret;
+		}
+	}
+
+	soc_init_codec_debugfs(codec);
+
+	/* mark codec as probed and add to card codec list */
+	codec->probed = 1;
+	list_add(&codec->card_list, &card->codec_dev_list);
+	list_add(&codec->dapm.list, &card->dapm_list);
+
+	/* now that all clients have probed, initialise the DAI link */
+	if (aux_dev->init) {
+		/* machine controls, routes and widgets are not prefixed */
+		temp = codec->name_prefix;
+		codec->name_prefix = NULL;
+		ret = aux_dev->init(&codec->dapm);
+		if (ret < 0) {
+			dev_err(codec->dev,
+				"asoc: failed to init %s\n", aux_dev->name);
+			return ret;
+		}
+		codec->name_prefix = temp;
+	}
+
+	/* Make sure all DAPM widgets are instantiated */
+	snd_soc_dapm_new_widgets(&codec->dapm);
+	snd_soc_dapm_sync(&codec->dapm);
+
+	/* register the rtd device */
+	rtd->codec = codec;
+	rtd->card = card;
+	rtd->dev.parent = card->dev;
+	rtd->dev.release = rtd_release;
+	rtd->dev.init_name = aux_dev->name;
+	ret = device_register(&rtd->dev);
+	if (ret < 0) {
+		dev_err(codec->dev,
+			"asoc: failed to register aux runtime device %d\n",
+			ret);
+		return ret;
+	}
+	rtd->dev_registered = 1;
+
+	/* add DAPM sysfs entries for this codec */
+	ret = snd_soc_dapm_sys_add(&rtd->dev);
+	if (ret < 0)
+		dev_err(codec->dev,
+			"asoc: failed to add codec dapm sysfs entries\n");
+
+	/* add codec sysfs entries */
+	ret = device_create_file(&rtd->dev, &dev_attr_codec_reg);
+	if (ret < 0)
+		dev_err(codec->dev, "asoc: failed to add codec sysfs files\n");
+
+out:
+	return ret;
+}
+
+static void soc_remove_aux_dev(struct snd_soc_card *card, int num)
+{
+	struct snd_soc_pcm_runtime *rtd = &card->rtd_aux[num];
+	struct snd_soc_codec *codec = rtd->codec;
+	int err;
+
+	/* unregister the rtd device */
+	if (rtd->dev_registered) {
+		device_unregister(&rtd->dev);
+		rtd->dev_registered = 0;
+	}
+
+	/* remove the CODEC */
+	if (codec && codec->probed) {
+		if (codec->driver->remove) {
+			err = codec->driver->remove(codec);
+			if (err < 0)
+				dev_err(codec->dev,
+					"asoc: failed to remove %s\n",
+					codec->name);
+		}
+
+		/* Make sure all DAPM widgets are freed */
+		snd_soc_dapm_free(&codec->dapm);
+
+		soc_cleanup_codec_debugfs(codec);
+		device_remove_file(&rtd->dev, &dev_attr_codec_reg);
+		codec->probed = 0;
+		list_del(&codec->card_list);
+		module_put(codec->dev->driver->owner);
+	}
+}
+
 static void snd_soc_instantiate_card(struct snd_soc_card *card)
 {
 	struct platform_device *pdev = to_platform_device(card->dev);
@@ -1658,6 +1782,15 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 		}
 	}
 
+	for (i = 0; i < card->num_aux_devs; i++) {
+		ret = soc_probe_aux_dev(card, i);
+		if (ret < 0) {
+			pr_err("asoc: failed to add auxiliary devices %s: %d\n",
+			       card->name, ret);
+			goto probe_aux_dev_err;
+		}
+	}
+
 	snprintf(card->snd_card->shortname, sizeof(card->snd_card->shortname),
 		 "%s",  card->name);
 	snprintf(card->snd_card->longname, sizeof(card->snd_card->longname),
@@ -1684,6 +1817,10 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 	mutex_unlock(&card->mutex);
 	return;
 
+probe_aux_dev_err:
+	for (i = 0; i < card->num_aux_devs; i++)
+		soc_remove_aux_dev(card, i);
+
 probe_dai_err:
 	for (i = 0; i < card->num_links; i++)
 		soc_remove_dai_link(card, i);
@@ -1748,6 +1885,10 @@ static int soc_remove(struct platform_device *pdev)
 			run_delayed_work(&rtd->delayed_work);
 		}
 
+		/* remove auxiliary devices */
+		for (i = 0; i < card->num_aux_devs; i++)
+			soc_remove_aux_dev(card, i);
+
 		/* remove and free each DAI */
 		for (i = 0; i < card->num_rtd; i++)
 			soc_remove_dai_link(card, i);
@@ -2950,10 +3091,12 @@ static int snd_soc_register_card(struct snd_soc_card *card)
 	if (!card->name || !card->dev)
 		return -EINVAL;
 
-	card->rtd = kzalloc(sizeof(struct snd_soc_pcm_runtime) * card->num_links,
-			GFP_KERNEL);
+	card->rtd = kzalloc(sizeof(struct snd_soc_pcm_runtime) *
+			    (card->num_links + card->num_aux_devs),
+			    GFP_KERNEL);
 	if (card->rtd == NULL)
 		return -ENOMEM;
+	card->rtd_aux = &card->rtd[card->num_links];
 
 	for (i = 0; i < card->num_links; i++)
 		card->rtd[i].dai_link = &card->dai_link[i];
-- 
1.7.2.3
