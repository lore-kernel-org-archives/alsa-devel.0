From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] ALSA: atmel: ac97c: fix error return code in
 atmel_ac97c_probe()
Date: Fri, 30 Jun 2017 17:34:23 -0500
Message-ID: <20170630223423.GA20635@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

platform_get_irq() returns an error code, but the ac97c
driver ignores it and always returns -ENXIO. This is not correct,
and prevents -EPROBE_DEFER from being propagated properly.
Notice that platform_get_irq() no longer returns 0 on error.

Print and propagate the return value of platform_get_irq on failure.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 sound/atmel/ac97c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index 65e6948..9d2c9d9 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -774,8 +774,8 @@ static int atmel_ac97c_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_dbg(&pdev->dev, "could not get irq\n");
-		return -ENXIO;
+		dev_dbg(&pdev->dev, "could not get irq: %d\n", irq);
+		return irq;
 	}
 
 	pclk = clk_get(&pdev->dev, "ac97_clk");
-- 
2.5.0
