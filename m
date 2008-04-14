From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] soc - pxa2xx-ac97: Add missing clk_enable()
Date: Mon, 14 Apr 2008 16:12:20 +0100
Message-ID: <1208185942-27637-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20080414151128.GA23694@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E8F6B244E2
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Apr 2008 17:12:23 +0200 (CEST)
In-Reply-To: <20080414151128.GA23694@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: eric miao <eric.y.miao@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

For some reason this is not required on PXA3xx.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/pxa2xx-ac97.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index fe9c297..e173799 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -314,6 +314,7 @@ static int pxa2xx_ac97_probe(struct platform_device *pdev)
 		ac97_clk = NULL;
 		goto err_irq;
 	}
+	clk_enable(ac97_clk);
 	return 0;
 
  err_irq:
-- 
1.5.5
