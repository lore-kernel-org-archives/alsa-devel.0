From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm179x: Support continuous rates" to
	the asoc tree
Date: Fri, 29 Jan 2016 01:22:29 +0100
Message-ID: <E1aOwpZ-0005nK-0s@finisterre>
References: <1453390018-16854-4-git-send-email-jacob@teenage.engineering>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AA597261546
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2016 01:22:42 +0100 (CET)
In-Reply-To: <1453390018-16854-4-git-send-email-jacob@teenage.engineering>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jacob Siverskog <jacob@teenage.engineering>, Michael Trimarchi <michael@amarulasolutions.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm179x: Support continuous rates

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From e0236f541e68aa2187a9a402bf74bec6f007eb84 Mon Sep 17 00:00:00 2001
From: Jacob Siverskog <jacob@teenage.engineering>
Date: Fri, 22 Jan 2016 13:39:55 +0100
Subject: [PATCH] ASoC: pcm179x: Support continuous rates

According to the PCM179x data sheets sampling frequencies between 10
kHz and 200 kHz are supported. Specify support in the driver.

Tested with PCM1791A.

References:
http://www.ti.com/lit/ds/symlink/pcm1791a.pdf
http://www.ti.com/lit/ds/symlink/pcm1792a.pdf
http://www.ti.com/lit/ds/symlink/pcm1795.pdf
http://www.ti.com/lit/ds/symlink/pcm1796.pdf

Signed-off-by: Jacob Siverskog <jacob@teenage.engineering>
Reviewed-by: Johan Hovold <johan@kernel.org>
Acked-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm179x.c | 4 +++-
 sound/soc/codecs/pcm179x.h | 4 ----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/pcm179x.c b/sound/soc/codecs/pcm179x.c
index 8f20f70..06a6657 100644
--- a/sound/soc/codecs/pcm179x.c
+++ b/sound/soc/codecs/pcm179x.c
@@ -187,7 +187,9 @@ static struct snd_soc_dai_driver pcm179x_dai = {
 		.stream_name = "Playback",
 		.channels_min = 2,
 		.channels_max = 2,
-		.rates = PCM1792A_RATES,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
+		.rate_min = 10000,
+		.rate_max = 200000,
 		.formats = PCM1792A_FORMATS, },
 	.ops = &pcm179x_dai_ops,
 };
diff --git a/sound/soc/codecs/pcm179x.h b/sound/soc/codecs/pcm179x.h
index c4eea4d..11e3312 100644
--- a/sound/soc/codecs/pcm179x.h
+++ b/sound/soc/codecs/pcm179x.h
@@ -17,10 +17,6 @@
 #ifndef __PCM179X_H__
 #define __PCM179X_H__
 
-#define PCM1792A_RATES (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_8000_48000 | \
-			SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 | \
-			SNDRV_PCM_RATE_192000)
-
 #define PCM1792A_FORMATS (SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S24_LE | \
 			  SNDRV_PCM_FMTBIT_S16_LE)
 
-- 
2.6.4
