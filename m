From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd-usb-audio hang when rmmoding after unplugging
 midisport1x1
Date: Thu, 11 Mar 2004 16:46:09 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0403111635570.18812-100000@studcom.urz.uni-halle.de>
References: <20040311151651.217ccc07.geli@enseirb.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20040311151651.217ccc07.geli@enseirb.fr>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mathieu Geli <geli@enseirb.fr>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Mathieu Geli wrote:
> I'm trying to plug/unplug the midisport1x1 from M-Audio. The plug
> works like a charm, hotplug does its job, load the firmware
> (fxload) and snd-usb-audio, if not inserted, is auto-loaded. But
> <hen I unplug the device, and I want to plug it again, the usb
> just hang, trying to rmmoding snd-usb-audio or anything else usb
> related will just hang.

There was a bug which has been fixed three days ago (after 1.0.3 came
out).  Either get the latest version from the CVS, or apply the patch
below.


HTH
Clemens

-- 

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




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
