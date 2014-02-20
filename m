From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH 5/6] ASoC: Intel: Add build support for Haswell
	ADSP
Date: Thu, 20 Feb 2014 21:48:46 +0000
Message-ID: <1392932927-9725-5-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1392932927-9725-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E303C265869
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 22:49:22 +0100 (CET)
In-Reply-To: <1392932927-9725-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Build the Haswell/Broadwell PCM, IPC and DSP drivers.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/Kconfig  | 2 ++
 sound/soc/intel/Makefile | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index dd048fe..4f1ac8f 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -24,3 +24,5 @@ config SND_SOC_INTEL_SST
 config SND_SOC_INTEL_SST_ACPI
 	tristate
 
+config SND_SOC_INTEL_HASWELL
+	tristate
diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index cf47100..4c08b21 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -10,3 +10,9 @@ obj-$(CONFIG_SND_MFLD_MACHINE) += snd-soc-mfld-machine.o
 
 obj-$(CONFIG_SND_SOC_INTEL_SST) += snd-soc-sst-dsp.o
 obj-$(CONFIG_SND_SOC_INTEL_SST_ACPI) += snd-soc-sst-acpi.o
+
+# Platform Support
+snd-soc-sst-haswell-pcm-objs := \
+	sst-haswell-ipc.o sst-haswell-pcm.o sst-haswell-dsp.o
+
+obj-$(CONFIG_SND_SOC_INTEL_HASWELL) += snd-soc-sst-haswell-pcm.o
-- 
1.8.3.2
