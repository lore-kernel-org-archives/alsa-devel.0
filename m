From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH 1/2] ASoC: fsl-asoc-card: put ASRC OF node in
 case of unknown device
Date: Mon, 31 Aug 2015 17:07:12 +0200
Message-ID: <55E46DA0.2080500@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id C1141260469
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2015 17:07:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

In case of unknown DT compatible device the ASRC OF node
possibly acquired earlier by of_parse_phandle() has
to be put before returning from probe method.

Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl-asoc-card.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 5aeb6ed..96f55ae 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -488,7 +488,8 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		priv->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
 	} else {
 		dev_err(&pdev->dev, "unknown Device Tree compatible\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto asrc_fail;
 	}
 
 	/* Common settings for corresponding Freescale CPU DAI driver */
