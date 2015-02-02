From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] ASoC: davicni-mcasp: Mark the common irq
	line as shared
Date: Mon, 2 Feb 2015 14:38:32 +0200
Message-ID: <1422880713-25414-2-git-send-email-peter.ujfalusi@ti.com>
References: <1422880713-25414-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 274C92605F1
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 13:38:42 +0100 (CET)
In-Reply-To: <1422880713-25414-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, daniel@zonque.org
List-Id: alsa-devel@alsa-project.org

On DA830 devices McASP0,1 and 2 shares a single combined interrupt request
line.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 95eef582331b..a5e4fe0359ce 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1461,7 +1461,8 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 					  dev_name(&pdev->dev));
 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 						davinci_mcasp_common_irq_handler,
-						IRQF_ONESHOT, irq_name, mcasp);
+						IRQF_ONESHOT | IRQF_SHARED,
+						irq_name, mcasp);
 		if (ret) {
 			dev_err(&pdev->dev, "common IRQ request failed\n");
 			goto err;
-- 
2.2.2
