From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH] ASoC: fsl-asoc-card: don't print EPROBE_DEFER
	as error
Date: Fri, 18 Aug 2017 18:33:35 +0200
Message-ID: <20170818163335.23695-1-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.4.pengutronix.de (metis.ext.4.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id DA174266A74
 for <alsa-devel@alsa-project.org>; Fri, 18 Aug 2017 18:33:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>, alsa-devel@alsa-project.org, "Wladimir J . van der Laan" <laanwj@gmail.com>, patchwork-lst@pengutronix.de, Ilia Mirkin <imirkin@alum.mit.edu>, kernel@pengutronix.de, Chris Healy <cphealy@gmail.com>
List-Id: alsa-devel@alsa-project.org

Probe deferral is to be expected during normal operation, so avoid
printing an error when it is encountered.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 sound/soc/fsl/fsl-asoc-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 9998aea23597..2db4d0c80d33 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -683,7 +683,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	snd_soc_card_set_drvdata(&priv->card, priv);
 
 	ret = devm_snd_soc_register_card(&pdev->dev, &priv->card);
-	if (ret)
+	if (ret && ret != -EPROBE_DEFER)
 		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
 
 asrc_fail:
-- 
2.11.0
