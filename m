From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 03/11] ASoC: atmel: Don't set unused struct
	snd_pcm_hardware fields
Date: Mon,  6 Jan 2014 14:19:08 +0100
Message-ID: <1389014356-7014-3-git-send-email-lars@metafoo.de>
References: <1389014356-7014-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-033.synserver.de (smtp-out-033.synserver.de
 [212.40.185.33])
 by alsa0.perex.cz (Postfix) with ESMTP id 123E92610A6
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2014 14:18:56 +0100 (CET)
In-Reply-To: <1389014356-7014-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: alsa-devel@alsa-project.org

The ASoC core assumes that the PCM component of the ASoC card transparently
moves data around and does not impose any restrictions on the memory layout or
the transfer speed. It ignores all fields from the snd_pcm_hardware struct for
the PCM driver that are related to this. Setting these fields in the PCM driver
might suggest otherwise though, so rather not set them.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Bo Shen <voice.shen@atmel.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
No changes in v2
---
 sound/soc/atmel/atmel-pcm-dma.c | 1 -
 sound/soc/atmel/atmel-pcm-pdc.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/sound/soc/atmel/atmel-pcm-dma.c b/sound/soc/atmel/atmel-pcm-dma.c
index 06082e5..b79a2a8 100644
--- a/sound/soc/atmel/atmel-pcm-dma.c
+++ b/sound/soc/atmel/atmel-pcm-dma.c
@@ -50,7 +50,6 @@ static const struct snd_pcm_hardware atmel_pcm_dma_hardware = {
 				  SNDRV_PCM_INFO_INTERLEAVED |
 				  SNDRV_PCM_INFO_RESUME |
 				  SNDRV_PCM_INFO_PAUSE,
-	.formats		= SNDRV_PCM_FMTBIT_S16_LE,
 	.period_bytes_min	= 256,		/* lighting DMA overhead */
 	.period_bytes_max	= 2 * 0xffff,	/* if 2 bytes format */
 	.periods_min		= 8,
diff --git a/sound/soc/atmel/atmel-pcm-pdc.c b/sound/soc/atmel/atmel-pcm-pdc.c
index 054ea4d..33ec592 100644
--- a/sound/soc/atmel/atmel-pcm-pdc.c
+++ b/sound/soc/atmel/atmel-pcm-pdc.c
@@ -58,7 +58,6 @@ static const struct snd_pcm_hardware atmel_pcm_hardware = {
 				  SNDRV_PCM_INFO_MMAP_VALID |
 				  SNDRV_PCM_INFO_INTERLEAVED |
 				  SNDRV_PCM_INFO_PAUSE,
-	.formats		= SNDRV_PCM_FMTBIT_S16_LE,
 	.period_bytes_min	= 32,
 	.period_bytes_max	= 8192,
 	.periods_min		= 2,
-- 
1.8.0
