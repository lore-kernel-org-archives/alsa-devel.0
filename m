From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH] ASoC: tlv320aic3x: Fix DSP DAI format and
	signal polarities matching
Date: Thu, 23 Oct 2008 14:27:03 +0300
Message-ID: <1224761223-15988-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 103CB244F5
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Oct 2008 13:28:21 +0200 (CEST)
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	m9NBRlQZ027428
	for <alsa-devel@alsa-project.org>; Thu, 23 Oct 2008 14:28:02 +0300
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
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

- Codec doesn't support to configure bit clock and frame sync polarities
- Codec doesn't support DSP_A format but DSP_B with inverted bit clock
  polarity
- Match also other formats with their signal polarities

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/codecs/tlv320aic3x.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 05336ed..cff276e 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -863,17 +863,21 @@ static int aic3x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	/* interface format */
-	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
-	case SND_SOC_DAIFMT_I2S:
+	/*
+	 * match both interface format and signal polarities since they
+	 * are fixed
+	 */
+	switch (fmt & (SND_SOC_DAIFMT_FORMAT_MASK |
+		       SND_SOC_DAIFMT_INV_MASK)) {
+	case (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF):
 		break;
-	case SND_SOC_DAIFMT_DSP_A:
+	case (SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_IB_NF):
 		iface_breg |= (0x01 << 6);
 		break;
-	case SND_SOC_DAIFMT_RIGHT_J:
+	case (SND_SOC_DAIFMT_RIGHT_J | SND_SOC_DAIFMT_NB_NF):
 		iface_breg |= (0x02 << 6);
 		break;
-	case SND_SOC_DAIFMT_LEFT_J:
+	case (SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_NB_NF):
 		iface_breg |= (0x03 << 6);
 		break;
 	default:
-- 
1.5.6.5
