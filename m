From: Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH] sound: soc-pcm: add a check to avoid NULL pointer dereference
Date: Thu, 14 Mar 2019 22:44:15 -0500
Message-ID: <20190315034415.24085-1-kjlu@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kjlu@umn.edu
Cc: pakki001@umn.edu, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In case debugfs_create_u32 fails, the fix frees memory and returns
an error to notify callers.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 sound/soc/soc-pcm.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 0d5ec68a1e50..a7d88ed8ebb5 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1231,15 +1231,21 @@ static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
 	list_add(&dpcm->list_be, &fe->dpcm[stream].be_clients);
 	list_add(&dpcm->list_fe, &be->dpcm[stream].fe_clients);
 
-	dev_dbg(fe->dev, "connected new DPCM %s path %s %s %s\n",
-			stream ? "capture" : "playback",  fe->dai_link->name,
-			stream ? "<-" : "->", be->dai_link->name);
-
 #ifdef CONFIG_DEBUG_FS
-	if (fe->debugfs_dpcm_root)
+	if (fe->debugfs_dpcm_root) {
 		dpcm->debugfs_state = debugfs_create_u32(be->dai_link->name, 0644,
 				fe->debugfs_dpcm_root, &dpcm->state);
+		if (!dpcm->debugfs_state) {
+			kfree(dpcm);
+			return -ENOMEM;
+		}
+	}
 #endif
+
+	dev_dbg(fe->dev, "connected new DPCM %s path %s %s %s\n",
+			stream ? "capture" : "playback",  fe->dai_link->name,
+			stream ? "<-" : "->", be->dai_link->name);
+
 	return 1;
 }
 
-- 
2.17.1
