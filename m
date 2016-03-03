From: Thomas Klausner <tk@giga.or.at>
Subject: [PATCH] Make alsa asound.h header more portable.
Date: Thu,  3 Mar 2016 16:28:22 +0100
Message-ID: <1457018902-24722-1-git-send-email-tk@giga.or.at>
References: <s5htwkn4mf7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vie01a-dmta-pe04-2.mx.upcmail.net
 (vie01a-dmta-pe04-2.mx.upcmail.net [62.179.121.164])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B8D92606CF
 for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2016 16:28:30 +0100 (CET)
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
 by vie01a-dmta-pe04.mx.upcmail.net with esmtp (Exim 4.72)
 (envelope-from <wiz@yt.nih.at>) id 1abVAz-0005g2-Tn
 for alsa-devel@alsa-project.org; Thu, 03 Mar 2016 16:28:29 +0100
In-Reply-To: <s5htwkn4mf7.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Cc: Thomas Klausner <wiz@NetBSD.org>
List-Id: alsa-devel@alsa-project.org

From: Thomas Klausner <wiz@NetBSD.org>

This header is used as-is in the alsa-lib userland library,
which is portable to other operating systems.
For this reason, include linux/types.h only on Linux systems.

Add sys/ioctl.h for _IOR/_IOW/etc. (works at least on *BSD and Solaris).

Signed-off-by: Thomas Klausner <wiz@NetBSD.org>
---
 include/uapi/sound/asound.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index a82108e..67bf49d 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -23,7 +23,11 @@
 #ifndef _UAPI__SOUND_ASOUND_H
 #define _UAPI__SOUND_ASOUND_H
 
+#if defined(__KERNEL__) || defined(__linux__)
 #include <linux/types.h>
+#else
+#include <sys/ioctl.h>
+#endif
 
 #ifndef __KERNEL__
 #include <stdlib.h>
-- 
2.7.1
