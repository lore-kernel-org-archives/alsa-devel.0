From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: bcm2835: cleanup includes by ordering
	them alphabetically" to the asoc tree
Date: Sun, 10 Jan 2016 12:50:45 +0000
Message-ID: <E1aIFSH-0001I2-MO@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 79C742605FF
 for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2016 13:50:56 +0100 (CET)
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
To: Martin Sperl <kernel@martin.sperl.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: bcm2835: cleanup includes by ordering them alphabetically

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

>From 7905f08247131ac5d5c0e2f057e0cf19da40e5da Mon Sep 17 00:00:00 2001
From: Martin Sperl <kernel@martin.sperl.org>
Date: Sat, 9 Jan 2016 09:25:53 +0000
Subject: [PATCH] ASoC: bcm2835: cleanup includes by ordering them
 alphabetically

Cleanup of includes so that they are ordered alphabetically.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/bcm/bcm2835-i2s.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
index 8c435beb263d..3303d5f58082 100644
--- a/sound/soc/bcm/bcm2835-i2s.c
+++ b/sound/soc/bcm/bcm2835-i2s.c
@@ -31,20 +31,20 @@
  * General Public License for more details.
  */
 
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/module.h>
-#include <linux/device.h>
 #include <linux/slab.h>
-#include <linux/delay.h>
-#include <linux/io.h>
-#include <linux/clk.h>
 
 #include <sound/core.h>
+#include <sound/dmaengine_pcm.h>
+#include <sound/initval.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
-#include <sound/initval.h>
 #include <sound/soc.h>
-#include <sound/dmaengine_pcm.h>
 
 /* Clock registers */
 #define BCM2835_CLK_PCMCTL_REG  0x00
-- 
2.7.0.rc3
