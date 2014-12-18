From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: pcm: Don't leave PREPARED state after
	draining
Date: Thu, 18 Dec 2014 10:07:19 +0100
Message-ID: <1418893639-2190-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CB07261685
 for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2014 10:07:22 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 3009FAD9F
 for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2014 09:07:22 +0000 (UTC)
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

When a PCM draining is performed to an empty stream that has been
already in PREPARED state, the current code just ignores and leaves as
it is, although the drain is supposed to set all such streams to SETUP
state.  This patch covers that overlooked case.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 095d9572ad2b..64d9863d6565 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1546,6 +1546,8 @@ static int snd_pcm_do_drain_init(struct snd_pcm_substream *substream, int state)
 			if (! snd_pcm_playback_empty(substream)) {
 				snd_pcm_do_start(substream, SNDRV_PCM_STATE_DRAINING);
 				snd_pcm_post_start(substream, SNDRV_PCM_STATE_DRAINING);
+			} else {
+				runtime->status->state = SNDRV_PCM_STATE_SETUP;
 			}
 			break;
 		case SNDRV_PCM_STATE_RUNNING:
-- 
2.2.0
