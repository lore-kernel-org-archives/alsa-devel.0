From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dwc: add quirk for different register
	offset" to the asoc tree
Date: Mon, 07 Dec 2015 19:54:05 +0000
Message-ID: <E1a61rJ-0003VE-Tb@debutante>
References: <1449272440-8735-5-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DD932652E8
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2015 20:54:15 +0100 (CET)
In-Reply-To: <1449272440-8735-5-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dwc: add quirk for different register offset

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From e164835a0270cc01c93794536027cc70cd00d0ff Mon Sep 17 00:00:00 2001
From: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
Date: Fri, 4 Dec 2015 18:40:32 -0500
Subject: [PATCH] ASoC: dwc: add quirk for different register offset

DWC in ACP 2.x IP has different offsets for I2S_COMP_PARAM_* registers.
Added a quirk to support the same.

Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/designware_i2s.h |  5 +++++
 sound/soc/dwc/designware_i2s.c | 17 ++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/sound/designware_i2s.h b/include/sound/designware_i2s.h
index 8966ba7c9629..e0bb45807f29 100644
--- a/include/sound/designware_i2s.h
+++ b/include/sound/designware_i2s.h
@@ -45,6 +45,11 @@ struct i2s_platform_data {
 	u32 snd_fmts;
 	u32 snd_rates;
 
+	#define DW_I2S_QUIRK_COMP_REG_OFFSET	(1 << 0)
+	unsigned int quirks;
+	unsigned int i2s_reg_comp1;
+	unsigned int i2s_reg_comp2;
+
 	void *play_dma_data;
 	void *capture_dma_data;
 	bool (*filter)(struct dma_chan *chan, void *slave);
diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index 3d7754c115ec..940c88136a34 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -94,6 +94,9 @@ struct dw_i2s_dev {
 	struct clk *clk;
 	int active;
 	unsigned int capability;
+	unsigned int quirks;
+	unsigned int i2s_reg_comp1;
+	unsigned int i2s_reg_comp2;
 	struct device *dev;
 
 	/* data related to DMA transfers b/w i2s and DMAC */
@@ -477,8 +480,8 @@ static int dw_configure_dai(struct dw_i2s_dev *dev,
 	 * Read component parameter registers to extract
 	 * the I2S block's configuration.
 	 */
-	u32 comp1 = i2s_read_reg(dev->i2s_base, I2S_COMP_PARAM_1);
-	u32 comp2 = i2s_read_reg(dev->i2s_base, I2S_COMP_PARAM_2);
+	u32 comp1 = i2s_read_reg(dev->i2s_base, dev->i2s_reg_comp1);
+	u32 comp2 = i2s_read_reg(dev->i2s_base, dev->i2s_reg_comp2);
 	u32 idx;
 
 	if (COMP1_TX_ENABLED(comp1)) {
@@ -521,7 +524,7 @@ static int dw_configure_dai_by_pd(struct dw_i2s_dev *dev,
 				   struct resource *res,
 				   const struct i2s_platform_data *pdata)
 {
-	u32 comp1 = i2s_read_reg(dev->i2s_base, I2S_COMP_PARAM_1);
+	u32 comp1 = i2s_read_reg(dev->i2s_base, dev->i2s_reg_comp1);
 	u32 idx = COMP1_APB_DATA_WIDTH(comp1);
 	int ret;
 
@@ -625,6 +628,14 @@ static int dw_i2s_probe(struct platform_device *pdev)
 	if (pdata) {
 		dev->capability = pdata->cap;
 		clk_id = NULL;
+		dev->quirks = pdata->quirks;
+		if (dev->quirks & DW_I2S_QUIRK_COMP_REG_OFFSET) {
+			dev->i2s_reg_comp1 = pdata->i2s_reg_comp1;
+			dev->i2s_reg_comp2 = pdata->i2s_reg_comp2;
+		} else {
+			dev->i2s_reg_comp1 = I2S_COMP_PARAM_1;
+			dev->i2s_reg_comp2 = I2S_COMP_PARAM_2;
+		}
 		ret = dw_configure_dai_by_pd(dev, dw_i2s_dai, res, pdata);
 	} else {
 		clk_id = "i2sclk";
-- 
2.6.2
