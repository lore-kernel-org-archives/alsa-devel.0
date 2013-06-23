From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] snd-firewire-lib: remove unused header
	inclusion
Date: Sun, 23 Jun 2013 11:50:24 +0900
Message-ID: <1371955824-8685-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C5BF261A0A
 for <alsa-devel@alsa-project.org>; Sun, 23 Jun 2013 04:50:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: o-takashi@sakamocchi.jp, clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

spinlock is not used in amdtp.h.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index b680c5e..f6103d6 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -3,7 +3,6 @@
 
 #include <linux/interrupt.h>
 #include <linux/mutex.h>
-#include <linux/spinlock.h>
 #include "packets-buffer.h"
 
 /**
-- 
1.7.10.4
