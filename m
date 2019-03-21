From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 19/20] ASoC: Intel: Make sure HSW/BDW based
	machine drivers build for SOF
Date: Thu, 21 Mar 2019 11:10:54 -0500
Message-ID: <20190321161055.26582-20-pierre-louis.bossart@linux.intel.com>
References: <20190321161055.26582-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190321161055.26582-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Daniel Baluta <daniel.baluta@gmail.com>, Alan Cox <alan@linux.intel.com>, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, andriy.shevchenko@linux.intel.com, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

HSW/BDW use hard coded IPC calls to set SSP, not needed in SOF as SSP is
configured via topology.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bdw-rt5677.c | 4 ++++
 sound/soc/intel/boards/broadwell.c  | 4 ++++
 sound/soc/intel/boards/haswell.c    | 4 ++++
 3 files changed, 12 insertions(+)

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
diff --git a/sound/soc/intel/boards/haswell.c b/sound/soc/intel/boards/haswell.c
index 971226d42042..93eb691c9d49 100644
--- a/sound/soc/intel/boards/haswell.c
+++ b/sound/soc/intel/boards/haswell.c
@@ -86,6 +86,7 @@ static const struct snd_soc_ops haswell_rt5640_ops = {
 	.hw_params = haswell_rt5640_hw_params,
 };
 
+#if !IS_ENABLED(CONFIG_SND_SOC_SOF_HASWELL)
 static int haswell_rtd_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
@@ -104,6 +105,7 @@ static int haswell_rtd_init(struct snd_soc_pcm_runtime *rtd)
 
 	return 0;
 }
+#endif
 
 static struct snd_soc_dai_link haswell_rt5640_dais[] = {
 	/* Front End DAI links */
@@ -115,7 +117,9 @@ static struct snd_soc_dai_link haswell_rt5640_dais[] = {
 		.dynamic = 1,
 		.codec_name = "snd-soc-dummy",
 		.codec_dai_name = "snd-soc-dummy-dai",
+#if !IS_ENABLED(CONFIG_SND_SOC_SOF_HASWELL)
 		.init = haswell_rtd_init,
+#endif
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
-- 
2.17.1
