From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH 2/4] pcm: remove unused macros of
	GETU_LABELS/GETU_END
Date: Thu, 21 Dec 2017 02:17:01 +0900
Message-ID: <20171220171703.10609-3-o-takashi@sakamocchi.jp>
References: <20171220171703.10609-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 165C42677EC
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

A commit 07c07da44f27 ("Fixed signess for route conversion") obsoletes
usage of a pair of GETU_LABEL/GETU_END, but it did not remove some
actual codes in 'src/pcm_plugin_ops.h'.

This commit removes them in a point to reduce the amount of code to
maintain.
---
 src/pcm/plugin_ops.h | 41 -----------------------------------------
 1 file changed, 41 deletions(-)

diff --git a/src/pcm/plugin_ops.h b/src/pcm/plugin_ops.h
index a0404909..1866d6d9 100644
--- a/src/pcm/plugin_ops.h
+++ b/src/pcm/plugin_ops.h
@@ -649,47 +649,6 @@ put32_1234_329_18: _put_triple_s(dst, (sample ^ 0x80000000) >> 14); goto PUT32_E
 #undef PUT32_END
 #endif
 
-#ifdef GETU_LABELS
-/* width endswap sign_toggle */
-static void *const getu_labels[4 * 2 * 2] = {
-	&&getu_1_1,		/*  8h ->  8h */
-	&&getu_1_9,		/*  8h ^>  8h */
-	&&getu_1_1,		/*  8s ->  8h */
-	&&getu_1_9,		/*  8s ^>  8h */
-	&&getu_12_12,		/* 16h -> 16h */
-	&&getu_12_92,		/* 16h ^> 16h */
-	&&getu_12_21,		/* 16s -> 16h */
-	&&getu_12_A1,		/* 16s ^> 16h */
-	&&getu_0123_0123,	/* 24h -> 24h */
-	&&getu_0123_0923,	/* 24h ^> 24h */
-	&&getu_1230_0321,	/* 24s -> 24h */
-	&&getu_1230_0B21,	/* 24s ^> 24h */
-	&&getu_1234_1234,	/* 32h -> 32h */
-	&&getu_1234_9234,	/* 32h ^> 32h */
-	&&getu_1234_4321,	/* 32s -> 32h */
-	&&getu_1234_C321,	/* 32s ^> 32h */
-};
-#endif
-
-#ifdef GETU_END
-while (0) {
-getu_1_1: sample = as_u8c(src); goto GETU_END;
-getu_1_9: sample = as_u8c(src) ^ 0x80; goto GETU_END;
-getu_12_12: sample = as_u16c(src); goto GETU_END;
-getu_12_92: sample = as_u16c(src) ^ 0x8000; goto GETU_END;
-getu_12_21: sample = bswap_16(as_u16c(src)); goto GETU_END;
-getu_12_A1: sample = bswap_16(as_u16c(src) ^ 0x80); goto GETU_END;
-getu_0123_0123: sample = sx24(as_u32c(src)); goto GETU_END;
-getu_0123_0923: sample = sx24(as_u32c(src) ^ 0x800000); goto GETU_END;
-getu_1230_0321: sample = sx24(bswap_32(as_u32c(src))); goto GETU_END;
-getu_1230_0B21: sample = sx24(bswap_32(as_u32c(src) ^ 0x8000)); goto GETU_END;
-getu_1234_1234: sample = as_u32c(src); goto GETU_END;
-getu_1234_9234: sample = as_u32c(src) ^ 0x80000000; goto GETU_END;
-getu_1234_4321: sample = bswap_32(as_u32c(src)); goto GETU_END;
-getu_1234_C321: sample = bswap_32(as_u32c(src) ^ 0x80); goto GETU_END;
-}
-#endif
-
 #ifdef PUT32F_LABELS
 /* type (0 = float, 1 = float64), endswap */
 static void *const put32float_labels[2 * 2] = {
-- 
2.14.1
