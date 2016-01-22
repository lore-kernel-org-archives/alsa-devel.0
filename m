From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [RFC v2 5/6] ASoc: hdmi-codec: add IEC control.
Date: Fri, 22 Jan 2016 18:48:31 +0100
Message-ID: <1453484912-24547-6-git-send-email-arnaud.pouliquen@st.com>
References: <1453484912-24547-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 1349F260504
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 18:49:02 +0100 (CET)
In-Reply-To: <1453484912-24547-1-git-send-email-arnaud.pouliquen@st.com>
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
Cc: Jean-Francois Moine <moinejf@free.fr>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@linux.ie>, arnaud.pouliquen@st.com, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>
List-Id: alsa-devel@alsa-project.org

Create 'IEC958 Playback Default' controls to support IEC61937 formats.
the use of the alsa control is optional, using 'iec_ctl' flag.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 include/sound/hdmi-codec.h    |  1 +
 sound/soc/codecs/hdmi-codec.c | 59 +++++++++++++++++++++++++++++++++----------
 2 files changed, 46 insertions(+), 14 deletions(-)

diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
index ed780b2..58e8eae 100644
--- a/include/sound/hdmi-codec.h
+++ b/include/sound/hdmi-codec.h
@@ -96,6 +96,7 @@ struct hdmi_codec_pdata {
 	const struct hdmi_codec_ops *ops;
 	uint i2s:1;
 	uint spdif:1;
+	uint iec_ctl:1;
 	int max_i2s_channels;
 };
 
diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 94349b3..1b6cb5a 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -32,6 +32,7 @@ struct hdmi_codec_priv {
 	struct snd_pcm_substream *current_stream;
 	struct snd_pcm_hw_constraint_list ratec;
 	uint8_t eld[MAX_ELD_BYTES];
+	struct snd_aes_iec958 iec;
 };
 
 static const struct snd_soc_dapm_widget hdmi_widgets[] = {
@@ -140,27 +141,30 @@ static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
-	struct hdmi_codec_params hp = {
-		.iec = {
-			.status = { 0 },
-			.subcode = { 0 },
-			.pad = 0,
-			.dig_subframe = { 0 },
-		}
-	};
+	struct hdmi_codec_params hp;
 	int ret;
 
 	dev_dbg(dai->dev, "%s() width %d rate %d channels %d\n", __func__,
 		params_width(params), params_rate(params),
 		params_channels(params));
 
-	ret = snd_pcm_create_iec958_consumer_hw_params(params, hp.iec.status,
-						       sizeof(hp.iec.status));
-	if (ret < 0) {
-		dev_err(dai->dev, "Creating IEC958 channel status failed %d\n",
-			ret);
-		return ret;
+	mutex_lock(&hcp->current_stream_lock);
+	hp.iec = hcp->iec;
+
+	if (!hcp->hcd.iec_ctl) {
+		/*
+		* only PCM format supported
+		*channel status set according to runtime parameters
+		*/
+		ret = snd_pcm_create_iec958_consumer_hw_params(params,
+					hp.iec.status, sizeof(hp.iec.status));
+		if (ret < 0) {
+			dev_err(dai->dev, "Creating IEC958 status failed %d\n",
+				ret);
+			return ret;
+		}
 	}
+	mutex_unlock(&hcp->current_stream_lock);
 
 	ret = hdmi_codec_new_stream(substream, dai);
 	if (ret)
@@ -266,12 +270,37 @@ static int hdmi_codec_digital_mute(struct snd_soc_dai *dai, int mute)
 	return 0;
 }
 
+static int hdmi_codec_pcm_new(struct snd_soc_pcm_runtime *rtd,
+			      struct snd_soc_dai *dai)
+{
+	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
+	struct snd_pcm_iec958_params *iec958_params;
+
+	dev_dbg(dai->dev, "%s()\n", __func__);
+
+	if (!hcp->hcd.iec_ctl)
+		return 0;
+
+	iec958_params = devm_kzalloc(dai->dev, sizeof(*iec958_params),
+				     GFP_KERNEL);
+	if (!iec958_params)
+		return -ENOMEM;
+
+	iec958_params->iec = &hcp->iec;
+	iec958_params->pdata = hcp;
+	iec958_params->mutex = &hcp->current_stream_lock;
+
+	return snd_pcm_create_iec958_ctl(rtd->pcm, iec958_params,
+					 SNDRV_PCM_STREAM_PLAYBACK);
+}
+
 static const struct snd_soc_dai_ops hdmi_dai_ops = {
 	.startup        = hdmi_codec_startup,
 	.shutdown       = hdmi_codec_shutdown,
 	.hw_params      = hdmi_codec_hw_params,
 	.set_fmt        = hdmi_codec_set_fmt,
 	.digital_mute   = hdmi_codec_digital_mute,
+	.pcm_new        = hdmi_codec_pcm_new,
 };
 
 
@@ -352,6 +381,8 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 	if (!hcp)
 		return -ENOMEM;
 
+	memset(&hcp->iec, 0, sizeof(hcp->iec));
+
 	hcp->hcd = *hcd;
 	mutex_init(&hcp->current_stream_lock);
 
-- 
1.9.1
