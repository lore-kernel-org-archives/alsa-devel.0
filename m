From: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: [PATCH] ASoC: dwc: Extends DW_I2S_QUIRK_COMP_PARAM1 to
	playback
Date: Fri, 16 Feb 2018 13:11:15 +0530
Message-ID: <1518766875-15164-4-git-send-email-akshu.agrawal@amd.com>
References: <1518766875-15164-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam03on0059.outbound.protection.outlook.com [104.47.40.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 47BA0267D81
 for <alsa-devel@alsa-project.org>; Fri, 16 Feb 2018 08:54:47 +0100 (CET)
In-Reply-To: <1518766875-15164-1-git-send-email-akshu.agrawal@amd.com>
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

When we have same register to tell capture and playback capability
of a device and we want separate cpu dais for playback and
capture. Then, DW_I2S_QUIRK_COMP_PARAM1 is used to enable one
capability per dai.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 sound/soc/dwc/dwc-i2s.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
index e27e21f..65112b9 100644
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
1.9.1
