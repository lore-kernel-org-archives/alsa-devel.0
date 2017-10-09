From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: img-parallel-out: Check
	pm_runtime_get_sync return code" to the asoc tree
Date: Mon, 09 Oct 2017 09:50:07 +0100
Message-ID: <E1e1TlH-0006SE-6z@debutante>
References: <20171006145750.13791-1-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B4A52671E0
 for <alsa-devel@alsa-project.org>; Mon,  9 Oct 2017 10:50:08 +0200 (CEST)
In-Reply-To: <20171006145750.13791-1-ed.blake@sondrel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ed Blake <ed.blake@sondrel.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: img-parallel-out: Check pm_runtime_get_sync return code

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

>From 596ec4bd958bc7c233d4129072d80272f21e2be1 Mon Sep 17 00:00:00 2001
From: Ed Blake <ed.blake@sondrel.com>
Date: Fri, 6 Oct 2017 15:57:50 +0100
Subject: [PATCH] ASoC: img-parallel-out: Check pm_runtime_get_sync return code

Check the the pm_runtime_get_sync return code and return if an error.

Signed-off-by: Ed Blake <ed.blake@sondrel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.14.1
