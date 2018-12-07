From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/6] ASoC: Intel: Skylake: Add CFL-S support
Date: Fri,  7 Dec 2018 17:50:03 -0600
Message-ID: <20181207235008.22988-2-pierre-louis.bossart@linux.intel.com>
References: <20181207235008.22988-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A07E267D2C
 for <alsa-devel@alsa-project.org>; Sat,  8 Dec 2018 00:51:03 +0100 (CET)
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

From: Takashi Iwai <tiwai@suse.de>

It's with CNP, supposed to be equivalent with CNL entry.

Keep the existing declaration style for now, at a later point we may
transition and use PCI_DEVICE_DATA().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 8 ++++++++
 sound/soc/intel/skylake/skl.c          | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 8bfb8b0fa3d5..b0e6fb93eaf8 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -247,6 +247,14 @@ static const struct skl_dsp_ops dsp_ops[] = {
 		.init_fw = cnl_sst_init_fw,
 		.cleanup = cnl_sst_dsp_cleanup
 	},
+	{
+		.id = 0xa348,
+		.num_cores = 4,
+		.loader_ops = bxt_get_loader_ops,
+		.init = cnl_sst_dsp_init,
+		.init_fw = cnl_sst_init_fw,
+		.cleanup = cnl_sst_dsp_cleanup
+	},
 };
 
 const struct skl_dsp_ops *skl_get_dsp_ops(int pci_id)
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 3f0ac1312982..df36b8fe6d5e 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -1121,6 +1121,9 @@ static const struct pci_device_id skl_ids[] = {
 	/* CNL */
 	{ PCI_DEVICE(0x8086, 0x9dc8),
 		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
+	/* CFL */
+	{ PCI_DEVICE(0x8086, 0xa348),
+		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, skl_ids);
-- 
2.17.1
