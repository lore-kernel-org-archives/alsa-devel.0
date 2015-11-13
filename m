From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 8/9] ASoC: Intel: Skylake: Constrain the
	audio devices
Date: Fri, 13 Nov 2015 19:22:12 +0530
Message-ID: <1447422733-2484-9-git-send-email-vinod.koul@intel.com>
References: <1447422733-2484-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id AF520265DCD
 for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2015 14:49:03 +0100 (CET)
In-Reply-To: <1447422733-2484-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

In ref configuration for Skylake, we support only 16bit, 48KHz,
stereo audio, so specify these as constrains for the devices

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/skl_rt286.c | 49 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index e6af48491229..9c67e05a24b3 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -104,6 +104,53 @@ static int skylake_rt286_codec_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
+static unsigned int rates[] = {
+	48000,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_rates = {
+	.count = ARRAY_SIZE(rates),
+	.list  = rates,
+	.mask = 0,
+};
+
+static unsigned int channels[] = {
+	2,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_channels = {
+	.count = ARRAY_SIZE(channels),
+	.list = channels,
+	.mask = 0,
+};
+
+static int skl_fe_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	/*
+	 * on this platform for PCM device we support,
+	 *	48Khz
+	 *	stereo
+	 *	16 bit audio
+	 */
+
+	runtime->hw.channels_max = 2;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+					   &constraints_channels);
+
+	runtime->hw.formats = SNDRV_PCM_FMTBIT_S16_LE;
+	snd_pcm_hw_constraint_msbits(runtime, 0, 16, 16);
+
+	snd_pcm_hw_constraint_list(runtime, 0,
+				SNDRV_PCM_HW_PARAM_RATE, &constraints_rates);
+
+	return 0;
+}
+
+static const struct snd_soc_ops skylake_rt286_fe_ops = {
+	.startup = skl_fe_startup,
+};
 
 static int skylake_ssp0_fixup(struct snd_soc_pcm_runtime *rtd,
 			struct snd_pcm_hw_params *params)
@@ -160,6 +207,7 @@ static struct snd_soc_dai_link skylake_rt286_dais[] = {
 			SND_SOC_DPCM_TRIGGER_POST
 		},
 		.dpcm_playback = 1,
+		.ops = &skylake_rt286_fe_ops,
 	},
 	{
 		.name = "Skl Audio Capture Port",
@@ -175,6 +223,7 @@ static struct snd_soc_dai_link skylake_rt286_dais[] = {
 			SND_SOC_DPCM_TRIGGER_POST
 		},
 		.dpcm_capture = 1,
+		.ops = &skylake_rt286_fe_ops,
 	},
 	{
 		.name = "Skl Audio Reference cap",
-- 
1.9.1
