From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 3/5] ASoC: sam9x5_wm8731: Return -ENODEV when
 probe does not find OF node
Date: Mon, 15 Jan 2018 08:53:51 +0100
Message-ID: <20180115075351.GD10762@lenoch>
References: <20180115075213.GA10762@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 1688426731C
 for <alsa-devel@alsa-project.org>; Mon, 15 Jan 2018 08:53:54 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23990477AbeAOHxxsuT-u (ORCPT
 <rfc822;alsa-devel@alsa-project.org>);
 Mon, 15 Jan 2018 08:53:53 +0100
Content-Disposition: inline
In-Reply-To: <20180115075213.GA10762@lenoch>
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
Cc: Liam Girdwood <lgirdwood@gmail.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, SF Markus Elfring <elfring@users.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Probe should fail with -ENODEV when called with NULL pdev->dev.of_node.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 sound/soc/atmel/sam9x5_wm8731.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/atmel/sam9x5_wm8731.c b/sound/soc/atmel/sam9x5_wm8731.c
index e6c303ab869d..9db08826b32a 100644
--- a/sound/soc/atmel/sam9x5_wm8731.c
+++ b/sound/soc/atmel/sam9x5_wm8731.c
@@ -84,10 +84,8 @@ static int sam9x5_wm8731_driver_probe(struct platform_device *pdev)
 	struct sam9x5_drvdata *priv;
 	int ret;
 
-	if (!np) {
-		dev_err(&pdev->dev, "No device node supplied\n");
-		return -EINVAL;
-	}
+	if (!np)
+		return -ENODEV;
 
 	card = devm_kzalloc(&pdev->dev, sizeof(*card), GFP_KERNEL);
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-- 
2.15.1
