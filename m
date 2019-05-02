From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Use DSP ops pointers to stop
	watchdog in error handlers" to the asoc tree
Date: Thu,  2 May 2019 03:18:01 +0100 (BST)
Message-ID: <20190502021801.E0AC1441D3E@finisterre.ee.mobilebroadband>
References: <20190501101332.31190-2-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A194BF80722
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2019 04:18:06 +0200 (CEST)
In-Reply-To: <20190501101332.31190-2-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Use DSP ops pointers to stop watchdog in error handlers

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From 81ed884501a59a49c71cd810578f793f3890c131 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Wed, 1 May 2019 11:13:32 +0100
Subject: [PATCH] ASoC: wm_adsp: Use DSP ops pointers to stop watchdog in error
 handlers

Whilst this isn't strictly necessary as the code is already DSP specific
better to use the pointers to avoid potential issues in the future if
one core ends up having multiple methods of stopping the watchdog.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index a9298bfddd9c..bb10c4aeceb4 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -4285,7 +4285,7 @@ irqreturn_t wm_adsp2_bus_error(struct wm_adsp *dsp)
 
 	if (val & ADSP2_WDT_TIMEOUT_STS_MASK) {
 		adsp_err(dsp, "watchdog timeout error\n");
-		wm_adsp_stop_watchdog(dsp);
+		dsp->ops->stop_watchdog(dsp);
 		wm_adsp_fatal_error(dsp);
 	}
 
@@ -4396,7 +4396,7 @@ irqreturn_t wm_halo_wdt_expire(int irq, void *data)
 	mutex_lock(&dsp->pwr_lock);
 
 	adsp_warn(dsp, "WDT Expiry Fault\n");
-	wm_halo_stop_watchdog(dsp);
+	dsp->ops->stop_watchdog(dsp);
 	wm_adsp_fatal_error(dsp);
 
 	mutex_unlock(&dsp->pwr_lock);
-- 
2.20.1
