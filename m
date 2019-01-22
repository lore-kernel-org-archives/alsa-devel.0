From: Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2 2/6] ALSA: hda/tegra: get clock handles
	early in probe
Date: Tue, 22 Jan 2019 13:03:17 +0530
Message-ID: <1548142401-22841-3-git-send-email-spujar@nvidia.com>
References: <1548142401-22841-1-git-send-email-spujar@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com [216.228.121.65])
 by alsa0.perex.cz (Postfix) with ESMTP id EF46E2674A5
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 08:33:44 +0100 (CET)
In-Reply-To: <1548142401-22841-1-git-send-email-spujar@nvidia.com>
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

Moved devm_clk_get() API calls to a separate function and the same
can be called early in the probe. This is done before runtime PM
for the device is enabled. The runtime resume/suspend callbacks can
later enable/disable clocks respectively(the support would be added
in subsequent patches). Clock handles should be available by the
time runtime suspend/resume calls can happen.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Reviewed-by: Ravindra Lokhande <rlokhande@nvidia.com>
Reviewed-by: Mohan Kumar D <mkumard@nvidia.com>
---
 sound/pci/hda/hda_tegra.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index 2f9dd23..28e1656 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -306,22 +306,6 @@ static int hda_tegra_init_chip(struct azx *chip, struct platform_device *pdev)
 	struct resource *res;
 	int err;
 
-	hda->hda_clk = devm_clk_get(dev, "hda");
-	if (IS_ERR(hda->hda_clk)) {
-		dev_err(dev, "failed to get hda clock\n");
-		return PTR_ERR(hda->hda_clk);
-	}
-	hda->hda2codec_2x_clk = devm_clk_get(dev, "hda2codec_2x");
-	if (IS_ERR(hda->hda2codec_2x_clk)) {
-		dev_err(dev, "failed to get hda2codec_2x clock\n");
-		return PTR_ERR(hda->hda2codec_2x_clk);
-	}
-	hda->hda2hdmi_clk = devm_clk_get(dev, "hda2hdmi");
-	if (IS_ERR(hda->hda2hdmi_clk)) {
-		dev_err(dev, "failed to get hda2hdmi clock\n");
-		return PTR_ERR(hda->hda2hdmi_clk);
-	}
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	hda->regs = devm_ioremap_resource(dev, res);
 	if (IS_ERR(hda->regs))
@@ -341,6 +325,29 @@ static int hda_tegra_init_chip(struct azx *chip, struct platform_device *pdev)
 	return 0;
 }
 
+static int hda_tegra_init_clk(struct hda_tegra *hda)
+{
+	struct device *dev = hda->dev;
+
+	hda->hda_clk = devm_clk_get(dev, "hda");
+	if (IS_ERR(hda->hda_clk)) {
+		dev_err(dev, "failed to get hda clock\n");
+		return PTR_ERR(hda->hda_clk);
+	}
+	hda->hda2codec_2x_clk = devm_clk_get(dev, "hda2codec_2x");
+	if (IS_ERR(hda->hda2codec_2x_clk)) {
+		dev_err(dev, "failed to get hda2codec_2x clock\n");
+		return PTR_ERR(hda->hda2codec_2x_clk);
+	}
+	hda->hda2hdmi_clk = devm_clk_get(dev, "hda2hdmi");
+	if (IS_ERR(hda->hda2hdmi_clk)) {
+		dev_err(dev, "failed to get hda2hdmi clock\n");
+		return PTR_ERR(hda->hda2hdmi_clk);
+	}
+
+	return 0;
+}
+
 static int hda_tegra_first_init(struct azx *chip, struct platform_device *pdev)
 {
 	struct hdac_bus *bus = azx_bus(chip);
@@ -507,6 +514,10 @@ static int hda_tegra_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	err = hda_tegra_init_clk(hda);
+	if (err < 0)
+		goto out_free;
+
 	err = hda_tegra_create(card, driver_flags, hda);
 	if (err < 0)
 		goto out_free;
-- 
2.7.4


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
