From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 10/21] ASoC: rt274: fix boolean tests
Date: Fri,  4 Jan 2019 20:02:38 -0600
Message-ID: <20190105020249.8639-11-pierre-louis.bossart@linux.intel.com>
References: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@linux.intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Reported by Coccinelle:

sound/soc/codecs/rt274.c:958:6-8: WARNING: Comparison to bool
sound/soc/codecs/rt274.c:961:6-9: WARNING: Comparison to bool
sound/soc/codecs/rt274.c:384:5-7: WARNING: Comparison to bool
sound/soc/codecs/rt274.c:387:5-8: WARNING: Comparison to bool

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt274.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt274.c b/sound/soc/codecs/rt274.c
index e2855ab9a2c6..9e88f7b25d38 100644
--- a/sound/soc/codecs/rt274.c
+++ b/sound/soc/codecs/rt274.c
@@ -381,10 +381,10 @@ static void rt274_jack_detect_work(struct work_struct *work)
 	if (rt274_jack_detect(rt274, &hp, &mic) < 0)
 		return;
 
-	if (hp == true)
+	if (hp)
 		status |= SND_JACK_HEADPHONE;
 
-	if (mic == true)
+	if (mic)
 		status |= SND_JACK_MICROPHONE;
 
 	snd_soc_jack_report(rt274->jack, status,
@@ -955,10 +955,10 @@ static irqreturn_t rt274_irq(int irq, void *data)
 	ret = rt274_jack_detect(rt274, &hp, &mic);
 
 	if (ret == 0) {
-		if (hp == true)
+		if (hp)
 			status |= SND_JACK_HEADPHONE;
 
-		if (mic == true)
+		if (mic)
 			status |= SND_JACK_MICROPHONE;
 
 		snd_soc_jack_report(rt274->jack, status,
-- 
2.17.1
