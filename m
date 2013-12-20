From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/19] ASoC: kirkwood: Don't set unused struct
	snd_pcm_hardware fields
Date: Fri, 20 Dec 2013 14:20:14 +0100
Message-ID: <1387545625-19240-8-git-send-email-lars@metafoo.de>
References: <1387545625-19240-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-044.synserver.de (smtp-out-122.synserver.de
 [212.40.185.122])
 by alsa0.perex.cz (Postfix) with ESMTP id 648EF26566F
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 15:19:39 +0100 (CET)
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
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The ASoC core assumes that the PCM component of the ASoC card transparently
moves data around and does not impose any restrictions on the memory layout or
the transfer speed. It ignores all fields from the snd_pcm_hardware struct for
the PCM driver that are related to this. Setting these fields in the PCM driver
might suggest otherwise though, so rather not set them.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean-Francois Moine <moinejf@free.fr>
---
 sound/soc/kirkwood/kirkwood-dma.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index 4af1936..aac22fc 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -21,16 +21,6 @@
 #include <sound/soc.h>
 #include "kirkwood.h"
 
-#define KIRKWOOD_RATES \
-	(SNDRV_PCM_RATE_8000_192000 |		\
-	 SNDRV_PCM_RATE_CONTINUOUS |		\
-	 SNDRV_PCM_RATE_KNOT)
-
-#define KIRKWOOD_FORMATS \
-	(SNDRV_PCM_FMTBIT_S16_LE | \
-	 SNDRV_PCM_FMTBIT_S24_LE | \
-	 SNDRV_PCM_FMTBIT_S32_LE)
-
 static struct kirkwood_dma_data *kirkwood_priv(struct snd_pcm_substream *subs)
 {
 	struct snd_soc_pcm_runtime *soc_runtime = subs->private_data;
@@ -43,12 +33,6 @@ static struct snd_pcm_hardware kirkwood_dma_snd_hw = {
 		 SNDRV_PCM_INFO_MMAP_VALID |
 		 SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		 SNDRV_PCM_INFO_PAUSE),
-	.formats		= KIRKWOOD_FORMATS,
-	.rates			= KIRKWOOD_RATES,
-	.rate_min		= 8000,
-	.rate_max		= 384000,
-	.channels_min		= 1,
-	.channels_max		= 8,
 	.buffer_bytes_max	= KIRKWOOD_SND_MAX_BUFFER_BYTES,
 	.period_bytes_min	= KIRKWOOD_SND_MIN_PERIOD_BYTES,
 	.period_bytes_max	= KIRKWOOD_SND_MAX_PERIOD_BYTES,
-- 
1.8.0
