From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] ALSA: pcm: simplify snd_pcm_tstamp()
Date: Thu, 10 Jul 2014 15:04:16 +0200
Message-ID: <1404997458-15377-2-git-send-email-tiwai@suse.de>
References: <1404997458-15377-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A3EEF260786
 for <alsa-devel@alsa-project.org>; Thu, 10 Jul 2014 15:04:22 +0200 (CEST)
In-Reply-To: <1404997458-15377-1-git-send-email-tiwai@suse.de>
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
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Mark Brown <broonie@kernel.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

No functional change.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index b653ab001fba..2372c49a8e84 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2540,9 +2540,7 @@ static int snd_pcm_tstamp(struct snd_pcm_substream *substream, int __user *_arg)
 		return -EFAULT;
 	if (arg < 0 || arg > SNDRV_PCM_TSTAMP_TYPE_LAST)
 		return -EINVAL;
-	runtime->tstamp_type = SNDRV_PCM_TSTAMP_TYPE_GETTIMEOFDAY;
-	if (arg == SNDRV_PCM_TSTAMP_TYPE_MONOTONIC)
-		runtime->tstamp_type = SNDRV_PCM_TSTAMP_TYPE_MONOTONIC;
+	runtime->tstamp_type = arg;
 	return 0;
 }
 		
-- 
2.0.1
