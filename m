From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cq93vc: remove MFD_DAVINCI_VOICECODEC
	dependency from CQ0093VC" to the asoc tree
Date: Wed, 25 Jan 2017 21:06:30 +0000
Message-ID: <E1cWUly-0008Qy-Sp@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B47A7266F1B
 for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2017 22:06:40 +0100 (CET)
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
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cq93vc: remove MFD_DAVINCI_VOICECODEC dependency from CQ0093VC

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

>From 31489c0b1d8b33e5b696ba18feb880617e937554 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 25 Jan 2017 00:51:04 +0000
Subject: [PATCH] ASoC: cq93vc: remove MFD_DAVINCI_VOICECODEC dependency from
 CQ0093VC

CQ0093VC is no longer dependent on MFD_DAVINCI_VOICECODEC,
let's remove it. Otherwise, we can't compile it by COMPILE_TEST
on non-DAVINCE platform

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 9e1718a8cb1c..928baa69de91 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -45,7 +45,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_ALC5623 if I2C
 	select SND_SOC_ALC5632 if I2C
 	select SND_SOC_BT_SCO
-	select SND_SOC_CQ0093VC if MFD_DAVINCI_VOICECODEC
+	select SND_SOC_CQ0093VC
 	select SND_SOC_CS35L32 if I2C
 	select SND_SOC_CS35L33 if I2C
 	select SND_SOC_CS35L34 if I2C
-- 
2.11.0
