From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 2/5] ASoC: Intel: Skylake: Add BE DAI for WoV
	usecase
Date: Sat, 27 Jan 2018 09:50:22 +0530
Message-ID: <20180127042025.22042-3-guneshwor.o.singh@intel.com>
References: <20180127042025.22042-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id BFEBD266F35
 for <alsa-devel@alsa-project.org>; Sat, 27 Jan 2018 05:21:21 +0100 (CET)
In-Reply-To: <20180127042025.22042-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, "Pawse,
 GuruprasadX" <guruprasadx.pawse@intel.com>, Pawse@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: "Pawse, GuruprasadX" <guruprasadx.pawse@intel.com>

Currently DMIC capture and WoV usecase uses same BE DAI but operate at
different sampling rates, this results in config mismatch for WoV when
DMIC is already running in parallel.

DMIC has two slots which can operate with some constraints, so add BE
DAI for DMICvoice pin which can used for WoV usecases to capture 4ch,
16KHz, 16bit data.

Signed-off-by: Pawse, GuruprasadX <guruprasadx.pawse@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
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
2.16.1
