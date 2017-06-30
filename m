From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] ASoC: spear: fix error return code in
	spdif_in_probe()
Date: Fri, 30 Jun 2017 15:43:50 -0500
Message-ID: <20170630204350.GA8158@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway31.websitewelcome.com (gateway31.websitewelcome.com
 [192.185.144.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 50091267574
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 22:43:51 +0200 (CEST)
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
 by gateway31.websitewelcome.com (Postfix) with ESMTP id 4E73B296248
 for <alsa-devel@alsa-project.org>;
 Fri, 30 Jun 2017 15:43:51 -0500 (CDT)
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
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

platform_get_irq() returns an error code, but the spdif_in driver
ignores it and always returns -EINVAL. This is not correct, and
prevents -EPROBE_DEFER from being propagated properly.

Notice that platform_get_irq() no longer returns 0 on error:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e330b9a6bb35dc7097a4f02cb1ae7b6f96df92af

Print error message and propagate the return value of platform_get_irq
on failure.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 sound/soc/spear/spdif_in.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/spear/spdif_in.c b/sound/soc/spear/spdif_in.c
index 977a078..7f32527 100644
--- a/sound/soc/spear/spdif_in.c
+++ b/sound/soc/spear/spdif_in.c
@@ -223,8 +223,10 @@ static int spdif_in_probe(struct platform_device *pdev)
 
 	host->io_base = io_base;
 	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq < 0)
-		return -EINVAL;
+	if (host->irq < 0) {
+		dev_warn(&pdev->dev, "failed to get IRQ: %d\n", host->irq);
+		return host->irq;
+	}
 
 	host->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(host->clk))
-- 
2.5.0
