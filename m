From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Make sure BDW based machine
	drivers build for SOF" to the asoc tree
Date: Sat, 27 Apr 2019 18:52:39 +0100 (BST)
Message-ID: <20190427175239.62AEE441D3C@finisterre.ee.mobilebroadband>
References: <20190412160904.30418-21-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190412160904.30418-21-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Cc: Dragos Tarcatu <dragos_tarcatu@mentor.com>, Daniel Baluta <daniel.baluta@gmail.com>, sound-open-firmware@alsa-project.org, tiwai@suse.de, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, Mark Brown <broonie@kernel.org>, andriy.shevchenko@linux.intel.com, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Make sure BDW based machine drivers build for SOF

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From f35bf70f61d389754fafd7fce75efbb3bd2eea87 Mon Sep 17 00:00:00 2001
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date: Fri, 12 Apr 2019 11:09:03 -0500
Subject: [PATCH] ASoC: Intel: Make sure BDW based machine drivers build for
 SOF

BDW uses hard coded IPC calls to set SSP, not needed in SOF as SSP is
configured via topology.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bdw-rt5677.c | 4 ++++
 sound/soc/intel/boards/broadwell.c  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/sound/soc/intel/boards/bdw-rt5677.c b/sound/soc/intel/boards/bdw-rt5677.c
index 1844c88ea4e2..6520a8ea5537 100644
--- a/sound/soc/intel/boards/bdw-rt5677.c
+++ b/sound/soc/intel/boards/bdw-rt5677.c
@@ -180,6 +180,7 @@ static const struct snd_soc_ops bdw_rt5677_ops = {
 	.hw_params = bdw_rt5677_hw_params,
 };
 
+#if !IS_ENABLED(CONFIG_SND_SOC_SOF_BROADWELL)
 static int bdw_rt5677_rtd_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
@@ -198,6 +199,7 @@ static int bdw_rt5677_rtd_init(struct snd_soc_pcm_runtime *rtd)
 
 	return 0;
 }
+#endif
 
 static int bdw_rt5677_init(struct snd_soc_pcm_runtime *rtd)
 {
@@ -265,7 +267,9 @@ static struct snd_soc_dai_link bdw_rt5677_dais[] = {
 		.dynamic = 1,
 		.codec_name = "snd-soc-dummy",
 		.codec_dai_name = "snd-soc-dummy-dai",
+#if !IS_ENABLED(CONFIG_SND_SOC_SOF_BROADWELL)
 		.init = bdw_rt5677_rtd_init,
+#endif
 		.trigger = {
 			SND_SOC_DPCM_TRIGGER_POST,
 			SND_SOC_DPCM_TRIGGER_POST
diff --git a/sound/soc/intel/boards/broadwell.c b/sound/soc/intel/boards/broadwell.c
index b86c746d9b7a..0f18f8964f51 100644
--- a/sound/soc/intel/boards/broadwell.c
+++ b/sound/soc/intel/boards/broadwell.c
@@ -131,6 +131,7 @@ static const struct snd_soc_ops broadwell_rt286_ops = {
 	.hw_params = broadwell_rt286_hw_params,
 };
 
+#if !IS_ENABLED(CONFIG_SND_SOC_SOF_BROADWELL)
 static int broadwell_rtd_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
@@ -149,6 +150,7 @@ static int broadwell_rtd_init(struct snd_soc_pcm_runtime *rtd)
 
 	return 0;
 }
+#endif
 
 /* broadwell digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link broadwell_rt286_dais[] = {
@@ -161,7 +163,9 @@ static struct snd_soc_dai_link broadwell_rt286_dais[] = {
 		.dynamic = 1,
 		.codec_name = "snd-soc-dummy",
 		.codec_dai_name = "snd-soc-dummy-dai",
+#if !IS_ENABLED(CONFIG_SND_SOC_SOF_BROADWELL)
 		.init = broadwell_rtd_init,
+#endif
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
-- 
2.20.1
