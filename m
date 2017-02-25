From: dspmihai <despotovici.mihai@gmail.com>
Subject: [PATCH] ASoC: spear: Remove redundant message
Date: Sat, 25 Feb 2017 02:33:30 -0800
Message-ID: <1488018810-11973-1-git-send-email-despotovici.mihai@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, dspmihai <despotovici.mihai@gmail.com>
List-Id: alsa-devel@alsa-project.org

This was reported by checkpatch.pl

Signed-off-by: Despotovici Mihai <despotovici.mihai@gmail.com>
---
 sound/soc/spear/spdif_in.c  | 4 +---
 sound/soc/spear/spdif_out.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/spear/spdif_in.c b/sound/soc/spear/spdif_in.c
index 977a078..0f3b1a8 100644
--- a/sound/soc/spear/spdif_in.c
+++ b/sound/soc/spear/spdif_in.c
@@ -216,10 +216,8 @@ static int spdif_in_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	host = devm_kzalloc(&pdev->dev, sizeof(*host), GFP_KERNEL);
-	if (!host) {
-		dev_warn(&pdev->dev, "kzalloc fail\n");
+	if (!host)
 		return -ENOMEM;
-	}
 
 	host->io_base = io_base;
 	host->irq = platform_get_irq(pdev, 0);
diff --git a/sound/soc/spear/spdif_out.c b/sound/soc/spear/spdif_out.c
index 0a72d52..58d5843 100644
--- a/sound/soc/spear/spdif_out.c
+++ b/sound/soc/spear/spdif_out.c
@@ -282,10 +282,8 @@ static int spdif_out_probe(struct platform_device *pdev)
 	int ret;
 
 	host = devm_kzalloc(&pdev->dev, sizeof(*host), GFP_KERNEL);
-	if (!host) {
-		dev_warn(&pdev->dev, "kzalloc fail\n");
+	if (!host)
 		return -ENOMEM;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host->io_base = devm_ioremap_resource(&pdev->dev, res);
-- 
2.7.4
