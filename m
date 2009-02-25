From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] cs4270: add support for slave mode
	configurations
Date: Wed, 25 Feb 2009 14:37:21 +0100
Message-ID: <1235569041-856-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id E8B47244E2
	for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2009 14:37:26 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Added support for scenarios where the Cirrus CS4270 audio codec is slave
to the bitclk and lrclk. Mixed setups are unsupported.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 sound/soc/codecs/cs4270.c |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index cd4a9ee..339e0f6 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -109,6 +109,7 @@ struct cs4270_private {
 	u8 reg_cache[CS4270_NUMREGS];
 	unsigned int mclk; /* Input frequency of the MCLK pin */
 	unsigned int mode; /* The mode (I2S or left-justified) */
+	unsigned int slave_mode;
 };
 
 /**
@@ -247,6 +248,7 @@ static int cs4270_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	struct cs4270_private *cs4270 = codec->private_data;
 	int ret = 0;
 
+	/* set DAI format */
 	switch (format & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 	case SND_SOC_DAIFMT_LEFT_J:
@@ -257,6 +259,21 @@ static int cs4270_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		ret = -EINVAL;
 	}
 
+	/* set master/slave audio interface */
+	switch (format & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		cs4270->slave_mode = 1;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFM:
+		cs4270->slave_mode = 0;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFS:
+		/* unsupported - cs4270 can eigther be slave or master to
+		 * both the bitclk and the lrclk. */
+	default:
+		ret = -EINVAL;
+	}
+
 	return ret;
 }
 
@@ -399,7 +416,12 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 
 	reg = snd_soc_read(codec, CS4270_MODE);
 	reg &= ~(CS4270_MODE_SPEED_MASK | CS4270_MODE_DIV_MASK);
-	reg |= cs4270_mode_ratios[i].speed_mode | cs4270_mode_ratios[i].mclk;
+	reg |= cs4270_mode_ratios[i].mclk;
+
+	if (cs4270->slave_mode)
+		reg |= CS4270_MODE_SLAVE;
+	else
+		reg |= cs4270_mode_ratios[i].speed_mode;
 
 	ret = snd_soc_write(codec, CS4270_MODE, reg);
 	if (ret < 0) {
-- 
1.6.1.3
