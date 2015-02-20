From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/4] ALSA: pcm: Don't notify internal PCMs
Date: Fri, 20 Feb 2015 17:23:27 +0100
Message-ID: <1424449408-22376-4-git-send-email-tiwai@suse.de>
References: <1424449408-22376-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id ED57726058D
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

Notifier shouldn't listen to the changes of internal PCMs.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 92bbb5143b83..3cf345426171 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -888,8 +888,9 @@ static int snd_pcm_free(struct snd_pcm *pcm)
 
 	if (!pcm)
 		return 0;
-	list_for_each_entry(notify, &snd_pcm_notify_list, list) {
-		notify->n_unregister(pcm);
+	if (!pcm->internal) {
+		list_for_each_entry(notify, &snd_pcm_notify_list, list)
+			notify->n_unregister(pcm);
 	}
 	if (pcm->private_free)
 		pcm->private_free(pcm);
@@ -1129,7 +1130,7 @@ static int snd_pcm_dev_disconnect(struct snd_device *device)
 	mutex_lock(&pcm->open_mutex);
 	wake_up(&pcm->open_wait);
 	list_del_init(&pcm->list);
-	for (cidx = 0; cidx < 2; cidx++)
+	for (cidx = 0; cidx < 2; cidx++) {
 		for (substream = pcm->streams[cidx].substream; substream; substream = substream->next) {
 			snd_pcm_stream_lock_irq(substream);
 			if (substream->runtime) {
@@ -1139,8 +1140,10 @@ static int snd_pcm_dev_disconnect(struct snd_device *device)
 			}
 			snd_pcm_stream_unlock_irq(substream);
 		}
-	list_for_each_entry(notify, &snd_pcm_notify_list, list) {
-		notify->n_disconnect(pcm);
+	}
+	if (!pcm->internal) {
+		list_for_each_entry(notify, &snd_pcm_notify_list, list)
+			notify->n_disconnect(pcm);
 	}
 	for (cidx = 0; cidx < 2; cidx++) {
 		snd_unregister_device(&pcm->streams[cidx].dev);
-- 
2.3.0
