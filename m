From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 6/6] ASoC: Intel: byt-max98090: Do not enable
	MAX98090 microphone detection
Date: Mon, 23 Jun 2014 16:29:42 +0300
Message-ID: <1403530182-5400-6-git-send-email-jarkko.nikula@linux.intel.com>
References: <1403530182-5400-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EC60261A96
 for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2014 15:30:19 +0200 (CEST)
In-Reply-To: <1403530182-5400-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Strasser <kevin.strasser@intel.com>
List-Id: alsa-devel@alsa-project.org

It turned out there is no need to enable microphone detection in MAX98090
codec. Headset microphone is anyway detected by a GPIO signal from another
chip and headset button presses cannot be detected either because a signal
needed for it is not connected.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/byt-max98090.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/byt-max98090.c b/sound/soc/intel/byt-max98090.c
index deb1db9a9a97..b8b8af571ef1 100644
--- a/sound/soc/intel/byt-max98090.c
+++ b/sound/soc/intel/byt-max98090.c
@@ -110,13 +110,9 @@ static int byt_max98090_init(struct snd_soc_pcm_runtime *runtime)
 	if (ret)
 		return ret;
 
-	ret = snd_soc_jack_add_gpiods(card->dev->parent, jack,
-				      ARRAY_SIZE(hs_jack_gpios),
-				      hs_jack_gpios);
-	if (ret)
-		return ret;
-
-	return max98090_mic_detect(codec, jack);
+	return snd_soc_jack_add_gpiods(card->dev->parent, jack,
+				       ARRAY_SIZE(hs_jack_gpios),
+				       hs_jack_gpios);
 }
 
 static struct snd_soc_dai_link byt_max98090_dais[] = {
-- 
2.0.0
