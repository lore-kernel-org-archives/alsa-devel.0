From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 7/7] ASoC: Intel: Add build support for
	Baytrail SST
Date: Mon, 24 Feb 2014 17:27:02 +0200
Message-ID: <1393255622-31365-8-git-send-email-jarkko.nikula@linux.intel.com>
References: <1393255622-31365-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id F294C261ADC
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 16:27:28 +0100 (CET)
In-Reply-To: <1393255622-31365-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Enable build support for Baytrail SST DSP platform and byt-rt5640 machine
drivers.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/Kconfig  | 14 +++++++++++++-
 sound/soc/intel/Makefile |  5 +++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index ce5a6928e601..274af1639781 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -27,6 +27,9 @@ config SND_SOC_INTEL_SST_ACPI
 config SND_SOC_INTEL_HASWELL
 	tristate
 
+config SND_SOC_INTEL_BAYTRAIL
+	tristate
+
 config SND_SOC_INTEL_HASWELL_MACH
         tristate "ASoC Audio DSP support for Intel Haswell Lynxpoint"
         depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS
@@ -36,4 +39,13 @@ config SND_SOC_INTEL_HASWELL_MACH
           This adds support for the Lynxpoint Audio DSP on Intel(R) Haswell
 	  Ultrabook platforms.
           Say Y if you have such a device
-          If unsure select "N".
\ No newline at end of file
+          If unsure select "N".
+
+config SND_SOC_INTEL_BYT_RT5640_MACH
+	tristate "ASoC Audio driver for Intel Baytrail with RT5640 codec"
+	depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS
+	select SND_SOC_INTEL_BAYTRAIL
+	select SND_SOC_RT5640
+	help
+	  This adds audio driver for Intel Baytrail platform based boards
+	  with the RT5640 audio codec.
diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index 1c188150accb..edeb79ae3dff 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -14,10 +14,15 @@ obj-$(CONFIG_SND_SOC_INTEL_SST_ACPI) += snd-soc-sst-acpi.o
 # Platform Support
 snd-soc-sst-haswell-pcm-objs := \
 	sst-haswell-ipc.o sst-haswell-pcm.o sst-haswell-dsp.o
+snd-soc-sst-baytrail-pcm-objs := \
+	sst-baytrail-ipc.o sst-baytrail-pcm.o sst-baytrail-dsp.o
 
 obj-$(CONFIG_SND_SOC_INTEL_HASWELL) += snd-soc-sst-haswell-pcm.o
+obj-$(CONFIG_SND_SOC_INTEL_BAYTRAIL) += snd-soc-sst-baytrail-pcm.o
 
 # Machine support
 snd-soc-sst-haswell-objs := haswell.o
+snd-soc-sst-byt-rt5640-mach-objs := byt-rt5640.o
 
 obj-$(CONFIG_SND_SOC_INTEL_HASWELL_MACH) += snd-soc-sst-haswell.o
+obj-$(CONFIG_SND_SOC_INTEL_BYT_RT5640_MACH) += snd-soc-sst-byt-rt5640-mach.o
-- 
1.8.5.3
