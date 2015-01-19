From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 05/17] ALSA: line6: Drop invalid
	SNDRV_PCM_INFO_RESUME flag
Date: Mon, 19 Jan 2015 16:54:39 +0100
Message-ID: <1421682891-11594-6-git-send-email-tiwai@suse.de>
References: <1421682891-11594-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4672A2610C5
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

The line6 drivers don't support the full resume although they set
SNDRV_PCM_INFO_RESUME.  These flags have to be dropped to inform
properly to the user-space.

Also, drop the CONFIG_PM in trigger callbacks, too, which are rather
superfluous.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/capture.c  | 4 ----
 sound/usb/line6/playback.c | 4 ----
 sound/usb/line6/pod.c      | 6 ------
 sound/usb/line6/podhd.c    | 6 ------
 sound/usb/line6/toneport.c | 6 ------
 5 files changed, 26 deletions(-)

diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index 4cf6fa0541f1..1970ab57cb6f 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -342,9 +342,7 @@ int snd_line6_capture_trigger(struct snd_line6_pcm *line6pcm, int cmd)
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-#ifdef CONFIG_PM
 	case SNDRV_PCM_TRIGGER_RESUME:
-#endif
 		err = line6_pcm_acquire(line6pcm,
 					LINE6_BIT_PCM_ALSA_CAPTURE_STREAM);
 
@@ -354,9 +352,7 @@ int snd_line6_capture_trigger(struct snd_line6_pcm *line6pcm, int cmd)
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
-#ifdef CONFIG_PM
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-#endif
 		err = line6_pcm_release(line6pcm,
 					LINE6_BIT_PCM_ALSA_CAPTURE_STREAM);
 
diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index 258147eadf37..8fc2dedbeb52 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -490,9 +490,7 @@ int snd_line6_playback_trigger(struct snd_line6_pcm *line6pcm, int cmd)
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-#ifdef CONFIG_PM
 	case SNDRV_PCM_TRIGGER_RESUME:
-#endif
 		err = line6_pcm_acquire(line6pcm,
 					LINE6_BIT_PCM_ALSA_PLAYBACK_STREAM);
 
@@ -502,9 +500,7 @@ int snd_line6_playback_trigger(struct snd_line6_pcm *line6pcm, int cmd)
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
-#ifdef CONFIG_PM
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-#endif
 		err = line6_pcm_release(line6pcm,
 					LINE6_BIT_PCM_ALSA_PLAYBACK_STREAM);
 
diff --git a/sound/usb/line6/pod.c b/sound/usb/line6/pod.c
index dde9c2b8ad0f..d6bc5a1ab7f4 100644
--- a/sound/usb/line6/pod.c
+++ b/sound/usb/line6/pod.c
@@ -153,9 +153,6 @@ static struct line6_pcm_properties pod_pcm_properties = {
 					   SNDRV_PCM_INFO_BLOCK_TRANSFER |
 					   SNDRV_PCM_INFO_MMAP_VALID |
 					   SNDRV_PCM_INFO_PAUSE |
-#ifdef CONFIG_PM
-					   SNDRV_PCM_INFO_RESUME |
-#endif
 					   SNDRV_PCM_INFO_SYNC_START),
 				  .formats = SNDRV_PCM_FMTBIT_S24_3LE,
 				  .rates = SNDRV_PCM_RATE_KNOT,
@@ -173,9 +170,6 @@ static struct line6_pcm_properties pod_pcm_properties = {
 					  SNDRV_PCM_INFO_INTERLEAVED |
 					  SNDRV_PCM_INFO_BLOCK_TRANSFER |
 					  SNDRV_PCM_INFO_MMAP_VALID |
-#ifdef CONFIG_PM
-					  SNDRV_PCM_INFO_RESUME |
-#endif
 					  SNDRV_PCM_INFO_SYNC_START),
 				 .formats = SNDRV_PCM_FMTBIT_S24_3LE,
 				 .rates = SNDRV_PCM_RATE_KNOT,
diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index 84096326694c..8f4ca1d20b62 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -50,9 +50,6 @@ static struct line6_pcm_properties podhd_pcm_properties = {
 					   SNDRV_PCM_INFO_BLOCK_TRANSFER |
 					   SNDRV_PCM_INFO_MMAP_VALID |
 					   SNDRV_PCM_INFO_PAUSE |
-#ifdef CONFIG_PM
-					   SNDRV_PCM_INFO_RESUME |
-#endif
 					   SNDRV_PCM_INFO_SYNC_START),
 				  .formats = SNDRV_PCM_FMTBIT_S24_3LE,
 				  .rates = SNDRV_PCM_RATE_48000,
@@ -70,9 +67,6 @@ static struct line6_pcm_properties podhd_pcm_properties = {
 					  SNDRV_PCM_INFO_INTERLEAVED |
 					  SNDRV_PCM_INFO_BLOCK_TRANSFER |
 					  SNDRV_PCM_INFO_MMAP_VALID |
-#ifdef CONFIG_PM
-					  SNDRV_PCM_INFO_RESUME |
-#endif
 					  SNDRV_PCM_INFO_SYNC_START),
 				 .formats = SNDRV_PCM_FMTBIT_S24_3LE,
 				 .rates = SNDRV_PCM_RATE_48000,
diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index 4f07643e47f2..6ec3268a6153 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -83,9 +83,6 @@ static struct line6_pcm_properties toneport_pcm_properties = {
 					   SNDRV_PCM_INFO_BLOCK_TRANSFER |
 					   SNDRV_PCM_INFO_MMAP_VALID |
 					   SNDRV_PCM_INFO_PAUSE |
-#ifdef CONFIG_PM
-					   SNDRV_PCM_INFO_RESUME |
-#endif
 					   SNDRV_PCM_INFO_SYNC_START),
 				  .formats = SNDRV_PCM_FMTBIT_S16_LE,
 				  .rates = SNDRV_PCM_RATE_KNOT,
@@ -103,9 +100,6 @@ static struct line6_pcm_properties toneport_pcm_properties = {
 					  SNDRV_PCM_INFO_INTERLEAVED |
 					  SNDRV_PCM_INFO_BLOCK_TRANSFER |
 					  SNDRV_PCM_INFO_MMAP_VALID |
-#ifdef CONFIG_PM
-					  SNDRV_PCM_INFO_RESUME |
-#endif
 					  SNDRV_PCM_INFO_SYNC_START),
 				 .formats = SNDRV_PCM_FMTBIT_S16_LE,
 				 .rates = SNDRV_PCM_RATE_KNOT,
-- 
2.2.1
