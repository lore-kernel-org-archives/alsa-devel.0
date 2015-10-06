From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tas2552: fix dBscale-min declaration" to the asoc tree
Date: Tue, 06 Oct 2015 11:56:07 +0100
Message-ID: <E1ZjPuh-0005Gs-W9@finisterre>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: 
Sender: stable-owner@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tas2552: fix dBscale-min declaration

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

>From e2600460bc3aa14ca1df86318a327cbbabedf9a8 Mon Sep 17 00:00:00 2001
From: Andreas Dannenberg <dannenberg@ti.com>
Date: Mon, 5 Oct 2015 15:00:14 -0500
Subject: [PATCH] ASoC: tas2552: fix dBscale-min declaration

The minimum volume level for the TAS2552 (control register value 0x00)
is -7dB however the driver declares it as -0.07dB.

Running amixer before the patch reports:
dBscale-min=-0.07dB,step=1.00dB,mute=0

Running amixer with the patch applied reports:
dBscale-min=-7.00dB,step=1.00dB,mute=0

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/tas2552.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index e3a0bca..cc1d398 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -549,7 +549,7 @@ static struct snd_soc_dai_driver tas2552_dai[] = {
 /*
  * DAC digital volumes. From -7 to 24 dB in 1 dB steps
  */
-static DECLARE_TLV_DB_SCALE(dac_tlv, -7, 100, 0);
+static DECLARE_TLV_DB_SCALE(dac_tlv, -700, 100, 0);
 
 static const char * const tas2552_din_source_select[] = {
 	"Muted",
-- 
2.5.0
