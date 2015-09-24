From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rl6347a: Clean up unneeded inclusion of
	header files" to the asoc tree
Date: Thu, 24 Sep 2015 13:41:35 -0700
Message-ID: <E1ZfDKh-0008IG-69@finisterre>
References: <1443108841.21872.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 404C7265A41
 for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2015 23:19:26 +0200 (CEST)
In-Reply-To: <1443108841.21872.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rl6347a: Clean up unneeded inclusion of header files

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

>From 0f7e17740612ca0f3b8baf91645075d07bb52b2c Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 24 Sep 2015 23:34:01 +0800
Subject: [PATCH] ASoC: rl6347a: Clean up unneeded inclusion of header files

Also move the include of sound/hda_verbs.h to rl6347a.h because it is used
in rl6347a.h.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rl6347a.c | 19 +------------------
 sound/soc/codecs/rl6347a.h |  2 ++
 sound/soc/codecs/rt286.c   |  1 -
 sound/soc/codecs/rt298.c   |  1 -
 4 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/rl6347a.c b/sound/soc/codecs/rl6347a.c
index 91d5166..a4b910e 100644
--- a/sound/soc/codecs/rl6347a.c
+++ b/sound/soc/codecs/rl6347a.c
@@ -11,25 +11,8 @@
  */
 
 #include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
-#include <linux/spi/spi.h>
-#include <linux/dmi.h>
-#include <linux/acpi.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/soc.h>
-#include <sound/soc-dapm.h>
-#include <sound/initval.h>
-#include <sound/tlv.h>
-#include <sound/jack.h>
-#include <linux/workqueue.h>
-#include <sound/hda_verbs.h>
+#include <linux/regmap.h>
 
 #include "rl6347a.h"
 
diff --git a/sound/soc/codecs/rl6347a.h b/sound/soc/codecs/rl6347a.h
index 1cb56e5..e127919 100644
--- a/sound/soc/codecs/rl6347a.h
+++ b/sound/soc/codecs/rl6347a.h
@@ -12,6 +12,8 @@
 #ifndef __RL6347A_H__
 #define __RL6347A_H__
 
+#include <sound/hda_verbs.h>
+
 #define VERB_CMD(V, N, D) ((N << 20) | (V << 8) | D)
 
 #define RL6347A_VENDOR_REGISTERS	0x20
diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index bd93658..1fbdb4f 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -29,7 +29,6 @@
 #include <sound/jack.h>
 #include <linux/workqueue.h>
 #include <sound/rt286.h>
-#include <sound/hda_verbs.h>
 
 #include "rl6347a.h"
 #include "rt286.h"
diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index 3c2f0f8..2a6c2ba 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -28,7 +28,6 @@
 #include <sound/jack.h>
 #include <linux/workqueue.h>
 #include <sound/rt298.h>
-#include <sound/hda_verbs.h>
 
 #include "rl6347a.h"
 #include "rt298.h"
-- 
2.5.0
