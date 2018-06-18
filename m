From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 7/8] ASoC: Intel: common: add entries for
	SOF-based machine drivers
Date: Mon, 18 Jun 2018 13:29:41 -0500
Message-ID: <20180618182942.4925-8-pierre-louis.bossart@linux.intel.com>
References: <20180618182942.4925-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CD5F2675EC
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 20:29:52 +0200 (CEST)
In-Reply-To: <20180618182942.4925-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

While we are at it, add entries for machine drivers that are used on
SOF-based platforms. The drivers will be submitted upstream after the
core SOF patches, but there's no harm in adding these references now.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/common/soc-acpi-intel-bxt-match.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
index 50869eddbb3b..f39386e540d3 100644
--- a/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-bxt-match.c
@@ -30,6 +30,27 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_bxt_machines[] = {
 		.sof_tplg_filename = "intel/sof-apl-da7219.tplg",
 		.asoc_plat_name = "0000:00:0e.0",
 	},
+	{
+		.id = "104C5122",
+		.drv_name = "bxt-pcm512x",
+		.sof_fw_filename = "intel/sof-apl.ri",
+		.sof_tplg_filename = "intel/sof-apl-pcm512x.tplg",
+		.asoc_plat_name = "0000:00:0e.0",
+	},
+	{
+		.id = "1AEC8804",
+		.drv_name = "bxt-wm8804",
+		.sof_fw_filename = "intel/sof-apl.ri",
+		.sof_tplg_filename = "intel/sof-apl-wm8804.tplg",
+		.asoc_plat_name = "0000:00:0e.0",
+	},
+	{
+		.id = "INT34C3",
+		.drv_name = "bxt_tdf8532",
+		.sof_fw_filename = "intel/sof-apl.ri",
+		.sof_tplg_filename = "intel/sof-apl-tdf8532.tplg",
+		.asoc_plat_name = "0000:00:0e.0",
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_bxt_machines);
-- 
2.14.1
