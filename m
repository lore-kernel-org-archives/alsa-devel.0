From: Ben Collins <bcollins@bluecherry.net>
Subject: [PATCH] pcm: Define G723 3-bit and 5-bit formats
Date: Fri, 28 May 2010 11:43:45 -0400
Message-ID: <1275061425.3987.34.camel@maclara>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 550541037EE
	for <alsa-devel@alsa-project.org>;
	Fri, 28 May 2010 17:43:50 +0200 (CEST)
Received: by gyd10 with SMTP id 10so1049148gyd.38
	for <alsa-devel@alsa-project.org>; Fri, 28 May 2010 08:43:49 -0700 (PDT)
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

pcm: Define G723 3-bit and 5-bit formats

This defines the 24bps and 40bps (8khz sample rate) G.723 codec
formats. They are going to be used once I submit the driver for
an mpeg4/g723 compression card.

I've updated the signed value to -1 as per Takashi's comments
since these are non-linear formats.

Signed-off-by: Ben Collins <bcollins@bluecherry.net>
Acked-by: Takashi Iwai <tiwai@suse.de>

diff --git a/include/sound/asound.h b/include/sound/asound.h
index 0985955..62e0857 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -212,7 +212,11 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_S18_3BE	((__force snd_pcm_format_t) 41)	/* in three bytes */
 #define	SNDRV_PCM_FORMAT_U18_3LE	((__force snd_pcm_format_t) 42)	/* in three bytes */
 #define	SNDRV_PCM_FORMAT_U18_3BE	((__force snd_pcm_format_t) 43)	/* in three bytes */
-#define	SNDRV_PCM_FORMAT_LAST		SNDRV_PCM_FORMAT_U18_3BE
+#define	SNDRV_PCM_FORMAT_G723_24	((__force snd_pcm_format_t) 44) /* 8 samples in 3 bytes */
+#define	SNDRV_PCM_FORMAT_G723_24_1B	((__force snd_pcm_format_t) 45) /* 1 sample in 1 byte */
+#define	SNDRV_PCM_FORMAT_G723_40	((__force snd_pcm_format_t) 46) /* 8 Samples in 5 bytes */
+#define	SNDRV_PCM_FORMAT_G723_40_1B	((__force snd_pcm_format_t) 47) /* 1 sample in 1 byte */
+#define	SNDRV_PCM_FORMAT_LAST		SNDRV_PCM_FORMAT_G723_40_1B
 
 #ifdef SNDRV_LITTLE_ENDIAN
 #define	SNDRV_PCM_FORMAT_S16		SNDRV_PCM_FORMAT_S16_LE
diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 8b611a5..37b5c3c 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -173,6 +173,10 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_FMTBIT_U18_3LE	(1ULL << SNDRV_PCM_FORMAT_U18_3LE)
 #define SNDRV_PCM_FMTBIT_S18_3BE	(1ULL << SNDRV_PCM_FORMAT_S18_3BE)
 #define SNDRV_PCM_FMTBIT_U18_3BE	(1ULL << SNDRV_PCM_FORMAT_U18_3BE)
+#define SNDRV_PCM_FMTBIT_G723_24	(1ULL << SNDRV_PCM_FORMAT_G723_24)
+#define SNDRV_PCM_FMTBIT_G723_24_1B	(1ULL << SNDRV_PCM_FORMAT_G723_24_1B)
+#define SNDRV_PCM_FMTBIT_G723_40	(1ULL << SNDRV_PCM_FORMAT_G723_40)
+#define SNDRV_PCM_FMTBIT_G723_40_1B	(1ULL << SNDRV_PCM_FORMAT_G723_40_1B)
 
 #ifdef SNDRV_LITTLE_ENDIAN
 #define SNDRV_PCM_FMTBIT_S16		SNDRV_PCM_FMTBIT_S16_LE
diff --git a/sound/core/pcm_misc.c b/sound/core/pcm_misc.c
index ea2bf82..434af3c 100644
--- a/sound/core/pcm_misc.c
+++ b/sound/core/pcm_misc.c
@@ -128,6 +128,14 @@ static struct pcm_format_data pcm_formats[SNDRV_PCM_FORMAT_LAST+1] = {
 		.width = 4, .phys = 4, .le = -1, .signd = -1,
 		.silence = {},
 	},
+	[SNDRV_PCM_FORMAT_G723_24] = {
+		.width = 3, .phys = 3, .le = -1, .signd = -1,
+		.silence = {},
+	},
+	[SNDRV_PCM_FORMAT_G723_40] = {
+		.width = 5, .phys = 5, .le = -1, .signd = -1,
+		.silence = {},
+	},
 	/* FIXME: the following three formats are not defined properly yet */
 	[SNDRV_PCM_FORMAT_MPEG] = {
 		.le = -1, .signd = -1,
@@ -186,6 +194,14 @@ static struct pcm_format_data pcm_formats[SNDRV_PCM_FORMAT_LAST+1] = {
 		.width = 18, .phys = 24, .le = 0, .signd = 0,
 		.silence = { 0x02, 0x00, 0x00 },
 	},
+	[SNDRV_PCM_FORMAT_G723_24_1B] = {
+		.width = 3, .phys = 8, .le = -1, .signd = -1,
+		.silence = {},
+	},
+	[SNDRV_PCM_FORMAT_G723_40_1B] = {
+		.width = 5, .phys = 8, .le = -1, .signd = -1,
+		.silence = {},
+	},
 };
 
 

-- 
Bluecherry: http://www.bluecherrydvr.com/
SwissDisk : http://www.swissdisk.com/
Ubuntu    : http://www.ubuntu.com/
My Blog   : http://ben-collins.blogspot.com/
