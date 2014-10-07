From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 2/3] ASoC: soc-dapm: fix use after free
Date: Tue,  7 Oct 2014 13:41:24 +0200
Message-ID: <1412682085-5217-3-git-send-email-daniel@zonque.org>
References: <1412682085-5217-1-git-send-email-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 31042260458
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 13:41:32 +0200 (CEST)
In-Reply-To: <1412682085-5217-1-git-send-email-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Coverity spotted the following possible use-after-free condition in
dapm_create_or_share_mixmux_kcontrol():

If kcontrol is NULL, and (wname_in_long_name && kcname_in_long_name)
validates to true, 'name' will be set to an allocated string, and be
freed a few lines later via the 'long_name' alias. 'name', however,
is used by dev_err() in case snd_ctl_add() fails.

Fix this by adding a jump label that frees 'long_name' at the end of
the function.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 sound/soc/soc-dapm.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 2c456a3..c61cb9c 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -592,9 +592,9 @@ static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
 	int shared;
 	struct snd_kcontrol *kcontrol;
 	bool wname_in_long_name, kcname_in_long_name;
-	char *long_name;
+	char *long_name = NULL;
 	const char *name;
-	int ret;
+	int ret = 0;
 
 	prefix = soc_dapm_prefix(dapm);
 	if (prefix)
@@ -653,15 +653,17 @@ static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
 
 		kcontrol = snd_soc_cnew(&w->kcontrol_news[kci], NULL, name,
 					prefix);
-		kfree(long_name);
-		if (!kcontrol)
-			return -ENOMEM;
+		if (!kcontrol) {
+			ret = -ENOMEM;
+			goto exit_free;
+		}
+
 		kcontrol->private_free = dapm_kcontrol_free;
 
 		ret = dapm_kcontrol_data_alloc(w, kcontrol);
 		if (ret) {
 			snd_ctl_free_one(kcontrol);
-			return ret;
+			goto exit_free;
 		}
 
 		ret = snd_ctl_add(card, kcontrol);
@@ -669,17 +671,18 @@ static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
 			dev_err(dapm->dev,
 				"ASoC: failed to add widget %s dapm kcontrol %s: %d\n",
 				w->name, name, ret);
-			return ret;
+			goto exit_free;
 		}
 	}
 
 	ret = dapm_kcontrol_add_widget(kcontrol, w);
-	if (ret)
-		return ret;
+	if (ret == 0)
+		w->kcontrols[kci] = kcontrol;
 
-	w->kcontrols[kci] = kcontrol;
+exit_free:
+	kfree(long_name);
 
-	return 0;
+	return ret;
 }
 
 /* create new dapm mixer control */
-- 
2.1.0
