From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] ALSA: line6: make snd_pcm_ops  const
Date: Wed, 27 Sep 2017 11:49:27 +0530
Message-ID: <1506493167-7694-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 by alsa0.perex.cz (Postfix) with ESMTP id B82B12671E3
 for <alsa-devel@alsa-project.org>; Wed, 27 Sep 2017 08:19:41 +0200 (CEST)
Received: by mail-pf0-f195.google.com with SMTP id g65so6003584pfe.1
 for <alsa-devel@alsa-project.org>; Tue, 26 Sep 2017 23:19:41 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: julia.lawall@lip6.fr, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make these const as they are only passed to a const argument of the
function snd_pcm_set_ops in the file referencing them. Also, add const
to the declaration in the headers.

Structures found using Coccinelle and changes done by hand.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/usb/line6/capture.c  | 2 +-
 sound/usb/line6/capture.h  | 2 +-
 sound/usb/line6/playback.c | 2 +-
 sound/usb/line6/playback.h | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index 7c81256..947d616 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -248,7 +248,7 @@ static int snd_line6_capture_close(struct snd_pcm_substream *substream)
 }
 
 /* capture operators */
-struct snd_pcm_ops snd_line6_capture_ops = {
+const struct snd_pcm_ops snd_line6_capture_ops = {
 	.open = snd_line6_capture_open,
 	.close = snd_line6_capture_close,
 	.ioctl = snd_pcm_lib_ioctl,
diff --git a/sound/usb/line6/capture.h b/sound/usb/line6/capture.h
index 890b21b..b67ccc3 100644
--- a/sound/usb/line6/capture.h
+++ b/sound/usb/line6/capture.h
@@ -17,7 +17,7 @@
 #include "driver.h"
 #include "pcm.h"
 
-extern struct snd_pcm_ops snd_line6_capture_ops;
+extern const struct snd_pcm_ops snd_line6_capture_ops;
 
 extern void line6_capture_copy(struct snd_line6_pcm *line6pcm, char *fbuf,
 			       int fsize);
diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index 812d181..819e9b2 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -393,7 +393,7 @@ static int snd_line6_playback_close(struct snd_pcm_substream *substream)
 }
 
 /* playback operators */
-struct snd_pcm_ops snd_line6_playback_ops = {
+const struct snd_pcm_ops snd_line6_playback_ops = {
 	.open = snd_line6_playback_open,
 	.close = snd_line6_playback_close,
 	.ioctl = snd_pcm_lib_ioctl,
diff --git a/sound/usb/line6/playback.h b/sound/usb/line6/playback.h
index 51fce29..d8d3b8a 100644
--- a/sound/usb/line6/playback.h
+++ b/sound/usb/line6/playback.h
@@ -27,7 +27,7 @@
  */
 #define USE_CLEAR_BUFFER_WORKAROUND 1
 
-extern struct snd_pcm_ops snd_line6_playback_ops;
+extern const struct snd_pcm_ops snd_line6_playback_ops;
 
 extern int line6_create_audio_out_urbs(struct snd_line6_pcm *line6pcm);
 extern int line6_submit_audio_out_all_urbs(struct snd_line6_pcm *line6pcm);
-- 
1.9.1
