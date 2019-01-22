From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/7] ALSA: pcm: Call snd_card_unref() inside
	in_pcm_file()
Date: Tue, 22 Jan 2019 17:19:09 +0100
Message-ID: <20190122161915.8445-2-tiwai@suse.de>
References: <20190122161915.8445-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 300C32674A9
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 17:19:18 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 501BBB07C
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 16:19:18 +0000 (UTC)
In-Reply-To: <20190122161915.8445-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

The snd_card_unref() call in snd_pcm_link() looks suspicious through a
quick glance, but it's a correct usage; this is needed just because
the file descriptor check in is_pcm_file() calls the helper
snd_lookup_minor_data() that keeps the card refcount.

Despite of the correctness, the code still looks confusing.
Basically, keeping the card ref for the whole code isn't needed
as fdget() blocks the release of the opened file.  Hence it's more
understandable if snd_card_unref() is moved into is_pcm_file(), then
the caller doesn't have to take care after the call.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 818dff1de545..c72dfd1fc1ed 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1935,13 +1935,19 @@ static int snd_pcm_drop(struct snd_pcm_substream *substream)
 static bool is_pcm_file(struct file *file)
 {
 	struct inode *inode = file_inode(file);
+	struct snd_pcm *pcm;
 	unsigned int minor;
 
 	if (!S_ISCHR(inode->i_mode) || imajor(inode) != snd_major)
 		return false;
 	minor = iminor(inode);
-	return snd_lookup_minor_data(minor, SNDRV_DEVICE_TYPE_PCM_PLAYBACK) ||
-		snd_lookup_minor_data(minor, SNDRV_DEVICE_TYPE_PCM_CAPTURE);
+	pcm = snd_lookup_minor_data(minor, SNDRV_DEVICE_TYPE_PCM_PLAYBACK);
+	if (!pcm)
+		pcm = snd_lookup_minor_data(minor, SNDRV_DEVICE_TYPE_PCM_CAPTURE);
+	if (!pcm)
+		return false;
+	snd_card_unref(pcm->card);
+	return true;
 }
 
 /*
@@ -1996,7 +2002,6 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
 	write_unlock_irq(&snd_pcm_link_rwlock);
 	up_write(&snd_pcm_link_rwsem);
  _nolock:
-	snd_card_unref(substream1->pcm->card);
 	kfree(group);
  _badf:
 	fdput(f);
-- 
2.16.4
