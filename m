From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: pxa: pxa-ssp: small leak in probe()
Date: Thu, 31 Jul 2014 15:57:51 +0300
Message-ID: <20140731125751.GA31539@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

There is a small memory leak if probe() fails.

Fixes: 2023c90c3a2c ('ASoC: pxa: pxa-ssp: add DT bindings')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 199a8b3..0109f6c2 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -723,7 +723,8 @@ static int pxa_ssp_probe(struct snd_soc_dai *dai)
 		ssp_handle = of_parse_phandle(dev->of_node, "port", 0);
 		if (!ssp_handle) {
 			dev_err(dev, "unable to get 'port' phandle\n");
-			return -ENODEV;
+			ret = -ENODEV;
+			goto err_priv;
 		}
 
 		priv->ssp = pxa_ssp_request_of(ssp_handle, "SoC audio");
