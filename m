From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix prefixing of DAPM controls by
	factoring prefix into snd_soc_cnew()
Date: Tue,  8 Mar 2011 17:25:03 +0000
Message-ID: <1299605103-13079-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2DC92103820
	for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2011 18:24:52 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Currently will ignore prefixes when creating DAPM controls. Since currently
all control creation goes through snd_soc_cnew() we can fix this by factoring
the prefixing into that function.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    3 ++-
 sound/soc/soc-core.c |   45 +++++++++++++++++++++++++++++++--------------
 sound/soc/soc-dapm.c |   16 ++++++++++++++--
 3 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 8b097f7..876dd5a 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -341,7 +341,8 @@ void snd_soc_free_ac97_codec(struct snd_soc_codec *codec);
  *Controls
  */
 struct snd_kcontrol *snd_soc_cnew(const struct snd_kcontrol_new *_template,
-	void *data, char *long_name);
+				  void *data, char *long_name,
+				  const char *prefix);
 int snd_soc_add_controls(struct snd_soc_codec *codec,
 	const struct snd_kcontrol_new *controls, int num_controls);
 int snd_soc_info_enum_double(struct snd_kcontrol *kcontrol,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index db3075d..17efacd 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2344,22 +2344,45 @@ EXPORT_SYMBOL_GPL(snd_soc_set_runtime_hwparams);
  * @_template: control template
  * @data: control private data
  * @long_name: control long name
+ * @prefix: control name prefix
  *
  * Create a new mixer control from a template control.
  *
  * Returns 0 for success, else error.
  */
 struct snd_kcontrol *snd_soc_cnew(const struct snd_kcontrol_new *_template,
-	void *data, char *long_name)
+				  void *data, char *long_name,
+				  const char *prefix)
 {
 	struct snd_kcontrol_new template;
+	struct snd_kcontrol *kcontrol;
+	char *name = NULL;
+	int name_len;
 
 	memcpy(&template, _template, sizeof(template));
-	if (long_name)
-		template.name = long_name;
 	template.index = 0;
 
-	return snd_ctl_new1(&template, data);
+	if (!long_name)
+		long_name = template.name;
+
+	if (prefix) {
+		name_len = strlen(long_name) + strlen(prefix) + 2;
+		name = kmalloc(name_len, GFP_ATOMIC);
+		if (!name)
+			return NULL;
+
+		snprintf(name, name_len, "%s %s", prefix, long_name);
+
+		template.name = name;
+	} else {
+		template.name = long_name;
+	}
+
+	kcontrol = snd_ctl_new1(&template, data);
+
+	kfree(name);
+
+	return kcontrol;
 }
 EXPORT_SYMBOL_GPL(snd_soc_cnew);
 
@@ -2378,22 +2401,16 @@ int snd_soc_add_controls(struct snd_soc_codec *codec,
 	const struct snd_kcontrol_new *controls, int num_controls)
 {
 	struct snd_card *card = codec->card->snd_card;
-	char prefixed_name[44], *name;
 	int err, i;
 
 	for (i = 0; i < num_controls; i++) {
 		const struct snd_kcontrol_new *control = &controls[i];
-		if (codec->name_prefix) {
-			snprintf(prefixed_name, sizeof(prefixed_name), "%s %s",
-				 codec->name_prefix, control->name);
-			name = prefixed_name;
-		} else {
-			name = control->name;
-		}
-		err = snd_ctl_add(card, snd_soc_cnew(control, codec, name));
+		err = snd_ctl_add(card, snd_soc_cnew(control, codec,
+						     control->name,
+						     codec->name_prefix));
 		if (err < 0) {
 			dev_err(codec->dev, "%s: Failed to add %s: %d\n",
-				codec->name, name, err);
+				codec->name, control->name, err);
 			return err;
 		}
 	}
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 570db88..a6fb85d 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -369,6 +369,12 @@ static int dapm_new_mixer(struct snd_soc_dapm_context *dapm,
 	size_t name_len;
 	struct snd_soc_dapm_path *path;
 	struct snd_card *card = dapm->card->snd_card;
+	const char *prefix;
+
+	if (dapm->codec)
+		prefix = dapm->codec->name_prefix;
+	else
+		prefix = NULL;
 
 	/* add kcontrol */
 	for (i = 0; i < w->num_kcontrols; i++) {
@@ -409,7 +415,7 @@ static int dapm_new_mixer(struct snd_soc_dapm_context *dapm,
 			path->long_name[name_len - 1] = '\0';
 
 			path->kcontrol = snd_soc_cnew(&w->kcontrols[i], w,
-				path->long_name);
+						      path->long_name, prefix);
 			ret = snd_ctl_add(card, path->kcontrol);
 			if (ret < 0) {
 				dev_err(dapm->dev,
@@ -431,6 +437,7 @@ static int dapm_new_mux(struct snd_soc_dapm_context *dapm,
 	struct snd_soc_dapm_path *path = NULL;
 	struct snd_kcontrol *kcontrol;
 	struct snd_card *card = dapm->card->snd_card;
+	const char *prefix;
 	int ret = 0;
 
 	if (!w->num_kcontrols) {
@@ -438,7 +445,12 @@ static int dapm_new_mux(struct snd_soc_dapm_context *dapm,
 		return -EINVAL;
 	}
 
-	kcontrol = snd_soc_cnew(&w->kcontrols[0], w, w->name);
+	if (dapm->codec)
+		prefix = dapm->codec->name_prefix;
+	else
+		prefix = NULL;
+
+	kcontrol = snd_soc_cnew(&w->kcontrols[0], w, w->name, prefix);
 	ret = snd_ctl_add(card, kcontrol);
 
 	if (ret < 0)
-- 
1.7.2.3
