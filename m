From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/2] ASoC: Add missing dev_set_drvdata in p1022_ds_probe
Date: Mon, 29 Nov 2010 14:55:58 +0800
Message-ID: <1291013758.19113.2.camel@mola>
References: <1291013698.19113.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1291013698.19113.1.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Otherwise, calling dev_get_drvdata in p1022_ds_remove returns NULL.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/fsl/p1022_ds.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
index 63b9eaa..026b756 100644
--- a/sound/soc/fsl/p1022_ds.c
+++ b/sound/soc/fsl/p1022_ds.c
@@ -498,6 +498,7 @@ static int p1022_ds_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "platform device add failed\n");
 		goto error;
 	}
+	dev_set_drvdata(&pdev->dev, sound_device);
 
 	of_node_put(codec_np);
 
-- 
1.7.2
