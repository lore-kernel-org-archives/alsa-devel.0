From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 2/3 v3] ASoC: mt8173: Fix platform_get_irq's
	error checking
Date: Sat, 18 Nov 2017 15:26:46 +0530
Message-ID: <f683092949c0a6195b09ebbeb690e358094a0506.1510997839.git.arvind.yadav.cs@gmail.com>
References: <874375c0dca41790e47b60ce30f88ab353f97b38.1510997839.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
 [209.85.192.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A18B266B80
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 10:57:03 +0100 (CET)
Received: by mail-pf0-f194.google.com with SMTP id d28so3764164pfe.2
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 01:57:03 -0800 (PST)
In-Reply-To: <874375c0dca41790e47b60ce30f88ab353f97b38.1510997839.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <874375c0dca41790e47b60ce30f88ab353f97b38.1510997839.git.arvind.yadav.cs@gmail.com>
References: <874375c0dca41790e47b60ce30f88ab353f97b38.1510997839.git.arvind.yadav.cs@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, matthias.bgg@gmail.com, linux@armlinux.org.uk
Cc: alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
               irq was unsigned. so changed it to signed.
changes in v3 :
              Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.

 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
index 8a643a3..11f5f2a 100644
--- a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
@@ -1083,7 +1083,7 @@ static int mt8173_afe_init_audio_clk(struct mtk_base_afe *afe)
 static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 {
 	int ret, i;
-	unsigned int irq_id;
+	int irq_id;
 	struct mtk_base_afe *afe;
 	struct mt8173_afe_private *afe_priv;
 	struct resource *res;
@@ -1105,9 +1105,9 @@ static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 	afe->dev = &pdev->dev;
 
 	irq_id = platform_get_irq(pdev, 0);
-	if (!irq_id) {
+	if (irq_id <= 0) {
 		dev_err(afe->dev, "np %s no irq\n", afe->dev->of_node->name);
-		return -ENXIO;
+		return irq_id;
 	}
 	ret = devm_request_irq(afe->dev, irq_id, mt8173_afe_irq_handler,
 			       0, "Afe_ISR_Handle", (void *)afe);
-- 
2.7.4
