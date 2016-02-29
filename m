From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 3/6] ALSA: rawmidi: Use comapt_put_timespec()
Date: Mon, 29 Feb 2016 17:16:42 +0100
Message-ID: <1456762605-2451-4-git-send-email-tiwai@suse.de>
References: <1456762605-2451-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6425226078A
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 17:16:50 +0100 (CET)
In-Reply-To: <1456762605-2451-1-git-send-email-tiwai@suse.de>
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
Cc: Steven Newbury <steve@snewbury.org.uk>
List-Id: alsa-devel@alsa-project.org

Instead of open-coding, use the existing helper to copy a 32bit
timespec from/to 64bit.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/rawmidi_compat.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/core/rawmidi_compat.c b/sound/core/rawmidi_compat.c
index 5268c1f58c25..836d1c9fc2cc 100644
--- a/sound/core/rawmidi_compat.c
+++ b/sound/core/rawmidi_compat.c
@@ -85,8 +85,7 @@ static int snd_rawmidi_ioctl_status_compat(struct snd_rawmidi_file *rfile,
 	if (err < 0)
 		return err;
 
-	if (put_user(status.tstamp.tv_sec, &src->tstamp.tv_sec) ||
-	    put_user(status.tstamp.tv_nsec, &src->tstamp.tv_nsec) ||
+	if (compat_put_timespec(&status.tstamp, &src->tstamp) ||
 	    put_user(status.avail, &src->avail) ||
 	    put_user(status.xruns, &src->xruns))
 		return -EFAULT;
-- 
2.7.2
