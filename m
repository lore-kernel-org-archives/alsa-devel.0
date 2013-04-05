From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH] ALSA: usb-audio: fix endianness bug in
	snd_nativeinstruments_*
Date: Fri,  5 Apr 2013 20:49:46 +0200
Message-ID: <1365187787-2542-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f46.google.com (mail-bk0-f46.google.com
 [209.85.214.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 60C652625E3
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2013 20:49:55 +0200 (CEST)
Received: by mail-bk0-f46.google.com with SMTP id je9so2273574bkc.19
 for <alsa-devel@alsa-project.org>; Fri, 05 Apr 2013 11:49:55 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

The usb_control_msg() function expects __u16 types and performs
the endianness conversions by itself.
However, in three places, a conversion is performed before it is
handed over to usb_control_msg(), which leads to a double conversion
(= no conversion):
* snd_usb_nativeinstruments_boot_quirk()
* snd_nativeinstruments_control_get()
* snd_nativeinstruments_control_put()

Caught by sparse:

sound/usb/mixer_quirks.c:512:38: warning: incorrect type in argument 6 (different base types)
sound/usb/mixer_quirks.c:512:38:    expected unsigned short [unsigned] [usertype] index
sound/usb/mixer_quirks.c:512:38:    got restricted __le16 [usertype] <noident>
sound/usb/mixer_quirks.c:543:35: warning: incorrect type in argument 5 (different base types)
sound/usb/mixer_quirks.c:543:35:    expected unsigned short [unsigned] [usertype] value
sound/usb/mixer_quirks.c:543:35:    got restricted __le16 [usertype] <noident>
sound/usb/mixer_quirks.c:543:56: warning: incorrect type in argument 6 (different base types)
sound/usb/mixer_quirks.c:543:56:    expected unsigned short [unsigned] [usertype] index
sound/usb/mixer_quirks.c:543:56:    got restricted __le16 [usertype] <noident>
sound/usb/quirks.c:502:35: warning: incorrect type in argument 5 (different base types)
sound/usb/quirks.c:502:35:    expected unsigned short [unsigned] [usertype] value
sound/usb/quirks.c:502:35:    got restricted __le16 [usertype] <noident>

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/mixer_quirks.c | 4 ++--
 sound/usb/quirks.c       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 497d274..ebe9144 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -509,7 +509,7 @@ static int snd_nativeinstruments_control_get(struct snd_kcontrol *kcontrol,
 	else
 		ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0), bRequest,
 				  USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
-				  0, cpu_to_le16(wIndex),
+				  0, wIndex,
 				  &tmp, sizeof(tmp), 1000);
 	up_read(&mixer->chip->shutdown_rwsem);
 
@@ -540,7 +540,7 @@ static int snd_nativeinstruments_control_put(struct snd_kcontrol *kcontrol,
 	else
 		ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0), bRequest,
 				  USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
-				  cpu_to_le16(wValue), cpu_to_le16(wIndex),
+				  wValue, wIndex,
 				  NULL, 0, 1000);
 	up_read(&mixer->chip->shutdown_rwsem);
 
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index a2ac004..68e9220 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -499,7 +499,7 @@ static int snd_usb_nativeinstruments_boot_quirk(struct usb_device *dev)
 {
 	int ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
 				  0xaf, USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-				  cpu_to_le16(1), 0, NULL, 0, 1000);
+				  1, 0, NULL, 0, 1000);
 
 	if (ret < 0)
 		return ret;
-- 
1.8.1.5
