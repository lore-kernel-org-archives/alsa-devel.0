From: Andrej Krutak <dev@andree.sk>
Subject: [PATCH 15/15] ALSA: line6: Remove double
	line6_pcm_release() after failed acquire.
Date: Thu, 11 Aug 2016 21:02:27 +0200
Message-ID: <1470942147-19848-16-git-send-email-dev@andree.sk>
References: <1470942147-19848-1-git-send-email-dev@andree.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 46B6526777A
 for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2016 21:04:14 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id o80so967358wme.0
 for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2016 12:04:14 -0700 (PDT)
In-Reply-To: <1470942147-19848-1-git-send-email-dev@andree.sk>
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
Cc: Andrej Krutak <dev@andree.sk>
List-Id: alsa-devel@alsa-project.org

If there's an error, pcm is released in line6_pcm_acquire already.

Signed-off-by: Andrej Krutak <dev@andree.sk>
---
 sound/usb/line6/pcm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index 13b3b27..455244c 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -55,7 +55,6 @@ static int snd_line6_impulse_volume_put(struct snd_kcontrol *kcontrol,
 		err = line6_pcm_acquire(line6pcm, LINE6_STREAM_IMPULSE, true);
 		if (err < 0) {
 			line6pcm->impulse_volume = 0;
-			line6_pcm_release(line6pcm, LINE6_STREAM_IMPULSE);
 			return err;
 		}
 	} else {
-- 
1.9.1
