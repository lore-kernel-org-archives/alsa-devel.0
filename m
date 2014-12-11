From: Kevin Strasser <kevin.strasser@intel.com>
Subject: [PATCH] ASoC: Intel: fix possible acpi enumeration panic
Date: Wed, 10 Dec 2014 23:21:57 -0800
Message-ID: <1418282517-851-1-git-send-email-kevin.strasser@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Mengdong Lin <mengdong.lin@intel.com>, Yang Fang <yang.a.fang@intel.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

A crash can occur on some platforms where adsp is enumerated but codec
is not matched. Check that the codec_id string is valid before
attempting to match.

Signed-off-by: Kevin Strasser <kevin.strasser@intel.com>
---
 sound/soc/intel/sst/sst_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/sst/sst_acpi.c b/sound/soc/intel/sst/sst_acpi.c
index 31124aa..dd72e58 100644
--- a/sound/soc/intel/sst/sst_acpi.c
+++ b/sound/soc/intel/sst/sst_acpi.c
@@ -236,7 +236,7 @@ static struct sst_machines *sst_acpi_find_machine(
 	struct sst_machines *mach;
 	bool found = false;
 
-	for (mach = machines; mach->codec_id; mach++)
+	for (mach = machines; mach->codec_id[0]; mach++)
 		if (ACPI_SUCCESS(acpi_get_devices(mach->codec_id,
 						  sst_acpi_mach_match,
 						  &found, NULL)) && found)
-- 
1.9.1
