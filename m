From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] USB MIDI bugs
Date: Mon, 11 Nov 2002 09:15:14 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0211110905510.16551-100000@studcom.urz.uni-halle.de>
References: <20021108100427.GA502@tuba.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20021108100427.GA502@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: perex@suse.cz
List-Id: alsa-devel@alsa-project.org


This fixes sequencer input from USB MIDI. Both usbmidi.c and seq_midi.c
thought they could use substream->runtime->private_data for themselves.

Additionally, interrupt transfer resubmissions for kernels before 2.5.45
are removed again.

-- 
Clemens



Index: alsa-driver/include/adriver.h
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/include/adriver.h,v
retrieving revision 1.22
diff -u -r1.22 adriver.h
--- alsa-driver/include/adriver.h	1 Nov 2002 13:25:22 -0000	1.22
+++ alsa-driver/include/adriver.h	11 Nov 2002 08:02:40 -0000
@@ -258,6 +258,10 @@
 #define get_cfg_desc(cfg)	(cfg)
 #endif

+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 45)
+#define usb_pipe_needs_resubmit(pipe) (!usb_pipeint(pipe))
+#endif
+
 #endif /* SND_NEED_USB_WRAPPER && CONFIG_USB */

 #include "amagic.h"


Index: alsa-kernel/usb/usbaudio.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.h,v
retrieving revision 1.7
diff -u -r1.7 usbaudio.h
--- alsa-kernel/usb/usbaudio.h	1 Nov 2002 13:25:01 -0000	1.7
+++ alsa-kernel/usb/usbaudio.h	11 Nov 2002 08:03:33 -0000
@@ -202,4 +202,8 @@
 #define get_cfg_desc(cfg)	(&(cfg)->desc)
 #endif

+#ifndef usb_pipe_needs_resubmit
+#define usb_pipe_needs_resubmit(pipe) 1
+#endif
+
 #endif /* __USBAUDIO_H */
Index: alsa-kernel/usb/usbmidi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbmidi.c,v
retrieving revision 1.9
diff -u -r1.9 usbmidi.c
--- alsa-kernel/usb/usbmidi.c	1 Nov 2002 13:25:01 -0000	1.9
+++ alsa-kernel/usb/usbmidi.c	11 Nov 2002 08:03:33 -0000
@@ -114,7 +114,6 @@
 	struct urb* urb;
 	struct usbmidi_in_port {
 		snd_rawmidi_substream_t* substream;
-		int active;
 	} ports[0x10];
 };

@@ -159,7 +158,12 @@
 	int cable = packet[0] >> 4;
 	usbmidi_in_port_t* port = &ep->ports[cable];

-	if (!port->active)
+	if (!port->substream) {
+		snd_printd("unexpected port %d!\n", cable);
+		return;
+	}
+	if (!port->substream->runtime ||
+	    !port->substream->runtime->trigger)
 		return;
 	snd_rawmidi_receive(port->substream, &packet[1],
 			    snd_usbmidi_cin_length[packet[0] & 0x0f]);
@@ -184,8 +188,10 @@
 			return;
 	}

-	urb->dev = ep->umidi->chip->dev;
-	snd_usbmidi_submit_urb(urb, GFP_ATOMIC);
+	if (usb_pipe_needs_resubmit(urb->pipe)) {
+		urb->dev = ep->umidi->chip->dev;
+		snd_usbmidi_submit_urb(urb, GFP_ATOMIC);
+	}
 }

 /*
@@ -451,20 +457,6 @@

 static int snd_usbmidi_input_open(snd_rawmidi_substream_t* substream)
 {
-	snd_usb_midi_t* umidi = snd_magic_cast(snd_usb_midi_t, substream->rmidi->private_data, return -ENXIO);
-	usbmidi_in_port_t* port = NULL;
-	int i, j;
-
-	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i)
-		if (umidi->endpoints[i].in)
-			for (j = 0; j < 0x10; ++j)
-				if (umidi->endpoints[i].in->ports[j].substream == substream) {
-					port = &umidi->endpoints[i].in->ports[j];
-					break;
-				}
-	if (!port)
-		return -ENXIO;
-	substream->runtime->private_data = port;
 	return 0;
 }

@@ -475,9 +467,6 @@

 static void snd_usbmidi_input_trigger(snd_rawmidi_substream_t* substream, int up)
 {
-	usbmidi_in_port_t* port = (usbmidi_in_port_t*)substream->runtime->private_data;
-
-	port->active = up;
 }

 static snd_rawmidi_ops_t snd_usbmidi_output_ops = {




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
