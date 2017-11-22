From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH 1/2] ALSA: pcm: add SNDRV_PCM_FORMAT_{S, U}20_4
Date: Wed, 22 Nov 2017 20:17:34 +0100
Message-ID: <53d527c0-89f6-d501-09e9-1effea8a5bac@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id A2844266F03
 for <alsa-devel@alsa-project.org>; Wed, 22 Nov 2017 20:17:42 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

This format is similar to existing SNDRV_PCM_FORMAT_{S,U}20_3 that keep
20-bit PCM samples in 3 bytes, however i.MX6 platform SSI FIFO does not
allow 3-byte accesses (including DMA) so a 4-byte format is needed for it.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 include/sound/pcm.h         |  8 ++++++++
 include/sound/soc-dai.h     |  2 ++
 include/uapi/sound/asound.h | 10 +++++++++-
 sound/core/pcm_misc.c       | 16 ++++++++++++++++
 4 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 24febf9e177c..7ad2d3f0934f 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -191,6 +191,10 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_FMTBIT_DSD_U32_LE	_SNDRV_PCM_FMTBIT(DSD_U32_LE)
 #define SNDRV_PCM_FMTBIT_DSD_U16_BE	_SNDRV_PCM_FMTBIT(DSD_U16_BE)
 #define SNDRV_PCM_FMTBIT_DSD_U32_BE	_SNDRV_PCM_FMTBIT(DSD_U32_BE)
+#define SNDRV_PCM_FMTBIT_S20_4LE	_SNDRV_PCM_FMTBIT(S20_4LE)
+#define SNDRV_PCM_FMTBIT_U20_4LE	_SNDRV_PCM_FMTBIT(U20_4LE)
+#define SNDRV_PCM_FMTBIT_S20_4BE	_SNDRV_PCM_FMTBIT(S20_4BE)
+#define SNDRV_PCM_FMTBIT_U20_4BE	_SNDRV_PCM_FMTBIT(U20_4BE)
 
 #ifdef SNDRV_LITTLE_ENDIAN
 #define SNDRV_PCM_FMTBIT_S16		SNDRV_PCM_FMTBIT_S16_LE
@@ -202,6 +206,8 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_FMTBIT_FLOAT		SNDRV_PCM_FMTBIT_FLOAT_LE
 #define SNDRV_PCM_FMTBIT_FLOAT64	SNDRV_PCM_FMTBIT_FLOAT64_LE
 #define SNDRV_PCM_FMTBIT_IEC958_SUBFRAME SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE
+#define SNDRV_PCM_FMTBIT_S20_4		SNDRV_PCM_FMTBIT_S20_4LE
+#define SNDRV_PCM_FMTBIT_U20_4		SNDRV_PCM_FMTBIT_U20_4LE
 #endif
 #ifdef SNDRV_BIG_ENDIAN
 #define SNDRV_PCM_FMTBIT_S16		SNDRV_PCM_FMTBIT_S16_BE
@@ -213,6 +219,8 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_FMTBIT_FLOAT		SNDRV_PCM_FMTBIT_FLOAT_BE
 #define SNDRV_PCM_FMTBIT_FLOAT64	SNDRV_PCM_FMTBIT_FLOAT64_BE
 #define SNDRV_PCM_FMTBIT_IEC958_SUBFRAME SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_BE
