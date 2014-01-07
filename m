From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] ASoC: fsl_ssi: Fixed wrong printf format
	identifier
Date: Tue,  7 Jan 2014 10:04:50 +0400
Message-ID: <1389074690-21654-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp32.i.mail.ru (smtp32.i.mail.ru [94.100.177.92])
 by alsa0.perex.cz (Postfix) with ESMTP id DCA1A26164D
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 07:05:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Alexander Shiyan <shc_work@mail.ru>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

sound/soc/fsl/fsl_ssi.c: In function 'fsl_ssi_probe':
sound/soc/fsl/fsl_ssi.c:1180:6: warning: format '%d' expects argument
of type 'int', but argument 3 has type 'long int' [-Wformat=]

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 sound/soc/fsl/fsl_ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 3d74477a..c9d567c 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1192,7 +1192,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		 */
 		ssi_private->baudclk = devm_clk_get(&pdev->dev, "baud");
 		if (IS_ERR(ssi_private->baudclk))
-			dev_warn(&pdev->dev, "could not get baud clock: %d\n",
+			dev_warn(&pdev->dev, "could not get baud clock: %ld\n",
 				 PTR_ERR(ssi_private->baudclk));
 		else
 			clk_prepare_enable(ssi_private->baudclk);
-- 
1.8.3.2
