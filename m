From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl-mpc5200: Use usleep_range() instead
	of msleep()" to the asoc tree
Date: Fri, 22 Jan 2016 18:26:52 +0000
Message-ID: <E1aMgQ8-0004Bz-8c@debutante>
References: <1452857725-32414-3-git-send-email-lixiubo@cmss.chinamobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B40B0261569
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 19:26:57 +0100 (CET)
In-Reply-To: <1452857725-32414-3-git-send-email-lixiubo@cmss.chinamobile.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <lixiubo@cmss.chinamobile.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl-mpc5200: Use usleep_range() instead of msleep()

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

>From 0d55ad456337487e8cdb72acdd520050e575a0bd Mon Sep 17 00:00:00 2001
From: Xiubo Li <lixiubo@cmss.chinamobile.com>
Date: Fri, 15 Jan 2016 19:35:25 +0800
Subject: [PATCH] ASoC: fsl-mpc5200: Use usleep_range() instead of msleep()

Since msleep() will sleep longer than intended time for values less
than 20ms, this patch allows the use of usleep_range for just 1ms.
usleep_range is a finer precision implementation of msleep and is
designed to be a drop-in replacement for udelay where a precise
sleep/busy-wait is unnecessary.

More details see Documentation/timers/timers-howto.txt.

Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/mpc5200_psc_ac97.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_ac97.c
index 0bab76051fd8..243700cc29e6 100644
--- a/sound/soc/fsl/mpc5200_psc_ac97.c
+++ b/sound/soc/fsl/mpc5200_psc_ac97.c
@@ -13,6 +13,7 @@
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
 #include <linux/delay.h>
+#include <linux/time.h>
 
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -127,7 +128,7 @@ static void psc_ac97_cold_reset(struct snd_ac97 *ac97)
 
 	mutex_unlock(&psc_dma->mutex);
 
-	msleep(1);
+	usleep_range(1000, 2000);
 	psc_ac97_warm_reset(ac97);
 }
 
-- 
2.7.0.rc3
