From: Daniel Mack <daniel@caiaq.org>
Subject: [PATCH] snd_usb_caiaq: make high sample rates work
	with A8DJ
Date: Thu, 10 Apr 2008 14:20:04 +0200
Message-ID: <20080410122004.GA24215@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F8F0244CC
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Apr 2008 14:20:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id 087CC7F4037
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Apr 2008 14:20:12 +0200 (CEST)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop.caiaq.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lg2-vVNXbEhd for <alsa-devel@alsa-project.org>;
	Thu, 10 Apr 2008 14:20:04 +0200 (CEST)
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


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch for snd_usb_caiaq makes sample rates higher dann 48KHz work
with devices which have more than 2 stereo input/output pairs.

Signed-off-by: Daniel Mack <daniel@caiaq.de>


--dDRMvlgZJXvWKvBx
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="snd-caiaq-1.3.6.diff"

diff --git a/sound/usb/caiaq/caiaq-audio.c b/sound/usb/caiaq/caiaq-audio.c
index ebf3281..24970a5 100644
--- a/sound/usb/caiaq/caiaq-audio.c
+++ b/sound/usb/caiaq/caiaq-audio.c
@@ -39,7 +39,8 @@
 #define BYTES_PER_SAMPLE	3
 #define BYTES_PER_SAMPLE_USB	4
 #define MAX_BUFFER_SIZE		(128*1024)
-				 
+#define MAX_ENDPOINT_SIZE	512
+
 #define ENDPOINT_CAPTURE	2
 #define ENDPOINT_PLAYBACK	6
 
@@ -221,7 +222,10 @@ static int snd_usb_caiaq_pcm_prepare(struct snd_pcm_substream *substream)
 	
 	bpp = ((runtime->rate / 8000) + CLOCK_DRIFT_TOLERANCE)
 		* bytes_per_sample * CHANNELS_PER_STREAM * dev->n_streams;
-	
+
+	if (bpp > MAX_ENDPOINT_SIZE)
+		bpp = MAX_ENDPOINT_SIZE;
+
 	ret = snd_usb_caiaq_set_audio_params(dev, runtime->rate,
 					     runtime->sample_bits, bpp);
 	if (ret)
diff --git a/sound/usb/caiaq/caiaq-device.c b/sound/usb/caiaq/caiaq-device.c
index 379e608..e97d8b2 100644
--- a/sound/usb/caiaq/caiaq-device.c
+++ b/sound/usb/caiaq/caiaq-device.c
@@ -42,7 +42,7 @@
 #endif
 
 MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
-MODULE_DESCRIPTION("caiaq USB audio, version 1.3.5");
+MODULE_DESCRIPTION("caiaq USB audio, version 1.3.6");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Native Instruments, RigKontrol2},"
 			 "{Native Instruments, RigKontrol3},"

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--dDRMvlgZJXvWKvBx--
