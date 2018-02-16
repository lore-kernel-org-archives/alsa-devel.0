From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dwc: Extends DW_I2S_QUIRK_COMP_PARAM1
	to playback" to the asoc tree
Date: Fri, 16 Feb 2018 17:12:02 +0000
Message-ID: <E1emjYI-0007yh-Do@debutante>
References: <1518766875-15164-4-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EEA79267E69
 for <alsa-devel@alsa-project.org>; Fri, 16 Feb 2018 18:12:06 +0100 (CET)
In-Reply-To: <1518766875-15164-4-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, akshu.agrawal@amd.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dwc: Extends DW_I2S_QUIRK_COMP_PARAM1 to playback

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 97a865d3c3438041913756a08e523fb1d0bbbe3c Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Fri, 16 Feb 2018 13:11:15 +0530
Subject: [PATCH] ASoC: dwc: Extends DW_I2S_QUIRK_COMP_PARAM1 to playback

When we have same register to tell capture and playback capability
of a device and we want separate cpu dais for playback and
capture. Then, DW_I2S_QUIRK_COMP_PARAM1 is used to enable one
capability per dai.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/dwc/dwc-i2s.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
index e27e21f8569a..65112b9d8588 100644
--- a/sound/soc/dwc/dwc-i2s.c
+++ b/sound/soc/dwc/dwc-i2s.c
@@ -491,6 +491,10 @@ static int dw_configure_dai(struct dw_i2s_dev *dev,
 			dev->quirks & DW_I2S_QUIRK_COMP_PARAM1)
 		comp1 = comp1 & ~BIT(5);
 
+	if (dev->capability & DWC_I2S_PLAY &&
+			dev->quirks & DW_I2S_QUIRK_COMP_PARAM1)
+		comp1 = comp1 & ~BIT(6);
+
 	if (COMP1_TX_ENABLED(comp1)) {
 		dev_dbg(dev->dev, " designware: play supported\n");
 		idx = COMP1_TX_WORDSIZE_0(comp1);
-- 
2.16.1
