From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix double addition of prefixes due to
	widget prefixing
Date: Wed,  9 Mar 2011 11:34:12 +0000
Message-ID: <1299670452-13290-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6D87F245CE
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2011 12:33:54 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We're not only prefixing all controls, we're also prefixing the widget
names in the runtime data. This causes us to add the prefix twice - once
when using the widget name to generate the control name and once when
adding the control.

Really we shouldn't be prefixing the widget names at all, the matching
code should be handing this as we always know which DAPM context a
widget came from and always display the widget name in terms of a DAPM
context.  However, we're quite close to the merge window and that's
relatively invasive.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   29 ++++++++++++++++++++++++++---
 1 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c5335da..81c4052 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -366,7 +366,7 @@ static int dapm_new_mixer(struct snd_soc_dapm_context *dapm,
 	struct snd_soc_dapm_widget *w)
 {
 	int i, ret = 0;
-	size_t name_len;
+	size_t name_len, prefix_len;
 	struct snd_soc_dapm_path *path;
 	struct snd_card *card = dapm->card->snd_card;
 	const char *prefix;
@@ -376,6 +376,11 @@ static int dapm_new_mixer(struct snd_soc_dapm_context *dapm,
 	else
 		prefix = NULL;
 
+	if (prefix)
+		prefix_len = strlen(prefix) + 1;
+	else
+		prefix_len = 0;
+
 	/* add kcontrol */
 	for (i = 0; i < w->num_kcontrols; i++) {
 
@@ -403,8 +408,15 @@ static int dapm_new_mixer(struct snd_soc_dapm_context *dapm,
 
 			switch (w->id) {
 			default:
+				/* The control will get a prefix from
+				 * the control creation process but
+				 * we're also using the same prefix
+				 * for widgets so cut the prefix off
+				 * the front of the widget name.
+				 */
 				snprintf(path->long_name, name_len, "%s %s",
-					 w->name, w->kcontrols[i].name);
+					 w->name + prefix_len,
+					 w->kcontrols[i].name);
 				break;
 			case snd_soc_dapm_mixer_named_ctl:
 				snprintf(path->long_name, name_len, "%s",
@@ -438,6 +450,7 @@ static int dapm_new_mux(struct snd_soc_dapm_context *dapm,
 	struct snd_kcontrol *kcontrol;
 	struct snd_card *card = dapm->card->snd_card;
 	const char *prefix;
+	size_t prefix_len;
 	int ret = 0;
 
 	if (!w->num_kcontrols) {
@@ -450,7 +463,17 @@ static int dapm_new_mux(struct snd_soc_dapm_context *dapm,
 	else
 		prefix = NULL;
 
-	kcontrol = snd_soc_cnew(&w->kcontrols[0], w, w->name, prefix);
+	if (prefix)
+		prefix_len = strlen(prefix) + 1;
+	else
+		prefix_len = 0;
+
+	/* The control will get a prefix from the control creation
+	 * process but we're also using the same prefix for widgets so
+	 * cut the prefix off the front of the widget name.
+	 */
+	kcontrol = snd_soc_cnew(&w->kcontrols[0], w, w->name + prefix_len,
+				prefix);
 	ret = snd_ctl_add(card, kcontrol);
 
 	if (ret < 0)
-- 
1.7.4.1
