From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH] ASoC: wm8741: Use snd_soc_update_bits rather
	than hard coding
Date: Wed, 1 Nov 2017 11:03:25 +0000
Message-ID: <20171101110325.2433-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 35B2C266A51
 for <alsa-devel@alsa-project.org>; Wed,  1 Nov 2017 12:03:28 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: ce3a@gmx.de, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, sergej@taudac.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Only build tested but Sergej should be able to test on actually hardware for us.

Thanks,
Charles

 sound/soc/codecs/wm8741.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index b8c1940f2243..3c96af057a3e 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -196,7 +196,7 @@ static int wm8741_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct wm8741_priv *wm8741 = snd_soc_codec_get_drvdata(codec);
-	u16 iface = snd_soc_read(codec, WM8741_FORMAT_CONTROL) & 0x1FC;
+	unsigned int iface;
 	int i;
 
 	/* The set of sample rates that can be supported depends on the
@@ -223,15 +223,16 @@ static int wm8741_hw_params(struct snd_pcm_substream *substream,
 	/* bit size */
 	switch (params_width(params)) {
 	case 16:
+		iface = 0x0;
 		break;
 	case 20:
-		iface |= 0x0001;
+		iface = 0x1;
 		break;
 	case 24:
-		iface |= 0x0002;
+		iface = 0x2;
 		break;
 	case 32:
-		iface |= 0x0003;
+		iface = 0x3;
 		break;
 	default:
 		dev_dbg(codec->dev, "wm8741_hw_params:    Unsupported bit size param = %d",
@@ -242,7 +243,9 @@ static int wm8741_hw_params(struct snd_pcm_substream *substream,
 	dev_dbg(codec->dev, "wm8741_hw_params:    bit size param = %d, rate param = %d",
 		params_width(params), params_rate(params));
 
-	snd_soc_write(codec, WM8741_FORMAT_CONTROL, iface);
+	snd_soc_update_bits(codec, WM8741_FORMAT_CONTROL, WM8741_IWL_MASK,
+			    iface);
+
 	return 0;
 }
 
@@ -295,7 +298,7 @@ static int wm8741_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	u16 iface = snd_soc_read(codec, WM8741_FORMAT_CONTROL) & 0x1C3;
+	unsigned int iface;
 
 	/* check master/slave audio interface */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -308,18 +311,19 @@ static int wm8741_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	/* interface format */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
-		iface |= 0x0008;
+		iface = 0x08;
 		break;
 	case SND_SOC_DAIFMT_RIGHT_J:
+		iface = 0x00;
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
-		iface |= 0x0004;
+		iface = 0x04;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
-		iface |= 0x000C;
+		iface = 0x0C;
 		break;
 	case SND_SOC_DAIFMT_DSP_B:
-		iface |= 0x001C;
+		iface = 0x1C;
 		break;
 	default:
 		return -EINVAL;
@@ -330,13 +334,13 @@ static int wm8741_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	case SND_SOC_DAIFMT_NB_NF:
 		break;
 	case SND_SOC_DAIFMT_IB_IF:
-		iface |= 0x0010;
+		iface |= 0x10;
 		break;
 	case SND_SOC_DAIFMT_IB_NF:
-		iface |= 0x0020;
+		iface |= 0x20;
 		break;
 	case SND_SOC_DAIFMT_NB_IF:
-		iface |= 0x0030;
+		iface |= 0x30;
 		break;
 	default:
 		return -EINVAL;
@@ -347,7 +351,10 @@ static int wm8741_set_dai_fmt(struct snd_soc_dai *codec_dai,
 				fmt & SND_SOC_DAIFMT_FORMAT_MASK,
 				((fmt & SND_SOC_DAIFMT_INV_MASK)));
 
-	snd_soc_write(codec, WM8741_FORMAT_CONTROL, iface);
+	snd_soc_update_bits(codec, WM8741_FORMAT_CONTROL,
+			    WM8741_BCP_MASK | WM8741_LRP_MASK | WM8741_FMT_MASK,
+			    iface);
+
 	return 0;
 }
 
-- 
2.11.0
