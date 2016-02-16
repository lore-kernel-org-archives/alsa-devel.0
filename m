From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 2/3] ASoC: rt298: clear IRQ at the beginning of
	rt298_irq
Date: Tue, 16 Feb 2016 17:12:35 +0800
Message-ID: <1455613956-14287-2-git-send-email-bardliao@realtek.com>
References: <1455613956-14287-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A867265715
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 10:12:52 +0100 (CET)
In-Reply-To: <1455613956-14287-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, john.lin@realtek.com, ramesh.babu@intel.com, Bard Liao <bardliao@realtek.com>, senthilnathanx.veppur@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The IRQ pin will go from high to low when the irq bit is clear.
To let the IRQ pin go low as early as possible, move the clear
irq bit function to the beginning of irq handler.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt298.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index e67ef5f..58bc134 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -961,11 +961,11 @@ static irqreturn_t rt298_irq(int irq, void *data)
 	bool mic = false;
 	int ret, status = 0;
 
-	ret = rt298_jack_detect(rt298, &hp, &mic);
-
 	/* Clear IRQ */
 	regmap_update_bits(rt298->regmap, RT298_IRQ_CTRL, 0x1, 0x1);
 
+	ret = rt298_jack_detect(rt298, &hp, &mic);
+
 	if (ret == 0) {
 		if (hp == true)
 			status |= SND_JACK_HEADPHONE;
-- 
1.8.1.1.439.g50a6b54
