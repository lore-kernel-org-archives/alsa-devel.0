From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5665: calibration should be done
	before jack detection
Date: Thu, 29 Jun 2017 20:07:50 +0800
Message-ID: <1498738070-16624-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EA82266991
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 14:08:06 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, xiaoxiang@pinecone.net, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

We will set some volatile registers in jack detection function. But
those volatile registers will be clear in rt5665_calibrate function
because we set cache bypass and reset codec in rt5665_calibrate function.
This patch add a flag to make sure that rt5665_calibrate is done
before starting jack detection.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5665.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 7420010..370ed54d 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -70,6 +70,7 @@ struct rt5665_priv {
 	int jack_type;
 	int irq_work_delay_time;
 	unsigned int sar_adc_value;
+	bool calibration_done;
 };
 
 static const struct reg_default rt5665_reg[] = {
@@ -1305,6 +1306,11 @@ static void rt5665_jack_detect_handler(struct work_struct *work)
 		usleep_range(10000, 15000);
 	}
 
+	while (!rt5665->calibration_done) {
+		pr_debug("%s calibration not ready\n", __func__);
+		usleep_range(10000, 15000);
+	}
+
 	mutex_lock(&rt5665->calibrate_mutex);
 
 	val = snd_soc_read(rt5665->codec, RT5665_AJD1_CTRL) & 0x0010;
@@ -4695,6 +4701,7 @@ static void rt5665_calibrate(struct rt5665_priv *rt5665)
 	regmap_write(rt5665->regmap, RT5665_ASRC_8, 0x0120);
 
 out_unlock:
+	rt5665->calibration_done = true;
 	mutex_unlock(&rt5665->calibrate_mutex);
 }
 
-- 
2.7.4
