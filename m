From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 21/29] ASoC: wm8995: Replace w->codec
	snd_soc_dapm_to_codec(w->dapm)
Date: Tue, 13 Jan 2015 10:27:27 +0100
Message-ID: <1421141255-21477-21-git-send-email-lars@metafoo.de>
References: <1421141255-21477-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-210.synserver.de
 [212.40.185.210])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E442261A28
 for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2015 10:28:04 +0100 (CET)
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
 sound/soc/codecs/wm8994.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 1b97de2..4fbc768 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -249,7 +249,8 @@ static int configure_clock(struct snd_soc_codec *codec)
 static int check_clk_sys(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
-	int reg = snd_soc_read(source->codec, WM8994_CLOCKING_1);
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
+	int reg = snd_soc_read(codec, WM8994_CLOCKING_1);
 	const char *clk;
 
 	/* Check what we're currently using for CLK_SYS */
@@ -806,7 +807,7 @@ static void active_dereference(struct snd_soc_codec *codec)
 static int clk_sys_event(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
 	switch (event) {
@@ -981,7 +982,7 @@ static void vmid_dereference(struct snd_soc_codec *codec)
 static int vmid_event(struct snd_soc_dapm_widget *w,
 		      struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -1037,7 +1038,7 @@ static bool wm8994_check_class_w_digital(struct snd_soc_codec *codec)
 static int aif1clk_ev(struct snd_soc_dapm_widget *w,
 		      struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	struct wm8994 *control = wm8994->wm8994;
 	int mask = WM8994_AIF1DAC1L_ENA | WM8994_AIF1DAC1R_ENA;
@@ -1135,7 +1136,7 @@ static int aif1clk_ev(struct snd_soc_dapm_widget *w,
 static int aif2clk_ev(struct snd_soc_dapm_widget *w,
 		      struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	int i;
 	int dac;
 	int adc;
@@ -1220,7 +1221,7 @@ static int aif2clk_ev(struct snd_soc_dapm_widget *w,
 static int aif1clk_late_ev(struct snd_soc_dapm_widget *w,
 			   struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
 	switch (event) {
@@ -1238,7 +1239,7 @@ static int aif1clk_late_ev(struct snd_soc_dapm_widget *w,
 static int aif2clk_late_ev(struct snd_soc_dapm_widget *w,
 			   struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
 	switch (event) {
@@ -1256,7 +1257,7 @@ static int aif2clk_late_ev(struct snd_soc_dapm_widget *w,
 static int late_enable_ev(struct snd_soc_dapm_widget *w,
 			  struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
 	switch (event) {
@@ -1289,7 +1290,7 @@ static int late_enable_ev(struct snd_soc_dapm_widget *w,
 static int late_disable_ev(struct snd_soc_dapm_widget *w,
 			   struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
 	switch (event) {
@@ -1331,7 +1332,7 @@ static int micbias_ev(struct snd_soc_dapm_widget *w,
 static int dac_ev(struct snd_soc_dapm_widget *w,
 		  struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	unsigned int mask = 1 << w->shift;
 
 	snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_5,
@@ -1372,7 +1373,7 @@ SOC_DAPM_SINGLE("DAC1 Switch", WM8994_SPEAKER_MIXER, 0, 1, 0),
 static int post_ev(struct snd_soc_dapm_widget *w,
 	    struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = w->codec;
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	dev_dbg(codec->dev, "SRC status: %x\n",
 		snd_soc_read(codec,
 			     WM8994_RATE_STATUS));
-- 
1.8.0
