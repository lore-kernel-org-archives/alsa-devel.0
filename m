From: Ed Blake <ed.blake@sondrel.com>
Subject: [PATCH] ASoC: img-parallel-out: Check
	pm_runtime_get_sync return code
Date: Fri,  6 Oct 2017 15:57:50 +0100
Message-ID: <20171006145750.13791-1-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0054.outbound.protection.outlook.com [104.47.1.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 92D7F266991
 for <alsa-devel@alsa-project.org>; Fri,  6 Oct 2017 16:57:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Ed Blake <ed.blake@sondrel.com>
List-Id: alsa-devel@alsa-project.org

Check the the pm_runtime_get_sync return code and return if an error.

Signed-off-by: Ed Blake <ed.blake@sondrel.com>
---
 sound/soc/img/img-parallel-out.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/img/img-parallel-out.c b/sound/soc/img/img-parallel-out.c
index 2fc8a6372206..acc005217be0 100644
--- a/sound/soc/img/img-parallel-out.c
+++ b/sound/soc/img/img-parallel-out.c
@@ -153,6 +153,7 @@ static int img_prl_out_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct img_prl_out *prl = snd_soc_dai_get_drvdata(dai);
 	u32 reg, control_set = 0;
+	int ret;
 
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_NB_NF:
@@ -164,7 +165,10 @@ static int img_prl_out_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	pm_runtime_get_sync(prl->dev);
+	ret = pm_runtime_get_sync(prl->dev);
+	if (ret < 0)
+		return ret;
+
 	reg = img_prl_out_readl(prl, IMG_PRL_OUT_CTL);
 	reg = (reg & ~IMG_PRL_OUT_CTL_EDGE_MASK) | control_set;
 	img_prl_out_writel(prl, reg, IMG_PRL_OUT_CTL);
-- 
2.11.0
