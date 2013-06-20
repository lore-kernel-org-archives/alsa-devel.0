From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [RFC] [patch 1/1] imx-sgtl5000: return E_PROBE_DEFER
	if ssi/codec not found
Date: Thu, 20 Jun 2013 23:20:49 +0200
Message-ID: <20130620212100.075892857@rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lebrac.rtp-net.org (lebrac.rtp-net.org [88.191.135.105])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BB37261737
 for <alsa-devel@alsa-project.org>; Sat, 22 Jun 2013 22:15:21 +0200 (CEST)
Content-Disposition: inline; filename=imx-sgtl5000-probe-defer.patch
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
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

If the ssi or codec drivers are not loaded (for instance, because spi or i2c
bus drivers are not loaded), returning -EINVAL will for people to unload and
then reload the module to get sound working. Returning E_PROBE_DEFER will
mitigate this.

Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>

Index: linux/sound/soc/fsl/imx-sgtl5000.c
===================================================================
--- linux.orig/sound/soc/fsl/imx-sgtl5000.c	2013-05-16 09:33:01.000000000 +0200
+++ linux/sound/soc/fsl/imx-sgtl5000.c	2013-05-16 09:35:14.000000000 +0200
@@ -113,13 +113,13 @@ static int imx_sgtl5000_probe(struct pla
 	ssi_pdev = of_find_device_by_node(ssi_np);
 	if (!ssi_pdev) {
 		dev_err(&pdev->dev, "failed to find SSI platform device\n");
-		ret = -EINVAL;
+		ret = -EPROBE_DEFER;
 		goto fail;
 	}
 	codec_dev = of_find_i2c_device_by_node(codec_np);
 	if (!codec_dev) {
 		dev_err(&pdev->dev, "failed to find codec platform device\n");
-		return -EINVAL;
+		return -EPROBE_DEFER;
 	}
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
