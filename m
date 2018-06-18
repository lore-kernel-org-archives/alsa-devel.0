From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 6/8] ASoC: Intel: common: add Geminilake
	Realtek+Maxim machine driver entry
Date: Mon, 18 Jun 2018 13:29:40 -0500
Message-ID: <20180618182942.4925-7-pierre-louis.bossart@linux.intel.com>
References: <20180618182942.4925-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A630266F88
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Naveen Manohar <naveen.m@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Naveen Manohar <naveen.m@intel.com>

This patch adds glk_rt5682_max98357a_i2s machine driver entry into
machine table. Both Skylake and SOF platform drivers can use this
machine drivers.

Signed-off-by: Naveen Manohar <naveen.m@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/common/soc-acpi-intel-glk-match.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-glk-match.c b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
index 305875af71ca..f7c7cb75d607 100644
--- a/sound/soc/intel/common/soc-acpi-intel-glk-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
@@ -33,6 +33,16 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_glk_machines[] = {
 		.sof_tplg_filename = "intel/sof-glk-da7219.tplg",
 		.asoc_plat_name = "0000:00:0e.0",
 	},
+	{
+		.id = "10EC5682",
+		.drv_name = "glk_rt5682_max98357a",
+		.fw_filename = "intel/dsp_fw_glk.bin",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &glk_codecs,
+		.sof_fw_filename = "intel/sof-glk.ri",
+		.sof_tplg_filename = "intel/sof-glk-rt5682.tplg",
+		.asoc_plat_name = "0000:00:0e.0",
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_glk_machines);
-- 
2.14.1
