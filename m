From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: [PATCH 2/2] ASoC: pxa2xx-ac97: fix warning due to
	missing argument	in fuction declaration
Date: Tue, 8 Jul 2008 19:45:42 +0400
Message-ID: <20080708154542.GA6605@doriath.ww600.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 67CE524434
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Jul 2008 17:45:51 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id u40so1159418ugc.50
	for <alsa-devel@alsa-project.org>; Tue, 08 Jul 2008 08:45:51 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
---
 sound/soc/pxa/pxa2xx-ac97.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index b458667..ce1835e 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -356,7 +356,7 @@ static int pxa2xx_ac97_probe(struct platform_device *pdev,
 	return ret;
 }
 
-static void pxa2xx_ac97_remove(struct platform_device *pdev)
+static void pxa2xx_ac97_remove(struct platform_device *pdev, struct snd_soc_dai *dai)
 {
 	GCR |= GCR_ACLINK_OFF;
 	free_irq(IRQ_AC97, NULL);
-- 
1.5.6


-- 
With best wishes
Dmitry
