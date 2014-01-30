From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/3] ASoC: davinci-evm: Add pm callbacks to
	platform driver
Date: Thu, 30 Jan 2014 15:21:31 +0200
Message-ID: <1391088092-4157-3-git-send-email-peter.ujfalusi@ti.com>
References: <1391088092-4157-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 40601265490
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2014 14:21:42 +0100 (CET)
In-Reply-To: <1391088092-4157-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, nsekhar@ti.com, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

Set snd_soc_pm_ops for the pm ops.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-evm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 70ff3772079f..5e3bc3c6801a 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -399,6 +399,7 @@ static struct platform_driver davinci_evm_driver = {
 	.driver		= {
 		.name	= "davinci_evm",
 		.owner	= THIS_MODULE,
+		.pm	= &snd_soc_pm_ops,
 		.of_match_table = of_match_ptr(davinci_evm_dt_ids),
 	},
 };
-- 
1.8.5.3
