From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC] ASoC: multi-component: Add optional kcontrol
 prefix name for a DAI link
Date: Wed, 25 Aug 2010 13:59:22 +0300
Message-ID: <20100825135922.5589ba30.jhnikula@gmail.com>
References: <1281943770-2990-1-git-send-email-jhnikula@gmail.com>
	<20100816100705.GA3276@rakim.wolfsonmicro.main>
	<20100816135328.077b5ea3.jhnikula@gmail.com>
	<20100816110902.GA10354@sirena.org.uk>
	<20100819144451.1d827367.jhnikula@gmail.com>
	<20100819135413.GA19582@opensource.wolfsonmicro.com>
	<20100819182049.3ecdd0bc.jhnikula@gmail.com>
	<20100820115144.451b474f.jhnikula@gmail.com>
	<20100823152145.GD14504@rakim.wolfsonmicro.main>
	<20100824102343.4dfaafe1.jhnikula@gmail.com>
	<20100824101032.GA15278@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BDC8E2464D
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Aug 2010 12:58:39 +0200 (CEST)
Received: by eyd9 with SMTP id 9so136111eyd.38
	for <alsa-devel@alsa-project.org>; Wed, 25 Aug 2010 03:58:39 -0700 (PDT)
In-Reply-To: <20100824101032.GA15278@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, 24 Aug 2010 11:10:32 +0100
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> DAIless devices should work already.
...
> We'll be fine just using the prefixed name in the machine drivers I
> think and not advertising the prefix-adding route add function.
>
I went back to original idea that prefixes only kcontrols of codec and
doesn't add any new API. So if we can have DAIless codec drivers (i.e.
amplifiers) then there is no immediate need for prefixing widgets and
routes.

Cross-device links and DAPM between them remains unsolved as this tries
to solve only kcontrol name issue with multiple codecs only.

-- 
Jarkko
=============== CUT HERE ================
>From 5b4db56e01fc7c19011dfa83d11b1e6d55681dd5 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jhnikula@gmail.com>
Date: Wed, 25 Aug 2010 12:59:01 +0300
Subject: [PATCH] ASoC: Add optional prefix_map to snd_soc_card for prefixing codec kcontrols

This optional prefix_map allows to specify unique ALSA control name prefixes
for maching codec names. This makes possible to have a sound card
configuration using multiple codecs without a name collision that would
occur if a codec driver tries to register a kcontrol with an existing name.

