From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl: imx-spdif: Set the card owner field
Date: Wed, 14 Jan 2015 16:39:15 -0200
Message-ID: <1421260755-7445-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f50.google.com (mail-qa0-f50.google.com
 [209.85.216.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 37D17261521
 for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2015 19:39:41 +0100 (CET)
Received: by mail-qa0-f50.google.com with SMTP id k15so7916001qaq.9
 for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2015 10:39:40 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Set the card owner field to avoid getting a kernel crash when the imx-spdif
is unloaded while the playback is active.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Build-tested only.

 sound/soc/fsl/imx-spdif.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/imx-spdif.c b/sound/soc/fsl/imx-spdif.c
index e94704f..33da26a 100644
--- a/sound/soc/fsl/imx-spdif.c
+++ b/sound/soc/fsl/imx-spdif.c
@@ -60,6 +60,7 @@ static int imx_spdif_audio_probe(struct platform_device *pdev)
 	data->card.dev = &pdev->dev;
 	data->card.dai_link = &data->dai;
 	data->card.num_links = 1;
+	data->card.owner = THIS_MODULE;
 
 	ret = snd_soc_of_parse_card_name(&data->card, "model");
 	if (ret)
-- 
1.9.1
