From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH 1/4] pcm: remove unused macros of
	COPY_LABELS/COPY_END
Date: Thu, 21 Dec 2017 02:17:00 +0900
Message-ID: <20171220171703.10609-2-o-takashi@sakamocchi.jp>
References: <20171220171703.10609-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 167C8267822
 for <alsa-devel@alsa-project.org>; Wed, 20 Dec 2017 18:17:09 +0100 (CET)
In-Reply-To: <20171220171703.10609-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

A commit 7b054f4dce56 obsoleted usage of a pair of COPY_LABELS/COPY_END,
however it did not remove some codes in 'src/pcm/plugin_ops.h'.

This commit removes them in a point to reduce the amount of code to
maintain.
---
 src/pcm/plugin_ops.h | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/src/pcm/plugin_ops.h b/src/pcm/plugin_ops.h
index a784d9c2..a0404909 100644
--- a/src/pcm/plugin_ops.h
+++ b/src/pcm/plugin_ops.h
@@ -92,26 +92,6 @@ static inline uint32_t sx24s(uint32_t x)
 #define _put_triple_s(ptr,val) _put_triple_le(ptr,val)
 #endif
 
-#ifdef COPY_LABELS
-static void *copy_labels[5] = {
-	&&copy_8,
-	&&copy_16,
-	&&copy_24
-	&&copy_32,
-	&&copy_64
-};
-#endif
-
-#ifdef COPY_END
-while(0) {
-copy_8: as_s8(dst) = as_s8c(src); goto COPY_END;
-copy_16: as_s16(dst) = as_s16c(src); goto COPY_END;
-copy_24: memcpy(dst,src,3); goto COPY_END;
-copy_32: as_s32(dst) = as_s32c(src); goto COPY_END;
-copy_64: as_s64(dst) = as_s64c(src); goto COPY_END;
-}
-#endif
-
 #ifdef CONV_LABELS
 /* src_wid src_endswap sign_toggle dst_wid dst_endswap */
 static void *const conv_labels[4 * 2 * 2 * 4 * 2] = {
-- 
2.14.1
