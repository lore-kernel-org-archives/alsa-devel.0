From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 2/4] ALSA: usb-audio: fix return values
Date: Wed, 26 May 2010 18:11:37 +0200
Message-ID: <1274890299-8972-2-git-send-email-daniel@caiaq.de>
References: <1274890299-8972-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id CB159103965
	for <alsa-devel@alsa-project.org>;
	Wed, 26 May 2010 18:11:52 +0200 (CEST)
In-Reply-To: <1274890299-8972-1-git-send-email-daniel@caiaq.de>
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
Cc: tiwai@suse.de, gregkh@suse.de, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

-1 is not a good return value as it means -EPERM, "not permitted".
Choose -ENOTSUPP instead, which is what the code really wants to tell
its callers.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 sound/usb/format.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index caaa3ef..fe29d61 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -408,7 +408,7 @@ int snd_usb_parse_audio_format(struct snd_usb_audio *chip, struct audioformat *f
 		snd_printd(KERN_INFO "%d:%u:%d : format type %d is not supported yet\n",
 			   chip->dev->devnum, fp->iface, fp->altsetting,
 			   fmt->bFormatType);
-		return -1;
+		return -ENOTSUPP;
 	}
 	fp->fmt_type = fmt->bFormatType;
 	if (err < 0)
@@ -424,7 +424,7 @@ int snd_usb_parse_audio_format(struct snd_usb_audio *chip, struct audioformat *f
 		if (fmt->bFormatType == UAC_FORMAT_TYPE_I &&
 		    fp->rates != SNDRV_PCM_RATE_48000 &&
 		    fp->rates != SNDRV_PCM_RATE_96000)
-			return -1;
+			return -ENOTSUPP;
 	}
 #endif
 	return 0;
-- 
1.7.1
