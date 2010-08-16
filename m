From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [RFC] ASoC: multi-component: Add optional kcontrol
	prefix name for a DAI link
Date: Mon, 16 Aug 2010 10:29:30 +0300
Message-ID: <1281943770-2990-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 262EB1037F7
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Aug 2010 09:29:37 +0200 (CEST)
Received: by eyd9 with SMTP id 9so1112341eyd.38
	for <alsa-devel@alsa-project.org>; Mon, 16 Aug 2010 00:29:33 -0700 (PDT)
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

This optional kcontrol_prefix allows to specify unique prefix for ALSA
control names for each DAI link. This makes possible to have a sound card
configuration with multiple DAIs and each of them using the same codec
driver without name collision.

Currently name collision would occur if a codec driver tries to register a
kcontrol with a same name for another DAI link.

Now it is possible to specify for instance "Front" and "Rear" prefixes and
a sound card can have two separate controls like "Front.PCM Playback Volume"
and "Rear.PCM Playback Volume". Those controls will then show as
"Front.PCM" and "Rear.PCM" in ALSA mixer application.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 include/sound/soc.h  |    2 ++
 sound/soc/soc-core.c |   13 +++++++++++--
 sound/soc/soc-dapm.c |   28 ++++++++++++++++++++++------
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index d31e8b7..9b83f7e 100644
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
@@ -539,6 +540,7 @@ struct snd_soc_dai_link {
 	const char *platform_name;	/* for multi-platform */
 	const char *cpu_dai_name;
 	const char *codec_dai_name;
+	const char *kcontrol_prefix;	/* kcontrol prefix for multi-codec */
 
 	/* Keep DAI active over suspend */
 	unsigned int ignore_suspend:1;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a004876..f52eb2a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1289,6 +1289,7 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 	/* config components */
 	codec_dai->codec = codec;
 	codec->card = card;
+	codec->kcontrol_prefix = dai_link->kcontrol_prefix;
 	cpu_dai->platform = platform;
 	rtd->card = card;
 	rtd->dev.parent = card->dev;
@@ -1903,14 +1904,22 @@ int snd_soc_add_controls(struct snd_soc_codec *codec,
 	const struct snd_kcontrol_new *controls, int num_controls)
 {
 	struct snd_card *card = codec->card->snd_card;
+	char prefixed_name[44], *name;
 	int err, i;
 
 	for (i = 0; i < num_controls; i++) {
 		const struct snd_kcontrol_new *control = &controls[i];
-		err = snd_ctl_add(card, snd_soc_cnew(control, codec, NULL));
+		if (codec->kcontrol_prefix) {
+			snprintf(prefixed_name, sizeof(prefixed_name), "%s.%s",
+				 codec->kcontrol_prefix, control->name);
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
index 035cab8..5751f4f 100644
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
+				snprintf(prefix, sizeof(prefix), "%s.",
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
+		snprintf(prefixed_name, sizeof(prefixed_name), "%s.%s",
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
