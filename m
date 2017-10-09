From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 3/3] ASoC: Intel: Skylake: Fix missing sentinel
	in sst_acpi_mach
Date: Mon,  9 Oct 2017 11:20:32 +0530
Message-ID: <20171009055032.12158-4-guneshwor.o.singh@intel.com>
References: <20171009055032.12158-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 64464267071
 for <alsa-devel@alsa-project.org>; Mon,  9 Oct 2017 07:50:53 +0200 (CEST)
In-Reply-To: <20171009055032.12158-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

To make it consistent, add sentinel for sst_cnl_devdata also.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/skl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 143ade31562f..4abbd90e394c 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -1011,6 +1011,7 @@ static const struct sst_acpi_mach sst_cnl_devdata[] = {
 		.fw_filename = "intel/dsp_fw_cnl.bin",
 		.pdata = &cnl_pdata,
 	},
+	{}
 };
 
 /* PCI IDs */
-- 
2.14.2
