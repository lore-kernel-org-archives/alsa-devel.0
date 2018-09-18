From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: remove redundant include" to the asoc
	tree
Date: Tue, 18 Sep 2018 18:45:43 +0100 (BST)
Message-ID: <20180918174543.A3884440078@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 491812678B0
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2018 19:45:49 +0200 (CEST)
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
To: zhong jiang <zhongjiang@huawei.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.cirrus.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: remove redundant include

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

>From 29ca7d32d7f10737e8d165fcf40fe31d44b06bee Mon Sep 17 00:00:00 2001
From: zhong jiang <zhongjiang@huawei.com>
Date: Tue, 18 Sep 2018 16:16:24 +0800
Subject: [PATCH] ASoC: remove redundant include

module.h already contained moduleparam.h,  so it is safe to remove
the redundant include.

The issue is detected with the help of Coccinelle.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5651.c | 1 -
 sound/soc/codecs/wm8904.c | 1 -
 sound/soc/codecs/wm8974.c | 1 -
 sound/soc/soc-dapm.c      | 1 -
 4 files changed, 4 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 985852fd9723..b613103d801b 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -10,7 +10,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 1965635ec07c..2a3e5fbd04e4 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -13,7 +13,6 @@
 
 #include <linux/clk.h>
 #include <linux/module.h>
-#include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index 43edaf8cd276..593a11960888 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -11,7 +11,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 43983c69f6aa..ee6b9758ec15 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -18,7 +18,6 @@
 //      device reopen.
 
 #include <linux/module.h>
-#include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/async.h>
 #include <linux/delay.h>
-- 
2.19.0
