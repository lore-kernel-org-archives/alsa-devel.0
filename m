From: Ricardo Biehl Pasquali <pasqualirb@gmail.com>
Subject: [PATCH v2] ALSA: pcm: Return 0 when size <
	start_threshold in capture
Date: Wed, 22 Aug 2018 12:03:59 -0300
Message-ID: <20180822150359.GA12976@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f181.google.com (mail-qt0-f181.google.com
 [209.85.216.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 293B3267663
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2018 17:04:07 +0200 (CEST)
Received: by mail-qt0-f181.google.com with SMTP id g44-v6so1725523qtb.12
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2018 08:04:07 -0700 (PDT)
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

version 2:
The code was not changed. Just resubmitting to follow the
rules from Documentation/process/submitting-patches.rst.

--- pcm_lib.c.orig	2018-08-21 15:31:54.457405053 -0300
+++ pcm_lib.c	2018-08-21 15:56:01.264549084 -0300
@@ -2125,7 +2125,7 @@ snd_pcm_sframes_t __snd_pcm_lib_xfer(str
 	pcm_transfer_f transfer;
 	bool nonblock;
 	bool is_playback;
-	int err;
+	int err = 0;
 
 	err = pcm_sanity_check(substream);
 	if (err < 0)
@@ -2173,11 +2173,15 @@ snd_pcm_sframes_t __snd_pcm_lib_xfer(str
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
 			goto _end_unlock;
+		}
 	}
 
 	runtime->twake = runtime->control->avail_min ? : 1;
