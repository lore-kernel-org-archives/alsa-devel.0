From: <twischer@de.adit-jv.com>
Subject: [PATCH IO plug API 1/1] ioplug: Use boundary for wrap
	around
Date: Fri, 23 Feb 2018 10:28:51 +0100
Message-ID: <1519378131-18139-1-git-send-email-twischer@de.adit-jv.com>
References: <s5hpo56o5e3.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id D3C93267232
 for <alsa-devel@alsa-project.org>; Fri, 23 Feb 2018 10:29:02 +0100 (CET)
In-Reply-To: <s5hpo56o5e3.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Timo Wischer <twischer@de.adit-jv.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Timo Wischer <twischer@de.adit-jv.com>

if requested by the IO plugin

Without this changes an IO plugin is not able to report
that buffer_size frames were read from the buffer.
When the buffer was full this is a valid action and
has not to be handled as an under run.

For example when the hw_ptr will be updated with
hw_ptr += buffer_size
and it is using the buffer_size as wrap around
hw_ptr %= buffer_size
would result in the same value as before the add operation.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
---
Hello Takashi,

> If you need to improve such a situation, you'd have to fix in the
> ioplug implementation itself, not the jack plugin.

A have attached a patch which improves the IO plug API.
If you are happy with this solution I would also adapt the pending
JACK plugin patch and set the SND_PCM_IOPLUG_FLAG_BOUNDARY_WA flag.

diff --git a/include/pcm_ioplug.h b/include/pcm_ioplug.h
index 1c84594..e75f973 100644
--- a/include/pcm_ioplug.h
+++ b/include/pcm_ioplug.h
@@ -65,6 +65,8 @@ typedef snd_pcm_ioplug_callback snd_pcm_ioplug_callback_t;
  */
 #define SND_PCM_IOPLUG_FLAG_LISTED	(1<<0)		/**< list up this PCM */
 #define SND_PCM_IOPLUG_FLAG_MONOTONIC	(1<<1)		/**< monotonic timestamps */
+/** hw pointer wrap around at boundary instead of buffer_size */
+#define SND_PCM_IOPLUG_FLAG_BOUNDARY_WA	(1<<2)
 
 /*
  * Protocol version
@@ -133,6 +135,9 @@ struct snd_pcm_ioplug_callback {
 	int (*stop)(snd_pcm_ioplug_t *io);
 	/**
 	 * get the current DMA position; required, called inside mutex lock
+	 * \return buffer position up to buffer_size or
+	 * when #SND_PCM_IOPLUG_FLAG_BOUNDARY_WA flag is set up to boundary or
+	 * a negative error code for Xrun
 	 */
 	snd_pcm_sframes_t (*pointer)(snd_pcm_ioplug_t *io);
 	/**
diff --git a/src/pcm/pcm_ioplug.c b/src/pcm/pcm_ioplug.c
index 7a782e6..9970646 100644
--- a/src/pcm/pcm_ioplug.c
+++ b/src/pcm/pcm_ioplug.c
@@ -42,7 +42,7 @@ const char *_snd_module_pcm_ioplug = "";
 typedef struct snd_pcm_ioplug_priv {
 	snd_pcm_ioplug_t *data;
 	struct snd_ext_parm params[SND_PCM_IOPLUG_HW_PARAMS];
-	unsigned int last_hw;
+	snd_pcm_uframes_t last_hw;
 	snd_pcm_uframes_t avail_max;
 	snd_htimestamp_t trigger_tstamp;
 } ioplug_priv_t;
@@ -56,13 +56,18 @@ static void snd_pcm_ioplug_hw_ptr_update(snd_pcm_t *pcm)
 
 	hw = io->data->callback->pointer(io->data);
 	if (hw >= 0) {
-		unsigned int delta;
-		if ((unsigned int)hw >= io->last_hw)
+		snd_pcm_uframes_t delta;
+
+		if ((snd_pcm_uframes_t)hw >= io->last_hw)
 			delta = hw - io->last_hw;
-		else
-			delta = pcm->buffer_size + hw - io->last_hw;
+		else {
+			const snd_pcm_uframes_t wrap_point =
+				(io->data->flags & SND_PCM_IOPLUG_FLAG_BOUNDARY_WA) ?
+					pcm->boundary : pcm->buffer_size;
+			delta = wrap_point + hw - io->last_hw;
+		}
 		snd_pcm_mmap_hw_forward(io->data->pcm, delta);
-		io->last_hw = hw;
+		io->last_hw = (snd_pcm_uframes_t)hw;
 	} else
 		io->data->state = SNDRV_PCM_STATE_XRUN;
 }
-- 
2.7.4
