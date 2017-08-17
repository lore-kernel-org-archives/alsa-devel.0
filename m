From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: kbl_rt5663_rt5514_max98927: Add
	rt5514 spi dailink" to the asoc tree
Date: Thu, 17 Aug 2017 18:13:49 +0100
Message-ID: <E1diOMf-0000Ck-4Q@debutante>
References: <1502822380-24047-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 339C62670FB
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 19:13:55 +0200 (CEST)
In-Reply-To: <1502822380-24047-1-git-send-email-harshapriya.n@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Hsin-yu Chao <hychao@google.com>, Harsha Priya <harshapriya.n@intel.com>, tiwai@suse.de, broonie@kernel.org, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: kbl_rt5663_rt5514_max98927: Add rt5514 spi dailink

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

>From 393a829bb2f7e12403cb7ff3b62539c27a543a2c Mon Sep 17 00:00:00 2001
From: Harsha Priya N <harshapriya.n@intel.com>
Date: Wed, 16 Aug 2017 15:37:11 -0700
Subject: [PATCH] ASoC: Intel: kbl_rt5663_rt5514_max98927: Add rt5514 spi
 dailink

This patch adds a dai to rt5514-spi driver for wake on voice functionality.

Signed-off-by: Hsin-yu Chao <hychao@google.com>
Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/Kconfig                             | 3 ++-
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index b301bfff1c09..b3c7f554ec30 100644
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
index 5ec942885b69..b51dff6fe25b 100644
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
@@ -480,6 +481,14 @@ static struct snd_soc_dai_link kabylake_dais[] = {
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
2.13.3
