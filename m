From: Yong Zhi <yong.zhi@intel.com>
Subject: [PATCH v2] ASoC: Intel: common: add Geminilake
	Realtek+Maxim machine driver entry
Date: Wed, 10 Apr 2019 12:27:31 -0500
Message-ID: <1554917251-16772-1-git-send-email-yong.zhi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4EC87F8068A
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2019 19:27:46 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
Cc: harshapriya.n@intel.com, liam.r.girdwood@linux.intel.com, tiwai@suse.de, vkoul@kernel.org, broonie@kernel.org, Naveen Manohar <naveen.m@intel.com>, Yong Zhi <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

This patch adds glk_rt5682_max98357a_i2s machine driver entry into
machine table. Both Skylake and SOF platform drivers can use this
machine drivers.

Signed-off-by: Yong Zhi <yong.zhi@intel.com>
Signed-off-by: Naveen Manohar <naveen.m@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
Hi, Pierre,

This is an update to https://patchwork.kernel.org/patch/10472523/
with SOF files prefix and asoc_plat_name removed, tested with SOF v1.1, thanks!!

 sound/soc/intel/common/soc-acpi-intel-glk-match.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-glk-match.c b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
index 3f2061475ae4..616eb09e78a0 100644
--- a/sound/soc/intel/common/soc-acpi-intel-glk-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
@@ -31,6 +31,15 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_glk_machines[] = {
 		.sof_fw_filename = "sof-glk.ri",
 		.sof_tplg_filename = "sof-glk-da7219.tplg",
 	},
+	{
+		.id = "10EC5682",
+		.drv_name = "glk_rt5682_max98357a",
+		.fw_filename = "intel/dsp_fw_glk.bin",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &glk_codecs,
+		.sof_fw_filename = "sof-glk.ri",
+		.sof_tplg_filename = "sof-glk-rt5682.tplg",
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_glk_machines);
-- 
2.7.4
