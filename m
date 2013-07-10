From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/4] ASoC: pcm3008: Remove noisy version print
Date: Wed, 10 Jul 2013 16:54:57 +0100
Message-ID: <1373471700-24119-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 88CF7264F10
 for <alsa-devel@alsa-project.org>; Wed, 10 Jul 2013 17:56:06 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The version number has never been updated and the printk isn't based on
any interaction with the device.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/pcm3008.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/pcm3008.c b/sound/soc/codecs/pcm3008.c
index f2a6282..32e5a59 100644
--- a/sound/soc/codecs/pcm3008.c
+++ b/sound/soc/codecs/pcm3008.c
@@ -28,8 +28,6 @@
 
 #include "pcm3008.h"
 
-#define PCM3008_VERSION "0.2"
-
 #define PCM3008_RATES (SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |	\
 		       SNDRV_PCM_RATE_48000)
 
@@ -64,8 +62,6 @@ static int pcm3008_soc_probe(struct snd_soc_codec *codec)
 	struct pcm3008_setup_data *setup = codec->dev->platform_data;
 	int ret = 0;
 
-	printk(KERN_INFO "PCM3008 SoC Audio Codec %s\n", PCM3008_VERSION);
-
 	/* DEM1  DEM0  DE-EMPHASIS_MODE
 	 * Low   Low   De-emphasis 44.1 kHz ON
 	 * Low   High  De-emphasis OFF
-- 
1.8.3.2
