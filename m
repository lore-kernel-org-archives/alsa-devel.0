From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 1/2] asoc/multi-component: remove superfluous
	snd_card member from snd_soc_codec
Date: Wed, 11 Aug 2010 14:29:45 +0200
Message-ID: <1281529786-5267-2-git-send-email-s.hauer@pengutronix.de>
References: <1281529786-5267-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 0672810386E
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 14:29:48 +0200 (CEST)
In-Reply-To: <1281529786-5267-1-git-send-email-s.hauer@pengutronix.de>
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 include/sound/soc.h  |    1 -
 sound/soc/soc-core.c |    6 +++---
 sound/soc/soc-dapm.c |    6 +++---
 sound/soc/soc-jack.c |    2 +-
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 6982b15..4b0f4cd 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -428,7 +428,6 @@ struct snd_soc_codec {
 	struct snd_soc_codec_driver *driver;
 
 	struct mutex mutex;
-	struct snd_card *snd_card;
 	struct snd_soc_card *card;
 	struct list_head list;
 	struct list_head card_list;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e2cc8fa..4300d6f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1287,7 +1287,7 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 	dev_dbg(card->dev, "probe %s dai link %d\n", card->name, num);
 
 	/* config components */
-	platform->snd_card = codec->snd_card = card->snd_card;
+	platform->snd_card = card->snd_card;
 	codec_dai->codec = codec;
 	codec->card = card;
 	cpu_dai->platform = platform;
@@ -1902,7 +1902,7 @@ EXPORT_SYMBOL_GPL(snd_soc_cnew);
 int snd_soc_add_controls(struct snd_soc_codec *codec,
 	const struct snd_kcontrol_new *controls, int num_controls)
 {
-	struct snd_card *card = codec->snd_card;
+	struct snd_card *card = codec->card->snd_card;
 	int err, i;
 
 	for (i = 0; i < num_controls; i++) {
@@ -2457,7 +2457,7 @@ EXPORT_SYMBOL_GPL(snd_soc_put_volsw_s8);
 int snd_soc_limit_volume(struct snd_soc_codec *codec,
 	const char *name, int max)
 {
-	struct snd_card *card = codec->snd_card;
+	struct snd_card *card = codec->card->snd_card;
 	struct snd_kcontrol *kctl;
 	struct soc_mixer_control *mc;
 	int found = 0;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index fb68c7d..035cab8 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -368,7 +368,7 @@ static int dapm_new_mixer(struct snd_soc_codec *codec,
 
 			path->kcontrol = snd_soc_cnew(&w->kcontrols[i], w,
 				path->long_name);
-			ret = snd_ctl_add(codec->snd_card, path->kcontrol);
+			ret = snd_ctl_add(codec->card->snd_card, path->kcontrol);
 			if (ret < 0) {
 				printk(KERN_ERR "asoc: failed to add dapm kcontrol %s: %d\n",
 				       path->long_name,
@@ -396,7 +396,7 @@ static int dapm_new_mux(struct snd_soc_codec *codec,
 	}
 
 	kcontrol = snd_soc_cnew(&w->kcontrols[0], w, w->name);
-	ret = snd_ctl_add(codec->snd_card, kcontrol);
+	ret = snd_ctl_add(codec->card->snd_card, kcontrol);
 	if (ret < 0)
 		goto err;
 
@@ -435,7 +435,7 @@ static inline void dapm_clear_walk(struct snd_soc_codec *codec)
  */
 static int snd_soc_dapm_suspend_check(struct snd_soc_dapm_widget *widget)
 {
-	int level = snd_power_get_state(widget->codec->snd_card);
+	int level = snd_power_get_state(widget->codec->card->snd_card);
 
 	switch (level) {
 	case SNDRV_CTL_POWER_D3hot:
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 1dfc4fd..8862770 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -39,7 +39,7 @@ int snd_soc_jack_new(struct snd_soc_codec *codec, const char *id, int type,
 	INIT_LIST_HEAD(&jack->pins);
 	BLOCKING_INIT_NOTIFIER_HEAD(&jack->notifier);
 
-	return snd_jack_new(codec->snd_card, id, type, &jack->jack);
+	return snd_jack_new(codec->card->snd_card, id, type, &jack->jack);
 }
 EXPORT_SYMBOL_GPL(snd_soc_jack_new);
 
-- 
1.7.1
