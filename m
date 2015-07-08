From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm0010: Remove spurious missing
	IRQF_ONESHOT" to the asoc tree
Date: Wed, 08 Jul 2015 19:50:57 +0100
Message-ID: <E1ZCuQr-0004tX-38@debutante>
References: <1435843604.17967.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 00C0C2650AF
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 20:51:06 +0200 (CEST)
In-Reply-To: <1435843604.17967.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm0010: Remove spurious missing IRQF_ONESHOT

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

>From 030e6ee241f0586308622bcdd273a317976b3169 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 2 Jul 2015 21:26:44 +0800
Subject: [PATCH] ASoC: wm0010: Remove spurious missing IRQF_ONESHOT

This reverts 58d468328646 ("ASoC: wm0010: Add missing IRQF_ONESHOT").

The coccinelle warnings is false positive because the original code does
set IRQF_ONESHOT by "trigger |= IRQF_ONESHOT;".

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm0010.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index e1da49f39334..f2c6ad4b8fde 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -953,7 +953,7 @@ static int wm0010_spi_probe(struct spi_device *spi)
 		trigger = IRQF_TRIGGER_FALLING;
 	trigger |= IRQF_ONESHOT;
 
-	ret = request_threaded_irq(irq, NULL, wm0010_irq, trigger | IRQF_ONESHOT,
+	ret = request_threaded_irq(irq, NULL, wm0010_irq, trigger,
 				   "wm0010", wm0010);
 	if (ret) {
 		dev_err(wm0010->dev, "Failed to request IRQ %d: %d\n",
-- 
2.1.4
