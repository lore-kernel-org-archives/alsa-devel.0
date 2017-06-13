From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/6] ALSA: pcm: Preprocess PAUSED or SUSPENDED
	stream before PREPARE
Date: Tue, 13 Jun 2017 16:18:10 +0200
Message-ID: <20170613141812.21220-5-tiwai@suse.de>
References: <20170613141812.21220-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E7DCA266C25
 for <alsa-devel@alsa-project.org>; Tue, 13 Jun 2017 16:18:14 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 30FA6AE87
 for <alsa-devel@alsa-project.org>; Tue, 13 Jun 2017 14:18:14 +0000 (UTC)
In-Reply-To: <20170613141812.21220-1-tiwai@suse.de>
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

Calling PREPARE ioctl to the stream in either PAUSED or SUSPENDED
state may confuse some drivers that don't handle the state properly.
Instead of fixing each driver, PCM core should take care of the proper
state change before actually trying to (re-)prepare the stream.
Namely, when the stream is in PAUSED state, it triggers PAUSH_RELEASE,
and when in SUSPENDED state, it triggers STOP, before calling prepare
callbacks.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 69cf9b02ac70..0941b9c92b3f 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1684,6 +1684,17 @@ static int snd_pcm_prepare(struct snd_pcm_substream *substream,
 	else
 		f_flags = substream->f_flags;
 
+	snd_pcm_stream_lock_irq(substream);
+	switch (substream->runtime->status->state) {
+	case SNDRV_PCM_STATE_PAUSED:
+		snd_pcm_pause(substream, 0);
+		/* fallthru */
+	case SNDRV_PCM_STATE_SUSPENDED:
+		snd_pcm_stop(substream, SNDRV_PCM_STATE_SETUP);
+		break;
+	}
+	snd_pcm_stream_unlock_irq(substream);
+
 	return snd_pcm_action_nonatomic(&snd_pcm_action_prepare,
 					substream, f_flags);
 }
-- 
2.13.1
