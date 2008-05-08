From: Daniel Mack <daniel@caiaq.org>
Subject: Re: [PATCH] snd_usb_caiaq: add support for
	"Session	I/O" interface
Date: Thu, 8 May 2008 13:47:07 +0200
Message-ID: <20080508114707.GB8677@buzzloop.caiaq.de>
References: <20080508112613.GA8677@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="QKdGvSO+nmPlgiQ/"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id BC523246D0
	for <alsa-devel@alsa-project.org>;
	Thu,  8 May 2008 13:47:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id 506187F4028
	for <alsa-devel@alsa-project.org>;
	Thu,  8 May 2008 13:47:10 +0200 (CEST)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop.caiaq.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GXvlJDbmX+bE for <alsa-devel@alsa-project.org>;
	Thu,  8 May 2008 13:47:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080508112613.GA8677@buzzloop.caiaq.de>
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


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 08, 2008 at 01:26:13PM +0200, Daniel Mack wrote:
> this patch adds support for "Session I/O". As it certainly won't break
> anything it could still go for 2.6.26, right?

Forgot to enable high sample rates for this device in my previous patch.
Use the one attached to this mail instead.

Daniel


--QKdGvSO+nmPlgiQ/
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="alsa-usb-caiaq-1.3.8.diff"

This patch adds suport for Native Instruments new 
"Guitar Rig Session I/O" audio hardware.

Signed-off-by: Daniel Mack <daniel@caiaq.de>

diff --git a/sound/usb/caiaq/caiaq-audio.c b/sound/usb/caiaq/caiaq-audio.c
index 24970a5..b3a6033 100644
--- a/sound/usb/caiaq/caiaq-audio.c
+++ b/sound/usb/caiaq/caiaq-audio.c
@@ -637,6 +637,7 @@ int snd_usb_caiaq_audio_init(struct snd_usb_caiaqdev *dev)
 	switch (dev->chip.usb_id) {
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AK1):
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_RIGKONTROL3):
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_SESSIONIO):
 		dev->samplerates |= SNDRV_PCM_RATE_88200;
 		dev->samplerates |= SNDRV_PCM_RATE_192000;
 		break;
diff --git a/sound/usb/caiaq/caiaq-device.c b/sound/usb/caiaq/caiaq-device.c
index e97d8b2..8ae5134 100644
--- a/sound/usb/caiaq/caiaq-device.c
+++ b/sound/usb/caiaq/caiaq-device.c
@@ -42,14 +42,15 @@
 #endif
 
 MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
-MODULE_DESCRIPTION("caiaq USB audio, version 1.3.6");
+MODULE_DESCRIPTION("caiaq USB audio, version 1.3.8");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Native Instruments, RigKontrol2},"
 			 "{Native Instruments, RigKontrol3},"
 			 "{Native Instruments, Kore Controller},"
 			 "{Native Instruments, Kore Controller 2},"
-			 "{Native Instruments, Audio Kontrol 1}"
-			 "{Native Instruments, Audio 8 DJ}}");
+			 "{Native Instruments, Audio Kontrol 1},"
+			 "{Native Instruments, Audio 8 DJ},"
+			 "{Native Instruments, Session I/O}}");
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX; /* Index 0-max */
 static char* id[SNDRV_CARDS] = SNDRV_DEFAULT_STR; /* Id for this card */
@@ -110,6 +111,11 @@ static struct usb_device_id snd_usb_id_table[] = {
 		.idVendor =     USB_VID_NATIVEINSTRUMENTS,
 		.idProduct =    USB_PID_AUDIO8DJ
 	},
+	{
+		.match_flags =  USB_DEVICE_ID_MATCH_DEVICE,
+		.idVendor =     USB_VID_NATIVEINSTRUMENTS,
+		.idProduct =    USB_PID_SESSIONIO
+	},
 	{ /* terminator */ }
 };
 
diff --git a/sound/usb/caiaq/caiaq-device.h b/sound/usb/caiaq/caiaq-device.h
index 9382d13..99e8a07 100644
--- a/sound/usb/caiaq/caiaq-device.h
+++ b/sound/usb/caiaq/caiaq-device.h
@@ -11,6 +11,7 @@
 #define USB_PID_KORECONTROLLER2	0x4712
 #define USB_PID_AK1		0x0815
 #define USB_PID_AUDIO8DJ	0x1978
+#define USB_PID_SESSIONIO	0x1915
 
 #define EP1_BUFSIZE 64
 #define CAIAQ_USB_STR_LEN 0xff

--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--QKdGvSO+nmPlgiQ/--
