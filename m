From: Harsha Priya <harshapriya.n@intel.com>
Subject: [PATCH v2] ASoC: Intel: kbl_rt5663_rt5514_max98927:
	Add rt5514 spi dailink
Date: Tue, 15 Aug 2017 11:39:40 -0700
Message-ID: <1502822380-24047-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id D022D2665D5
 for <alsa-devel@alsa-project.org>; Tue, 15 Aug 2017 20:39:49 +0200 (CEST)
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

This v2 patch adds the dependency on SPI in Kconfig

Signed-off-by: Hsin-yu Chao <hychao@google.com>
Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
---
 sound/soc/intel/Kconfig                             | 3 ++-
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index b301bff..b3c7f55 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -255,11 +255,12 @@ config SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH
 
 config SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH
         tristate "ASoC Audio driver for KBL with RT5663, RT5514 and MAX98927 in I2S Mode"
-        depends on X86_INTEL_LPSS && I2C
+        depends on X86_INTEL_LPSS && I2C && SPI
         select SND_SOC_INTEL_SST
         select SND_SOC_INTEL_SKYLAKE
         select SND_SOC_RT5663
         select SND_SOC_RT5514
+        select SND_SOC_RT5514_SPI
         select SND_SOC_MAX98927
         select SND_SOC_HDAC_HDMI
         help
diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 0fab2df..c2ef538 100644
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
@@ -473,6 +474,14 @@ static int kabylake_dmic_startup(struct snd_pcm_substream *substream)
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
