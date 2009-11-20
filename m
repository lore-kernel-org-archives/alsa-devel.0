From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH] sound: usbmidi: Use hweight16
Date: Fri, 20 Nov 2009 14:56:52 +0900
Message-ID: <1258696612-15924-1-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f190.google.com (mail-yw0-f190.google.com
	[209.85.211.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 55E59103819
	for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2009 06:57:41 +0100 (CET)
Received: by ywh28 with SMTP id 28so2863601ywh.16
	for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2009 21:57:40 -0800 (PST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Akinobu Mita <akinobu.mita@gmail.com>
List-Id: alsa-devel@alsa-project.org

Use hweight16 instead of Brian Kernighan's/Peter Wegner's method

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
Cc: Clemens Ladisch <clemens@ladisch.de>
---
 sound/usb/usbmidi.c |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/sound/usb/usbmidi.c b/sound/usb/usbmidi.c
index 0eff19c..e5b0689 100644
--- a/sound/usb/usbmidi.c
+++ b/sound/usb/usbmidi.c
@@ -1062,15 +1062,6 @@ static int snd_usbmidi_in_endpoint_create(struct snd_usb_midi* umidi,
 	return 0;
 }
 
-static unsigned int snd_usbmidi_count_bits(unsigned int x)
-{
-	unsigned int bits;
-
-	for (bits = 0; x; ++bits)
-		x &= x - 1;
-	return bits;
-}
-
 /*
  * Frees an output endpoint.
  * May be called when ep hasn't been initialized completely.
@@ -1914,8 +1905,8 @@ int snd_usb_create_midi_interface(struct snd_usb_audio* chip,
 	out_ports = 0;
 	in_ports = 0;
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
-		out_ports += snd_usbmidi_count_bits(endpoints[i].out_cables);
-		in_ports += snd_usbmidi_count_bits(endpoints[i].in_cables);
+		out_ports += hweight16(endpoints[i].out_cables);
+		in_ports += hweight16(endpoints[i].in_cables);
 	}
 	err = snd_usbmidi_create_rawmidi(umidi, out_ports, in_ports);
 	if (err < 0) {
-- 
1.6.5.1
