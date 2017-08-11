From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ASoC: DaVinci: Delete an error message for a
 failed memory allocation in two functions
Date: Fri, 11 Aug 2017 17:08:03 +0200
Message-ID: <e25c9d88-2f82-bd02-b0da-0342077406b1@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id EAC1926768D
 for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2017 17:08:44 +0200 (CEST)
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 11 Aug 2017 16:51:46 +0200

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/davinci/davinci-mcasp.c | 2 --
 sound/soc/davinci/davinci-vcif.c  | 5 +----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 56ec1d301ac2..d486908d4e0e 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1604,6 +1604,4 @@ static struct davinci_mcasp_pdata *davinci_mcasp_set_pdata_from_of(
 		if (!pdata) {
-			dev_err(&pdev->dev,
-				"Failed to allocate memory for pdata\n");
 			ret = -ENOMEM;
 			return pdata;
 		}
diff --git a/sound/soc/davinci/davinci-vcif.c b/sound/soc/davinci/davinci-vcif.c
index c77d9218795a..5415b72393fa 100644
--- a/sound/soc/davinci/davinci-vcif.c
+++ b/sound/soc/davinci/davinci-vcif.c
@@ -213,8 +213,5 @@ static int davinci_vcif_probe(struct platform_device *pdev)
-	if (!davinci_vcif_dev) {
-		dev_dbg(&pdev->dev,
-			"could not allocate memory for private data\n");
+	if (!davinci_vcif_dev)
 		return -ENOMEM;
-	}
 
 	/* DMA tx params */
 	davinci_vcif_dev->davinci_vc = davinci_vc;
-- 
2.14.0
