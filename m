From: <twischer@de.adit-jv.com>
Subject: [PATCH 09/10] ALSA: pcm: Add snd_pcm_ops for snd_pcm_link()
Date: Tue, 26 Mar 2019 08:49:33 +0100
Message-ID: <1553586574-18608-5-git-send-email-twischer@de.adit-jv.com>
References: <1553529644-5654-1-git-send-email-twischer@de.adit-jv.com>
 <1553586574-18608-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553586574-18608-1-git-send-email-twischer@de.adit-jv.com>
Sender: linux-kernel-owner@vger.kernel.org
To: patch@alsa-project.org, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Timo Wischer <twischer@de.adit-jv.com>
List-Id: alsa-devel@alsa-project.org

From: Timo Wischer <twischer@de.adit-jv.com>

snd_pcm_link() can be called by the user as long as the device is not
yet started. Therefore currently a driver which wants to iterate over
the linked substreams has to do this at the start trigger. But the start
trigger should not block for a long time. Therefore there is no callback
which can be used to iterate over the linked substreams without delaying
the start trigger.
This patch introduces a new callback function which will be called after
the linked substream list was updated by snd_pcm_link(). This callback
function is allowed to block for a longer time without interfering the
synchronized start up of linked substreams.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
---
 include/sound/pcm.h     |  1 +
 sound/core/pcm_native.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 18bd8c3..a7e5dd2 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -90,6 +90,7 @@ struct snd_pcm_ops {
 			     unsigned long offset);
 	int (*mmap)(struct snd_pcm_substream *substream, struct vm_area_struct *vma);
 	int (*ack)(struct snd_pcm_substream *substream);
+	int (*link_changed)(struct snd_pcm_substream *substream);
 };
 
 /*
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index f731f90..57a8a66 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1981,6 +1981,27 @@ static bool is_pcm_file(struct file *file)
 /*
  * PCM link handling
  */
+/* Note: call with snd_pcm_link_rwsem locked */
+static int  snd_pcm_link_changed(struct snd_pcm_substream * const substream)
+{
+	struct snd_pcm_substream *s;
+
+	/* snd_pcm_link_rwsem is down whenever the link_list is changed.
+	 * Therefore this lock is sufficent for the iteration.
+	 */
+	snd_pcm_group_for_each_entry(s, substream) {
+		int err;
+
+		if (!s->ops->link_changed)
+			continue;
+		err = s->ops->link_changed(s);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
 static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
 {
 	int res = 0;
@@ -2030,6 +2051,9 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
 	snd_pcm_group_assign(substream1, target_group);
 	snd_pcm_stream_unlock(substream1);
 	snd_pcm_group_unlock_irq(target_group, nonatomic);
+
+	if (res >= 0)
+		res = snd_pcm_link_changed(substream);
  _end:
 	up_write(&snd_pcm_link_rwsem);
  _nolock:
@@ -2076,6 +2100,11 @@ static int snd_pcm_unlink(struct snd_pcm_substream *substream)
 	snd_pcm_group_unlock_irq(group, nonatomic);
 	if (do_free)
 		kfree(group);
+	if (res >= 0)
+		res = snd_pcm_link_changed(substream);
+	/* Also signal substream which was removed */
+	if (res >= 0 && substream->ops->link_changed)
+		res = substream->ops->link_changed(substream);
 
        _end:
 	up_write(&snd_pcm_link_rwsem);
-- 
2.7.4
