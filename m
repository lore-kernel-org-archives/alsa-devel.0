From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] ASoC: TSCS42xx: make functions pll_event and dac_event static
Date: Mon,  8 Jan 2018 23:14:44 +0000
Message-ID: <20180108231444.8415-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

The functions pll_event and dac_event are local to the source and do
not need to be in global scope, so make them static.

Cleans up sparse warnings:
symbol 'pll_event' was not declared. Should it be static?
symbol 'dac_event' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/tscs42xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tscs42xx.c b/sound/soc/codecs/tscs42xx.c
index eedd600875e5..9e8155766ea9 100644
--- a/sound/soc/codecs/tscs42xx.c
+++ b/sound/soc/codecs/tscs42xx.c
@@ -355,8 +355,8 @@ static int dapm_micb_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-int pll_event(struct snd_soc_dapm_widget *w,
-		   struct snd_kcontrol *kcontrol, int event)
+static int pll_event(struct snd_soc_dapm_widget *w,
+		     struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	int ret;
@@ -369,8 +369,8 @@ int pll_event(struct snd_soc_dapm_widget *w,
 	return ret;
 }
 
-int dac_event(struct snd_soc_dapm_widget *w,
-		   struct snd_kcontrol *kcontrol, int event)
+static int dac_event(struct snd_soc_dapm_widget *w,
+		     struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct tscs42xx *tscs42xx = snd_soc_codec_get_drvdata(codec);
-- 
2.15.1
