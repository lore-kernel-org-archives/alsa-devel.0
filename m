From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Update micdet for irqdomain
	conversion
Date: Wed, 18 Jul 2012 19:11:58 +0100
Message-ID: <1342635118-21119-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7020D260312
 for <alsa-devel@alsa-project.org>; Wed, 18 Jul 2012 20:21:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The conversion of the core driver to irqdomains means that we don't need
and irq_base to have working interrupts so use wm8994_request_irq() to
deal with looking up the interrupt number for the micdet IRQ.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index a4aafdb..235577a 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3692,9 +3692,6 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 
 	if (wm8994->pdata && wm8994->pdata->micdet_irq)
 		wm8994->micdet_irq = wm8994->pdata->micdet_irq;
-	else if (wm8994->pdata && wm8994->pdata->irq_base)
-		wm8994->micdet_irq = wm8994->pdata->irq_base +
-				     WM8994_IRQ_MIC1_DET;
 
 	pm_runtime_enable(codec->dev);
 	pm_runtime_idle(codec->dev);
@@ -3833,6 +3830,10 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 				dev_warn(codec->dev,
 					 "Failed to request Mic detect IRQ: %d\n",
 					 ret);
+		} else {
+			wm8994_request_irq(wm8994->wm8994, WM8994_IRQ_MIC1_DET,
+					   wm8958_mic_irq, "Mic detect",
+					   wm8994);
 		}
 	}
 
-- 
1.7.10.4
