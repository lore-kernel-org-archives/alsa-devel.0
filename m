From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] ASoC: Use kasprintf instead of opencoding
	it
Date: Tue, 14 May 2013 11:05:32 +0200
Message-ID: <1368522332-15624-3-git-send-email-lars@metafoo.de>
References: <1368522332-15624-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-187.synserver.de (smtp-out-187.synserver.de
 [212.40.185.187])
 by alsa0.perex.cz (Postfix) with ESMTP id D50F92608DA
 for <alsa-devel@alsa-project.org>; Tue, 14 May 2013 11:05:58 +0200 (CEST)
In-Reply-To: <1368522332-15624-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

kasprintf calculates the size of the result string, allocates a buffer large
enough to hold the string and then performs the format string operation. There
are a couple of places in ASoC where these three steps are done by hand and
where kasprintf can be used instead.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c |  6 +-----
 sound/soc/soc-dapm.c | 31 ++++++++++---------------------
 2 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 9d95ef5..4489c5b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2237,7 +2237,6 @@ struct snd_kcontrol *snd_soc_cnew(const struct snd_kcontrol_new *_template,
 	struct snd_kcontrol_new template;
 	struct snd_kcontrol *kcontrol;
 	char *name = NULL;
-	int name_len;
 
 	memcpy(&template, _template, sizeof(template));
 	template.index = 0;
@@ -2246,13 +2245,10 @@ struct snd_kcontrol *snd_soc_cnew(const struct snd_kcontrol_new *_template,
 		long_name = template.name;
 
 	if (prefix) {
-		name_len = strlen(long_name) + strlen(prefix) + 2;
-		name = kmalloc(name_len, GFP_KERNEL);
+		name = kasprintf(GFP_KERNEL, "%s %s", prefix, long_name);
 		if (!name)
 			return NULL;
 
-		snprintf(name, name_len, "%s %s", prefix, long_name);
-
 		template.name = name;
 	} else {
 		template.name = long_name;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index e4e5420..071579b 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -521,7 +521,6 @@ static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
 	int wlistentries;
 	size_t wlistsize;
 	bool wname_in_long_name, kcname_in_long_name;
-	size_t name_len;
 	char *long_name;
 	const char *name;
 	int ret;
@@ -586,25 +585,19 @@ static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
 		}
 
 		if (wname_in_long_name && kcname_in_long_name) {
-			name_len = strlen(w->name) - prefix_len + 1 +
-				   strlen(w->kcontrol_news[kci].name) + 1;
-
-			long_name = kmalloc(name_len, GFP_KERNEL);
-			if (long_name == NULL) {
-				kfree(wlist);
-				return -ENOMEM;
-			}
-
 			/*
 			 * The control will get a prefix from the control
 			 * creation process but we're also using the same
 			 * prefix for widgets so cut the prefix off the
 			 * front of the widget name.
 			 */
-			snprintf(long_name, name_len, "%s %s",
+			long_name = kasprintf(GFP_KERNEL, "%s %s",
 				 w->name + prefix_len,
 				 w->kcontrol_news[kci].name);
-			long_name[name_len - 1] = '\0';
+			if (long_name == NULL) {
+				kfree(wlist);
+				return -ENOMEM;
+			}
 
 			name = long_name;
 		} else if (wname_in_long_name) {
@@ -3077,7 +3070,6 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 			 const struct snd_soc_dapm_widget *widget)
 {
 	struct snd_soc_dapm_widget *w;
-	size_t name_len;
 	int ret;
 
 	if ((w = dapm_cnew_widget(widget)) == NULL)
@@ -3118,19 +3110,16 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 		break;
 	}
 
-	name_len = strlen(widget->name) + 1;
 	if (dapm->codec && dapm->codec->name_prefix)
-		name_len += 1 + strlen(dapm->codec->name_prefix);
-	w->name = kmalloc(name_len, GFP_KERNEL);
+		w->name = kasprintf(GFP_KERNEL, "%s %s",
+			dapm->codec->name_prefix, widget->name);
+	else
+		w->name = kasprintf(GFP_KERNEL, "%s", widget->name);
+
 	if (w->name == NULL) {
 		kfree(w);
 		return NULL;
 	}
-	if (dapm->codec && dapm->codec->name_prefix)
-		snprintf((char *)w->name, name_len, "%s %s",
-			dapm->codec->name_prefix, widget->name);
-	else
-		snprintf((char *)w->name, name_len, "%s", widget->name);
 
 	switch (w->id) {
 	case snd_soc_dapm_switch:
-- 
1.8.0
