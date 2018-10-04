From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/5] ASoC: adau1761: Use the standard
	fall-through annotation
Date: Thu,  4 Oct 2018 20:30:02 +0200
Message-ID: <20181004183006.23983-2-tiwai@suse.de>
References: <20181004183006.23983-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D573267845
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2018 20:30:09 +0200 (CEST)
In-Reply-To: <20181004183006.23983-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

As a preparatory patch for the upcoming -Wimplicit-fallthrough
compiler checks, replace with the standard "fall through" annotation
at the right place.  It has to be put right before the next label.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/adau1761.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/adau1761.c b/sound/soc/codecs/adau1761.c
index be136e981653..bef3e9e74c26 100644
--- a/sound/soc/codecs/adau1761.c
+++ b/sound/soc/codecs/adau1761.c
@@ -518,7 +518,8 @@ static int adau1761_setup_digmic_jackdetect(struct snd_soc_component *component)
 			ARRAY_SIZE(adau1761_jack_detect_controls));
 		if (ret)
 			return ret;
-	case ADAU1761_DIGMIC_JACKDET_PIN_MODE_NONE: /* fallthrough */
+		/* fall through */
+	case ADAU1761_DIGMIC_JACKDET_PIN_MODE_NONE:
 		ret = snd_soc_dapm_add_routes(dapm, adau1761_no_dmic_routes,
 			ARRAY_SIZE(adau1761_no_dmic_routes));
 		if (ret)
-- 
2.18.0
