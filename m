From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] usbaudio.c steals interfaces from other drivers
Date: Wed, 18 Sep 2002 14:52:31 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0209181438180.20324-100000@studcom.urz.uni-halle.de>
References: <Pine.HPX.4.33n.0209181036450.6852-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.HPX.4.33n.0209181036450.6852-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


The USB audio driver claims the streaming interfaces of the device even if
they have already been claimed by another driver. (See the thread
"snd-usb-midi, midi input, oss, oops!" for the gory details.)


Index: usbaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.c,v
retrieving revision 1.8
diff -u -r1.8 usbaudio.c
--- alsa-kernel/usb/usbaudio.c	13 Sep 2002 08:39:08 -0000	1.8
+++ alsa-kernel/usb/usbaudio.c	18 Sep 2002 12:35:47 -0000
@@ -1829,6 +1829,10 @@
 			continue;
 		}
 		iface = &config->interface[j];
+		if (usb_interface_claimed(iface)) {
+			snd_printdd(KERN_INFO "%d:%d:%d: skipping, already claimed\n", dev->devnum, ctrlif, j);
+			continue;
+		}
 		if (iface->altsetting[0].bInterfaceClass == USB_CLASS_AUDIO &&
 		    iface->altsetting[0].bInterfaceSubClass == USB_SUBCLASS_MIDI_STREAMING) {
 			if (snd_usb_create_midi_interface(chip, j, NULL) < 0) {



-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
