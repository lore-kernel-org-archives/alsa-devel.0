From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 1/5] ALSA: ASoC: enable 192KHz support for McASP
Date: Thu,  4 Oct 2012 15:08:38 +0200
Message-ID: <1349356122-14794-2-git-send-email-zonque@gmail.com>
References: <1349356122-14794-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C6EC26163C
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2012 15:09:11 +0200 (CEST)
In-Reply-To: <1349356122-14794-1-git-send-email-zonque@gmail.com>
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/davinci/davinci-mcasp.h |  2 +-
 sound/soc/davinci/davinci-pcm.c   | 16 ++++------------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.h b/sound/soc/davinci/davinci-mcasp.h
index 0de9ed6..156f15f 100644
--- a/sound/soc/davinci/davinci-mcasp.h
+++ b/sound/soc/davinci/davinci-mcasp.h
@@ -23,7 +23,7 @@
 
 #include "davinci-pcm.h"
 
-#define DAVINCI_MCASP_RATES	SNDRV_PCM_RATE_8000_96000
+#define DAVINCI_MCASP_RATES	SNDRV_PCM_RATE_8000_192000
 #define DAVINCI_MCASP_I2S_DAI	0
 #define DAVINCI_MCASP_DIT_DAI	1
 
diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index f47b8f3..61117e0 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -70,13 +70,9 @@ static struct snd_pcm_hardware pcm_hardware_playback = {
 		 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME|
 		 SNDRV_PCM_INFO_BATCH),
 	.formats = DAVINCI_PCM_FMTBITS,
-	.rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
-		  SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
-		  SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
-		  SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
-		  SNDRV_PCM_RATE_KNOT),
+	.rates = SNDRV_PCM_RATE_8000_192000 | SNDRV_PCM_RATE_KNOT,
 	.rate_min = 8000,
-	.rate_max = 96000,
+	.rate_max = 192000,
 	.channels_min = 2,
 	.channels_max = 384,
 	.buffer_bytes_max = 128 * 1024,
@@ -93,13 +89,9 @@ static struct snd_pcm_hardware pcm_hardware_capture = {
 		 SNDRV_PCM_INFO_PAUSE |
 		 SNDRV_PCM_INFO_BATCH),
 	.formats = DAVINCI_PCM_FMTBITS,
-	.rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
-		  SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
-		  SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
-		  SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
-		  SNDRV_PCM_RATE_KNOT),
+	.rates = SNDRV_PCM_RATE_8000_192000 | SNDRV_PCM_RATE_KNOT,
 	.rate_min = 8000,
-	.rate_max = 96000,
+	.rate_max = 192000,
 	.channels_min = 2,
 	.channels_max = 384,
 	.buffer_bytes_max = 128 * 1024,
-- 
1.7.11.4
