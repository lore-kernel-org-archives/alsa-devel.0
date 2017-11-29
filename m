From: Mark Brown <broonie@kernel.org>
Subject: Applied "ALSA: pcm: add SNDRV_PCM_FORMAT_{S,
	U}20" to the asoc tree
Date: Wed, 29 Nov 2017 19:00:01 +0000
Message-ID: <E1eK7aT-0004iV-CY@debutante>
References: <3a279ea2-8098-d5a4-a53e-b0e3585fa9bf@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B74EF267960
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 20:00:27 +0100 (CET)
In-Reply-To: <3a279ea2-8098-d5a4-a53e-b0e3585fa9bf@maciej.szmigiero.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ALSA: pcm: add SNDRV_PCM_FORMAT_{S,U}20

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 823dbb6eb08a2865bcd236b4f52b1b9de216418a Mon Sep 17 00:00:00 2001
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Date: Mon, 27 Nov 2017 23:33:29 +0100
Subject: [PATCH] ALSA: pcm: add SNDRV_PCM_FORMAT_{S,U}20

This format is similar to existing SNDRV_PCM_FORMAT_{S,U}20_3 that keep
20-bit PCM samples in 3 bytes, however i.MX6 platform SSI FIFO does not
allow 3-byte accesses (including DMA) so a 4-byte (more conventional)
format is needed for it.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/pcm.h         |  8 ++++++++
 include/sound/soc-dai.h     |  2 ++
 include/uapi/sound/asound.h |  9 +++++++++
 sound/core/pcm_misc.c       | 19 ++++++++++++++++++-
 4 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 24febf9e177c..e054c583d3b3 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -169,6 +169,10 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_FMTBIT_IMA_ADPCM	_SNDRV_PCM_FMTBIT(IMA_ADPCM)
 #define SNDRV_PCM_FMTBIT_MPEG		_SNDRV_PCM_FMTBIT(MPEG)
 #define SNDRV_PCM_FMTBIT_GSM		_SNDRV_PCM_FMTBIT(GSM)
+#define SNDRV_PCM_FMTBIT_S20_LE	_SNDRV_PCM_FMTBIT(S20_LE)
+#define SNDRV_PCM_FMTBIT_U20_LE	_SNDRV_PCM_FMTBIT(U20_LE)
+#define SNDRV_PCM_FMTBIT_S20_BE	_SNDRV_PCM_FMTBIT(S20_BE)
+#define SNDRV_PCM_FMTBIT_U20_BE	_SNDRV_PCM_FMTBIT(U20_BE)
 #define SNDRV_PCM_FMTBIT_SPECIAL	_SNDRV_PCM_FMTBIT(SPECIAL)
 #define SNDRV_PCM_FMTBIT_S24_3LE	_SNDRV_PCM_FMTBIT(S24_3LE)
 #define SNDRV_PCM_FMTBIT_U24_3LE	_SNDRV_PCM_FMTBIT(U24_3LE)
@@ -202,6 +206,8 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_FMTBIT_FLOAT		SNDRV_PCM_FMTBIT_FLOAT_LE
 #define SNDRV_PCM_FMTBIT_FLOAT64	SNDRV_PCM_FMTBIT_FLOAT64_LE
 #define SNDRV_PCM_FMTBIT_IEC958_SUBFRAME SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE
+#define SNDRV_PCM_FMTBIT_S20		SNDRV_PCM_FMTBIT_S20_LE
+#define SNDRV_PCM_FMTBIT_U20		SNDRV_PCM_FMTBIT_U20_LE
 #endif
 #ifdef SNDRV_BIG_ENDIAN
 #define SNDRV_PCM_FMTBIT_S16		SNDRV_PCM_FMTBIT_S16_BE
@@ -213,6 +219,8 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_FMTBIT_FLOAT		SNDRV_PCM_FMTBIT_FLOAT_BE
 #define SNDRV_PCM_FMTBIT_FLOAT64	SNDRV_PCM_FMTBIT_FLOAT64_BE
 #define SNDRV_PCM_FMTBIT_IEC958_SUBFRAME SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_BE
