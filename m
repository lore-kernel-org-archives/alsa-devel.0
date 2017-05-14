From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH RFC 05/21] ALSA: pcm: enable parameter
	tracepoints at CONFIG_SND_DEBUG only
Date: Sun, 14 May 2017 17:57:40 +0900
Message-ID: <20170514085756.22382-6-o-takashi@sakamocchi.jp>
References: <20170514085756.22382-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 74A52266943
 for <alsa-devel@alsa-project.org>; Sun, 14 May 2017 10:58:04 +0200 (CEST)
In-Reply-To: <20170514085756.22382-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, lars@metafoo.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In a previous commit, tracepoints are added for PCM parameter processing.
As long as I know, this implementation increases size of relocatable
object by 135%. For vendors who are conscious of memory footprint, it
brings apparent disadvantage.

This commit uses CONFIG_SND_DEBUG option to enable/disable the
tracepoints.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_native.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 5a2703e..3fd2a63 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -37,7 +37,9 @@
 #include <sound/minors.h>
 #include <linux/uio.h>
 
+#ifdef CONFIG_SND_DEBUG
 #define CREATE_TRACE_POINTS
+#endif
 #include "pcm_params_trace.h"
 
 /*
-- 
2.9.3
