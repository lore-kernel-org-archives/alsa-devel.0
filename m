From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: [PATCH] ASoC: kirkwood: add S/PDIF support
Date: Tue, 24 Sep 2013 12:41:22 +0200
Message-ID: <20130924124122.64834b2a@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This patch adds S/PDIF input/output for mvebu DT boards.

Signed-off-by: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/mvebu-audio.txt |  23 +++++
 sound/soc/kirkwood/kirkwood-i2s.c                       | 128 ++++++++=
++++++++----------
 sound/soc/kirkwood/kirkwood.h                           |   2 +
 3 files changed, 102 insertions(+), 51 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mvebu-audio.txt b/=
Documentation/devicetree/bindings/sound/mvebu-audio.txt
index f0062c5..c19a5d3 100644
--- a/Documentation/devicetree/bindings/sound/mvebu-audio.txt
+++ b/Documentation/devicetree/bindings/sound/mvebu-audio.txt
@@ -22,6 +22,27 @@ Required properties:
 	"internal" for the internal clock
 	"extclk" for the external clock
=20
+Optional properties:
+
+- i2s-out: This is a boolean property. If present, the transmitting
+  function of I2S will be enabled, indicating the I2S is connected
+  to some IP block, such as an HDMI encoder/display-controller.
+
+- i2s-in: This is a boolean property. If present, the receiving
+  function of I2S will be enabled, indicating the I2S is connected
+  to some IP block, such as an HDMI encoder/display-controller.
+
+- spdif-out: This is a boolean property. If present, the transmitting
+  function of S/PDIF will be enabled, indicating there's a physical
+  S/PDIF out connector/jack on the board or it's connecting to some
+  other IP block, such as an HDMI encoder/display-controller.
+
+- spdif-in: This is a boolean property. If present, the receiving
+  function of S/PDIF will be enabled, indicating there's a physical
+  S/PDIF in connector/jack on the board.
+
+* Note: At least one of these four properties should be set in the DT =
binding.
+
 Example:
=20
 i2s1: audio-controller@b4000 {
@@ -30,4 +51,6 @@ i2s1: audio-controller@b4000 {
 	interrupts =3D <21>, <22>;
 	clocks =3D <&gate_clk 13>;
 	clock-names =3D "internal";
+	i2s-out;
+	spdif-out;
 };
diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kir=
kwood-i2s.c
index 0f3d73d..c62c7fa 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -160,9 +160,11 @@ static int kirkwood_i2s_hw_params(struct snd_pcm_s=
ubstream *substream,
 	case SNDRV_PCM_FORMAT_S16_LE:
 		i2s_value |=3D KIRKWOOD_I2S_CTL_SIZE_16;
 		ctl_play =3D KIRKWOOD_PLAYCTL_SIZE_16_C |
-			   KIRKWOOD_PLAYCTL_I2S_EN;
+			   KIRKWOOD_PLAYCTL_I2S_EN |
+			   KIRKWOOD_PLAYCTL_SPDIF_EN;
 		ctl_rec =3D KIRKWOOD_RECCTL_SIZE_16_C |
-			  KIRKWOOD_RECCTL_I2S_EN;
+			  KIRKWOOD_RECCTL_I2S_EN |
+			  KIRKWOOD_RECCTL_SPDIF_EN;
 		break;
 	/*
 	 * doesn't work... S20_3LE !=3D kirkwood 20bit format ?
@@ -178,9 +180,11 @@ static int kirkwood_i2s_hw_params(struct snd_pcm_s=
ubstream *substream,
 	case SNDRV_PCM_FORMAT_S24_LE:
 		i2s_value |=3D KIRKWOOD_I2S_CTL_SIZE_24;
 		ctl_play =3D KIRKWOOD_PLAYCTL_SIZE_24 |
-			   KIRKWOOD_PLAYCTL_I2S_EN;
+			   KIRKWOOD_PLAYCTL_I2S_EN |
+			   KIRKWOOD_PLAYCTL_SPDIF_EN;
 		ctl_rec =3D KIRKWOOD_RECCTL_SIZE_24 |
-			  KIRKWOOD_RECCTL_I2S_EN;
+			  KIRKWOOD_RECCTL_I2S_EN |
+			  KIRKWOOD_PLAYCTL_I2S_EN;
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
 		i2s_value |=3D KIRKWOOD_I2S_CTL_SIZE_32;
@@ -253,12 +257,14 @@ static int kirkwood_i2s_play_trigger(struct snd_p=
cm_substream *substream,
 		writel(value, priv->io + KIRKWOOD_INT_MASK);
=20
 		/* enable playback */
+		ctl &=3D priv->ctl_play_mask;
 		writel(ctl, priv->io + KIRKWOOD_PLAYCTL);
 		break;
=20
 	case SNDRV_PCM_TRIGGER_STOP:
 		/* stop audio, disable interrupts */
-		ctl |=3D KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE;
+		ctl |=3D KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE |
+				KIRKWOOD_PLAYCTL_SPDIF_MUTE;
 		writel(ctl, priv->io + KIRKWOOD_PLAYCTL);
=20
 		value =3D readl(priv->io + KIRKWOOD_INT_MASK);
@@ -272,13 +278,15 @@ static int kirkwood_i2s_play_trigger(struct snd_p=
cm_substream *substream,
=20
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		ctl |=3D KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE;
+		ctl |=3D KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE |
+				KIRKWOOD_PLAYCTL_SPDIF_MUTE;
 		writel(ctl, priv->io + KIRKWOOD_PLAYCTL);
 		break;
=20
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		ctl &=3D ~(KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE);
+		ctl &=3D ~(KIRKWOOD_PLAYCTL_PAUSE | KIRKWOOD_PLAYCTL_I2S_MUTE |
+				KIRKWOOD_PLAYCTL_SPDIF_MUTE);
 		writel(ctl, priv->io + KIRKWOOD_PLAYCTL);
 		break;
=20
@@ -301,7 +309,8 @@ static int kirkwood_i2s_rec_trigger(struct snd_pcm_=
substream *substream,
 	case SNDRV_PCM_TRIGGER_START:
 		/* configure */
 		ctl =3D priv->ctl_rec;
-		value =3D ctl & ~KIRKWOOD_RECCTL_I2S_EN;
+		value =3D ctl & ~(KIRKWOOD_RECCTL_I2S_EN |
+				KIRKWOOD_RECCTL_SPDIF_EN);
 		writel(value, priv->io + KIRKWOOD_RECCTL);
=20
 		/* enable interrupts */
@@ -310,6 +319,7 @@ static int kirkwood_i2s_rec_trigger(struct snd_pcm_=
substream *substream,
 		writel(value, priv->io + KIRKWOOD_INT_MASK);
=20
 		/* enable record */
+		ctl &=3D priv->ctl_rec_mask;
 		writel(ctl, priv->io + KIRKWOOD_RECCTL);
 		break;
=20
@@ -404,55 +414,75 @@ static const struct snd_soc_dai_ops kirkwood_i2s_=
dai_ops =3D {
 	.set_fmt        =3D kirkwood_i2s_set_fmt,
 };
=20
+static const struct snd_soc_component_driver kirkwood_i2s_component =3D=
 {
+	.name		=3D DRV_NAME,
+};
=20
-static struct snd_soc_dai_driver kirkwood_i2s_dai =3D {
-	.probe =3D kirkwood_i2s_probe,
-	.playback =3D {
-		.channels_min =3D 1,
-		.channels_max =3D 2,
-		.rates =3D SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
-				SNDRV_PCM_RATE_96000,
-		.formats =3D KIRKWOOD_I2S_FORMATS,
-	},
-	.capture =3D {
+static int kirkwood_register_component(struct device *dev,
+					struct kirkwood_dma_data *priv)
+{
+	struct device_node *np =3D dev->of_node;
+	uint32_t ctl_play_mask =3D ~(KIRKWOOD_PLAYCTL_I2S_EN |
+				KIRKWOOD_PLAYCTL_SPDIF_EN);
+	uint32_t ctl_rec_mask =3D ~(KIRKWOOD_RECCTL_I2S_EN |
+				KIRKWOOD_RECCTL_SPDIF_EN);
+	int ret;
+
+	static const struct snd_soc_pcm_stream stream =3D {
 		.channels_min =3D 1,
 		.channels_max =3D 2,
 		.rates =3D SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
 				SNDRV_PCM_RATE_96000,
 		.formats =3D KIRKWOOD_I2S_FORMATS,
-	},
-	.ops =3D &kirkwood_i2s_dai_ops,
-};
+	};
=20
-static struct snd_soc_dai_driver kirkwood_i2s_dai_extclk =3D {
-	.probe =3D kirkwood_i2s_probe,
-	.playback =3D {
-		.channels_min =3D 1,
-		.channels_max =3D 2,
-		.rates =3D SNDRV_PCM_RATE_8000_192000 |
-			 SNDRV_PCM_RATE_CONTINUOUS |
-			 SNDRV_PCM_RATE_KNOT,
-		.formats =3D KIRKWOOD_I2S_FORMATS,
-	},
-	.capture =3D {
-		.channels_min =3D 1,
-		.channels_max =3D 2,
-		.rates =3D SNDRV_PCM_RATE_8000_192000 |
-			 SNDRV_PCM_RATE_CONTINUOUS |
-			 SNDRV_PCM_RATE_KNOT,
-		.formats =3D KIRKWOOD_I2S_FORMATS,
-	},
-	.ops =3D &kirkwood_i2s_dai_ops,
-};
+	if (np) {
+		if (of_property_read_bool(np, "i2s-in"))
+			ctl_rec_mask |=3D KIRKWOOD_RECCTL_I2S_EN;
+		if (of_property_read_bool(np, "i2s-out"))
+			ctl_play_mask |=3D KIRKWOOD_PLAYCTL_I2S_EN;
+		if (of_property_read_bool(np, "spdif-in"))
+			ctl_rec_mask |=3D KIRKWOOD_RECCTL_SPDIF_EN;
+		if (of_property_read_bool(np, "spdif-out"))
+			ctl_play_mask |=3D KIRKWOOD_PLAYCTL_SPDIF_EN;
+	} else {
+		ctl_rec_mask |=3D KIRKWOOD_RECCTL_I2S_EN;
+		ctl_play_mask |=3D KIRKWOOD_PLAYCTL_I2S_EN;
+	}
+	priv->ctl_play_mask =3D ctl_play_mask;
+	priv->ctl_rec_mask =3D ctl_rec_mask;
+
+	priv->soc_dai.probe =3D kirkwood_i2s_probe;
+	priv->soc_dai.ops =3D &kirkwood_i2s_dai_ops;
+	if (ctl_play_mask & (KIRKWOOD_PLAYCTL_I2S_EN |
+				KIRKWOOD_PLAYCTL_SPDIF_EN)) {
+		memcpy(&priv->soc_dai.playback, &stream,
+			sizeof priv->soc_dai.playback);
+		if (!IS_ERR(priv->extclk))
+			priv->soc_dai.playback.rates =3D SNDRV_PCM_RATE_8000_192000 |
+						SNDRV_PCM_RATE_CONTINUOUS |
+						SNDRV_PCM_RATE_KNOT;
+	}
+	if (ctl_rec_mask & (KIRKWOOD_RECCTL_I2S_EN |
+				KIRKWOOD_RECCTL_SPDIF_EN)) {
+		memcpy(&priv->soc_dai.capture, &stream,
+			sizeof priv->soc_dai.capture);
+		if (!IS_ERR(priv->extclk))
+			priv->soc_dai.capture.rates =3D SNDRV_PCM_RATE_8000_192000 |
+						SNDRV_PCM_RATE_CONTINUOUS |
+						SNDRV_PCM_RATE_KNOT;
+	}
=20
-static const struct snd_soc_component_driver kirkwood_i2s_component =3D=
 {
-	.name		=3D DRV_NAME,
-};
+	ret =3D snd_soc_register_component(dev, &kirkwood_i2s_component,
+					 &priv->soc_dai, 1);
+	if (ret)
+		dev_err(dev, "snd_soc_register_component failed\n");
+	return ret;
+}
=20
 static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 {
 	struct kirkwood_asoc_platform_data *data =3D pdev->dev.platform_data;
-	struct snd_soc_dai_driver *soc_dai =3D &kirkwood_i2s_dai;
 	struct kirkwood_dma_data *priv;
 	struct resource *mem;
 	struct device_node *np =3D pdev->dev.of_node;
@@ -503,7 +533,6 @@ static int kirkwood_i2s_dev_probe(struct platform_d=
evice *pdev)
 		} else {
 			dev_info(&pdev->dev, "found external clock\n");
 			clk_prepare_enable(priv->extclk);
-			soc_dai =3D &kirkwood_i2s_dai_extclk;
 		}
 	}
=20
@@ -520,12 +549,9 @@ static int kirkwood_i2s_dev_probe(struct platform_=
device *pdev)
 		priv->ctl_rec |=3D KIRKWOOD_RECCTL_BURST_128;
 	}
=20
-	err =3D snd_soc_register_component(&pdev->dev, &kirkwood_i2s_componen=
t,
-					 soc_dai, 1);
-	if (err) {
-		dev_err(&pdev->dev, "snd_soc_register_component failed\n");
+	err =3D kirkwood_register_component(&pdev->dev, priv);
+	if (err)
 		goto err_component;
-	}
=20
 	err =3D snd_soc_register_platform(&pdev->dev, &kirkwood_soc_platform)=
;
 	if (err) {
diff --git a/sound/soc/kirkwood/kirkwood.h b/sound/soc/kirkwood/kirkwoo=
d.h
index f8e1ccc..8f11e03 100644
--- a/sound/soc/kirkwood/kirkwood.h
+++ b/sound/soc/kirkwood/kirkwood.h
@@ -134,6 +134,8 @@ struct kirkwood_dma_data {
 	struct clk *extclk;
 	uint32_t ctl_play;
 	uint32_t ctl_rec;
+	uint32_t ctl_play_mask, ctl_rec_mask;
+	struct snd_soc_dai_driver soc_dai;
 	struct snd_pcm_substream *substream_play;
 	struct snd_pcm_substream *substream_rec;
 	int irq;


--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