+#define SNDRV_PCM_FMTBIT_S20		SNDRV_PCM_FMTBIT_S20_BE
+#define SNDRV_PCM_FMTBIT_U20		SNDRV_PCM_FMTBIT_U20_BE
 #endif
 
 struct snd_pcm_file {
diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 58acd00cae19..d970879944fc 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -102,6 +102,8 @@ struct snd_compr_stream;
 			       SNDRV_PCM_FMTBIT_S16_BE |\
 			       SNDRV_PCM_FMTBIT_S20_3LE |\
 			       SNDRV_PCM_FMTBIT_S20_3BE |\
+			       SNDRV_PCM_FMTBIT_S20_LE |\
+			       SNDRV_PCM_FMTBIT_S20_BE |\
 			       SNDRV_PCM_FMTBIT_S24_3LE |\
 			       SNDRV_PCM_FMTBIT_S24_3BE |\
                                SNDRV_PCM_FMTBIT_S32_LE |\
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index c227ccba60ae..07d61583fd02 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -214,6 +214,11 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_IMA_ADPCM	((__force snd_pcm_format_t) 22)
 #define	SNDRV_PCM_FORMAT_MPEG		((__force snd_pcm_format_t) 23)
 #define	SNDRV_PCM_FORMAT_GSM		((__force snd_pcm_format_t) 24)
+#define	SNDRV_PCM_FORMAT_S20_LE	((__force snd_pcm_format_t) 25) /* in four bytes, LSB justified */
+#define	SNDRV_PCM_FORMAT_S20_BE	((__force snd_pcm_format_t) 26) /* in four bytes, LSB justified */
+#define	SNDRV_PCM_FORMAT_U20_LE	((__force snd_pcm_format_t) 27) /* in four bytes, LSB justified */
+#define	SNDRV_PCM_FORMAT_U20_BE	((__force snd_pcm_format_t) 28) /* in four bytes, LSB justified */
+/* gap in the numbering for a future standard linear format */
 #define	SNDRV_PCM_FORMAT_SPECIAL	((__force snd_pcm_format_t) 31)
 #define	SNDRV_PCM_FORMAT_S24_3LE	((__force snd_pcm_format_t) 32)	/* in three bytes */
 #define	SNDRV_PCM_FORMAT_S24_3BE	((__force snd_pcm_format_t) 33)	/* in three bytes */
@@ -248,6 +253,8 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_FLOAT		SNDRV_PCM_FORMAT_FLOAT_LE
 #define	SNDRV_PCM_FORMAT_FLOAT64	SNDRV_PCM_FORMAT_FLOAT64_LE
 #define	SNDRV_PCM_FORMAT_IEC958_SUBFRAME SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE
+#define	SNDRV_PCM_FORMAT_S20		SNDRV_PCM_FORMAT_S20_LE
+#define	SNDRV_PCM_FORMAT_U20		SNDRV_PCM_FORMAT_U20_LE
 #endif
 #ifdef SNDRV_BIG_ENDIAN
 #define	SNDRV_PCM_FORMAT_S16		SNDRV_PCM_FORMAT_S16_BE
@@ -259,6 +266,8 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_FLOAT		SNDRV_PCM_FORMAT_FLOAT_BE
 #define	SNDRV_PCM_FORMAT_FLOAT64	SNDRV_PCM_FORMAT_FLOAT64_BE
 #define	SNDRV_PCM_FORMAT_IEC958_SUBFRAME SNDRV_PCM_FORMAT_IEC958_SUBFRAME_BE
+#define	SNDRV_PCM_FORMAT_S20		SNDRV_PCM_FORMAT_S20_BE
+#define	SNDRV_PCM_FORMAT_U20		SNDRV_PCM_FORMAT_U20_BE
 #endif
 
 typedef int __bitwise snd_pcm_subformat_t;
diff --git a/sound/core/pcm_misc.c b/sound/core/pcm_misc.c
index 9be81025372f..c4eb561d2008 100644
--- a/sound/core/pcm_misc.c
+++ b/sound/core/pcm_misc.c
@@ -163,13 +163,30 @@ static struct pcm_format_data pcm_formats[(INT)SNDRV_PCM_FORMAT_LAST+1] = {
 		.width = 32, .phys = 32, .le = 0, .signd = 0,
 		.silence = { 0x69, 0x69, 0x69, 0x69 },
 	},
-	/* FIXME: the following three formats are not defined properly yet */
+	/* FIXME: the following two formats are not defined properly yet */
 	[SNDRV_PCM_FORMAT_MPEG] = {
 		.le = -1, .signd = -1,
 	},
 	[SNDRV_PCM_FORMAT_GSM] = {
 		.le = -1, .signd = -1,
 	},
+	[SNDRV_PCM_FORMAT_S20_LE] = {
+		.width = 20, .phys = 32, .le = 1, .signd = 1,
+		.silence = {},
+	},
+	[SNDRV_PCM_FORMAT_S20_BE] = {
+		.width = 20, .phys = 32, .le = 0, .signd = 1,
+		.silence = {},
+	},
+	[SNDRV_PCM_FORMAT_U20_LE] = {
+		.width = 20, .phys = 32, .le = 1, .signd = 0,
+		.silence = { 0x00, 0x00, 0x08, 0x00 },
+	},
+	[SNDRV_PCM_FORMAT_U20_BE] = {
+		.width = 20, .phys = 32, .le = 0, .signd = 0,
+		.silence = { 0x00, 0x08, 0x00, 0x00 },
+	},
+	/* FIXME: the following format is not defined properly yet */
 	[SNDRV_PCM_FORMAT_SPECIAL] = {
 		.le = -1, .signd = -1,
 	},
-- 
2.15.0
