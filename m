From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: davinci-mcasp: Discourage use of
	fck_parent for clock reparenting
Date: Wed, 27 Jan 2016 15:02:49 +0200
Message-ID: <1453899769-679-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 3503726044B
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2016 14:02:57 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, daniel@zonque.org, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

The in-driver clock reparenting had been added when we did not had other
means to cleanly set the parent for the fck. Now we can use
assigned-clocks/assigned-clock-parents in DT binding. Print warning when
the fck_parent is present for McASP and recommend the switch to the proper
way to handle the clock selection.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
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
2.7.0
