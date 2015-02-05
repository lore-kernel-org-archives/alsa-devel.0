From: Kevin Strasser <kevin.strasser@linux.intel.com>
Subject: [PATCH v2] ASoC: Intel: fix sst firmware path for cht-bsw-rt5672
Date: Thu,  5 Feb 2015 12:12:07 -0800
Message-ID: <1423167127-16029-1-git-send-email-kevin.strasser@linux.intel.com>
References: <1423078507-30032-1-git-send-email-kevin.strasser@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423078507-30032-1-git-send-email-kevin.strasser@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, linux-kernel@vger.kernel.org, Yang Fang <yang.a.fang@intel.com>
List-Id: alsa-devel@alsa-project.org

All sst firmware is provided under the intel directory of the linux-firmware
tree. By default this directory structure is kept when installing on a target
system. Change the path to expect a default linux-firmware installation.

Signed-off-by: Kevin Strasser <kevin.strasser@linux.intel.com>
---
 sound/soc/intel/sst/sst_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/sst/sst_acpi.c b/sound/soc/intel/sst/sst_acpi.c
index 2ac72eb..b336013 100644
--- a/sound/soc/intel/sst/sst_acpi.c
+++ b/sound/soc/intel/sst/sst_acpi.c
@@ -350,7 +350,7 @@ static struct sst_machines sst_acpi_bytcr[] = {
 
 /* Cherryview-based platforms: CherryTrail and Braswell */
 static struct sst_machines sst_acpi_chv[] = {
-	{"10EC5670", "cht-bsw", "cht-bsw-rt5672", NULL, "fw_sst_22a8.bin",
+	{"10EC5670", "cht-bsw", "cht-bsw-rt5672", NULL, "intel/fw_sst_22a8.bin",
 						&chv_platform_data },
 	{},
 };
-- 
1.9.1
