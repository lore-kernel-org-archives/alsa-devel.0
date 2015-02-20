From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/4] ALSA: pcm: Don't ignore internal PCMs in
	snd_pcm_dev_disconnect()
Date: Fri, 20 Feb 2015 17:23:28 +0100
Message-ID: <1424449408-22376-5-git-send-email-tiwai@suse.de>
References: <1424449408-22376-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EF705260591
 for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2015 17:23:31 +0100 (CET)
In-Reply-To: <1424449408-22376-1-git-send-email-tiwai@suse.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Some codes in snd_pcm_dev_disconnect() are still valid even for
internal PCMs, but they are skipped because of the check of
list_empty(&pcm->list) at the beginning.  Remove this check and put
pcm->internal checks appropriately for internal PCM object to process
through this function.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 3cf345426171..64e726658ca1 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -1124,9 +1124,6 @@ static int snd_pcm_dev_disconnect(struct snd_device *device)
 	int cidx;
 
 	mutex_lock(&register_mutex);
-	if (list_empty(&pcm->list))
-		goto unlock;
-
 	mutex_lock(&pcm->open_mutex);
 	wake_up(&pcm->open_wait);
 	list_del_init(&pcm->list);
@@ -1146,14 +1143,14 @@ static int snd_pcm_dev_disconnect(struct snd_device *device)
 			notify->n_disconnect(pcm);
 	}
 	for (cidx = 0; cidx < 2; cidx++) {
-		snd_unregister_device(&pcm->streams[cidx].dev);
+		if (!pcm->internal)
+			snd_unregister_device(&pcm->streams[cidx].dev);
 		if (pcm->streams[cidx].chmap_kctl) {
 			snd_ctl_remove(pcm->card, pcm->streams[cidx].chmap_kctl);
 			pcm->streams[cidx].chmap_kctl = NULL;
 		}
 	}
 	mutex_unlock(&pcm->open_mutex);
- unlock:
 	mutex_unlock(&register_mutex);
 	return 0;
 }
-- 
2.3.0
