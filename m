From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fix usb midi crash
Date: Mon, 13 Jan 2003 09:49:30 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0301130925050.3084-100000@studcom.urz.uni-halle.de>
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

Revision 1.14 of usbmidi.c added checks for chip->shutdown ("to be sure"),
but chip->shutdown is always 1 when unloading, so the URBs didn't get
unlinked at all. This caused random crashes later.

This patch adds a hook to unlink the URBs, at the same time as the PCM
URBs.

Additionally, the card's longname now includes again the device number (as
suggested by Pedro).


-- 


- unlink URBs when disconnecting (like PCM)
- add device path to card longname


Index: alsa-driver/include/adriver.h
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/include/adriver.h,v
retrieving revision 1.27
diff -u -r1.27 adriver.h
--- alsa-driver/include/adriver.h	19 Dec 2002 17:14:01 -0000	1.27
+++ alsa-driver/include/adriver.h	13 Jan 2003 08:37:28 -0000
@@ -227,6 +227,15 @@

 #include <linux/usb.h>

+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 4, 20)
+inline static int usb_make_path(struct usb_device *dev, char *buf, size_t size)
+{
+	int actual;
+	actual = snprintf(buf, size, "%03d/%03d", dev->bus->busnum, dev->devnum);
+	return (actual >= size) ? -1 : actual;
+}
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
 inline static struct urb *usb_alloc_urb_wrapper(int iso_packets, int flags)
 {
@@ -240,6 +249,7 @@
 #undef usb_submit_urb
 #define usb_alloc_urb(n,flags) usb_alloc_urb_wrapper(n,flags)
 #define usb_submit_urb(p,flags) usb_submit_urb_wrapper(p,flags)
 #define OLD_USB
 #endif /* LINUX_VERSION_CODE < 2.5.0 */

Index: alsa-kernel/usb/usbaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.c,v
retrieving revision 1.34
diff -u -r1.34 usbaudio.c
--- alsa-kernel/usb/usbaudio.c	10 Jan 2003 10:31:57 -0000	1.34
+++ alsa-kernel/usb/usbaudio.c	13 Jan 2003 08:37:44 -0000
@@ -2053,6 +2053,7 @@
 	chip->dev = dev;
 	chip->card = card;
 	INIT_LIST_HEAD(&chip->pcm_list);
+	INIT_LIST_HEAD(&chip->midi_list);

 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
 		snd_usb_audio_free(chip);
@@ -2104,6 +2105,13 @@
 		strncpy(card->longname + len, quirk->product_name, sizeof(card->longname) - len - 1);
 		card->longname[sizeof(card->longname) - 1] = '\0';
 	}
+	/* add device path to longname */
+	len = strlen(card->longname);
+	if (sizeof(card->longname) - len > 10) {
+		strcpy(card->longname + len, " at ");
+		len += 4;
+		usb_make_path(dev, card->longname + len, sizeof(card->longname) - len);
+	}

 	*rchip = chip;
 	return 0;
@@ -2294,6 +2302,10 @@
 					continue;
 				release_substream_urbs(subs);
 			}
+		}
+		/* release the midi resources */
+		list_for_each(p, &chip->midi_list) {
+			snd_usbmidi_disconnect(p);
 		}
 		up(&register_mutex);
 		snd_card_free_in_thread(card);
Index: alsa-kernel/usb/usbaudio.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.h,v
retrieving revision 1.12
diff -u -r1.12 usbaudio.h
--- alsa-kernel/usb/usbaudio.h	10 Jan 2003 10:31:57 -0000	1.12
+++ alsa-kernel/usb/usbaudio.h	13 Jan 2003 08:37:44 -0000
@@ -139,6 +139,7 @@
 	struct list_head pcm_list;	/* list of pcm streams */
 	int pcm_devs;

+	struct list_head midi_list;	/* list of midi interfaces */
 	int next_midi_device;
 };

@@ -192,6 +193,7 @@
 int snd_usb_create_mixer(snd_usb_audio_t *chip, int ctrlif, unsigned char *buffer, int buflen);

 int snd_usb_create_midi_interface(snd_usb_audio_t *chip, struct usb_interface *iface, const snd_usb_audio_quirk_t *quirk);
