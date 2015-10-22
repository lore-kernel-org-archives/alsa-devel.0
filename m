From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: h1940_uda1380: Constify rate
	constraints" to the asoc tree
Date: Fri, 23 Oct 2015 08:57:05 +0900
Message-ID: <E1ZpPjF-0002oD-NF@finisterre>
References: <1445503403-22934-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 209F8266B0B
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:57:15 +0200 (CEST)
In-Reply-To: <1445503403-22934-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: h1940_uda1380: Constify rate constraints

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

>From de687fb133f7ede18f026feefbeab3106081148d Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Thu, 22 Oct 2015 10:43:21 +0200
Subject: [PATCH] ASoC: h1940_uda1380: Constify rate constraints

The rate constraints in this board driver are not modified at runtime, so
make them const.

While we are at it also remove the unnecessary 0 initializer for the mask
field.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/h1940_uda1380.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/samsung/h1940_uda1380.c b/sound/soc/samsung/h1940_uda1380.c
index c72e9fb..5f5825f 100644
--- a/sound/soc/samsung/h1940_uda1380.c
+++ b/sound/soc/samsung/h1940_uda1380.c
@@ -26,16 +26,15 @@
 #include <mach/gpio-samsung.h>
 #include "s3c24xx-i2s.h"
 
-static unsigned int rates[] = {
+static const unsigned int rates[] = {
 	11025,
 	22050,
 	44100,
 };
 
-static struct snd_pcm_hw_constraint_list hw_rates = {
+static const struct snd_pcm_hw_constraint_list hw_rates = {
 	.count = ARRAY_SIZE(rates),
 	.list = rates,
-	.mask = 0,
 };
 
 static struct snd_soc_jack hp_jack;
-- 
2.6.1
