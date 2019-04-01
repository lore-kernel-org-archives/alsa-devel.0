From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl: fix spelling mistake: "missign" -> "missing"" to
 the asoc tree
Date: Mon,  1 Apr 2019 09:53:07 +0100 (BST)
Message-ID: <20190401085307.A2D25440082@finisterre.ee.mobilebroadband>
References: <20190328092816.12883-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190328092816.12883-1-colin.king@canonical.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Colin Ian King <colin.king@canonical.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, NXP Linux Team <linux-imx@nxp.com>, Viorel Suman <viorel.suman@nxp.com>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl: fix spelling mistake: "missign" -> "missing"

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

>From de70b2a581125a8a627db6fdc1d7f9c05536fe84 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 28 Mar 2019 09:28:16 +0000
Subject: [PATCH] ASoC: fsl: fix spelling mistake: "missign" -> "missing"

There is a spelling mistake in a dev_err message. Fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Acked-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-audmix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
index 72e37ca6cfbb..7983bd339c01 100644
--- a/sound/soc/fsl/imx-audmix.c
+++ b/sound/soc/fsl/imx-audmix.c
@@ -161,7 +161,7 @@ static int imx_audmix_probe(struct platform_device *pdev)
 	}
 
 	if (!audmix_np) {
-		dev_err(&pdev->dev, "Missign DT node for parent device.\n");
+		dev_err(&pdev->dev, "Missing DT node for parent device.\n");
 		return -EINVAL;
 	}
 
-- 
2.20.1
