From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5663: Change the dev getting function
	in rt5663_irq
Date: Mon, 25 Sep 2017 11:11:05 +0800
Message-ID: <1506309065-25802-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id BDA2F266B70
 for <alsa-devel@alsa-project.org>; Mon, 25 Sep 2017 05:11:16 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, alexlee@realtek.com, naveen.m@intel.com, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

In the irq handler "rt5663_irq", while the codec is not initialized,
rt5663->codec will be null, and it will cause the kernel panic in the debug
print enabled.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5663.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index 767f219..fcd1643 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -1827,7 +1827,8 @@ static irqreturn_t rt5663_irq(int irq, void *data)
 {
 	struct rt5663_priv *rt5663 = data;
 
-	dev_dbg(rt5663->codec->dev, "%s IRQ queue work\n", __func__);
+	dev_dbg(regmap_get_device(rt5663->regmap), "%s IRQ queue work\n",
+		__func__);
 
 	queue_delayed_work(system_wq, &rt5663->jack_detect_work,
 		msecs_to_jiffies(250));
-- 
2.7.4
