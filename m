From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5645: Use the mod_delayed_work instead
	of the queue_delayed_work and cancel_delayed_work_sync
Date: Tue, 10 Nov 2015 19:35:18 +0800
Message-ID: <1447155318-31001-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 28B712625ED
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 12:35:26 +0100 (CET)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, john.lin@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5645.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 672fafd..4e81181 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -572,14 +572,12 @@ static int rt5645_spk_put_volsw(struct snd_kcontrol *kcontrol,
 	struct rt5645_priv *rt5645 = snd_soc_component_get_drvdata(component);
 	int ret;
 
-	cancel_delayed_work_sync(&rt5645->rcclock_work);
-
 	regmap_update_bits(rt5645->regmap, RT5645_MICBIAS,
 		RT5645_PWR_CLK25M_MASK, RT5645_PWR_CLK25M_PU);
 
 	ret = snd_soc_put_volsw(kcontrol, ucontrol);
 
-	queue_delayed_work(system_power_efficient_wq, &rt5645->rcclock_work,
+	mod_delayed_work(system_power_efficient_wq, &rt5645->rcclock_work,
 		msecs_to_jiffies(200));
 
 	return ret;
-- 
1.8.1.1.439.g50a6b54
