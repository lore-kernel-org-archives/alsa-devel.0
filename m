From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] add USB MIDI port names
Date: Mon, 23 Feb 2004 10:10:22 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0402231008300.20713-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


- add device-specific port names
- begin numbering ports at 1


Index: alsa-kernel/usb/usbmidi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbmidi.c,v
retrieving revision 1.22
diff -u -r1.22 usbmidi.c
--- alsa-kernel/usb/usbmidi.c	26 Jan 2004 14:19:24 -0000	1.22
+++ alsa-kernel/usb/usbmidi.c	23 Feb 2004 08:27:42 -0000
@@ -1,7 +1,7 @@
 /*
  * usbmidi.c - ALSA USB MIDI driver
  *
- * Copyright (c) 2002 Clemens Ladisch
+ * Copyright (c) 2002-2004 Clemens Ladisch
  * All rights reserved.
  *
  * Based on the OSS usb-midi driver by NAGANO Daisuke,
@@ -727,18 +727,92 @@
 	return NULL;
 }

+/*
+ * This list specifies names for ports that do not fit into the standard
+ * "(product) MIDI (n)" schema because they aren't external MIDI ports,
+ * such as internal control or synthesizer ports.
+ */
+static struct {
+	__u16 vendor;
+	__u16 product;
+	int port;
+	const char *name_format;
+} snd_usbmidi_port_names[] = {
+	/* Roland UA-100 */
+	{0x0582, 0x0000, 2, "%s Control"},
+	/* Roland SC-8850 */
+	{0x0582, 0x0003, 0, "%s Part A"},
+	{0x0582, 0x0003, 1, "%s Part B"},
+	{0x0582, 0x0003, 2, "%s Part C"},
+	{0x0582, 0x0003, 3, "%s Part D"},
+	{0x0582, 0x0003, 4, "%s MIDI 1"},
+	{0x0582, 0x0003, 5, "%s MIDI 2"},
+	/* Roland U-8 */
+	{0x0582, 0x0004, 1, "%s Control"},
+	/* Roland SC-8820 */
+	{0x0582, 0x0007, 0, "%s Part A"},
+	{0x0582, 0x0007, 1, "%s Part B"},
+	{0x0582, 0x0007, 2, "%s MIDI"},
+	/* Roland SK-500 */
+	{0x0582, 0x000b, 0, "%s Part A"},
+	{0x0582, 0x000b, 1, "%s Part B"},
+	{0x0582, 0x000b, 2, "%s MIDI"},
+	/* Roland SC-D70 */
+	{0x0582, 0x000c, 0, "%s Part A"},
+	{0x0582, 0x000c, 1, "%s Part B"},
+	{0x0582, 0x000c, 2, "%s MIDI"},
+	/* Edirol UM-880 */
+	{0x0582, 0x0014, 8, "%s Control"},
+	/* Edirol SD-90 */
+	{0x0582, 0x0016, 0, "%s Part A"},
+	{0x0582, 0x0016, 1, "%s Part B"},
+	{0x0582, 0x0016, 2, "%s MIDI 1"},
+	{0x0582, 0x0016, 3, "%s MIDI 2"},
+	/* Edirol UM-550 */
+	{0x0582, 0x0023, 5, "%s Control"},
+	/* Edirol SD-20 */
+	{0x0582, 0x0027, 0, "%s Part A"},
+	{0x0582, 0x0027, 1, "%s Part B"},
+	{0x0582, 0x0027, 2, "%s MIDI"},
+	/* Edirol SD-80 */
+	{0x0582, 0x0029, 0, "%s Part A"},
+	{0x0582, 0x0029, 1, "%s Part B"},
+	{0x0582, 0x0029, 2, "%s MIDI 1"},
+	{0x0582, 0x0029, 3, "%s MIDI 2"},
+	/* M-Audio MidiSport 8x8 */
+	{0x0763, 0x1031, 8, "%s Control"},
+	{0x0763, 0x1033, 8, "%s Control"},
+};
+
 static void snd_usbmidi_init_substream(snd_usb_midi_t* umidi,
 				       int stream, int number,
 				       snd_rawmidi_substream_t** rsubstream)
 {
+	int i;
+	__u16 vendor, product;
+	const char *name_format;
+
 	snd_rawmidi_substream_t* substream = snd_usbmidi_find_substream(umidi, stream, number);
 	if (!substream) {
 		snd_printd(KERN_ERR "substream %d:%d not found\n", stream, number);
 		return;
 	}
+
 	/* TODO: read port name from jack descriptor */
+	name_format = "%s MIDI %d";
+	vendor = umidi->chip->dev->descriptor.idVendor;
+	product = umidi->chip->dev->descriptor.idProduct;
+	for (i = 0; i < ARRAY_SIZE(snd_usbmidi_port_names); ++i) {
+		if (snd_usbmidi_port_names[i].vendor == vendor &&
+		    snd_usbmidi_port_names[i].product == product &&
+		    snd_usbmidi_port_names[i].port == number) {
+			name_format = snd_usbmidi_port_names[i].name_format;
+			break;
+		}
+	}
 	snprintf(substream->name, sizeof(substream->name),
-		 "%s Port %d", umidi->chip->card->shortname, number);
+		 name_format, umidi->chip->card->shortname, number + 1);
+
 	*rsubstream = substream;
 }





-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
