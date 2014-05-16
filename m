From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 5/7] ASoC: max98090: Make sure we configure
	BCLK in one place
Date: Fri, 16 May 2014 16:55:23 +0300
Message-ID: <1400248525-21900-6-git-send-email-jarkko.nikula@linux.intel.com>
References: <1400248525-21900-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 524A22608E8
 for <alsa-devel@alsa-project.org>; Fri, 16 May 2014 15:55:51 +0200 (CEST)
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

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

BCL is being configured in two places producing a warning message.
Make sure we only configure BCLK once and when we are master.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/codecs/max98090.c | 8 +++++---
 sound/soc/codecs/max98090.h | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 8c88b4448f7e..14d42cde9235 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -1675,6 +1675,7 @@ static int max98090_dai_set_fmt(struct snd_soc_dai *codec_dai,
 				M98090_REG_CLOCK_RATIO_NI_LSB, 0x00);
 			snd_soc_update_bits(codec, M98090_REG_CLOCK_MODE,
 				M98090_USE_M1_MASK, 0);
+			max98090->master = false;
 			break;
 		case SND_SOC_DAIFMT_CBM_CFM:
 			/* Set to master mode */
@@ -1691,6 +1692,7 @@ static int max98090_dai_set_fmt(struct snd_soc_dai *codec_dai,
 				regval |= M98090_MAS_MASK |
 					M98090_BSEL_32;
 			}
+			max98090->master = true;
 			break;
 		case SND_SOC_DAIFMT_CBS_CFM:
 		case SND_SOC_DAIFMT_CBM_CFS:
@@ -1874,7 +1876,8 @@ static int max98090_dai_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	max98090_configure_bclk(codec);
+	if (max98090->master)
+		max98090_configure_bclk(codec);
 
 	cdata->rate = max98090->lrclk;
 
@@ -1953,8 +1956,6 @@ static int max98090_dai_set_sysclk(struct snd_soc_dai *dai,
 
 	max98090->sysclk = freq;
 
-	max98090_configure_bclk(codec);
-
 	return 0;
 }
 
@@ -2226,6 +2227,7 @@ static int max98090_probe(struct snd_soc_codec *codec)
 	/* Initialize private data */
 
 	max98090->sysclk = (unsigned)-1;
+	max98090->master = false;
 
 	cdata = &max98090->dai[0];
 	cdata->rate = (unsigned)-1;
diff --git a/sound/soc/codecs/max98090.h b/sound/soc/codecs/max98090.h
index 1a4e2334a7b2..5a3c8d0613cb 100644
--- a/sound/soc/codecs/max98090.h
+++ b/sound/soc/codecs/max98090.h
@@ -1540,6 +1540,7 @@ struct max98090_priv {
 	unsigned int pa2en;
 	unsigned int extmic_mux;
 	unsigned int sidetone;
+	bool master;
 };
 
 int max98090_mic_detect(struct snd_soc_codec *codec,
-- 
2.0.0.rc0
