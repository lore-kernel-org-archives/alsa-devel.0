From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm5100: Set the DAI base address in
	the DAI drivers
Date: Tue,  1 May 2012 20:04:28 +0100
Message-ID: <1335899068-22645-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1335899068-22645-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 067DB104348
	for <alsa-devel@alsa-project.org>;
	Tue,  1 May 2012 21:04:32 +0200 (CEST)
In-Reply-To: <1335899068-22645-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5100.c |   26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 7fbcd6d..1f13ccd 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -1342,29 +1342,12 @@ static const __devinitdata struct reg_default wm5100_reva_patches[] = {
 	{ WM5100_AUDIO_IF_3_19, 1 },
 };
 
-static int wm5100_dai_to_base(struct snd_soc_dai *dai)
-{
-	switch (dai->id) {
-	case 0:
-		return WM5100_AUDIO_IF_1_1 - 1;
-	case 1:
-		return WM5100_AUDIO_IF_2_1 - 1;
-	case 2:
-		return WM5100_AUDIO_IF_3_1 - 1;
-	default:
-		BUG();
-		return -EINVAL;
-	}
-}
-
 static int wm5100_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	int lrclk, bclk, mask, base;
 
-	base = wm5100_dai_to_base(dai);
-	if (base < 0)
-		return base;
+	base = dai->driver->base;
 
 	lrclk = 0;
 	bclk = 0;
@@ -1491,9 +1474,7 @@ static int wm5100_hw_params(struct snd_pcm_substream *substream,
 	int i, base, bclk, aif_rate, lrclk, wl, fl, sr;
 	int *bclk_rates;
 
-	base = wm5100_dai_to_base(dai);
-	if (base < 0)
-		return base;
+	base = dai->driver->base;
 
 	/* Data sizes if not using TDM */
 	wl = snd_pcm_format_width(params_format(params));
@@ -1974,6 +1955,7 @@ static int wm5100_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 static struct snd_soc_dai_driver wm5100_dai[] = {
 	{
 		.name = "wm5100-aif1",
+		.base = WM5100_AUDIO_IF_1_1 - 1,
 		.playback = {
 			.stream_name = "AIF1 Playback",
 			.channels_min = 2,
@@ -1993,6 +1975,7 @@ static struct snd_soc_dai_driver wm5100_dai[] = {
 	{
 		.name = "wm5100-aif2",
 		.id = 1,
+		.base = WM5100_AUDIO_IF_2_1 - 1,
 		.playback = {
 			.stream_name = "AIF2 Playback",
 			.channels_min = 2,
@@ -2012,6 +1995,7 @@ static struct snd_soc_dai_driver wm5100_dai[] = {
 	{
 		.name = "wm5100-aif3",
 		.id = 2,
+		.base = WM5100_AUDIO_IF_3_1 - 1,
 		.playback = {
 			.stream_name = "AIF3 Playback",
 			.channels_min = 2,
-- 
1.7.10
