From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5659: Remove the routing path of the
	power widget "LDO2"" to the asoc tree
Date: Mon, 12 Feb 2018 12:52:22 +0000
Message-ID: <E1elDao-0006Ws-SB@debutante>
References: <1517826596-17864-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E5932268160
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:52:27 +0100 (CET)
In-Reply-To: <1517826596-17864-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, spujar@nvidia.com, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5659: Remove the routing path of the power widget "LDO2"

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

>From b44483eff7fb3b8c96ee763fe4e84c7933882709 Mon Sep 17 00:00:00 2001
From: "oder_chiou@realtek.com" <oder_chiou@realtek.com>
Date: Mon, 5 Feb 2018 18:29:55 +0800
Subject: [PATCH] ASoC: rt5659: Remove the routing path of the power widget
 "LDO2"

This patch removes the routing path of the power widget "LDO2", and it
should be depended on the hardware design. The power widget "LDO2" should
add the routing path with the MICBIAS in the machine driver that is
reasonable.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5659.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index dbc7dbfe8c6f..c4a704e9a4db 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -2873,11 +2873,6 @@ static const struct snd_soc_dapm_route rt5659_dapm_routes[] = {
 	{ "I2S2", NULL, "I2S2 ASRC" },
 	{ "I2S3", NULL, "I2S3 ASRC" },
 
-	{ "IN1P", NULL, "LDO2" },
-	{ "IN2P", NULL, "LDO2" },
-	{ "IN3P", NULL, "LDO2" },
-	{ "IN4P", NULL, "LDO2" },
-
 	{ "DMIC1", NULL, "DMIC L1" },
 	{ "DMIC1", NULL, "DMIC R1" },
 	{ "DMIC2", NULL, "DMIC L2" },
-- 
2.16.1
