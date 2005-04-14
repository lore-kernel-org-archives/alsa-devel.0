From: karsten wiese <annabellesgarden@yahoo.de>
Subject: [PATCH]usx2y: prevent oops & dead keyboard on hot usb unplugging
Date: Thu, 14 Apr 2005 20:59:30 +0200 (CEST)
Message-ID: <20050414185930.36889.qmail@web26505.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1347243092-1113505170=:35690"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>
Cc: Devel Alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--0-1347243092-1113505170=:35690
Content-Type: text/plain; charset=iso-8859-1
Content-Id: 
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Clemens & Takashi

Please commit the patch.
Btw, snd-usb-audio could use the same treatment.
Whats the use of:
	chip->num_interfaces--;
	if (chip->num_interfaces <=3D 0) {
in snd_usb_audio_disconnect() ?
is snd_usb_audio_disconnect() called for each usb
interface?

best regards,
Karsten
-----------------------------------------------------------
Header:
snd-usb-usx2y: prevent oops & dead keyboard on usb
unplugging while the device is being used

Description:
Without this patch, some usb kobjects, which are parents to
the usx2y's kobjects can be freed before the usx2y's.
This led to an oops in get_kobj_path_length() and a dead
keyboard, when the usx2y's kobjects were freed.
The patch ensures the correct sequence.
Tested ok on kernel 2.6.12-rc2.

Signed-of-by: Karsten Wiese <annabellesgarden@yahoo.de>


=09

=09
	=09
___________________________________________________________=20
Gesendet von Yahoo! Mail - Jetzt mit 250MB Speicher kostenlos - Hier anme=
lden: http://mail.yahoo.de
--0-1347243092-1113505170=:35690
Content-Type: text/x-diff; name="usbusx2y.c_1.10_patch"
Content-Description: usbusx2y.c_1.10_patch
Content-Disposition: inline; filename="usbusx2y.c_1.10_patch"

Index: usbusx2y.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usx2y/usbusx2y.c,v
retrieving revision 1.9
diff -c -r1.9 usbusx2y.c
--- usbusx2y.c	28 Jan 2005 10:21:48 -0000	1.9
+++ usbusx2y.c	14 Apr 2005 18:27:29 -0000
@@ -1,6 +1,11 @@
 /*
  * usbusy2y.c - ALSA USB US-428 Driver
  *
+2005-04-14 Karsten Wiese
+	Version 0.8.7.2:
+	Call snd_card_free() instead of snd_card_free_in_thread() to prevent oops with dead keyboard symptom.
+	Tested ok with kernel 2.6.12-rc2.
+
 2004-12-14 Karsten Wiese
 	Version 0.8.7.1:
 	snd_pcm_open for rawusb pcm-devices now returns -EBUSY if called without rawusb's hwdep device being open.
@@ -143,7 +148,7 @@
 
 
 MODULE_AUTHOR("Karsten Wiese <annabellesgarden@yahoo.de>");
-MODULE_DESCRIPTION("TASCAM "NAME_ALLCAPS" Version 0.8.7.1");
+MODULE_DESCRIPTION("TASCAM "NAME_ALLCAPS" Version 0.8.7.2");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{TASCAM(0x1604), "NAME_ALLCAPS"(0x8001)(0x8005)(0x8007) }}");
 
@@ -430,8 +435,6 @@
 	if (ptr) {
 		usX2Ydev_t* usX2Y = usX2Y((snd_card_t*)ptr);
 		struct list_head* p;
-		if (usX2Y->chip_status == USX2Y_STAT_CHIP_HUP)	// on 2.6.1 kernel snd_usbmidi_disconnect()
-			return;					// calls us back. better leave :-) .
 		usX2Y->chip.shutdown = 1;
 		usX2Y->chip_status = USX2Y_STAT_CHIP_HUP;
 		usX2Y_unlinkSeq(&usX2Y->AS04);
@@ -443,7 +446,7 @@
 		}
 		if (usX2Y->us428ctls_sharedmem) 
 			wake_up(&usX2Y->us428ctls_wait_queue_head);
-		snd_card_free_in_thread((snd_card_t*)ptr);
+		snd_card_free((snd_card_t*)ptr);
 	}
 }
 

--0-1347243092-1113505170=:35690--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
