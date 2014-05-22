From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: [PATCH v3 5/9] ASoC: simple-card: Support setting mclk via a fixed factor
Date: Thu, 22 May 2014 17:31:49 +0200
Message-ID: <1400772710-23523-1-git-send-email-andrew@lunn.ch>
References: <20140520221359.GF12304@sirena.org.uk>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140520221359.GF12304-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Some platforms require that the codecs mclk is a fixed multiplication
factor of the audio stream rate. Add a optional property to the
binding to hold this factor and implement a hw_params() function to
make use of it.

Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
---
v1->v2:
  s/factor/fs/g
v2->v3:
  rebase on asoc/for-next
---
 .../devicetree/bindings/sound/simple-card.txt      |  3 +++
 sound/soc/generic/simple-card.c                    | 28 ++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index 9b9df146fd1a..c2e9841dfce4 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -15,6 +15,9 @@ Optional properties:
 					  Each entry is a pair of strings, the first being the
 					  connection's sink, the second being the connection's
 					  source.
+- simple-audio-card,mclk-fs             : Multiplication factor between stream rate and codec
+  					  mclk.
+
 Optional subnodes:
 
 - simple-audio-card,dai-link		: Container for dai-link level
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 98f97e543c29..e97459f1424a 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -24,9 +24,32 @@ struct simple_card_data {
 		struct asoc_simple_dai cpu_dai;
 		struct asoc_simple_dai codec_dai;
 	} *dai_props;
+	unsigned int mclk_fs;
 	struct snd_soc_dai_link dai_link[];	/* dynamically allocated */
 };
 
+static int asoc_simple_card_hw_params(struct snd_pcm_substream *substream,
+				      struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct simple_card_data *priv = snd_soc_card_get_drvdata(rtd->card);
+	unsigned int mclk;
+	int ret = 0;
+
+	if (priv->mclk_fs) {
+		mclk = params_rate(params) * priv->mclk_fs;
+		ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
+					     SND_SOC_CLOCK_IN);
+	}
+
+	return ret;
+}
+
+static struct snd_soc_ops asoc_simple_card_ops = {
+	.hw_params = asoc_simple_card_hw_params,
+};
+
 static int __asoc_simple_card_dai_init(struct snd_soc_dai *dai,
 				       struct asoc_simple_dai *set)
 {
@@ -249,6 +272,7 @@ static int simple_card_dai_link_of(struct device_node *node,
 	sprintf(name, "%s-%s", dai_link->cpu_dai_name,
 				dai_link->codec_dai_name);
 	dai_link->name = dai_link->stream_name = name;
+	dai_link->ops = &asoc_simple_card_ops;
 
 	dev_dbg(dev, "\tname : %s\n", dai_link->stream_name);
 	dev_dbg(dev, "\tcpu : %s / %04x / %d\n",
@@ -298,6 +322,10 @@ static int asoc_simple_card_parse_of(struct device_node *node,
 			return ret;
 	}
 
+	/* Factor to mclk, used in hw_params() */
+	of_property_read_u32(node, "simple-audio-card,mclk-fs",
+			     &priv->mclk_fs);
+
 	dev_dbg(dev, "New simple-card: %s\n", priv->snd_card.name ?
 		priv->snd_card.name : "");
 
-- 
2.0.0.rc2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
