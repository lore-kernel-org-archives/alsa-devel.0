From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v3 1/5] ALSA: add DSD formats
Date: Wed, 17 Apr 2013 00:01:36 +0800
Message-ID: <1366128100-9778-2-git-send-email-zonque@gmail.com>
References: <1366128100-9778-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id B09622610AD
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 18:01:50 +0200 (CEST)
In-Reply-To: <1366128100-9778-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>, demian@auraliti.com, ray@auraliti.com, andreas@akdesigninc.com
List-Id: alsa-devel@alsa-project.org

This patch adds two formats for Direct Stream Digital (DSD), a
pulse-density encoding format which is described here:
https://en.wikipedia.org/wiki/Direct_Stream_Digital

DSD operates on 2.8, 5.6 or 11.2MHz sample rates and as a 1-bit
stream.

The two new types added by this patch describe streams that are capable
of handling DSD samples in DOP format as 8-bit or in 16-bit (or at a x8
or x16 data rate, respectively).

DSD itself specifies samples in *bit*, while DOP and ALSA handle them
as *bytes*. Hence, a factor of 8 or 16 has to be applied for the sample
rare configuration, according to the following table:

                                                  configured hardware
        176.4KHz   352.8kHz   705.6KHz     <----       sample rate

8-bit                2.8MHz     5.6MHz
16-bit    2.8Mhz     5.6MHz    11.2MHz

         `-----------------------------'
             actual DSD sample rates

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 include/sound/pcm.h         |    2 ++
 include/uapi/sound/asound.h |    4 +++-
 sound/core/pcm.c            |    2 ++
 sound/core/pcm_misc.c       |    8 ++++++++
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index aa7b0a8..1b0c648 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -181,6 +181,8 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_FMTBIT_G723_24_1B	_SNDRV_PCM_FMTBIT(G723_24_1B)
 #define SNDRV_PCM_FMTBIT_G723_40	_SNDRV_PCM_FMTBIT(G723_40)
 #define SNDRV_PCM_FMTBIT_G723_40_1B	_SNDRV_PCM_FMTBIT(G723_40_1B)
+#define SNDRV_PCM_FMTBIT_DSD_U8		_SNDRV_PCM_FMTBIT(DSD_U8)
+#define SNDRV_PCM_FMTBIT_DSD_U16_LE	_SNDRV_PCM_FMTBIT(DSD_U16_LE)
 
 #ifdef SNDRV_LITTLE_ENDIAN
 #define SNDRV_PCM_FMTBIT_S16		SNDRV_PCM_FMTBIT_S16_LE
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 1774a5c..e3983d5 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -214,7 +214,9 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_G723_24_1B	((__force snd_pcm_format_t) 45) /* 1 sample in 1 byte */
 #define	SNDRV_PCM_FORMAT_G723_40	((__force snd_pcm_format_t) 46) /* 8 Samples in 5 bytes */
 #define	SNDRV_PCM_FORMAT_G723_40_1B	((__force snd_pcm_format_t) 47) /* 1 sample in 1 byte */
-#define	SNDRV_PCM_FORMAT_LAST		SNDRV_PCM_FORMAT_G723_40_1B
+#define	SNDRV_PCM_FORMAT_DSD_U8		((__force snd_pcm_format_t) 48) /* DSD, 1-byte samples DSD (x8) */
+#define	SNDRV_PCM_FORMAT_DSD_U16_LE	((__force snd_pcm_format_t) 49) /* DSD, 2-byte samples DSD (x16), little endian */
+#define	SNDRV_PCM_FORMAT_LAST		SNDRV_PCM_FORMAT_DSD_U16_LE
 
 #ifdef SNDRV_LITTLE_ENDIAN
 #define	SNDRV_PCM_FORMAT_S16		SNDRV_PCM_FORMAT_S16_LE
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 578327e..17f45e8 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -209,6 +209,8 @@ static char *snd_pcm_format_names[] = {
 	FORMAT(G723_24_1B),
 	FORMAT(G723_40),
 	FORMAT(G723_40_1B),
+	FORMAT(DSD_U8),
+	FORMAT(DSD_U16_LE),
 };
 
 const char *snd_pcm_format_name(snd_pcm_format_t format)
diff --git a/sound/core/pcm_misc.c b/sound/core/pcm_misc.c
index b875b19..43f24cc 100644
--- a/sound/core/pcm_misc.c
+++ b/sound/core/pcm_misc.c
@@ -140,6 +140,14 @@ static struct pcm_format_data pcm_formats[(INT)SNDRV_PCM_FORMAT_LAST+1] = {
 		.width = 5, .phys = 5, .le = -1, .signd = -1,
 		.silence = {},
 	},
+	[SNDRV_PCM_FORMAT_DSD_U8] = {
+		.width = 8, .phys = 8, .le = 1, .signd = 0,
+		.silence = {},
+	},
+	[SNDRV_PCM_FORMAT_DSD_U16_LE] = {
+		.width = 16, .phys = 16, .le = 1, .signd = 0,
+		.silence = {},
+	},
 	/* FIXME: the following three formats are not defined properly yet */
 	[SNDRV_PCM_FORMAT_MPEG] = {
 		.le = -1, .signd = -1,
-- 
1.7.10.4
