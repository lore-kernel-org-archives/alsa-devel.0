From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 6/7] ASoC: Intel: common: add SOF information
	for APL RVP
Date: Wed, 31 Oct 2018 20:07:17 -0500
Message-ID: <20181101010718.2878-7-pierre-louis.bossart@linux.intel.com>
References: <20181101010718.2878-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A77C2677E8
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2018 02:07:27 +0100 (CET)
In-Reply-To: <20181101010718.2878-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com, Bard liao <bard.liao@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Bard liao <bard.liao@intel.com>

Add firmware/topology information for APL RVP

Signed-off-by: Bard liao <bard.liao@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/common/soc-acpi-intel-bxt-match.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
index f39386e540d3..2756fa4ab552 100644
--- a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
@@ -19,6 +19,9 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_bxt_machines[] = {
 		.id = "INT343A",
 		.drv_name = "bxt_alc298s_i2s",
 		.fw_filename = "intel/dsp_fw_bxtn.bin",
+		.sof_fw_filename = "intel/sof-apl.ri",
+		.sof_tplg_filename = "intel/sof-apl-rt298.tplg",
+		.asoc_plat_name = "0000:00:0e.0",
 	},
 	{
 		.id = "DLGS7219",
-- 
2.17.1
