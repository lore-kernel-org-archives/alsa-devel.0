From: Ricardo Biehl Pasquali <pasqualirb@gmail.com>
Subject: [PATCH] ALSA: pcm: Return 0 when size <
	start_threshold in capture
Date: Tue, 21 Aug 2018 16:46:43 -0300
Message-ID: <20180821194643.GA10347@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f177.google.com (mail-qt0-f177.google.com
 [209.85.216.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 30F81267657
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2018 21:46:51 +0200 (CEST)
Received: by mail-qt0-f177.google.com with SMTP id f18-v6so21679049qtp.10
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2018 12:46:51 -0700 (PDT)
Received: from localhost.localdomain ([201.37.66.59])
 by smtp.gmail.com with ESMTPSA id d138-v6sm4720544qke.18.2018.08.21.12.46.48
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 21 Aug 2018 12:46:49 -0700 (PDT)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In __snd_pcm_lib_xfer(), when capture, if state is
PREPARED and size is less than start_threshold nothing
can be done. As there is no error, 0 is returned.

Am I missing something?

Cheers!

	pasquali

--- pcm_lib.c.orig	2018-08-21 15:31:54.457405053 -0300
+++ pcm_lib.c	2018-08-21 15:56:01.264549084 -0300
@@ -2125,7 +2125,7 @@
 	pcm_transfer_f transfer;
 	bool nonblock;
 	bool is_playback;
-	int err;
+	int err = 0;
 
 	err = pcm_sanity_check(substream);
 	if (err < 0)
@@ -2173,11 +2173,15 @@
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
