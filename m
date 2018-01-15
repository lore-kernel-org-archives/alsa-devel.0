From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 5/5] ASoC: atmel_wm8904: Return -ENODEV when
 probe does not find OF node
Date: Mon, 15 Jan 2018 08:54:58 +0100
Message-ID: <20180115075458.GF10762@lenoch>
References: <20180115075213.GA10762@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id C84EF26731C
 for <alsa-devel@alsa-project.org>; Mon, 15 Jan 2018 08:54:59 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23990488AbeAOHy7eauPu (ORCPT
 <rfc822;alsa-devel@alsa-project.org>);
 Mon, 15 Jan 2018 08:54:59 +0100
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
 sound/soc/atmel/atmel_wm8904.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/atmel/atmel_wm8904.c b/sound/soc/atmel/atmel_wm8904.c
index fbc10f61eb55..39a73c4d19ec 100644
--- a/sound/soc/atmel/atmel_wm8904.c
+++ b/sound/soc/atmel/atmel_wm8904.c
@@ -85,10 +85,8 @@ static int atmel_asoc_wm8904_dt_init(struct platform_device *pdev)
 	struct snd_soc_dai_link *dailink = &atmel_asoc_wm8904_dailink;
 	int ret;
 
-	if (!np) {
-		dev_err(&pdev->dev, "only device tree supported\n");
-		return -EINVAL;
-	}
+	if (!np)
+		return -ENODEV;
 
 	ret = snd_soc_of_parse_card_name(card, "atmel,model");
 	if (ret) {
-- 
2.15.1
