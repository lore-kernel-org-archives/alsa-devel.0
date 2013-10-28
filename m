From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/5] ASoC: DAPM: Fix use after free in error
	path
Date: Mon, 28 Oct 2013 14:21:47 +0100
Message-ID: <1382966510-13075-3-git-send-email-tiwai@suse.de>
References: <1382966510-13075-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 101452615F3
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2013 14:19:06 +0100 (CET)
In-Reply-To: <1382966510-13075-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The error message in dapm_create_or_share_mixmux_kcontrol() refers to
the string "name", which may be "long_name" that has been already
freed.  Delay the release of long_name to the place just before return.

Spotted by coverity CID 1042678.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/soc-dapm.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 2fb0b72..d2ff080 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -687,7 +687,7 @@ static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
 	int shared;
 	struct snd_kcontrol *kcontrol;
 	bool wname_in_long_name, kcname_in_long_name;
-	char *long_name;
+	char *long_name = NULL;
 	const char *name;
 	int ret;
 
@@ -745,24 +745,23 @@ static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
 
 			name = long_name;
 		} else if (wname_in_long_name) {
-			long_name = NULL;
 			name = w->name + prefix_len;
 		} else {
-			long_name = NULL;
 			name = w->kcontrol_news[kci].name;
 		}
 
 		kcontrol = snd_soc_cnew(&w->kcontrol_news[kci], NULL, name,
 					prefix);
-		kfree(long_name);
-		if (!kcontrol)
-			return -ENOMEM;
+		if (!kcontrol) {
+			ret = -ENOMEM;
+			goto error;
+		}
 		kcontrol->private_free = dapm_kcontrol_free;
 
 		ret = dapm_kcontrol_data_alloc(w, kcontrol);
 		if (ret) {
 			snd_ctl_free_one(kcontrol);
-			return ret;
+			goto error;
 		}
 
 		ret = snd_ctl_add(card, kcontrol);
@@ -770,16 +769,18 @@ static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
 			dev_err(dapm->dev,
 				"ASoC: failed to add widget %s dapm kcontrol %s: %d\n",
 				w->name, name, ret);
-			return ret;
+			goto error;
 		}
 	}
 
 	ret = dapm_kcontrol_add_widget(kcontrol, w);
 	if (ret)
-		return ret;
+		goto error;
 
 	w->kcontrols[kci] = kcontrol;
 
+ error:
+	kfree(long_name);
 	return 0;
 }
 
-- 
1.8.4.1
