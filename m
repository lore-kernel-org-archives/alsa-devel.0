From: John Lin <john.lin@realtek.com>
Subject: [PATCH] ASoC: rt5645: fix kernel hang when call
	rt5645_set_jack_detect()
Date: Mon, 18 May 2015 10:34:03 +0800
Message-ID: <1431916443-22588-1-git-send-email-john.lin@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 76B0E26043A
 for <alsa-devel@alsa-project.org>; Mon, 18 May 2015 04:34:19 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, zhengxing@rock-chips.com, yang.a.fang@intel.com, koro.chen@mediatek.com, john.lin@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

rt5645_set_jack_detect() is usually called from
snd_soc_dai_link.init() and it calls snd_soc_jack_report() from
rt5645_irq_detection() if jack is inserted. snd_soc_jack_report()
results in kernel hang if it is called from a context which cannot
sleep.
This patch makes sure snd_soc_jack_report() is called from
workqueue. It can fix the kernel hang issue.

Signed-off-by: John Lin <john.lin@realtek.com>
---
 sound/soc/codecs/rt5645.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 14b12c5..aaede45 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2876,6 +2876,7 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 }
 
 static int rt5645_irq_detection(struct rt5645_priv *rt5645);
+static irqreturn_t rt5645_irq(int irq, void *data);
 
 int rt5645_set_jack_detect(struct snd_soc_codec *codec,
 	struct snd_soc_jack *hp_jack, struct snd_soc_jack *mic_jack,
@@ -2895,7 +2896,7 @@ int rt5645_set_jack_detect(struct snd_soc_codec *codec,
 		regmap_update_bits(rt5645->regmap, RT5645_GEN_CTRL1,
 				RT5645_DIG_GATE_CTRL, RT5645_DIG_GATE_CTRL);
 	}
-	rt5645_irq_detection(rt5645);
+	rt5645_irq(0, rt5645);
 
 	return 0;
 }
-- 
1.8.1.1.439.g50a6b54
