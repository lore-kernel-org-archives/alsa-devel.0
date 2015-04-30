From: yang.a.fang@intel.com
Subject: [PATCH 1/4] ASoC: Intel: Add support max98090 in sst
	driver
Date: Wed, 29 Apr 2015 18:43:55 -0700
Message-ID: <1430358238-74659-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 378902607F7
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 03:44:38 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, praveen.k.jain@intel.com, praveen.diwakar@intel.com, denny.iriawan@intel.com, "Fang,
 Yang A" <yang.a.fang@intel.com>, kevin.strasser@linux.intel.com, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

Added entry in sst driver to support max98090 codec
for intel Braswell platform.

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
---
 sound/soc/intel/atom/sst/sst_acpi.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index fc02a48..bb19b58 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -356,6 +356,8 @@ static struct sst_machines sst_acpi_chv[] = {
 						&chv_platform_data },
 	{"10EC5650", "cht-bsw", "cht-bsw-rt5645", NULL, "intel/fw_sst_22a8.bin",
 						&chv_platform_data },
+	{"193C9890", "cht-bsw", "cht-bsw-max98090", NULL,
+	"intel/fw_sst_22a8.bin", &chv_platform_data },
 	{},
 };
 
-- 
1.7.9.5
