From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl: imx-wm8962: Set the card owner field
Date: Wed, 14 Jan 2015 11:56:22 -0200
Message-ID: <1421243782-26115-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f53.google.com (mail-qg0-f53.google.com
 [209.85.192.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 86BB1265071
 for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2015 14:56:38 +0100 (CET)
Received: by mail-qg0-f53.google.com with SMTP id l89so6934793qgf.12
 for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2015 05:56:38 -0800 (PST)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lars@metafoo.de, jiada_wang@mentor.com, nicoleotsuka@gmail.com, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

The following crash happens when trying to unload the snd_soc_imx_wm8962 module
while playback is active:

[  208.666868] Unable to handle kernel paging request at virtc
[  208.674110] pgd = 80004000
[  208.676867] [7f06541c] *pgd=4c334811, *pte=00000000, *ppte=00000000
[  208.683211] Internal error: Oops: 80000007 [#1] SMP ARM
[  208.688445] Modules linked in: snd_soc_wm8962 snd_soc_fsl_ssi snd_soc_imx_audmux imx_pcm_fiq evbug]
...

In order to avoid such problem, fill the card owner field as suggested by
Lars-Peter Clausen:

"But looking at the source it seems that this is a core feature of ALSA and at 
least for the card module itself it will do the ref-counting when a stream is 
started/stopped. And we even support setting the owner of a card in ASoC. 
It's just that pretty much no ASoC card driver bothers to set the owner field
in the snd_soc_card struct. So this particular problem can be fixed by updating
the imx-wm8962 driver to set the owner field."

By doing as suggested, we no longer see the crash when attempting to unload the
snd_soc_imx_wm8962 module while playback is active:

$ modprobe -r snd_soc_imx_wm8962
modprobe: can't unload module snd_soc_imx_wm8962: Resource temporarily 
unavailable

Reported-by: Jiada Wang <jiada_wang@mentor.com>
Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/imx-wm8962.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/imx-wm8962.c b/sound/soc/fsl/imx-wm8962.c
index 4caacb0..cd146d4 100644
--- a/sound/soc/fsl/imx-wm8962.c
+++ b/sound/soc/fsl/imx-wm8962.c
@@ -257,6 +257,7 @@ static int imx_wm8962_probe(struct platform_device *pdev)
 	if (ret)
 		goto clk_fail;
 	data->card.num_links = 1;
+	data->card.owner = THIS_MODULE;
 	data->card.dai_link = &data->dai;
 	data->card.dapm_widgets = imx_wm8962_dapm_widgets;
 	data->card.num_dapm_widgets = ARRAY_SIZE(imx_wm8962_dapm_widgets);
-- 
1.9.1
