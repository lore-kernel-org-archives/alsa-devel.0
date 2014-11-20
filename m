From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: usb-audio: Use snd_usb_ctl_msg() for
	Native Instruments quirk
Date: Thu, 20 Nov 2014 21:44:07 +0100
Message-ID: <1416516247-1425-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EC9A32605FF
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 21:44:11 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E06AAAB07
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 20:44:10 +0000 (UTC)
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

snd_nativeinstruments_control_get() uses a stack as a buffer for
usb_control_msg(), but it's basically not allowed.  Replace the call
with a safer helper, snd_usb_ctl_msg(), instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer_quirks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 03405b93b438..8b55c0667f60 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -702,10 +702,10 @@ static int snd_nativeinstruments_control_get(struct snd_kcontrol *kcontrol,
 	if (mixer->chip->shutdown)
 		ret = -ENODEV;
 	else
-		ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0), bRequest,
+		ret = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), bRequest,
 				  USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
 				  0, wIndex,
-				  &tmp, sizeof(tmp), 1000);
+				  &tmp, sizeof(tmp));
 	up_read(&mixer->chip->shutdown_rwsem);
 
 	if (ret < 0) {
-- 
2.1.3
