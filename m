From: LCID Fire <lcid-fire@gmx.net>
Subject: Re: [PATCH] Detailed messages in usbaudio.c
Date: Tue, 27 Jan 2009 14:54:16 +0100
Message-ID: <497F1208.1050007@gmx.net>
References: <497B6EAF.4000005@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050806070602090407040706"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id AEBDE24419
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 14:54:21 +0100 (CET)
In-Reply-To: <497B6EAF.4000005@gmx.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050806070602090407040706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

LCID Fire wrote:
> Attached are 3 patches which make the error messages in usbaudio.c more 
> useful and also some code optimizations.
Attached are the patches done via format patch.

--------------050806070602090407040706
Content-Type: text/x-patch;
 name="0001-Add-device-and-control-number-so-it-s-apparent-for-w.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Add-device-and-control-number-so-it-s-apparent-for-w.pa";
 filename*1="tch"

>From cd0180399253b17ece4fc1177457b21b8b70fe8f Mon Sep 17 00:00:00 2001
From: Andreas Bergmeier <lcid-fire@gmx.net>
Date: Sat, 24 Jan 2009 12:22:13 +0100
Subject: [PATCH] Add device and control number so it's apparent for which control this error is showing up.

Signed-off-by: Andreas Bergmeier <lcid-fire@gmx.net>
---
 sound/usb/usbaudio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
index 037435d..e578a5c 100644
--- a/sound/usb/usbaudio.c
+++ b/sound/usb/usbaudio.c
@@ -2867,12 +2867,12 @@ static int snd_usb_create_streams(struct snd_usb_audio *chip, int ctrlif)
 	/* find audiocontrol interface */
 	host_iface = &usb_ifnum_to_if(dev, ctrlif)->altsetting[0];
 	if (!(p1 = snd_usb_find_csint_desc(host_iface->extra, host_iface->extralen, NULL, HEADER))) {
-		snd_printk(KERN_ERR "cannot find HEADER\n");
+		snd_printk(KERN_ERR "%d:%u: cannot find HEADER\n", dev->devnum, ctrlif);
 
 		return -EINVAL;
 	}
 	if (! p1[7] || p1[0] < 8 + p1[7]) {
-		snd_printk(KERN_ERR "invalid HEADER\n");
+		snd_printk(KERN_ERR "%d:%u: invalid HEADER\n", dev->devnum, ctrlif);
 		return -EINVAL;
 	}
 
-- 
1.5.6.3


--------------050806070602090407040706
Content-Type: text/x-patch;
 name="0001-Print-device-number-which-did-not-support-low-speed.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Print-device-number-which-did-not-support-low-speed.pat";
 filename*1="ch"

>From 191cf816a5a618a84cc3627c5f9f96355f5d22c4 Mon Sep 17 00:00:00 2001
From: Andreas Bergmeier <lcid-fire@gmx.net>
Date: Sat, 24 Jan 2009 12:17:01 +0100
Subject: [PATCH] Print device number which did not support low speed audio streaming

Signed-off-by: Andreas Bergmeier <lcid-fire@gmx.net>
---
 sound/usb/usbaudio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
index 8b8eb9e..2cfb8a3 100644
--- a/sound/usb/usbaudio.c
+++ b/sound/usb/usbaudio.c
@@ -2929,7 +2929,7 @@ static int snd_usb_create_streams(struct snd_usb_audio *chip, int ctrlif)
 			continue;
 		}
 		if (snd_usb_get_speed(dev) == USB_SPEED_LOW) {
-			snd_printk(KERN_ERR "low speed audio streaming not supported\n");
+			snd_printk(KERN_ERR "%d: low speed audio streaming not supported\n", dev->devnum);
 			continue;
 		}
 		if (! parse_audio_endpoints(chip, j)) {
-- 
1.5.6.3


--------------050806070602090407040706
Content-Type: text/x-patch;
 name="0001-Replaced-return-NULL-lines-by-break-in-snd_usb_fin.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Replaced-return-NULL-lines-by-break-in-snd_usb_fin.patc";
 filename*1="h"

>From c6d62cbaf6d36b252768ef109b8d85a036e1d451 Mon Sep 17 00:00:00 2001
From: Andreas Bergmeier <lcid-fire@gmx.net>
Date: Sat, 24 Jan 2009 12:16:16 +0100
Subject: [PATCH] Replaced 'return NULL' lines by break in snd_usb_find_desc so there is only one default error.

Signed-off-by: Andreas Bergmeier <lcid-fire@gmx.net>
---
 sound/usb/usbaudio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
index d35b51c..8b8eb9e 100644
--- a/sound/usb/usbaudio.c
+++ b/sound/usb/usbaudio.c
@@ -2054,10 +2054,10 @@ void *snd_usb_find_desc(void *descstart, int desclen, void *after, u8 dtype)
 	end = p + desclen;
 	for (; p < end;) {
 		if (p[0] < 2)
-			return NULL;
+			break;
 		next = p + p[0];
 		if (next > end)
-			return NULL;
+			break;
 		if (p[1] == dtype && (!after || (void *)p > after)) {
 			return p;
 		}
-- 
1.5.6.3


--------------050806070602090407040706
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050806070602090407040706--
