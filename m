From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 1/2] ASoC: Intel: Fix BYTCR firmware name
Date: Mon, 22 Dec 2014 16:49:19 +0200
Message-ID: <1419259760-19066-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id EBCA62605B7
 for <alsa-devel@alsa-project.org>; Mon, 22 Dec 2014 15:49:27 +0100 (CET)
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
Cc: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

BYTCR DSP firmware is in intel/ subdirectory. See linux-firmware.git
commit d562a3b63632 ("linux-firmware: add sst audio firmware for baytrail
platforms").

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/sst/sst_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/sst/sst_acpi.c b/sound/soc/intel/sst/sst_acpi.c
index 3abc29e8a928..2ac72eb5e75d 100644
--- a/sound/soc/intel/sst/sst_acpi.c
+++ b/sound/soc/intel/sst/sst_acpi.c
@@ -343,7 +343,7 @@ int sst_acpi_remove(struct platform_device *pdev)
 }
 
 static struct sst_machines sst_acpi_bytcr[] = {
-	{"10EC5640", "T100", "bytt100_rt5640", NULL, "fw_sst_0f28.bin",
+	{"10EC5640", "T100", "bytt100_rt5640", NULL, "intel/fw_sst_0f28.bin",
 						&byt_rvp_platform_data },
 	{},
 };
-- 
2.1.3
