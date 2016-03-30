From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8960: Depends on I2C" to the asoc tree
Date: Wed, 30 Mar 2016 11:07:13 -0700
Message-ID: <E1alKWP-0006Yh-8F@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 16EEE265011
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 20:07:20 +0200 (CEST)
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
To: kbuild test robot <fengguang.wu@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8960: Depends on I2C

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

>From 3fcdfc9dad07c2a6ea19dfb98a2151cd86d06c6a Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Wed, 30 Mar 2016 11:02:49 -0700
Subject: [PATCH] ASoC: wm8960: Depends on I2C

Now that this is directly user selectable it needs to care about its
dependencies.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 196101b2eab5..3ebf29bc87d3 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -910,6 +910,7 @@ config SND_SOC_WM8955
 
 config SND_SOC_WM8960
 	tristate "Wolfson Microelectronics WM8960 CODEC"
+	depends on I2C
 
 config SND_SOC_WM8961
 	tristate
-- 
2.8.0.rc3
