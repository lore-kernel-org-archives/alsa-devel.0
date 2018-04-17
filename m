From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt1305: fix ACPI_PTR compile error" to
	the asoc tree
Date: Tue, 17 Apr 2018 11:31:01 +0100
Message-ID: <E1f8Nt7-0006i9-3p@debutante>
References: <1523930882-17730-1-git-send-email-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A605A2673E1
 for <alsa-devel@alsa-project.org>; Tue, 17 Apr 2018 12:31:12 +0200 (CEST)
In-Reply-To: <1523930882-17730-1-git-send-email-shumingf@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shuming Fan <shumingf@realtek.com>
Cc: oder_chiou@realtek.com, Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, lars@metafoo.de, jack.yu@realtek.com, lgirdwood@gmail.com, broonie@kernel.org, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt1305: fix ACPI_PTR compile error

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 816cabd8d472d2e1b7daad2838eb4ce5046f03bb Mon Sep 17 00:00:00 2001
From: Shuming Fan <shumingf@realtek.com>
Date: Tue, 17 Apr 2018 10:08:02 +0800
Subject: [PATCH] ASoC: rt1305: fix ACPI_PTR compile error

This patch added <linux/acpi.h> header

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Shuming Fan <shumingf@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt1305.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt1305.c b/sound/soc/codecs/rt1305.c
index 90baab91d11b..84043068c0b7 100644
--- a/sound/soc/codecs/rt1305.c
+++ b/sound/soc/codecs/rt1305.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
+#include <linux/acpi.h>
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
-- 
2.17.0
