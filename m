From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 00/13] Remove mach-kirkwood and mach-dove
Date: Mon, 30 Jun 2014 17:20:51 +0100
Message-ID: <20140630162050.GC32514@n2100.arm.linux.org.uk>
References: <1404075603-31838-1-git-send-email-andrew@lunn.ch>
 <20140629213510.GR32514@n2100.arm.linux.org.uk> <53B154FE.80804@gmail.com>
 <20140630124320.GZ32514@n2100.arm.linux.org.uk>
 <20140630181347.6a4ad4a8@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.arm.linux.org.uk (gw-1.arm.linux.org.uk [78.32.30.217])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C69B2655C4
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 18:21:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140630181347.6a4ad4a8@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Mark Brown <broonie@kernel.org>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 30, 2014 at 06:13:47PM +0200, Jean-Francois Moine wrote:
> On Mon, 30 Jun 2014 13:43:20 +0100
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > For example, I've had fully working audio on the Cubox for 18+ months,
> > but there's a big problem getting it into mainline.  First it was the
> > lack of co-operation from the ASoC maintainers.  Then it was the ASoC
> > maintainers accepting Jean-Francois patches (which really torpedoed
> > my efforts.)  And the final problem which makes it totally impossible
> > is that pushing the DPCM stuff will completely break the DT based
> > kirkwood ASoC stuff which got pushed in.
> 
> I already tried DPCM with the kirkwood audio subsystem. It just ask to
> add a 'system' DAI in kirkwood-i2s. The card is defined as:
> 
> - link 0:
> 	CPU: 'system' (kirkwood new DAI)
> 	CODEC: 'dummy'
> 	front-end
> - link 1:
> 	CPU: 'i2s' (kirkwood)
> 	CODEC: 'i2s-hdmi' (tda998x codec)
> 	back-end
> - link 2
> 	CPU: 'spdif' (kirkwood)
> 	CODEC: 'spdif-hdmi' (tda998x codec)
> 	back-end
> - link 3
> 	CPU: 'spdif' (kirkwood)
> 	CODEC: 'dit-hifi' (spdif codec)
> 	backend
> 
> with the routes (simple-card format):
> 
> 	"I2S Playback",   "System Playback",
> 	"SPDIF Playback", "System Playback",
>         
>  	"hdmi-out",     "I2S Playback",
>  	"hdmi-out",     "SPDIF Playback",
> 	"spdif-out",    "SPDIF Playback";
> 
> This works, but the HW constraints of the sinks are not handled, so,
> all backends are always activated for any format/any rate.

Not quite.  Your changes do not provide DPCM support.  What your changes
did was provide to CPU interfaces, one of which can only be used.

Here's the proper DPCM implementation (which may or may not apply),
which had post-kernel summit Mark's blessing as being the right
solution.  It's the right solution because it allows both I2S and
SPDIF to be active at one time, if you have such a setup.

From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH] ASoC: kirkwood: add DPCM support

Add DPCM support to kirkwood-i2s to support the I2S and SPDIF streams.
This consists of:
- a single front end DAI called "kirkwood-fe" with "dma-tx" and "dma-rx"
  streams.
- one backend DAI called "kirkwood-i2s" for I2S with streams named
  "i2s-tx" and "i2s-rx"
- one backend DAI called "kirkwood-spdif" for SPDIF with a single stream
  named "spdif-tx".

DAPM widgets are used to connect the backend i2s-tx/spdif-tx streams to
the dma-tx frontend stream, and similarly for the capture side.  SPDIF
capture is not supported by this patch.

