From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 1/2] ASoC: arizona: Set compressed IRQ to a
	wake source
Date: Wed, 20 Jun 2018 11:56:20 +0100
Message-ID: <20180620105621.2660-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 65318266D4C
 for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2018 12:56:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The current code is not setting the compressed IRQ as a wake
source.  Normally this doesn't cause any issues as the CODEC
IRQ is set as a wake source by the jack detection code and the
CODEC only produces a single IRQ line. However if the system
is not using jack detection the compressed audio IRQ should
still function as a wake source, as such directly set the
compressed audio IRQ as a wake source.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/cs47l24.c | 8 ++++++++
 sound/soc/codecs/wm5102.c  | 8 ++++++++
 sound/soc/codecs/wm5110.c  | 8 ++++++++
 3 files changed, 24 insertions(+)

diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index 196e9c343aeb..0da52ead91e0 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -1283,6 +1283,12 @@ static int cs47l24_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = arizona_set_irq_wake(arizona, ARIZONA_IRQ_DSP_IRQ1, 1);
+	if (ret != 0)
+		dev_warn(&pdev->dev,
+			 "Failed to set compressed IRQ as a wake source: %d\n",
+			 ret);
+
 	arizona_init_common(arizona);
 
 	ret = arizona_init_vol_limit(arizona);
@@ -1306,6 +1312,7 @@ static int cs47l24_probe(struct platform_device *pdev)
 err_spk_irqs:
 	arizona_free_spk_irqs(arizona);
 err_dsp_irq:
+	arizona_set_irq_wake(arizona, ARIZONA_IRQ_DSP_IRQ1, 0);
 	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, cs47l24);
 
 	return ret;
@@ -1323,6 +1330,7 @@ static int cs47l24_remove(struct platform_device *pdev)
 
 	arizona_free_spk_irqs(arizona);
 
+	arizona_set_irq_wake(arizona, ARIZONA_IRQ_DSP_IRQ1, 0);
 	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, cs47l24);
 
 	return 0;
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 1ac83388d1b8..a01a0c0e01eb 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -2094,6 +2094,12 @@ static int wm5102_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = arizona_set_irq_wake(arizona, ARIZONA_IRQ_DSP_IRQ1, 1);
+	if (ret != 0)
+		dev_warn(&pdev->dev,
+			 "Failed to set compressed IRQ as a wake source: %d\n",
+			 ret);
+
 	arizona_init_common(arizona);
 
 	ret = arizona_init_vol_limit(arizona);
@@ -2117,6 +2123,7 @@ static int wm5102_probe(struct platform_device *pdev)
 err_spk_irqs:
 	arizona_free_spk_irqs(arizona);
 err_dsp_irq:
+	arizona_set_irq_wake(arizona, ARIZONA_IRQ_DSP_IRQ1, 0);
 	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, wm5102);
 
 	return ret;
@@ -2133,6 +2140,7 @@ static int wm5102_remove(struct platform_device *pdev)
 
 	arizona_free_spk_irqs(arizona);
 
+	arizona_set_irq_wake(arizona, ARIZONA_IRQ_DSP_IRQ1, 0);
 	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, wm5102);
 
 	return 0;
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index fb9835dcd836..00c735c585d9 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2455,6 +2455,12 @@ static int wm5110_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = arizona_set_irq_wake(arizona, ARIZONA_IRQ_DSP_IRQ1, 1);
+	if (ret != 0)
+		dev_warn(&pdev->dev,
+			 "Failed to set compressed IRQ as a wake source: %d\n",
+			 ret);
+
 	arizona_init_common(arizona);
 
 	ret = arizona_init_vol_limit(arizona);
@@ -2478,6 +2484,7 @@ static int wm5110_probe(struct platform_device *pdev)
 err_spk_irqs:
 	arizona_free_spk_irqs(arizona);
 err_dsp_irq:
+	arizona_set_irq_wake(arizona, ARIZONA_IRQ_DSP_IRQ1, 0);
 	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, wm5110);
 
 	return ret;
@@ -2496,6 +2503,7 @@ static int wm5110_remove(struct platform_device *pdev)
 
 	arizona_free_spk_irqs(arizona);
 
+	arizona_set_irq_wake(arizona, ARIZONA_IRQ_DSP_IRQ1, 0);
 	arizona_free_irq(arizona, ARIZONA_IRQ_DSP_IRQ1, wm5110);
 
 	return 0;
-- 
2.11.0
