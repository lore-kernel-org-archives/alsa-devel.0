From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 6/7] ASoC: tlv320dac33: Use core to set the
	msbits constraint
Date: Wed, 18 Jan 2012 10:44:54 +0100
Message-ID: <1326879895-2973-7-git-send-email-peter.ujfalusi@ti.com>
References: <1326879895-2973-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog102.obsmtp.com (na3sys009aog102.obsmtp.com
	[74.125.149.69])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B321103A89
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 10:45:49 +0100 (CET)
Received: by ggnq4 with SMTP id q4so1694161ggn.29
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 01:45:47 -0800 (PST)
In-Reply-To: <1326879895-2973-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Core can set the msbits constraint in behalf of the dai.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tlv320dac33.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index f0aad26..21ccf0a 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -806,8 +806,6 @@ static int dac33_startup(struct snd_pcm_substream *substream,
 	/* Stream started, save the substream pointer */
 	dac33->substream = substream;
 
-	snd_pcm_hw_constraint_msbits(substream->runtime, 0, 32, 24);
-
 	return 0;
 }
 
@@ -1516,6 +1514,7 @@ static struct snd_soc_dai_driver dac33_dai = {
 		.channels_max = 2,
 		.rates = DAC33_RATES,
 		.formats = DAC33_FORMATS,},
+		.sig_bits = 24,
 	.ops = &dac33_dai_ops,
 };
 
-- 
1.7.8.3
