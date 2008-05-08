From: Daniel Mack <daniel@caiaq.org>
Subject: [PATCH] snd_usb_caiaq: add support for "Session I/O"
	interface
Date: Thu, 8 May 2008 13:26:13 +0200
Message-ID: <20080508112613.GA8677@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id E545224573
	for <alsa-devel@alsa-project.org>;
	Thu,  8 May 2008 13:26:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id 9D1627F4028
	for <alsa-devel@alsa-project.org>;
	Thu,  8 May 2008 13:26:18 +0200 (CEST)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop.caiaq.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LRmsEcjmIpGc for <alsa-devel@alsa-project.org>;
	Thu,  8 May 2008 13:26:14 +0200 (CEST)
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


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

this patch adds support for "Session I/O". As it certainly won't break
anything it could still go for 2.6.26, right?

Thanks,
Daniel


--7JfCtLOvnd9MIVvH
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="alsa-usb-caiaq-1.3.8.diff"

This patch adds suport for Native Instruments new 
"Guitar Rig Session I/O" audio hardware.

Signed-off-by: Daniel Mack <daniel@caiaq.de>

diff --git a/sound/usb/Kconfig b/sound/usb/Kconfig
index 9351b8a..f917ef4 100644
--- a/sound/usb/Kconfig
+++ b/sound/usb/Kconfig
@@ -45,6 +45,7 @@ config SND_USB_CAIAQ
 	    * Native Instruments Kore Controller 2
 	    * Native Instruments Audio Kontrol 1
 	    * Native Instruments Audio 8 DJ
+	    * Native Instruments Guitar Rig Session I/O
 
 	   To compile this driver as a module, choose M here: the module
 	   will be called snd-usb-caiaq.
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

--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--7JfCtLOvnd9MIVvH--
