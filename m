From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic3x: Improve tdm support" to
	the asoc tree
Date: Wed, 16 Sep 2015 21:01:51 +0100
Message-ID: <E1ZcItr-0007uj-HQ@finisterre>
References: <fd757436a42258131e9b671149893f8578dafd8b.1441806963.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E4A1F2650C0
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2015 22:02:01 +0200 (CEST)
In-Reply-To: <fd757436a42258131e9b671149893f8578dafd8b.1441806963.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic3x: Improve tdm support

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

>From 3e8f5263bd83fd0fe7dacba2de347b17ac99fc91 Mon Sep 17 00:00:00 2001
From: Jyri Sarha <jsarha@ti.com>
Date: Wed, 9 Sep 2015 21:27:46 +0300
Subject: [PATCH] ASoC: tlv320aic3x: Improve tdm support

Before this patch the set_tdm_slots() callback did not store the value
of slot width anywhere. The tdm support only worked if selected slot
width was equal to the sample width. With this patch all sample widths
that fit into the slot width are supported. There unused bits are
filled unnecessarily in the capture direction, but the other end of
the i2s bus should be able to ignore them.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic3x.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 1a82b19..f1c9fff 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -80,6 +80,7 @@ struct aic3x_priv {
 	unsigned int sysclk;
 	unsigned int dai_fmt;
 	unsigned int tdm_delay;
+	unsigned int slot_width;
 	struct list_head list;
 	int master;
 	int gpio_reset;
@@ -1025,10 +1026,14 @@ static int aic3x_hw_params(struct snd_pcm_substream *substream,
 	u8 data, j, r, p, pll_q, pll_p = 1, pll_r = 1, pll_j = 1;
 	u16 d, pll_d = 1;
 	int clk;
+	int width = aic3x->slot_width;
+
+	if (!width)
+		width = params_width(params);
 
 	/* select data word length */
 	data = snd_soc_read(codec, AIC3X_ASD_INTF_CTRLB) & (~(0x3 << 4));
-	switch (params_width(params)) {
+	switch (width) {
 	case 16:
 		break;
 	case 20:
@@ -1170,12 +1175,16 @@ static int aic3x_prepare(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = dai->codec;
 	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
 	int delay = 0;
+	int width = aic3x->slot_width;
+
+	if (!width)
+		width = substream->runtime->sample_bits;
 
 	/* TDM slot selection only valid in DSP_A/_B mode */
 	if (aic3x->dai_fmt == SND_SOC_DAIFMT_DSP_A)
-		delay += (aic3x->tdm_delay + 1);
+		delay += (aic3x->tdm_delay*width + 1);
 	else if (aic3x->dai_fmt == SND_SOC_DAIFMT_DSP_B)
-		delay += aic3x->tdm_delay;
+		delay += aic3x->tdm_delay*width;
 
 	/* Configure data delay */
 	snd_soc_write(codec, AIC3X_ASD_INTF_CTRLC, delay);
@@ -1296,7 +1305,20 @@ static int aic3x_set_dai_tdm_slot(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	aic3x->tdm_delay = lsb * slot_width;
+	switch (slot_width) {
+	case 16:
+	case 20:
+	case 24:
+	case 32:
+		break;
+	default:
+		dev_err(codec->dev, "Unsupported slot width %d\n", slot_width);
+		return -EINVAL;
+	}
+
+
+	aic3x->tdm_delay = lsb;
+	aic3x->slot_width = slot_width;
 
 	/* DOUT in high-impedance on inactive bit clocks */
 	snd_soc_update_bits(codec, AIC3X_ASD_INTF_CTRLA,
-- 
2.5.0
