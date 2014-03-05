From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/7] ASoC: Add helper function to check whether
	a CODEC is active
Date: Wed,  5 Mar 2014 13:17:45 +0100
Message-ID: <1394021868-11860-4-git-send-email-lars@metafoo.de>
References: <1394021868-11860-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-014.synserver.de (smtp-out-163.synserver.de
 [212.40.185.163])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AD55265099
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 13:17:20 +0100 (CET)
In-Reply-To: <1394021868-11860-1-git-send-email-lars@metafoo.de>
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
Cc: Viresh Kumar <viresh.kumar@linaro.org>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Instead of directly checking the 'active' field of the CODEC struct add a new
helper function that will return either true or false depending on whether the
CODEC is active. This will make the migration to the component level easier.

The patch also updates all CODEC drivers that check the active attribute to use
the new helper function.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h            | 5 +++++
 sound/soc/codecs/adav80x.c     | 4 ++--
 sound/soc/codecs/tlv320aic23.c | 2 +-
 sound/soc/codecs/tlv320dac33.c | 2 +-
 sound/soc/codecs/uda1380.c     | 2 +-
 sound/soc/codecs/wl1273.c      | 2 +-
 sound/soc/codecs/wm8711.c      | 2 +-
 sound/soc/codecs/wm8753.c      | 4 ++--
 8 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 53d15e0..5c2b4f4 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1172,6 +1172,11 @@ static inline bool snd_soc_volsw_is_stereo(struct soc_mixer_control *mc)
 	return 1;
 }
 
+static inline bool snd_soc_codec_is_active(struct snd_soc_codec *codec)
+{
+	return codec->active != 0;
+}
+
 int snd_soc_util_init(void);
 void snd_soc_util_exit(void);
 
diff --git a/sound/soc/codecs/adav80x.c b/sound/soc/codecs/adav80x.c
index f78b27a..d50cf5b 100644
--- a/sound/soc/codecs/adav80x.c
+++ b/sound/soc/codecs/adav80x.c
@@ -722,7 +722,7 @@ static int adav80x_dai_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = dai->codec;
 	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
 
-	if (!codec->active || !adav80x->rate)
+	if (!snd_soc_codec_is_active(codec) || !adav80x->rate)
 		return 0;
 
 	return snd_pcm_hw_constraint_minmax(substream->runtime,
@@ -735,7 +735,7 @@ static void adav80x_dai_shutdown(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = dai->codec;
 	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
 
-	if (!codec->active)
+	if (!snd_soc_codec_is_active(codec))
 		adav80x->rate = 0;
 }
 
diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 5d430cc..458a6ae 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -400,7 +400,7 @@ static void tlv320aic23_shutdown(struct snd_pcm_substream *substream,
 	struct aic23 *aic23 = snd_soc_codec_get_drvdata(codec);
 
 	/* deactivate */
-	if (!codec->active) {
+	if (!snd_soc_codec_is_active(codec)) {
 		udelay(50);
 		snd_soc_write(codec, TLV320AIC23_ACTIVE, 0x0);
 	}
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 4f35839..35b2d24 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -461,7 +461,7 @@ static int dac33_set_fifo_mode(struct snd_kcontrol *kcontrol,
 	if (dac33->fifo_mode == ucontrol->value.integer.value[0])
 		return 0;
 	/* Do not allow changes while stream is running*/
-	if (codec->active)
+	if (snd_soc_codec_is_active(codec))
 		return -EPERM;
 
 	if (ucontrol->value.integer.value[0] < 0 ||
diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 726df6d..8e3940d 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -108,7 +108,7 @@ static int uda1380_write(struct snd_soc_codec *codec, unsigned int reg,
 	/* the interpolator & decimator regs must only be written when the
 	 * codec DAI is active.
 	 */
-	if (!codec->active && (reg >= UDA1380_MVOL))
+	if (!snd_soc_codec_is_active(codec) && (reg >= UDA1380_MVOL))
 		return 0;
 	pr_debug("uda1380: hw write %x val %x\n", reg, value);
 	if (codec->hw_write(codec->control_data, data, 3) == 3) {
diff --git a/sound/soc/codecs/wl1273.c b/sound/soc/codecs/wl1273.c
index b7ab2ef..47e96ff 100644
--- a/sound/soc/codecs/wl1273.c
+++ b/sound/soc/codecs/wl1273.c
@@ -197,7 +197,7 @@ static int snd_wl1273_set_audio_route(struct snd_kcontrol *kcontrol,
 		return 0;
 
 	/* Do not allow changes while stream is running */
-	if (codec->active)
+	if (snd_soc_codec_is_active(codec))
 		return -EPERM;
 
 	if (ucontrol->value.integer.value[0] < 0 ||
diff --git a/sound/soc/codecs/wm8711.c b/sound/soc/codecs/wm8711.c
index d99f948..6efcc40 100644
--- a/sound/soc/codecs/wm8711.c
+++ b/sound/soc/codecs/wm8711.c
@@ -201,7 +201,7 @@ static void wm8711_shutdown(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = dai->codec;
 
 	/* deactivate */
-	if (!codec->active) {
+	if (!snd_soc_codec_is_active(codec)) {
 		udelay(50);
 		snd_soc_write(codec, WM8711_ACTIVE, 0x0);
 	}
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index be85da9..5cf4beb 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -251,7 +251,7 @@ static int wm8753_set_dai(struct snd_kcontrol *kcontrol,
 	if (wm8753->dai_func == ucontrol->value.integer.value[0])
 		return 0;
 
-	if (codec->active)
+	if (snd_soc_codec_is_active(codec))
 		return -EBUSY;
 
 	ioctl = snd_soc_read(codec, WM8753_IOCTL);
@@ -1314,7 +1314,7 @@ static int wm8753_mute(struct snd_soc_dai *dai, int mute)
 	/* the digital mute covers the HiFi and Voice DAC's on the WM8753.
 	 * make sure we check if they are not both active when we mute */
 	if (mute && wm8753->dai_func == 1) {
-		if (!codec->active)
+		if (!snd_soc_codec_is_active(codec))
 			snd_soc_write(codec, WM8753_DAC, mute_reg | 0x8);
 	} else {
 		if (mute)
-- 
1.8.0
