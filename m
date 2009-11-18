From: Dan Carpenter <error27@gmail.com>
Subject: [patch] remove unnecessary null check
Date: Wed, 18 Nov 2009 10:31:57 +0200 (SAST)
Message-ID: <alpine.DEB.2.00.0911170741010.12393@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f209.google.com (mail-fx0-f209.google.com
	[209.85.220.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B8BC245EC
	for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2009 09:32:03 +0100 (CET)
Received: by fxm1 with SMTP id 1so2103650fxm.32
	for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2009 00:32:02 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

This function is only called from snd_ctl_ioctl() and the file parameter 
can never be null so there is no need to check it here.

We dereference file at the start of the function:
        struct snd_card *card = file->card;
and it confuses static checkers to dereference a pointer before 
checking it.

regards,
dan carpenter

Signed-off-by: Dan Carpenter <error27@gmail.com>

--- orig/sound/core/control.c	2009-11-17 07:15:04.000000000 +0200
+++ devel/sound/core/control.c	2009-11-17 07:40:30.000000000 +0200
@@ -1120,7 +1120,7 @@
 	    	goto __kctl_end;
 	}
 	if (vd->access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK) {
-		if (file && vd->owner != NULL && vd->owner != file) {
+		if (vd->owner != NULL && vd->owner != file) {
 			err = -EPERM;
 			goto __kctl_end;
 		}
