From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fix composite quirk
Date: Wed, 22 Jan 2003 09:04:33 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0301220856300.1159-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


The first version of the composite quirk would handle the quirk for each
interface when that interface is probed by khubd, but the PCM capture
stream wouldn't get registered correcty if it was added after the PCM
device has been already registered.

This patch handles all interfaces when the first one is probed.
(This means capturing on the SC-D70 may work after all.)


Index: alsa-kernel/usb/usbaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.c,v
retrieving revision 1.36
diff -u -r1.36 usbaudio.c
--- alsa-kernel/usb/usbaudio.c	21 Jan 2003 09:52:44 -0000	1.36
+++ alsa-kernel/usb/usbaudio.c	22 Jan 2003 07:59:01 -0000
@@ -1954,22 +1954,28 @@
 				const snd_usb_audio_quirk_t *quirk);

 /*
- * handle the quirk(s) for the current interface
+ * handle the quirks for the contained interfaces
  */
 static int create_composite_quirk(snd_usb_audio_t *chip,
 				  struct usb_interface *iface,
 				  const snd_usb_audio_quirk_t *quirk)
 {
-	struct usb_host_interface *alts = &iface->altsetting[0];
-	int ifnum = get_iface_desc(alts)->bInterfaceNumber;
+	struct usb_config_descriptor *config = chip->dev->actconfig;
+	int probed_ifnum = get_iface_desc(iface->altsetting)->bInterfaceNumber;
 	int err;

 	for (quirk = quirk->data; quirk->ifnum >= 0; ++quirk) {
-		if (quirk->ifnum == ifnum) {
-			err = snd_usb_create_quirk(chip, iface, quirk);
-			if (err < 0)
-				return err;
-		}
+		if (quirk->ifnum >= config->bNumInterfaces)
+			continue;
+		iface = &config->interface[quirk->ifnum];
+		if (quirk->ifnum != probed_ifnum &&
+		    usb_interface_claimed(iface))
+			continue;
+		err = snd_usb_create_quirk(chip, iface, quirk);
+		if (err < 0)
+			return err;
+		if (quirk->ifnum != probed_ifnum)
+			usb_driver_claim_interface(&usb_audio_driver, iface, (void *)-1);
 	}
 	return 0;
 }



-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
