From: Harsha Priya <harshapriya.n@intel.com>
Subject: [PATCH] ASoC: Intel: kbl_rt5663_rt5514_max98927: Add
	rt5514 spi dailink
Date: Mon,  7 Aug 2017 18:33:17 -0700
Message-ID: <1502155997-31404-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 3829A26737C
 for <alsa-devel@alsa-project.org>; Tue,  8 Aug 2017 03:33:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, vinod.koul@intel.com, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: Harsha Priya <harshapriya.n@intel.com>, Hsin-yu Chao <hychao@google.com>
List-Id: alsa-devel@alsa-project.org

This patch adds a dai to rt5514-spi driver for wake on voice functionality.

Signed-off-by: Hsin-yu Chao <hychao@google.com>
Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
---
 sound/soc/intel/Kconfig                             | 1 +
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index b301bff..e3ca40d 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -260,6 +260,7 @@ config SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH
         select SND_SOC_INTEL_SKYLAKE
         select SND_SOC_RT5663
         select SND_SOC_RT5514
+        select SND_SOC_RT5514_SPI
         select SND_SOC_MAX98927
         select SND_SOC_HDAC_HDMI
         help
diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 5ec9428..b51dff6 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -65,6 +65,7 @@ enum {
 	KBL_DPCM_AUDIO_HS_PB,
 	KBL_DPCM_AUDIO_ECHO_REF_CP,
 	KBL_DPCM_AUDIO_DMIC_CP,
+	KBL_DPCM_AUDIO_RT5514_DSP,
 	KBL_DPCM_AUDIO_HDMI1_PB,
 	KBL_DPCM_AUDIO_HDMI2_PB,
 };
@@ -480,6 +481,14 @@ static int kabylake_dmic_startup(struct snd_pcm_substream *substream)
 		.capture_only = 1,
 		.nonatomic = 1,
 	},
+	[KBL_DPCM_AUDIO_RT5514_DSP] = {
+		.name = "rt5514 dsp",
+		.stream_name = "Wake on Voice",
+		.cpu_dai_name = "spi-PRP0001:00",
+		.platform_name = "spi-PRP0001:00",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+	},
 	[KBL_DPCM_AUDIO_DMIC_CP] = {
 		.name = "Kbl Audio DMIC cap",
 		.stream_name = "dmiccap",
-- 
1.9.1
