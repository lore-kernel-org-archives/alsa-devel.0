From: Daniel Mack <daniel@caiaq.org>
Subject: [PATCH] snd-usb-caiaq: support for two more audio
	devices
Date: Fri, 16 Jan 2009 11:03:19 +0100
Message-ID: <20090116100319.GA28132@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 946E71038C8
	for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2009 11:03:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id 4644D7F404F
	for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2009 11:03:26 +0100 (CET)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop.caiaq.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LzVaw9O3ga55 for <alsa-devel@alsa-project.org>;
	Fri, 16 Jan 2009 11:03:19 +0100 (CET)
Content-Disposition: inline
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

- Added support for two new audio devices from Native Instuments,
  'Audio4DJ' and 'GuitarRig mobile'
- Add missing statement about 'Session IO' in Kconfig help text
- Version number bumped to 1.3.11

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 Resending an updated version - this one should apply cleanly to
 git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

 sound/usb/Kconfig               |    3 +++
 sound/usb/caiaq/caiaq-audio.c   |    5 +++--
 sound/usb/caiaq/caiaq-control.c |   15 ++++++++++++---
 sound/usb/caiaq/caiaq-device.c  |   16 ++++++++++++++--
 sound/usb/caiaq/caiaq-device.h  |    2 ++
 5 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/sound/usb/Kconfig b/sound/usb/Kconfig
index 4f0eac9..523aec1 100644
--- a/sound/usb/Kconfig
+++ b/sound/usb/Kconfig
@@ -48,7 +48,10 @@ config SND_USB_CAIAQ
 	    * Native Instruments Kore Controller
 	    * Native Instruments Kore Controller 2
 	    * Native Instruments Audio Kontrol 1
+	    * Native Instruments Audio 4 DJ
 	    * Native Instruments Audio 8 DJ
+	    * Native Instruments Guitar Rig Session I/O
+	    * Native Instruments Guitar Rig mobile
 
 	   To compile this driver as a module, choose M here: the module
 	   will be called snd-usb-caiaq.
diff --git a/sound/usb/caiaq/caiaq-audio.c b/sound/usb/caiaq/caiaq-audio.c
index b3a6033..fc6d571 100644
--- a/sound/usb/caiaq/caiaq-audio.c
+++ b/sound/usb/caiaq/caiaq-audio.c
@@ -638,9 +638,10 @@ int snd_usb_caiaq_audio_init(struct snd_usb_caiaqdev *dev)
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AK1):
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_RIGKONTROL3):
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_SESSIONIO):
-		dev->samplerates |= SNDRV_PCM_RATE_88200;
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_GUITARRIGMOBILE):
 		dev->samplerates |= SNDRV_PCM_RATE_192000;
-		break;
+		/* fall thru */
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO4DJ):
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO8DJ):
 		dev->samplerates |= SNDRV_PCM_RATE_88200;
 		break;
diff --git a/sound/usb/caiaq/caiaq-control.c b/sound/usb/caiaq/caiaq-control.c
index ccd763d..6ac5489 100644
--- a/sound/usb/caiaq/caiaq-control.c
+++ b/sound/usb/caiaq/caiaq-control.c
@@ -39,14 +39,15 @@ static int control_info(struct snd_kcontrol *kcontrol,
 	struct snd_usb_caiaqdev *dev = caiaqdev(chip->card);
 	int pos = kcontrol->private_value;
 	int is_intval = pos & CNT_INTVAL;
+	unsigned int id = dev->chip.usb_id;
 
 	uinfo->count = 1;
 	pos &= ~CNT_INTVAL;
 
-	if (dev->chip.usb_id ==
-		USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO8DJ)
+	if (((id == USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO8DJ)) ||
+	     (id == USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO4DJ)))
 		&& (pos == 0)) {
-		/* current input mode of A8DJ */
+		/* current input mode of A8DJ and A4DJ */
 		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 		uinfo->value.integer.min = 0;
 		uinfo->value.integer.max = 2;
@@ -247,6 +248,10 @@ static struct caiaq_controller a8dj_controller[] = {
 	{ "Software lock", 			40 		}
 };
 
+static struct caiaq_controller a4dj_controller[] = {
+	{ "Current input mode",	0 | CNT_INTVAL 	}
+};
+
 static int __devinit add_controls(struct caiaq_controller *c, int num,
 				  struct snd_usb_caiaqdev *dev)
 {
@@ -295,6 +300,10 @@ int __devinit snd_usb_caiaq_control_init(struct snd_usb_caiaqdev *dev)
 		ret = add_controls(a8dj_controller,
 			ARRAY_SIZE(a8dj_controller), dev);
 		break;
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO4DJ):
+		ret = add_controls(a4dj_controller,
+			ARRAY_SIZE(a4dj_controller), dev);
+		break;
 	}
 
 	return ret;
diff --git a/sound/usb/caiaq/caiaq-device.c b/sound/usb/caiaq/caiaq-device.c
index 09aed23..2464614 100644
--- a/sound/usb/caiaq/caiaq-device.c
+++ b/sound/usb/caiaq/caiaq-device.c
@@ -42,15 +42,17 @@
 #endif
 
 MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
-MODULE_DESCRIPTION("caiaq USB audio, version 1.3.10");
+MODULE_DESCRIPTION("caiaq USB audio, version 1.3.11");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Native Instruments, RigKontrol2},"
 			 "{Native Instruments, RigKontrol3},"
 			 "{Native Instruments, Kore Controller},"
 			 "{Native Instruments, Kore Controller 2},"
 			 "{Native Instruments, Audio Kontrol 1},"
+			 "{Native Instruments, Audio 4 DJ},"
 			 "{Native Instruments, Audio 8 DJ},"
-			 "{Native Instruments, Session I/O}}");
+			 "{Native Instruments, Session I/O},"
+			 "{Native Instruments, GuitarRig mobile}");
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX; /* Index 0-max */
 static char* id[SNDRV_CARDS] = SNDRV_DEFAULT_STR; /* Id for this card */
@@ -116,6 +118,16 @@ static struct usb_device_id snd_usb_id_table[] = {
 		.idVendor =     USB_VID_NATIVEINSTRUMENTS,
 		.idProduct =    USB_PID_SESSIONIO
 	},
+	{
+		.match_flags =  USB_DEVICE_ID_MATCH_DEVICE,
+		.idVendor =     USB_VID_NATIVEINSTRUMENTS,
+		.idProduct =    USB_PID_GUITARRIGMOBILE
+	},
+	{
+		.match_flags =  USB_DEVICE_ID_MATCH_DEVICE,
+		.idVendor =     USB_VID_NATIVEINSTRUMENTS,
+		.idProduct =    USB_PID_AUDIO4DJ
+	},
 	{ /* terminator */ }
 };
 
diff --git a/sound/usb/caiaq/caiaq-device.h b/sound/usb/caiaq/caiaq-device.h
index ab56e73..0560c32 100644
--- a/sound/usb/caiaq/caiaq-device.h
+++ b/sound/usb/caiaq/caiaq-device.h
@@ -10,8 +10,10 @@
 #define USB_PID_KORECONTROLLER	0x4711
 #define USB_PID_KORECONTROLLER2	0x4712
 #define USB_PID_AK1		0x0815
+#define USB_PID_AUDIO4DJ	0x0839
 #define USB_PID_AUDIO8DJ	0x1978
 #define USB_PID_SESSIONIO	0x1915
+#define USB_PID_GUITARRIGMOBILE	0x0d8d
 
 #define EP1_BUFSIZE 64
 #define CAIAQ_USB_STR_LEN 0xff
-- 
1.5.6.5
