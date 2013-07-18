From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: twl6040: Use power efficient workqueue
Date: Thu, 18 Jul 2013 22:45:11 +0100
Message-ID: <1374183911-6814-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EAD12655F0
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2013 23:45:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: peter.ujfalusi@ti.com, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The accessory detect debounce work is not performance sensitive so let
the scheduler run it wherever is most efficient rather than in a per CPU
workqueue by using the system power efficient workqueue.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/twl6040.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 44621dd..caf8784 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -429,7 +429,8 @@ static irqreturn_t twl6040_audio_handler(int irq, void *data)
 	struct snd_soc_codec *codec = data;
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
 
-	schedule_delayed_work(&priv->hs_jack.work, msecs_to_jiffies(200));
+	queue_delayed_work(system_power_efficient_wq,
+			   &priv->hs_jack.work, msecs_to_jiffies(200));
 
 	return IRQ_HANDLED;
 }
-- 
1.8.3.2
