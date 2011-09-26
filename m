From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 04/10] ASoC: twl6040: Move the delayed_work for
	HS detection under twl6040_jack_data
Date: Mon, 26 Sep 2011 16:26:27 +0300
Message-ID: <1317043593-27202-5-git-send-email-peter.ujfalusi@ti.com>
References: <1317043593-27202-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog107.obsmtp.com (na3sys009aog107.obsmtp.com
	[74.125.149.197])
	by alsa0.perex.cz (Postfix) with ESMTP id 18B53243C2
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Sep 2011 15:26:54 +0200 (CEST)
Received: by mail-bw0-f53.google.com with SMTP id zt12so7309155bkb.40
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2011 06:26:50 -0700 (PDT)
In-Reply-To: <1317043593-27202-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

The delayed_work named 'delayed_work' is for the headset detection,
so move it to the twl6040_jack_data struct.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index c5232ce..72f838c 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -78,6 +78,7 @@ struct twl6040_output {
 
 struct twl6040_jack_data {
 	struct snd_soc_jack *jack;
+	struct delayed_work work;
 	int report;
 };
 
@@ -99,7 +100,6 @@ struct twl6040_data {
 	struct twl6040_jack_data hs_jack;
 	struct snd_soc_codec *codec;
 	struct workqueue_struct *workqueue;
-	struct delayed_work delayed_work;
 	struct mutex mutex;
 	struct twl6040_output headset;
 	struct twl6040_output handsfree;
@@ -734,7 +734,7 @@ EXPORT_SYMBOL_GPL(twl6040_hs_jack_detect);
 static void twl6040_accessory_work(struct work_struct *work)
 {
 	struct twl6040_data *priv = container_of(work,
-					struct twl6040_data, delayed_work.work);
+					struct twl6040_data, hs_jack.work.work);
 	struct snd_soc_codec *codec = priv->codec;
 	struct twl6040_jack_data *hs_jack = &priv->hs_jack;
 
@@ -747,7 +747,7 @@ static irqreturn_t twl6040_audio_handler(int irq, void *data)
 	struct snd_soc_codec *codec = data;
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
 
-	queue_delayed_work(priv->workqueue, &priv->delayed_work,
+	queue_delayed_work(priv->workqueue, &priv->hs_jack.work,
 			   msecs_to_jiffies(200));
 
 	return IRQ_HANDLED;
@@ -1606,7 +1606,7 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 		goto work_err;
 	}
 
-	INIT_DELAYED_WORK(&priv->delayed_work, twl6040_accessory_work);
+	INIT_DELAYED_WORK(&priv->hs_jack.work, twl6040_accessory_work);
 
 	mutex_init(&priv->mutex);
 
-- 
1.7.6.1
