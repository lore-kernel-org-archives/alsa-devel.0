From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH] ASoC: Implement mixer control sharing
Date: Thu, 28 Mar 2013 17:53:10 -0600
Message-ID: <1364514790-28398-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id A2AB52652C1
 for <alsa-devel@alsa-project.org>; Fri, 29 Mar 2013 00:53:27 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

This is the equivalent of commit af46800 "ASoC: Implement mux control
sharing", but applied to mixers instead of muxes.

This allows a single control to affect multiple mixer widgets at once,
which is useful when there is a single set of register bits that affects
both multiple mixers in HW, for example both the L and R mixers of a
stereo path.

Without this, you either:

1) End up with multiple controls that affect the same register bits, but
whose DAPM state falls out of sync with HW, since the DAPM state is only
updated for the specific control that is modified, and not for other
paths that are affected only by the other control.

2) False paths through DAPM, since you end up merging unconnected stereo
paths together into a single widget which hosts the single control, and
then branching back out again, thus conjoining the enable states of the
two input paths.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Mark, the goto here might be considered icky. It avoids heavy indent
levels. Should I separate out the control creation part of dapm_new_mixer()
into a separate function to avoid this?

Also, this commit has the potential for user-space impact, since control
names could change for existing drivers. However, in this case I suspect
the affected controls wouldn't have worked very well anyway, since they'd
be affected by one of the problems I mention in the commit description
above anyway, so I doubt this will be a practical problem.

FYI, this feature for muxes will be useful for the rt5640.c driver, which
has a single register for the HPO MUX, which separately affects both a L
and R path to the HP outputs.

 sound/soc/soc-dapm.c |   57 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 21 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 33acd8b..9a87aa5 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -508,13 +508,15 @@ static int dapm_is_shared_kcontrol(struct snd_soc_dapm_context *dapm,
 static int dapm_new_mixer(struct snd_soc_dapm_widget *w)
 {
 	struct snd_soc_dapm_context *dapm = w->dapm;
-	int i, ret = 0;
+	int i, ret;
 	size_t name_len, prefix_len;
 	struct snd_soc_dapm_path *path;
 	struct snd_card *card = dapm->card->snd_card;
 	const char *prefix;
 	struct snd_soc_dapm_widget_list *wlist;
+	int shared, wlistentries;
 	size_t wlistsize;
+	struct snd_kcontrol *kcontrol;
 
 	if (dapm->codec)
 		prefix = dapm->codec->name_prefix;
@@ -531,7 +533,6 @@ static int dapm_new_mixer(struct snd_soc_dapm_widget *w)
 
 		/* match name */
 		list_for_each_entry(path, &w->sources, list_sink) {
-
 			/* mixer/mux paths name must match control name */
 			if (path->name != (char *)w->kcontrol_news[i].name)
 				continue;
@@ -541,26 +542,41 @@ static int dapm_new_mixer(struct snd_soc_dapm_widget *w)
 				continue;
 			}
 
+			shared = dapm_is_shared_kcontrol(dapm, w,
+					&w->kcontrol_news[i], &kcontrol);
+
+			if (kcontrol) {
+				wlist = kcontrol->private_data;
+				wlistentries = wlist->num_widgets + 1;
+			} else {
+				wlist = NULL;
+				wlistentries = 1;
+			}
+
 			wlistsize = sizeof(struct snd_soc_dapm_widget_list) +
-				    sizeof(struct snd_soc_dapm_widget *),
-			wlist = kzalloc(wlistsize, GFP_KERNEL);
+					wlistentries *
+					sizeof(struct snd_soc_dapm_widget *),
+			wlist = krealloc(wlist, wlistsize, GFP_KERNEL);
 			if (wlist == NULL) {
 				dev_err(dapm->dev,
 					"ASoC: can't allocate widget list for %s\n",
 					w->name);
 				return -ENOMEM;
 			}
-			wlist->num_widgets = 1;
-			wlist->widgets[0] = w;
+			wlist->num_widgets = wlistentries;
+			wlist->widgets[wlistentries - 1] = w;
+
+			if (kcontrol)
+				goto skip_new_control;
 
 			/* add dapm control with long name.
 			 * for dapm_mixer this is the concatenation of the
 			 * mixer and kcontrol name.
-			 * for dapm_mixer_named_ctl this is simply the
-			 * kcontrol name.
+			 * for dapm_mixer_named_ctl or shared controls, this
+			 * is simply the kcontrol name.
 			 */
 			name_len = strlen(w->kcontrol_news[i].name) + 1;
-			if (w->id != snd_soc_dapm_mixer_named_ctl)
+			if (!shared && w->id != snd_soc_dapm_mixer_named_ctl)
 				name_len += 1 + strlen(w->name);
 
 			path->long_name = kmalloc(name_len, GFP_KERNEL);
@@ -570,8 +586,7 @@ static int dapm_new_mixer(struct snd_soc_dapm_widget *w)
 				return -ENOMEM;
 			}
 
-			switch (w->id) {
-			default:
+			if (!shared && w->id != snd_soc_dapm_mixer_named_ctl)
 				/* The control will get a prefix from
 				 * the control creation process but
 				 * we're also using the same prefix
@@ -581,19 +596,15 @@ static int dapm_new_mixer(struct snd_soc_dapm_widget *w)
 				snprintf((char *)path->long_name, name_len,
 					 "%s %s", w->name + prefix_len,
 					 w->kcontrol_news[i].name);
-				break;
-			case snd_soc_dapm_mixer_named_ctl:
+			else
 				snprintf((char *)path->long_name, name_len,
 					 "%s", w->kcontrol_news[i].name);
-				break;
-			}
 
 			((char *)path->long_name)[name_len - 1] = '\0';
 
-			path->kcontrol = snd_soc_cnew(&w->kcontrol_news[i],
-						      wlist, path->long_name,
-						      prefix);
-			ret = snd_ctl_add(card, path->kcontrol);
+			kcontrol = snd_soc_cnew(&w->kcontrol_news[i], wlist,
+						path->long_name, prefix);
+			ret = snd_ctl_add(card, kcontrol);
 			if (ret < 0) {
 				dev_err(dapm->dev, "ASoC: failed to add widget"
 					" %s dapm kcontrol %s: %d\n",
@@ -603,10 +614,14 @@ static int dapm_new_mixer(struct snd_soc_dapm_widget *w)
 				path->long_name = NULL;
 				return ret;
 			}
-			w->kcontrols[i] = path->kcontrol;
+
+skip_new_control:
+			path->kcontrol = kcontrol;
+			kcontrol->private_data = wlist;
+			w->kcontrols[i] = kcontrol;
 		}
 	}
-	return ret;
+	return 0;
 }
 
 /* create new dapm mux control */
-- 
1.7.10.4
