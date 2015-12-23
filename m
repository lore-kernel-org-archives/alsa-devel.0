From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7219: Update REFERENCES reg default,
	in-line with HW" to the asoc tree
Date: Wed, 23 Dec 2015 00:12:18 +0000
Message-ID: <E1aBX2Q-0008Mx-A2@debutante>
References: <5233faeef4073f33e2826866eae35e8c9502c35f.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 89E37266029
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 01:12:24 +0100 (CET)
In-Reply-To: <5233faeef4073f33e2826866eae35e8c9502c35f.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7219: Update REFERENCES reg default, in-line with HW

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

>From 9ff099790412cb46536efba02039b36d81300976 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 22 Dec 2015 18:27:53 +0000
Subject: [PATCH] ASoC: da7219: Update REFERENCES reg default, in-line with HW

In current AB silicon, BIAS_EN field is enabled by default in the
REFERENCES register, so the regmap default value should reflect
this.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7219.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 9136a8b6f593..0a177ae8e0c3 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1788,7 +1788,7 @@ static struct reg_default da7219_reg_defaults[] = {
 	{ DA7219_DIG_ROUTING_DAC, 0x32 },
 	{ DA7219_DAI_OFFSET_LOWER, 0x00 },
 	{ DA7219_DAI_OFFSET_UPPER, 0x00 },
-	{ DA7219_REFERENCES, 0x00 },
+	{ DA7219_REFERENCES, 0x08 },
 	{ DA7219_MIXIN_L_SELECT, 0x00 },
 	{ DA7219_MIXIN_L_GAIN, 0x03 },
 	{ DA7219_ADC_L_GAIN, 0x6F },
-- 
2.6.2
