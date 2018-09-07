From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98373: usleep_range() needs
	include/delay.h" to the asoc tree
Date: Fri,  7 Sep 2018 17:08:41 +0100 (BST)
Message-ID: <20180907160841.E234B1122A6D@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 42AE626777B
 for <alsa-devel@alsa-project.org>; Fri,  7 Sep 2018 18:08:42 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Grant Grundler <grundler@chromium.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98373: usleep_range() needs include/delay.h

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

>From 3004136b90bedc9e254ff659adb7a60299e9495e Mon Sep 17 00:00:00 2001
From: Grant Grundler <grundler@chromium.org>
Date: Thu, 6 Sep 2018 17:27:28 -0700
Subject: [PATCH] ASoC: max98373: usleep_range() needs include/delay.h

Commit ca917f9fe1a0fab added use of usleep_range() but not
the corresponding "include <linux/delay.h>". The result is
with Chrome OS won't build because warnings are forced
to be errors:
mnt/host/source/src/third_party/kernel/v4.4/sound/soc/codecs/max98373.c:734:2: error: implicit declaration of function 'usleep_range' [-Werror,-Wimplicit-function-declaration]
        usleep_range(10000, 11000);
        ^

Including delay.h "fixes" this.

Signed-off-by: Grant Grundler <grundler@chromium.org>
Reviewed-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98373.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index 1093f766d0d2..d6868c9a9ce6 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2017, Maxim Integrated
 
 #include <linux/acpi.h>
+#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
-- 
2.19.0.rc1
