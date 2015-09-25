From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: db1200: Fix DAI link format for db1300 and db1550" to the asoc tree
Date: Fri, 25 Sep 2015 09:55:24 -0700
Message-ID: <E1ZfWHM-0001QA-MH@finisterre>
References: <55ED7AF2.1050800@metafoo.de>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <55ED7AF2.1050800@metafoo.de>
Sender: stable-owner@vger.kernel.org
To: Manuel Lauss <manuel.lauss@gmail.com>Manuel Lauss <manuel.lauss@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: db1200: Fix DAI link format for db1300 and db1550

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

>From e74679b38c9417c1c524081121cdcdb36f82264d Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Fri, 25 Sep 2015 11:07:04 +0200
Subject: [PATCH] ASoC: db1200: Fix DAI link format for db1300 and db1550

Commit b4508d0f95fa ("ASoC: db1200: Use static DAI format setup") switched
the db1200 driver over to using static DAI format setup instead of a
callback function. But the commit only added the dai_fmt field to one of
the three DAI links in the driver. This breaks audio on db1300 and db1550.

Add the two missing dai_fmt settings to fix the issue.

Fixes: b4508d0f95fa ("ASoC: db1200: Use static DAI format setup")
Reported-by: Manuel Lauss <manuel.lauss@gmail.com>
Tested-by: Manuel Lauss <manuel.lauss@gmail.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/au1x/db1200.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index 58c3164..8c907eb 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -129,6 +129,8 @@ static struct snd_soc_dai_link db1300_i2s_dai = {
 	.cpu_dai_name	= "au1xpsc_i2s.2",
 	.platform_name	= "au1xpsc-pcm.2",
 	.codec_name	= "wm8731.0-001b",
+	.dai_fmt	= SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_NB_NF |
+			  SND_SOC_DAIFMT_CBM_CFM,
 	.ops		= &db1200_i2s_wm8731_ops,
 };
 
@@ -146,6 +148,8 @@ static struct snd_soc_dai_link db1550_i2s_dai = {
 	.cpu_dai_name	= "au1xpsc_i2s.3",
 	.platform_name	= "au1xpsc-pcm.3",
 	.codec_name	= "wm8731.0-001b",
+	.dai_fmt	= SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_NB_NF |
+			  SND_SOC_DAIFMT_CBM_CFM,
 	.ops		= &db1200_i2s_wm8731_ops,
 };
 
-- 
2.5.0