Now it is possible to specify for instance "Front" and "Rear" prefixes and
a sound card can have two separate controls like "Front PCM Playback Volume"
and "Rear PCM Playback Volume". Those controls will then show as
"Front PCM" and "Rear PCM" in ALSA mixer application.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 include/sound/soc.h  |   10 ++++++++++
 sound/soc/soc-core.c |   35 +++++++++++++++++++++++++++++++++--
 sound/soc/soc-dapm.c |   28 ++++++++++++++++++++++------
 3 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index d31e8b7..cc309af 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -423,6 +423,7 @@ struct snd_soc_ops {
 /* SoC Audio Codec device */
 struct snd_soc_codec {
 	const char *name;
+	const char *kcontrol_prefix;
 	int id;
 	struct device *dev;
 	struct snd_soc_codec_driver *driver;
@@ -553,6 +554,11 @@ struct snd_soc_dai_link {
 	struct snd_soc_ops *ops;
 };
 
+struct snd_soc_prefix_map {
+	const char *codec_name;
+	const char *kcontrol_prefix;
+};
+
 /* SoC card */
 struct snd_soc_card {
 	const char *name;
@@ -587,6 +593,10 @@ struct snd_soc_card {
 	struct snd_soc_pcm_runtime *rtd;
 	int num_rtd;
 
+	/* optional map of name prefixes that are associated per codec */
+	struct snd_soc_prefix_map *prefix_map;
+	int num_prefixes;
+
 	struct work_struct deferred_resume_work;
 
 	/* lists of probed devices belonging to this card */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 65352c7..b17596f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1266,6 +1266,23 @@ static void soc_remove_dai_link(struct snd_soc_card *card, int num)
 
 static void rtd_release(struct device *dev) {}
 
+static void soc_set_name_prefix(struct snd_soc_card *card,
+				struct snd_soc_codec *codec)
+{
+	int i;
+
+	if (card->prefix_map == NULL)
+		return;
+
+	for (i = 0; i < card->num_prefixes; i++) {
+		struct snd_soc_prefix_map *map = &card->prefix_map[i];
+		if (map->codec_name && !strcmp(codec->name, map->codec_name)) {
+			codec->kcontrol_prefix = map->kcontrol_prefix;
+			break;
+		}
+	}
+}
+
 static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 {
 	struct snd_soc_dai_link *dai_link = &card->dai_link[num];
@@ -1306,6 +1323,7 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 
 	/* probe the CODEC */
 	if (!codec->probed) {
+		soc_set_name_prefix(card, codec);
 		if (codec->driver->probe) {
 			ret = codec->driver->probe(codec);
 			if (ret < 0) {
@@ -1895,14 +1913,27 @@ int snd_soc_add_controls(struct snd_soc_codec *codec,
 	const struct snd_kcontrol_new *controls, int num_controls)
 {
 	struct snd_card *card = codec->card->snd_card;
+	char prefixed_name[44], *name;
+	const char *prefix = NULL;
 	int err, i;
 
+	/* Only codec controls are prefixed */
+	if (!codec->probed)
+		prefix = codec->kcontrol_prefix;
+
 	for (i = 0; i < num_controls; i++) {
 		const struct snd_kcontrol_new *control = &controls[i];
-		err = snd_ctl_add(card, snd_soc_cnew(control, codec, NULL));
+		if (prefix) {
+			snprintf(prefixed_name, sizeof(prefixed_name), "%s %s",
+				 prefix, control->name);
+			name = prefixed_name;
+		} else {
+			name = control->name;
+		}
+		err = snd_ctl_add(card, snd_soc_cnew(control, codec, name));
 		if (err < 0) {
 			dev_err(codec->dev, "%s: Failed to add %s\n",
-				codec->name, control->name);
+				codec->name, name);
 			return err;
 		}
 	}
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 035cab8..412f0bf 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -327,6 +327,7 @@ static int dapm_new_mixer(struct snd_soc_codec *codec,
 	int i, ret = 0;
 	size_t name_len;
 	struct snd_soc_dapm_path *path;
+	char prefix[10];
 
 	/* add kcontrol */
 	for (i = 0; i < w->num_kcontrols; i++) {
@@ -347,6 +348,13 @@ static int dapm_new_mixer(struct snd_soc_codec *codec,
 			name_len = strlen(w->kcontrols[i].name) + 1;
 			if (w->id != snd_soc_dapm_mixer_named_ctl)
 				name_len += 1 + strlen(w->name);
+			if (codec->kcontrol_prefix) {
+				name_len += 1 + strlen(codec->kcontrol_prefix);
+				snprintf(prefix, sizeof(prefix), "%s ",
+					 codec->kcontrol_prefix);
+			} else {
+				prefix[0] = '\0';
+			}
 
 			path->long_name = kmalloc(name_len, GFP_KERNEL);
 
@@ -355,12 +363,12 @@ static int dapm_new_mixer(struct snd_soc_codec *codec,
 
 			switch (w->id) {
 			default:
-				snprintf(path->long_name, name_len, "%s %s",
-					 w->name, w->kcontrols[i].name);
+				snprintf(path->long_name, name_len, "%s%s %s",
+					 prefix, w->name, w->kcontrols[i].name);
 				break;
 			case snd_soc_dapm_mixer_named_ctl:
-				snprintf(path->long_name, name_len, "%s",
-					 w->kcontrols[i].name);
+				snprintf(path->long_name, name_len, "%s%s",
+					 prefix, w->kcontrols[i].name);
 				break;
 			}
 
@@ -388,6 +396,7 @@ static int dapm_new_mux(struct snd_soc_codec *codec,
 {
 	struct snd_soc_dapm_path *path = NULL;
 	struct snd_kcontrol *kcontrol;
+	char prefixed_name[44], *name;
 	int ret = 0;
 
 	if (!w->num_kcontrols) {
@@ -395,7 +404,14 @@ static int dapm_new_mux(struct snd_soc_codec *codec,
 		return -EINVAL;
 	}
 
-	kcontrol = snd_soc_cnew(&w->kcontrols[0], w, w->name);
+	if (codec->kcontrol_prefix) {
+		snprintf(prefixed_name, sizeof(prefixed_name), "%s %s",
+			 codec->kcontrol_prefix, w->name);
+		name = prefixed_name;
+	} else {
+		name = w->name;
+	}
+	kcontrol = snd_soc_cnew(&w->kcontrols[0], w, name);
 	ret = snd_ctl_add(codec->card->snd_card, kcontrol);
 	if (ret < 0)
 		goto err;
@@ -406,7 +422,7 @@ static int dapm_new_mux(struct snd_soc_codec *codec,
 	return ret;
 
 err:
-	printk(KERN_ERR "asoc: failed to add kcontrol %s\n", w->name);
+	printk(KERN_ERR "asoc: failed to add kcontrol %s\n", name);
 	return ret;
 }
 
-- 
1.7.1
