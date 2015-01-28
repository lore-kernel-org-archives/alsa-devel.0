From: Peter Rosin <peda@lysator.liu.se>
Subject: [PATCH v2 7/7] ASoC: pcm512x: Support
	SND_SOC_DAIFMT_CBM_CFS
Date: Wed, 28 Jan 2015 15:16:12 +0100
Message-ID: <1422454572-7847-8-git-send-email-peda@lysator.liu.se>
References: <1422454572-7847-1-git-send-email-peda@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by alsa0.perex.cz (Postfix) with ESMTP id CF261262634
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 15:17:41 +0100 (CET)
In-Reply-To: <1422454572-7847-1-git-send-email-peda@lysator.liu.se>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Clemens Ladisch <clemens@ladisch.de>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

From: Peter Rosin <peda@axentia.se>

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/codecs/pcm512x.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index d46d6cdb6b87..64be85fb2748 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -464,6 +464,7 @@ static int pcm512x_dai_startup(struct snd_pcm_substream *substream,
 
 	switch (pcm512x->fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
+	case SND_SOC_DAIFMT_CBM_CFS:
 		return pcm512x_dai_startup_master(substream, dai);
 
 	case SND_SOC_DAIFMT_CBS_CFS:
@@ -970,6 +971,8 @@ static int pcm512x_hw_params(struct snd_pcm_substream *substream,
 	struct pcm512x_priv *pcm512x = snd_soc_codec_get_drvdata(codec);
 	int alen;
 	int gpio;
+	int clock_output;
+	int master_mode;
 	int ret;
 
 	dev_dbg(codec->dev, "hw_params %u Hz, %u channels\n",
@@ -1018,6 +1021,12 @@ static int pcm512x_hw_params(struct snd_pcm_substream *substream,
 		}
 		return 0;
 	case SND_SOC_DAIFMT_CBM_CFM:
+		clock_output = PCM512x_BCKO | PCM512x_LRKO;
+		master_mode = PCM512x_RLRK | PCM512x_RBCK;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFS:
+		clock_output = PCM512x_BCKO;
+		master_mode = PCM512x_RBCK;
 		break;
 	default:
 		return -EINVAL;
@@ -1114,7 +1123,7 @@ static int pcm512x_hw_params(struct snd_pcm_substream *substream,
 
 	ret = regmap_update_bits(pcm512x->regmap, PCM512x_BCLK_LRCLK_CFG,
 				 PCM512x_BCKP | PCM512x_BCKO | PCM512x_LRKO,
-				 PCM512x_BCKO | PCM512x_LRKO);
+				 clock_output);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to enable clock output: %d\n", ret);
 		return ret;
@@ -1122,7 +1131,7 @@ static int pcm512x_hw_params(struct snd_pcm_substream *substream,
 
 	ret = regmap_update_bits(pcm512x->regmap, PCM512x_MASTER_MODE,
 				 PCM512x_RLRK | PCM512x_RBCK,
-				 PCM512x_RLRK | PCM512x_RBCK);
+				 master_mode);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to enable master mode: %d\n", ret);
 		return ret;
-- 
1.7.10.4
