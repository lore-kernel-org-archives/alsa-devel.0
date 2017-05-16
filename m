From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH alsa-lib 1/2] build: Define __USE_UNIX98 for
	old glibc
Date: Tue, 16 May 2017 16:28:18 +0200
Message-ID: <20170516142819.7734-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 22F0C266C59
 for <alsa-devel@alsa-project.org>; Tue, 16 May 2017 16:28:23 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 86D9AABF2
 for <alsa-devel@alsa-project.org>; Tue, 16 May 2017 14:28:22 +0000 (UTC)
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

Otherwise PTHREAD_MUTEX_RECURSIVE isn't defined and we get an error
with old glibc.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/pcm/pcm_local.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/pcm/pcm_local.h b/src/pcm/pcm_local.h
index 32e6dcdf6fcd..e4f652187c49 100644
--- a/src/pcm/pcm_local.h
+++ b/src/pcm/pcm_local.h
@@ -35,6 +35,7 @@
 #include "local.h"
 
 #ifdef THREAD_SAFE_API
+#define __USE_UNIX98 1	/* for old glibc */
 #include <pthread.h>
 #endif
 
-- 
2.13.0
