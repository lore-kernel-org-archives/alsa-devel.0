From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/2] ALSA: update sync header when streams are
	linked/unlinked
Date: Tue, 22 May 2012 14:54:01 -0500
Message-ID: <1337716442-10411-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id F298B24554
	for <alsa-devel@alsa-project.org>;
	Tue, 22 May 2012 21:54:15 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Previous code only reported card number and was not updated
when devices were linked/unlinked. This makes alsa-lib
snd_pcm_info_get_sync totally useless.
Add hooks to force update of sync header when devices are
linked/unlinked, and provide more information such as
number of devices and indices of capture/playback devices
linked to

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/core/pcm_lib.c    |   37 ++++++++++++++++++++++++++++++++-----
 sound/core/pcm_native.c |    6 ++++++
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index faedb14..ae46d75 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -533,11 +533,38 @@ EXPORT_SYMBOL(snd_pcm_set_ops);
 void snd_pcm_set_sync(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	
-	runtime->sync.id32[0] = substream->pcm->card->number;
-	runtime->sync.id32[1] = -1;
-	runtime->sync.id32[2] = -1;
-	runtime->sync.id32[3] = -1;
+	struct snd_pcm_substream *s;
+	int dev_c, dev_p;
+
+	if (snd_pcm_stream_linked(substream)) {
+		runtime->sync.id32[0] = substream->pcm->card->number;
+		/* save number of devices linked */
+		runtime->sync.id32[1] = substream->group->count-1;
+		dev_c = dev_p = 0;
+
+		snd_pcm_group_for_each_entry(s, substream) {
+			if (s == substream)
+				continue;
+			if (s->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+				dev_p++;
+				if (dev_p == 1)
+					runtime->sync.id32[2] = 0;
+				/* save mask of linked playback devices */
+				runtime->sync.id32[2] |= (1<<s->number);
+			} else {
+				dev_c++;
+				if (dev_c == 1)
+					runtime->sync.id32[3] = 0;
+				/* save mask of linked capture devices */
+				runtime->sync.id32[3] |= (1<<s->number);
+			}
+		}
+	} else {
+		runtime->sync.id32[0] = -1;
+		runtime->sync.id32[1] = -1;
+		runtime->sync.id32[2] = -1;
+		runtime->sync.id32[3] = -1;
+	}
 }
 
 EXPORT_SYMBOL(snd_pcm_set_sync);
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 3fe99e6..e92bc62 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1619,6 +1619,9 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
 	list_add_tail(&substream1->link_list, &substream->group->substreams);
 	substream->group->count++;
 	substream1->group = substream->group;
+	snd_pcm_set_sync(substream);
+	snd_pcm_set_sync(substream1);
+
  _end:
 	write_unlock_irq(&snd_pcm_link_rwlock);
 	up_write(&snd_pcm_link_rwsem);
@@ -1652,11 +1655,14 @@ static int snd_pcm_unlink(struct snd_pcm_substream *substream)
 	if (substream->group->count == 1) {	/* detach the last stream, too */
 		snd_pcm_group_for_each_entry(s, substream) {
 			relink_to_local(s);
+			snd_pcm_set_sync(s);
 			break;
 		}
 		kfree(substream->group);
 	}
 	relink_to_local(substream);
+	snd_pcm_set_sync(substream);
+
        _end:
 	write_unlock_irq(&snd_pcm_link_rwlock);
 	up_write(&snd_pcm_link_rwsem);
-- 
1.7.6.5
