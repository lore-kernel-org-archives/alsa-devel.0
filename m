From: Ricardo Biehl Pasquali <pasqualirb@gmail.com>
Subject: [PATCH v3] ALSA: pcm: Return 0 when size <
	start_threshold in capture
Date: Sat, 25 Aug 2018 16:53:23 -0300
Message-ID: <20180825195322.GA4521@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f177.google.com (mail-qt0-f177.google.com
 [209.85.216.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D82426773F
 for <alsa-devel@alsa-project.org>; Sat, 25 Aug 2018 21:53:31 +0200 (CEST)
Received: by mail-qt0-f177.google.com with SMTP id r37-v6so13927684qtc.0
 for <alsa-devel@alsa-project.org>; Sat, 25 Aug 2018 12:53:31 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In __snd_pcm_lib_xfer(), when capture, if state is PREPARED
and size is less than start_threshold nothing can be done.
As there is no error, 0 is returned.

Signed-off-by: Ricardo Biehl Pasquali <pasqualirb@gmail.com>
---

version 3:
Set 'err' variable inside 'else' block.

--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -2173,11 +2173,16 @@ snd_pcm_sframes_t __snd_pcm_lib_xfer(str
 		goto _end_unlock;
 
 	if (!is_playback &&
-	    runtime->status->state == SNDRV_PCM_STATE_PREPARED &&
-	    size >= runtime->start_threshold) {
-		err = snd_pcm_start(substream);
-		if (err < 0)
+	    runtime->status->state == SNDRV_PCM_STATE_PREPARED) {
+		if (size >= runtime->start_threshold) {
+			err = snd_pcm_start(substream);
+			if (err < 0)
+				goto _end_unlock;
+		} else {
+			/* nothing to do */
+			err = 0;
 			goto _end_unlock;
+		}
 	}
 
 	runtime->twake = runtime->control->avail_min ? : 1;
