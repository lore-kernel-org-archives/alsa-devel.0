From: Cyrus Harmon <cyrus@bobobeach.com>
Subject: [PATCH] add Steinberg UR44 USB Audio Interface support
	to quirks-table.
Date: Mon, 10 Mar 2014 08:37:55 -0700
Message-ID: <1394465875-3932-1-git-send-email-cyrus@bobobeach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.cyrusharmon.org (unknown [206.125.171.163])
 by alsa0.perex.cz (Postfix) with ESMTP id 2224926571F
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 16:38:15 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Cyrus Harmon <cyrus@bobobeach.com>
List-Id: alsa-devel@alsa-project.org

 * The patch is based on Clemens Ladisch's patch to support the UR22
   (http://linuxaudio.org/mailarchive/lad/2013/2/23/197831), with the
   device ID modified for the UR44. The patch was tested with kernel
   versions 3.12.11 and 3.12.12 and a PREEMPT RT-patched 3.12.12-rt
   kernel. Basic recording and playback appear to work.

 * NB: On one of the systems that I used to test the patch, I was
   never able to achieve xrun-free JACK performance at -p256 -n3 as I
   would invariably see xruns roughly once every minute. But this is a
   new box (Intel haswell NUC) and it seems there are many possible
   sources of the unacceptable latency. On an older i3 box, the
   performance was much better.

Signed-off-by: Cyrus Harmon <cyrus@bobobeach.com>
---
 sound/usb/quirks-table.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index f652b10..987ca01 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -436,6 +436,36 @@ YAMAHA_DEVICE(0x105d, NULL),
 		}
 	}
 },
+{
+	USB_DEVICE(0x0499, 0x150e),
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		/* .vendor_name = "Yamaha", */
+		/* .product_name = "Steinberg UR44", */
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 1,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+			},
+			{
+				.ifnum = 2,
+				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+			},
+			{
+				.ifnum = 3,
+				.type = QUIRK_MIDI_YAMAHA
+			},
+			{
+				.ifnum = 4,
+				.type = QUIRK_IGNORE_INTERFACE
+			},
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
 YAMAHA_DEVICE(0x2000, "DGP-7"),
 YAMAHA_DEVICE(0x2001, "DGP-5"),
 YAMAHA_DEVICE(0x2002, NULL),
-- 
1.8.3.2
