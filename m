From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH 2/2] ASoC: nau8824: condition for clock disable
Date: Tue, 7 Nov 2017 17:06:33 +0800
Message-ID: <1510045593-21477-2-git-send-email-KCHSU0@nuvoton.com>
References: <1510045593-21477-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 177DD26735A
 for <alsa-devel@alsa-project.org>; Tue,  7 Nov 2017 10:06:38 +0100 (CET)
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
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, WTLI@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, YHCHuang@nuvoton.com, CTLIN0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

There are headphone and speaker outputs in NAU88L24. During the
playback, the codec should not change the clock status when
switching these outputs.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8824.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index b7b63ac..8a9a993 100644
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
2.6.4
