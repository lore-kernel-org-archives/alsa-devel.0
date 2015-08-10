From: mengdong.lin@intel.com
Subject: [RFC PATCH 01/10] ASoC: change the PCM runtime array
	to a list
Date: Mon, 10 Aug 2015 14:12:35 +0800
Message-ID: <1439187155-961-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 6749A265171
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 07:59:20 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Mengdong Lin <mengdong.lin@intel.com>, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

Currently the number of DAI links is statically defined by the machine
driver at build time using an array. This makes it difficult to shrink/
grow the number of DAI links at runtime in order to reflect any changes
in topology.

We can change the DAI link array in the core to a list so that PCMs and
FE DAI links can be added and deleted at runtime to reflect changes in
use case and DSP topology. The machine driver can still register DAI links
as an array.

As the 1st step, this patch change the PCM runtime array to a list. A new
PCM runtime is added to the list when a DAI link is bound successfully.

Later patches will further implement the DAI link list.

More:
- define snd_soc_new/free_pcm_runtime() to create/free a runtime.
- define soc_add_pcm_runtime() to add a runtime to the rtd list.
- define soc_remove_pcm_runtimes() to clean up the runtime list.

- traverse the rtd list to probe the link components and dais.

- Add a field "num" to PCM runtime struct, used to specify the device
  number when creating the pcm device, and for a simple card to access
  its dai_props array.

