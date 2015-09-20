From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Remove unused CPU dais"
	to the asoc tree
Date: Sat, 19 Sep 2015 17:13:02 -0700
Message-ID: <E1ZdSFa-0003zN-Pg@finisterre>
References: <1438971749-874-14-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CC6B2605D6
 for <alsa-devel@alsa-project.org>; Sun, 20 Sep 2015 02:13:16 +0200 (CEST)
In-Reply-To: <1438971749-874-14-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Remove unused CPU dais

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

>From 5b97c0f18a1781f50db96baa020f913886d1972a Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Mon, 17 Aug 2015 22:56:44 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Remove unused CPU dais

We need to create CPU DAI for each endpoint instance. For this we
should have one DMIC DAI, one HDA DAI and SSP DAI.  Thus, DMIC23,
HDA-SPK/AMIC was not required so this patch removes them

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 7d617bf..bea2673 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -510,17 +510,6 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 	},
 },
 {
-	.name = "DMIC23 Pin",
-	.ops = &skl_dmic_dai_ops,
-	.capture = {
-		.stream_name = "DMIC23 Rx",
-		.channels_min = HDA_STEREO,
-		.channels_max = HDA_STEREO,
-		.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_16000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
-	},
-},
-{
 	.name = "HD-Codec Pin",
 	.ops = &skl_link_dai_ops,
 	.playback = {
@@ -538,28 +527,6 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
 },
-{
-	.name = "HD-Codec-SPK Pin",
-	.ops = &skl_link_dai_ops,
-	.playback = {
-		.stream_name = "HD-Codec-SPK Tx",
-		.channels_min = HDA_STEREO,
-		.channels_max = HDA_STEREO,
-		.rates = SNDRV_PCM_RATE_48000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
-	},
-},
-{
-	.name = "HD-Codec-AMIC Pin",
-	.ops = &skl_link_dai_ops,
-	.capture = {
-		.stream_name = "HD-Codec-AMIC Rx",
-		.channels_min = HDA_STEREO,
-		.channels_max = HDA_STEREO,
-		.rates = SNDRV_PCM_RATE_48000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
-	},
-},
 };
 
 static int skl_platform_open(struct snd_pcm_substream *substream)
-- 
2.5.0
