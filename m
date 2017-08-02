From: Naveen M <naveen.m@intel.com>
Subject: [PATCH 2/3] ASoC: Intel: kbl: Add DAI links for
	Multi-Playback & Echo-reference
Date: Wed,  2 Aug 2017 11:43:34 +0530
Message-ID: <1501654415-24590-3-git-send-email-naveen.m@intel.com>
References: <1501654415-24590-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 9888E267218
 for <alsa-devel@alsa-project.org>; Wed,  2 Aug 2017 08:13:28 +0200 (CEST)
In-Reply-To: <1501654415-24590-1-git-send-email-naveen.m@intel.com>
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
Cc: vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Sathya Prakash M R <sathya.prakash.m.r@intel.com>, naveen.m@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

Add new FE DAI links to support:
1. Parallel playback on 2 ports simultaneously
2. Echo reference capture capability

Signed-off-by: Naveen M <naveen.m@intel.com>
Signed-off-by: Sathya Prakash M R <sathya.prakash.m.r@intel.com>
---
 sound/soc/intel/boards/kbl_rt5663_max98927.c       | 24 ++++++++++++++++++++++
 .../soc/intel/boards/kbl_rt5663_rt5514_max98927.c  | 24 ++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index f9ba977..795e959 100644
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
@@ -443,6 +445,28 @@ static int kabylake_refcap_startup(struct snd_pcm_substream *substream)
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
index 3fe4a08..2d98982 100644
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
@@ -449,6 +451,28 @@ static int kabylake_dmic_startup(struct snd_pcm_substream *substream)
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
1.9.1
