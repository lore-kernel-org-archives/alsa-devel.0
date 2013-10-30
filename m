From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/9] ASoC: ab8500: Add missing of NULL check of
	devm_kzalloc()
Date: Wed, 30 Oct 2013 08:34:59 +0100
Message-ID: <1383118507-21503-2-git-send-email-tiwai@suse.de>
References: <1383118507-21503-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 755862652C5
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 08:32:34 +0100 (CET)
In-Reply-To: <1383118507-21503-1-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Spotted by coverity CID 712316.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/ab8500-codec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index a0394a8f2257..6e3dda1ca734 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -2575,6 +2575,8 @@ static int ab8500_codec_driver_probe(struct platform_device *pdev)
 	/* Create driver private-data struct */
 	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct ab8500_codec_drvdata),
 			GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
 	drvdata->sid_status = SID_UNCONFIGURED;
 	drvdata->anc_status = ANC_UNCONFIGURED;
 	dev_set_drvdata(&pdev->dev, drvdata);
-- 
1.8.4.1
