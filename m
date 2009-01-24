From: LCID Fire <lcid-fire@gmx.net>
Subject: [PATCH] Detailed messages in usbaudio.c
Date: Sat, 24 Jan 2009 20:40:31 +0100
Message-ID: <497B6EAF.4000005@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000205080404070207090304"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id E706B243CF
	for <alsa-devel@alsa-project.org>; Sat, 24 Jan 2009 20:40:33 +0100 (CET)
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
--------------000205080404070207090304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Attached are 3 patches which make the error messages in usbaudio.c more 
useful and also some code optimizations.

--------------000205080404070207090304
Content-Type: text/plain;
 name="commit-191cf81"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="commit-191cf81"

commit 191cf816a5a618a84cc3627c5f9f96355f5d22c4
Author: Andreas Bergmeier <lcid-fire@gmx.net>
Date:   Sat Jan 24 12:17:01 2009 +0100

    Print device number which did not support low speed audio streaming
    
    Signed-off-by: Andreas Bergmeier <lcid-fire@gmx.net>

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

--------------000205080404070207090304
Content-Type: text/plain;
 name="commit-c6d62cb"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="commit-c6d62cb"

commit c6d62cbaf6d36b252768ef109b8d85a036e1d451
Author: Andreas Bergmeier <lcid-fire@gmx.net>
Date:   Sat Jan 24 12:16:16 2009 +0100

    Replaced 'return NULL' lines by break in snd_usb_find_desc so there is only one default error.
    
    Signed-off-by: Andreas Bergmeier <lcid-fire@gmx.net>

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

--------------000205080404070207090304
Content-Type: text/plain;
 name="commit-cd01803"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="commit-cd01803"

commit cd0180399253b17ece4fc1177457b21b8b70fe8f
Author: Andreas Bergmeier <lcid-fire@gmx.net>
Date:   Sat Jan 24 12:22:13 2009 +0100

    Add device and control number so it's apparent for which control this error is showing up.
    
    Signed-off-by: Andreas Bergmeier <lcid-fire@gmx.net>

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
 

--------------000205080404070207090304
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------000205080404070207090304--
