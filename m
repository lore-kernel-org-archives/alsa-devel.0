From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/6] ALSA: pcm: Clean up SNDRV_PCM_IOCTL_PAUSE
	code
Date: Tue, 13 Jun 2017 16:18:07 +0200
Message-ID: <20170613141812.21220-2-tiwai@suse.de>
References: <20170613141812.21220-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EA2C8266D55
 for <alsa-devel@alsa-project.org>; Tue, 13 Jun 2017 16:18:14 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 2EAA4AE86
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

Use snd_pcm_action_lock_irq() helper instead of open coding.
No functional change.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 07995e645327..798bca967c0e 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2865,13 +2865,9 @@ static int snd_pcm_common_ioctl1(struct file *file,
 	case SNDRV_PCM_IOCTL_DROP:
 		return snd_pcm_drop(substream);
 	case SNDRV_PCM_IOCTL_PAUSE:
-	{
-		int res;
-		snd_pcm_stream_lock_irq(substream);
-		res = snd_pcm_pause(substream, (int)(unsigned long)arg);
-		snd_pcm_stream_unlock_irq(substream);
-		return res;
-	}
+		return snd_pcm_action_lock_irq(&snd_pcm_action_pause,
+					       substream,
+					       (int)(unsigned long)arg);
 	}
 	pcm_dbg(substream->pcm, "unknown ioctl = 0x%x\n", cmd);
 	return -ENOTTY;
-- 
2.13.1
