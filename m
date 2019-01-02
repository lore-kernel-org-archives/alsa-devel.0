From: Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 1/3] ASoC: Intel: sst: Simplify is_byt_cr()
Date: Wed,  2 Jan 2019 20:39:03 +0100
Message-ID: <20190102193904.50123-1-stephan@gerhold.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [85.215.255.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 87D86267B31
 for <alsa-devel@alsa-project.org>; Wed,  2 Jan 2019 20:40:51 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, Stephan Gerhold <stephan@gerhold.net>
List-Id: alsa-devel@alsa-project.org

is_byt_cr() and its usage can be simplified by returning the bool
directly, instead of through a pointer. This works because the
return value is just treated as bytcr = false and is not used
otherwise.

This patch also removes the extra check of
IS_ENABLED(CONFIG_IOSF_MBI) in favor of checking
iosf_mbi_available() directly. The header already takes care
of returning false if the config option is not enabled.

No functional change.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
New patch in v2 to keep the necessary cleanup separate from the
next patch.

 sound/soc/intel/atom/sst/sst_acpi.c | 33 ++++++++++++-----------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 3a95ebbfc45d..9eaac450f864 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -255,18 +255,15 @@ static int is_byt(void)
 	return status;
 }
 
-static int is_byt_cr(struct device *dev, bool *bytcr)
+static bool is_byt_cr(struct device *dev)
 {
 	int status = 0;
 
-	if (IS_ENABLED(CONFIG_IOSF_MBI)) {
-		u32 bios_status;
-
-		if (!is_byt() || !iosf_mbi_available()) {
-			/* bail silently */
-			return status;
-		}
+	if (!is_byt())
+		return false;
 
+	if (iosf_mbi_available()) {
+		u32 bios_status;
 		status = iosf_mbi_read(BT_MBI_UNIT_PMC, /* 0x04 PUNIT */
 				       MBI_REG_READ, /* 0x10 */
 				       0x006, /* BIOS_CONFIG */
@@ -278,15 +275,17 @@ static int is_byt_cr(struct device *dev, bool *bytcr)
 			/* bits 26:27 mirror PMIC options */
 			bios_status = (bios_status >> 26) & 3;
 
-			if ((bios_status == 1) || (bios_status == 3))
-				*bytcr = true;
-			else
-				dev_info(dev, "BYT-CR not detected\n");
+			if (bios_status == 1 || bios_status == 3) {
+				dev_info(dev, "Detected Baytrail-CR platform\n");
+				return true;
+			}
+
+			dev_info(dev, "BYT-CR not detected\n");
 		}
 	} else {
-		dev_info(dev, "IOSF_MBI not enabled, no BYT-CR detection\n");
+		dev_info(dev, "IOSF_MBI not available, no BYT-CR detection\n");
 	}
-	return status;
+	return false;
 }
 
 
@@ -301,7 +300,6 @@ static int sst_acpi_probe(struct platform_device *pdev)
 	struct platform_device *plat_dev;
 	struct sst_platform_info *pdata;
 	unsigned int dev_id;
-	bool bytcr = false;
 
 	id = acpi_match_device(dev->driver->acpi_match_table, dev);
 	if (!id)
@@ -333,10 +331,7 @@ static int sst_acpi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	ret = is_byt_cr(dev, &bytcr);
-	if (!(ret < 0 || !bytcr)) {
-		dev_info(dev, "Detected Baytrail-CR platform\n");
-
+	if (is_byt_cr(dev)) {
 		/* override resource info */
 		byt_rvp_platform_data.res_info = &bytcr_res_info;
 	}
-- 
2.20.1
