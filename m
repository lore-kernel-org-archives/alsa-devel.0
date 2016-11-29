From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: usb-audio: Fix bogus error return in
	snd_usb_create_stream()
Date: Tue, 29 Nov 2016 22:39:00 +0100
Message-ID: <20161129213900.8602-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C1969265A82
 for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2016 22:39:02 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id EF9EEAC0D
 for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2016 21:39:01 +0000 (UTC)
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

The function returns -EINVAL even if it builds the stream properly.
The bogus error code sneaked in during the code refactoring, but it
wasn't noticed until now since the returned error code itself is
ignored in anyway.  Kill it here, but there is no behavior change by
this patch, obviously.

Fixes: e5779998bf8b ('ALSA: usb-audio: refactor code')
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/card.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 2ddc034673a8..f36cb068dad3 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -206,7 +206,6 @@ static int snd_usb_create_stream(struct snd_usb_audio *chip, int ctrlif, int int
 	if (! snd_usb_parse_audio_interface(chip, interface)) {
 		usb_set_interface(dev, interface, 0); /* reset the current interface */
 		usb_driver_claim_interface(&usb_audio_driver, iface, (void *)-1L);
-		return -EINVAL;
 	}
 
 	return 0;
-- 
2.10.2
