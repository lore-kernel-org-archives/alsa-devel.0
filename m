From: Koro Chen <koro.chen@mediatek.com>
Subject: [PATCH 1/2] ASoC: rt5645: Fix missing free_irq
Date: Wed, 8 Jul 2015 16:25:50 +0800
Message-ID: <1436343951-3482-1-git-send-email-koro.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 18FA026043A
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 10:26:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, perex@perex.cz, tiwai@suse.de, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, srv_heupstream@mediatek.com, Koro Chen <koro.chen@mediatek.com>, linux-kernel@vger.kernel.org, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org

The driver does not free irq if snd_soc_register_codec fails.
It does not return error when request irq failed, either.
Fix this by using devm_request_threaded_irq(), and returns when error.

Signed-off-by: Koro Chen <koro.chen@mediatek.com>
---
 sound/soc/codecs/rt5645.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 9dfa431..f9f2db8 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3427,11 +3427,15 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 	INIT_DELAYED_WORK(&rt5645->jack_detect_work, rt5645_jack_detect_work);
 
 	if (rt5645->i2c->irq) {
-		ret = request_threaded_irq(rt5645->i2c->irq, NULL, rt5645_irq,
-			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
-			| IRQF_ONESHOT, "rt5645", rt5645);
-		if (ret)
+		ret = devm_request_threaded_irq(&i2c->dev, rt5645->i2c->irq,
+						NULL, rt5645_irq,
+						IRQF_TRIGGER_RISING |
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT, "rt5645", rt5645);
+		if (ret) {
 			dev_err(&i2c->dev, "Failed to reguest IRQ: %d\n", ret);
+			return ret;
+		}
 	}
 
 	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5645,
@@ -3442,9 +3446,6 @@ static int rt5645_i2c_remove(struct i2c_client *i2c)
 {
 	struct rt5645_priv *rt5645 = i2c_get_clientdata(i2c);
 
-	if (i2c->irq)
-		free_irq(i2c->irq, rt5645);
-
 	cancel_delayed_work_sync(&rt5645->jack_detect_work);
 
 	snd_soc_unregister_codec(&i2c->dev);
-- 
1.8.1.1.dirty
