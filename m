From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/2] ALSA: rawmidi: add a helper to set runtime
	error
Date: Sat, 13 Aug 2016 21:39:17 +0900
Message-ID: <1471091957-14757-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1471091957-14757-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 882BC265D44
 for <alsa-devel@alsa-project.org>; Sat, 13 Aug 2016 14:39:23 +0200 (CEST)
In-Reply-To: <1471091957-14757-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In previous commit, runtime of rawmidi substream can represent error state.
This allows drivers to break the runtime voluntarily.

This commit adds a helper function to help drivers.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/sound/rawmidi.h |  2 ++
 sound/core/rawmidi.c    | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/sound/rawmidi.h b/include/sound/rawmidi.h
index da1e93f..0b9c0f6 100644
--- a/include/sound/rawmidi.h
+++ b/include/sound/rawmidi.h
@@ -191,4 +191,6 @@ long snd_rawmidi_kernel_read(struct snd_rawmidi_substream *substream,
 long snd_rawmidi_kernel_write(struct snd_rawmidi_substream *substream,
 			      const unsigned char *buf, long count);
 
+void snd_rawmidi_substream_break(struct snd_rawmidi_substream *substream);
+
 #endif /* __SOUND_RAWMIDI_H */
diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index 1ca820e..c5da14a 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -134,6 +134,31 @@ static int snd_rawmidi_runtime_create(struct snd_rawmidi_substream *substream)
 	return 0;
 }
 
+/**
+ * snd_rawmidi_substream_break - break rawmidi substream
+ * @substream: the rawmidi substream.
+ *
+ * When logical channel between system and device for MIDI transmitssion is
+ * under disorder, call this helper to notify it to userspace. Once broken,
+ * the substream should be closed in userspace, because there's no
+ * operation for userspace applications to recover from this state.
+ */
+void snd_rawmidi_substream_break(struct snd_rawmidi_substream *substream)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&substream->runtime->lock, flags);
+	substream->runtime->error = true;
+	spin_unlock_irqrestore(&substream->runtime->lock, flags);
+
+	/* Kick event listener. */
+	if (runtime->event)
+		schedule_work(&runtime->event_work);
+
+	wake_up(&runtime->sleep);
+}
+EXPORT_SYMBOL(snd_rawmidi_substream_break);
+
 static int snd_rawmidi_runtime_free(struct snd_rawmidi_substream *substream)
 {
 	struct snd_rawmidi_runtime *runtime = substream->runtime;
-- 
2.7.4
