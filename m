From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 01/29] mixer: include library local header to
	find layout of structures
Date: Fri, 15 Jul 2016 09:23:05 +0900
Message-ID: <1468542213-24880-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1468542213-24880-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 352F32658D8
 for <alsa-devel@alsa-project.org>; Fri, 15 Jul 2016 02:23:38 +0200 (CEST)
In-Reply-To: <1468542213-24880-1-git-send-email-o-takashi@sakamocchi.jp>
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

Inner this library, implementation of each features can find actual layout
of structures by including local header. Although, mixer feature is written
without the header and as the same way for applications. This brings some
inefficiencies such as usage of alloca() to keep memory objects for the
structures.

This commit includes the header for further improvements in mixer
feature.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/mixer/simple_none.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/mixer/simple_none.c b/src/mixer/simple_none.c
index 4e55660..1d2112d 100644
--- a/src/mixer/simple_none.c
+++ b/src/mixer/simple_none.c
@@ -38,7 +38,7 @@
 #include <assert.h>
 #include <math.h>
 #include <limits.h>
-#include <alsa/asoundlib.h>
+#include "local.h"
 #include "config.h"
 #include "mixer_simple.h"
 
-- 
2.7.4
