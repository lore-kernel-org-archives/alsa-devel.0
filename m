From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/3] ASoC: Intel: mrfld: Define sst_res_info
	for acpi
Date: Fri, 24 Oct 2014 13:49:48 +0530
Message-ID: <1414138788-4632-4-git-send-email-vinod.koul@intel.com>
References: <1414138788-4632-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E3B32604D7
 for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2014 10:59:44 +0200 (CEST)
In-Reply-To: <1414138788-4632-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Subhransu S. Prusty <subhransu.s.prusty@intel.com>

To query resources in ACPI systems we need to define a data structure. This
would be set as platform_info for the devices.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 arch/x86/include/asm/platform_sst_audio.h |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/platform_sst_audio.h b/arch/x86/include/asm/platform_sst_audio.h
index 6021dee..7249e6d 100644
--- a/arch/x86/include/asm/platform_sst_audio.h
+++ b/arch/x86/include/asm/platform_sst_audio.h
@@ -102,6 +102,27 @@ struct sst_lib_dnld_info {
 	bool mod_ddr_dnld;
 };
 
+struct sst_res_info {
+	unsigned int shim_offset;
+	unsigned int shim_size;
+	unsigned int shim_phy_addr;
+	unsigned int ssp0_offset;
+	unsigned int ssp0_size;
+	unsigned int dma0_offset;
+	unsigned int dma0_size;
+	unsigned int dma1_offset;
+	unsigned int dma1_size;
+	unsigned int iram_offset;
+	unsigned int iram_size;
+	unsigned int dram_offset;
+	unsigned int dram_size;
+	unsigned int mbox_offset;
+	unsigned int mbox_size;
+	unsigned int acpi_lpe_res_index;
+	unsigned int acpi_ddr_index;
+	unsigned int acpi_ipc_irq_index;
+};
+
 struct sst_ipc_info {
 	int ipc_offset;
 	unsigned int mbox_recv_off;
@@ -110,7 +131,9 @@ struct sst_ipc_info {
 struct sst_platform_info {
 	const struct sst_info *probe_data;
 	const struct sst_ipc_info *ipc_info;
+	const struct sst_res_info *res_info;
 	const struct sst_lib_dnld_info *lib_info;
+	const char *platform;
 };
 int add_sst_platform_device(void);
 #endif
-- 
1.7.0.4
