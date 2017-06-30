From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] ASoC: kirkwood-i2s: fix error return code in
 kirkwood_i2s_dev_probe()
Date: Fri, 30 Jun 2017 16:46:33 -0500
Message-ID: <20170630214633.GA14042@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gateway34.websitewelcome.com (gateway34.websitewelcome.com
 [192.185.148.214])
 by alsa0.perex.cz (Postfix) with ESMTP id D74E2267574
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 23:46:37 +0200 (CEST)
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
 by gateway34.websitewelcome.com (Postfix) with ESMTP id 7B7BF38742
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 16:46:36 -0500 (CDT)
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

platform_get_irq() returns an error code, but the kirkwood-i2s
driver ignores it and always returns -ENXIO. This is not correct,
and prevents -EPROBE_DEFER from being propagated properly.
Notice that platform_get_irq() no longer returns 0 on error.

Print and propagate the return value of platform_get_irq on failure.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 sound/soc/kirkwood/kirkwood-i2s.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 3a36d60..3b09f71 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -550,9 +550,9 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->io);
 
 	priv->irq = platform_get_irq(pdev, 0);
-	if (priv->irq <= 0) {
-		dev_err(&pdev->dev, "platform_get_irq failed\n");
-		return -ENXIO;
+	if (priv->irq < 0) {
+		dev_err(&pdev->dev, "platform_get_irq failed: %d\n", priv->irq);
+		return priv->irq;
 	}
 
 	if (np) {
-- 
2.5.0
