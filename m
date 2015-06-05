From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH 1/2] ASoC: simple card: Add mclk-fs property in
	dai-link
Date: Fri, 5 Jun 2015 10:19:05 +0200
Message-ID: <1433492346-29506-2-git-send-email-arnaud.pouliquen@st.com>
References: <1433492346-29506-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id D427F26072A
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2015 10:19:43 +0200 (CEST)
In-Reply-To: <1433492346-29506-1-git-send-email-arnaud.pouliquen@st.com>
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
Cc: broonie@kernel.org, arnaud.pouliquen@st.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Add mclk-fs ratio property per dai-link sub node. This will
allow to manage several codecs with different ratio.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 .../devicetree/bindings/sound/simple-card.txt          |  6 +++++-
 sound/soc/generic/simple-card.c                        | 18 +++++++++++++++---
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index 73bf314..cf3979e 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -16,7 +16,8 @@ Optional properties:
 					  connection's sink, the second being the connection's
 					  source.
 - simple-audio-card,mclk-fs             : Multiplication factor between stream rate and codec
-  					  mclk.
+					  mclk. When defined, mclk-fs property defined in
+					  dai-link sub nodes are ignored.
 - simple-audio-card,hp-det-gpio		: Reference to GPIO that signals when
 					  headphones are attached.
 - simple-audio-card,mic-det-gpio	: Reference to GPIO that signals when
@@ -55,6 +56,9 @@ Optional dai-link subnode properties:
 					  dai-link uses bit clock inversion.
 - frame-inversion			: bool property. Add this if the
 					  dai-link uses frame clock inversion.
+- mclk-fs             			: Multiplication factor between stream
+					  rate and codec mclk, applied only for
+					  the dai-link.
 
 For backward compatibility the frame-master and bitclock-master
 properties can be used as booleans in codec subnode to indicate if the
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index c87e585..d555493 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -26,6 +26,7 @@ struct simple_card_data {
 	struct simple_dai_props {
 		struct asoc_simple_dai cpu_dai;
 		struct asoc_simple_dai codec_dai;
+		unsigned int mclk_fs;
 	} *dai_props;
 	unsigned int mclk_fs;
 	int gpio_hp_det;
@@ -76,11 +77,18 @@ static int asoc_simple_card_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct simple_card_data *priv = snd_soc_card_get_drvdata(rtd->card);
-	unsigned int mclk;
+	struct simple_dai_props *dai_props =
+		&priv->dai_props[rtd - rtd->card->rtd];
+	unsigned int mclk, mclk_fs = 0;
 	int ret = 0;
 
-	if (priv->mclk_fs) {
-		mclk = params_rate(params) * priv->mclk_fs;
+	if (priv->mclk_fs)
+		mclk_fs = priv->mclk_fs;
+	else if (dai_props->mclk_fs)
+		mclk_fs = dai_props->mclk_fs;
+
+	if (mclk_fs) {
+		mclk = params_rate(params) * mclk_fs;
 		ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
 					     SND_SOC_CLOCK_IN);
 	}
@@ -313,6 +321,7 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	char prop[128];
 	char *prefix = "";
 	int ret, cpu_args;
+	u32 val;
 
 	/* For single DAI link & old style of DT node */
 	if (is_top_level_node)
@@ -338,6 +347,9 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	if (ret < 0)
 		goto dai_link_of_err;
 
+	if (!of_property_read_u32(node, "mclk-fs", &val))
+		dai_props->mclk_fs = val;
+
 	ret = asoc_simple_card_sub_parse_of(cpu, &dai_props->cpu_dai,
 					    &dai_link->cpu_of_node,
 					    &dai_link->cpu_dai_name,
-- 
1.9.1
