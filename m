From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] ALSA: snd_usb_caiaq: add support for Audio2DJ
Date: Wed, 22 Jul 2009 14:13:35 +0200
Message-ID: <1248264815-10041-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 469E31038D0
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jul 2009 14:13:46 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This adds support for Native Instrument's freshly announced Audio2DJ
sound device hardware. Version number bumped to 1.3.19.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/Kconfig        |    1 +
 sound/usb/caiaq/audio.c  |    1 +
 sound/usb/caiaq/device.c |    8 +++++++-
 sound/usb/caiaq/device.h |    1 +
 4 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/sound/usb/Kconfig b/sound/usb/Kconfig
index 523aec1..73525c0 100644
--- a/sound/usb/Kconfig
+++ b/sound/usb/Kconfig
@@ -48,6 +48,7 @@ config SND_USB_CAIAQ
 	    * Native Instruments Kore Controller
 	    * Native Instruments Kore Controller 2
 	    * Native Instruments Audio Kontrol 1
+	    * Native Instruments Audio 2 DJ
 	    * Native Instruments Audio 4 DJ
 	    * Native Instruments Audio 8 DJ
 	    * Native Instruments Guitar Rig Session I/O
diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
index 8f9b60c..121af06 100644
--- a/sound/usb/caiaq/audio.c
+++ b/sound/usb/caiaq/audio.c
@@ -646,6 +646,7 @@ int snd_usb_caiaq_audio_init(struct snd_usb_caiaqdev *dev)
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_GUITARRIGMOBILE):
 		dev->samplerates |= SNDRV_PCM_RATE_192000;
 		/* fall thru */
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO2DJ):
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO4DJ):
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO8DJ):
 		dev->samplerates |= SNDRV_PCM_RATE_88200;
diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index de38108..83e6c13 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -35,13 +35,14 @@
 #include "input.h"
 
 MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
-MODULE_DESCRIPTION("caiaq USB audio, version 1.3.18");
+MODULE_DESCRIPTION("caiaq USB audio, version 1.3.19");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Native Instruments, RigKontrol2},"
 			 "{Native Instruments, RigKontrol3},"
 			 "{Native Instruments, Kore Controller},"
 			 "{Native Instruments, Kore Controller 2},"
 			 "{Native Instruments, Audio Kontrol 1},"
+			 "{Native Instruments, Audio 2 DJ},"
 			 "{Native Instruments, Audio 4 DJ},"
 			 "{Native Instruments, Audio 8 DJ},"
 			 "{Native Instruments, Session I/O},"
@@ -121,6 +122,11 @@ static struct usb_device_id snd_usb_id_table[] = {
 		.idVendor =     USB_VID_NATIVEINSTRUMENTS,
 		.idProduct =    USB_PID_AUDIO4DJ
 	},
+	{
+		.match_flags =  USB_DEVICE_ID_MATCH_DEVICE,
+		.idVendor =     USB_VID_NATIVEINSTRUMENTS,
+		.idProduct =    USB_PID_AUDIO2DJ
+	},
 	{ /* terminator */ }
 };
 
diff --git a/sound/usb/caiaq/device.h b/sound/usb/caiaq/device.h
index ece7351..44e3edf 100644
--- a/sound/usb/caiaq/device.h
+++ b/sound/usb/caiaq/device.h
@@ -10,6 +10,7 @@
 #define USB_PID_KORECONTROLLER	0x4711
 #define USB_PID_KORECONTROLLER2	0x4712
 #define USB_PID_AK1		0x0815
+#define USB_PID_AUDIO2DJ	0x041c
 #define USB_PID_AUDIO4DJ	0x0839
 #define USB_PID_AUDIO8DJ	0x1978
 #define USB_PID_SESSIONIO	0x1915
-- 
1.6.3.1
