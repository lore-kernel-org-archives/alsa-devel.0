From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 4/8] ASoC: Intel: common: Add Geminilake
	Dialog+Maxim machine driver entry
Date: Mon, 18 Jun 2018 13:29:38 -0500
Message-ID: <20180618182942.4925-5-pierre-louis.bossart@linux.intel.com>
References: <20180618182942.4925-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 66AC72673C7
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 20:29:50 +0200 (CEST)
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Naveen Manohar <naveen.m@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Naveen Manohar <naveen.m@intel.com>

This patch adds da7219_max98357a machine driver entry into
machine table

Signed-off-by: Naveen Manohar <naveen.m@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/common/soc-acpi-intel-glk-match.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-glk-match.c b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
index dee09439e7cb..5902aa1d0ee3 100644
--- a/sound/soc/intel/common/soc-acpi-intel-glk-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
@@ -9,12 +9,24 @@
 #include <sound/soc-acpi.h>
 #include <sound/soc-acpi-intel-match.h>
 
+static struct snd_soc_acpi_codecs glk_codecs = {
+	.num_codecs = 1,
+	.codecs = {"MX98357A"}
+};
+
 struct snd_soc_acpi_mach snd_soc_acpi_intel_glk_machines[] = {
 	{
 		.id = "INT343A",
 		.drv_name = "glk_alc298s_i2s",
 		.fw_filename = "intel/dsp_fw_glk.bin",
 	},
+	{
+		.id = "DLGS7219",
+		.drv_name = "glk_da7219_max98357a",
+		.fw_filename = "intel/dsp_fw_glk.bin",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &glk_codecs,
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_glk_machines);
-- 
2.14.1
