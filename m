From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Move WM8915 FLL operations onto the CODEC
Date: Mon, 11 Apr 2011 23:39:47 -0700
Message-ID: <1302590387-14857-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 451A1103876
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Apr 2011 08:56:58 +0200 (CEST)
Received: from finisterre.wolfsonmicro.main (unknown [209.119.62.83])
	by opensource2.wolfsonmicro.com (Postfix) with ESMTPSA id D9A2911018E
	for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2011 07:56:55 +0100 (BST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Since the WM8915 FLL is not tied to a particular audio interface move it
to a CODEC wide operation.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8915.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8915.c b/sound/soc/codecs/wm8915.c
index 3adad28..0836094 100644
--- a/sound/soc/codecs/wm8915.c
+++ b/sound/soc/codecs/wm8915.c
@@ -1997,10 +1997,9 @@ static int fll_factors(struct _fll_div *fll_div, unsigned int Fref,
 	return 0;
 }
 
-static int wm8915_set_fll(struct snd_soc_dai *dai, int fll_id, int source,
+static int wm8915_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 			  unsigned int Fref, unsigned int Fout)
 {
-	struct snd_soc_codec *codec = dai->codec;
 	struct wm8915_priv *wm8915 = snd_soc_codec_get_drvdata(codec);
 	struct _fll_div fll_div;
 	unsigned long timeout;
@@ -2776,6 +2775,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8915 = {
 	.num_dapm_widgets = ARRAY_SIZE(wm8915_dapm_widgets),
 	.dapm_routes = wm8915_dapm_routes,
 	.num_dapm_routes = ARRAY_SIZE(wm8915_dapm_routes),
+	.set_pll = wm8915_set_fll,
 };
 
 #define WM8915_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
@@ -2788,7 +2788,6 @@ static struct snd_soc_dai_ops wm8915_dai_ops = {
 	.set_fmt = wm8915_set_fmt,
 	.hw_params = wm8915_hw_params,
 	.set_sysclk = wm8915_set_sysclk,
-	.set_pll = wm8915_set_fll,
 };
 
 static struct snd_soc_dai_driver wm8915_dai[] = {
-- 
1.7.4.1
