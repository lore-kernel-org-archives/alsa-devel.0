From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/2] ASoC: Intel: atom: statify cht_quirk
Date: Fri,  8 Jul 2016 18:30:18 +0530
Message-ID: <1467982818-4528-2-git-send-email-vinod.koul@intel.com>
References: <1467982818-4528-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 87AA026595B
 for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2016 14:53:14 +0200 (CEST)
In-Reply-To: <1467982818-4528-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Sparse rightly warns:
sound/soc/intel/atom/sst/sst_acpi.c:353:22: warning: symbol 'cht_quirk' was not declared. Should it be static?

So statify this

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 82a374d885a7..4d3184971227 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -350,7 +350,7 @@ static struct sst_acpi_mach cht_surface_mach = {
 	"10EC5640", "cht-bsw-rt5645", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
 								&chv_platform_data };
 
-struct sst_acpi_mach *cht_quirk(void *arg)
+static struct sst_acpi_mach *cht_quirk(void *arg)
 {
 	struct sst_acpi_mach *mach = arg;
 
-- 
1.9.1
