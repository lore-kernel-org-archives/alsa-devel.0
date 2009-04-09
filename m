From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/3] ASoC: tlv320aic32: add DSP_A format support
Date: Thu,  9 Apr 2009 12:34:40 +0300
Message-ID: <1239269682-21309-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1239269682-21309-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id D232924382
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Apr 2009 11:34:56 +0200 (CEST)
In-Reply-To: <1239269682-21309-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: jarkko.nikula@nokia.com, broonie@opensource.wolfsonmicro.com, arunks@mistralsolutions.com
List-Id: alsa-devel@alsa-project.org

Add DSP_A interface format support by setting the LRP bit in
DSP mode.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320aic23.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index c3f4afb..21f69df 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -523,6 +523,8 @@ static int tlv320aic23_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	case SND_SOC_DAIFMT_I2S:
 		iface_reg |= TLV320AIC23_FOR_I2S;
 		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		iface_reg |= TLV320AIC23_LRP_ON;
 	case SND_SOC_DAIFMT_DSP_B:
 		iface_reg |= TLV320AIC23_FOR_DSP;
 		break;
-- 
1.6.2.2
