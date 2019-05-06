From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 3/4] ASoC: hdmi-codec: remove reference to the dai drivers in the private data
Date: Mon,  6 May 2019 11:58:14 +0200
Message-ID: <20190506095815.24578-4-jbrunet@baylibre.com>
References: <20190506095815.24578-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190506095815.24578-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
List-Id: alsa-devel@alsa-project.org

Keeping the a pointer to the dai drivers is not necessary. It is not used
by the hdmi_codec after the probe.

Even if it was used, the 'struct snd_soc_dai_driver' can accessed through
the 'struct snd_soc_dai' so keeping the pointer in the private data
structure is not useful.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/hdmi-codec.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 4d32f93f6be6..9408e6bc4d3e 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -278,7 +278,6 @@ static const struct hdmi_codec_cea_spk_alloc hdmi_codec_channel_alloc[] = {
 
 struct hdmi_codec_priv {
 	struct hdmi_codec_pdata hcd;
-	struct snd_soc_dai_driver *daidrv;
 	struct hdmi_codec_daifmt daifmt[2];
 	uint8_t eld[MAX_ELD_BYTES];
 	struct snd_pcm_chmap *chmap_info;
@@ -715,6 +714,7 @@ static const struct snd_soc_component_driver hdmi_driver = {
 static int hdmi_codec_probe(struct platform_device *pdev)
 {
 	struct hdmi_codec_pdata *hcd = pdev->dev.platform_data;
+	struct snd_soc_dai_driver *daidrv;
 	struct device *dev = &pdev->dev;
 	struct hdmi_codec_priv *hcp;
 	int dai_count, i = 0;
@@ -737,27 +737,25 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	hcp->hcd = *hcd;
-	hcp->daidrv = devm_kcalloc(dev, dai_count, sizeof(*hcp->daidrv),
-				   GFP_KERNEL);
-	if (!hcp->daidrv)
+	daidrv = devm_kcalloc(dev, dai_count, sizeof(*daidrv), GFP_KERNEL);
+	if (!daidrv)
 		return -ENOMEM;
 
 	if (hcd->i2s) {
-		hcp->daidrv[i] = hdmi_i2s_dai;
-		hcp->daidrv[i].playback.channels_max =
-			hcd->max_i2s_channels;
+		daidrv[i] = hdmi_i2s_dai;
+		daidrv[i].playback.channels_max = hcd->max_i2s_channels;
 		i++;
 	}
 
 	if (hcd->spdif) {
-		hcp->daidrv[i] = hdmi_spdif_dai;
+		daidrv[i] = hdmi_spdif_dai;
 		hcp->daifmt[DAI_ID_SPDIF].fmt = HDMI_SPDIF;
 	}
 
 	dev_set_drvdata(dev, hcp);
 
-	ret = devm_snd_soc_register_component(dev, &hdmi_driver, hcp->daidrv,
-				     dai_count);
+	ret = devm_snd_soc_register_component(dev, &hdmi_driver, daidrv,
+					      dai_count);
 	if (ret) {
 		dev_err(dev, "%s: snd_soc_register_component() failed (%d)\n",
 			__func__, ret);
-- 
2.20.1
