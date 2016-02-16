From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH] a52: Make compatible with ffmpeg 3.0
Date: Mon, 15 Feb 2016 17:49:22 -0800
Message-ID: <1455587362-7366-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 74E68261501
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 02:50:04 +0100 (CET)
Received: by mail-pa0-f53.google.com with SMTP id ho8so95235660pac.2
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 17:50:04 -0800 (PST)
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
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>, david.henningsson@canonical.com, anton@khirnov.net
List-Id: alsa-devel@alsa-project.org

audioconvert.h has been deprecated a while ago and got removed in
ffmpeg 3.0 (commit 2d40968dd3ff17b12f7).

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 a52/pcm_a52.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/a52/pcm_a52.c b/a52/pcm_a52.c
index 88529eb..6fad77d 100644
--- a/a52/pcm_a52.c
+++ b/a52/pcm_a52.c
@@ -39,7 +39,7 @@
 #endif
 
 #if LIBAVCODEC_VERSION_INT >= AV_VERSION_INT(53, 34, 0)
-#include <libavutil/audioconvert.h>
+#include <libavutil/channel_layout.h>
 #include <libavutil/mem.h>
 #define USE_AVCODEC_FRAME
 #endif
-- 
2.7.1
