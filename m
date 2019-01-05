From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 08/21] ASoC: rt298: fix boolean tests
Date: Fri,  4 Jan 2019 20:02:36 -0600
Message-ID: <20190105020249.8639-9-pierre-louis.bossart@linux.intel.com>
References: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@linux.intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Reported by Coccinelle:

sound/soc/codecs/rt298.c:992:6-8: WARNING: Comparison to bool
sound/soc/codecs/rt298.c:995:6-9: WARNING: Comparison to bool
sound/soc/codecs/rt298.c:317:5-7: WARNING: Comparison to bool
sound/soc/codecs/rt298.c:320:5-8: WARNING: Comparison to bool
sound/soc/codecs/rt298.c:348:5-7: WARNING: Comparison to bool
sound/soc/codecs/rt298.c:351:5-8: WARNING: Comparison to bool

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt298.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index 06cdba4edfe2..bcf5bab31969 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -314,10 +314,10 @@ static void rt298_jack_detect_work(struct work_struct *work)
 	if (rt298_jack_detect(rt298, &hp, &mic) < 0)
 		return;
 
-	if (hp == true)
+	if (hp)
 		status |= SND_JACK_HEADPHONE;
 
-	if (mic == true)
+	if (mic)
 		status |= SND_JACK_MICROPHONE;
 
 	snd_soc_jack_report(rt298->jack, status,
@@ -345,10 +345,10 @@ int rt298_mic_detect(struct snd_soc_component *component, struct snd_soc_jack *j
 	regmap_update_bits(rt298->regmap, RT298_IRQ_CTRL, 0x2, 0x2);
 
 	rt298_jack_detect(rt298, &hp, &mic);
-	if (hp == true)
+	if (hp)
 		status |= SND_JACK_HEADPHONE;
 
-	if (mic == true)
+	if (mic)
 		status |= SND_JACK_MICROPHONE;
 
 	snd_soc_jack_report(rt298->jack, status,
@@ -989,10 +989,10 @@ static irqreturn_t rt298_irq(int irq, void *data)
 	regmap_update_bits(rt298->regmap, RT298_IRQ_CTRL, 0x1, 0x1);
 
 	if (ret == 0) {
-		if (hp == true)
+		if (hp)
 			status |= SND_JACK_HEADPHONE;
 
-		if (mic == true)
+		if (mic)
 			status |= SND_JACK_MICROPHONE;
 
 		snd_soc_jack_report(rt298->jack, status,
-- 
2.17.1
