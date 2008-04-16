From: Roel Kluin <12o3l@tiscali.nl>
Subject: [PATCH 6/6] sound/drivers/dummy.c: fix negative snd_pcm_format_width()
 check
Date: Wed, 16 Apr 2008 18:20:33 +0200
Message-ID: <48062751.8040309@tiscali.nl>
References: <480558CA.7090800@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762245AbYDPQWV@vger.kernel.org>
In-Reply-To: <480558CA.7090800@tiscali.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz
Cc: alsa-devel@alsa-project.org, lkml <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

bps is unsigned, a negative snd_pcm_format_width() return value is not noticed
    
Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index a240eae..1c88977 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -230,13 +230,14 @@ static int snd_card_dummy_pcm_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_dummy_pcm *dpcm = runtime->private_data;
-	unsigned int bps;
+	int bps;
+
+	bps = snd_pcm_format_width(runtime->format) * runtime->rate *
+		runtime->channels / 8;
 
-	bps = runtime->rate * runtime->channels;
-	bps *= snd_pcm_format_width(runtime->format);
-	bps /= 8;
 	if (bps <= 0)
 		return -EINVAL;
+
 	dpcm->pcm_bps = bps;
 	dpcm->pcm_jiffie = bps / HZ;
 	dpcm->pcm_size = snd_pcm_lib_buffer_bytes(substream);
