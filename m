From: Jussi Laako <jussi@sonarnerd.net>
Subject: [PATCH 1/1] Add big-endian DSD sample formats and fix
	XMOS DSD sample format
Date: Fri, 21 Nov 2014 10:52:15 +0200
Message-ID: <1416559935-3465-2-git-send-email-jussi@sonarnerd.net>
References: <1416559935-3465-1-git-send-email-jussi@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [83.145.240.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F48226661D
 for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2014 09:52:22 +0100 (CET)
In-Reply-To: <1416559935-3465-1-git-send-email-jussi@sonarnerd.net>
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
Cc: Jussi Laako <jussi@sonarnerd.net>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jussi Laako <jussi@sonarnerd.net>
---
 include/sound/pcm.h         | 2 ++
 include/uapi/sound/asound.h | 4 +++-
 sound/core/pcm.c            | 2 ++
 sound/core/pcm_misc.c       | 8 ++++++++
 sound/usb/quirks.c          | 4 ++--
 5 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 40289ec..1e7f74a 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -184,6 +184,8 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_FMTBIT_DSD_U8		_SNDRV_PCM_FMTBIT(DSD_U8)
 #define SNDRV_PCM_FMTBIT_DSD_U16_LE	_SNDRV_PCM_FMTBIT(DSD_U16_LE)
 #define SNDRV_PCM_FMTBIT_DSD_U32_LE	_SNDRV_PCM_FMTBIT(DSD_U32_LE)
+#define SNDRV_PCM_FMTBIT_DSD_U16_BE	_SNDRV_PCM_FMTBIT(DSD_U16_BE)
+#define SNDRV_PCM_FMTBIT_DSD_U32_BE	_SNDRV_PCM_FMTBIT(DSD_U32_BE)
 
 #ifdef SNDRV_LITTLE_ENDIAN
 #define SNDRV_PCM_FMTBIT_S16		SNDRV_PCM_FMTBIT_S16_LE
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 6ee5867..941d32f 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -220,7 +220,9 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_DSD_U8		((__force snd_pcm_format_t) 48) /* DSD, 1-byte samples DSD (x8) */
 #define	SNDRV_PCM_FORMAT_DSD_U16_LE	((__force snd_pcm_format_t) 49) /* DSD, 2-byte samples DSD (x16), little endian */
 #define	SNDRV_PCM_FORMAT_DSD_U32_LE	((__force snd_pcm_format_t) 50) /* DSD, 4-byte samples DSD (x32), little endian */
-#define	SNDRV_PCM_FORMAT_LAST		SNDRV_PCM_FORMAT_DSD_U32_LE
+#define	SNDRV_PCM_FORMAT_DSD_U16_BE	((__force snd_pcm_format_t) 51) /* DSD, 2-byte samples DSD (x16), big endian */
+#define	SNDRV_PCM_FORMAT_DSD_U32_BE	((__force snd_pcm_format_t) 52) /* DSD, 4-byte samples DSD (x32), big endian */
+#define	SNDRV_PCM_FORMAT_LAST		SNDRV_PCM_FORMAT_DSD_U32_BE
 
 #ifdef SNDRV_LITTLE_ENDIAN
 #define	SNDRV_PCM_FORMAT_S16		SNDRV_PCM_FORMAT_S16_LE
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 8f624b7..cfc56c8 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -216,6 +216,8 @@ static char *snd_pcm_format_names[] = {
 	FORMAT(DSD_U8),
 	FORMAT(DSD_U16_LE),
 	FORMAT(DSD_U32_LE),
+	FORMAT(DSD_U16_BE),
+	FORMAT(DSD_U32_BE),
 };
 
 /**
diff --git a/sound/core/pcm_misc.c b/sound/core/pcm_misc.c
index ae7a0fe..ebe8444 100644
--- a/sound/core/pcm_misc.c
+++ b/sound/core/pcm_misc.c
@@ -152,6 +152,14 @@ static struct pcm_format_data pcm_formats[(INT)SNDRV_PCM_FORMAT_LAST+1] = {
 		.width = 32, .phys = 32, .le = 1, .signd = 0,
 		.silence = { 0x69, 0x69, 0x69, 0x69 },
 	},
+	[SNDRV_PCM_FORMAT_DSD_U16_BE] = {
+		.width = 16, .phys = 16, .le = 0, .signd = 0,
+		.silence = { 0x69, 0x69 },
+	},
+	[SNDRV_PCM_FORMAT_DSD_U32_BE] = {
+		.width = 32, .phys = 32, .le = 0, .signd = 0,
+		.silence = { 0x69, 0x69, 0x69, 0x69 },
+	},
 	/* FIXME: the following three formats are not defined properly yet */
 	[SNDRV_PCM_FORMAT_MPEG] = {
 		.le = -1, .signd = -1,
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 2c1018e..bc9ebb6 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1202,12 +1202,12 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 	/* iFi Audio micro/nano iDSD */
 	case USB_ID(0x20b1, 0x3008):
 		if (fp->altsetting == 2)
-			return SNDRV_PCM_FMTBIT_DSD_U32_LE;
+			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 		break;
 	/* DIYINHK DSD DXD 384kHz USB to I2S/DSD */
 	case USB_ID(0x20b1, 0x2009):
 		if (fp->altsetting == 3)
-			return SNDRV_PCM_FMTBIT_DSD_U32_LE;
+			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 		break;
 	default:
 		break;
-- 
1.9.1
