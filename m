From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: max98090: Use power efficient workqueue
Date: Thu, 18 Jul 2013 22:59:55 +0100
Message-ID: <1374184795-11976-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D2EB265628
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 00:00:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

None of the delayed work the driver schedules has particularly short delays
and it is not performance sensitive so let the scheduler run it wherever
is most efficient rather than in a per CPU workqueue by using the system
power efficient workqueue.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/max98090.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index ad5313f..0569a4c 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2084,8 +2084,9 @@ static irqreturn_t max98090_interrupt(int irq, void *data)
 
 		pm_wakeup_event(codec->dev, 100);
 
-		schedule_delayed_work(&max98090->jack_work,
-			msecs_to_jiffies(100));
+		queue_delayed_work(system_power_efficient_wq,
+				   &max98090->jack_work,
+				   msecs_to_jiffies(100));
 	}
 
 	if (active & M98090_DRCACT_MASK)
@@ -2132,8 +2133,9 @@ int max98090_mic_detect(struct snd_soc_codec *codec,
 	snd_soc_jack_report(max98090->jack, 0,
 			    SND_JACK_HEADSET | SND_JACK_BTN_0);
 
-	schedule_delayed_work(&max98090->jack_work,
-		msecs_to_jiffies(100));
+	queue_delayed_work(system_power_efficient_wq,
+			   &max98090->jack_work,
+			   msecs_to_jiffies(100));
 
 	return 0;
 }
-- 
1.8.3.2