+#define SNDRV_PCM_FMTBIT_S20_4		SNDRV_PCM_FMTBIT_S20_4BE
+#define SNDRV_PCM_FMTBIT_U20_4		SNDRV_PCM_FMTBIT_U20_4BE
 #endif
 
 struct snd_pcm_file {
diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 58acd00cae19..16aec0cc96f5 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -102,6 +102,8 @@ struct snd_compr_stream;
 			       SNDRV_PCM_FMTBIT_S16_BE |\
 			       SNDRV_PCM_FMTBIT_S20_3LE |\
 			       SNDRV_PCM_FMTBIT_S20_3BE |\
+			       SNDRV_PCM_FMTBIT_S20_4LE |\
+			       SNDRV_PCM_FMTBIT_S20_4BE |\
 			       SNDRV_PCM_FMTBIT_S24_3LE |\
 			       SNDRV_PCM_FMTBIT_S24_3BE |\
                                SNDRV_PCM_FMTBIT_S32_LE |\
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index c227ccba60ae..69b661816491 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -236,7 +236,11 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_DSD_U32_LE	((__force snd_pcm_format_t) 50) /* DSD, 4-byte samples DSD (x32), little endian */
 #define	SNDRV_PCM_FORMAT_DSD_U16_BE	((__force snd_pcm_format_t) 51) /* DSD, 2-byte samples DSD (x16), big endian */
 #define	SNDRV_PCM_FORMAT_DSD_U32_BE	((__force snd_pcm_format_t) 52) /* DSD, 4-byte samples DSD (x32), big endian */
-#define	SNDRV_PCM_FORMAT_LAST		SNDRV_PCM_FORMAT_DSD_U32_BE
+#define	SNDRV_PCM_FORMAT_S20_4LE	((__force snd_pcm_format_t) 53)	/* in four bytes */
+#define	SNDRV_PCM_FORMAT_S20_4BE	((__force snd_pcm_format_t) 54)	/* in four bytes */
+#define	SNDRV_PCM_FORMAT_U20_4LE	((__force snd_pcm_format_t) 55)	/* in four bytes */
+#define	SNDRV_PCM_FORMAT_U20_4BE	((__force snd_pcm_format_t) 56)	/* in four bytes */
+#define	SNDRV_PCM_FORMAT_LAST		SNDRV_PCM_FORMAT_U20_4BE
 
 #ifdef SNDRV_LITTLE_ENDIAN
 #define	SNDRV_PCM_FORMAT_S16		SNDRV_PCM_FORMAT_S16_LE
@@ -248,6 +252,8 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_FLOAT		SNDRV_PCM_FORMAT_FLOAT_LE
 #define	SNDRV_PCM_FORMAT_FLOAT64	SNDRV_PCM_FORMAT_FLOAT64_LE
 #define	SNDRV_PCM_FORMAT_IEC958_SUBFRAME SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE
+#define	SNDRV_PCM_FORMAT_S20_4		SNDRV_PCM_FORMAT_S20_4LE
+#define	SNDRV_PCM_FORMAT_U20_4		SNDRV_PCM_FORMAT_U20_4LE
 #endif
 #ifdef SNDRV_BIG_ENDIAN
 #define	SNDRV_PCM_FORMAT_S16		SNDRV_PCM_FORMAT_S16_BE
@@ -259,6 +265,8 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_FLOAT		SNDRV_PCM_FORMAT_FLOAT_BE
 #define	SNDRV_PCM_FORMAT_FLOAT64	SNDRV_PCM_FORMAT_FLOAT64_BE
 #define	SNDRV_PCM_FORMAT_IEC958_SUBFRAME SNDRV_PCM_FORMAT_IEC958_SUBFRAME_BE
+#define	SNDRV_PCM_FORMAT_S20_4		SNDRV_PCM_FORMAT_S20_4BE
+#define	SNDRV_PCM_FORMAT_U20_4		SNDRV_PCM_FORMAT_U20_4BE
 #endif
 
 typedef int __bitwise snd_pcm_subformat_t;
diff --git a/sound/core/pcm_misc.c b/sound/core/pcm_misc.c
index 9be81025372f..132ee41edae1 100644
--- a/sound/core/pcm_misc.c
+++ b/sound/core/pcm_misc.c
@@ -229,6 +229,22 @@ static struct pcm_format_data pcm_formats[(INT)SNDRV_PCM_FORMAT_LAST+1] = {
 		.width = 5, .phys = 8, .le = -1, .signd = -1,
 		.silence = {},
 	},
+	[SNDRV_PCM_FORMAT_S20_4LE] = {
+		.width = 20, .phys = 32, .le = 1, .signd = 1,
+		.silence = {},
+	},
+	[SNDRV_PCM_FORMAT_S20_4BE] = {
+		.width = 20, .phys = 32, .le = 0, .signd = 1,
+		.silence = {},
+	},
+	[SNDRV_PCM_FORMAT_U20_4LE] = {
+		.width = 20, .phys = 32, .le = 1, .signd = 0,
+		.silence = { 0x00, 0x00, 0x08, 0x00 },
+	},
+	[SNDRV_PCM_FORMAT_U20_4BE] = {
+		.width = 20, .phys = 32, .le = 0, .signd = 0,
+		.silence = { 0x00, 0x08, 0x00, 0x00 },
+	},
 };
 
 
