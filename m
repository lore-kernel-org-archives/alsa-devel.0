From: Martin Langer <martin-langer@gmx.de>
Subject: [PATCH] usx2y messages
Date: Sat, 27 Dec 2003 14:41:43 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031227134143.GA5810@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


rename some messages from old us428 names to usX2Y ones.


Index: alsa-driver/usb/usx2y/usX2Yhwdep.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usx2y/usX2Yhwdep.c,v
retrieving revision 1.1
diff -u -r1.1 usX2Yhwdep.c
--- alsa-driver/usb/usx2y/usX2Yhwdep.c	25 Nov 2003 11:21:49 -0000	1.1
+++ alsa-driver/usb/usx2y/usX2Yhwdep.c	27 Dec 2003 13:29:30 -0000
@@ -247,7 +247,7 @@
 
 	do {
 		if ((err = snd_usX2Y_create_usbmidi(card)) < 0) {
-			snd_printk("snd_us428_create_alsa_devices: snd_us428_create_usbmidi error %i \n", err);
+			snd_printk("snd_usX2Y_create_alsa_devices: snd_usX2Y_create_usbmidi error %i \n", err);
 			break;
 		}
 		if ((err = snd_usX2Y_audio_create(card)) < 0) 
@@ -304,15 +304,15 @@
 	if (!err  &&  1 == dsp->index)
 		do {
 			if ((err = snd_usX2Y_AsyncSeq04_init((usX2Ydev_t*)hw->private_data))) {
-				snd_printk("snd_us428_AsyncSeq04_init error \n");
+				snd_printk("snd_usX2Y_AsyncSeq04_init error \n");
 				break;
 			}
 			if ((err = snd_usX2Y_In04_init((usX2Ydev_t*)hw->private_data))) {
-				snd_printk("snd_us428_In04_init error \n");
+				snd_printk("snd_usX2Y_In04_init error \n");
 				break;
 			}
 			if ((err = snd_usX2Y_create_alsa_devices(hw->card))) {
-				snd_printk("snd_us428_create_alsa_devices error %i \n", err);
+				snd_printk("snd_usX2Y_create_alsa_devices error %i \n", err);
 				snd_card_free(hw->card);
 				break;
 			}


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
