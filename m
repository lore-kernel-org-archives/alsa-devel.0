From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: aloop: Fix access to not-yet-ready
	substream via cable
Date: Thu, 22 Mar 2018 14:29:58 +0100
Message-ID: <20180322132958.29481-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C7EC226738C
 for <alsa-devel@alsa-project.org>; Thu, 22 Mar 2018 14:30:00 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0B9AFACC3
 for <alsa-devel@alsa-project.org>; Thu, 22 Mar 2018 13:30:00 +0000 (UTC)
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

In loopback_open() and loopback_close(), we assign and release the
substream object to the corresponding cable in a racy way.  It's
neither locked nor done in the right position.  The open callback
assigns the substream before its preparation finishes, hence the other
side of the cable may pick it up, which may lead to the invalid memory
access.

This patch addresses these: move the assignment to the end of the open
callback, and wrap with cable->lock for avoiding concurrent accesses.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/aloop.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 0a08e63e9c66..1063a4377502 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -666,7 +666,9 @@ static void free_cable(struct snd_pcm_substream *substream)
 		return;
 	if (cable->streams[!substream->stream]) {
 		/* other stream is still alive */
+		spin_lock_irq(&cable->lock);
 		cable->streams[substream->stream] = NULL;
+		spin_unlock_irq(&cable->lock);
 	} else {
 		/* free the cable */
 		loopback->cables[substream->number][dev] = NULL;
@@ -705,7 +707,6 @@ static int loopback_open(struct snd_pcm_substream *substream)
 		loopback->cables[substream->number][dev] = cable;
 	}
 	dpcm->cable = cable;
-	cable->streams[substream->stream] = dpcm;
 
 	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
 
@@ -737,6 +738,11 @@ static int loopback_open(struct snd_pcm_substream *substream)
 		runtime->hw = loopback_pcm_hardware;
 	else
 		runtime->hw = cable->hw;
+
+	spin_lock_irq(&cable->lock);
+	cable->streams[substream->stream] = dpcm;
+	spin_unlock_irq(&cable->lock);
+
  unlock:
 	if (err < 0) {
 		free_cable(substream);
-- 
2.16.2
