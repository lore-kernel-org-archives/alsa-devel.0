From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: codecs: Replace instances of rtd->codec
	with dai->codec
Date: Thu, 13 Mar 2014 21:24:54 +0100
Message-ID: <1394742294-14698-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-088.synserver.de (smtp-out-118.synserver.de
 [212.40.185.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 45A9F265482
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 21:24:26 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, patches@opensource.wolfsonmicro.com, Jyri Sarha <jsarha@ti.com>, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, M R Swami Reddy <mr.swami.reddy@ti.com>, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

With CODEC to CODEC links rtd->codec does not necessarily point to the driver's
CODEC. CODEC drivers should always use dai->codec and never even look at the PCM
runtime.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/isabelle.c      | 3 +--
 sound/soc/codecs/mc13783.c       | 6 ++----
 sound/soc/codecs/rt5640.c        | 3 +--
 sound/soc/codecs/sta529.c        | 3 +--
 sound/soc/codecs/tlv320aic31xx.c | 5 ++---
 sound/soc/codecs/uda134x.c       | 3 +--
 sound/soc/codecs/uda1380.c       | 3 +--
 sound/soc/codecs/wm8580.c        | 3 +--
 8 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/isabelle.c b/sound/soc/codecs/isabelle.c
index 3e264a7..3a89ce6 100644
--- a/sound/soc/codecs/isabelle.c
+++ b/sound/soc/codecs/isabelle.c
@@ -918,8 +918,7 @@ static int isabelle_hw_params(struct snd_pcm_substream *substream,
 			      struct snd_pcm_hw_params *params,
 			      struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	u16 aif = 0;
 	unsigned int fs_val = 0;
 
diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index 37d737e..2c59b1f 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -106,8 +106,7 @@ static int mc13783_pcm_hw_params_dac(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	unsigned int rate = params_rate(params);
 	int i;
 
@@ -126,8 +125,7 @@ static int mc13783_pcm_hw_params_codec(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	unsigned int rate = params_rate(params);
 	unsigned int val;
 
diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 13ccee4..0061ae6 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1594,8 +1594,7 @@ static int get_clk_info(int sclk, int rate)
 static int rt5640_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
 	unsigned int val_len = 0, val_clk, mask_clk;
 	int dai_sel, pre_div, bclk_ms, frame_size;
diff --git a/sound/soc/codecs/sta529.c b/sound/soc/codecs/sta529.c
index a3c61d3..a40c4b0 100644
--- a/sound/soc/codecs/sta529.c
+++ b/sound/soc/codecs/sta529.c
@@ -193,8 +193,7 @@ static int sta529_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params,
 		struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	int pdata, play_freq_val, record_freq_val;
 	int bclk_to_fs_ratio;
 
diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index d3517a9..cc1c9c2 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -753,10 +753,9 @@ static int aic31xx_setup_pll(struct snd_soc_codec *codec,
 
 static int aic31xx_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params,
-			     struct snd_soc_dai *tmp)
+			     struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	u8 data = 0;
 
 	dev_dbg(codec->dev, "## %s: format %d width %d rate %d\n",
diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index c94d4c1..edf27ac 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -203,8 +203,7 @@ static int uda134x_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params,
 	struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct uda134x_priv *uda134x = snd_soc_codec_get_drvdata(codec);
 	u8 hw_params;
 
diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 4dadaa8..e62e707 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -566,8 +566,7 @@ static int uda1380_pcm_hw_params(struct snd_pcm_substream *substream,
 static void uda1380_pcm_shutdown(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	u16 clk = uda1380_read_reg_cache(codec, UDA1380_CLK);
 
 	/* shut down WSPLL power if running from this clock */
diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 7558c83..af7ed8b 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -504,8 +504,7 @@ static int wm8580_paif_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct wm8580_priv *wm8580 = snd_soc_codec_get_drvdata(codec);
 	u16 paifa = 0;
 	u16 paifb = 0;
-- 
1.8.0
