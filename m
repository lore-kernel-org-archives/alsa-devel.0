From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: mxs: mxs-sgtl5000: Simplify probe
	function
Date: Mon,  2 Sep 2013 17:56:18 -0300
Message-ID: <1378155378-22627-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f171.google.com (mail-vc0-f171.google.com
 [209.85.220.171])
 by alsa0.perex.cz (Postfix) with ESMTP id DBF7C26522E
 for <alsa-devel@alsa-project.org>; Mon,  2 Sep 2013 22:56:37 +0200 (CEST)
Received: by mail-vc0-f171.google.com with SMTP id ij15so3479628vcb.30
 for <alsa-devel@alsa-project.org>; Mon, 02 Sep 2013 13:56:36 -0700 (PDT)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

mxs is a device tree only platform, which allows us to simplify a bit
mxs_sgtl5000_probe(), because there is no need to check whether device tree is
supported or not.

Remove mxs_sgtl5000_probe_dt() and place its content inside mxs_sgtl5000_probe()
for making the code simpler.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/mxs/mxs-sgtl5000.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/sound/soc/mxs/mxs-sgtl5000.c b/sound/soc/mxs/mxs-sgtl5000.c
index 4bb2737..61822cc 100644
--- a/sound/soc/mxs/mxs-sgtl5000.c
+++ b/sound/soc/mxs/mxs-sgtl5000.c
@@ -122,14 +122,12 @@ static struct snd_soc_card mxs_sgtl5000 = {
 	.num_links	= ARRAY_SIZE(mxs_sgtl5000_dai),
 };
 
-static int mxs_sgtl5000_probe_dt(struct platform_device *pdev)
+static int mxs_sgtl5000_probe(struct platform_device *pdev)
 {
+	struct snd_soc_card *card = &mxs_sgtl5000;
+	int ret, i;
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *saif_np[2], *codec_np;
-	int i;
-
-	if (!np)
-		return 1; /* no device tree */
 
 	saif_np[0] = of_parse_phandle(np, "saif-controllers", 0);
 	saif_np[1] = of_parse_phandle(np, "saif-controllers", 1);
@@ -152,18 +150,6 @@ static int mxs_sgtl5000_probe_dt(struct platform_device *pdev)
 	of_node_put(saif_np[0]);
 	of_node_put(saif_np[1]);
 
-	return 0;
-}
-
-static int mxs_sgtl5000_probe(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = &mxs_sgtl5000;
-	int ret;
-
-	ret = mxs_sgtl5000_probe_dt(pdev);
-	if (ret < 0)
-		return ret;
-
 	/*
 	 * Set an init clock(11.28Mhz) for sgtl5000 initialization(i2c r/w).
 	 * The Sgtl5000 sysclk is derived from saif0 mclk and it's range
-- 
1.8.1.2