- The following 3rd party machine/platform drivers either iterate the rtd
  list or use snd_soc_get_pcm_runtime() to access a rtd:

  intel/atom/sst-mfld-platform-pcm.c
  intel/boards/cht_bsw_rt5672
  intel/boards/cht_bsw_rt5645
  fsl/imx-wm8962.c
  fsl/fsl-asoc-card.c
  samsung/bells.c
  samsung/littlemill.c
  samsung/odroidx2_max98090.c
  samsung/snow.c
  samsung/speyside.c
  samsung/tobermory.c
  pxa/mioa701_wm9713.c
  tegra/tegra_wm8903.c

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4cef20e..e2b7b0f 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1080,7 +1080,7 @@ struct snd_soc_card {
 	/* CPU <--> Codec DAI links  */
 	struct snd_soc_dai_link *dai_link;
 	int num_links;
-	struct snd_soc_pcm_runtime *rtd;
+	struct list_head rtd_list;
 	int num_rtd;
 
 	/* optional codec specific configuration */
@@ -1175,6 +1175,9 @@ struct snd_soc_pcm_runtime {
 	struct dentry *debugfs_dpcm_root;
 	struct dentry *debugfs_dpcm_state;
 #endif
+
+	unsigned int num; /* 0-based and monotonic increasing */
+	struct list_head list; /* rtd list of the soc card */
 };
 
 /* mixer control */
diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index de43887..b80cf09 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -211,12 +211,15 @@ static int fsl_asoc_card_set_bias_level(struct snd_soc_card *card,
 					enum snd_soc_bias_level level)
 {
 	struct fsl_asoc_card_priv *priv = snd_soc_card_get_drvdata(card);
-	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai *codec_dai;
 	struct codec_priv *codec_priv = &priv->codec_priv;
 	struct device *dev = card->dev;
 	unsigned int pll_out;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
+	codec_dai = rtd->codec_dai;
 	if (dapm->dev != codec_dai->dev)
 		return 0;
 
@@ -383,11 +386,14 @@ static int fsl_asoc_card_audmux_init(struct device_node *np,
 static int fsl_asoc_card_late_probe(struct snd_soc_card *card)
 {
 	struct fsl_asoc_card_priv *priv = snd_soc_card_get_drvdata(card);
-	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai *codec_dai;
 	struct codec_priv *codec_priv = &priv->codec_priv;
 	struct device *dev = card->dev;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
+	codec_dai = rtd->codec_dai;
 	ret = snd_soc_dai_set_sysclk(codec_dai, codec_priv->mclk_id,
 				     codec_priv->mclk_freq, SND_SOC_CLOCK_IN);
 	if (ret) {
diff --git a/sound/soc/fsl/imx-wm8962.c b/sound/soc/fsl/imx-wm8962.c
index b38b98c..201a70d 100644
--- a/sound/soc/fsl/imx-wm8962.c
+++ b/sound/soc/fsl/imx-wm8962.c
@@ -69,13 +69,16 @@ static int imx_wm8962_set_bias_level(struct snd_soc_card *card,
 					struct snd_soc_dapm_context *dapm,
 					enum snd_soc_bias_level level)
 {
-	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai *codec_dai;
 	struct imx_priv *priv = &card_priv;
 	struct imx_wm8962_data *data = snd_soc_card_get_drvdata(card);
 	struct device *dev = &priv->pdev->dev;
 	unsigned int pll_out;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
+	codec_dai = rtd->codec_dai;
 	if (dapm->dev != codec_dai->dev)
 		return 0;
 
@@ -135,12 +138,15 @@ static int imx_wm8962_set_bias_level(struct snd_soc_card *card,
 
 static int imx_wm8962_late_probe(struct snd_soc_card *card)
 {
-	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai *codec_dai;
 	struct imx_priv *priv = &card_priv;
 	struct imx_wm8962_data *data = snd_soc_card_get_drvdata(card);
 	struct device *dev = &priv->pdev->dev;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
+	codec_dai = rtd->codec_dai;
 	ret = snd_soc_dai_set_sysclk(codec_dai, WM8962_SYSCLK_MCLK,
 			data->clk_frequency, SND_SOC_CLOCK_IN);
 	if (ret < 0)
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 3ff76d4..95a2f91 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -45,7 +45,7 @@ static int asoc_simple_card_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct simple_card_data *priv =	snd_soc_card_get_drvdata(rtd->card);
 	struct simple_dai_props *dai_props =
-		&priv->dai_props[rtd - rtd->card->rtd];
+		&priv->dai_props[rtd->num];
 	int ret;
 
 	ret = clk_prepare_enable(dai_props->cpu_dai.clk);
@@ -64,7 +64,7 @@ static void asoc_simple_card_shutdown(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct simple_card_data *priv =	snd_soc_card_get_drvdata(rtd->card);
 	struct simple_dai_props *dai_props =
-		&priv->dai_props[rtd - rtd->card->rtd];
+		&priv->dai_props[rtd->num];
 
 	clk_disable_unprepare(dai_props->cpu_dai.clk);
 
@@ -78,8 +78,7 @@ static int asoc_simple_card_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct simple_card_data *priv = snd_soc_card_get_drvdata(rtd->card);
-	struct simple_dai_props *dai_props =
-		&priv->dai_props[rtd - rtd->card->rtd];
+	struct simple_dai_props *dai_props = &priv->dai_props[rtd->num];
 	unsigned int mclk, mclk_fs = 0;
 	int ret = 0;
 
@@ -172,10 +171,9 @@ static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_dai *codec = rtd->codec_dai;
 	struct snd_soc_dai *cpu = rtd->cpu_dai;
 	struct simple_dai_props *dai_props;
-	int num, ret;
+	int ret;
 
-	num = rtd - rtd->card->rtd;
-	dai_props = &priv->dai_props[num];
+	dai_props = &priv->dai_props[rtd->num];
 	ret = __asoc_simple_card_dai_init(codec, &dai_props->codec_dai);
 	if (ret < 0)
 		return ret;
diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index 683e501..5ae8ae2 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -777,15 +777,15 @@ static int sst_platform_remove(struct platform_device *pdev)
 static int sst_soc_prepare(struct device *dev)
 {
 	struct sst_data *drv = dev_get_drvdata(dev);
-	int i;
+	struct snd_soc_pcm_runtime *rtd;
 
 	/* suspend all pcms first */
 	snd_soc_suspend(drv->soc_card->dev);
 	snd_soc_poweroff(drv->soc_card->dev);
 
 	/* set the SSPs to idle */
-	for (i = 0; i < drv->soc_card->num_rtd; i++) {
-		struct snd_soc_dai *dai = drv->soc_card->rtd[i].cpu_dai;
+	list_for_each_entry(rtd, &drv->soc_card->rtd_list, list) {
+		struct snd_soc_dai *dai = rtd->cpu_dai;
 
 		if (dai->active) {
 			send_ssp_cmd(dai, dai->name, 0);
@@ -799,11 +799,11 @@ static int sst_soc_prepare(struct device *dev)
 static void sst_soc_complete(struct device *dev)
 {
 	struct sst_data *drv = dev_get_drvdata(dev);
-	int i;
+	struct snd_soc_pcm_runtime *rtd;
 
 	/* restart SSPs */
-	for (i = 0; i < drv->soc_card->num_rtd; i++) {
-		struct snd_soc_dai *dai = drv->soc_card->rtd[i].cpu_dai;
+	list_for_each_entry(rtd, &drv->soc_card->rtd_list, list) {
+		struct snd_soc_dai *dai = rtd->cpu_dai;
 
 		if (dai->active) {
 			sst_handle_vb_timer(dai, true);
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index bdcaf46..fade1a2 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -47,12 +47,9 @@ struct cht_mc_private {
 
 static inline struct snd_soc_dai *cht_get_codec_dai(struct snd_soc_card *card)
 {
-	int i;
-
-	for (i = 0; i < card->num_rtd; i++) {
-		struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_pcm_runtime *rtd;
 
-		rtd = card->rtd + i;
+	list_for_each_entry(rtd, &card->rtd_list, list) {
 		if (!strncmp(rtd->codec_dai->name, CHT_CODEC_DAI,
 			     strlen(CHT_CODEC_DAI)))
 			return rtd->codec_dai;
diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index 2c9cc5b..fee43bd 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -46,12 +46,9 @@ static struct snd_soc_jack_pin cht_bsw_headset_pins[] = {
 
 static inline struct snd_soc_dai *cht_get_codec_dai(struct snd_soc_card *card)
 {
-	int i;
+	struct snd_soc_pcm_runtime *rtd;
 
-	for (i = 0; i < card->num_rtd; i++) {
-		struct snd_soc_pcm_runtime *rtd;
-
-		rtd = card->rtd + i;
+	list_for_each_entry(rtd, &card->rtd_list, list) {
 		if (!strncmp(rtd->codec_dai->name, CHT_CODEC_DAI,
 			     strlen(CHT_CODEC_DAI)))
 			return rtd->codec_dai;
diff --git a/sound/soc/pxa/mioa701_wm9713.c b/sound/soc/pxa/mioa701_wm9713.c
index a9615a57..4f6cafe 100644
--- a/sound/soc/pxa/mioa701_wm9713.c
+++ b/sound/soc/pxa/mioa701_wm9713.c
@@ -81,8 +81,12 @@ static int rear_amp_power(struct snd_soc_codec *codec, int power)
 static int rear_amp_event(struct snd_soc_dapm_widget *widget,
 			  struct snd_kcontrol *kctl, int event)
 {
-	struct snd_soc_codec *codec = widget->dapm->card->rtd[0].codec;
+	struct snd_soc_card *card = widget->dapm->card;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_codec *codec;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
+	codec = rtd->codec;
 	return rear_amp_power(codec, SND_SOC_DAPM_EVENT_ON(event));
 }
 
diff --git a/sound/soc/samsung/bells.c b/sound/soc/samsung/bells.c
index e5f05e6..3dd246f 100644
--- a/sound/soc/samsung/bells.c
+++ b/sound/soc/samsung/bells.c
@@ -58,11 +58,16 @@ static int bells_set_bias_level(struct snd_soc_card *card,
 				struct snd_soc_dapm_context *dapm,
 				enum snd_soc_bias_level level)
 {
-	struct snd_soc_dai *codec_dai = card->rtd[DAI_DSP_CODEC].codec_dai;
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai *codec_dai;
+	struct snd_soc_codec *codec;
 	struct bells_drvdata *bells = card->drvdata;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[DAI_DSP_CODEC].name);
+	codec_dai = rtd->codec_dai;
+	codec = codec_dai->codec;
+
 	if (dapm->dev != codec_dai->dev)
 		return 0;
 
@@ -99,11 +104,16 @@ static int bells_set_bias_level_post(struct snd_soc_card *card,
 				     struct snd_soc_dapm_context *dapm,
 				     enum snd_soc_bias_level level)
 {
-	struct snd_soc_dai *codec_dai = card->rtd[DAI_DSP_CODEC].codec_dai;
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai *codec_dai;
+	struct snd_soc_codec *codec;
 	struct bells_drvdata *bells = card->drvdata;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[DAI_DSP_CODEC].name);
+	codec_dai = rtd->codec_dai;
+	codec = codec_dai->codec;
+
 	if (dapm->dev != codec_dai->dev)
 		return 0;
 
@@ -137,14 +147,22 @@ static int bells_set_bias_level_post(struct snd_soc_card *card,
 static int bells_late_probe(struct snd_soc_card *card)
 {
 	struct bells_drvdata *bells = card->drvdata;
-	struct snd_soc_codec *wm0010 = card->rtd[DAI_AP_DSP].codec;
-	struct snd_soc_codec *codec = card->rtd[DAI_DSP_CODEC].codec;
-	struct snd_soc_dai *aif1_dai = card->rtd[DAI_DSP_CODEC].codec_dai;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_codec *wm0010;
+	struct snd_soc_codec *codec;
+	struct snd_soc_dai *aif1_dai;
 	struct snd_soc_dai *aif2_dai;
 	struct snd_soc_dai *aif3_dai;
 	struct snd_soc_dai *wm9081_dai;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[DAI_AP_DSP].name);
+	wm0010 = rtd->codec;
+
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[DAI_DSP_CODEC].name);
+	codec = rtd->codec;
+	aif1_dai = rtd->codec_dai;
+
 	ret = snd_soc_codec_set_sysclk(codec, ARIZONA_CLK_SYSCLK,
 				       ARIZONA_CLK_SRC_FLL1,
 				       bells->sysclk_rate,
@@ -181,7 +199,8 @@ static int bells_late_probe(struct snd_soc_card *card)
 		return ret;
 	}
 
-	aif2_dai = card->rtd[DAI_CODEC_CP].cpu_dai;
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[DAI_CODEC_CP].name);
+	aif2_dai = rtd->cpu_dai;
 
 	ret = snd_soc_dai_set_sysclk(aif2_dai, ARIZONA_CLK_ASYNCCLK, 0, 0);
 	if (ret != 0) {
@@ -192,8 +211,9 @@ static int bells_late_probe(struct snd_soc_card *card)
 	if (card->num_rtd == DAI_CODEC_SUB)
 		return 0;
 
-	aif3_dai = card->rtd[DAI_CODEC_SUB].cpu_dai;
-	wm9081_dai = card->rtd[DAI_CODEC_SUB].codec_dai;
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[DAI_CODEC_SUB].name);
+	aif3_dai = rtd->cpu_dai;
+	wm9081_dai = rtd->codec_dai;
 
 	ret = snd_soc_dai_set_sysclk(aif3_dai, ARIZONA_CLK_SYSCLK, 0, 0);
 	if (ret != 0) {
diff --git a/sound/soc/samsung/littlemill.c b/sound/soc/samsung/littlemill.c
index 31a820e..7cb204e 100644
--- a/sound/soc/samsung/littlemill.c
+++ b/sound/soc/samsung/littlemill.c
@@ -23,9 +23,13 @@ static int littlemill_set_bias_level(struct snd_soc_card *card,
 					  struct snd_soc_dapm_context *dapm,
 					  enum snd_soc_bias_level level)
 {
-	struct snd_soc_dai *aif1_dai = card->rtd[0].codec_dai;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai *aif1_dai;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
+	aif1_dai = rtd->codec_dai;
+
 	if (dapm->dev != aif1_dai->dev)
 		return 0;
 
@@ -66,9 +70,13 @@ static int littlemill_set_bias_level_post(struct snd_soc_card *card,
 					       struct snd_soc_dapm_context *dapm,
 					       enum snd_soc_bias_level level)
 {
-	struct snd_soc_dai *aif1_dai = card->rtd[0].codec_dai;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai *aif1_dai;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
+	aif1_dai = rtd->codec_dai;
+
 	if (dapm->dev != aif1_dai->dev)
 		return 0;
 
@@ -168,9 +176,13 @@ static int bbclk_ev(struct snd_soc_dapm_widget *w,
 		    struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_card *card = w->dapm->card;
-	struct snd_soc_dai *aif2_dai = card->rtd[1].cpu_dai;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai *aif2_dai;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[1].name);
+	aif2_dai = rtd->cpu_dai;
+
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		ret = snd_soc_dai_set_pll(aif2_dai, WM8994_FLL2,
@@ -245,11 +257,19 @@ static struct snd_soc_jack littlemill_headset;
 
 static int littlemill_late_probe(struct snd_soc_card *card)
 {
-	struct snd_soc_codec *codec = card->rtd[0].codec;
-	struct snd_soc_dai *aif1_dai = card->rtd[0].codec_dai;
-	struct snd_soc_dai *aif2_dai = card->rtd[1].cpu_dai;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_codec *codec;
+	struct snd_soc_dai *aif1_dai;
+	struct snd_soc_dai *aif2_dai;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
+	codec = rtd->codec;
+	aif1_dai = rtd->codec_dai;
+
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[1].name);
+	aif2_dai = rtd->cpu_dai;
+
 	ret = snd_soc_dai_set_sysclk(aif1_dai, WM8994_SYSCLK_MCLK2,
 				     32768, SND_SOC_CLOCK_IN);
 	if (ret < 0)
diff --git a/sound/soc/samsung/odroidx2_max98090.c b/sound/soc/samsung/odroidx2_max98090.c
index 596f118..0421727 100644
--- a/sound/soc/samsung/odroidx2_max98090.c
+++ b/sound/soc/samsung/odroidx2_max98090.c
@@ -25,10 +25,15 @@ static struct snd_soc_dai_link odroidx2_dai[];
 
 static int odroidx2_late_probe(struct snd_soc_card *card)
 {
-	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
-	struct snd_soc_dai *cpu_dai = card->rtd[0].cpu_dai;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai *codec_dai;
+	struct snd_soc_dai *cpu_dai;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
+	codec_dai = rtd->codec_dai;
+	cpu_dai = rtd->cpu_dai;
+
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0, MAX98090_MCLK,
 						SND_SOC_CLOCK_IN);
 
diff --git a/sound/soc/samsung/snow.c b/sound/soc/samsung/snow.c
index 7651dc9..0969577 100644
--- a/sound/soc/samsung/snow.c
+++ b/sound/soc/samsung/snow.c
@@ -35,10 +35,15 @@ static struct snd_soc_dai_link snow_dai[] = {
 
 static int snow_late_probe(struct snd_soc_card *card)
 {
-	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
-	struct snd_soc_dai *cpu_dai = card->rtd[0].cpu_dai;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai *codec_dai;
+	struct snd_soc_dai *cpu_dai;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
+	codec_dai = rtd->codec_dai;
+	cpu_dai = rtd->cpu_dai;
+
 	/* Set the MCLK rate for the codec */
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0,
 					FIN_PLL_RATE, SND_SOC_CLOCK_IN);
diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index d1ae21c..083ef5e 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -25,9 +25,13 @@ static int speyside_set_bias_level(struct snd_soc_card *card,
 				   struct snd_soc_dapm_context *dapm,
 				   enum snd_soc_bias_level level)
 {
-	struct snd_soc_dai *codec_dai = card->rtd[1].codec_dai;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai *codec_dai;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[1].name);
+	codec_dai = rtd->codec_dai;
+
 	if (dapm->dev != codec_dai->dev)
 		return 0;
 
@@ -57,9 +61,13 @@ static int speyside_set_bias_level_post(struct snd_soc_card *card,
 					struct snd_soc_dapm_context *dapm,
 					enum snd_soc_bias_level level)
 {
-	struct snd_soc_dai *codec_dai = card->rtd[1].codec_dai;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai *codec_dai;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[1].name);
+	codec_dai = rtd->codec_dai;
+
 	if (dapm->dev != codec_dai->dev)
 		return 0;
 
diff --git a/sound/soc/samsung/tobermory.c b/sound/soc/samsung/tobermory.c
index 85ccfb7..3310eda 100644
--- a/sound/soc/samsung/tobermory.c
+++ b/sound/soc/samsung/tobermory.c
@@ -23,9 +23,13 @@ static int tobermory_set_bias_level(struct snd_soc_card *card,
 					  struct snd_soc_dapm_context *dapm,
 					  enum snd_soc_bias_level level)
 {
-	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai *codec_dai;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
+	codec_dai = rtd->codec_dai;
+
 	if (dapm->dev != codec_dai->dev)
 		return 0;
 
@@ -62,9 +66,13 @@ static int tobermory_set_bias_level_post(struct snd_soc_card *card,
 					       struct snd_soc_dapm_context *dapm,
 					       enum snd_soc_bias_level level)
 {
-	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dai *codec_dai;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
+	codec_dai = rtd->codec_dai;
+
 	if (dapm->dev != codec_dai->dev)
 		return 0;
 
@@ -170,10 +178,15 @@ static struct snd_soc_jack_pin tobermory_headset_pins[] = {
 
 static int tobermory_late_probe(struct snd_soc_card *card)
 {
-	struct snd_soc_codec *codec = card->rtd[0].codec;
-	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_codec *codec;
+	struct snd_soc_dai *codec_dai;
 	int ret;
 
+	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
+	codec = rtd->codec;
+	codec_dai = rtd->codec_dai;
+
 	ret = snd_soc_dai_set_sysclk(codec_dai, WM8962_SYSCLK_MCLK,
 				     32768, SND_SOC_CLOCK_IN);
 	if (ret < 0)
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1b63a03..fb78674 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -537,26 +537,76 @@ static inline void snd_soc_debugfs_exit(void)
 struct snd_pcm_substream *snd_soc_get_dai_substream(struct snd_soc_card *card,
 		const char *dai_link, int stream)
 {
-	int i;
+	struct snd_soc_pcm_runtime *rtd;
 
-	for (i = 0; i < card->num_links; i++) {
-		if (card->rtd[i].dai_link->no_pcm &&
-			!strcmp(card->rtd[i].dai_link->name, dai_link))
-			return card->rtd[i].pcm->streams[stream].substream;
+	list_for_each_entry(rtd, &card->rtd_list, list) {
+		if (rtd->dai_link->no_pcm &&
+			!strcmp(rtd->dai_link->name, dai_link))
+			return rtd->pcm->streams[stream].substream;
 	}
 	dev_dbg(card->dev, "ASoC: failed to find dai link %s\n", dai_link);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(snd_soc_get_dai_substream);
 
+static struct snd_soc_pcm_runtime *soc_new_pcm_runtime(
+	struct snd_soc_card *card, struct snd_soc_dai_link *dai_link)
+{
+	struct snd_soc_pcm_runtime *rtd;
+
+	rtd = devm_kzalloc(card->dev,
+			sizeof(struct snd_soc_pcm_runtime), GFP_KERNEL);
+	if (!rtd)
+		return NULL;
+
+	rtd->card = card;
+	rtd->dai_link = dai_link;
+	rtd->codec_dais = devm_kzalloc(card->dev,
+					sizeof(struct snd_soc_dai *) *
+					dai_link->num_codecs,
+					GFP_KERNEL);
+	if (!rtd->codec_dais)
+		return NULL;
+
+	return rtd;
+}
+
+static void soc_free_pcm_runtime(struct snd_soc_card *card,
+	struct snd_soc_pcm_runtime *rtd)
+{
+	if (rtd->codec_dai)
+		devm_kfree(card->dev, rtd->codec_dais);
+	devm_kfree(card->dev, rtd);
+}
+
+static void soc_add_pcm_runtime(struct snd_soc_card *card,
+		struct snd_soc_pcm_runtime *rtd)
+{
+	list_add_tail(&rtd->list, &card->rtd_list);
+	rtd->num = card->num_rtd;
+	card->num_rtd++;
+}
+
+static void soc_remove_pcm_runtimes(struct snd_soc_card *card)
+{
+	struct snd_soc_pcm_runtime *rtd, *_rtd;
+
+	list_for_each_entry_safe(rtd, _rtd, &card->rtd_list, list) {
+		list_del(&rtd->list);
+		soc_free_pcm_runtime(card, rtd);
+	}
+
+	card->num_rtd = 0;
+}
+
 struct snd_soc_pcm_runtime *snd_soc_get_pcm_runtime(struct snd_soc_card *card,
 		const char *dai_link)
 {
-	int i;
+	struct snd_soc_pcm_runtime *rtd;
 
-	for (i = 0; i < card->num_links; i++) {
-		if (!strcmp(card->rtd[i].dai_link->name, dai_link))
-			return &card->rtd[i];
+	list_for_each_entry(rtd, &card->rtd_list, list) {
+		if (!strcmp(rtd->dai_link->name, dai_link))
+			return rtd;
 	}
 	dev_dbg(card->dev, "ASoC: failed to find rtd %s\n", dai_link);
 	return NULL;
@@ -578,7 +628,8 @@ int snd_soc_suspend(struct device *dev)
 {
 	struct snd_soc_card *card = dev_get_drvdata(dev);
 	struct snd_soc_codec *codec;
-	int i, j;
+	struct snd_soc_pcm_runtime *rtd;
+	int i;
 
 	/* If the card is not initialized yet there is nothing to do */
 	if (!card->instantiated)
@@ -595,13 +646,13 @@ int snd_soc_suspend(struct device *dev)
 	snd_power_change_state(card->snd_card, SNDRV_CTL_POWER_D3hot);
 
 	/* mute any active DACs */
-	for (i = 0; i < card->num_rtd; i++) {
+	list_for_each_entry(rtd, &card->rtd_list, list) {
 
-		if (card->rtd[i].dai_link->ignore_suspend)
+		if (rtd->dai_link->ignore_suspend)
 			continue;
 
-		for (j = 0; j < card->rtd[i].num_codecs; j++) {
-			struct snd_soc_dai *dai = card->rtd[i].codec_dais[j];
+		for (i = 0; i < rtd->num_codecs; i++) {
+			struct snd_soc_dai *dai = rtd->codec_dais[i];
 			struct snd_soc_dai_driver *drv = dai->driver;
 
 			if (drv->ops->digital_mute && dai->playback_active)
@@ -610,20 +661,20 @@ int snd_soc_suspend(struct device *dev)
 	}
 
 	/* suspend all pcms */
-	for (i = 0; i < card->num_rtd; i++) {
-		if (card->rtd[i].dai_link->ignore_suspend)
+	list_for_each_entry(rtd, &card->rtd_list, list) {
+		if (rtd->dai_link->ignore_suspend)
 			continue;
 
-		snd_pcm_suspend_all(card->rtd[i].pcm);
+		snd_pcm_suspend_all(rtd->pcm);
 	}
 
 	if (card->suspend_pre)
 		card->suspend_pre(card);
 
-	for (i = 0; i < card->num_rtd; i++) {
-		struct snd_soc_dai *cpu_dai = card->rtd[i].cpu_dai;
+	list_for_each_entry(rtd, &card->rtd_list, list) {
+		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 
-		if (card->rtd[i].dai_link->ignore_suspend)
+		if (rtd->dai_link->ignore_suspend)
 			continue;
 
 		if (cpu_dai->driver->suspend && !cpu_dai->driver->bus_control)
@@ -631,19 +682,19 @@ int snd_soc_suspend(struct device *dev)
 	}
 
 	/* close any waiting streams */
-	for (i = 0; i < card->num_rtd; i++)
-		flush_delayed_work(&card->rtd[i].delayed_work);
+	list_for_each_entry(rtd, &card->rtd_list, list)
+		flush_delayed_work(&rtd->delayed_work);
 
-	for (i = 0; i < card->num_rtd; i++) {
+	list_for_each_entry(rtd, &card->rtd_list, list) {
 
-		if (card->rtd[i].dai_link->ignore_suspend)
+		if (rtd->dai_link->ignore_suspend)
 			continue;
 
-		snd_soc_dapm_stream_event(&card->rtd[i],
+		snd_soc_dapm_stream_event(rtd,
 					  SNDRV_PCM_STREAM_PLAYBACK,
 					  SND_SOC_DAPM_STREAM_SUSPEND);
 
-		snd_soc_dapm_stream_event(&card->rtd[i],
+		snd_soc_dapm_stream_event(rtd,
 					  SNDRV_PCM_STREAM_CAPTURE,
 					  SND_SOC_DAPM_STREAM_SUSPEND);
 	}
@@ -690,10 +741,10 @@ int snd_soc_suspend(struct device *dev)
 		}
 	}
 
-	for (i = 0; i < card->num_rtd; i++) {
-		struct snd_soc_dai *cpu_dai = card->rtd[i].cpu_dai;
+	list_for_each_entry(rtd, &card->rtd_list, list) {
+		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 
-		if (card->rtd[i].dai_link->ignore_suspend)
+		if (rtd->dai_link->ignore_suspend)
 			continue;
 
 		if (cpu_dai->driver->suspend && cpu_dai->driver->bus_control)
@@ -717,8 +768,9 @@ static void soc_resume_deferred(struct work_struct *work)
 {
 	struct snd_soc_card *card =
 			container_of(work, struct snd_soc_card, deferred_resume_work);
+	struct snd_soc_pcm_runtime *rtd;
 	struct snd_soc_codec *codec;
-	int i, j;
+	int i;
 
 	/* our power state is still SNDRV_CTL_POWER_D3hot from suspend time,
 	 * so userspace apps are blocked from touching us
@@ -733,10 +785,10 @@ static void soc_resume_deferred(struct work_struct *work)
 		card->resume_pre(card);
 
 	/* resume control bus DAIs */
-	for (i = 0; i < card->num_rtd; i++) {
-		struct snd_soc_dai *cpu_dai = card->rtd[i].cpu_dai;
+	list_for_each_entry(rtd, &card->rtd_list, list) {
+		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 
-		if (card->rtd[i].dai_link->ignore_suspend)
+		if (rtd->dai_link->ignore_suspend)
 			continue;
 
 		if (cpu_dai->driver->resume && cpu_dai->driver->bus_control)
@@ -751,28 +803,28 @@ static void soc_resume_deferred(struct work_struct *work)
 		}
 	}
 
-	for (i = 0; i < card->num_rtd; i++) {
+	list_for_each_entry(rtd, &card->rtd_list, list) {
 
-		if (card->rtd[i].dai_link->ignore_suspend)
+		if (rtd->dai_link->ignore_suspend)
 			continue;
 
-		snd_soc_dapm_stream_event(&card->rtd[i],
+		snd_soc_dapm_stream_event(rtd,
 					  SNDRV_PCM_STREAM_PLAYBACK,
 					  SND_SOC_DAPM_STREAM_RESUME);
 
-		snd_soc_dapm_stream_event(&card->rtd[i],
+		snd_soc_dapm_stream_event(rtd,
 					  SNDRV_PCM_STREAM_CAPTURE,
 					  SND_SOC_DAPM_STREAM_RESUME);
 	}
 
 	/* unmute any active DACs */
-	for (i = 0; i < card->num_rtd; i++) {
+	list_for_each_entry(rtd, &card->rtd_list, list) {
 
-		if (card->rtd[i].dai_link->ignore_suspend)
+		if (rtd->dai_link->ignore_suspend)
 			continue;
 
-		for (j = 0; j < card->rtd[i].num_codecs; j++) {
-			struct snd_soc_dai *dai = card->rtd[i].codec_dais[j];
+		for (i = 0; i < rtd->num_codecs; i++) {
+			struct snd_soc_dai *dai = rtd->codec_dais[i];
 			struct snd_soc_dai_driver *drv = dai->driver;
 
 			if (drv->ops->digital_mute && dai->playback_active)
@@ -780,10 +832,10 @@ static void soc_resume_deferred(struct work_struct *work)
 		}
 	}
 
-	for (i = 0; i < card->num_rtd; i++) {
-		struct snd_soc_dai *cpu_dai = card->rtd[i].cpu_dai;
+	list_for_each_entry(rtd, &card->rtd_list, list) {
+		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 
-		if (card->rtd[i].dai_link->ignore_suspend)
+		if (rtd->dai_link->ignore_suspend)
 			continue;
 
 		if (cpu_dai->driver->resume && !cpu_dai->driver->bus_control)
@@ -808,15 +860,14 @@ int snd_soc_resume(struct device *dev)
 {
 	struct snd_soc_card *card = dev_get_drvdata(dev);
 	bool bus_control = false;
-	int i;
+	struct snd_soc_pcm_runtime *rtd;
 
 	/* If the card is not initialized yet there is nothing to do */
 	if (!card->instantiated)
 		return 0;
 
 	/* activate pins from sleep state */
-	for (i = 0; i < card->num_rtd; i++) {
-		struct snd_soc_pcm_runtime *rtd = &card->rtd[i];
+	list_for_each_entry(rtd, &card->rtd_list, list) {
 		struct snd_soc_dai **codec_dais = rtd->codec_dais;
 		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 		int j;
@@ -837,8 +888,8 @@ int snd_soc_resume(struct device *dev)
 	 * have that problem and may take a substantial amount of time to resume
 	 * due to I/O costs and anti-pop so handle them out of line.
 	 */
-	for (i = 0; i < card->num_rtd; i++) {
-		struct snd_soc_dai *cpu_dai = card->rtd[i].cpu_dai;
+	list_for_each_entry(rtd, &card->rtd_list, list) {
+		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 		bus_control |= cpu_dai->driver->bus_control;
 	}
 	if (bus_control) {
@@ -913,16 +964,26 @@ static struct snd_soc_dai *snd_soc_find_dai(
 static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 {
 	struct snd_soc_dai_link *dai_link = &card->dai_link[num];
-	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
+	struct snd_soc_pcm_runtime *rtd;
 	struct snd_soc_dai_link_component *codecs = dai_link->codecs;
 	struct snd_soc_dai_link_component cpu_dai_component;
-	struct snd_soc_dai **codec_dais = rtd->codec_dais;
+	struct snd_soc_dai **codec_dais;
 	struct snd_soc_platform *platform;
 	const char *platform_name;
 	int i;
 
 	dev_dbg(card->dev, "ASoC: binding %s at idx %d\n", dai_link->name, num);
 
+	if (snd_soc_get_pcm_runtime(card, dai_link->name)) {
+		dev_dbg(card->dev, "ASoC: dai link %s already bound\n",
+			dai_link->name);
+		return 0;
+	}
+
+	rtd = soc_new_pcm_runtime(card, dai_link);
+	if (!rtd)
+		return -ENOMEM;
+
 	cpu_dai_component.name = dai_link->cpu_name;
 	cpu_dai_component.of_node = dai_link->cpu_of_node;
 	cpu_dai_component.dai_name = dai_link->cpu_dai_name;
@@ -930,18 +991,19 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 	if (!rtd->cpu_dai) {
 		dev_err(card->dev, "ASoC: CPU DAI %s not registered\n",
 			dai_link->cpu_dai_name);
-		return -EPROBE_DEFER;
+		goto _err_defer;
 	}
 
 	rtd->num_codecs = dai_link->num_codecs;
 
 	/* Find CODEC from registered CODECs */
+	codec_dais = rtd->codec_dais;
 	for (i = 0; i < rtd->num_codecs; i++) {
 		codec_dais[i] = snd_soc_find_dai(&codecs[i]);
 		if (!codec_dais[i]) {
 			dev_err(card->dev, "ASoC: CODEC DAI %s not registered\n",
 				codecs[i].dai_name);
-			return -EPROBE_DEFER;
+			goto _err_defer;
 		}
 	}
 
@@ -973,9 +1035,12 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 		return -EPROBE_DEFER;
 	}
 
-	card->num_rtd++;
-
+	soc_add_pcm_runtime(card, rtd);
 	return 0;
+
+_err_defer:
+	soc_free_pcm_runtime(card, rtd);
+	return  -EPROBE_DEFER;
 }
 
 static void soc_remove_component(struct snd_soc_component *component)
@@ -1014,9 +1079,9 @@ static void soc_remove_dai(struct snd_soc_dai *dai, int order)
 	}
 }
 
-static void soc_remove_link_dais(struct snd_soc_card *card, int num, int order)
+static void soc_remove_link_dais(struct snd_soc_card *card,
+		struct snd_soc_pcm_runtime *rtd, int order)
 {
-	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
 	int i;
 
 	/* unregister the rtd device */
@@ -1032,10 +1097,9 @@ static void soc_remove_link_dais(struct snd_soc_card *card, int num, int order)
 	soc_remove_dai(rtd->cpu_dai, order);
 }
 
-static void soc_remove_link_components(struct snd_soc_card *card, int num,
-				       int order)
+static void soc_remove_link_components(struct snd_soc_card *card,
+	struct snd_soc_pcm_runtime *rtd, int order)
 {
-	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_component *component;
@@ -1061,21 +1125,20 @@ static void soc_remove_link_components(struct snd_soc_card *card, int num,
 
 static void soc_remove_dai_links(struct snd_soc_card *card)
 {
-	int dai, order;
+	int order;
+	struct snd_soc_pcm_runtime *rtd;
 
 	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
 			order++) {
-		for (dai = 0; dai < card->num_rtd; dai++)
-			soc_remove_link_dais(card, dai, order);
+		list_for_each_entry(rtd, &card->rtd_list, list)
+			soc_remove_link_dais(card, rtd, order);
 	}
 
 	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
 			order++) {
-		for (dai = 0; dai < card->num_rtd; dai++)
-			soc_remove_link_components(card, dai, order);
+		list_for_each_entry(rtd, &card->rtd_list, list)
+			soc_remove_link_components(card, rtd, order);
 	}
-
-	card->num_rtd = 0;
 }
 
 static void soc_set_name_prefix(struct snd_soc_card *card,
@@ -1220,10 +1283,10 @@ static int soc_post_component_init(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
-static int soc_probe_link_components(struct snd_soc_card *card, int num,
+static int soc_probe_link_components(struct snd_soc_card *card,
+			struct snd_soc_pcm_runtime *rtd,
 				     int order)
 {
-	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_component *component;
 	int i, ret;
@@ -1319,15 +1382,15 @@ static int soc_link_dai_widgets(struct snd_soc_card *card,
 	return 0;
 }
 
-static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
+static int soc_probe_link_dais(struct snd_soc_card *card,
+		struct snd_soc_pcm_runtime *rtd, int order)
 {
-	struct snd_soc_dai_link *dai_link = &card->dai_link[num];
-	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
+	struct snd_soc_dai_link *dai_link = rtd->dai_link;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int i, ret;
 
 	dev_dbg(card->dev, "ASoC: probe %s dai link %d late %d\n",
-			card->name, num, order);
+			card->name, rtd->num, order);
 
 	/* set default power off timeout */
 	rtd->pmdown_time = pmdown_time;
@@ -1372,7 +1435,7 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 
 	if (cpu_dai->driver->compress_dai) {
 		/*create compress_device"*/
-		ret = soc_new_compress(rtd, num);
+		ret = soc_new_compress(rtd, rtd->num);
 		if (ret < 0) {
 			dev_err(card->dev, "ASoC: can't create compress %s\n",
 					 dai_link->stream_name);
@@ -1382,7 +1445,7 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 
 		if (!dai_link->params) {
 			/* create the pcm */
-			ret = soc_new_pcm(rtd, num);
+			ret = soc_new_pcm(rtd, rtd->num);
 			if (ret < 0) {
 				dev_err(card->dev, "ASoC: can't create pcm %s :%d\n",
 				       dai_link->stream_name, ret);
@@ -1552,6 +1615,7 @@ EXPORT_SYMBOL_GPL(snd_soc_runtime_set_dai_fmt);
 static int snd_soc_instantiate_card(struct snd_soc_card *card)
 {
 	struct snd_soc_codec *codec;
+	struct snd_soc_pcm_runtime *rtd;
 	int ret, i, order;
 
 	mutex_lock(&client_mutex);
@@ -1624,8 +1688,8 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	/* probe all components used by DAI links on this card */
 	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
 			order++) {
-		for (i = 0; i < card->num_links; i++) {
-			ret = soc_probe_link_components(card, i, order);
+		list_for_each_entry(rtd, &card->rtd_list, list) {
+			ret = soc_probe_link_components(card, rtd, order);
 			if (ret < 0) {
 				dev_err(card->dev,
 					"ASoC: failed to instantiate card %d\n",
@@ -1638,8 +1702,8 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	/* probe all DAI links on this card */
 	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
 			order++) {
-		for (i = 0; i < card->num_links; i++) {
-			ret = soc_probe_link_dais(card, i, order);
+		list_for_each_entry(rtd, &card->rtd_list, list) {
+			ret = soc_probe_link_dais(card, rtd, order);
 			if (ret < 0) {
 				dev_err(card->dev,
 					"ASoC: failed to instantiate card %d\n",
@@ -1733,6 +1797,7 @@ card_probe_error:
 	snd_card_free(card->snd_card);
 
 base_error:
+	soc_remove_pcm_runtimes(card);
 	mutex_unlock(&card->mutex);
 	mutex_unlock(&client_mutex);
 
@@ -1763,13 +1828,12 @@ static int soc_probe(struct platform_device *pdev)
 
 static int soc_cleanup_card_resources(struct snd_soc_card *card)
 {
+	struct snd_soc_pcm_runtime *rtd;
 	int i;
 
 	/* make sure any delayed work runs */
-	for (i = 0; i < card->num_rtd; i++) {
-		struct snd_soc_pcm_runtime *rtd = &card->rtd[i];
+	list_for_each_entry(rtd, &card->rtd_list, list)
 		flush_delayed_work(&rtd->delayed_work);
-	}
 
 	/* remove auxiliary devices */
 	for (i = 0; i < card->num_aux_devs; i++)
@@ -1777,6 +1841,7 @@ static int soc_cleanup_card_resources(struct snd_soc_card *card)
 
 	/* remove and free each DAI */
 	soc_remove_dai_links(card);
+	soc_remove_pcm_runtimes(card);
 
 	soc_cleanup_card_debugfs(card);
 
@@ -1803,29 +1868,26 @@ static int soc_remove(struct platform_device *pdev)
 int snd_soc_poweroff(struct device *dev)
 {
 	struct snd_soc_card *card = dev_get_drvdata(dev);
-	int i;
+	struct snd_soc_pcm_runtime *rtd;
 
 	if (!card->instantiated)
 		return 0;
 
 	/* Flush out pmdown_time work - we actually do want to run it
 	 * now, we're shutting down so no imminent restart. */
-	for (i = 0; i < card->num_rtd; i++) {
-		struct snd_soc_pcm_runtime *rtd = &card->rtd[i];
+	list_for_each_entry(rtd, &card->rtd_list, list)
 		flush_delayed_work(&rtd->delayed_work);
-	}
 
 	snd_soc_dapm_shutdown(card);
 
 	/* deactivate pins to sleep state */
-	for (i = 0; i < card->num_rtd; i++) {
-		struct snd_soc_pcm_runtime *rtd = &card->rtd[i];
+	list_for_each_entry(rtd, &card->rtd_list, list) {
 		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-		int j;
+		int i;
 
 		pinctrl_pm_select_sleep_state(cpu_dai->dev);
-		for (j = 0; j < rtd->num_codecs; j++) {
-			struct snd_soc_dai *codec_dai = rtd->codec_dais[j];
+		for (i = 0; i < rtd->num_codecs; i++) {
+			struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
 			pinctrl_pm_select_sleep_state(codec_dai->dev);
 		}
 	}
@@ -2337,6 +2399,7 @@ static int snd_soc_init_multicodec(struct snd_soc_card *card,
 int snd_soc_register_card(struct snd_soc_card *card)
 {
 	int i, j, ret;
+	struct snd_soc_pcm_runtime *rtd;
 
 	if (!card->name || !card->dev)
 		return -EINVAL;
@@ -2408,25 +2471,15 @@ int snd_soc_register_card(struct snd_soc_card *card)
 
 	snd_soc_initialize_card_lists(card);
 
-	card->rtd = devm_kzalloc(card->dev,
+	INIT_LIST_HEAD(&card->rtd_list);
+	card->num_rtd = 0;
+
+	card->rtd_aux = devm_kzalloc(card->dev,
 				 sizeof(struct snd_soc_pcm_runtime) *
-				 (card->num_links + card->num_aux_devs),
+				 card->num_aux_devs,
 				 GFP_KERNEL);
-	if (card->rtd == NULL)
+	if (card->rtd_aux == NULL)
 		return -ENOMEM;
-	card->num_rtd = 0;
-	card->rtd_aux = &card->rtd[card->num_links];
-
-	for (i = 0; i < card->num_links; i++) {
-		card->rtd[i].card = card;
-		card->rtd[i].dai_link = &card->dai_link[i];
-		card->rtd[i].codec_dais = devm_kzalloc(card->dev,
-					sizeof(struct snd_soc_dai *) *
-					(card->rtd[i].dai_link->num_codecs),
-					GFP_KERNEL);
-		if (card->rtd[i].codec_dais == NULL)
-			return -ENOMEM;
-	}
 
 	for (i = 0; i < card->num_aux_devs; i++)
 		card->rtd_aux[i].card = card;
@@ -2442,8 +2495,7 @@ int snd_soc_register_card(struct snd_soc_card *card)
 		return ret;
 
 	/* deactivate pins to sleep state */
-	for (i = 0; i < card->num_rtd; i++) {
-		struct snd_soc_pcm_runtime *rtd = &card->rtd[i];
+	list_for_each_entry(rtd, &card->rtd_list, list)  {
 		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 		int j;
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 7482c5d..6d1f066 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3861,13 +3861,10 @@ static void soc_dapm_dai_stream_event(struct snd_soc_dai *dai, int stream,
 
 void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card)
 {
-	struct snd_soc_pcm_runtime *rtd = card->rtd;
-	int i;
+	struct snd_soc_pcm_runtime *rtd;
 
 	/* for each BE DAI link... */
-	for (i = 0; i < card->num_rtd; i++) {
-		rtd = &card->rtd[i];
-
+	list_for_each_entry(rtd, &card->rtd_list, list)  {
 		/*
 		 * dynamic FE links have no fixed DAI mapping.
 		 * CODEC<->CODEC links have no direct connection.
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 70e4b9d..0246019 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1166,11 +1166,10 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 		struct snd_soc_dapm_widget *widget, int stream)
 {
 	struct snd_soc_pcm_runtime *be;
-	int i, j;
+	int i;
 
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		for (i = 0; i < card->num_links; i++) {
-			be = &card->rtd[i];
+		list_for_each_entry(be, &card->rtd_list, list) {
 
 			if (!be->dai_link->no_pcm)
 				continue;
@@ -1178,16 +1177,15 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 			if (be->cpu_dai->playback_widget == widget)
 				return be;
 
-			for (j = 0; j < be->num_codecs; j++) {
-				struct snd_soc_dai *dai = be->codec_dais[j];
+			for (i = 0; i < be->num_codecs; i++) {
+				struct snd_soc_dai *dai = be->codec_dais[i];
 				if (dai->playback_widget == widget)
 					return be;
 			}
 		}
 	} else {
 
-		for (i = 0; i < card->num_links; i++) {
-			be = &card->rtd[i];
+		list_for_each_entry(be, &card->rtd_list, list) {
 
 			if (!be->dai_link->no_pcm)
 				continue;
@@ -1195,8 +1193,8 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 			if (be->cpu_dai->capture_widget == widget)
 				return be;
 
-			for (j = 0; j < be->num_codecs; j++) {
-				struct snd_soc_dai *dai = be->codec_dais[j];
+			for (i = 0; i < be->num_codecs; i++) {
+				struct snd_soc_dai *dai = be->codec_dais[i];
 				if (dai->capture_widget == widget)
 					return be;
 			}
@@ -2296,12 +2294,12 @@ static int dpcm_run_old_update(struct snd_soc_pcm_runtime *fe, int stream)
  */
 int soc_dpcm_runtime_update(struct snd_soc_card *card)
 {
-	int i, old, new, paths;
+	struct snd_soc_pcm_runtime *fe;
+	int old, new, paths;
 
 	mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
-	for (i = 0; i < card->num_rtd; i++) {
+	list_for_each_entry(fe, &card->rtd_list, list) {
 		struct snd_soc_dapm_widget_list *list;
-		struct snd_soc_pcm_runtime *fe = &card->rtd[i];
 
 		/* make sure link is FE */
 		if (!fe->dai_link->dynamic)
diff --git a/sound/soc/tegra/tegra_wm8903.c b/sound/soc/tegra/tegra_wm8903.c
index 2160400..e485278 100644
--- a/sound/soc/tegra/tegra_wm8903.c
+++ b/sound/soc/tegra/tegra_wm8903.c
@@ -199,7 +199,8 @@ static int tegra_wm8903_init(struct snd_soc_pcm_runtime *rtd)
 
 static int tegra_wm8903_remove(struct snd_soc_card *card)
 {
-	struct snd_soc_pcm_runtime *rtd = &(card->rtd[0]);
+	struct snd_soc_pcm_runtime *rtd =
+		snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct tegra_wm8903 *machine = snd_soc_card_get_drvdata(card);
-- 
1.9.1
