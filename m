From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 10/18] ASoC: wl1273: Use
	snd_pcm_hw_constraint_single()
Date: Sun, 18 Oct 2015 15:39:25 +0200
Message-ID: <1445175573-11784-11-git-send-email-lars@metafoo.de>
References: <1445175573-11784-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-200.synserver.de (smtp-out-225.synserver.de
 [212.40.185.225])
 by alsa0.perex.cz (Postfix) with ESMTP id D4023265054
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 15:39:58 +0200 (CEST)
In-Reply-To: <1445175573-11784-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vinod.koul@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Yang A Fang <yang.a.fang@intel.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Use the new snd_pcm_hw_constraint_single() helper function instead of
calling snd_pcm_hw_constraint_minmax() with the same value for min and max
to install a constraint that limits the possible configuration values to a
single value. Using snd_pcm_hw_constraint_single() makes the indented
result clearer.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wl1273.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wl1273.c b/sound/soc/codecs/wl1273.c
index 80fb1dc..7693c11 100644
--- a/sound/soc/codecs/wl1273.c
+++ b/sound/soc/codecs/wl1273.c
@@ -307,11 +307,10 @@ static int wl1273_startup(struct snd_pcm_substream *substream,
 
 	switch (wl1273->mode) {
 	case WL1273_MODE_BT:
-		snd_pcm_hw_constraint_minmax(substream->runtime,
-					     SNDRV_PCM_HW_PARAM_RATE,
-					     8000, 8000);
-		snd_pcm_hw_constraint_minmax(substream->runtime,
-					     SNDRV_PCM_HW_PARAM_CHANNELS, 1, 1);
+		snd_pcm_hw_constraint_single(substream->runtime,
+					     SNDRV_PCM_HW_PARAM_RATE, 8000);
+		snd_pcm_hw_constraint_single(substream->runtime,
+					     SNDRV_PCM_HW_PARAM_CHANNELS, 1);
 		break;
 	case WL1273_MODE_FM_RX:
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-- 
2.1.4
