From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8824: move key irq after jd done" to
	the asoc tree
Date: Thu, 16 Nov 2017 19:29:22 +0000 (GMT)
Message-ID: <20171116192922.2DBCF44005B@finisterre.ee.mobilebroadband>
References: <1510045593-21477-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1921C2677A6
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 20:29:22 +0100 (CET)
In-Reply-To: <1510045593-21477-1-git-send-email-KCHSU0@nuvoton.com>
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

   ASoC: nau8824: move key irq after jd done

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

>From cf6b68d192138d67b49002b499eb507af0c8c56d Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Tue, 7 Nov 2017 17:06:32 +0800
Subject: [PATCH] ASoC: nau8824: move key irq after jd done

It is possible to get the fake key press interruption when the codec
do jack detection. We think it's proper to move the key interruption
configuration after jack detection done.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8824.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index 0240759f951c..b7b63ac037a7 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -843,6 +843,11 @@ static void nau8824_jdet_work(struct work_struct *work)
 	event_mask |= SND_JACK_HEADSET;
 	snd_soc_jack_report(nau8824->jack, event, event_mask);
 
+	/* Enable short key press and release interruption. */
+	regmap_update_bits(regmap, NAU8824_REG_INTERRUPT_SETTING,
+		NAU8824_IRQ_KEY_RELEASE_DIS |
+		NAU8824_IRQ_KEY_SHORT_PRESS_DIS, 0);
+
 	nau8824_sema_release(nau8824);
 }
 
@@ -850,13 +855,12 @@ static void nau8824_setup_auto_irq(struct nau8824 *nau8824)
 {
 	struct regmap *regmap = nau8824->regmap;
 
-	/* Enable jack ejection, short key press and release interruption. */
+	/* Enable jack ejection interruption. */
 	regmap_update_bits(regmap, NAU8824_REG_INTERRUPT_SETTING_1,
 		NAU8824_IRQ_INSERT_EN | NAU8824_IRQ_EJECT_EN,
 		NAU8824_IRQ_EJECT_EN);
 	regmap_update_bits(regmap, NAU8824_REG_INTERRUPT_SETTING,
-		NAU8824_IRQ_EJECT_DIS | NAU8824_IRQ_KEY_RELEASE_DIS |
-		NAU8824_IRQ_KEY_SHORT_PRESS_DIS, 0);
+		NAU8824_IRQ_EJECT_DIS, 0);
 	/* Enable internal VCO needed for interruptions */
 	nau8824_config_sysclk(nau8824, NAU8824_CLK_INTERNAL, 0);
 	regmap_update_bits(regmap, NAU8824_REG_ENA_CTRL,
-- 
2.14.1
