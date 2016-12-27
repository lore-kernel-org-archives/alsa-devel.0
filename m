From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 2/2] ASoC: rt5645: set high voltage for capless
	power
Date: Tue, 27 Dec 2016 12:05:06 +0800
Message-ID: <1482811506-6447-2-git-send-email-bardliao@realtek.com>
References: <1482811506-6447-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id D8E03266726
 for <alsa-devel@alsa-project.org>; Tue, 27 Dec 2016 05:09:43 +0100 (CET)
In-Reply-To: <1482811506-6447-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, pierre-louis.bossart@linux.intel.com, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The default capless power mode is low voltage mode. We should set
it to high voltage mode to get fair headphone performance.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 1ac96ef..37fb2b6 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3109,7 +3109,7 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 	unsigned int val;
 
 	if (jack_insert) {
-		regmap_write(rt5645->regmap, RT5645_CHARGE_PUMP, 0x0006);
+		regmap_write(rt5645->regmap, RT5645_CHARGE_PUMP, 0x0e06);
 
 		/* for jack type detect */
 		snd_soc_dapm_force_enable_pin(dapm, "LDO2");
-- 
1.8.1.1.439.g50a6b54