+void snd_usbmidi_disconnect(struct list_head *p);

 /*
  * retrieve usb_interface descriptor from the host interface
Index: alsa-kernel/usb/usbmidi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbmidi.c,v
retrieving revision 1.17
diff -u -r1.17 usbmidi.c
--- alsa-kernel/usb/usbmidi.c	10 Jan 2003 10:31:58 -0000	1.17
+++ alsa-kernel/usb/usbmidi.c	13 Jan 2003 08:37:44 -0000
@@ -77,6 +77,7 @@
 	struct usb_interface *iface;
 	const snd_usb_audio_quirk_t *quirk;
 	snd_rawmidi_t* rmidi;
+	struct list_head list;

 	struct snd_usb_midi_endpoint {
 		snd_usb_midi_out_endpoint_t *out;
@@ -394,7 +395,7 @@
 	unsigned long flags;

 	spin_lock_irqsave(&ep->buffer_lock, flags);
-	if (urb->status == -EINPROGRESS) {
+	if (urb->status == -EINPROGRESS || ep->umidi->chip->shutdown) {
 		spin_unlock_irqrestore(&ep->buffer_lock, flags);
 		return;
 	}
@@ -451,10 +452,8 @@
 	usbmidi_out_port_t* port = (usbmidi_out_port_t*)substream->runtime->private_data;

 	port->active = up;
-	if (up) {
-		if (! port->ep->umidi->chip->shutdown) /* to be sure... */
-			tasklet_hi_schedule(&port->ep->tasklet);
-	}
+	if (up)
+		tasklet_hi_schedule(&port->ep->tasklet);
 }

 static int snd_usbmidi_input_open(snd_rawmidi_substream_t* substream)
@@ -490,11 +489,8 @@
 static void snd_usbmidi_in_endpoint_delete(snd_usb_midi_in_endpoint_t* ep)
 {
 	if (ep->urb) {
-		if (ep->urb->transfer_buffer) {
-			if (! ep->umidi->chip->shutdown) /* to be sure */
-				usb_unlink_urb(ep->urb);
+		if (ep->urb->transfer_buffer)
 			kfree(ep->urb->transfer_buffer);
-		}
 		usb_free_urb(ep->urb);
 	}
 	snd_magic_kfree(ep);
@@ -619,11 +615,8 @@
 	if (ep->tasklet.func)
 		tasklet_kill(&ep->tasklet);
 	if (ep->urb) {
-		if (ep->urb->transfer_buffer) {
-			if (! ep->umidi->chip->shutdown) /* to be sure */
-				usb_unlink_urb(ep->urb);
+		if (ep->urb->transfer_buffer)
 			kfree(ep->urb->transfer_buffer);
-		}
 		usb_free_urb(ep->urb);
 	}
 	snd_magic_kfree(ep);
@@ -693,6 +686,24 @@
 	snd_magic_kfree(umidi);
 }

+/*
+ * Unlinks all URBs (must be done before the usb_device is deleted).
+ */
+void snd_usbmidi_disconnect(struct list_head* p)
+{
+	snd_usb_midi_t* umidi;
+	int i;
+
+	umidi = list_entry(p, snd_usb_midi_t, list);
+	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
+		snd_usb_midi_endpoint_t* ep = &umidi->endpoints[i];
+		if (ep->out && ep->out->urb)
+			usb_unlink_urb(ep->out->urb);
+		if (ep->in && ep->in->urb)
+			usb_unlink_urb(ep->in->urb);
+	}
+}
+
 static void snd_usbmidi_rawmidi_free(snd_rawmidi_t* rmidi)
 {
 	snd_usb_midi_t* umidi = snd_magic_cast(snd_usb_midi_t, rmidi->private_data, return);
@@ -994,7 +1005,7 @@
 			      out_ports, in_ports, &rmidi);
 	if (err < 0)
 		return err;
-	strcpy(rmidi->name, umidi->chip->card->longname);
+	strcpy(rmidi->name, umidi->chip->card->shortname);
 	rmidi->info_flags = SNDRV_RAWMIDI_INFO_OUTPUT |
 			    SNDRV_RAWMIDI_INFO_INPUT |
 			    SNDRV_RAWMIDI_INFO_DUPLEX;
@@ -1078,6 +1089,8 @@
 		snd_usbmidi_free(umidi);
 		return err;
 	}
+
+	list_add(&umidi->list, &umidi->chip->midi_list);

 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i)
 		if (umidi->endpoints[i].in)




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
