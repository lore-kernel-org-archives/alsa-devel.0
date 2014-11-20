From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] ASoC: max98088: Replace w->codec
	snd_soc_dapm_to_codec(w->dapm)
Date: Thu, 20 Nov 2014 21:21:53 +0100
Message-ID: <1416514915-29836-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-076.synserver.de (smtp-out-076.synserver.de
 [212.40.185.76])
 by alsa0.perex.cz (Postfix) with ESMTP id C218D2605FC
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 21:21:54 +0100 (CET)
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
 sound/soc/codecs/max98088.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index bb892b3..805b3f8 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -875,7 +875,7 @@ static const struct snd_kcontrol_new max98088_right_ADC_mixer_controls[] = {
 static int max98088_mic_event(struct snd_soc_dapm_widget *w,
                             struct snd_kcontrol *kcontrol, int event)
 {
-       struct snd_soc_codec *codec = w->codec;
+       struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
        struct max98088_priv *max98088 = snd_soc_codec_get_drvdata(codec);
 
        switch (event) {
@@ -905,7 +905,7 @@ static int max98088_mic_event(struct snd_soc_dapm_widget *w,
 static int max98088_line_pga(struct snd_soc_dapm_widget *w,
                             int event, int line, u8 channel)
 {
-       struct snd_soc_codec *codec = w->codec;
+       struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
        struct max98088_priv *max98088 = snd_soc_codec_get_drvdata(codec);
        u8 *state;
 
-- 
1.8.0
