From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Omnistudio USB
Date: Fri, 14 Jan 2005 12:34:01 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0501141230020.25187-100000@studcom.urz.uni-halle.de>
References: <1105563002.14697.45.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1105563002.14697.45.camel@localhost>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rusty Phillips <rustyp@freeshell.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Rusty Phillips wrote:
> Okay, I've been trying most of my testing with the first two channels.
>
> However, I just figured out that recording and playback works on
> channels #3 and #4 at 96000.

The first two channels use an additional 16-bit interface, probably
for compatibility with the Windows USB Audio driver.

Please try the patch below.


HTH
Clemens

-- 
Index: alsa-kernel/usb/usbaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.c,v
retrieving revision 1.113
diff -u -r1.113 usbaudio.c
--- alsa-kernel/usb/usbaudio.c	16 Dec 2004 16:12:51 -0000	1.113
+++ alsa-kernel/usb/usbaudio.c	14 Jan 2005 10:16:31 -0000
@@ -2977,6 +2977,8 @@
 		return create_ua700_ua25_quirk(chip, iface);
 	case QUIRK_AUDIO_EDIROL_UA1000:
 		return create_ua1000_quirk(chip, iface);
+	case QUIRK_IGNORE_INTERFACE:
+		return 0;
 	default:
 		snd_printd(KERN_ERR "invalid quirk type %d\n", quirk->type);
 		return -ENXIO;
Index: alsa-kernel/usb/usbaudio.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.h,v
retrieving revision 1.35
diff -u -r1.35 usbaudio.h
--- alsa-kernel/usb/usbaudio.h	30 Sep 2004 10:11:25 -0000	1.35
+++ alsa-kernel/usb/usbaudio.h	14 Jan 2005 10:16:31 -0000
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

Index: alsa-kernel/usb/usbquirks.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbquirks.h,v
retrieving revision 1.38
diff -u -r1.38 usbquirks.h
--- alsa-kernel/usb/usbquirks.h	30 Sep 2004 10:11:25 -0000	1.38
+++ alsa-kernel/usb/usbquirks.h	14 Jan 2005 10:16:31 -0000
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
