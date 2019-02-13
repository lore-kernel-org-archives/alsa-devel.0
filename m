From: Ricardo Biehl Pasquali <pasqualirb@gmail.com>
Subject: [PATCH] ALSA: pcm: Comment why read blocks when PCM is
	not running
Date: Wed, 13 Feb 2019 00:57:51 -0200
Message-ID: <20190213025751.GA6024@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 49E00267482
 for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2019 03:57:58 +0100 (CET)
Received: by mail-qt1-f195.google.com with SMTP id p25so722946qtb.3
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2019 18:57:57 -0800 (PST)
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

This avoids bringing back the problem introduced by
62ba568f7aef ("ALSA: pcm: Return 0 when size <
start_threshold in capture") and fixed in 00a399cad1a0
("ALSA: pcm: Revert capture stream behavior change in
blocking mode"), which prevented the user from starting
capture from another thread.

Signed-off-by: Ricardo Biehl Pasquali <pasqualirb@gmail.com>
---
 sound/core/pcm_lib.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index bcb06bd3d..345ab1ab2 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -2176,6 +2176,10 @@ snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
 	if (runtime->status->state == SNDRV_PCM_STATE_RUNNING)
 		snd_pcm_update_hw_ptr(substream);
 
+	/*
+	 * If size < start_threshold, wait indefinitely. Another
+	 * thread may start capture
+	 */
 	if (!is_playback &&
 	    runtime->status->state == SNDRV_PCM_STATE_PREPARED &&
 	    size >= runtime->start_threshold) {
-- 
2.19.1
