From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/3] ASoC: Intel: atom: fix 0-day warnings
Date: Tue, 16 Aug 2016 18:28:21 -0500
Message-ID: <1471390103-915-2-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1471390103-915-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BF1F26683F
 for <alsa-devel@alsa-project.org>; Wed, 17 Aug 2016 01:28:35 +0200 (CEST)
In-Reply-To: <1471390103-915-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, sfr@canb.auug.org.au, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org

spurious __initconst copy/pasted from other drivers

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/atom/sst/sst_acpi.c   | 2 +-
 sound/soc/intel/boards/bytcr_rt5640.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 0c2cc42..773acfb 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -245,7 +245,7 @@ static int is_byt_cr(struct device *dev, bool *bytcr)
 	int status = 0;
 
 	if (IS_ENABLED(CONFIG_IOSF_MBI)) {
-		static const struct x86_cpu_id cpu_ids[] __initconst = {
+		static const struct x86_cpu_id cpu_ids[] = {
 			{ X86_VENDOR_INTEL, 6, 55 }, /* Valleyview, Bay Trail */
 			{}
 		};
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 09ec3d7..2548815 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -668,7 +668,7 @@ static char byt_rt5640_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
 
 static bool is_valleyview(void)
 {
-	static const struct x86_cpu_id cpu_ids[] __initconst = {
+	static const struct x86_cpu_id cpu_ids[] = {
 		{ X86_VENDOR_INTEL, 6, 55 }, /* Valleyview, Bay Trail */
 		{}
 	};
-- 
2.7.4
