From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: atmel-pdmic: Fix typos in comments and
	error messages" to the asoc tree
Date: Tue, 16 Aug 2016 19:43:41 +0100
Message-ID: <E1bZjKv-0002BU-NL@debutante>
References: <1471359378-9122-2-git-send-email-pmeerw@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 02CBF26683F
 for <alsa-devel@alsa-project.org>; Tue, 16 Aug 2016 20:43:55 +0200 (CEST)
In-Reply-To: <1471359378-9122-2-git-send-email-pmeerw@pmeerw.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com, Songjun Wu <songjun.wu@atmel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: atmel-pdmic: Fix typos in comments and error messages

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 032ca4a76fc3cc81801903aa2532f1e6bae94ca2 Mon Sep 17 00:00:00 2001
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Date: Tue, 16 Aug 2016 16:56:18 +0200
Subject: [PATCH] ASoC: atmel-pdmic: Fix typos in comments and error messages

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Songjun Wu <songjun.wu@atmel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/atmel-pdmic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/atmel/atmel-pdmic.c b/sound/soc/atmel/atmel-pdmic.c
index 8b4beb07ca43..bca7751a15fd 100644
--- a/sound/soc/atmel/atmel-pdmic.c
+++ b/sound/soc/atmel/atmel-pdmic.c
@@ -80,7 +80,7 @@ static struct atmel_pdmic_pdata *atmel_pdmic_dt_init(struct device *dev)
 
 	if (pdata->mic_max_freq < pdata->mic_min_freq) {
 		dev_err(dev,
-			"mic-max-freq should not less than mic-min-freq\n");
+			"mic-max-freq should not be less than mic-min-freq\n");
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -598,7 +598,7 @@ static int atmel_pdmic_probe(struct platform_device *pdev)
 	dd->irq = platform_get_irq(pdev, 0);
 	if (dd->irq < 0) {
 		ret = dd->irq;
-		dev_err(dev, "failed to could not get irq: %d\n", ret);
+		dev_err(dev, "failed to get irq: %d\n", ret);
 		return ret;
 	}
 
@@ -616,7 +616,7 @@ static int atmel_pdmic_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/* The gclk clock frequency must always be tree times
+	/* The gclk clock frequency must always be three times
 	 * lower than the pclk clock frequency
 	 */
 	ret = clk_set_rate(dd->gclk, clk_get_rate(dd->pclk)/3);
@@ -651,7 +651,7 @@ static int atmel_pdmic_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/* Get the minimal and maximal sample rate that micphone supports */
+	/* Get the minimal and maximal sample rate that the microphone supports */
 	atmel_pdmic_get_sample_rate(dd, &rate_min, &rate_max);
 
 	/* register cpu dai */
-- 
2.8.1
