From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 5/6] ALSA / hda: stop probe if DMICS are
	detected on Skylake+ platforms
Date: Thu, 23 May 2019 18:39:50 -0500
Message-ID: <20190523233951.31122-6-pierre-louis.bossart@linux.intel.com>
References: <20190523233951.31122-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 981BEF89670
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 01:40:38 +0200 (CEST)
In-Reply-To: <20190523233951.31122-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Daniel Drake <drake@endlessm.com>, Hui Wang <hui.wang@canonical.com>, Curtis Malainey <cujomalainey@google.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The legacy HD-Audio driver cannot handle Skylake+ platforms with
digital microphones. For those platforms, the SOF driver needs to be
used.

Use the common intel-nhlt module to stop the probe when the DSP is
enabled and DMICs are exposed in the NHTL tables.

Note: This assumes that the BIOS information is correct, and
additional testing is required to see on which platforms the detection
is a false positive.

FIXME: I need to find what is the mirror of azx_create() to free all
the resources on exit.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/pci/hda/Kconfig     |  1 +
 sound/pci/hda/hda_intel.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 4235907b7858..7b560c557b07 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -11,6 +11,7 @@ config SND_HDA_INTEL
 	tristate "HD Audio PCI"
 	depends on SND_PCI
 	select SND_HDA
+	select SND_SOC_INTEL_NHLT
 	help
 	  Say Y here to include support for Intel "High Definition
 	  Audio" (Azalia) and its compatible devices.
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 0741eae23f10..e9f427d75a5d 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -66,6 +66,7 @@
 #include <sound/hda_codec.h>
 #include "hda_controller.h"
 #include "hda_intel.h"
+#include "../../soc/intel/common/intel-nhlt.h"
 
 #define CREATE_TRACE_POINTS
 #include "hda_intel_trace.h"
@@ -2038,6 +2039,25 @@ static const struct hda_controller_ops pci_hda_ops = {
 	.position_check = azx_position_check,
 };
 
+static int azx_check_dmic(struct pci_dev *pci, struct azx *chip)
+{
+	struct nhlt_acpi_table *nhlt;
+	int ret = 0;
+
+	if (chip->driver_type == AZX_DRIVER_SKL &&
+	    pci->class != 0x040300) {
+		nhlt = intel_nhlt_init(&pci->dev);
+		if (nhlt) {
+			if (intel_nhlt_get_dmic_geo(&pci->dev, nhlt)) {
+				ret = -ENODEV;
+				dev_dbg(&pci->dev, "Digital mics found on Skylake+ platform, aborting probe\n");
+			}
+			intel_nhlt_free(nhlt);
+		}
+	}
+	return ret;
+}
+
 static int azx_probe(struct pci_dev *pci,
 		     const struct pci_device_id *pci_id)
 {
@@ -2068,6 +2088,16 @@ static int azx_probe(struct pci_dev *pci,
 	card->private_data = chip;
 	hda = container_of(chip, struct hda_intel, chip);
 
+	/*
+	 * stop probe if digital microphones detected on Skylake+ platform
+	 * with the DSP enabled
+	 */
+	err = azx_check_dmic(pci, chip);
+	if (err < 0) {
+		/* FIXME: need to free everything allocated in azx_create */
+		goto out_free;
+	}
+
 	pci_set_drvdata(pci, card);
 
 	err = register_vga_switcheroo(chip);
-- 
2.20.1
