From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH 1/2] ASoC: nau8824: move key irq after jd done
Date: Tue, 7 Nov 2017 17:06:32 +0800
Message-ID: <1510045593-21477-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A27526735F
 for <alsa-devel@alsa-project.org>; Tue,  7 Nov 2017 10:06:38 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, WTLI@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, YHCHuang@nuvoton.com, CTLIN0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

It is possible to get the fake key press interruption when the codec
do jack detection. We think it's proper to move the key interruption
configuration after jack detection done.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8824.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index 0240759..b7b63ac 100644
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
2.6.4
