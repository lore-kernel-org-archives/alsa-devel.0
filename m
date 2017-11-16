From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8824: condition for clock disable"
	to the asoc tree
Date: Thu, 16 Nov 2017 19:28:55 +0000 (GMT)
Message-ID: <20171116192855.7150D44005B@finisterre.ee.mobilebroadband>
References: <1510045593-21477-2-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3233E26778C
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 20:28:56 +0100 (CET)
In-Reply-To: <1510045593-21477-2-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, WTLI@nuvoton.com, lgirdwood@gmail.com, YHCHuang@nuvoton.com, broonie@kernel.org, CTLIN0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8824: condition for clock disable

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

>From a2eb62edbd01064cee0c4c00854a25f04237605b Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Tue, 7 Nov 2017 17:06:33 +0800
Subject: [PATCH] ASoC: nau8824: condition for clock disable

There are headphone and speaker outputs in NAU88L24. During the
playback, the codec should not change the clock status when
switching these outputs.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8824.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index b7b63ac037a7..8a9a9939827e 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -811,7 +811,8 @@ static void nau8824_eject_jack(struct nau8824 *nau8824)
 		NAU8824_JD_SLEEP_MODE, NAU8824_JD_SLEEP_MODE);
 
 	/* Close clock for jack type detection at manual mode */
-	nau8824_config_sysclk(nau8824, NAU8824_CLK_DIS, 0);
+	if (dapm->bias_level < SND_SOC_BIAS_PREPARE)
+		nau8824_config_sysclk(nau8824, NAU8824_CLK_DIS, 0);
 }
 
 static void nau8824_jdet_work(struct work_struct *work)
@@ -862,7 +863,8 @@ static void nau8824_setup_auto_irq(struct nau8824 *nau8824)
 	regmap_update_bits(regmap, NAU8824_REG_INTERRUPT_SETTING,
 		NAU8824_IRQ_EJECT_DIS, 0);
 	/* Enable internal VCO needed for interruptions */
-	nau8824_config_sysclk(nau8824, NAU8824_CLK_INTERNAL, 0);
+	if (nau8824->dapm->bias_level < SND_SOC_BIAS_PREPARE)
+		nau8824_config_sysclk(nau8824, NAU8824_CLK_INTERNAL, 0);
 	regmap_update_bits(regmap, NAU8824_REG_ENA_CTRL,
 		NAU8824_JD_SLEEP_MODE, 0);
 }
-- 
2.14.1
