From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] ASoC: adau17x1: Replace w->codec with
	snd_soc_dapm_to_codec(w->dapm)
Date: Mon, 17 Nov 2014 09:37:36 +0100
Message-ID: <1416213456-5987-3-git-send-email-lars@metafoo.de>
References: <1416213456-5987-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-035.synserver.de (smtp-out-134.synserver.de
 [212.40.185.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F63A261552
 for <alsa-devel@alsa-project.org>; Mon, 17 Nov 2014 09:37:42 +0100 (CET)
In-Reply-To: <1416213456-5987-1-git-send-email-lars@metafoo.de>
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
 sound/soc/codecs/adau1761.c | 3 ++-
 sound/soc/codecs/adau1781.c | 2 +-
 sound/soc/codecs/adau17x1.c | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/adau1761.c b/sound/soc/codecs/adau1761.c
index 91f6028..16093dc 100644
--- a/sound/soc/codecs/adau1761.c
+++ b/sound/soc/codecs/adau1761.c
@@ -255,7 +255,8 @@ static const struct snd_kcontrol_new adau1761_input_mux_control =
 static int adau1761_dejitter_fixup(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct adau *adau = snd_soc_codec_get_drvdata(w->codec);
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct adau *adau = snd_soc_codec_get_drvdata(codec);
 
 	/* After any power changes have been made the dejitter circuit
 	 * has to be reinitialized. */
diff --git a/sound/soc/codecs/adau1781.c b/sound/soc/codecs/adau1781.c
index e9fc00f..aa6a37c 100644
--- a/sound/soc/codecs/adau1781.c
+++ b/sound/soc/codecs/adau1781.c
@@ -174,7 +174,7 @@ static const struct snd_kcontrol_new adau1781_mono_mixer_controls[] = {
 static int adau1781_dejitter_fixup(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct adau *adau = snd_soc_codec_get_drvdata(codec);
 
 	/* After any power changes have been made the dejitter circuit
diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
index 3e16c1c..427ad77 100644
--- a/sound/soc/codecs/adau17x1.c
+++ b/sound/soc/codecs/adau17x1.c
@@ -61,7 +61,8 @@ static const struct snd_kcontrol_new adau17x1_controls[] = {
 static int adau17x1_pll_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct adau *adau = snd_soc_codec_get_drvdata(w->codec);
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct adau *adau = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
 	if (SND_SOC_DAPM_EVENT_ON(event)) {
-- 
1.8.0
