From: yang.a.fang@intel.com
Subject: [PATCH v2 1/2] ASoC: Intel: Add support max98090 in
	sst driver
Date: Fri,  1 May 2015 11:42:02 -0700
Message-ID: <1430505723-75442-1-git-send-email-yang.a.fang@intel.com>
References: <1430358238-74659-2-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 599DC260538
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2015 20:42:49 +0200 (CEST)
In-Reply-To: <1430358238-74659-2-git-send-email-yang.a.fang@intel.com>
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
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, vinod.koul@intel.com, praveen.k.jain@intel.com, praveen.diwakar@intel.com, denny.iriawan@intel.com, "Fang, Yang A" <yang.a.fang@intel.com>, sathyanarayana.nujella@intel.com, kevin.strasser@linux.intel.com, dgreid@chromium.org
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
