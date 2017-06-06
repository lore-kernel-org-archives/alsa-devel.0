From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/3] ALSA: pcm: enable parameter tracepoints
	only when CONFIG_SND_DEBUG is enabled
Date: Wed,  7 Jun 2017 08:46:44 +0900
Message-ID: <20170606234645.13775-3-o-takashi@sakamocchi.jp>
References: <20170606234645.13775-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id EE8D626681D
 for <alsa-devel@alsa-project.org>; Wed,  7 Jun 2017 01:46:50 +0200 (CEST)
In-Reply-To: <20170606234645.13775-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In a previous commit, tracepoints are added for PCM parameter processing.
As long as I know, this implementation increases size of relocatable
object by 35%. For vendors who are conscious of memory footprint, it
brings apparent disadvantage.

This commit utilizes CONFIG_SND_DEBUG configuration to enable/disable the
tracepoints.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_native.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index b98b3ccde4f0..2ce3c98a1418 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -39,8 +39,15 @@
 
 #include "pcm_local.h"
 
+#ifdef CONFIG_SND_DEBUG
 #define CREATE_TRACE_POINTS
 #include "pcm_param_trace.h"
+#else
+#define trace_hw_mask_param_enabled()		0
+#define trace_hw_interval_param_enabled()	0
+#define trace_hw_mask_param(substream, type, index, prev, curr)
+#define trace_hw_interval_param(substream, type, index, prev, curr)
+#endif
 
 /*
  *  Compatibility
-- 
2.11.0
