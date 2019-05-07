From: Evan Green <evgreen@chromium.org>
Subject: [PATCH v2 1/2] ASoC: SOF: Add Comet Lake PCI IDs
Date: Tue,  7 May 2019 14:53:58 -0700
Message-ID: <20190507215359.113378-2-evgreen@chromium.org>
References: <20190507215359.113378-1-evgreen@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190507215359.113378-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Naveen M <naveen.m@intel.com>, Sathya Prakash <sathya.prakash.m.r@intel.com>, Ben Zhang <benzh@chromium.org>, Rajat Jain <rajatja@chromium.org>, Evan Green <evgreen@chromium.org>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Add support for Intel Comet Lake platforms by adding a new Kconfig
for CometLake and the appropriate PCI IDs.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

Changes in v2:
- Add CML-H ID 0x06c8 (Pierre-Louis)

 sound/soc/sof/intel/Kconfig | 32 ++++++++++++++++++++++++++++++++
 sound/soc/sof/sof-pci-dev.c |  8 ++++++++
 2 files changed, 40 insertions(+)

diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index 32ee0fabab92..b3f4463100ce 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -24,6 +24,8 @@ config SND_SOC_SOF_INTEL_PCI
 	select SND_SOC_SOF_CANNONLAKE  if SND_SOC_SOF_CANNONLAKE_SUPPORT
 	select SND_SOC_SOF_COFFEELAKE  if SND_SOC_SOF_COFFEELAKE_SUPPORT
 	select SND_SOC_SOF_ICELAKE     if SND_SOC_SOF_ICELAKE_SUPPORT
+	select SND_SOC_SOF_COMETLAKE_LP if SND_SOC_SOF_COMETLAKE_LP_SUPPORT
+	select SND_SOC_SOF_COMETLAKE_H if SND_SOC_SOF_COMETLAKE_H_SUPPORT
 	help
 	  This option is not user-selectable but automagically handled by
 	  'select' statements at a higher level
@@ -179,6 +181,36 @@ config SND_SOC_SOF_ICELAKE
 	  This option is not user-selectable but automagically handled by
 	  'select' statements at a higher level
 
+config SND_SOC_SOF_COMETLAKE_LP
+	tristate
+	select SND_SOC_SOF_CANNONLAKE
+	help
+	  This option is not user-selectable but automagically handled by
+	  'select' statements at a higher level
+
+config SND_SOC_SOF_COMETLAKE_LP_SUPPORT
+	bool "SOF support for CometLake-LP"
+	help
+	  This adds support for Sound Open Firmware for Intel(R) platforms
+	  using the Cometlake-LP processors.
+	  Say Y if you have such a device.
+	  If unsure select "N".
+
+config SND_SOC_SOF_COMETLAKE_H
+	tristate
+	select SND_SOC_SOF_CANNONLAKE
+	help
+	  This option is not user-selectable but automagically handled by
+	  'select' statements at a higher level
+
+config SND_SOC_SOF_COMETLAKE_H_SUPPORT
+	bool "SOF support for CometLake-H"
+	help
+	  This adds support for Sound Open Firmware for Intel(R) platforms
+	  using the Cometlake-H processors.
+	  Say Y if you have such a device.
+	  If unsure select "N".
+
 config SND_SOC_SOF_HDA_COMMON
 	tristate
 	select SND_SOC_SOF_INTEL_COMMON
diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index b778dffb2d25..f559a56d18ab 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -353,6 +353,14 @@ static const struct pci_device_id sof_pci_ids[] = {
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_ICELAKE)
 	{ PCI_DEVICE(0x8086, 0x34C8),
 		.driver_data = (unsigned long)&icl_desc},
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_COMETLAKE_LP)
+	{ PCI_DEVICE(0x8086, 0x02c8),
+		.driver_data = (unsigned long)&cnl_desc},
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_COMETLAKE_H)
+	{ PCI_DEVICE(0x8086, 0x06c8),
+		.driver_data = (unsigned long)&cnl_desc},
 #endif
 	{ 0, }
 };
-- 
2.20.1
