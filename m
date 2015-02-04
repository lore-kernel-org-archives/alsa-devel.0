From: Kevin Strasser <kevin.strasser@linux.intel.com>
Subject: [PATCH] ASoC: Intel: fix sst firmware path
Date: Wed,  4 Feb 2015 11:35:07 -0800
Message-ID: <1423078507-30032-1-git-send-email-kevin.strasser@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, linux-kernel@vger.kernel.org, Yang Fang <yang.a.fang@intel.com>
List-Id: alsa-devel@alsa-project.org

All sst firmware is provided under the intel directory of the linux-firmware
tree. By default this directory structure is kept when installing on a target
system. Change the path to expect a default linux-firmware installation.

Signed-off-by: Kevin Strasser <kevin.strasser@linux.intel.com>
---
 sound/soc/intel/sst/sst_acpi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/sst/sst_acpi.c b/sound/soc/intel/sst/sst_acpi.c
index 21b22e6..378ef3c 100644
--- a/sound/soc/intel/sst/sst_acpi.c
+++ b/sound/soc/intel/sst/sst_acpi.c
@@ -343,16 +343,16 @@ static int sst_acpi_remove(struct platform_device *pdev)
 }
 
 static struct sst_machines sst_acpi_bytcr[] = {
-	{"10EC5640", "T100", "bytt100_rt5640", NULL, "fw_sst_0f28.bin",
+	{"10EC5640", "T100", "bytt100_rt5640", NULL, "intel/fw_sst_0f28.bin",
 						&byt_rvp_platform_data },
 	{},
 };
 
 /* Cherryview-based platforms: CherryTrail and Braswell */
 static struct sst_machines sst_acpi_chv[] = {
-	{"10EC5670", "cht-bsw", "cht-bsw-rt5672", NULL, "fw_sst_22a8.bin",
+	{"10EC5670", "cht-bsw", "cht-bsw-rt5672", NULL, "intel/fw_sst_22a8.bin",
 						&chv_platform_data },
-	{"10EC5645", "cht-bsw", "cht-bsw-rt5645", NULL, "fw_sst_22a8.bin",
+	{"10EC5645", "cht-bsw", "cht-bsw-rt5645", NULL, "intel/fw_sst_22a8.bin",
 						&chv_platform_data },
 	{},
 };
-- 
1.9.1
