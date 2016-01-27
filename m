From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: davinci-mcasp: Discourage use of
	fck_parent for clock reparenting" to the asoc tree
Date: Wed, 27 Jan 2016 18:37:31 +0000
Message-ID: <E1aOUyB-00086d-Kk@debutante>
References: <1453899769-679-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 01BF626548F
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2016 19:37:39 +0100 (CET)
In-Reply-To: <1453899769-679-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: davinci-mcasp: Discourage use of fck_parent for clock reparenting

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

>From c670254f63fe09681b1c4c82d3d059c6cc04ce09 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Wed, 27 Jan 2016 15:02:49 +0200
Subject: [PATCH] ASoC: davinci-mcasp: Discourage use of fck_parent for clock
 reparenting

The in-driver clock reparenting had been added when we did not had other
means to cleanly set the parent for the fck. Now we can use
assigned-clocks/assigned-clock-parents in DT binding. Print warning when
the fck_parent is present for McASP and recommend the switch to the proper
way to handle the clock selection.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/davinci/davinci-mcasp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 2ccb8bccc9d4..3cf46afb353f 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1517,6 +1517,8 @@ static int mcasp_reparent_fck(struct platform_device *pdev)
 	if (!parent_name)
 		return 0;
 
+	dev_warn(&pdev->dev, "Update the bindings to use assigned-clocks!\n");
+
 	gfclk = clk_get(&pdev->dev, "fck");
 	if (IS_ERR(gfclk)) {
 		dev_err(&pdev->dev, "failed to get fck\n");
-- 
2.7.0.rc3
