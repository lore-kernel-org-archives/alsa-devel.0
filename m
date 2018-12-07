From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/6] ASoC: Intel: Skylake: Harden DSP detection
	with PCI class/subclass info
Date: Fri,  7 Dec 2018 17:50:04 -0600
Message-ID: <20181207235008.22988-3-pierre-louis.bossart@linux.intel.com>
References: <20181207235008.22988-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 91732267D2D
 for <alsa-devel@alsa-project.org>; Sat,  8 Dec 2018 00:51:04 +0100 (CET)
In-Reply-To: <20181207235008.22988-1-pierre-louis.bossart@linux.intel.com>
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
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Filip Kaczmarski <filip.kaczmarski@intel.com>, tiwai@suse.de, Chris Chiu <chiu@endlessm.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Daniel Drake <drake@endlessm.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Michal Wasko <michal.wasko@intel.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>
List-Id: alsa-devel@alsa-project.org

The existing PPCAP and GCAP fields cannot be used reliably to
determine if the DSP is enabled by the BIOS. Instead rely on the
class/subclass information to find out if this driver can run or
not. The values in the code don't seem to be documented in publicly
available documents but are part of recommendations made to BIOS
writers and have been verified to be accurate on a number of
platforms.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/skylake/skl.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index df36b8fe6d5e..41a084b3d48f 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -916,6 +916,21 @@ static int skl_first_init(struct hdac_bus *bus)
 	unsigned short gcap;
 	int cp_streams, pb_streams, start_idx;
 
+	/*
+	 * detect DSP by checking class/subclass/prog-id information
+	 * class=04 subclass 03 prog-if 00: no DSP, legacy driver needs to be used
+	 * class=04 subclass 01 prog-if 00: DSP is present (and may be required e.g. for DMIC or SSP support)
+	 * class=04 subclass 03 prog-if 80: either of DSP or legacy mode can be used
+	 */
+	if (pci->class == 0x040300) {
+		dev_err(bus->dev, "The DSP is not enabled on this platform, aborting probe\n");
+		return -ENODEV;
+	} else if (pci->class != 0x040100 && pci->class != 0x040380) {
+		dev_err(bus->dev, "Unknown PCI class/subclass/prog-if information (0x%06x) found, aborting probe\n", pci->class);
+		return -ENODEV;
+	}
+	dev_info(bus->dev, "DSP detected with PCI class/subclass/prog-if info 0x%06x\n", pci->class);
+
 	err = pci_request_regions(pci, "Skylake HD audio");
 	if (err < 0)
 		return err;
-- 
2.17.1
