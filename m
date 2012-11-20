From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 08/10] ASoC: kirkwood-dma: remove restriction
	on sample rates
Date: Tue, 20 Nov 2012 12:20:14 +0000
Message-ID: <E1TamoI-0007Xc-8G@rmk-PC.arm.linux.org.uk>
References: <20121120121726.GN3290@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 5FE06265372
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2012 13:20:16 +0100 (CET)
In-Reply-To: <20121120121726.GN3290@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Liam Girdwood <lrg@ti.com>, Rabeeh Khoury <rabeeh@solid-run.com>
List-Id: alsa-devel@alsa-project.org

This is part of a patch found in Rabeeh Khoury's git tree for the
cubox.

The kirkwood DMA hardware for ASoC does not impose any restrictions
on the sample rates available, so it's silly to impose an artificial
set in the DMA code.  The restrictions come from the availble clocks
to the I2S module, which are already handled in the I2S part of the
driver.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood-dma.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index 2ba0814..73c90c6 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -22,8 +22,10 @@
 #include "kirkwood.h"
 
 #define KIRKWOOD_RATES \
-	(SNDRV_PCM_RATE_44100 | \
-	 SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000)
+	(SNDRV_PCM_RATE_8000_192000 |		\
+	 SNDRV_PCM_RATE_CONTINUOUS |		\
+	 SNDRV_PCM_RATE_KNOT)
+
 #define KIRKWOOD_FORMATS \
 	(SNDRV_PCM_FMTBIT_S16_LE | \
 	 SNDRV_PCM_FMTBIT_S24_LE | \
@@ -43,8 +45,8 @@ static struct snd_pcm_hardware kirkwood_dma_snd_hw = {
 		 SNDRV_PCM_INFO_PAUSE),
 	.formats		= KIRKWOOD_FORMATS,
 	.rates			= KIRKWOOD_RATES,
-	.rate_min		= 44100,
-	.rate_max		= 96000,
+	.rate_min		= 8000,
+	.rate_max		= 384000,
 	.channels_min		= 1,
 	.channels_max		= 2,
 	.buffer_bytes_max	= KIRKWOOD_SND_MAX_PERIOD_BYTES * KIRKWOOD_SND_MAX_PERIODS,
-- 
1.7.4.4
