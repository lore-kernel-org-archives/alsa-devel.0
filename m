From: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: [PATCH] pcm: pcm_local.h: include <time.h> to enable
	CLOCK_MONOTONIC
Date: Wed, 23 Jul 2014 15:09:58 +0800
Message-ID: <1406099398-28758-1-git-send-email-shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0188.outbound.protection.outlook.com [207.46.163.188])
 by alsa0.perex.cz (Postfix) with ESMTP id 396D6265618
 for <alsa-devel@alsa-project.org>; Wed, 23 Jul 2014 09:09:49 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

CLOCK_MONITONIC is defined in <bits/time.h>, add <time.h> before
<sys/time.h>.

Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
 src/pcm/pcm_local.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/src/pcm/pcm_local.h b/src/pcm/pcm_local.h
index 2206afe..80bbe59 100644
--- a/src/pcm/pcm_local.h
+++ b/src/pcm/pcm_local.h
@@ -24,6 +24,7 @@
 #include <stdlib.h>
 #include <limits.h>
 #include <sys/uio.h>
+#include <time.h>
 #include <sys/time.h>
 
 #define _snd_mask sndrv_mask
-- 
1.7.9.5
