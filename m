From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: M-Audio Qattro USB
Date: Tue, 18 Jan 2005 10:16:48 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0501181009230.218-100000@studcom.urz.uni-halle.de>
References: <1106028964.41eca9a4b23a3@www3.webhosting.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mailgate.urz.uni-halle.de [141.48.3.51])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EDDC325E
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2005 10:16:49 +0100 (MET)
In-Reply-To: <1106028964.41eca9a4b23a3@www3.webhosting.cx>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: Michael Hoffer <info@michaelhoffer.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Patrick Shirkey wrote:

> Quoting Michael Hoffer <info@michaelhoffer.de>:
>
> > bash-2.05b$ arecord -D quattro -f S24_3LE -r 96000 -c 2 -d 10 test.raw
> > Recording WAVE 'test.raw' : Signed 24 bit Little Endian in 3bytes, Rate 96000
> > Hz, Stereo
> > arecord: set_params:854: Sample format non available

What sample formats appear in /proc/asound/cardX/stream0, 1?

> It's possible the alsa drivers you are using had a broken implementation.

I just committed a patch against 1.0.8 which should improve the
behaviour in some cases (I don't know if it is related to this
problem).


Clemens

-- 
Index: alsa-kernel/usb/usbaudio.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.h,v
retrieving revision 1.35
retrieving revision 1.36
diff -u -r1.35 -r1.36
--- alsa-kernel/usb/usbaudio.h	30 Sep 2004 10:11:25 -0000	1.35
+++ alsa-kernel/usb/usbaudio.h	17 Jan 2005 17:41:38 -0000	1.36
@@ -157,6 +157,7 @@
 #define QUIRK_MIDI_STANDARD_INTERFACE	6
 #define QUIRK_AUDIO_EDIROL_UA700_UA25	7
 #define QUIRK_AUDIO_EDIROL_UA1000	8
+#define QUIRK_IGNORE_INTERFACE		9

 typedef struct snd_usb_audio_quirk snd_usb_audio_quirk_t;
 typedef struct snd_usb_midi_endpoint_info snd_usb_midi_endpoint_info_t;
@@ -190,6 +191,8 @@

 /* for QUIRK_AUDIO_EDIROL_UA700_UA25/UA1000, data is NULL */

+/* for QUIRK_IGNORE_INTERFACE, data is null */
+
 /*
  */

Index: alsa-kernel/usb/usbaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.c,v
retrieving revision 1.113
retrieving revision 1.114
diff -u -r1.113 -r1.114
--- alsa-kernel/usb/usbaudio.c	16 Dec 2004 16:12:51 -0000	1.113
+++ alsa-kernel/usb/usbaudio.c	17 Jan 2005 17:41:34 -0000	1.114
@@ -2977,6 +2977,8 @@
 		return create_ua700_ua25_quirk(chip, iface);
 	case QUIRK_AUDIO_EDIROL_UA1000:
 		return create_ua1000_quirk(chip, iface);
+	case QUIRK_IGNORE_INTERFACE:
+		return 0;
 	default:
 		snd_printd(KERN_ERR "invalid quirk type %d\n", quirk->type);
 		return -ENXIO;
Index: alsa-kernel/usb/usbquirks.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbquirks.h,v
retrieving revision 1.38
retrieving revision 1.39
diff -u -r1.38 -r1.39
--- alsa-kernel/usb/usbquirks.h	30 Sep 2004 10:11:25 -0000	1.38
+++ alsa-kernel/usb/usbquirks.h	17 Jan 2005 17:41:38 -0000	1.39
@@ -876,6 +876,22 @@
 			 * but captured samples are big-endian (see usbaudio.c).
 			 */
 			{
+				.ifnum = 0,
+				.type = QUIRK_IGNORE_INTERFACE
+			},
+			{
+				.ifnum = 1,
+				.type = QUIRK_IGNORE_INTERFACE
+			},
+			{
+				.ifnum = 2,
+				.type = QUIRK_IGNORE_INTERFACE
+			},
+			{
+				.ifnum = 3,
+				.type = QUIRK_IGNORE_INTERFACE
+			},
+			{
 				.ifnum = 4,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
 			},
@@ -884,6 +900,10 @@
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
 			},
 			{
+				.ifnum = 6,
+				.type = QUIRK_IGNORE_INTERFACE
+			},
+			{
 				.ifnum = 7,
 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
 			},
@@ -936,11 +956,56 @@
 	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
 		.vendor_name = "M-Audio",
 		.product_name = "OmniStudio",
-		.ifnum = 9,
-		.type = QUIRK_MIDI_MIDIMAN,
-		.data = & (const snd_usb_midi_endpoint_info_t) {
-			.out_cables = 0x0001,
-			.in_cables  = 0x0001
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = & (const snd_usb_audio_quirk_t[]) {
+			{
+				.ifnum = 0,
+				.type = QUIRK_IGNORE_INTERFACE
+			},
+			{
+				.ifnum = 1,
+				.type = QUIRK_IGNORE_INTERFACE
+			},
+			{
+				.ifnum = 2,
+				.type = QUIRK_IGNORE_INTERFACE
+			},
+			{
+				.ifnum = 3,
+				.type = QUIRK_IGNORE_INTERFACE
+			},
+			{
+				.ifnum = 4,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+			},
+			{
+				.ifnum = 5,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+			},
+			{
+				.ifnum = 6,
+				.type = QUIRK_IGNORE_INTERFACE
+			},
+			{
+				.ifnum = 7,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+			},
+			{
+				.ifnum = 8,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+			},
+			{
+				.ifnum = 9,
+				.type = QUIRK_MIDI_MIDIMAN,
+				.data = & (const snd_usb_midi_endpoint_info_t) {
+					.out_cables = 0x0001,
+					.in_cables  = 0x0001
+				}
+			},
+			{
+				.ifnum = -1
+			}
 		}
 	}
 },



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
