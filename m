From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH] ASoC: cs42l73: Fix mask bits for
	SOC_VALUE_ENUM_SINGLE
Date: Tue, 18 Mar 2014 13:56:21 -0500
Message-ID: <1395168981-1905-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heelrod (unknown [141.131.2.3])
 by alsa0.perex.cz (Postfix) with ESMTP id A9E9726165C
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 19:56:21 +0100 (CET)
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

The mask bits values were wrong for the SOC_VALUE_ENUM_SINGLE for the mono mix controls.

Reported-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Brian Austin <brian.austin@cirrus.com>
---
 sound/soc/codecs/cs42l73.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 61c0f64..4cb7652 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -325,7 +325,7 @@ static const char * const cs42l73_mono_mix_texts[] = {
 static const unsigned int cs42l73_mono_mix_values[] = { 0, 1, 2 };
 
 static const struct soc_enum spk_asp_enum =
-	SOC_VALUE_ENUM_SINGLE(CS42L73_MMIXCTL, 6, 1,
+	SOC_VALUE_ENUM_SINGLE(CS42L73_MMIXCTL, 6, 3,
 			      ARRAY_SIZE(cs42l73_mono_mix_texts),
 			      cs42l73_mono_mix_texts,
 			      cs42l73_mono_mix_values);
@@ -343,7 +343,7 @@ static const struct snd_kcontrol_new spk_xsp_mixer =
 	SOC_DAPM_ENUM("Route", spk_xsp_enum);
 
 static const struct soc_enum esl_asp_enum =
-	SOC_VALUE_ENUM_SINGLE(CS42L73_MMIXCTL, 2, 5,
+	SOC_VALUE_ENUM_SINGLE(CS42L73_MMIXCTL, 2, 3,
 			      ARRAY_SIZE(cs42l73_mono_mix_texts),
 			      cs42l73_mono_mix_texts,
 			      cs42l73_mono_mix_values);
@@ -352,7 +352,7 @@ static const struct snd_kcontrol_new esl_asp_mixer =
 	SOC_DAPM_ENUM("Route", esl_asp_enum);
 
 static const struct soc_enum esl_xsp_enum =
-	SOC_VALUE_ENUM_SINGLE(CS42L73_MMIXCTL, 0, 7,
+	SOC_VALUE_ENUM_SINGLE(CS42L73_MMIXCTL, 0, 3,
 			      ARRAY_SIZE(cs42l73_mono_mix_texts),
 			      cs42l73_mono_mix_texts,
 			      cs42l73_mono_mix_values);
-- 
1.7.9.5
