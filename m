From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: davinci-mcasp: Use a copy of pdata per
	instance during DT boot
Date: Thu, 2 Jun 2016 12:55:24 +0300
Message-ID: <20160602095524.6967-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [198.47.19.11])
 by alsa0.perex.cz (Postfix) with ESMTP id C2D6E26047C
 for <alsa-devel@alsa-project.org>; Thu,  2 Jun 2016 11:55:29 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, misael.lopez@ti.com
List-Id: alsa-devel@alsa-project.org

Instead of modifying the static pdata struct per McASP instance we need to
allocate pdata for each McASP.
This way we can avoid configuration leakage from prior McASP to McASP
drivers probed at later time.

Reported-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index f8cb3c7d3c45..e10cfda21d89 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1620,7 +1620,14 @@ static struct davinci_mcasp_pdata *davinci_mcasp_set_pdata_from_of(
 		pdata = pdev->dev.platform_data;
 		return pdata;
 	} else if (match) {
-		pdata = (struct davinci_mcasp_pdata*) match->data;
+		pdata = devm_kmemdup(&pdev->dev, match->data, sizeof(*pdata),
+				     GFP_KERNEL);
+		if (!pdata) {
+			dev_err(&pdev->dev,
+				"Failed to allocate memory for pdata\n");
+			ret = -ENOMEM;
+			return pdata;
+		}
 	} else {
 		/* control shouldn't reach here. something is wrong */
 		ret = -EINVAL;
-- 
2.8.3
