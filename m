From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] hda-emu: Handle snd_BUG()
Date: Wed, 17 Oct 2012 12:59:32 +0200
Message-ID: <1350471572-22504-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 96A7F2651C4
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2012 12:59:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 include/sound/core.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/sound/core.h b/include/sound/core.h
index 57774ea..a749460 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -24,6 +24,7 @@ static inline int _snd_BUG_ON(int cond, const char *func, int line)
 	return cond;
 }
 #define snd_BUG_ON(cond)	_snd_BUG_ON(cond, __func__, __LINE__)
+#define snd_BUG()		snd_BUG_ON(1)
 
 #include "asound.h"
 #include "codec_config.h"
-- 
1.7.9.5
