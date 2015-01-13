From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 28/29] ASoC: wm_adsp: Replace w->codec
	snd_soc_dapm_to_codec(w->dapm)
Date: Tue, 13 Jan 2015 10:27:34 +0100
Message-ID: <1421141255-21477-28-git-send-email-lars@metafoo.de>
References: <1421141255-21477-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-210.synserver.de
 [212.40.185.210])
 by alsa0.perex.cz (Postfix) with ESMTP id 10C92261A7F
 for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2015 10:28:16 +0100 (CET)
In-Reply-To: <1421141255-21477-1-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The codec field of the snd_soc_widget struct is eventually going to be
removed, use snd_soc_dapm_to_codec(w->dapm) instead.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm_adsp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 720d6e8..ff67b33 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1373,7 +1373,7 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol,
 		   int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct wm_adsp *dsps = snd_soc_codec_get_drvdata(codec);
 	struct wm_adsp *dsp = &dsps[w->shift];
 	struct wm_adsp_alg_region *alg_region;
@@ -1605,7 +1605,7 @@ err:
 int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct wm_adsp *dsps = snd_soc_codec_get_drvdata(codec);
 	struct wm_adsp *dsp = &dsps[w->shift];
 
@@ -1626,7 +1626,7 @@ EXPORT_SYMBOL_GPL(wm_adsp2_early_event);
 int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct wm_adsp *dsps = snd_soc_codec_get_drvdata(codec);
 	struct wm_adsp *dsp = &dsps[w->shift];
 	struct wm_adsp_alg_region *alg_region;
-- 
1.8.0
