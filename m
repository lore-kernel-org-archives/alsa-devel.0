From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 4/7] ASoC: Intel: atom: use cht_bsw_max98090
	for Baytrail Chromebooks
Date: Fri,  8 Sep 2017 00:13:06 -0500
Message-ID: <20170908051309.19028-5-pierre-louis.bossart@linux.intel.com>
References: <20170908051309.19028-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 6789826751B
 for <alsa-devel@alsa-project.org>; Fri,  8 Sep 2017 07:13:30 +0200 (CEST)
In-Reply-To: <20170908051309.19028-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Baytrail Chromebooks used to be managed with legacy driver which
is not compatible with atom/sst drivers. Reuse CHT driver to
handle max98098 codec and allow distributions to support all
Atom platforms with the same build.

The legacy byt-max98090 can still be used but in a build for
Baytrail+max98090 only.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 0e928d5..ff4a517 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -536,6 +536,14 @@ static struct sst_acpi_mach sst_acpi_bytcr[] = {
 		.board = "cht-bsw",
 		.pdata = &byt_rvp_platform_data
 	},
+	/* use CHT driver to Baytrail Chromebooks */
+	{
+		.id = "193C9890",
+		.drv_name = "cht-bsw-max98090",
+		.fw_filename = "intel/fw_sst_0f28.bin",
+		.board = "cht-bsw",
+		.pdata = &byt_rvp_platform_data
+	},
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH)
 	/*
 	 * This is always last in the table so that it is selected only when
-- 
2.9.3
