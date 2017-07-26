From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun4i-spdif: Handle return value of
 clk_prepare_enable." to the asoc tree
Date: Wed, 26 Jul 2017 15:16:49 +0100
Message-ID: <E1daN7J-0003SG-Kd@debutante>
References: <1500977718-28010-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1500977718-28010-1-git-send-email-arvind.yadav.cs@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, sbkim73@samsung.com, linux-kernel@vger.kernel.org, tiwai@suse.com, krzk@kernel.org, perex@perex.cz, wens@csie.org, broonie@kernel.org, maxime.ripard@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sun4i-spdif: Handle return value of clk_prepare_enable.

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

>From 3643e9172649f97f2e6301582890202abcc0f97e Mon Sep 17 00:00:00 2001
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Tue, 25 Jul 2017 15:45:18 +0530
Subject: [PATCH] ASoC: sun4i-spdif: Handle return value of clk_prepare_enable.

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-spdif.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index c49f3757b686..b4af4aabead1 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -458,11 +458,16 @@ static int sun4i_spdif_runtime_suspend(struct device *dev)
 static int sun4i_spdif_runtime_resume(struct device *dev)
 {
 	struct sun4i_spdif_dev *host  = dev_get_drvdata(dev);
+	int ret;
 
-	clk_prepare_enable(host->spdif_clk);
-	clk_prepare_enable(host->apb_clk);
+	ret = clk_prepare_enable(host->spdif_clk);
+	if (ret)
+		return ret;
+	ret = clk_prepare_enable(host->apb_clk);
+	if (ret)
+		clk_disable_unprepare(host->spdif_clk);
 
-	return 0;
+	return ret;
 }
 
 static int sun4i_spdif_probe(struct platform_device *pdev)
-- 
2.13.2
