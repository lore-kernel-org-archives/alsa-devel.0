From: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: [PATCH 1/1] ASoC: dwc: Use devm_ioremap_shared_resource
Date: Fri, 16 Feb 2018 13:13:29 +0530
Message-ID: <1518767009-15232-2-git-send-email-akshu.agrawal@amd.com>
References: <1518767009-15232-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0062.outbound.protection.outlook.com [104.47.37.62])
 by alsa0.perex.cz (Postfix) with ESMTP id C7E7B26778B
 for <alsa-devel@alsa-project.org>; Fri, 16 Feb 2018 08:56:46 +0100 (CET)
In-Reply-To: <1518767009-15232-1-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, lgirdwood@gmail.com, akshu.agrawal@amd.com
List-Id: alsa-devel@alsa-project.org

In the event when resgiters are same, this patch checks shared
flag and uses devm_ioremap_shared_resource for mapping. This allows
us to have 2 separate cpu dais for playback and capture having same
register set.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/sound/designware_i2s.h |  1 +
 sound/soc/dwc/dwc-i2s.c        | 18 +++++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/sound/designware_i2s.h b/include/sound/designware_i2s.h
index 830f5ca..a43a3708 100644
--- a/include/sound/designware_i2s.h
+++ b/include/sound/designware_i2s.h
@@ -56,6 +56,7 @@ struct i2s_platform_data {
 	void *capture_dma_data;
 	bool (*filter)(struct dma_chan *chan, void *slave);
 	int (*i2s_clk_cfg)(struct i2s_clk_config_data *config);
+	bool shared;
 };
 
 struct i2s_dma_data {
diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
index e27e21f..1e7c285 100644
--- a/sound/soc/dwc/dwc-i2s.c
+++ b/sound/soc/dwc/dwc-i2s.c
@@ -629,9 +629,21 @@ static int dw_i2s_probe(struct platform_device *pdev)
 	dw_i2s_dai->resume = dw_i2s_resume;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dev->i2s_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(dev->i2s_base))
-		return PTR_ERR(dev->i2s_base);
+	/* For devices which use the same registers for playback
+	 * and capture, we would set shared flag for registering
+	 * the second cpu dai.
+	 */
+	if (pdata && pdata->shared) {
+			dev->i2s_base =
+				devm_ioremap_shared_resource(&pdev->dev, res);
+			if (IS_ERR(dev->i2s_base))
+				return PTR_ERR(dev->i2s_base);
+	} else {
+			dev->i2s_base =
+				devm_ioremap_resource(&pdev->dev, res);
+			if (IS_ERR(dev->i2s_base))
+				return PTR_ERR(dev->i2s_base);
+	}
 
 	dev->dev = &pdev->dev;
 
-- 
1.9.1
