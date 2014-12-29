From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/9] ALSA: pcm_params: Remove unused add/sub
	functions
Date: Mon, 29 Dec 2014 19:41:38 +0100
Message-ID: <1419878506-28684-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-184.synserver.de (smtp-out-184.synserver.de
 [212.40.185.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 457802605BF
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 19:41:50 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Those two functions are not used anywhere and also their name is a bit to
generic to be in a global header, so remove them.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/pcm_params.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/sound/pcm_params.h b/include/sound/pcm_params.h
index 6b1c78f..15760f5 100644
--- a/include/sound/pcm_params.h
+++ b/include/sound/pcm_params.h
@@ -325,20 +325,6 @@ static inline int snd_interval_eq(const struct snd_interval *i1, const struct sn
 		i1->max == i2->max && i1->openmax == i2->openmax;
 }
 
-static inline unsigned int add(unsigned int a, unsigned int b)
-{
-	if (a >= UINT_MAX - b)
-		return UINT_MAX;
-	return a + b;
-}
-
-static inline unsigned int sub(unsigned int a, unsigned int b)
-{
-	if (a > b)
-		return a - b;
-	return 0;
-}
-
 #define params_access(p) ((__force snd_pcm_access_t)\
 		snd_mask_min(hw_param_mask_c((p), SNDRV_PCM_HW_PARAM_ACCESS)))
 #define params_format(p) ((__force snd_pcm_format_t)\
-- 
1.8.0
