From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac-hdmi: make driver select
	CONFIG_HDMI" to the asoc tree
Date: Sun, 22 Nov 2015 13:24:46 +0000
Message-ID: <E1a0UdK-0002Ti-0P@finisterre>
References: <1448189698-8756-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7139026070E
 for <alsa-devel@alsa-project.org>; Sun, 22 Nov 2015 14:25:01 +0100 (CET)
In-Reply-To: <1448189698-8756-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kbuild test robot <fengguang.wu@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac-hdmi: make driver select CONFIG_HDMI

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

>From 96b96a743c65969ebf13c343837db2faff1a8a84 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Sun, 22 Nov 2015 16:24:58 +0530
Subject: [PATCH] ASoC: hdac-hdmi: make driver select CONFIG_HDMI

Since driver use infoframe symbols from video/hdmi.c we should select this
symbol for this driver

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index b2b0b71..5c584da 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -458,6 +458,7 @@ config SND_SOC_DMIC
 config SND_SOC_HDAC_HDMI
 	tristate
 	select SND_HDA_EXT_CORE
+	select HDMI
 
 config SND_SOC_ES8328
 	tristate "Everest Semi ES8328 CODEC"
-- 
2.6.1
