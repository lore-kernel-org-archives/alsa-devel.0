From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: usb-audio: ignore delay calculation
	for capture stream
Date: Fri, 23 Nov 2012 16:21:47 +0100
Message-ID: <1353684108-16669-2-git-send-email-tiwai@suse.de>
References: <1353684108-16669-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DE08261722
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2012 16:21:56 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 14B5BA30ED
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2012 16:21:56 +0100 (CET)
In-Reply-To: <1353684108-16669-1-git-send-email-tiwai@suse.de>
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

It doesn't make sense to calculate the delay for capture streams in
the current implementation.  It's always zero, so we should skip the
computation in snd_usb_pcm_pointer() in the case of capture.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index e919c2e..8e1d5e0 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -75,7 +75,8 @@ static snd_pcm_uframes_t snd_usb_pcm_pointer(struct snd_pcm_substream *substream
 		return SNDRV_PCM_POS_XRUN;
 	spin_lock(&subs->lock);
 	hwptr_done = subs->hwptr_done;
-	substream->runtime->delay = snd_usb_pcm_delay(subs,
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		substream->runtime->delay = snd_usb_pcm_delay(subs,
 						substream->runtime->rate);
 	spin_unlock(&subs->lock);
 	return hwptr_done / (substream->runtime->frame_bits >> 3);
-- 
1.8.0
