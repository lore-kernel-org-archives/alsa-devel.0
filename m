From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 12/17] ALSA: line6: Drop MISSING_CASE macro
Date: Mon, 19 Jan 2015 16:54:46 +0100
Message-ID: <1421682891-11594-13-git-send-email-tiwai@suse.de>
References: <1421682891-11594-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 69646261492
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 16:55:03 +0100 (CET)
In-Reply-To: <1421682891-11594-1-git-send-email-tiwai@suse.de>
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

Such a debug is needed in the core code, not in each lowlevel driver.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/driver.h | 4 ----
 sound/usb/line6/pcm.c    | 3 ---
 2 files changed, 7 deletions(-)

diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index 31cd318369e9..8e4d946a130c 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -48,10 +48,6 @@
 
 #define LINE6_CHANNEL_MASK 0x0f
 
-#define MISSING_CASE	\
-	pr_err("line6usb driver bug: missing case in %s:%d\n", \
-		__FILE__, __LINE__)
-
 #define CHECK_RETURN(x)		\
 do {				\
 	err = x;		\
diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index 1e77d0d9da17..39034c7681da 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -488,9 +488,6 @@ int snd_line6_prepare(struct snd_pcm_substream *substream)
 			line6_unlink_wait_clear_audio_in_urbs(line6pcm);
 
 		break;
-
-	default:
-		MISSING_CASE;
 	}
 
 	if (!test_and_set_bit(LINE6_INDEX_PREPARED, &line6pcm->flags)) {
-- 
2.2.1
