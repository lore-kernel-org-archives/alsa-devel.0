From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH] ASoC: cs42l52: Fix mask bits for
	SOC_VALUE_ENUM_SINGLE
Date: Tue, 18 Mar 2014 14:01:47 -0500
Message-ID: <1395169307-2048-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heelrod (unknown [141.131.2.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F7F226165C
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 20:01:35 +0100 (CET)
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
Cc: tiwai@suse.de, Brian Austin <brian.austin@cirrus.com>, broonie@kernel.org, lgirdwood@gmail.com, paul.handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org

The mask bits values were wrong for the SOC_VALUE_ENUM_SINGLE for the PCM/ADC Swap controls

Reported-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Brian Austin <brian.austin@cirrus.com>
---
 sound/soc/codecs/cs42l52.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index be2ba1b..ab3ac7b 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -352,7 +352,7 @@ static const char * const right_swap_text[] = {
 static const unsigned int swap_values[] = { 0, 1, 3 };
 
 static const struct soc_enum adca_swap_enum =
-	SOC_VALUE_ENUM_SINGLE(CS42L52_ADC_PCM_MIXER, 2, 1,
+	SOC_VALUE_ENUM_SINGLE(CS42L52_ADC_PCM_MIXER, 2, 3,
 			      ARRAY_SIZE(left_swap_text),
 			      left_swap_text,
 			      swap_values);
@@ -361,7 +361,7 @@ static const struct snd_kcontrol_new adca_mixer =
 	SOC_DAPM_ENUM("Route", adca_swap_enum);
 
 static const struct soc_enum pcma_swap_enum =
-	SOC_VALUE_ENUM_SINGLE(CS42L52_ADC_PCM_MIXER, 6, 1,
+	SOC_VALUE_ENUM_SINGLE(CS42L52_ADC_PCM_MIXER, 6, 3,
 			      ARRAY_SIZE(left_swap_text),
 			      left_swap_text,
 			      swap_values);
@@ -370,7 +370,7 @@ static const struct snd_kcontrol_new pcma_mixer =
 	SOC_DAPM_ENUM("Route", pcma_swap_enum);
 
 static const struct soc_enum adcb_swap_enum =
-	SOC_VALUE_ENUM_SINGLE(CS42L52_ADC_PCM_MIXER, 0, 1,
+	SOC_VALUE_ENUM_SINGLE(CS42L52_ADC_PCM_MIXER, 0, 3,
 			      ARRAY_SIZE(right_swap_text),
 			      right_swap_text,
 			      swap_values);
@@ -379,7 +379,7 @@ static const struct snd_kcontrol_new adcb_mixer =
 	SOC_DAPM_ENUM("Route", adcb_swap_enum);
 
 static const struct soc_enum pcmb_swap_enum =
-	SOC_VALUE_ENUM_SINGLE(CS42L52_ADC_PCM_MIXER, 4, 1,
+	SOC_VALUE_ENUM_SINGLE(CS42L52_ADC_PCM_MIXER, 4, 3,
 			      ARRAY_SIZE(right_swap_text),
 			      right_swap_text,
 			      swap_values);
-- 
1.7.9.5
