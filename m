From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH 3/4] pcm: remove unused macros of
	NORMS_LABELS/NORMS_END
Date: Thu, 21 Dec 2017 02:17:02 +0900
Message-ID: <20171220171703.10609-4-o-takashi@sakamocchi.jp>
References: <20171220171703.10609-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 182D2267825
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

A commit fcd164e6229c ("Permit to PCM plug configuration to specify unchanged
parameters. Added support for RT signals to async interface. Added ops for
PCM mix.") added a pair of NORMS_LABELS/NORMS_END, however they have been
no longer used.

This commit removes them in a point to reduce the amount of code to
maintain.
---
 src/pcm/plugin_ops.h | 264 ---------------------------------------------------
 1 file changed, 264 deletions(-)

diff --git a/src/pcm/plugin_ops.h b/src/pcm/plugin_ops.h
index 1866d6d9..63e3c827 100644
--- a/src/pcm/plugin_ops.h
+++ b/src/pcm/plugin_ops.h
@@ -713,270 +713,6 @@ get32f_4321D_1234: tmp_double.l = bswap_64(as_u64c(src));
 		   goto GET32F_END;
 #endif
 
-#ifdef NORMS_LABELS
-static inline void _norms(const void *src, void *dst,
-			  int src_wid,
-			  int dst_sign, int dst_wid, int dst_end)
-{
-	int32_t s;
-	switch (src_wid) {
-	case 8:
-		s = *(int32_t*)src;
-		if (s >= 0x7f)
-			goto _max;
-		else if (s <= -0x80)
-			goto _min;
-		break;
-	case 16:
-		s = *(int32_t*)src;
-		if (s >= 0x7fff)
-			goto _max;
-		else if (s <= -0x8000)
-			goto _min;
-		break;
-	case 24:
-		s = *(int32_t*)src;
-		if (s >= 0x7fffff)
-			goto _max;
-		else if (s <= -0x800000)
-			goto _min;
-		break;
-	case 32:
-	{
-		int64_t s64;
-		s64 = *(int64_t*)src;
-		if (s64 >= 0x7fffffff)
-			goto _max;
-		else if (s64 <= -0x80000000)
-			goto _min;
-		s = s64;
-		break;
-	}
-	default:
-		assert(0);
-		return;
-	}
-	if (src_wid < dst_wid) {
-		unsigned int bits = dst_wid - src_wid;
-		s *= 1 << bits;
-	} else if (src_wid > dst_wid) {
-		unsigned int bits = src_wid - dst_wid;
-		s = (s + (1 << (bits - 1))) / (1 << bits);
-	}
-	if (!dst_sign)
-		s += (1U << (dst_wid - 1));
-	switch (dst_wid) {
-	case 8:
-		*(uint8_t*)dst = s;
-		break;
-	case 16:
-		if (dst_end)
-			s = bswap_16(s);
-		*(uint16_t*)dst = s;
-		break;
-	case 24:
-	case 32:
-		if (dst_end)
-			s = bswap_32(s);
-		*(uint32_t*)dst = s;
-		break;
-	}
-	return;
-
- _min:
-	switch (dst_wid) {
-	case 8:
-		if (dst_sign)
-			*(uint8_t*)dst = 0x80;
-		else
-			*(uint8_t*)dst = 0;
-		break;
-	case 16:
-		if (dst_sign)
-			*(uint16_t*)dst = dst_end ? 0x0080 : 0x8000;
-		else
-			*(uint16_t*)dst = 0;
-		break;
-	case 24:
-		if (dst_sign)
-			*(uint32_t*)dst = dst_end ? 0x00008000 : 0x00800000;
-		else
-			*(uint32_t*)dst = 0;
-		break;
-	case 32:
-		if (dst_sign)
-			*(uint32_t*)dst = dst_end ? 0x00000080 : 0x80000000;
-		else
-			*(uint32_t*)dst = 0;
-		break;
-	default:
-		assert(0);
-		break;
-	}
-	return;
-
- _max:
-	switch (dst_wid) {
-	case 8:
-		if (dst_sign)
-			*(uint8_t*)dst = 0x7f;
-		else
-			*(uint8_t*)dst = 0xff;
-		break;
-	case 16:
-		if (dst_sign)
-			*(uint16_t*)dst = dst_end ? 0xff7f : 0x7fff;
-		else
-			*(uint16_t*)dst = 0;
-		break;
-	case 24:
-		if (dst_sign)
-			*(uint32_t*)dst = dst_end ? 0xffff7f00 : 0x007fffff;
-		else
-			*(uint32_t*)dst = 0;
-		break;
-	case 32:
-		if (dst_sign)
-			*(uint32_t*)dst = dst_end ? 0xffffff7f : 0x7fffffff;
-		else
-			*(uint32_t*)dst = 0;
-		break;
-	default:
-		assert(0);
-		break;
-	}
-	return;
-}
-
-/* src_wid dst_sign dst_wid dst_end */
-static void *const norms_labels[4 * 2 * 4 * 2] = {
-	&&norms_8_u8,	        /*  s8 -> u8 */
-	&&norms_8_u8,	        /*  s8 -> u8 */
-	&&norms_8_u16h,	        /*  s8 -> u16h */
-	&&norms_8_u16s,	        /*  s8 -> u16s */
-	&&norms_8_u24h,	        /*  s8 -> u24h */
-	&&norms_8_u24s,	        /*  s8 -> u24s */
-	&&norms_8_u32h,	        /*  s8 -> u32h */
-	&&norms_8_u32s,	        /*  s8 -> u32s */
-	&&norms_8_s8,	        /*  s8 -> s8 */
-	&&norms_8_s8,	        /*  s8 -> s8 */
-	&&norms_8_s16h,	        /*  s8 -> s16h */
-	&&norms_8_s16s,	        /*  s8 -> s16s */
-	&&norms_8_s24h,	        /*  s8 -> s24h */
-	&&norms_8_s24s,	        /*  s8 -> s24s */
-	&&norms_8_s32h,	        /*  s8 -> s32h */
-	&&norms_8_s32s,	        /*  s8 -> s32s */
-	&&norms_16_u8,	        /* s16 -> u8 */
-	&&norms_16_u8,	        /* s16 -> u8 */
-	&&norms_16_u16h,	/* s16 -> u16h */
-	&&norms_16_u16s,	/* s16 -> u16s */
-	&&norms_16_u24h,	/* s16 -> u24h */
-	&&norms_16_u24s,	/* s16 -> u24s */
-	&&norms_16_u32h,	/* s16 -> u32h */
-	&&norms_16_u32s,	/* s16 -> u32s */
-	&&norms_16_s8,		/* s16 -> s8 h*/
-	&&norms_16_s8,		/* s16 -> s8 */
-	&&norms_16_s16h,	/* s16 -> s16h */
-	&&norms_16_s16s,	/* s16 -> s16s */
-	&&norms_16_s24h,	/* s16 -> s24h */
-	&&norms_16_s24s,	/* s16 -> s24s */
-	&&norms_16_s32h,	/* s16 -> s32h */
-	&&norms_16_s32s,	/* s16 -> s32s */
-	&&norms_24_u8,		/* s24 -> u8 */
-	&&norms_24_u8,		/* s24 -> u8 */
-	&&norms_24_u16h,	/* s24 -> u16h */
-	&&norms_24_u16s,	/* s24 -> u16s */
-	&&norms_24_u24h,	/* s24 -> u24h */
-	&&norms_24_u24s,	/* s24 -> u24s */
-	&&norms_24_u32h,	/* s24 -> u32h */
-	&&norms_24_u32s,	/* s24 -> u32s */
-	&&norms_24_s8,		/* s24 -> s8 */
-	&&norms_24_s8,		/* s24 -> s8 */
-	&&norms_24_s16h,	/* s24 -> s16h */
-	&&norms_24_s16s,	/* s24 -> s16s */
-	&&norms_24_s24h,	/* s24 -> s24h */
-	&&norms_24_s24s,	/* s24 -> s24s */
-	&&norms_24_s32h,	/* s24 -> s32h */
-	&&norms_24_s32s,	/* s24 -> s32s */
-	&&norms_32_u8,		/* s32 -> u8 */
-	&&norms_32_u8,		/* s32 -> u8 */
-	&&norms_32_u16h,	/* s32 -> u16h */
-	&&norms_32_u16s,	/* s32 -> u16s */
-	&&norms_32_u24h,	/* s32 -> u24h */
-	&&norms_32_u24s,	/* s32 -> u24s */
-	&&norms_32_u32h,	/* s32 -> u32h */
-	&&norms_32_u32s,	/* s32 -> u32s */
-	&&norms_32_s8,		/* s32 -> s8 */
-	&&norms_32_s8,		/* s32 -> s8 */
-	&&norms_32_s16h,	/* s32 -> s16h */
-	&&norms_32_s16s,	/* s32 -> s16s */
-	&&norms_32_s24h,	/* s32 -> s24h */
-	&&norms_32_s24s,	/* s32 -> s24s */
-	&&norms_32_s32h,	/* s32 -> s32h */
-	&&norms_32_s32s,	/* s32 -> s32s */
-};
-#endif
-
-#ifdef NORMS_END
-norms_8_u8:	_norms(src, dst,  8, 0,  8, 0); goto NORMS_END;
-norms_8_u16h:	_norms(src, dst,  8, 0,  16, 0); goto NORMS_END;
-norms_8_u16s:	_norms(src, dst,  8, 0,  16, 1); goto NORMS_END;
-norms_8_u24h:	_norms(src, dst,  8, 0,  24, 0); goto NORMS_END;
-norms_8_u24s:	_norms(src, dst,  8, 0,  24, 1); goto NORMS_END;
-norms_8_u32h:	_norms(src, dst,  8, 0,  32, 0); goto NORMS_END;
-norms_8_u32s:	_norms(src, dst,  8, 0,  32, 1); goto NORMS_END;
-norms_8_s8:	_norms(src, dst,  8, 1,  8, 0); goto NORMS_END;
-norms_8_s16h:	_norms(src, dst,  8, 1,  16, 0); goto NORMS_END;
-norms_8_s16s:	_norms(src, dst,  8, 1,  16, 1); goto NORMS_END;
-norms_8_s24h:	_norms(src, dst,  8, 1,  24, 0); goto NORMS_END;
-norms_8_s24s:	_norms(src, dst,  8, 1,  24, 1); goto NORMS_END;
-norms_8_s32h:	_norms(src, dst,  8, 1,  32, 0); goto NORMS_END;
-norms_8_s32s:	_norms(src, dst,  8, 1,  32, 1); goto NORMS_END;
-norms_16_u8:	_norms(src, dst, 16, 0,  8, 0); goto NORMS_END;
-norms_16_u16h:	_norms(src, dst, 16, 0,  16, 0); goto NORMS_END;
-norms_16_u16s:	_norms(src, dst, 16, 0,  16, 1); goto NORMS_END;
-norms_16_u24h:	_norms(src, dst, 16, 0,  24, 0); goto NORMS_END;
-norms_16_u24s:	_norms(src, dst, 16, 0,  24, 1); goto NORMS_END;
-norms_16_u32h:	_norms(src, dst, 16, 0,  32, 0); goto NORMS_END;
-norms_16_u32s:	_norms(src, dst, 16, 0,  32, 1); goto NORMS_END;
-norms_16_s8:	_norms(src, dst, 16, 1,  8, 0); goto NORMS_END;
-norms_16_s16h:	_norms(src, dst, 16, 1,  16, 0); goto NORMS_END;
-norms_16_s16s:	_norms(src, dst, 16, 1,  16, 1); goto NORMS_END;
-norms_16_s24h:	_norms(src, dst, 16, 1,  24, 0); goto NORMS_END;
-norms_16_s24s:	_norms(src, dst, 16, 1,  24, 1); goto NORMS_END;
-norms_16_s32h:	_norms(src, dst, 16, 1,  32, 0); goto NORMS_END;
-norms_16_s32s:	_norms(src, dst, 16, 1,  32, 1); goto NORMS_END;
-norms_24_u8:	_norms(src, dst, 24, 0,  8, 0); goto NORMS_END;
-norms_24_u16h:	_norms(src, dst, 24, 0,  16, 0); goto NORMS_END;
-norms_24_u16s:	_norms(src, dst, 24, 0,  16, 1); goto NORMS_END;
-norms_24_u24h:	_norms(src, dst, 24, 0,  24, 0); goto NORMS_END;
-norms_24_u24s:	_norms(src, dst, 24, 0,  24, 1); goto NORMS_END;
-norms_24_u32h:	_norms(src, dst, 24, 0,  32, 0); goto NORMS_END;
-norms_24_u32s:	_norms(src, dst, 24, 0,  32, 1); goto NORMS_END;
-norms_24_s8:	_norms(src, dst, 24, 1,  8, 0); goto NORMS_END;
-norms_24_s16h:	_norms(src, dst, 24, 1,  16, 0); goto NORMS_END;
-norms_24_s16s:	_norms(src, dst, 24, 1,  16, 1); goto NORMS_END;
-norms_24_s24h:	_norms(src, dst, 24, 1,  24, 0); goto NORMS_END;
-norms_24_s24s:	_norms(src, dst, 24, 1,  24, 1); goto NORMS_END;
-norms_24_s32h:	_norms(src, dst, 24, 1,  32, 0); goto NORMS_END;
-norms_24_s32s:	_norms(src, dst, 24, 1,  32, 1); goto NORMS_END;
-norms_32_u8:	_norms(src, dst, 32, 0,  8, 0); goto NORMS_END;
-norms_32_u16h:	_norms(src, dst, 32, 0,  16, 0); goto NORMS_END;
-norms_32_u16s:	_norms(src, dst, 32, 0,  16, 1); goto NORMS_END;
-norms_32_u24h:	_norms(src, dst, 32, 0,  24, 0); goto NORMS_END;
-norms_32_u24s:	_norms(src, dst, 32, 0,  24, 1); goto NORMS_END;
-norms_32_u32h:	_norms(src, dst, 32, 0,  32, 0); goto NORMS_END;
-norms_32_u32s:	_norms(src, dst, 32, 0,  32, 1); goto NORMS_END;
-norms_32_s8:	_norms(src, dst, 32, 1,  8, 0); goto NORMS_END;
-norms_32_s16h:	_norms(src, dst, 32, 1,  16, 0); goto NORMS_END;
-norms_32_s16s:	_norms(src, dst, 32, 1,  16, 1); goto NORMS_END;
-norms_32_s24h:	_norms(src, dst, 32, 1,  24, 0); goto NORMS_END;
-norms_32_s24s:	_norms(src, dst, 32, 1,  24, 1); goto NORMS_END;
-norms_32_s32h:	_norms(src, dst, 32, 1,  32, 0); goto NORMS_END;
-norms_32_s32s:	_norms(src, dst, 32, 1,  32, 1); goto NORMS_END;
-#endif
-
-
 #undef as_u8
 #undef as_u16
 #undef as_u32
-- 
2.14.1
