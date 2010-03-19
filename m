From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/2] ASoC: tlv320dac33: Fix DSP modes
Date: Fri, 19 Mar 2010 11:10:19 +0200
Message-ID: <1268989820-18262-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1268989820-18262-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id E6EC91037EE
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2010 10:10:30 +0100 (CET)
In-Reply-To: <1268989820-18262-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

To make DSP_A mode working correctly the data delay should be
configured to 0. DSP_B mode thus can not be used with DAC33,
so remove it.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index a6f1927..f5dbed2 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -1028,11 +1028,7 @@ static int dac33_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	case SND_SOC_DAIFMT_DSP_A:
 		aictrl_a |= DAC33_AFMT_DSP;
 		aictrl_b &= ~DAC33_DATA_DELAY_MASK;
-		aictrl_b |= DAC33_DATA_DELAY(1); /* 1 bit delay */
-		break;
-	case SND_SOC_DAIFMT_DSP_B:
-		aictrl_a |= DAC33_AFMT_DSP;
-		aictrl_b &= ~DAC33_DATA_DELAY_MASK; /* No delay */
+		aictrl_b |= DAC33_DATA_DELAY(0);
 		break;
 	case SND_SOC_DAIFMT_RIGHT_J:
 		aictrl_a |= DAC33_AFMT_RIGHT_J;
-- 
1.7.0.2
