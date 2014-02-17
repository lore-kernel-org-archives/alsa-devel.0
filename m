From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCHv2 5/5] ASoC: Intel: Add build support for Intel
	SST DSP core.
Date: Mon, 17 Feb 2014 13:32:10 +0000
Message-ID: <1392643930-6030-5-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1392643930-6030-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D4BF262631
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2014 14:32:38 +0100 (CET)
In-Reply-To: <1392643930-6030-1-git-send-email-liam.r.girdwood@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Benson Leung <bleung@google.com>, Jarkko Nikula <jarkko.nikula@intel.com>
List-Id: alsa-devel@alsa-project.org

This adds kernel build support for Intel SST core audio.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/Kconfig  | 12 ++++++++++++
 sound/soc/intel/Makefile |  7 +++++++
 2 files changed, 19 insertions(+)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 4d9d0a5..b0a07e4 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -11,3 +11,15 @@ config SND_MFLD_MACHINE
 
 config SND_SST_MFLD_PLATFORM
 	tristate
+
+config SND_SOC_INTEL_SST
+	tristate "ASoC support for Intel(R) Smart Sound Technology"
+	select SND_SOC_INTEL_SST_ACPI if ACPI
+	help
+          This adds support for Intel(R) Smart Sound Technology (SST).
+          Say Y if you have such a device
+          If unsure select "N".
+
+config SND_SOC_INTEL_SST_ACPI
+	tristate
+
diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index eb899fc..cf47100 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -1,5 +1,12 @@
+# Core support
+snd-soc-sst-dsp-objs := sst-dsp.o sst-firmware.o
+snd-soc-sst-acpi-objs := sst-acpi.o
+
 snd-soc-sst-mfld-platform-objs := sst-mfld-platform.o
 snd-soc-mfld-machine-objs := mfld_machine.o
 
 obj-$(CONFIG_SND_SST_MFLD_PLATFORM) += snd-soc-sst-mfld-platform.o
 obj-$(CONFIG_SND_MFLD_MACHINE) += snd-soc-mfld-machine.o
+
+obj-$(CONFIG_SND_SOC_INTEL_SST) += snd-soc-sst-dsp.o
+obj-$(CONFIG_SND_SOC_INTEL_SST_ACPI) += snd-soc-sst-acpi.o
-- 
1.8.3.2
