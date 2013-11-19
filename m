From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/1] firewire-lib: include sound/asound.h to
	refer to snd_pcm_format_t
Date: Tue, 19 Nov 2013 13:29:24 +0900
Message-ID: <1384835364-11903-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (unknown [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C414260890
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2013 05:30:49 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

'snd_pcm_format_t' is used by amdtp_out_stream_set_pcm_format().

Currently, when just including amdtp.h, compiler cannot find this type because
this type is defined in uapi/sound/asound.h and this header is not included by
amdtp.h.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index 839ebf8..2746ecd 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -4,6 +4,7 @@
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/mutex.h>
+#include <sound/asound.h>
 #include "packets-buffer.h"
 
 /**
-- 
1.8.3.2
