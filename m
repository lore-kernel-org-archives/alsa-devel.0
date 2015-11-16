From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ak4613: add single-end optional
	property for IN/OUT pins" to the asoc tree
Date: Mon, 16 Nov 2015 17:02:46 +0000
Message-ID: <E1ZyNB1-0005lf-0D@debutante>
References: <87oaeud01r.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B41C92604DF
 for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2015 18:02:52 +0100 (CET)
In-Reply-To: <87oaeud01r.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ak4613: add single-end optional property for IN/OUT pins

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From a3af0c65836e714fa71dcaa0a81f6db83a212faa Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 16 Nov 2015 04:51:21 +0000
Subject: [PATCH] ASoC: ak4613: add single-end optional property for IN/OUT
 pins

ak4613 IN/OUT pin can be selected as differential/single-end.
Default is differential, because it is register default settings.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/ak4613.txt | 10 ++++++++
 sound/soc/codecs/ak4613.c                          | 29 ++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/ak4613.txt b/Documentation/devicetree/bindings/sound/ak4613.txt
index 15a919522b42..3cf63e7f8e77 100644
--- a/Documentation/devicetree/bindings/sound/ak4613.txt
+++ b/Documentation/devicetree/bindings/sound/ak4613.txt
@@ -7,6 +7,16 @@ Required properties:
 - compatible : "asahi-kasei,ak4613"
 - reg : The chip select number on the I2C bus
 
+Optional properties:
+- ak4613,in1-single-end	: Boolean. Indicate input / output pins are single-ended.
+- ak4613,in2-single-end	  rather than differential.
+- ak4613,out1-single-end
+- ak4613,out2-single-end
+- ak4613,out3-single-end
+- ak4613,out4-single-end
+- ak4613,out5-single-end
+- ak4613,out6-single-end
+
 Example:
 
 &i2c {
diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
index 07a266460ec3..394c10ff049e 100644
--- a/sound/soc/codecs/ak4613.c
+++ b/sound/soc/codecs/ak4613.c
@@ -79,6 +79,8 @@ struct ak4613_priv {
 
 	unsigned int fmt;
 	u8 fmt_ctrl;
+	u8 oc;
+	u8 ic;
 	int cnt;
 };
 
@@ -343,6 +345,9 @@ static int ak4613_dai_hw_params(struct snd_pcm_substream *substream,
 	snd_soc_update_bits(codec, CTRL1, FMT_MASK, fmt_ctrl);
 	snd_soc_write(codec, CTRL2, ctrl2);
 
+	snd_soc_write(codec, ICTRL, priv->ic);
+	snd_soc_write(codec, OCTRL, priv->oc);
+
 hw_params_end:
 	if (ret < 0)
 		dev_warn(dev, "unsupported data width/format combination\n");
@@ -431,6 +436,28 @@ static struct snd_soc_codec_driver soc_codec_dev_ak4613 = {
 	.num_dapm_routes	= ARRAY_SIZE(ak4613_intercon),
 };
 
+static void ak4613_parse_of(struct ak4613_priv *priv,
+			    struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	char prop[32];
+	int i;
+
+	/* Input 1 - 2 */
+	for (i = 0; i < 2; i++) {
+		snprintf(prop, sizeof(prop), "ak4613,in%d-single-end", i + 1);
+		if (!of_get_property(np, prop, NULL))
+			priv->ic |= 1 << i;
+	}
+
+	/* Output 1 - 6 */
+	for (i = 0; i < 6; i++) {
+		snprintf(prop, sizeof(prop), "ak4613,out%d-single-end", i + 1);
+		if (!of_get_property(np, prop, NULL))
+			priv->oc |= 1 << i;
+	}
+}
+
 static int ak4613_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
@@ -458,6 +485,8 @@ static int ak4613_i2c_probe(struct i2c_client *i2c,
 	if (!priv)
 		return -ENOMEM;
 
+	ak4613_parse_of(priv, dev);
+
 	priv->fmt_ctrl		= NO_FMT;
 	priv->cnt		= 0;
 
-- 
2.6.2
