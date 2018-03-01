From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add BE DAI for WoV
	usecase" to the asoc tree
Date: Thu, 01 Mar 2018 19:42:16 +0000
Message-ID: <E1erU5o-0003Qk-Jv@debutante>
References: <20180127042025.22042-3-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180127042025.22042-3-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pawse@sirena.org.uk
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, "Pawse, ,
 GuruprasadX" <guruprasadx.pawse@intel.com>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>, Pawse@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add BE DAI for WoV usecase

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

>From 66b4860641cd459cd5e189ed5db6e9f339c31a0f Mon Sep 17 00:00:00 2001
From: "Pawse, GuruprasadX" <guruprasadx.pawse@intel.com>
Date: Sat, 27 Jan 2018 09:50:22 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add BE DAI for WoV usecase

Currently DMIC capture and WoV usecase uses same BE DAI but operate at
different sampling rates, this results in config mismatch for WoV when
DMIC is already running in parallel.

DMIC has two slots which can operate with some constraints, so add BE
DAI for DMICvoice pin which can used for WoV usecases to capture 4ch,
16KHz, 16bit data.

Signed-off-by: Pawse, GuruprasadX <guruprasadx.pawse@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index e46828533826..2685d511c06f 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -958,6 +958,17 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
 	},
 },
+{
+	.name = "DMIC16k Pin",
+	.ops = &skl_dmic_dai_ops,
+	.capture = {
+		.stream_name = "DMIC16k Rx",
+		.channels_min = HDA_MONO,
+		.channels_max = HDA_QUAD,
+		.rates = SNDRV_PCM_RATE_16000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+},
 {
 	.name = "HD-Codec Pin",
 	.ops = &skl_link_dai_ops,
-- 
2.16.2
