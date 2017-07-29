From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: soc-pcm: Remove unused
	'debugfs_dpcm_state' entry
Date: Sat, 29 Jul 2017 11:40:55 -0300
Message-ID: <1501339255-29094-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f194.google.com (mail-qt0-f194.google.com
 [209.85.216.194])
 by alsa0.perex.cz (Postfix) with ESMTP id BC191266E15
 for <alsa-devel@alsa-project.org>; Sat, 29 Jul 2017 16:41:23 +0200 (CEST)
Received: by mail-qt0-f194.google.com with SMTP id d10so13746512qtb.4
 for <alsa-devel@alsa-project.org>; Sat, 29 Jul 2017 07:41:23 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

'debugfs_dpcm_state' member from structure snd_soc_pcm_runtime
is never used at all, so it is safe to remove it.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 include/sound/soc.h | 1 -
 sound/soc/soc-pcm.c | 5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 8f9376f..9d6e1db 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1233,7 +1233,6 @@ struct snd_soc_pcm_runtime {
 	struct delayed_work delayed_work;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_dpcm_root;
-	struct dentry *debugfs_dpcm_state;
 #endif
 
 	unsigned int num; /* 0-based and monotonic increasing */
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 7d3859e..24148de 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -3000,8 +3000,7 @@ void soc_dpcm_debugfs_add(struct snd_soc_pcm_runtime *rtd)
 		return;
 	}
 
-	rtd->debugfs_dpcm_state = debugfs_create_file("state", 0444,
-						rtd->debugfs_dpcm_root,
-						rtd, &dpcm_state_fops);
+	debugfs_create_file("state", 0444, rtd->debugfs_dpcm_root,
+			    rtd, &dpcm_state_fops);
 }
 #endif
-- 
2.7.4
