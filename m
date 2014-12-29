From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 7/9] ALSA: pcm: Use __ffs() instead of ffs() in
	snd_mask_min()
Date: Mon, 29 Dec 2014 19:41:44 +0100
Message-ID: <1419878506-28684-7-git-send-email-lars@metafoo.de>
References: <1419878506-28684-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-184.synserver.de (smtp-out-184.synserver.de
 [212.40.185.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 7ED60261685
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 19:41:53 +0100 (CET)
In-Reply-To: <1419878506-28684-1-git-send-email-lars@metafoo.de>
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

The difference between __ffs and ffs is that ffs will return a one based
index whereas __ffs will return a zero based index. Furthermore ffs will
check if the passed value is zero and return zero in that case, whereas
__ffs behavior is undefined if the passed parameter is 0.

Since we already check if the mask is 0 before calling ffs and also subtract
1 from the result __ffs is the better choice.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/pcm_params.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/pcm_params.h b/include/sound/pcm_params.h
index 042049b..c99e20b 100644
--- a/include/sound/pcm_params.h
+++ b/include/sound/pcm_params.h
@@ -92,7 +92,7 @@ static inline unsigned int snd_mask_min(const struct snd_mask *mask)
 	int i;
 	for (i = 0; i < SNDRV_MASK_SIZE; i++) {
 		if (mask->bits[i])
-			return ffs(mask->bits[i]) - 1 + (i << 5);
+			return __ffs(mask->bits[i]) + (i << 5);
 	}
 	return 0;
 }
-- 
1.8.0
