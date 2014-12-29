From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 9/9] ALSA: pcm: Replace custom ld2 function
	with __fls
Date: Mon, 29 Dec 2014 19:41:46 +0100
Message-ID: <1419878506-28684-9-git-send-email-lars@metafoo.de>
References: <1419878506-28684-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-184.synserver.de (smtp-out-184.synserver.de
 [212.40.185.184])
 by alsa0.perex.cz (Postfix) with ESMTP id B5928261A50
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 19:41:54 +0100 (CET)
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

__fls has the same semantics as ld2, so there is no need to re-implement it.
Furthermore a lot of architectures have custom implementations of __fls that
are able to use special hardware instructions to compute the result. This
makes the code slightly shorter and faster.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/pcm_params.h | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/include/sound/pcm_params.h b/include/sound/pcm_params.h
index c99e20b..3c45f39 100644
--- a/include/sound/pcm_params.h
+++ b/include/sound/pcm_params.h
@@ -38,31 +38,6 @@ int snd_pcm_hw_param_value(const struct snd_pcm_hw_params *params,
 #define MASK_OFS(i)	((i) >> 5)
 #define MASK_BIT(i)	(1U << ((i) & 31))
 
-static inline unsigned int ld2(u_int32_t v)
-{
-        unsigned r = 0;
-
-        if (v >= 0x10000) {
-                v >>= 16;
-                r += 16;
-        }
-        if (v >= 0x100) {
-                v >>= 8;
-                r += 8;
-        }
-        if (v >= 0x10) {
-                v >>= 4;
-                r += 4;
-        }
-        if (v >= 4) {
-                v >>= 2;
-                r += 2;
-        }
-        if (v >= 2)
-                r++;
-        return r;
-}
-
 static inline size_t snd_mask_sizeof(void)
 {
 	return sizeof(struct snd_mask);
@@ -102,7 +77,7 @@ static inline unsigned int snd_mask_max(const struct snd_mask *mask)
 	int i;
 	for (i = SNDRV_MASK_SIZE - 1; i >= 0; i--) {
 		if (mask->bits[i])
-			return ld2(mask->bits[i]) + (i << 5);
+			return __fls(mask->bits[i]) + (i << 5);
 	}
 	return 0;
 }
-- 
1.8.0
