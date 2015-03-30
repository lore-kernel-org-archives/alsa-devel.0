From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/8] ASoC: wm8971: Use
	system_power_efficient_wq instead of custom workqueue
Date: Mon, 30 Mar 2015 21:04:45 +0200
Message-ID: <1427742293-8588-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-247.synserver.de (smtp-out-247.synserver.de
 [212.40.185.247])
 by alsa0.perex.cz (Postfix) with ESMTP id 821A026058E
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2015 21:04:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The delayed work used by the wm8971 driver to manage the caps charging
doesn't have any special requirements that would justify using a custom
workqueue, just use the generic system_power_efficient_wq instead.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8971.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 39ddb9b..44baacd 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -31,8 +31,6 @@
 
 #define	WM8971_REG_COUNT		43
 
-static struct workqueue_struct *wm8971_workq = NULL;
-
 /* codec private data */
 struct wm8971_priv {
 	unsigned int sysclk;
@@ -636,7 +634,8 @@ static int wm8971_resume(struct snd_soc_codec *codec)
 		reg = snd_soc_read(codec, WM8971_PWR1) & 0xfe3e;
 		snd_soc_write(codec, WM8971_PWR1, reg | 0x01c0);
 		codec->dapm.bias_level = SND_SOC_BIAS_ON;
-		queue_delayed_work(wm8971_workq, &codec->dapm.delayed_work,
+		queue_delayed_work(system_power_efficient_wq,
+			&codec->dapm.delayed_work,
 			msecs_to_jiffies(1000));
 	}
 
@@ -649,9 +648,6 @@ static int wm8971_probe(struct snd_soc_codec *codec)
 	u16 reg;
 
 	INIT_DELAYED_WORK(&codec->dapm.delayed_work, wm8971_work);
-	wm8971_workq = create_workqueue("wm8971");
-	if (wm8971_workq == NULL)
-		return -ENOMEM;
 
 	wm8971_reset(codec);
 
@@ -659,7 +655,8 @@ static int wm8971_probe(struct snd_soc_codec *codec)
 	reg = snd_soc_read(codec, WM8971_PWR1) & 0xfe3e;
 	snd_soc_write(codec, WM8971_PWR1, reg | 0x01c0);
 	codec->dapm.bias_level = SND_SOC_BIAS_STANDBY;
-	queue_delayed_work(wm8971_workq, &codec->dapm.delayed_work,
+	queue_delayed_work(system_power_efficient_wq,
+		&codec->dapm.delayed_work,
 		msecs_to_jiffies(1000));
 
 	/* set the update bits */
@@ -681,8 +678,6 @@ static int wm8971_remove(struct snd_soc_codec *codec)
 {
 	wm8971_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
-	if (wm8971_workq)
-		destroy_workqueue(wm8971_workq);
 	return 0;
 }
 
-- 
1.8.0
