From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: fsl: imx-wm8962: remove an unneeded check
Date: Fri, 8 Nov 2013 12:54:44 +0300
Message-ID: <20131108095444.GM27977@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id F27C0261705
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2013 10:54:59 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Wolfram Sang <wsa@the-dreams.de>, Takashi Iwai <tiwai@suse.de>, Nicolin Chen <b42378@freescale.com>, kernel-janitors@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Sachin Kamat <sachin.kamat@linaro.org>, Mark Brown <broonie@kernel.org>, Grant Likely <grant.likely@linaro.org>
List-Id: alsa-devel@alsa-project.org

"data->codec_clk" can't be an ERR_PTR here so I have removed the
superflous check.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/fsl/imx-wm8962.c b/sound/soc/fsl/imx-wm8962.c
index a1deac6..61e4885 100644
--- a/sound/soc/fsl/imx-wm8962.c
+++ b/sound/soc/fsl/imx-wm8962.c
@@ -279,8 +279,7 @@ static int imx_wm8962_probe(struct platform_device *pdev)
 	return 0;
 
 clk_fail:
-	if (!IS_ERR(data->codec_clk))
-		clk_disable_unprepare(data->codec_clk);
+	clk_disable_unprepare(data->codec_clk);
 fail:
 	if (ssi_np)
 		of_node_put(ssi_np);
