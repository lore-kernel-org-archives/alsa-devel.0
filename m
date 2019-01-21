From: Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 4/7] ALSA: hda/tegra: remove redundant clock
	enable API
Date: Mon, 21 Jan 2019 23:11:34 +0530
Message-ID: <1548092497-5459-5-git-send-email-spujar@nvidia.com>
References: <1548092497-5459-1-git-send-email-spujar@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com [216.228.121.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 9070426680F
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2019 18:42:09 +0100 (CET)
In-Reply-To: <1548092497-5459-1-git-send-email-spujar@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Sameer Pujar <spujar@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Explicit clock enable is not required during probe, as this would be
managed by runtime PM calls. Clock can be enabled/disabled in runtime
resume/suspend. This way it is easier to balance clock enable/disable
counts.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Reviewed-by: Ravindra Lokhande <rlokhande@nvidia.com>
Reviewed-by: Mohan Kumar D <mkumard@nvidia.com>
---
 sound/pci/hda/hda_tegra.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index 1189f97..f068b1e 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -319,7 +319,6 @@ static int hda_tegra_init_chip(struct azx *chip, struct platform_device *pdev)
 	struct hdac_bus *bus = azx_bus(chip);
 	struct device *dev = hda->dev;
 	struct resource *res;
-	int err;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	hda->regs = devm_ioremap_resource(dev, res);
@@ -329,12 +328,6 @@ static int hda_tegra_init_chip(struct azx *chip, struct platform_device *pdev)
 	bus->remap_addr = hda->regs + HDA_BAR0;
 	bus->addr = res->start + HDA_BAR0;
 
-	err = hda_tegra_enable_clocks(hda);
-	if (err) {
-		dev_err(dev, "failed to get enable clocks\n");
-		return err;
-	}
-
 	hda_tegra_init(hda);
 
 	return 0;
-- 
2.7.4


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
