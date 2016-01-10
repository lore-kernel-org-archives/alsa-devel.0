From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dwc: add quirk to override COMP_PARAM_1
	register" to the asoc tree
Date: Sun, 10 Jan 2016 12:22:34 +0000
Message-ID: <E1aIF10-0008Sl-Eb@debutante>
References: <1452295331-28476-4-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1958726067F
 for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2016 13:22:42 +0100 (CET)
In-Reply-To: <1452295331-28476-4-git-send-email-alexander.deucher@amd.com>
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

   ASoC: dwc: add quirk to override COMP_PARAM_1 register

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

>From a242cac1d3aa098fbe51097d2b1dcae8b662b761 Mon Sep 17 00:00:00 2001
From: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
Date: Fri, 8 Jan 2016 18:22:05 -0500
Subject: [PATCH] ASoC: dwc: add quirk to override COMP_PARAM_1 register

DWC for capture in ACP 2.x IP reports playback and capture capabilities
though it supports only capture. Added a quirk to override default value
to represent capture capability only.

Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/designware_i2s.h | 1 +
 sound/soc/dwc/designware_i2s.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/sound/designware_i2s.h b/include/sound/designware_i2s.h
index e0bb45807f29..5681855396c4 100644
--- a/include/sound/designware_i2s.h
+++ b/include/sound/designware_i2s.h
@@ -46,6 +46,7 @@ struct i2s_platform_data {
 	u32 snd_rates;
 
 	#define DW_I2S_QUIRK_COMP_REG_OFFSET	(1 << 0)
+	#define DW_I2S_QUIRK_COMP_PARAM1	(1 << 1)
 	unsigned int quirks;
 	unsigned int i2s_reg_comp1;
 	unsigned int i2s_reg_comp2;
diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index 825a1f480aab..ce664c239be3 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -500,6 +500,10 @@ static int dw_configure_dai(struct dw_i2s_dev *dev,
 	u32 comp2 = i2s_read_reg(dev->i2s_base, dev->i2s_reg_comp2);
 	u32 idx;
 
+	if (dev->capability & DWC_I2S_RECORD &&
+			dev->quirks & DW_I2S_QUIRK_COMP_PARAM1)
+		comp1 = comp1 & ~BIT(5);
+
 	if (COMP1_TX_ENABLED(comp1)) {
 		dev_dbg(dev->dev, " designware: play supported\n");
 		idx = COMP1_TX_WORDSIZE_0(comp1);
-- 
2.7.0.rc3
