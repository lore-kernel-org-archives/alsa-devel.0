From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/7] ALSA: line6: Remove revision.h
Date: Wed, 28 Jan 2015 17:41:25 +0100
Message-ID: <1422463289-19135-4-git-send-email-tiwai@suse.de>
References: <1422463289-19135-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 49C39264FF6
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 17:41:37 +0100 (CET)
In-Reply-To: <1422463289-19135-1-git-send-email-tiwai@suse.de>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Chris Rorvick <chris@rorvick.com>
List-Id: alsa-devel@alsa-project.org

The definition is no longer used.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/driver.c   | 1 -
 sound/usb/line6/revision.h | 4 ----
 2 files changed, 5 deletions(-)
 delete mode 100644 sound/usb/line6/revision.h

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index f46da99c44b3..786b38159ad6 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -22,7 +22,6 @@
 #include "driver.h"
 #include "midi.h"
 #include "playback.h"
-#include "revision.h"
 #include "usbdefs.h"
 
 #define DRIVER_AUTHOR  "Markus Grabner <grabner@icg.tugraz.at>"
diff --git a/sound/usb/line6/revision.h b/sound/usb/line6/revision.h
deleted file mode 100644
index b4eee2b73831..000000000000
--- a/sound/usb/line6/revision.h
+++ /dev/null
@@ -1,4 +0,0 @@
-#ifndef DRIVER_REVISION
-/* current subversion revision */
-#define DRIVER_REVISION " (904)"
-#endif
-- 
2.2.2
