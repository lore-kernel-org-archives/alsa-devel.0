From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: board: Add BE DAI link for WoV
	and update DAPM machine map." to the asoc tree
Date: Thu, 01 Mar 2018 19:42:08 +0000
Message-ID: <E1erU5g-0003PL-C7@debutante>
References: <20180127042025.22042-4-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180127042025.22042-4-guneshwor.o.singh@intel.com>
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

   ASoC: Intel: board: Add BE DAI link for WoV and update DAPM machine map.

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

>From 8913f97d2317f363d4d525fdbff5817942bda6d1 Mon Sep 17 00:00:00 2001
From: "Pawse, GuruprasadX" <guruprasadx.pawse@intel.com>
Date: Sat, 27 Jan 2018 09:50:23 +0530
Subject: [PATCH] ASoC: Intel: board: Add BE DAI link for WoV and update DAPM
 machine map.

Create BE DAI link for WoV and accordingly update the DAPM machine map

Signed-off-by: Pawse, GuruprasadX <guruprasadx.pawse@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bxt_rt298.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index 875d85119c66..c7e9024e65ef 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -146,6 +146,9 @@ static const struct snd_soc_dapm_route geminilake_rt298_map[] = {
 	{ "dmic01_hifi", NULL, "DMIC01 Rx" },
 	{ "DMIC01 Rx", NULL, "Capture" },
 
+	{ "dmic_voice", NULL, "DMIC16k Rx" },
+	{ "DMIC16k Rx", NULL, "Capture" },
+
 	{ "hifi3", NULL, "iDisp3 Tx"},
 	{ "iDisp3 Tx", NULL, "iDisp3_out"},
 	{ "hifi2", NULL, "iDisp2 Tx"},
@@ -456,6 +459,18 @@ static struct snd_soc_dai_link broxton_rt298_dais[] = {
 		.dpcm_capture = 1,
 		.no_pcm = 1,
 	},
+	{
+		.name = "dmic16k",
+		.id = 2,
+		.cpu_dai_name = "DMIC16k Pin",
+		.codec_name = "dmic-codec",
+		.codec_dai_name = "dmic-hifi",
+		.platform_name = "0000:00:0e.0",
+		.be_hw_params_fixup = broxton_dmic_fixup,
+		.ignore_suspend = 1,
+		.dpcm_capture = 1,
+		.no_pcm = 1,
+	},
 	{
 		.name = "iDisp1",
 		.id = 3,
-- 
2.16.2
