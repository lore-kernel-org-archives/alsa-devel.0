From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] ASoC: Make soc_dpcm_debugfs_add() non-fatal
Date: Thu,  9 Apr 2015 10:52:37 +0200
Message-ID: <1428569558-15883-2-git-send-email-lars@metafoo.de>
References: <1428569558-15883-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-026.synserver.de (smtp-out-026.synserver.de
 [212.40.185.26])
 by alsa0.perex.cz (Postfix) with ESMTP id 392982658FA
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2015 10:52:56 +0200 (CEST)
In-Reply-To: <1428569558-15883-1-git-send-email-lars@metafoo.de>
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
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Fabio Estevam <festevam@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

Failing to register the debugfs entries is not fatal and will not affect
normal operation of the sound card. Don't abort the card registration if
soc_dpcm_debugfs_add() fails.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dpcm.h |  2 +-
 sound/soc/soc-core.c     | 11 ++---------
 sound/soc/soc-pcm.c      |  8 +++-----
 3 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/include/sound/soc-dpcm.h b/include/sound/soc-dpcm.h
index 98f2ade..8060590 100644
--- a/include/sound/soc-dpcm.h
+++ b/include/sound/soc-dpcm.h
@@ -135,7 +135,7 @@ void snd_soc_dpcm_be_set_state(struct snd_soc_pcm_runtime *be, int stream,
 
 /* internal use only */
 int soc_dpcm_be_digital_mute(struct snd_soc_pcm_runtime *fe, int mute);
-int soc_dpcm_debugfs_add(struct snd_soc_pcm_runtime *rtd);
+void soc_dpcm_debugfs_add(struct snd_soc_pcm_runtime *rtd);
 int soc_dpcm_runtime_update(struct snd_soc_card *);
 
 int dpcm_path_get(struct snd_soc_pcm_runtime *fe,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 7bd1599..e97b395 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1324,15 +1324,8 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 
 #ifdef CONFIG_DEBUG_FS
 	/* add DPCM sysfs entries */
-	if (dai_link->dynamic) {
-		ret = soc_dpcm_debugfs_add(rtd);
-		if (ret < 0) {
-			dev_err(rtd->dev,
-				"ASoC: failed to add dpcm sysfs entries: %d\n",
-				ret);
-			return ret;
-		}
-	}
+	if (dai_link->dynamic)
+		soc_dpcm_debugfs_add(rtd);
 #endif
 
 	if (cpu_dai->driver->compress_dai) {
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 6e3781e..e67378a 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2803,10 +2803,10 @@ static const struct file_operations dpcm_state_fops = {
 	.llseek = default_llseek,
 };
 
-int soc_dpcm_debugfs_add(struct snd_soc_pcm_runtime *rtd)
+void soc_dpcm_debugfs_add(struct snd_soc_pcm_runtime *rtd)
 {
 	if (!rtd->dai_link)
-		return 0;
+		return;
 
 	rtd->debugfs_dpcm_root = debugfs_create_dir(rtd->dai_link->name,
 			rtd->card->debugfs_card_root);
@@ -2814,13 +2814,11 @@ int soc_dpcm_debugfs_add(struct snd_soc_pcm_runtime *rtd)
 		dev_dbg(rtd->dev,
 			 "ASoC: Failed to create dpcm debugfs directory %s\n",
 			 rtd->dai_link->name);
-		return -EINVAL;
+		return;
 	}
 
 	rtd->debugfs_dpcm_state = debugfs_create_file("state", 0444,
 						rtd->debugfs_dpcm_root,
 						rtd, &dpcm_state_fops);
-
-	return 0;
 }
 #endif
-- 
1.8.0
