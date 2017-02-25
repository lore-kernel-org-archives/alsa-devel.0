From: Mihai Burduselu <michelcatalin@gmail.com>
Subject: [PATCH] soc: blackfin: remove 'out of memory' message
Date: Sat, 25 Feb 2017 12:29:33 +0200
Message-ID: <20170225102933.6879-1-michelcatalin@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, michelcatalin@gmail.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, adi-buildroot-devel@lists.sourceforge.net, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

reported by checkpatch.pl

Signed-off-by: Mihai Burduselu <michelcatalin@gmail.com>
---
 sound/soc/blackfin/bf5xx-sport.c | 8 ++------
 sound/soc/blackfin/bf6xx-sport.c | 4 +---
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-sport.c b/sound/soc/blackfin/bf5xx-sport.c
index 9dfa1241ea66..c445d6cc875e 100644
--- a/sound/soc/blackfin/bf5xx-sport.c
+++ b/sound/soc/blackfin/bf5xx-sport.c
@@ -876,10 +876,8 @@ struct sport_device *sport_init(struct platform_device *pdev,
 	}
 
 	sport = kzalloc(sizeof(*sport), GFP_KERNEL);
-	if (!sport) {
-		dev_err(dev, "failed to allocate for sport device\n");
+	if (!sport)
 		goto __init_err0;
-	}
 
 	sport->num = param.num;
 	sport->dma_rx_chan = param.dma_rx_chan;
@@ -921,10 +919,8 @@ struct sport_device *sport_init(struct platform_device *pdev,
 	sport->dummy_count = param.dummy_count;
 
 	sport->private_data = kzalloc(priv_size, GFP_KERNEL);
-	if (!sport->private_data) {
-		dev_err(dev, "could not alloc priv data %zu bytes\n", priv_size);
+	if (!sport->private_data)
 		goto __init_err4;
-	}
 
 	if (L1_DATA_A_LENGTH)
 		sport->dummy_buf = l1_data_sram_zalloc(param.dummy_count * 2);
diff --git a/sound/soc/blackfin/bf6xx-sport.c b/sound/soc/blackfin/bf6xx-sport.c
index dfb744381c42..b56ff75d4c13 100644
--- a/sound/soc/blackfin/bf6xx-sport.c
+++ b/sound/soc/blackfin/bf6xx-sport.c
@@ -388,10 +388,8 @@ struct sport_device *sport_create(struct platform_device *pdev)
 	int ret;
 
 	sport = kzalloc(sizeof(*sport), GFP_KERNEL);
-	if (!sport) {
-		dev_err(dev, "Unable to allocate memory for sport device\n");
+	if (!sport)
 		return NULL;
-	}
 	sport->pdev = pdev;
 
 	ret = sport_get_resource(sport);
-- 
2.11.0
