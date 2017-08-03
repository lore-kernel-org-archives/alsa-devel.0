From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: kbl: Add DAI links for
	Multi-Playback & Echo-reference" to the asoc tree
Date: Thu, 03 Aug 2017 17:30:33 +0100
Message-ID: <E1ddJ17-0002bs-3V@debutante>
References: <1501654415-24590-3-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8728C267412
 for <alsa-devel@alsa-project.org>; Thu,  3 Aug 2017 18:30:42 +0200 (CEST)
In-Reply-To: <1501654415-24590-3-git-send-email-naveen.m@intel.com>
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

   ASoC: Intel: kbl: Add DAI links for Multi-Playback & Echo-reference

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

>From b32ee384ac18d3e4db0ef45d23c3ff1c67113529 Mon Sep 17 00:00:00 2001
From: Naveen Manohar <naveen.m@intel.com>
Date: Wed, 2 Aug 2017 11:43:34 +0530
Subject: [PATCH] ASoC: Intel: kbl: Add DAI links for Multi-Playback &
 Echo-reference

Add new FE DAI links to support:
1. Parallel playback on 2 ports simultaneously
2. Echo reference capture capability

Signed-off-by: Naveen M <naveen.m@intel.com>
Signed-off-by: Sathya Prakash M R <sathya.prakash.m.r@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/kbl_rt5663_max98927.c       | 24 ++++++++++++++++++++++
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  | 24 ++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index 090331bd6900..4c70d5a3028c 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -52,6 +52,8 @@ struct kbl_rt5663_private {
 enum {
 	KBL_DPCM_AUDIO_PB = 0,
 	KBL_DPCM_AUDIO_CP,
+	KBL_DPCM_AUDIO_HS_PB,
+	KBL_DPCM_AUDIO_ECHO_REF_CP,
 	KBL_DPCM_AUDIO_REF_CP,
 	KBL_DPCM_AUDIO_DMIC_CP,
 	KBL_DPCM_AUDIO_HDMI1_PB,
@@ -485,6 +487,28 @@ static struct snd_soc_dai_link kabylake_dais[] = {
 		.dpcm_capture = 1,
 		.ops = &kabylake_rt5663_fe_ops,
 	},
+	[KBL_DPCM_AUDIO_HS_PB] = {
+		.name = "Kbl Audio Headset Playback",
+		.stream_name = "Headset Audio",
+		.cpu_dai_name = "System Pin2",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "0000:00:1f.3",
+		.dpcm_playback = 1,
+		.nonatomic = 1,
+		.dynamic = 1,
+	},
+	[KBL_DPCM_AUDIO_ECHO_REF_CP] = {
+		.name = "Kbl Audio Echo Reference cap",
+		.stream_name = "Echoreference Capture",
+		.cpu_dai_name = "Echoref Pin",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "0000:00:1f.3",
+		.init = NULL,
+		.capture_only = 1,
+		.nonatomic = 1,
+	},
 	[KBL_DPCM_AUDIO_REF_CP] = {
 		.name = "Kbl Audio Reference cap",
 		.stream_name = "Wake on Voice",
diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 74bbc008c965..64364de165be 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -62,6 +62,8 @@ struct kbl_codec_private {
 enum {
 	KBL_DPCM_AUDIO_PB = 0,
 	KBL_DPCM_AUDIO_CP,
+	KBL_DPCM_AUDIO_HS_PB,
+	KBL_DPCM_AUDIO_ECHO_REF_CP,
 	KBL_DPCM_AUDIO_DMIC_CP,
 	KBL_DPCM_AUDIO_HDMI1_PB,
 	KBL_DPCM_AUDIO_HDMI2_PB,
@@ -456,6 +458,28 @@ static struct snd_soc_dai_link kabylake_dais[] = {
 		.dpcm_capture = 1,
 		.ops = &kabylake_rt5663_fe_ops,
 	},
+	[KBL_DPCM_AUDIO_HS_PB] = {
+		.name = "Kbl Audio Headset Playback",
+		.stream_name = "Headset Audio",
+		.cpu_dai_name = "System Pin2",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "0000:00:1f.3",
+		.dpcm_playback = 1,
+		.nonatomic = 1,
+		.dynamic = 1,
+	},
+	[KBL_DPCM_AUDIO_ECHO_REF_CP] = {
+		.name = "Kbl Audio Echo Reference cap",
+		.stream_name = "Echoreference Capture",
+		.cpu_dai_name = "Echoref Pin",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "0000:00:1f.3",
+		.init = NULL,
+		.capture_only = 1,
+		.nonatomic = 1,
+	},
 	[KBL_DPCM_AUDIO_DMIC_CP] = {
 		.name = "Kbl Audio DMIC cap",
 		.stream_name = "dmiccap",
-- 
2.13.2
