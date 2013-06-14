From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/5] ASoC: dapm: Remove unused long_name field
	from snd_soc_dapm_path struct
Date: Fri, 14 Jun 2013 13:16:54 +0200
Message-ID: <1371208614-18697-5-git-send-email-lars@metafoo.de>
References: <1371208614-18697-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-121.synserver.de (smtp-out-121.synserver.de
 [212.40.185.121])
 by alsa0.perex.cz (Postfix) with ESMTP id 594A8265053
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2013 13:16:57 +0200 (CEST)
In-Reply-To: <1371208614-18697-1-git-send-email-lars@metafoo.de>
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

Since commit 85762e71 ("ASoC: dapm: Implement mixer control sharing") the
long_name field of the snd_soc_dapm_path struct is unused. All of the name
handling now happens entirely in dapm_create_or_share_mixmux_kcontrol(). So we
can remove the long_name field from the snd_soc_dapm_path struct.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h | 1 -
 sound/soc/soc-dapm.c     | 5 +----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 69e8e07..3e479f4 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -481,7 +481,6 @@ struct snd_soc_dapm_route {
 /* dapm audio path between two widgets */
 struct snd_soc_dapm_path {
 	const char *name;
-	const char *long_name;
 
 	/* source (input) and sink (output) widgets */
 	struct snd_soc_dapm_widget *source;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a771473..b941908 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -619,17 +619,15 @@ static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
 		kcontrol = snd_soc_cnew(&w->kcontrol_news[kci], wlist, name,
 					prefix);
 		kcontrol->private_free = dapm_kcontrol_free;
+		kfree(long_name);
 		ret = snd_ctl_add(card, kcontrol);
 		if (ret < 0) {
 			dev_err(dapm->dev,
 				"ASoC: failed to add widget %s dapm kcontrol %s: %d\n",
 				w->name, name, ret);
 			kfree(wlist);
-			kfree(long_name);
 			return ret;
 		}
-
-		path->long_name = long_name;
 	}
 
 	kcontrol->private_data = wlist;
@@ -2114,7 +2112,6 @@ static void dapm_free_path(struct snd_soc_dapm_path *path)
 	list_del(&path->list_sink);
 	list_del(&path->list_source);
 	list_del(&path->list);
-	kfree(path->long_name);
 	kfree(path);
 }
 
-- 
1.8.0
