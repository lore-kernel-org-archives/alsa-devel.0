From: Rolf Meeser <rolfm_9dq@yahoo.de>
Subject: [PATCH] snd-usb-audio with multiple audio functions
Date: Mon, 06 Jun 2011 08:49:32 +0200
Message-ID: <4DEC787C.3050805@yahoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050109020509060200080600"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm30.bullet.mail.sp2.yahoo.com (nm30.bullet.mail.sp2.yahoo.com
	[98.139.91.100]) by alsa0.perex.cz (Postfix) with SMTP id AE0FD24378
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 08:49:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050109020509060200080600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

This patch fixes the currently broken support for multiple audio 
functions (AF) in snd-usb-audio.
The patch is against the stable 2.6.39.1 kernel.

It addresses three issues:
1. Controls of the second and any further AF are currently not 
accessibly (controls of the first AF are duplicated!)
2. Multiple AF's are currently incorrectly combined into one sound card 
index.
3. Module usage count of snd-usb-audio does not drop to zero after 
disconnecting a multiple AF device.

All three issues are fixed by assigning a new card index for each AF in 
a USB device.


Rationale:

- A USB audio function (AF) consists of a control interface and zero or 
more streaming interfaces. USB devices can have multiple AF, where the 
individual AF are completely independent of each other. In particular, 
it cannot be assumed that the controls of one AF can be manipulated 
through the control interface of another (the first) AF.

- Older kernels (up to 2.6.32? at least before the major rewrite of USB 
audio code) supported multiple AF's. However, they combined the streams 
into one sound card: For instance hw:1,0 for the stream interface of the 
first AF, and hw:1,1 for the stream interface of the second AF.
I believe this is incorrect, as different AF's must be treated as an 
independent entity. Each AF must get its own card index, for the example 
this would be hw:1,0 and hw:2,0. This is also the way THE OTHER OS 
implements it.

- Newer kernels have broken multiple AF support. In a dual AF setup 
these kernels detect the second AF, but they duplicate the controls of 
the first AF, and ignore the controls of the second one!

- The patch also fixes a problem with module usage: When you unplug a 
multiple AF device, the snd-usb-audio module usage count currently stays 
at 1, while you could expect it to go to zero.

This is the first time I'm sending a patch to this list. Please be 
patient with me if I did something in a wrong way :-)

Regards,
Rolf


--------------050109020509060200080600
Content-Type: text/plain;
 name="patch-multiple-aic"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="patch-multiple-aic"

diff -ur linux-2.6.39.1.orig/sound/usb/card.c linux-2.6.39.1/sound/usb/card.c
--- linux-2.6.39.1.orig/sound/usb/card.c	2011-06-06 06:37:26.000000000 +0200
+++ linux-2.6.39.1/sound/usb/card.c	2011-06-06 07:06:06.000000000 +0200
@@ -461,7 +461,10 @@
 	chip = NULL;
 	mutex_lock(&register_mutex);
 	for (i = 0; i < SNDRV_CARDS; i++) {
-		if (usb_chip[i] && usb_chip[i]->dev == dev) {
+		if (usb_chip[i] &&
+			(usb_chip[i]->dev == dev) &&
+			(usb_chip[i]->ctrl_intf) &&
+			(usb_chip[i]->ctrl_intf->desc.bInterfaceNumber == ifnum)) {
 			if (usb_chip[i]->shutdown) {
 				snd_printk(KERN_ERR "USB device is in the shutdown state, cannot create a card instance\n");
 				goto __error;


--------------050109020509060200080600
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050109020509060200080600--
