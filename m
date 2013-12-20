From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/19] ASoC: davinci: Don't set unused struct
	snd_pcm_hardware fields
Date: Fri, 20 Dec 2013 14:20:10 +0100
Message-ID: <1387545625-19240-4-git-send-email-lars@metafoo.de>
References: <1387545625-19240-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-044.synserver.de (smtp-out-122.synserver.de
 [212.40.185.122])
 by alsa0.perex.cz (Postfix) with ESMTP id 854FF265636
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 15:19:35 +0100 (CET)
In-Reply-To: <1387545625-19240-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Olof Johansson <olof@lixom.net>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The ASoC core assumes that the PCM component of the ASoC card transparently
moves data around and does not impose any restrictions on the memory layout or
the transfer speed. It ignores all fields from the snd_pcm_hardware struct for
the PCM driver that are related to this. Setting these fields in the PCM driver
might suggest otherwise though, so rather not set them.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Olof Johansson <olof@lixom.net>
---
 sound/soc/davinci/davinci-pcm.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index fb5d107..14145cd 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -46,33 +46,11 @@ static void print_buf_info(int slot, char *name)
 }
 #endif
 
-#define DAVINCI_PCM_FMTBITS	(\
-				SNDRV_PCM_FMTBIT_S8	|\
-				SNDRV_PCM_FMTBIT_U8	|\
-				SNDRV_PCM_FMTBIT_S16_LE	|\
-				SNDRV_PCM_FMTBIT_S16_BE	|\
-				SNDRV_PCM_FMTBIT_U16_LE	|\
-				SNDRV_PCM_FMTBIT_U16_BE	|\
-				SNDRV_PCM_FMTBIT_S24_LE	|\
-				SNDRV_PCM_FMTBIT_S24_BE	|\
-				SNDRV_PCM_FMTBIT_U24_LE	|\
-				SNDRV_PCM_FMTBIT_U24_BE	|\
-				SNDRV_PCM_FMTBIT_S32_LE	|\
-				SNDRV_PCM_FMTBIT_S32_BE	|\
-				SNDRV_PCM_FMTBIT_U32_LE	|\
-				SNDRV_PCM_FMTBIT_U32_BE)
-
 static struct snd_pcm_hardware pcm_hardware_playback = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
 		 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME|
 		 SNDRV_PCM_INFO_BATCH),
-	.formats = DAVINCI_PCM_FMTBITS,
-	.rates = SNDRV_PCM_RATE_8000_192000 | SNDRV_PCM_RATE_KNOT,
-	.rate_min = 8000,
-	.rate_max = 192000,
-	.channels_min = 2,
-	.channels_max = 384,
 	.buffer_bytes_max = 128 * 1024,
 	.period_bytes_min = 32,
 	.period_bytes_max = 8 * 1024,
@@ -86,12 +64,6 @@ static struct snd_pcm_hardware pcm_hardware_capture = {
 		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
 		 SNDRV_PCM_INFO_PAUSE |
 		 SNDRV_PCM_INFO_BATCH),
-	.formats = DAVINCI_PCM_FMTBITS,
-	.rates = SNDRV_PCM_RATE_8000_192000 | SNDRV_PCM_RATE_KNOT,
-	.rate_min = 8000,
-	.rate_max = 192000,
-	.channels_min = 2,
-	.channels_max = 384,
 	.buffer_bytes_max = 128 * 1024,
 	.period_bytes_min = 32,
 	.period_bytes_max = 8 * 1024,
-- 
1.8.0
