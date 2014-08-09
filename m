From: Jurgen Kramer <gtmkramer@xs4all.nl>
Subject: [PATCH] Fix DSD formats userland usability
Date: Sat,  9 Aug 2014 12:09:21 +0200
Message-ID: <1407578961-13291-1-git-send-email-gtmkramer@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lb2-smtp-cloud3.xs4all.net (lb2-smtp-cloud3.xs4all.net
 [194.109.24.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DEE026163C
 for <alsa-devel@alsa-project.org>; Sat,  9 Aug 2014 12:09:41 +0200 (CEST)
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
Cc: Jurgen Kramer <gtmkramer@xs4all.nl>
List-Id: alsa-devel@alsa-project.org

Support for DSD sample formats has been added a while ago. This patch makes
those sample formats beter usable from userland (e.g. aplay).

---
 include/sound/asound.h | 4 +++-
 src/pcm/pcm_misc.c     | 4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/sound/asound.h b/include/sound/asound.h
index c819df4..5194524 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -214,7 +214,9 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_G723_24_1B	((__force snd_pcm_format_t) 45) /* 1 sample in 1 byte */
 #define	SNDRV_PCM_FORMAT_G723_40	((__force snd_pcm_format_t) 46) /* 8 Samples in 5 bytes */
 #define	SNDRV_PCM_FORMAT_G723_40_1B	((__force snd_pcm_format_t) 47) /* 1 sample in 1 byte */
-#define	SNDRV_PCM_FORMAT_LAST		SNDRV_PCM_FORMAT_G723_40_1B
+#define SNDRV_PCM_FORMAT_DSD_U8		((__force snd_pcm_format_t) 48) /* 8 1-bit samples in 1 byte */
+#define SNDRV_PCM_FORMAT_DSD_U16_LE	((__force snd_pcm_format_t) 49) /* 16 1-bit samples in 2 bytes */
+#define	SNDRV_PCM_FORMAT_LAST		SNDRV_PCM_FORMAT_DSD_U16_LE
 
 #ifdef SNDRV_LITTLE_ENDIAN
 #define	SNDRV_PCM_FORMAT_S16		SNDRV_PCM_FORMAT_S16_LE
diff --git a/src/pcm/pcm_misc.c b/src/pcm/pcm_misc.c
index d52160c..44bb89c 100644
--- a/src/pcm/pcm_misc.c
+++ b/src/pcm/pcm_misc.c
@@ -195,11 +195,13 @@ int snd_pcm_format_width(snd_pcm_format_t format)
 	switch (format) {
 	case SNDRV_PCM_FORMAT_S8:
 	case SNDRV_PCM_FORMAT_U8:
+	case SNDRV_PCM_FORMAT_DSD_U8:
 		return 8;
 	case SNDRV_PCM_FORMAT_S16_LE:
 	case SNDRV_PCM_FORMAT_S16_BE:
 	case SNDRV_PCM_FORMAT_U16_LE:
 	case SNDRV_PCM_FORMAT_U16_BE:
+	case SNDRV_PCM_FORMAT_DSD_U16_LE:
 		return 16;
 	case SNDRV_PCM_FORMAT_S18_3LE:
 	case SNDRV_PCM_FORMAT_S18_3BE:
@@ -253,11 +255,13 @@ int snd_pcm_format_physical_width(snd_pcm_format_t format)
 	switch (format) {
 	case SNDRV_PCM_FORMAT_S8:
 	case SNDRV_PCM_FORMAT_U8:
+	case SNDRV_PCM_FORMAT_DSD_U8:
 		return 8;
 	case SNDRV_PCM_FORMAT_S16_LE:
 	case SNDRV_PCM_FORMAT_S16_BE:
 	case SNDRV_PCM_FORMAT_U16_LE:
 	case SNDRV_PCM_FORMAT_U16_BE:
+	case SNDRV_PCM_FORMAT_DSD_U16_LE:
 		return 16;
 	case SNDRV_PCM_FORMAT_S18_3LE:
 	case SNDRV_PCM_FORMAT_S18_3BE:
-- 
1.9.3
