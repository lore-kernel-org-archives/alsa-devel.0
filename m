From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 14/14] ALSA: pcm: Make snd_pcm_suspend() local
	static
Date: Tue, 15 Jan 2019 17:21:55 +0100
Message-ID: <20190115162155.6308-15-tiwai@suse.de>
References: <20190115162155.6308-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CE6B267465
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 17:21:58 +0100 (CET)
In-Reply-To: <20190115162155.6308-1-tiwai@suse.de>
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
Cc: Libin Yang <libin.yang@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

snd_pcm_suspend() is no longer called from outside, so let's make it
local static.  Also drop a superfluous NULL check there.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/pcm.h     |  5 -----
 sound/core/pcm_native.c | 11 +++--------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 04e97564949c..2c30c1ad1b0d 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -582,13 +582,8 @@ int snd_pcm_stop(struct snd_pcm_substream *substream, snd_pcm_state_t status);
 int snd_pcm_drain_done(struct snd_pcm_substream *substream);
 int snd_pcm_stop_xrun(struct snd_pcm_substream *substream);
 #ifdef CONFIG_PM
-int snd_pcm_suspend(struct snd_pcm_substream *substream);
 int snd_pcm_suspend_all(struct snd_pcm *pcm);
 #else
-static inline int snd_pcm_suspend(struct snd_pcm_substream *substream)
-{
-	return 0;
-}
 static inline int snd_pcm_suspend_all(struct snd_pcm *pcm)
 {
 	return 0;
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 818dff1de545..26afb6b0889a 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1460,29 +1460,24 @@ static const struct action_ops snd_pcm_action_suspend = {
 	.post_action = snd_pcm_post_suspend
 };
 
-/**
+/*
  * snd_pcm_suspend - trigger SUSPEND to all linked streams
  * @substream: the PCM substream
  *
  * After this call, all streams are changed to SUSPENDED state.
  *
- * Return: Zero if successful (or @substream is %NULL), or a negative error
- * code.
+ * Return: Zero if successful, or a negative error code.
  */
-int snd_pcm_suspend(struct snd_pcm_substream *substream)
+static int snd_pcm_suspend(struct snd_pcm_substream *substream)
 {
 	int err;
 	unsigned long flags;
 
-	if (! substream)
-		return 0;
-
 	snd_pcm_stream_lock_irqsave(substream, flags);
 	err = snd_pcm_action(&snd_pcm_action_suspend, substream, 0);
 	snd_pcm_stream_unlock_irqrestore(substream, flags);
 	return err;
 }
-EXPORT_SYMBOL(snd_pcm_suspend);
 
 /**
  * snd_pcm_suspend_all - trigger SUSPEND to all substreams in the given pcm
-- 
2.20.1
