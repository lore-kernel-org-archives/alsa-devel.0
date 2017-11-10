From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: bcm2835: Support additional samplerates
	up to 384kHz" to the asoc tree
Date: Fri, 10 Nov 2017 21:29:15 +0000
Message-ID: <E1eDGrT-0004Pm-95@debutante>
References: <1466358739-31669-1-git-send-email-clive.messer@digitaldreamtime.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A11BC2679CD
 for <alsa-devel@alsa-project.org>; Fri, 10 Nov 2017 22:29:19 +0100 (CET)
In-Reply-To: <1466358739-31669-1-git-send-email-clive.messer@digitaldreamtime.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matthias Reichl <hias@horus.com>
Cc: Clive Messer <clive.messer@digitaldreamtime.co.uk>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: bcm2835: Support additional samplerates up to 384kHz

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

>From 675c0ee514f56ea39f6f550299621aafe9a53fc0 Mon Sep 17 00:00:00 2001
From: Matthias Reichl <hias@horus.com>
Date: Wed, 8 Nov 2017 21:03:31 +0100
Subject: [PATCH] ASoC: bcm2835: Support additional samplerates up to 384kHz

Sample rates are only restricted by the capabilities of the
clock driver, so use SNDRV_PCM_RATE_CONTINUOUS instead of
SNDRV_PCM_RATE_8000_192000.

Tests (eg with pcm5122) have shown that bcm2835 works fine
in 384kHz/32bit stereo mode, so change the maximum allowed
rate from 192kHz to 384kHz.

Signed-off-by: Matthias Reichl <hias@horus.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/bcm/bcm2835-i2s.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
index dcacf7f83c93..f4b778ed350b 100644
--- a/sound/soc/bcm/bcm2835-i2s.c
+++ b/sound/soc/bcm/bcm2835-i2s.c
@@ -719,7 +719,9 @@ static struct snd_soc_dai_driver bcm2835_i2s_dai = {
 	.playback = {
 		.channels_min = 2,
 		.channels_max = 2,
-		.rates =	SNDRV_PCM_RATE_8000_192000,
+		.rates =	SNDRV_PCM_RATE_CONTINUOUS,
+		.rate_min =	8000,
+		.rate_max =	384000,
 		.formats =	SNDRV_PCM_FMTBIT_S16_LE
 				| SNDRV_PCM_FMTBIT_S24_LE
 				| SNDRV_PCM_FMTBIT_S32_LE
@@ -727,7 +729,9 @@ static struct snd_soc_dai_driver bcm2835_i2s_dai = {
 	.capture = {
 		.channels_min = 2,
 		.channels_max = 2,
-		.rates =	SNDRV_PCM_RATE_8000_192000,
+		.rates =	SNDRV_PCM_RATE_CONTINUOUS,
+		.rate_min =	8000,
+		.rate_max =	384000,
 		.formats =	SNDRV_PCM_FMTBIT_S16_LE
 				| SNDRV_PCM_FMTBIT_S24_LE
 				| SNDRV_PCM_FMTBIT_S32_LE
-- 
2.15.0
