From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Allow source specification for CODEC
	level sysclk
Date: Wed, 24 Aug 2011 20:09:38 +0100
Message-ID: <1314212978-18293-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C7BE824414
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 21:09:40 +0200 (CEST)
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

Similarly to PLLs/FLLs some modern CODECs provide selectable system clock
sources. When the clock is the clock for a DAI we do not usually need to
identify which clock is being configured so can use clk_id for the source
clock but with CODEC wide system clocks we will need to specify both the
clock being configured and the source.

Add a source argument to the CODEC driver set_sysclk() operation to
reflect this. As this operation is not as widely used as the DAI
set_sysclk() operation the change is not very invasive. We probably
ought to go and make the same alternation for DAIs at some point.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h          |    4 ++--
 sound/soc/codecs/wm9081.c    |    4 ++--
 sound/soc/samsung/speyside.c |    2 +-
 sound/soc/soc-core.c         |    8 +++++---
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 0fc8f15..24e17be 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -276,7 +276,7 @@ enum snd_soc_pcm_subclass {
 };
 
 int snd_soc_codec_set_sysclk(struct snd_soc_codec *codec, int clk_id,
-			     unsigned int freq, int dir);
+			     int source, unsigned int freq, int dir);
 int snd_soc_codec_set_pll(struct snd_soc_codec *codec, int pll_id, int source,
 			  unsigned int freq_in, unsigned int freq_out);
 
@@ -610,7 +610,7 @@ struct snd_soc_codec_driver {
 
 	/* codec wide operations */
 	int (*set_sysclk)(struct snd_soc_codec *codec,
-			  int clk_id, unsigned int freq, int dir);
+			  int clk_id, int source, unsigned int freq, int dir);
 	int (*set_pll)(struct snd_soc_codec *codec, int pll_id, int source,
 		unsigned int freq_in, unsigned int freq_out);
 
diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index a469132..f32ab1e 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -1120,8 +1120,8 @@ static int wm9081_digital_mute(struct snd_soc_dai *codec_dai, int mute)
 	return 0;
 }
 
-static int wm9081_set_sysclk(struct snd_soc_codec *codec,
-			     int clk_id, unsigned int freq, int dir)
+static int wm9081_set_sysclk(struct snd_soc_codec *codec, int clk_id,
+			     int source, unsigned int freq, int dir)
 {
 	struct wm9081_priv *wm9081 = snd_soc_codec_get_drvdata(codec);
 
diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index 12e60e3..401ca22 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -223,7 +223,7 @@ static int speyside_wm9081_init(struct snd_soc_dapm_context *dapm)
 	snd_soc_dapm_nc_pin(dapm, "LINEOUT");
 
 	/* At any time the WM9081 is active it will have this clock */
-	return snd_soc_codec_set_sysclk(dapm->codec, WM9081_SYSCLK_MCLK,
+	return snd_soc_codec_set_sysclk(dapm->codec, WM9081_SYSCLK_MCLK, 0,
 					48000 * 256, 0);
 }
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index fd173f6..187ddfd 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2670,7 +2670,7 @@ int snd_soc_dai_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	if (dai->driver && dai->driver->ops->set_sysclk)
 		return dai->driver->ops->set_sysclk(dai, clk_id, freq, dir);
 	else if (dai->codec && dai->codec->driver->set_sysclk)
-		return dai->codec->driver->set_sysclk(dai->codec, clk_id,
+		return dai->codec->driver->set_sysclk(dai->codec, clk_id, 0,
 						      freq, dir);
 	else
 		return -EINVAL;
@@ -2681,16 +2681,18 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_sysclk);
  * snd_soc_codec_set_sysclk - configure CODEC system or master clock.
  * @codec: CODEC
  * @clk_id: DAI specific clock ID
+ * @source: Source for the clock
  * @freq: new clock frequency in Hz
  * @dir: new clock direction - input/output.
  *
  * Configures the CODEC master (MCLK) or system (SYSCLK) clocking.
  */
 int snd_soc_codec_set_sysclk(struct snd_soc_codec *codec, int clk_id,
-	unsigned int freq, int dir)
+			     int source, unsigned int freq, int dir)
 {
 	if (codec->driver->set_sysclk)
-		return codec->driver->set_sysclk(codec, clk_id, freq, dir);
+		return codec->driver->set_sysclk(codec, clk_id, source,
+						 freq, dir);
 	else
 		return -EINVAL;
 }
-- 
1.7.5.4
