From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH v2] ASoC: Fix build error in
 sound/soc/kirkwood/kirkwood-i2s.c
Date: Wed, 28 Dec 2011 16:05:22 +0800
Message-ID: <1325059522.18468.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 492A924382
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 09:05:33 +0100 (CET)
Received: by iaae16 with SMTP id e16so20971156iaa.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 00:05:30 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Nicolas Pitre <nico@fluxnic.net>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org

Since commit db33f4de "ARM: Orion: Remove address map info from all platform data structures",
the dram is removed from struct kirkwood_asoc_platform_data.

This patch fixes below build error:
  CC      sound/soc/kirkwood/kirkwood-i2s.o
sound/soc/kirkwood/kirkwood-i2s.c: In function 'kirkwood_i2s_dev_probe':
sound/soc/kirkwood/kirkwood-i2s.c:444: error: 'struct kirkwood_asoc_platform_data' has no member named 'dram'
sound/soc/kirkwood/kirkwood-i2s.c:450: error: 'struct kirkwood_asoc_platform_data' has no member named 'dram'
make[3]: *** [sound/soc/kirkwood/kirkwood-i2s.o] Error 1
make[2]: *** [sound/soc/kirkwood] Error 2
make[1]: *** [sound/soc] Error 2
make: *** [sound] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Nicolas Pitre <nico@fluxnic.net>
---
v2: the dram field of struct kirkwood_dma_data is not being used now.
Thus also remove it in this patch.
This patch is against linux-next.

 sound/soc/kirkwood/kirkwood-i2s.c |    3 +--
 sound/soc/kirkwood/kirkwood.h     |    1 -
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index f6bb211..3cb9aa4 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -441,13 +441,12 @@ static __devinit int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 		goto err_ioremap;
 	}
 
-	if (!data || !data->dram) {
+	if (!data) {
 		dev_err(&pdev->dev, "no platform data ?!\n");
 		err = -EINVAL;
 		goto err_ioremap;
 	}
 
-	priv->dram = data->dram;
 	priv->burst = data->burst;
 
 	return snd_soc_register_dai(&pdev->dev, &kirkwood_i2s_dai);
diff --git a/sound/soc/kirkwood/kirkwood.h b/sound/soc/kirkwood/kirkwood.h
index bb6e6a5..9047436 100644
--- a/sound/soc/kirkwood/kirkwood.h
+++ b/sound/soc/kirkwood/kirkwood.h
@@ -123,7 +123,6 @@ struct kirkwood_dma_data {
 	void __iomem *io;
 	int irq;
 	int burst;
-	struct mbus_dram_target_info *dram;
 };
 
 #endif
-- 
1.7.5.4
