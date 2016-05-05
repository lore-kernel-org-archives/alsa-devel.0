From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5645: polling jd status in all
	conditions
Date: Thu, 5 May 2016 11:13:31 +0800
Message-ID: <1462418011-20974-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 09B432651FD
 for <alsa-devel@alsa-project.org>; Thu,  5 May 2016 05:13:47 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

We only polling jd status when rt5645->pdata.jd_invert is true.
However, it should be done at all time since there will be no
interrupt for jd if we press a headset button and remove the
headset at the same time.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index dff706a..3c6594d 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3286,10 +3286,8 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 		if (btn_type == 0)/* button release */
 			report =  rt5645->jack_type;
 		else {
-			if (rt5645->pdata.jd_invert) {
-				mod_timer(&rt5645->btn_check_timer,
-					msecs_to_jiffies(100));
-			}
+			mod_timer(&rt5645->btn_check_timer,
+				msecs_to_jiffies(100));
 		}
 
 		break;
@@ -3816,9 +3814,9 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 	if (rt5645->pdata.jd_invert) {
 		regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
 			RT5645_JD_1_1_MASK, RT5645_JD_1_1_INV);
-		setup_timer(&rt5645->btn_check_timer,
-			rt5645_btn_check_callback, (unsigned long)rt5645);
 	}
+	setup_timer(&rt5645->btn_check_timer,
+		rt5645_btn_check_callback, (unsigned long)rt5645);
 
 	INIT_DELAYED_WORK(&rt5645->jack_detect_work, rt5645_jack_detect_work);
 	INIT_DELAYED_WORK(&rt5645->rcclock_work, rt5645_rcclock_work);
-- 
1.8.1.1.439.g50a6b54
