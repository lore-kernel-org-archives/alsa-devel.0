From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd-usb-audio and midisport1x1 little hack fixes
 hotplug pb
Date: Tue, 16 Mar 2004 18:03:49 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0403161750550.9632-100000@studcom.urz.uni-halle.de>
References: <20040313043234.49d783bb.geli@enseirb.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20040313043234.49d783bb.geli@enseirb.fr>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mathieu Geli <geli@enseirb.fr>
Cc: nwgbh@swissonline.ch, Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Mathieu Geli wrote:
> Ok, I applied your second patch, and get this dmesg output:
>
> drivers/usb/core/usb.c: deregistering driver snd-usb-audio
> ALSA /home/mathieu/alsa-driver/usb/usbaudio.c:2944: snd_usb_audio_disconnect called, refcount = 1
> ALSA /home/mathieu/alsa-driver/usb/usbaudio.c:2944: snd_usb_audio_disconnect called, refcount = 0

Two calls to disconnect?  Strange.

> ALSA /home/mathieu/alsa-driver/alsa-kernel/usb/usbmidi.c:148: urb status -104
> ALSA /home/mathieu/alsa-driver/alsa-kernel/usb/usbmidi.c:134: usb_submit_urb: -32

The driver tries to resubmit the URB although the device is being shut
down.  I don't think this causes the hang, but the patch below
(already in CVS) fixes this.  (-104 is -ECONNRESET which shouldn't
occur when unlinking synchronously.)

Apparently, snd_usb_audio_disconnect hangs before returning.  Please
try to insert printk's in snd_usbmidi_disconnect as Takashi suggestes.


Regards,
Clemens

-- 
diff -u -r1.25 -r1.26
--- alsa-kernel/usb/usbmidi.c	8 Mar 2004 09:34:05 -0000	1.25
+++ alsa-kernel/usb/usbmidi.c	16 Mar 2004 16:36:05 -0000	1.26
@@ -143,8 +143,9 @@
 	if (status == -ENOENT)
 		return status; /* killed */
 	if (status == -EILSEQ ||
+	    status == -ECONNRESET ||
 	    status == -ETIMEDOUT)
-		return -ENODEV; /* device removed */
+		return -ENODEV; /* device removed/shutdown */
 	snd_printk(KERN_ERR "urb status %d\n", status);
 	return 0; /* continue */
 }
@@ -706,7 +707,6 @@
 	int i;

 	umidi = list_entry(p, snd_usb_midi_t, list);
-	usb_driver_release_interface(driver, umidi->iface);
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
 		snd_usb_midi_endpoint_t* ep = &umidi->endpoints[i];
 		if (ep->out && ep->out->urb)
@@ -714,6 +714,7 @@
 		if (ep->in && ep->in->urb)
 			usb_unlink_urb(ep->in->urb);
 	}
+	usb_driver_release_interface(driver, umidi->iface);
 }

 static void snd_usbmidi_rawmidi_free(snd_rawmidi_t* rmidi)




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
