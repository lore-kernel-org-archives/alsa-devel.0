From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: pcm: Avoid double hw_free calls at
	releasing a stream
Date: Tue, 29 Sep 2015 13:01:31 +0200
Message-ID: <1443524491-16341-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B6E026042B
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2015 13:01:33 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id ED67BABE8
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2015 11:01:31 +0000 (UTC)
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

snd_pcm_release_substream() always calls hw_free op when the stream
was opened.  This is superfluous in most cases because it's been
already released via explicit hw_free ioctl.  Although this double
call is usually OK as this callback should be written to be called
multiple times, it's better to avoid superfluous calls.

Reported-by: Vinod Koul <vinod.koul@intel.com>
Tested-by: Jeeja Kp <jeeja.kp@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 4863af5e7b26..139887011ba2 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2227,7 +2227,8 @@ void snd_pcm_release_substream(struct snd_pcm_substream *substream)
 
 	snd_pcm_drop(substream);
 	if (substream->hw_opened) {
-		if (substream->ops->hw_free != NULL)
+		if (substream->ops->hw_free &&
+		    substream->runtime->status->state != SNDRV_PCM_STATE_OPEN)
 			substream->ops->hw_free(substream);
 		substream->ops->close(substream);
 		substream->hw_opened = 0;
-- 
2.5.3
