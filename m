From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 5/5] ASoC: tlv320dac33: Safety check for codec
	slave mode
Date: Thu, 31 Dec 2009 10:30:23 +0200
Message-ID: <1262248223-9335-6-git-send-email-peter.ujfalusi@nokia.com>
References: <1262248223-9335-1-git-send-email-peter.ujfalusi@nokia.com>
	<1262248223-9335-2-git-send-email-peter.ujfalusi@nokia.com>
	<1262248223-9335-3-git-send-email-peter.ujfalusi@nokia.com>
	<1262248223-9335-4-git-send-email-peter.ujfalusi@nokia.com>
	<1262248223-9335-5-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 9678E1038A3
	for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2009 09:31:41 +0100 (CET)
In-Reply-To: <1262248223-9335-5-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The currently available FIFO modes (mode1 and mode7) require master
mode from the codec.
Do not allow the slave configuration when the FIFO is in use.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index bc35f3f..3ef3255 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -993,6 +993,7 @@ static int dac33_set_dai_fmt(struct snd_soc_dai *codec_dai,
 			     unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
+	struct tlv320dac33_priv *dac33 = codec->private_data;
 	u8 aictrl_a, aictrl_b;
 
 	aictrl_a = dac33_read_reg_cache(codec, DAC33_SER_AUDIOIF_CTRL_A);
@@ -1005,7 +1006,11 @@ static int dac33_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		break;
 	case SND_SOC_DAIFMT_CBS_CFS:
 		/* Codec Slave */
-		aictrl_a &= ~(DAC33_MSBCLK | DAC33_MSWCLK);
+		if (dac33->fifo_mode) {
+			dev_err(codec->dev, "FIFO mode requires master mode\n");
+			return -EINVAL;
+		} else
+			aictrl_a &= ~(DAC33_MSBCLK | DAC33_MSWCLK);
 		break;
 	default:
 		return -EINVAL;
-- 
1.6.6
