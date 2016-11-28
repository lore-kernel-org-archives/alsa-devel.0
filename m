From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt298: disable IRQ when jack is NULL
Date: Mon, 28 Nov 2016 13:24:06 +0800
Message-ID: <1480310646-16354-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 396F7266A76
 for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2016 06:24:28 +0100 (CET)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, vinod.koul@intel.com, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Disable IRQ when jack is NULL in rt298_mic_detect. So machine driver
can use it in suspend/resume.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt298.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index 2db8179..7150a40 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -326,11 +326,31 @@ static void rt298_jack_detect_work(struct work_struct *work)
 int rt298_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack)
 {
 	struct rt298_priv *rt298 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm;
+	bool hp = false;
+	bool mic = false;
+	int status = 0;
+
+	/* If jack in NULL, disable HS jack */
+	if (!jack) {
+		regmap_update_bits(rt298->regmap, RT298_IRQ_CTRL, 0x2, 0x0);
+		dapm = snd_soc_codec_get_dapm(codec);
+		snd_soc_dapm_disable_pin(dapm, "LDO1");
+		snd_soc_dapm_sync(dapm);
+		return 0;
+	}
 
 	rt298->jack = jack;
+	regmap_update_bits(rt298->regmap, RT298_IRQ_CTRL, 0x2, 0x2);
 
-	/* Send an initial empty report */
-	snd_soc_jack_report(rt298->jack, 0,
+	rt298_jack_detect(rt298, &hp, &mic);
+	if (hp == true)
+		status |= SND_JACK_HEADPHONE;
+
+	if (mic == true)
+		status |= SND_JACK_MICROPHONE;
+
+	snd_soc_jack_report(rt298->jack, status,
 		SND_JACK_MICROPHONE | SND_JACK_HEADPHONE);
 
 	return 0;
-- 
1.8.1.1.439.g50a6b54
