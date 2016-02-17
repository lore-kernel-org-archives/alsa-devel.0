From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v7 8/9] ASoC: Intel: Skylake: Add i915 enabling
	in skl probe
Date: Wed, 17 Feb 2016 21:34:06 +0530
Message-ID: <1455725047-7303-9-git-send-email-subhransu.s.prusty@intel.com>
References: <1455725047-7303-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id AC634265D2B
 for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2016 17:03:54 +0100 (CET)
In-Reply-To: <1455725047-7303-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

The SKL also supports HDMI output so in probe we need to enable
the HDMI using common i915 APIs to ensure it gets probed on the
bus

After S3 during the controller resequencing the codec domain need
to be kept ON for successful reconfiguration of Codec. Once
configured it will be turned OFF in codec driver.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/Kconfig       |  1 +
 sound/soc/intel/skylake/skl.c | 51 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 7d7c872..008baa5 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -163,6 +163,7 @@ config SND_SOC_INTEL_SKYLAKE
 	tristate
 	select SND_HDA_EXT_CORE
 	select SND_SOC_TOPOLOGY
+	select SND_HDA_I915
 	select SND_SOC_INTEL_SST
 
 config SND_SOC_INTEL_SKL_RT286_MACH
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 06f4b2c..7f4909b 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -28,6 +28,9 @@
 #include <linux/firmware.h>
 #include <sound/pcm.h>
 #include "../common/sst-acpi.h"
+#include <sound/hda_register.h>
+#include <sound/hdaudio.h>
+#include <sound/hda_i915.h>
 #include "skl.h"
 #include "skl-sst-dsp.h"
 #include "skl-sst-ipc.h"
@@ -243,6 +246,16 @@ static int skl_resume(struct device *dev)
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
 	int ret;
 
+	/* Turned OFF in HDMI codec driver after codec reconfiguration */
+	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)) {
+		ret = snd_hdac_display_power(bus, true);
+		if (ret < 0) {
+			dev_err(bus->dev,
+				"Cannot turn on display power on i915\n");
+			return ret;
+		}
+	}
+
 	/*
 	 * resume only when we are not in suspend active, otherwise need to
 	 * restore the device
@@ -481,6 +494,27 @@ static int skl_create(struct pci_dev *pci,
 	return 0;
 }
 
+static int skl_i915_init(struct hdac_bus *bus)
+{
+	int err;
+
+	/*
+	 * The HDMI codec is in GPU so we need to ensure that it is powered
+	 * up and ready for probe
+	 */
+	err = snd_hdac_i915_init(bus);
+	if (err < 0)
+		return err;
+
+	err = snd_hdac_display_power(bus, true);
+	if (err < 0) {
+		dev_err(bus->dev, "Cannot turn on display power on i915\n");
+		return err;
+	}
+
+	return err;
+}
+
 static int skl_first_init(struct hdac_ext_bus *ebus)
 {
 	struct skl *skl = ebus_to_skl(ebus);
@@ -543,6 +577,12 @@ static int skl_first_init(struct hdac_ext_bus *ebus)
 	/* initialize chip */
 	skl_init_pci(skl);
 
+	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)) {
+		err = skl_i915_init(bus);
+		if (err < 0)
+			return err;
+	}
+
 	skl_init_chip(bus, true);
 
 	/* codec detection */
@@ -613,6 +653,14 @@ static int skl_probe(struct pci_dev *pci,
 	if (err < 0)
 		goto out_unregister;
 
+	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)) {
+		err = snd_hdac_display_power(bus, false);
+		if (err < 0) {
+			dev_err(bus->dev, "Cannot turn off display power on i915\n");
+			return err;
+		}
+	}
+
 	/*configure PM */
 	pm_runtime_put_noidle(bus->dev);
 	pm_runtime_allow(bus->dev);
@@ -667,6 +715,9 @@ static void skl_remove(struct pci_dev *pci)
 	if (skl->tplg)
 		release_firmware(skl->tplg);
 
+	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI))
+		snd_hdac_i915_exit(&ebus->bus);
+
 	if (pci_dev_run_wake(pci))
 		pm_runtime_get_noresume(&pci->dev);
 	pci_dev_put(pci);
-- 
1.9.1
