From: Mark Brown <broonie@kernel.org>
Subject: Applied "MAINTAINERS: Remove wm97xx entry" to the asoc
	tree
Date: Tue, 06 Oct 2015 12:22:15 +0100
Message-ID: <E1ZjQJz-0006Er-Ug@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AF6026548F
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 13:22:53 +0200 (CEST)
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
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   MAINTAINERS: Remove wm97xx entry

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

>From ff6afc8d0df0347901e862e622b1efaeb6f1fe5d Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Fri, 2 Oct 2015 18:07:09 +0100
Subject: [PATCH] MAINTAINERS: Remove wm97xx entry

Neither myself or Liam is especially interested in this driver any more
and the devices are already covered by the general ex-Wolfson entry so
just remove this.

Signed-off-by: Mark Brown <broonie@kernel.org>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 MAINTAINERS | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0581f47..07790df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11363,15 +11363,6 @@ W:	http://oops.ghostprotocols.net:81/blog
 S:	Maintained
 F:	drivers/net/wireless/wl3501*
 
-WM97XX TOUCHSCREEN DRIVERS
-M:	Mark Brown <broonie@kernel.org>
-M:	Liam Girdwood <lrg@slimlogic.co.uk>
-L:	linux-input@vger.kernel.org
-W:	https://github.com/CirrusLogic/linux-drivers/wiki
-S:	Supported
-F:	drivers/input/touchscreen/*wm97*
-F:	include/linux/wm97xx.h
-
 WOLFSON MICROELECTRONICS DRIVERS
 L:	patches@opensource.wolfsonmicro.com
 T:	git https://github.com/CirrusLogic/linux-drivers.git
-- 
2.5.0
