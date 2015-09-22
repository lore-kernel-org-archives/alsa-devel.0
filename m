From: Mark Brown <broonie@kernel.org>
Subject: Applied "MAINTAINERS: Update website and git repo for
	Wolfson Microelectronics" to the asoc tree
Date: Tue, 22 Sep 2015 09:35:01 -0700
Message-ID: <E1ZeQWz-0000Tz-43@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 455FD264ED4
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2015 18:35:40 +0200 (CEST)
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
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   MAINTAINERS: Update website and git repo for Wolfson Microelectronics

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

>From f0e03dbd2d61d991bdd2d76b4e84681fe3077176 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Tue, 22 Sep 2015 15:30:33 +0100
Subject: [PATCH] MAINTAINERS: Update website and git repo for Wolfson
 Microelectronics

Support for Wolfson Microelectronics devices is now part of Cirrus Logic
and the relevant parts of the old opensource.wolfsonmicro.com site have
moved to the Cirrus Logic GitHub area.

This patch updates the website and git repo links, and also removes an
obsolete website link for the voltage and current drivers.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ba7ab7..dffea21 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11239,7 +11239,6 @@ VOLTAGE AND CURRENT REGULATOR FRAMEWORK
 M:	Liam Girdwood <lgirdwood@gmail.com>
 M:	Mark Brown <broonie@kernel.org>
 L:	linux-kernel@vger.kernel.org
-W:	http://opensource.wolfsonmicro.com/node/15
 W:	http://www.slimlogic.co.uk/?p=48
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
 S:	Supported
@@ -11368,17 +11367,15 @@ WM97XX TOUCHSCREEN DRIVERS
 M:	Mark Brown <broonie@kernel.org>
 M:	Liam Girdwood <lrg@slimlogic.co.uk>
 L:	linux-input@vger.kernel.org
-T:	git git://opensource.wolfsonmicro.com/linux-2.6-touch
-W:	http://opensource.wolfsonmicro.com/node/7
+W:	https://github.com/CirrusLogic/linux-drivers/wiki
 S:	Supported
 F:	drivers/input/touchscreen/*wm97*
 F:	include/linux/wm97xx.h
 
 WOLFSON MICROELECTRONICS DRIVERS
 L:	patches@opensource.wolfsonmicro.com
-T:	git git://opensource.wolfsonmicro.com/linux-2.6-asoc
-T:	git git://opensource.wolfsonmicro.com/linux-2.6-audioplus
-W:	http://opensource.wolfsonmicro.com/content/linux-drivers-wolfson-devices
+T:	git https://github.com/CirrusLogic/linux-drivers.git
+W:	https://github.com/CirrusLogic/linux-drivers/wiki
 S:	Supported
 F:	Documentation/hwmon/wm83??
 F:	arch/arm/mach-s3c64xx/mach-crag6410*
-- 
2.5.0
