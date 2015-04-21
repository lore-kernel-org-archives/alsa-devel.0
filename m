From: yang.a.fang@intel.com
Subject: [PATCH 2/2] ASoC: Intel: Add support rt5650 in sst
	driver
Date: Tue, 21 Apr 2015 16:36:00 -0700
Message-ID: <1429659360-99360-2-git-send-email-yang.a.fang@intel.com>
References: <1429659360-99360-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C73126507F
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2015 01:36:41 +0200 (CEST)
In-Reply-To: <1429659360-99360-1-git-send-email-yang.a.fang@intel.com>
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
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, praveen.k.jain@intel.com, denny.iriawan@intel.com, "Fang, Yang A" <yang.a.fang@intel.com>, sathyanarayana.nujella@intel.com, kevin.strasser@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

Added entry in sst driver to support rt5650 codec
for intel Braswell platform.

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
---
 sound/soc/intel/atom/sst/sst_acpi.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 678f36e..4476620 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -354,6 +354,8 @@ static struct sst_machines sst_acpi_chv[] = {
 						&chv_platform_data },
 	{"10EC5645", "cht-bsw", "cht-bsw-rt5645", NULL, "intel/fw_sst_22a8.bin",
 						&chv_platform_data },
+	{"10EC5650", "cht-bsw", "cht-bsw-rt5645", NULL, "intel/fw_sst_22a8.bin",
+						&chv_platform_data },
 	{},
 };
 
-- 
1.7.9.5
