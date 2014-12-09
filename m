From: weiyj_lk@163.com
Subject: [PATCH -next] ASoC: Intel: fix return value check in
	sst_acpi_probe()
Date: Tue,  9 Dec 2014 21:14:37 +0800
Message-ID: <1418130877-28923-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
 by alsa0.perex.cz (Postfix) with ESMTP id 571B526054C
 for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2014 14:14:46 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>, kbuild test robot <fengguang.wu@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function platform_device_register_data()
returns ERR_PTR() and never returns NULL. The NULL test in the
return value check should be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/intel/sst/sst_acpi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/sst/sst_acpi.c b/sound/soc/intel/sst/sst_acpi.c
index 31124aa..f59972a 100644
--- a/sound/soc/intel/sst/sst_acpi.c
+++ b/sound/soc/intel/sst/sst_acpi.c
@@ -277,16 +277,16 @@ int sst_acpi_probe(struct platform_device *pdev)
 	dev_dbg(dev, "ACPI device id: %x\n", dev_id);
 
 	plat_dev = platform_device_register_data(dev, mach->pdata->platform, -1, NULL, 0);
-	if (plat_dev == NULL) {
+	if (IS_ERR(plat_dev)) {
 		dev_err(dev, "Failed to create machine device: %s\n", mach->pdata->platform);
-		return -ENODEV;
+		return PTR_ERR(plat_dev);
 	}
 
 	/* Create platform device for sst machine driver */
 	mdev = platform_device_register_data(dev, mach->machine, -1, NULL, 0);
-	if (mdev == NULL) {
+	if (IS_ERR(mdev)) {
 		dev_err(dev, "Failed to create machine device: %s\n", mach->machine);
-		return -ENODEV;
+		return PTR_ERR(mdev);
 	}
 
 	ret = sst_alloc_drv_context(&ctx, dev, dev_id);
