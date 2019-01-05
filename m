From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 11/21] ASoc: rt286: fix boolean tests
Date: Fri,  4 Jan 2019 20:02:39 -0600
Message-ID: <20190105020249.8639-12-pierre-louis.bossart@linux.intel.com>
References: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@linux.intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Reported by Coccinelle:
sound/soc/codecs/rt286.c:927:5-7: WARNING: Comparison to bool
sound/soc/codecs/rt286.c:930:5-8: WARNING: Comparison to bool
sound/soc/codecs/rt286.c:299:5-7: WARNING: Comparison to bool
sound/soc/codecs/rt286.c:302:5-8: WARNING: Comparison to bool

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt286.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 0b0f748bffbe..c9457c247a03 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -296,10 +296,10 @@ static void rt286_jack_detect_work(struct work_struct *work)
 
 	rt286_jack_detect(rt286, &hp, &mic);
 
-	if (hp == true)
+	if (hp)
 		status |= SND_JACK_HEADPHONE;
 
-	if (mic == true)
+	if (mic)
 		status |= SND_JACK_MICROPHONE;
 
 	snd_soc_jack_report(rt286->jack, status,
@@ -924,10 +924,10 @@ static irqreturn_t rt286_irq(int irq, void *data)
 	/* Clear IRQ */
 	regmap_update_bits(rt286->regmap, RT286_IRQ_CTRL, 0x1, 0x1);
 
-	if (hp == true)
+	if (hp)
 		status |= SND_JACK_HEADPHONE;
 
-	if (mic == true)
+	if (mic)
 		status |= SND_JACK_MICROPHONE;
 
 	snd_soc_jack_report(rt286->jack, status,
-- 
2.17.1
