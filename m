From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/4] ALSA: rawmidi: Use kvmalloc() for buffers
Date: Tue, 17 Jul 2018 23:19:49 +0200
Message-ID: <20180717211949.689-5-tiwai@suse.de>
References: <20180717211949.689-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A8ED226783C
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2018 23:19:51 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 33DCCADDF
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2018 21:19:51 +0000 (UTC)
In-Reply-To: <20180717211949.689-1-tiwai@suse.de>
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

The size of in-kernel rawmidi buffers may be big up to 1MB, and it can
be specified freely by user-space; which implies that user-space may
trigger kmalloc() errors frequently.

This patch replaces the buffer allocation via kvmalloc() for dealing
with bigger buffers gracefully.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/rawmidi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index cc944a3637a2..c4e3f4e71c6b 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -128,7 +128,7 @@ static int snd_rawmidi_runtime_create(struct snd_rawmidi_substream *substream)
 		runtime->avail = 0;
 	else
 		runtime->avail = runtime->buffer_size;
-	runtime->buffer = kmalloc(runtime->buffer_size, GFP_KERNEL);
+	runtime->buffer = kvmalloc(runtime->buffer_size, GFP_KERNEL);
 	if (!runtime->buffer) {
 		kfree(runtime);
 		return -ENOMEM;
@@ -142,7 +142,7 @@ static int snd_rawmidi_runtime_free(struct snd_rawmidi_substream *substream)
 {
 	struct snd_rawmidi_runtime *runtime = substream->runtime;
 
-	kfree(runtime->buffer);
+	kvfree(runtime->buffer);
 	kfree(runtime);
 	substream->runtime = NULL;
 	return 0;
@@ -654,7 +654,7 @@ static int resize_runtime_buffer(struct snd_rawmidi_runtime *runtime,
 	if (params->avail_min < 1 || params->avail_min > params->buffer_size)
 		return -EINVAL;
 	if (params->buffer_size != runtime->buffer_size) {
-		newbuf = kmalloc(params->buffer_size, GFP_KERNEL);
+		newbuf = kvmalloc(params->buffer_size, GFP_KERNEL);
 		if (!newbuf)
 			return -ENOMEM;
 		spin_lock_irq(&runtime->lock);
@@ -663,7 +663,7 @@ static int resize_runtime_buffer(struct snd_rawmidi_runtime *runtime,
 		runtime->buffer_size = params->buffer_size;
 		__reset_runtime_ptrs(runtime, is_input);
 		spin_unlock_irq(&runtime->lock);
-		kfree(oldbuf);
+		kvfree(oldbuf);
 	}
 	runtime->avail_min = params->avail_min;
 	return 0;
-- 
2.18.0
