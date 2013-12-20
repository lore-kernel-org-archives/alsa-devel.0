From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 15/19] ASoC: sh: Don't set unused struct
	snd_pcm_hardware fields
Date: Fri, 20 Dec 2013 14:20:21 +0100
Message-ID: <1387545625-19240-15-git-send-email-lars@metafoo.de>
References: <1387545625-19240-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-044.synserver.de (smtp-out-122.synserver.de
 [212.40.185.122])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A528265667
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 15:19:46 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The ASoC core assumes that the PCM component of the ASoC card transparently
moves data around and does not impose any restrictions on the memory layout or
the transfer speed. It ignores all fields from the snd_pcm_hardware struct for
the PCM driver that are related to this. Setting these fields in the PCM driver
might suggest otherwise though, so rather not set them.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/sh/dma-sh7760.c | 17 -----------------
 sound/soc/sh/fsi.c        |  6 ------
 sound/soc/sh/rcar/core.c  |  6 ------
 3 files changed, 29 deletions(-)

diff --git a/sound/soc/sh/dma-sh7760.c b/sound/soc/sh/dma-sh7760.c
index 1a8b03e..c85f8eb 100644
--- a/sound/soc/sh/dma-sh7760.c
+++ b/sound/soc/sh/dma-sh7760.c
@@ -89,29 +89,12 @@ struct camelot_pcm {
 #define DMABRG_PREALLOC_BUFFER		32 * 1024
 #define DMABRG_PREALLOC_BUFFER_MAX	32 * 1024
 
-/* support everything the SSI supports */
-#define DMABRG_RATES	\
-	SNDRV_PCM_RATE_8000_192000
-
-#define DMABRG_FMTS	\
-	(SNDRV_PCM_FMTBIT_S8      | SNDRV_PCM_FMTBIT_U8      |	\
-	 SNDRV_PCM_FMTBIT_S16_LE  | SNDRV_PCM_FMTBIT_U16_LE  |	\
-	 SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_U20_3LE |	\
-	 SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_U24_3LE |	\
-	 SNDRV_PCM_FMTBIT_S32_LE  | SNDRV_PCM_FMTBIT_U32_LE)
-
 static struct snd_pcm_hardware camelot_pcm_hardware = {
 	.info = (SNDRV_PCM_INFO_MMAP |
 		SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		SNDRV_PCM_INFO_MMAP_VALID |
 		SNDRV_PCM_INFO_BATCH),
-	.formats =	DMABRG_FMTS,
-	.rates =	DMABRG_RATES,
-	.rate_min =		8000,
-	.rate_max =		192000,
-	.channels_min =		2,
-	.channels_max =		8,		/* max of the SSI */
 	.buffer_bytes_max =	DMABRG_PERIOD_MAX,
 	.period_bytes_min =	DMABRG_PERIOD_MIN,
 	.period_bytes_max =	DMABRG_PERIOD_MAX / 2,
diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 6101055..1967f44 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1787,12 +1787,6 @@ static struct snd_pcm_hardware fsi_pcm_hardware = {
 			SNDRV_PCM_INFO_MMAP		|
 			SNDRV_PCM_INFO_MMAP_VALID	|
 			SNDRV_PCM_INFO_PAUSE,
-	.formats		= FSI_FMTS,
-	.rates			= FSI_RATES,
-	.rate_min		= 8000,
-	.rate_max		= 192000,
-	.channels_min		= 2,
-	.channels_max		= 2,
 	.buffer_bytes_max	= 64 * 1024,
 	.period_bytes_min	= 32,
 	.period_bytes_max	= 8192,
diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index b3653d3..743de5e 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -628,12 +628,6 @@ static struct snd_pcm_hardware rsnd_pcm_hardware = {
 			SNDRV_PCM_INFO_MMAP		|
 			SNDRV_PCM_INFO_MMAP_VALID	|
 			SNDRV_PCM_INFO_PAUSE,
-	.formats		= RSND_FMTS,
-	.rates			= RSND_RATES,
-	.rate_min		= 8000,
-	.rate_max		= 192000,
-	.channels_min		= 2,
-	.channels_max		= 2,
 	.buffer_bytes_max	= 64 * 1024,
 	.period_bytes_min	= 32,
 	.period_bytes_max	= 8192,
-- 
1.8.0