We avoid the requirement that streams must not be started independently
by keeping a separate mask of which streams are enabled - and this mask
is only used in the playback trigger when we start playback.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood-i2s.c    | 261 +++++++++++++++++++++++------------
 sound/soc/kirkwood/kirkwood-openrd.c |  14 +-
 sound/soc/kirkwood/kirkwood-spdif.c  |  26 +++-
 sound/soc/kirkwood/kirkwood-t5325.c  |  13 +-
 sound/soc/kirkwood/kirkwood.h        |  20 +++
 5 files changed, 239 insertions(+), 95 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index c06920364e93..0425571017e7 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -38,6 +38,18 @@
 	(SNDRV_PCM_FMTBIT_S16_LE | \
 	 SNDRV_PCM_FMTBIT_S24_LE)
 
+/* Workaround ASoC not respecting backend restrictions */
+#define KIRKWOOD_FE_FORMATS (KIRKWOOD_I2S_FORMATS & KIRKWOOD_SPDIF_FORMATS)
+
+enum {
+	KW_DAI_FE,
+	KW_DAI_BE_I2S,
+	KW_DAI_BE_SPDIF,
+
+	KW_DAI_BE_SPDIF_PLAYBACK = BIT(0),
+	KW_DAI_BE_SPDIF_CAPTURE = BIT(1),
+};
+
 static void kirkwood_i2s_dump_spdif(struct device *dev,
 	struct kirkwood_dma_data *priv)
 {
@@ -381,13 +393,12 @@ static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
+		if (priv->ctl_play_mask == ~KIRKWOOD_PLAYCTL_ENABLE_MASK)
+			return -EINVAL;
+
 		/* configure */
-		ctl = priv->ctl_play;
-		if (dai->id == 0)
-			ctl &= ~KIRKWOOD_PLAYCTL_SPDIF_EN;	/* i2s */
-		else
-			ctl &= ~KIRKWOOD_PLAYCTL_I2S_EN;	/* spdif */
-		ctl = kirkwood_i2s_play_mute(ctl);
+		ctl = kirkwood_i2s_play_mute(priv->ctl_play &
+					     priv->ctl_play_mask);
 		value = ctl & ~KIRKWOOD_PLAYCTL_ENABLE_MASK;
 		writel(value, priv->io + KIRKWOOD_PLAYCTL);
 
@@ -452,13 +463,11 @@ static int kirkwood_i2s_rec_trigger(struct snd_pcm_substream *substream,
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		/* configure */
-		ctl = priv->ctl_rec;
-		if (dai->id == 0)
-			ctl &= ~KIRKWOOD_RECCTL_SPDIF_EN;	/* i2s */
-		else
-			ctl &= ~KIRKWOOD_RECCTL_I2S_EN;		/* spdif */
+		if (priv->ctl_rec_mask == ~KIRKWOOD_RECCTL_ENABLE_MASK)
+			return -EINVAL;
 
+		/* configure */
+		ctl = priv->ctl_rec & priv->ctl_rec_mask;
 		value = ctl & ~KIRKWOOD_RECCTL_ENABLE_MASK;
 		writel(value, priv->io + KIRKWOOD_RECCTL);
 
@@ -519,19 +528,25 @@ static int kirkwood_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 	return 0;
 }
 
-static int kirkwood_i2s_init(struct kirkwood_dma_data *priv)
+static int kirkwood_fe_probe(struct snd_soc_dai *dai)
 {
+	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(dai);
 	unsigned long value;
 	unsigned int reg_data;
-	int ret;
 
-	ret = snd_soc_add_dai_controls(dai, kirkwood_i2s_iec958_controls,
+	if (priv->have_spdif) {
+		int ret;
+
+		ret = snd_soc_add_dai_controls(dai,
+				kirkwood_i2s_iec958_controls,
 				ARRAY_SIZE(kirkwood_i2s_iec958_controls));
-	if (ret) {
-		dev_err(dai->dev,
-			"unable to add soc card controls: %d\n", ret);
-		return ret;
+		if (ret) {
+			dev_err(dai->dev,
+				"unable to add soc card controls: %d\n", ret);
+			return ret;
+		}
 	}
+
 	/* put system in a "safe" state : */
 	/* disable audio interrupts */
 	writel(0xffffffff, priv->io + KIRKWOOD_INT_CAUSE);
@@ -564,97 +579,134 @@ static int kirkwood_i2s_init(struct kirkwood_dma_data *priv)
 
 }
 
-static const struct snd_soc_dai_ops kirkwood_i2s_dai_ops = {
+static const struct snd_soc_dai_ops kirkwood_dai_fe_ops = {
 	.startup	= kirkwood_i2s_startup,
 	.trigger	= kirkwood_i2s_trigger,
 	.hw_params      = kirkwood_i2s_hw_params,
 	.set_fmt        = kirkwood_i2s_set_fmt,
 };
 
-static struct snd_soc_dai_driver kirkwood_i2s_dai[2] = {
-    {
-	.name = "i2s",
-	.id = 0,
-	.playback = {
-		.channels_min = 1,
-		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
-				SNDRV_PCM_RATE_96000,
-		.formats = KIRKWOOD_I2S_FORMATS,
-	},
-	.capture = {
-		.channels_min = 1,
-		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
-				SNDRV_PCM_RATE_96000,
-		.formats = KIRKWOOD_I2S_FORMATS,
-	},
-	.ops = &kirkwood_i2s_dai_ops,
-    },
-    {
-	.name = "spdif",
-	.id = 1,
+static int kirkwood_i2s_be_startup(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *dai)
+{
+	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(dai);
+
+	switch (dai->id) {
+	case KW_DAI_BE_I2S:
+		priv->ctl_play_mask |= KIRKWOOD_PLAYCTL_I2S_EN;
+		priv->ctl_rec_mask |= KIRKWOOD_RECCTL_I2S_EN;
+		break;
+
+	case KW_DAI_BE_SPDIF:
+		priv->ctl_play_mask |= KIRKWOOD_PLAYCTL_SPDIF_EN;
+		priv->ctl_rec_mask |= KIRKWOOD_RECCTL_SPDIF_EN;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void kirkwood_i2s_be_shutdown(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *dai)
+{
+	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(dai);
+
+	switch (dai->id) {
+	case KW_DAI_BE_I2S:
+		priv->ctl_play_mask &= ~KIRKWOOD_PLAYCTL_I2S_EN;
+		priv->ctl_rec_mask &= ~KIRKWOOD_RECCTL_I2S_EN;
+		break;
+
+	case KW_DAI_BE_SPDIF:
+		priv->ctl_play_mask &= ~KIRKWOOD_PLAYCTL_SPDIF_EN;
+		priv->ctl_rec_mask &= ~KIRKWOOD_RECCTL_SPDIF_EN;
+		break;
+	}
+}
+
+static const struct snd_soc_dai_ops kirkwood_i2s_be_dai_ops = {
+	.startup	= kirkwood_i2s_be_startup,
+	.shutdown	= kirkwood_i2s_be_shutdown,
+};
+
+
+static const struct snd_soc_dai_driver kirkwood_dai_fe = {
+	.name = "kirkwood-fe",
+	.id = KW_DAI_FE,
+	.probe = kirkwood_fe_probe,
 	.playback = {
+		.stream_name = "dma-tx",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
 				SNDRV_PCM_RATE_96000,
-		.formats = KIRKWOOD_SPDIF_FORMATS,
+		.formats = KIRKWOOD_FE_FORMATS,
 	},
 	.capture = {
+		.stream_name = "dma-rx",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
 				SNDRV_PCM_RATE_96000,
-		.formats = KIRKWOOD_SPDIF_FORMATS,
+		.formats = KIRKWOOD_FE_FORMATS,
 	},
-	.ops = &kirkwood_i2s_dai_ops,
-    },
+	.ops = &kirkwood_dai_fe_ops,
 };
 
-static struct snd_soc_dai_driver kirkwood_i2s_dai_extclk[2] = {
-    {
-	.name = "i2s",
-	.id = 0,
+static const struct snd_soc_dai_driver kirkwood_dai_fe_extclk = {
+	.name = "kirkwood-fe",
+	.id = KW_DAI_FE,
+	.probe = kirkwood_fe_probe,
 	.playback = {
+		.stream_name = "dma-tx",
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_CONTINUOUS,
-		.rate_min = 5512,
-		.rate_max = 192000,
-		.formats = KIRKWOOD_I2S_FORMATS,
+		.rates = SNDRV_PCM_RATE_8000_192000 |
+			 SNDRV_PCM_RATE_CONTINUOUS |
+			 SNDRV_PCM_RATE_KNOT,
+		.formats = KIRKWOOD_FE_FORMATS,
 	},
 	.capture = {
+		.stream_name = "dma-rx",
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_CONTINUOUS,
-		.rate_min = 5512,
-		.rate_max = 192000,
-		.formats = KIRKWOOD_I2S_FORMATS,
-	},
-	.ops = &kirkwood_i2s_dai_ops,
-    },
-    {
-	.name = "spdif",
-	.id = 1,
-	.playback = {
-		.channels_min = 1,
-		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_CONTINUOUS,
-		.rate_min = 5512,
-		.rate_max = 192000,
-		.formats = KIRKWOOD_SPDIF_FORMATS,
+		.rates = SNDRV_PCM_RATE_8000_192000 |
+			 SNDRV_PCM_RATE_CONTINUOUS |
+			 SNDRV_PCM_RATE_KNOT,
+		.formats = KIRKWOOD_FE_FORMATS,
 	},
-	.capture = {
-		.channels_min = 1,
-		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_CONTINUOUS,
-		.rate_min = 5512,
-		.rate_max = 192000,
-		.formats = KIRKWOOD_SPDIF_FORMATS,
+	.ops = &kirkwood_dai_fe_ops,
+};
+
+static const struct snd_soc_dai_driver kirkwood_dai_be[] = {
+	{
+		.name = "kirkwood-i2s",
+		.id = KW_DAI_BE_I2S,
+		.ops = &kirkwood_i2s_be_dai_ops,
+		.playback = {
+			.stream_name = "i2s-tx",
+			.formats = KIRKWOOD_I2S_FORMATS,
+		},
+		.capture = {
+			.stream_name = "i2s-rx",
+			.formats = KIRKWOOD_I2S_FORMATS,
+		},
+	}, {
+		.name = "kirkwood-spdif",
+		.id = KW_DAI_BE_SPDIF,
+		.ops = &kirkwood_i2s_be_dai_ops,
+		.playback = {
+			.stream_name = "spdif-tx",
+			.formats = KIRKWOOD_SPDIF_FORMATS,
+		},
+		.capture = {
+			.stream_name = "spdif-rx",
+			.formats = KIRKWOOD_SPDIF_FORMATS,
+		},
 	},
-	.ops = &kirkwood_i2s_dai_ops,
-    },
 };
 
 static const struct snd_soc_component_driver kirkwood_i2s_component = {
@@ -664,10 +716,12 @@ static const struct snd_soc_component_driver kirkwood_i2s_component = {
 static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 {
 	struct kirkwood_asoc_platform_data *data = pdev->dev.platform_data;
-	struct snd_soc_dai_driver *soc_dai = kirkwood_i2s_dai;
+	const struct snd_soc_dai_driver *soc_dai = &kirkwood_dai_fe;
+	struct snd_soc_dai_driver *dai;
 	struct kirkwood_dma_data *priv;
 	struct resource *mem;
 	struct device_node *np = pdev->dev.of_node;
+	unsigned i;
 	int err;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -688,6 +742,13 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
+	/*
+	 * We currently have no way to determine whether SPDIF playback
+	 * or capture is currently supported; take the middle ground
+	 * for the time being until DT/platform data passes this detail.
+	 */
+	priv->have_spdif = KW_DAI_BE_SPDIF_PLAYBACK;
+
 	if (np) {
 		priv->burst = 128;		/* might be 32 or 128 */
 	} else if (data) {
@@ -718,13 +779,15 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 		} else {
 			dev_info(&pdev->dev, "found external clock\n");
 			clk_prepare_enable(priv->extclk);
-			soc_dai = kirkwood_i2s_dai_extclk;
+			soc_dai = &kirkwood_dai_fe_extclk;
 		}
 	}
 
 	/* Some sensible defaults - this reflects the powerup values */
 	priv->ctl_play = KIRKWOOD_PLAYCTL_SIZE_24;
 	priv->ctl_rec = KIRKWOOD_RECCTL_SIZE_24;
+	priv->ctl_play_mask = ~KIRKWOOD_PLAYCTL_ENABLE_MASK;
+	priv->ctl_rec_mask = ~KIRKWOOD_RECCTL_ENABLE_MASK;
 
 	/* Select the burst size */
 	if (priv->burst == 32) {
@@ -738,8 +801,35 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 	writel(KIRKWOOD_MCLK_SOURCE_DCO, 
 	       priv->io+KIRKWOOD_CLOCKS_CTRL);
 
+	dai = priv->dai_driver;
+	memcpy(dai, soc_dai, sizeof(*dai));
+
+	/* Copy the frontend channels and rates to the backends */
+	for (i = 1; i < ARRAY_SIZE(priv->dai_driver); i++) {
+		memcpy(&dai[i], &kirkwood_dai_be[i - 1], sizeof(*dai));
+		dai[i].playback.channels_min = dai[0].playback.channels_min;
+		dai[i].playback.channels_max = dai[0].playback.channels_max;
+		dai[i].playback.rates        = dai[0].playback.rates;
+		dai[i].playback.rate_min     = dai[0].playback.rate_min;
+		dai[i].playback.rate_max     = dai[0].playback.rate_max;
+		dai[i].capture.channels_min  = dai[0].capture.channels_min;
+		dai[i].capture.channels_max  = dai[0].capture.channels_max;
+		dai[i].capture.rates         = dai[0].capture.rates;
+		dai[i].capture.rate_min      = dai[0].capture.rate_min;
+		dai[i].capture.rate_max      = dai[0].capture.rate_max;
+	}
+
+	/*
+	 * Kill the SPDIF stream information according to
+	 * the capabilities we have on this device.
+	 */
+	if (!(priv->have_spdif & KW_DAI_BE_SPDIF_PLAYBACK))
+		memset(&dai[2].playback, 0, sizeof(dai[2].playback));
+	if (!(priv->have_spdif & KW_DAI_BE_SPDIF_CAPTURE))
+		memset(&dai[2].capture, 0, sizeof(dai[2].capture));
+
 	err = snd_soc_register_component(&pdev->dev, &kirkwood_i2s_component,
-					 soc_dai, 2);
+					 dai, 2 + !!priv->have_spdif);
 	if (err) {
 		dev_err(&pdev->dev, "snd_soc_register_component failed\n");
 		goto err_component;
@@ -751,9 +841,8 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 		goto err_platform;
 	}
 
-	kirkwood_i2s_init(priv);
-
 	return 0;
+
  err_platform:
 	snd_soc_unregister_component(&pdev->dev);
  err_component:
diff --git a/sound/soc/kirkwood/kirkwood-openrd.c b/sound/soc/kirkwood/kirkwood-openrd.c
index 65f2a5b9ec3b..78fb05ff44a8 100644
--- a/sound/soc/kirkwood/kirkwood-openrd.c
+++ b/sound/soc/kirkwood/kirkwood-openrd.c
@@ -49,24 +49,34 @@ static struct snd_soc_ops openrd_client_ops = {
 
 
 static struct snd_soc_dai_link openrd_client_dai[] = {
+	KIRKWOOD_FE_DAI_LINK(".0", 1, 1),
 {
 	.name = "CS42L51",
 	.stream_name = "CS42L51 HiFi",
-	.cpu_dai_name = "i2s",
-	.platform_name = "mvebu-audio",
+	.cpu_name = "mvebu-audio.0",
+	.cpu_dai_name = "kirkwood-i2s",
+	.platform_name = "snd-soc-dummy",
 	.codec_dai_name = "cs42l51-hifi",
 	.codec_name = "cs42l51-codec.0-004a",
 	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS,
 	.ops = &openrd_client_ops,
+	.dpcm_playback = 1,
+	.dpcm_capture = 1,
 },
 };
 
+static const struct snd_soc_dapm_route openrd_route[] = {
+	{ "i2s-tx",		NULL,	"dma-tx" },
+	{ "dma-rx",		NULL,	"i2s-rx" },
+};
 
 static struct snd_soc_card openrd_client = {
 	.name = "OpenRD Client",
 	.owner = THIS_MODULE,
 	.dai_link = openrd_client_dai,
 	.num_links = ARRAY_SIZE(openrd_client_dai),
+	.dapm_routes = openrd_route,
+	.num_dapm_routes = ARRAY_SIZE(openrd_route),
 };
 
 static int openrd_probe(struct platform_device *pdev)
diff --git a/sound/soc/kirkwood/kirkwood-spdif.c b/sound/soc/kirkwood/kirkwood-spdif.c
index 9d49bc53f07d..6098dde85fc9 100644
--- a/sound/soc/kirkwood/kirkwood-spdif.c
+++ b/sound/soc/kirkwood/kirkwood-spdif.c
@@ -20,25 +20,39 @@
 #include <sound/pcm.h>
 #include <sound/soc.h>
 
+#include "kirkwood.h"
+
+static const struct snd_soc_dapm_route routes[] = {
+	{ "spdif-tx", NULL, "dma-tx" },
+};
+
 static struct snd_soc_dai_link kirkwood_spdif_dai0[] = {
+	KIRKWOOD_FE_DAI_LINK(".0", 1, 0),
 	{
 		.name = "S/PDIF0",
 		.stream_name = "S/PDIF0 PCM Playback",
-		.platform_name = "mvebu-audio.0",
-		.cpu_dai_name = "mvebu-audio.0",
+		.cpu_name = "mvebu-audio.0",
+		.platform_name = "snd-soc-dummy",
+		.cpu_dai_name = "kirkwood-spdif",
 		.codec_dai_name = "dit-hifi",
 		.codec_name = "spdif-dit",
+		.no_pcm = 1,
+		.dpcm_playback = 1,
 	},
 };
 
 static struct snd_soc_dai_link kirkwood_spdif_dai1[] = {
+	KIRKWOOD_FE_DAI_LINK(".1", 1, 0),
 	{
 		.name = "S/PDIF1",
 		.stream_name = "IEC958 Playback",
-		.platform_name = "mvebu-audio.1",
-		.cpu_dai_name = "mvebu-audio.1",
+		.cpu_name = "mvebu-audio.1",
+		.platform_name = "snd-soc-dummy",
+		.cpu_dai_name = "kirkwood-spdif",
 		.codec_dai_name = "dit-hifi",
 		.codec_name = "spdif-dit",
+		.no_pcm = 1,
+		.dpcm_playback = 1,
 	},
 };
 
@@ -66,7 +80,9 @@ static int kirkwood_spdif_probe(struct platform_device *pdev)
 		card->dai_link = kirkwood_spdif_dai0;
 	else
 		card->dai_link = kirkwood_spdif_dai1;
-	card->num_links = 1;
+	card->num_links = 2;
+	card->dapm_routes = routes;
+	card->num_dapm_routes = ARRAY_SIZE(routes);
 	card->dev = &pdev->dev;
 
 	ret = snd_soc_register_card(card);
diff --git a/sound/soc/kirkwood/kirkwood-t5325.c b/sound/soc/kirkwood/kirkwood-t5325.c
index d213832b0c72..5c0ea0d12a6c 100644
--- a/sound/soc/kirkwood/kirkwood-t5325.c
+++ b/sound/soc/kirkwood/kirkwood-t5325.c
@@ -18,6 +18,8 @@
 #include <linux/platform_data/asoc-kirkwood.h>
 #include "../codecs/alc5623.h"
 
+#include "kirkwood.h"
+
 static int t5325_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params)
 {
@@ -50,6 +52,9 @@ static const struct snd_soc_dapm_route t5325_route[] = {
 
 	{ "MIC1",		NULL,	"Mic Jack" },
 	{ "MIC2",		NULL,	"Mic Jack" },
+
+	{ "i2s-tx",		NULL,	"dma-tx" },
+	{ "dma-rx",		NULL,	"i2s-rx" },
 };
 
 static int t5325_dai_init(struct snd_soc_pcm_runtime *rtd)
@@ -65,16 +70,20 @@ static int t5325_dai_init(struct snd_soc_pcm_runtime *rtd)
 }
 
 static struct snd_soc_dai_link t5325_dai[] = {
+	KIRKWOOD_FE_DAI_LINK(".0", 1, 1),
 {
 	.name = "ALC5621",
 	.stream_name = "ALC5621 HiFi",
-	.cpu_dai_name = "i2s",
-	.platform_name = "mvebu-audio",
+	.cpu_name = "mvebu-audio.0",
+	.cpu_dai_name = "kirkwood-i2s",
+	.platform_name = "snd-soc-dummy",
 	.codec_dai_name = "alc5621-hifi",
 	.codec_name = "alc562x-codec.0-001a",
 	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS,
 	.ops = &t5325_ops,
 	.init = t5325_dai_init,
+	.dpcm_playback = 1,
+	.dpcm_capture = 1,
 },
 };
 
diff --git a/sound/soc/kirkwood/kirkwood.h b/sound/soc/kirkwood/kirkwood.h
index 2404de0963d4..8afe7190eaea 100644
--- a/sound/soc/kirkwood/kirkwood.h
+++ b/sound/soc/kirkwood/kirkwood.h
@@ -141,12 +141,19 @@
 #define KIRKWOOD_SND_MAX_PERIOD_BYTES		0x800000
 #define KIRKWOOD_SND_MAX_BUFFER_BYTES		0x100000
 
+#define KIRKWOOD_NUM_DAIS 3
+
 struct kirkwood_dma_data {
 	void __iomem *io;
 	struct clk *clk;
 	struct clk *extclk;
+	unsigned have_spdif;
+	uint32_t ctl_play_mask;
 	uint32_t ctl_play;
+	uint32_t ctl_rec_mask;
 	uint32_t ctl_rec;
+	struct snd_soc_dai *active_dai;
+	struct snd_soc_dai_driver dai_driver[KIRKWOOD_NUM_DAIS];
 	struct snd_pcm_substream *substream_play;
 	struct snd_pcm_substream *substream_rec;
 	int irq;
@@ -155,4 +162,17 @@ struct kirkwood_dma_data {
 
 extern struct snd_soc_platform_driver kirkwood_soc_platform;
 
+#define KIRKWOOD_FE_DAI_LINK(id, play, capt) {	\
+	.name = "Kirkwood-FE",			\
+	.stream_name = "FE PCM Playback",	\
+	.cpu_name = "mvebu-audio" id,		\
+	.cpu_dai_name = "kirkwood-fe",		\
+	.codec_name = "snd-soc-dummy",		\
+	.codec_dai_name = "snd-soc-dummy-dai",	\
+	.platform_name = "mvebu-audio" id,	\
+	.dynamic = 1,				\
+	.dpcm_capture = capt,			\
+	.dpcm_playback = play,			\
+}
+
 #endif
-- 
1.8.3.1

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
