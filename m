From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] s3c24xx_simtec: fix typo
Date: Tue,  3 Jan 2012 15:24:47 +0100
Message-ID: <1325600687-32697-1-git-send-email-pmeerw@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pmeerw.net (ns.pmeerw.net [87.118.82.44])
	by alsa0.perex.cz (Postfix) with ESMTP id 61433247D8
	for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2012 15:25:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: ben@simtec.co.uk
List-Id: alsa-devel@alsa-project.org

From: Peter Meerwald <p.meerwald@bct-electronic.com>

---
 sound/soc/samsung/s3c24xx_simtec.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/samsung/s3c24xx_simtec.c b/sound/soc/samsung/s3c24xx_simtec.c
index a253bcc..dcef50c 100644
--- a/sound/soc/samsung/s3c24xx_simtec.c
+++ b/sound/soc/samsung/s3c24xx_simtec.c
@@ -343,7 +343,7 @@ int __devinit simtec_audio_core_probe(struct platform_device *pdev,
 
 	snd_dev = platform_device_alloc("soc-audio", -1);
 	if (!snd_dev) {
-		dev_err(&pdev->dev, "failed to alloc soc-audio devicec\n");
+		dev_err(&pdev->dev, "failed to alloc soc-audio device\n");
 		ret = -ENOMEM;
 		goto err_gpio;
 	}
-- 
1.7.4.1
