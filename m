From: Mark Brown <broonie@kernel.org>
Subject: Applied "MAINTAINERS: update sound/soc/intel
	maintainers" to the asoc tree
Date: Thu, 17 May 2018 17:40:57 +0100 (BST)
Message-ID: <20180517164057.EA3AA44007E@finisterre.ee.mobilebroadband>
References: <20180516194901.8128-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AF8B22676C7
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 18:41:09 +0200 (CEST)
In-Reply-To: <20180516194901.8128-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, Keyon Jie <yang.jie@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>
List-Id: alsa-devel@alsa-project.org

The patch

   MAINTAINERS: update sound/soc/intel maintainers

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

>From c90ddb69d4b24bc32edf9c7bcfec85e52427d1c1 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Wed, 16 May 2018 14:48:49 -0500
Subject: [PATCH] MAINTAINERS: update sound/soc/intel maintainers

The information for Intel SoC drivers was not updated for several
years. Add myself, Liam and Keyon (Jie) as maintainers to get notified
of contributions and bug reports. As discussed with Mark and Takashi,
I'll also monitor alsa-devel and ack Intel patches as necessary.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b62e6cf6b1c..fc29793c2f67 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7004,14 +7004,13 @@ L:	linux-fbdev@vger.kernel.org
 S:	Maintained
 F:	drivers/video/fbdev/i810/
 
-INTEL ASoC BDW/HSW DRIVERS
+INTEL ASoC DRIVERS
+M:	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
+M:	Liam Girdwood <liam.r.girdwood@linux.intel.com>
 M:	Jie Yang <yang.jie@linux.intel.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
-F:	sound/soc/intel/common/sst-dsp*
-F:	sound/soc/intel/common/sst-firmware.c
-F:	sound/soc/intel/boards/broadwell.c
-F:	sound/soc/intel/haswell/
+F:	sound/soc/intel/
 
 INTEL C600 SERIES SAS CONTROLLER DRIVER
 M:	Intel SCU Linux support <intel-linux-scu@intel.com>
-- 
2.17.0
