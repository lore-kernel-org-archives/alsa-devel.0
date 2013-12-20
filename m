From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 18/19] ASoC: ux500: Don't set unused struct
	snd_pcm_hardware fields
Date: Fri, 20 Dec 2013 14:20:24 +0100
Message-ID: <1387545625-19240-18-git-send-email-lars@metafoo.de>
References: <1387545625-19240-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-044.synserver.de (smtp-out-122.synserver.de
 [212.40.185.122])
 by alsa0.perex.cz (Postfix) with ESMTP id AAE64265616
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 15:19:50 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

The ASoC core assumes that the PCM component of the ASoC card transparently
moves data around and does not impose any restrictions on the memory layout or
the transfer speed. It ignores all fields from the snd_pcm_hardware struct for
the PCM driver that are related to this. Setting these fields in the PCM driver
might suggest otherwise though, so rather not set them.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/ux500/ux500_pcm.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/sound/soc/ux500/ux500_pcm.c b/sound/soc/ux500/ux500_pcm.c
index ce554de..fa71640 100644
--- a/sound/soc/ux500/ux500_pcm.c
+++ b/sound/soc/ux500/ux500_pcm.c
@@ -28,12 +28,6 @@
 #include "ux500_msp_i2s.h"
 #include "ux500_pcm.h"
 
-#define UX500_PLATFORM_MIN_RATE 8000
-#define UX500_PLATFORM_MAX_RATE 48000
-
-#define UX500_PLATFORM_MIN_CHANNELS 1
-#define UX500_PLATFORM_MAX_CHANNELS 8
-
 #define UX500_PLATFORM_PERIODS_BYTES_MIN	128
 #define UX500_PLATFORM_PERIODS_BYTES_MAX	(64 * PAGE_SIZE)
 #define UX500_PLATFORM_PERIODS_MIN		2
@@ -45,15 +39,6 @@ static const struct snd_pcm_hardware ux500_pcm_hw = {
 		SNDRV_PCM_INFO_MMAP |
 		SNDRV_PCM_INFO_RESUME |
 		SNDRV_PCM_INFO_PAUSE,
-	.formats = SNDRV_PCM_FMTBIT_S16_LE |
-		SNDRV_PCM_FMTBIT_U16_LE |
-		SNDRV_PCM_FMTBIT_S16_BE |
-		SNDRV_PCM_FMTBIT_U16_BE,
-	.rates = SNDRV_PCM_RATE_KNOT,
-	.rate_min = UX500_PLATFORM_MIN_RATE,
-	.rate_max = UX500_PLATFORM_MAX_RATE,
-	.channels_min = UX500_PLATFORM_MIN_CHANNELS,
-	.channels_max = UX500_PLATFORM_MAX_CHANNELS,
 	.buffer_bytes_max = UX500_PLATFORM_BUFFER_BYTES_MAX,
 	.period_bytes_min = UX500_PLATFORM_PERIODS_BYTES_MIN,
 	.period_bytes_max = UX500_PLATFORM_PERIODS_BYTES_MAX,
-- 
1.8.0
