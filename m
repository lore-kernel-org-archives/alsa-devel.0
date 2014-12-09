From: weiyj_lk@163.com
Subject: [PATCH -next] ASoC: Intel: fix sparse non static
	symbol warnings
Date: Tue,  9 Dec 2014 09:10:44 +0800
Message-ID: <1418087444-14504-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
 by alsa0.perex.cz (Postfix) with ESMTP id A7D9A26057E
 for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2014 02:10:48 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, kbuild test robot <fengguang.wu@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fixes the following sparse warnings:

sound/soc/intel/sst/sst_acpi.c:248:5: warning:
 symbol 'sst_acpi_probe' was not declared. Should it be static?
sound/soc/intel/sst/sst_acpi.c:335:5: warning:
 symbol 'sst_acpi_remove' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/intel/sst/sst_acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/sst/sst_acpi.c b/sound/soc/intel/sst/sst_acpi.c
index 31124aa..98a8f66 100644
--- a/sound/soc/intel/sst/sst_acpi.c
+++ b/sound/soc/intel/sst/sst_acpi.c
@@ -245,7 +245,7 @@ static struct sst_machines *sst_acpi_find_machine(
 	return NULL;
 }
 
-int sst_acpi_probe(struct platform_device *pdev)
+static int sst_acpi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	int ret = 0;
@@ -332,7 +332,7 @@ do_sst_cleanup:
 * This function is called by OS when a device is unloaded
 * This frees the interrupt etc
 */
-int sst_acpi_remove(struct platform_device *pdev)
+static int sst_acpi_remove(struct platform_device *pdev)
 {
 	struct intel_sst_drv *ctx;
 
