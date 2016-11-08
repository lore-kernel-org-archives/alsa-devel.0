From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [RFC 1/4] ASoC: core: allow PCM control binding to PCM
	device
Date: Tue, 8 Nov 2016 09:11:12 +0100
Message-ID: <1478592675-23092-2-git-send-email-arnaud.pouliquen@st.com>
References: <1478592675-23092-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id DAACA266EF1
 for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2016 09:13:11 +0100 (CET)
In-Reply-To: <1478592675-23092-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Add relationchip between DAI PCM controls and PCM device. 
For some generic controls (for instance iec controls), it is useful 
to link control to the PCM device. Especially for application that uses a
instance of the control based on the PCM device number.

Implementation is based on bind_pcm_ctl field in dai_driver struct
to enable the link. When set to true DAI PCM controls device field 
is forced to the PCM device number.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 include/sound/soc-dai.h |   3 ++
 sound/soc/soc-core.c    | 118 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 117 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 964b7de..52e89ee 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -233,6 +233,8 @@ struct snd_soc_dai_driver {
 	int (*compress_new)(struct snd_soc_pcm_runtime *rtd, int num);
 	/* DAI is also used for the control bus */
 	bool bus_control;
+	/* Bind IFACE_PCM controls to the PCM device */
+	bool bind_pcm_ctl;
 
 	/* ops */
 	const struct snd_soc_dai_ops *ops;
@@ -292,6 +294,7 @@ struct snd_soc_dai {
 	unsigned int rx_mask;
 
 	struct list_head list;
+	struct list_head list_pcm_ctl;
 };
 
 static inline void *snd_soc_dai_get_dma_data(const struct snd_soc_dai *dai,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4afa8db..148b90f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -58,6 +58,11 @@ static LIST_HEAD(platform_list);
 static LIST_HEAD(codec_list);
 static LIST_HEAD(component_list);
 
+struct snd_soc_dai_pcm_ctls {
+	struct snd_kcontrol *controls;
+	struct list_head list;
+};
+
 /*
  * This is a timeout to do a DAPM powerdown after a stream is closed().
  * It can be used to eliminate pops between different playback streams, e.g.
@@ -1362,6 +1367,32 @@ static void soc_set_name_prefix(struct snd_soc_card *card,
 	}
 }
 
+static int soc_link_dai_pcm_controls(struct snd_soc_card *card,
+	struct snd_soc_dai *dai, struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_dai_pcm_ctls *ctls, *_ctls;
+	struct snd_kcontrol *kctl;
+	int i, err;
+
+	list_for_each_entry_safe(ctls, _ctls,  &dai->list_pcm_ctl, list) {
+		kctl = ctls->controls;
+		kctl->id.device = rtd->pcm->device;
+
+		err = snd_ctl_add(card->snd_card, kctl);
+		if (err < 0) {
+			dev_err(card->dev,
+				"ASoC: Can't link %s: %s control(s) to %s :%d\n",
+				dai->name, kctl->id.name,
+				rtd->dai_link->stream_name, err);
+			return err;
+		}
+		list_del(&ctls->list);
+		kfree(ctls);
+	}
+
+	return 0;
+}
+
 static int soc_probe_component(struct snd_soc_card *card,
 	struct snd_soc_component *component)
 {
@@ -1598,7 +1629,7 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 		struct snd_soc_pcm_runtime *rtd, int order)
 {
 	struct snd_soc_dai_link *dai_link = rtd->dai_link;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *dai, *cpu_dai = rtd->cpu_dai;
 	int i, ret;
 
 	dev_dbg(card->dev, "ASoC: probe %s dai link %d late %d\n",
@@ -1663,6 +1694,24 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 				       dai_link->stream_name, ret);
 				return ret;
 			}
+
+			/* link  CPU DAI pcm controls to pcm device */
+			if (!list_empty(&cpu_dai->list_pcm_ctl)) {
+				ret = soc_link_dai_pcm_controls(card, cpu_dai,
+								rtd);
+				if (ret < 0)
+					return ret;
+			}
+
+			/* link CODEC DAI pcm control to pcm device */
+			for (i = 0; i < rtd->num_codecs; i++) {
+				dai = rtd->codec_dais[i];
+				if (!list_empty(&dai->list_pcm_ctl))
+					ret = soc_link_dai_pcm_controls(card,
+								      dai, rtd);
+				if (ret < 0)
+					return ret;
+			}
 		} else {
 			INIT_DELAYED_WORK(&rtd->delayed_work,
 						codec2codec_close_delayed_work);
@@ -2218,6 +2267,49 @@ static int snd_soc_add_controls(struct snd_card *card, struct device *dev,
 	return 0;
 }
 
+static int snd_soc_add_dai_pcm_controls(struct snd_soc_card *soc_card,
+	struct snd_soc_dai *dai, const struct snd_kcontrol_new *controls,
+	int num_controls, const char *prefix, void *data)
+{
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai_pcm_ctls *ctls_list;
+	struct snd_kcontrol *kctl;
+	int i, dai_found = 0;
+
+	for (i = 0; i < num_controls; i++) {
+		const struct snd_kcontrol_new *control = &controls[i];
+
+		if (control->iface != SNDRV_CTL_ELEM_IFACE_PCM) {
+			dev_err(dai->dev, "%s: not a pcm device control !!!\n",
+				control->name);
+			return -EINVAL;
+		}
+		kctl = snd_soc_cnew(control, data, control->name, prefix);
+		if (IS_ERR(kctl))
+			return PTR_ERR(kctl);
+
+		ctls_list = kzalloc(sizeof(*ctls_list), GFP_KERNEL);
+		ctls_list->controls = kctl;
+		list_add(&ctls_list->list, &dai->list_pcm_ctl);
+	}
+
+	if (dai->probed) {
+		/* pcm device exists. Control can be linked to it */
+		list_for_each_entry(rtd, &soc_card->rtd_list, list) {
+			if (dai == rtd->cpu_dai) {
+				dai_found = 1;
+				break;
+			}
+		}
+		if (!dai_found)
+			return -EINVAL;
+
+		soc_link_dai_pcm_controls(soc_card, dai, rtd);
+	}
+
+	return 0;
+}
+
 struct snd_kcontrol *snd_soc_card_get_kcontrol(struct snd_soc_card *soc_card,
 					       const char *name)
 {
@@ -2323,10 +2415,26 @@ EXPORT_SYMBOL_GPL(snd_soc_add_card_controls);
 int snd_soc_add_dai_controls(struct snd_soc_dai *dai,
 	const struct snd_kcontrol_new *controls, int num_controls)
 {
-	struct snd_card *card = dai->component->card->snd_card;
+	struct snd_soc_card *soc_card = dai->component->card;
+	struct snd_card *card = soc_card->snd_card;
+	int ret, i;
 
-	return snd_soc_add_controls(card, dai->dev, controls, num_controls,
-			NULL, dai);
+	if (!dai->driver || !dai->driver->bind_pcm_ctl)
+		return snd_soc_add_controls(card, dai->dev, controls,
+			num_controls, NULL, dai);
+
+	for (i = 0; i < num_controls; i++) {
+		if (controls[i].iface == SNDRV_CTL_ELEM_IFACE_PCM)
+			ret = snd_soc_add_dai_pcm_controls(soc_card, dai,
+				&controls[i], 1, NULL, dai);
+		else
+			ret = snd_soc_add_controls(card, dai->dev, &controls[i],
+				 1, NULL, dai);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_add_dai_controls);
 
@@ -2806,6 +2914,8 @@ static struct snd_soc_dai *soc_add_dai(struct snd_soc_component *component,
 	if (!dai->driver->ops)
 		dai->driver->ops = &null_dai_ops;
 
+	INIT_LIST_HEAD(&dai->list_pcm_ctl);
+
 	list_add(&dai->list, &component->dai_list);
 	component->num_dai++;
 
-- 
1.9.1
