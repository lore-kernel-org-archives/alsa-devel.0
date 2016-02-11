From: Rajan Vaja <rajan.vaja@gmail.com>
Subject: [PATCH] ASoC: dapm: Remove unneeded variable ret
	returning 0
Date: Thu, 11 Feb 2016 11:23:35 +0530
Message-ID: <1455170015-25009-1-git-send-email-rajan.vaja@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 by alsa0.perex.cz (Postfix) with ESMTP id DD31D260644
 for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2016 06:54:06 +0100 (CET)
Received: by mail-pa0-f44.google.com with SMTP id fl4so11859355pad.0
 for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2016 21:54:06 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

This patch fixes coccicheck report:
	Unneeded variable: "ret". Return "0" on line 2817

Remove unneccesary variable ret created to return zero.

Signed-off-by: Rajan Vaja <rajan.vaja@gmail.com>
---
 sound/soc/soc-dapm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 5a2812f..8dc395f 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2805,7 +2805,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_add_routes);
 int snd_soc_dapm_del_routes(struct snd_soc_dapm_context *dapm,
 			    const struct snd_soc_dapm_route *route, int num)
 {
-	int i, ret = 0;
+	int i;
 
 	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_INIT);
 	for (i = 0; i < num; i++) {
@@ -2814,7 +2814,7 @@ int snd_soc_dapm_del_routes(struct snd_soc_dapm_context *dapm,
 	}
 	mutex_unlock(&dapm->card->dapm_mutex);
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_del_routes);
 
-- 
1.7.9.5
