From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] usb audio device selection
Date: Mon, 02 Sep 2002 18:11:04 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D738D98.F613EA20@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

If there are two or more USB audio devices connected to a computer, it is
impossible to specify module parameters (snd_id/index/enable) for a specific
device because the device order depends on the order they are plugged in or
switched on.

This patch adds parameters snd_vid/snd_pid to reserve a device index for a
specific device.


-- 
Clemens


Index: alsa-kernel/usb/usbaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.c,v
retrieving revision 1.3
diff -u -r1.3 usbaudio.c
--- alsa-kernel/usb/usbaudio.c	26 Aug 2002 16:05:43 -0000	1.3
+++ alsa-kernel/usb/usbaudio.c	2 Sep 2002 16:07:48 -0000
@@ -53,6 +53,8 @@
 static int snd_index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *snd_id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 static int snd_enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;	/* Enable this card */
+static int snd_vid[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS-1)] = -1 }; /* Vendor ID for this card */
+static int snd_pid[SNDRV_CARDS] = { [0 ... (SNDRV_CARDS-1)] = -1 }; /* Product ID for this card */
 
 MODULE_PARM(snd_index, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(snd_index, "Index value for the USB audio adapter.");
@@ -63,6 +65,12 @@
 MODULE_PARM(snd_enable, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(snd_enable, "Enable USB audio adapter.");
 MODULE_PARM_SYNTAX(snd_enable, SNDRV_ENABLE_DESC);
+MODULE_PARM(snd_vid, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
+MODULE_PARM_DESC(snd_vid, "Vendor ID for the USB audio device.");
+MODULE_PARM_SYNTAX(snd_vid, SNDRV_ENABLED ",allows:{{-1,0xffff}},base:16");
+MODULE_PARM(snd_pid, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
+MODULE_PARM_DESC(snd_pid, "Product ID for the USB audio device.");
+MODULE_PARM_SYNTAX(snd_pid, SNDRV_ENABLED ",allows:{{-1,0xffff}},base:16");
 
 
 /*
@@ -2043,7 +2051,9 @@
 		 * now look for an empty slot and create a new card instance
 		 */
 		for (i = 0; i < SNDRV_CARDS; i++)
-			if (snd_enable[i] && ! usb_chip[i]) {
+			if (snd_enable[i] && ! usb_chip[i] &&
+			    (snd_vid[i] == -1 || snd_vid[i] == dev->descriptor.idVendor) &&
+			    (snd_pid[i] == -1 || snd_pid[i] == dev->descriptor.idProduct)) {
 				card = snd_card_new(snd_index[i], snd_id[i], THIS_MODULE, 0);
 				if (card == NULL) {
 					snd_printk(KERN_ERR "cannot create a card instance %d\n", i);
Index: alsa-driver/INSTALL
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/INSTALL,v
retrieving revision 1.132
diff -u -r1.132 INSTALL
--- alsa-driver/INSTALL	3 Jul 2002 13:44:32 -0000	1.132
+++ alsa-driver/INSTALL	2 Sep 2002 16:07:58 -0000
@@ -812,18 +812,10 @@
   Module snd-usb-audio.o
   ----------------------
 
-    Module for USB audio devices.
+    Module for USB audio and USB MIDI devices.
 
-    This module supports up to 8 cards, autoprobe and hotplugging.
-
-  Module snd-usb-midi.o
-  ---------------------
-
-    Module for MIDI devices connected to a USB port.
-
-    snd_int_transfer    - transfer type for MIDI input
-                          0 = bulk transfers (default)
-                          1 = interrupt transfers, if supported by the device
+    snd_vid             - Vendor ID for the device (optional)
+    snd_pid             - Product ID for the device (optional)
 
     This module supports up to 8 cards, autoprobe and hotplugging.


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
