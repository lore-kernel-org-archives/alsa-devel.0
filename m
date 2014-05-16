From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 6/7] ASoC: max98090: Move microphone bias
	voltage setting to probe function
Date: Fri, 16 May 2014 16:55:24 +0300
Message-ID: <1400248525-21900-7-git-send-email-jarkko.nikula@linux.intel.com>
References: <1400248525-21900-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B5D5926087D
 for <alsa-devel@alsa-project.org>; Fri, 16 May 2014 15:55:54 +0200 (CEST)
In-Reply-To: <1400248525-21900-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Microphone bias level configuration register can configure voltage between
2.2 V and 2.8 V but doesn't manage is voltage on or off. Microphone bias
on/off state is controlled by "MICBIAS" DAPM widget.

Therefore there is no need to update bias voltage conditionally depending on
jack state each time when codec goes to SND_SOC_BIAS_ON state and setting
can be moved to max98090_probe() as driver currently doesn't support other
levels than 2.8 V.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/codecs/max98090.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 14d42cde9235..0c8315270e8e 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -1796,13 +1796,6 @@ static int max98090_set_bias_level(struct snd_soc_codec *codec,
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-		if (max98090->jack_state == M98090_JACK_STATE_HEADSET) {
-			/*
-			 * Set to normal bias level.
-			 */
-			snd_soc_update_bits(codec, M98090_REG_MIC_BIAS_VOLTAGE,
-				M98090_MBVSEL_MASK, M98090_MBVSEL_2V8);
-		}
 		break;
 
 	case SND_SOC_BIAS_PREPARE:
@@ -2297,6 +2290,9 @@ static int max98090_probe(struct snd_soc_codec *codec)
 	snd_soc_write(codec, M98090_REG_BIAS_CONTROL,
 		M98090_VCM_MODE_MASK);
 
+	snd_soc_update_bits(codec, M98090_REG_MIC_BIAS_VOLTAGE,
+		M98090_MBVSEL_MASK, M98090_MBVSEL_2V8);
+
 	max98090_handle_pdata(codec);
 
 	max98090_add_widgets(codec);
-- 
2.0.0.rc0
