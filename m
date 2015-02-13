From: mengdong.lin@intel.com
Subject: [PATCH] ASoC: Intel: set initial runtime PM status to
	active for ACPI-enumerated ADSP
Date: Fri, 13 Feb 2015 19:21:25 +0800
Message-ID: <4c86d19eb8db54ac57244ee77e873d5bc22c1b21.1423826462.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E52AC26063A
 for <alsa-devel@alsa-project.org>; Fri, 13 Feb 2015 12:12:36 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

The ADSP on Braswell/Baytrail is an ACPI device. This patch sets its initial
runtime PM status to active. Otherwise, its initial status is suspended and
runtime_suspend ops will not be called after probe and thus cannot further
trigger ACPI _PS3 (D3) method to put the device into low power D3cold state.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/soc/intel/sst/sst.c b/sound/soc/intel/sst/sst.c
index 8a8d56a..d6ea800 100644
--- a/sound/soc/intel/sst/sst.c
+++ b/sound/soc/intel/sst/sst.c
@@ -379,6 +379,10 @@ void sst_configure_runtime_pm(struct intel_sst_drv *ctx)
 	 * initially active. So change the state to active before
 	 * enabling the pm
 	 */
+
+	if (!acpi_disabled)
+		pm_runtime_set_active(ctx->dev);
+
 	pm_runtime_enable(ctx->dev);
 
 	if (acpi_disabled)
-- 
1.9.1
