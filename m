From: Mathieu Geli <geli@enseirb.fr>
Subject: Re: snd-usb-audio and midisport1x1 little hack fixes
 hotplug pb
Date: Sat, 13 Mar 2004 04:32:34 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040313043234.49d783bb.geli@enseirb.fr>
References: <20040311204610.3766f038.geli@enseirb.fr>
	<Pine.HPX.4.33n.0403121305470.14417-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0403121305470.14417-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: clemens@ladisch.de, nwgbh@swissonline.ch
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ok, I applied your second patch, and get this dmesg output:

drivers/usb/core/usb.c: deregistering driver snd-usb-audio
ALSA /home/mathieu/alsa-driver/usb/usbaudio.c:2944: snd_usb_audio_disconnect called, refcount = 1
ALSA /home/mathieu/alsa-driver/usb/usbaudio.c:2944: snd_usb_audio_disconnect called, refcount = 0
ALSA /home/mathieu/alsa-driver/alsa-kernel/usb/usbmidi.c:148: urb status -104
ALSA /home/mathieu/alsa-driver/alsa-kernel/usb/usbmidi.c:134: usb_submit_urb: -32

At this point the usb was down not responding anymore, like in the past.

what I did next, is put double each interesting lines printk, what I get is, that the rmmod of the driver was hanging on the midi ressources cleaning stuff.
Hum, first reflex: I just comment out those 3 lines =) and guess what.. that works fine now. I tried to plug/unplug several times my mouse, the midisport, and everything
works fine, so... I don't really know what was the bug's reason, but as long as that works I'm happy ;-)
Probably Takashi Iwai who seems to has coded it should once have a look to understand the 'why' question.

Cheers,

Mathieu 
--


Here is finally the modifications I applied:

--- alsa-kernel/usb/usbmidi.c	3 Mar 2004 11:35:15 -0000	1.24
+++ alsa-kernel/usb/usbmidi.c	8 Mar 2004 09:34:05 -0000	1.25
@@ -453,8 +453,16 @@
 	usbmidi_out_port_t* port = (usbmidi_out_port_t*)substream->runtime->private_data;

 	port->active = up;
-	if (up)
+	if (up) {
+		if (port->ep->umidi->chip->shutdown) {
+			/* gobble up remaining bytes to prevent wait in
+			 * snd_rawmidi_drain_output */
+			while (!snd_rawmidi_transmit_empty(substream))
+				snd_rawmidi_transmit_ack(substream, 1);
+			return;
+		}
 		tasklet_hi_schedule(&port->ep->tasklet);
+	}
 }

 static int snd_usbmidi_input_open(snd_rawmidi_substream_t* substream)


--- alsa-kernel/usb/usbaudio.c	2004-03-11 21:00:25.000000000 +0100
+++ alsa-kernel/usb/usbaudio.c	2004-03-13 04:01:06.000000000 +0100
@@ -2939,9 +2939,9 @@
                        snd_usb_stream_disconnect(p, &usb_audio_driver);
                }
                /* release the midi resources */
-               list_for_each(p, &chip->midi_list) {
-                       snd_usbmidi_disconnect(p, &usb_audio_driver);
-               }
+               /* list_for_each(p, &chip->midi_list) { */
+               /* snd_usbmidi_disconnect(p, &usb_audio_driver); */
+               /* } */
                up(&register_mutex);
                snd_card_free_in_thread(card);
        } else {


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
