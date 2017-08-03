From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: kbl: Add new FEs for
	Multi-Playback & Echo-Reference" to the asoc tree
Date: Thu, 03 Aug 2017 17:30:36 +0100
Message-ID: <E1ddJ1A-0002cw-4k@debutante>
References: <1501654415-24590-2-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A10A9267411
 for <alsa-devel@alsa-project.org>; Thu,  3 Aug 2017 18:30:45 +0200 (CEST)
In-Reply-To: <1501654415-24590-2-git-send-email-naveen.m@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Sathya Prakash M R <sathya.prakash.m.r@intel.com>, naveen.m@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: kbl: Add new FEs for Multi-Playback & Echo-Reference

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

>From da3cbb40f35b4b5ab66df9a23a717a4a5df1f992 Mon Sep 17 00:00:00 2001
From: Naveen Manohar <naveen.m@intel.com>
Date: Wed, 2 Aug 2017 11:43:33 +0530
Subject: [PATCH] ASoC: Intel: kbl: Add new FEs for Multi-Playback &
 Echo-Reference

Adding new frontends to support:
1. Parallel playback on 2 ports simultaneously
2. Echo reference capture capability

Signed-off-by: Naveen M <naveen.m@intel.com>
Signed-off-by: Sathya Prakash M R <sathya.prakash.m.r@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index b1f2dba642c4..debdaac2c3a2 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -675,6 +675,32 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 	},
 },
 {
+	.name = "System Pin2",
+	.ops = &skl_pcm_dai_ops,
+	.playback = {
+		.stream_name = "Headset Playback",
+		.channels_min = HDA_MONO,
+		.channels_max = HDA_STEREO,
+		.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_16000 |
+			SNDRV_PCM_RATE_8000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE |
+			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE,
+	},
+},
+{
+	.name = "Echoref Pin",
+	.ops = &skl_pcm_dai_ops,
+	.capture = {
+		.stream_name = "Echoreference Capture",
+		.channels_min = HDA_STEREO,
+		.channels_max = HDA_STEREO,
+		.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_16000 |
+			SNDRV_PCM_RATE_8000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE |
+			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE,
+	},
+},
+{
 	.name = "Reference Pin",
 	.ops = &skl_pcm_dai_ops,
 	.capture = {
-- 
2.13.2
