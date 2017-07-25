From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ASoC: Intel: Skylake: Fix missing sentinels in
	sst_acpi_mach
Date: Tue, 25 Jul 2017 12:08:12 +0530
Message-ID: <1500964692-20866-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 211D4266B0A
 for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2017 08:35:36 +0200 (CEST)
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

Couple of instances of sst_acpi_mach were having missing sentinels
so add them up

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 334917ee41cf..9e3f8c04dd32 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -941,6 +941,7 @@ static struct sst_acpi_mach sst_bxtp_devdata[] = {
 		.machine_quirk = sst_acpi_codec_list,
 		.quirk_data = &bxt_codecs,
 	},
+	{}
 };
 
 static struct sst_acpi_mach sst_kbl_devdata[] = {
@@ -991,6 +992,7 @@ static struct sst_acpi_mach sst_glk_devdata[] = {
 		.drv_name = "glk_alc298s_i2s",
 		.fw_filename = "intel/dsp_fw_glk.bin",
 	},
+	{}
 };
 
 /* PCI IDs */
-- 
2.7.4
