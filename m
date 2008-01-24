From: Daniel Mack <daniel@caiaq.org>
Subject: [PATCH] usb/caiaq: decrease period_bytes_min
Date: Thu, 24 Jan 2008 18:44:07 +0100
Message-ID: <20080124174407.GA12888@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F71B24369
	for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2008 18:44:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id C3F137F4020
	for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2008 18:44:10 +0100 (CET)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop.caiaq.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e6U-xVFl7pmR for <alsa-devel@alsa-project.org>;
	Thu, 24 Jan 2008 18:44:07 +0100 (CET)
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


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch increases the snd_pcm_hardware->period_bytes_min field in the
caiaq/usb audio driver. The hardware can actually handle as few as 128
bytes, depending on the system. So it makes no sense to keep
applications from actually using such values.

Signed-off-by: Daniel Mack <daniel@caiaq.de>



--OgqxwSJOaUobr8KG
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="caiaq-periods.diff"

diff --git a/sound/usb/caiaq/caiaq-audio.c b/sound/usb/caiaq/caiaq-audio.c
index 2f9e9b2..9cc4cd8 100644
--- a/sound/usb/caiaq/caiaq-audio.c
+++ b/sound/usb/caiaq/caiaq-audio.c
@@ -57,7 +57,7 @@ static struct snd_pcm_hardware snd_usb_caiaq_pcm_hardware = {
 	.channels_min	= CHANNELS_PER_STREAM,
 	.channels_max	= CHANNELS_PER_STREAM,
 	.buffer_bytes_max = MAX_BUFFER_SIZE,
-	.period_bytes_min = 4096,
+	.period_bytes_min = 128,
 	.period_bytes_max = MAX_BUFFER_SIZE,
 	.periods_min	= 1,
 	.periods_max	= 1024,
diff --git a/sound/usb/caiaq/caiaq-device.c b/sound/usb/caiaq/caiaq-device.c
index 5cd92ae..58d25e4 100644
--- a/sound/usb/caiaq/caiaq-device.c
+++ b/sound/usb/caiaq/caiaq-device.c
@@ -42,7 +42,7 @@
 #endif
 
 MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
-MODULE_DESCRIPTION("caiaq USB audio, version 1.3.1");
+MODULE_DESCRIPTION("caiaq USB audio, version 1.3.2");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Native Instruments, RigKontrol2},"
 			 "{Native Instruments, RigKontrol3},"

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--OgqxwSJOaUobr8KG--
