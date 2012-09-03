From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH] sound: Remove the last mention of SNDRV_MAIN_OBJECT_FILE
Date: Sun, 2 Sep 2012 20:04:17 -0700
Message-ID: <20120903030415.GA20377@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

SNDRV_MAIN_OBJECT_FILE hasn't done anything since the pre-git days, and
the only remaining reference occurs as a #define in sound/last.c.  Drop
that last mention of it.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 sound/last.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/last.c b/sound/last.c
index 7ffc182..43f2228 100644
--- a/sound/last.c
+++ b/sound/last.c
@@ -19,7 +19,6 @@
  *
  */
 
-#define SNDRV_MAIN_OBJECT_FILE
 #include <linux/init.h>
 #include <sound/core.h>
 
-- 
1.7.10.4
