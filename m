From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] ASoC: max98095: Replace w->codec
	snd_soc_dapm_to_codec(w->dapm)
Date: Thu, 20 Nov 2014 21:21:55 +0100
Message-ID: <1416514915-29836-3-git-send-email-lars@metafoo.de>
References: <1416514915-29836-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-076.synserver.de (smtp-out-076.synserver.de
 [212.40.185.76])
 by alsa0.perex.cz (Postfix) with ESMTP id E5E24260610
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 21:21:56 +0100 (CET)
In-Reply-To: <1416514915-29836-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The codec field of the snd_soc_widget struct is eventually going to be
removed, use snd_soc_dapm_to_codec(w->dapm) instead.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/max98095.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 8a9e841..8fba0c3 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -866,7 +866,7 @@ static const struct snd_kcontrol_new max98095_right_ADC_mixer_controls[] = {
 static int max98095_mic_event(struct snd_soc_dapm_widget *w,
 			     struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
 
 	switch (event) {
@@ -896,7 +896,7 @@ static int max98095_mic_event(struct snd_soc_dapm_widget *w,
 static int max98095_line_pga(struct snd_soc_dapm_widget *w,
 			     int event, u8 channel)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
 	u8 *state;
 
@@ -944,7 +944,7 @@ static int max98095_pga_in2_event(struct snd_soc_dapm_widget *w,
 static int max98095_lineout_event(struct snd_soc_dapm_widget *w,
 			     struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-- 
1.8.0
