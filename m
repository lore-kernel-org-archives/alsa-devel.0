From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/5] ALSA: seq: Drop unused 64bit division
	macros
Date: Wed,  1 Aug 2018 18:12:00 +0200
Message-ID: <20180801161200.3930-6-tiwai@suse.de>
References: <20180801161200.3930-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E7E272677DA
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2018 18:12:03 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 40810AF56
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2018 16:12:02 +0000 (UTC)
In-Reply-To: <20180801161200.3930-1-tiwai@suse.de>
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

The old ugly macros remained in the code without usage.
Rip them off.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_queue.h | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/sound/core/seq/seq_queue.h b/sound/core/seq/seq_queue.h
index 76db43b79a2b..e006fc8e3a36 100644
--- a/sound/core/seq/seq_queue.h
+++ b/sound/core/seq/seq_queue.h
@@ -109,28 +109,4 @@ int snd_seq_queue_is_used(int queueid, int client);
 
 int snd_seq_control_queue(struct snd_seq_event *ev, int atomic, int hop);
 
-/*
- * 64bit division - for sync stuff..
- */
-#if defined(i386) || defined(i486)
-
-#define udiv_qrnnd(q, r, n1, n0, d) \
-  __asm__ ("divl %4"		\
-	   : "=a" ((u32)(q)),	\
-	     "=d" ((u32)(r))	\
-	   : "0" ((u32)(n0)),	\
-	     "1" ((u32)(n1)),	\
-	     "rm" ((u32)(d)))
-
-#define u64_div(x,y,q) do {u32 __tmp; udiv_qrnnd(q, __tmp, (x)>>32, x, y);} while (0)
-#define u64_mod(x,y,r) do {u32 __tmp; udiv_qrnnd(__tmp, q, (x)>>32, x, y);} while (0)
-#define u64_divmod(x,y,q,r) udiv_qrnnd(q, r, (x)>>32, x, y)
-
-#else
-#define u64_div(x,y,q)	((q) = (u32)((u64)(x) / (u64)(y)))
-#define u64_mod(x,y,r)	((r) = (u32)((u64)(x) % (u64)(y)))
-#define u64_divmod(x,y,q,r) (u64_div(x,y,q), u64_mod(x,y,r))
-#endif
-
-
 #endif
-- 
2.18.0
