From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: usb-audio: Apply rate limit to warning
	messages in URB complete callback
Date: Wed, 16 May 2018 20:09:31 +0200
Message-ID: <20180516180931.18241-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DD5D3266DF0
 for <alsa-devel@alsa-project.org>; Wed, 16 May 2018 20:09:33 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 04560AEFC
 for <alsa-devel@alsa-project.org>; Wed, 16 May 2018 18:09:32 +0000 (UTC)
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

retire_capture_urb() may print warning messages when the given URB
doesn't align, and this may flood the system log easily.
Put the rate limit to the message for avoiding it.

Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1093485
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index dc2dfec9effd..20bed1c7a312 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1303,7 +1303,7 @@ static void retire_capture_urb(struct snd_usb_substream *subs,
 		if (bytes % (runtime->sample_bits >> 3) != 0) {
 			int oldbytes = bytes;
 			bytes = frames * stride;
-			dev_warn(&subs->dev->dev,
+			dev_warn_ratelimited(&subs->dev->dev,
 				 "Corrected urb data len. %d->%d\n",
 							oldbytes, bytes);
 		}
-- 
2.16.3
