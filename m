From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH] usb-audio: ignore-quirk for HP Wireless Audio
Date: Sat, 15 Dec 2012 05:30:33 +0100
Message-ID: <1355545833-8654-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F874264F42
 for <alsa-devel@alsa-project.org>; Sat, 15 Dec 2012 05:30:40 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so1997662bkc.38
 for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2012 20:30:39 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Isaac Smith <hunternet93@gmail.com>, alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>, Joe Cooper <swelljoe@gmail.com>
List-Id: alsa-devel@alsa-project.org

As Joe Cooper <swelljoe@gmail.com> reported, "On most HP Envy laptops
the snd-usb-audio module causes the system to become unresponsive and
Gnome Shell 3 to crash.".
See also:
 http://mailman.alsa-project.org/pipermail/alsa-devel/2012-December/057729.html

Add a quirk to ignore this device (for now) to solve the instability
issue and allow other USB audio devices to be used.

Reported-by: Joe Cooper <swelljoe@gmail.com>
Tested-by: Isaac Smith <hunternet93@gmail.com>
Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/quirks-table.h |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

Applies against mainline 3.7.0 and sound-3.8.

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 49f9af9..e3c59f0 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -99,6 +99,42 @@
 },
 
 /*
+ * HP Wireless Audio
+ * When not ignored, causes instability issues for some users, forcing them to
+ * blacklist the entire module.
+ */
+{
+	USB_DEVICE(0x0424, 0xb832),
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.vendor_name = "Standard Microsystems Corp.",
+		.product_name = "HP Wireless Audio",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const struct snd_usb_audio_quirk[]) {
+			/* Mixer */
+			{
+				.ifnum = 0,
+				.type = QUIRK_IGNORE_INTERFACE,
+			},
+			/* Playback */
+			{
+				.ifnum = 1,
+				.type = QUIRK_IGNORE_INTERFACE,
+			},
+			/* Capture */
+			{
+				.ifnum = 2,
+				.type = QUIRK_IGNORE_INTERFACE,
+			},
+			/* HID Device, .ifnum = 3 */
+			{
+				.ifnum = -1,
+			}
+		}
+	}
+},
+
+/*
  * Logitech QuickCam: bDeviceClass is vendor-specific, so generic interface
  * class matches do not take effect without an explicit ID match.
  */
-- 
1.7.8.6
