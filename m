From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 2/2] ASoC: atmel-pdmic: Fix typos in comments
	and error messages
Date: Tue, 16 Aug 2016 16:56:18 +0200
Message-ID: <1471359378-9122-2-git-send-email-pmeerw@pmeerw.net>
References: <1471359378-9122-1-git-send-email-pmeerw@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pmeerw.net (ns.pmeerw.net [84.19.176.92])
 by alsa0.perex.cz (Postfix) with ESMTP id 421632666BD
 for <alsa-devel@alsa-project.org>; Tue, 16 Aug 2016 16:56:23 +0200 (CEST)
In-Reply-To: <1471359378-9122-1-git-send-email-pmeerw@pmeerw.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Songjun Wu <songjun.wu@atmel.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Peter Meerwald-Stadler <pmeerw@pmeerw.net>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Songjun Wu <songjun.wu@atmel.com>
---
 sound/soc/atmel/atmel-pdmic.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/atmel/atmel-pdmic.c b/sound/soc/atmel/atmel-pdmic.c
index 5f56da6..70e8bdc 100644
--- a/sound/soc/atmel/atmel-pdmic.c
+++ b/sound/soc/atmel/atmel-pdmic.c
@@ -80,7 +80,7 @@ static struct atmel_pdmic_pdata *atmel_pdmic_dt_init(struct device *dev)
 
 	if (pdata->mic_max_freq < pdata->mic_min_freq) {
 		dev_err(dev,
-			"mic-max-freq should not less than mic-min-freq\n");
+			"mic-max-freq should not be less than mic-min-freq\n");
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -596,7 +596,7 @@ static int atmel_pdmic_probe(struct platform_device *pdev)
 	dd->irq = platform_get_irq(pdev, 0);
 	if (dd->irq < 0) {
 		ret = dd->irq;
-		dev_err(dev, "failed to could not get irq: %d\n", ret);
+		dev_err(dev, "failed to get irq: %d\n", ret);
 		return ret;
 	}
 
@@ -614,7 +614,7 @@ static int atmel_pdmic_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/* The gclk clock frequency must always be tree times
+	/* The gclk clock frequency must always be three times
 	 * lower than the pclk clock frequency
 	 */
 	ret = clk_set_rate(dd->gclk, clk_get_rate(dd->pclk)/3);
@@ -649,7 +649,7 @@ static int atmel_pdmic_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/* Get the minimal and maximal sample rate that micphone supports */
+	/* Get the minimal and maximal sample rate that the microphone supports */
 	atmel_pdmic_get_sample_rate(dd, &rate_min, &rate_max);
 
 	/* register cpu dai */
-- 
1.7.10.4
