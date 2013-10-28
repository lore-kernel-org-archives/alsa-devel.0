From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/6] ALSA: pcm: Add fallthru comments
Date: Mon, 28 Oct 2013 14:14:09 +0100
Message-ID: <1382966050-12752-6-git-send-email-tiwai@suse.de>
References: <1382966050-12752-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B4B12615F3
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2013 14:11:34 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A5EE2A5D7F
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2013 14:11:31 +0100 (CET)
In-Reply-To: <1382966050-12752-1-git-send-email-tiwai@suse.de>
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

Just to improve readability.
Spotted by coverity CID 115002 and 115003.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index b71be57..01a5e05 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2428,6 +2428,7 @@ static int snd_pcm_hwsync(struct snd_pcm_substream *substream)
 	case SNDRV_PCM_STATE_DRAINING:
 		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
 			goto __badfd;
+		/* Fall through */
 	case SNDRV_PCM_STATE_RUNNING:
 		if ((err = snd_pcm_update_hw_ptr(substream)) < 0)
 			break;
@@ -2460,6 +2461,7 @@ static int snd_pcm_delay(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_STATE_DRAINING:
 		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
 			goto __badfd;
+		/* Fall through */
 	case SNDRV_PCM_STATE_RUNNING:
 		if ((err = snd_pcm_update_hw_ptr(substream)) < 0)
 			break;
-- 
1.8.4.1
