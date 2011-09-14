From: Daniele Guerrieri <d.guerrieri@gmail.com>
Subject: [PATCH 1/1] sound/usb: Added support for Roland UM-ONE
	midi-usb interface.
Date: Wed, 14 Sep 2011 19:52:39 +0200
Message-ID: <CAF_WDAk97ezGsjm3hwNch1ZWsnhET3K4fGcMcRsdmCvGCJs7jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 5597324477
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Sep 2011 19:53:14 +0200 (CEST)
Received: by bkbzu17 with SMTP id zu17so1692657bkb.38
	for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2011 10:53:12 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,
this is my first post to this list.
Recently i bought a roland UM-ONE midi-usb interface which i thought worked
well with alsa, but it didn't. So i got from lsusb id/vid and added them to
sound/usb/quirks-table.h; it seems to work well now with snd-usb-audio,
tested on 2 machines. Below there is the patch output for my changes. As a
master branch i cloned   git://github.com/torvalds/linux.git



----output of git format-patch -----

Roland UM-ONE midi usb interface differs from Roland UM-1.

Signed-off-by: Daniele Guerrieri <d.guerrieri@gmail.com>
---
 sound/usb/quirks-table.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index a42e3ef..f041b2e 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -1192,6 +1192,20 @@ YAMAHA_DEVICE(0x7010, "UB99"),
     }
 },
 {
+    /* Added support for Roland UM-ONE which differs from UM-1 */
+    USB_DEVICE(0x0582, 0x012a),
+    .driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+        /* .vendor_name = "ROLAND", */
+        /* .product_name = "UM-ONE", */
+        .ifnum = 0,
+        .type = QUIRK_MIDI_FIXED_ENDPOINT,
+        .data = & (const struct snd_usb_midi_endpoint_info) {
+            .out_cables = 0x0001,
+            .in_cables  = 0x0003
+        }
+    }
+},
+{
     /* has ID 0x006b when not in "Advanced Driver" mode */
     USB_DEVICE_VENDOR_SPEC(0x0582, 0x006a),
     .driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-- 
1.7.6
