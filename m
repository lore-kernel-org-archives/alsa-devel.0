From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cq93vc: remove MFD_DAVINCI_VOICECODEC dependency for CQ0093VC" to the asoc tree
Date: Mon, 05 Dec 2016 12:09:30 +0000
Message-ID: <E1cDs5K-0003md-2z@finisterre>
References: <8760oefb59.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8760oefb59.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Michael Trimarchi <michael@amarulasolutions.com>, Arnd Bergmann <arnd@arndb.de>, anish kumar <yesanishhere@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Jeremy McDermond <nh6z@nh6z.net>, Liam Girdwood <lgirdwood@gmail.com>, Jacob Siverskog <jacob@teenage.engineering>, Simon <horms@verge.net.au>, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, "Damien.Horsley" <Damien.Horsley@imgtec.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cq93vc: remove MFD_DAVINCI_VOICECODEC dependency for CQ0093VC

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

>From 4de429888c5b534f43a3d693e3627021b17e900c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 2 Dec 2016 04:01:22 +0000
Subject: [PATCH] ASoC: cq93vc: remove MFD_DAVINCI_VOICECODEC dependency for
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
index c67667bb970f..cb195b07e7d2 100644
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
 	select SND_SOC_CS42L51_I2C if I2C
-- 
2.10.2
