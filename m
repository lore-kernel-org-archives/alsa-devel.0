From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/5] ASoC: rt5651: Fix workqueue cancel vs irq
	free race on remove
Date: Thu,  5 Jul 2018 00:59:31 +0200
Message-ID: <20180704225935.7902-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 03EB22670D7
 for <alsa-devel@alsa-project.org>; Thu,  5 Jul 2018 00:59:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

On removal we must free the IRQ *before* cancelling the jack-detect work,
so that the jack-detect work cannot be rescheduled by the IRQ.

Before this commit we were cancelling the jack-detect work from the
driver remove callback, while relying on devm to free the IRQ, which
happens after the remove callback.

This is the wrong order. This commit uses a devm-action to register
a devm callback which cancels the work, before requesting the IRQ
(devm tears things down in reverse order). This also allows us to
remove the now empty remove driver callback.

Cc: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/rt5651.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 6b5669f3e85d..39d2c67cd064 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1696,6 +1696,13 @@ static irqreturn_t rt5651_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static void rt5651_cancel_work(void *data)
+{
+	struct rt5651_priv *rt5651 = data;
+
+	cancel_work_sync(&rt5651->jack_detect_work);
+}
+
 static int rt5651_set_jack(struct snd_soc_component *component,
 			   struct snd_soc_jack *hp_jack, void *data)
 {
@@ -2036,6 +2043,11 @@ static int rt5651_i2c_probe(struct i2c_client *i2c,
 
 	INIT_WORK(&rt5651->jack_detect_work, rt5651_jack_detect_work);
 
+	/* Make sure work is stopped on probe-error / remove */
+	ret = devm_add_action_or_reset(&i2c->dev, rt5651_cancel_work, rt5651);
+	if (ret)
+		return ret;
+
 	ret = devm_snd_soc_register_component(&i2c->dev,
 				&soc_component_dev_rt5651,
 				rt5651_dai, ARRAY_SIZE(rt5651_dai));
@@ -2043,15 +2055,6 @@ static int rt5651_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static int rt5651_i2c_remove(struct i2c_client *i2c)
-{
-	struct rt5651_priv *rt5651 = i2c_get_clientdata(i2c);
-
-	cancel_work_sync(&rt5651->jack_detect_work);
-
-	return 0;
-}
-
 static struct i2c_driver rt5651_i2c_driver = {
 	.driver = {
 		.name = "rt5651",
@@ -2059,7 +2062,6 @@ static struct i2c_driver rt5651_i2c_driver = {
 		.of_match_table = of_match_ptr(rt5651_of_match),
 	},
 	.probe = rt5651_i2c_probe,
-	.remove   = rt5651_i2c_remove,
 	.id_table = rt5651_i2c_id,
 };
 module_i2c_driver(rt5651_i2c_driver);
-- 
2.17.1
