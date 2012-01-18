From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 4/5] ASoC: tlv320dac33: Use core to set the
	msbits constraint
Date: Wed, 18 Jan 2012 12:18:25 +0100
Message-ID: <1326885506-6140-5-git-send-email-peter.ujfalusi@ti.com>
References: <1326885506-6140-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog118.obsmtp.com (na3sys009aog118.obsmtp.com
	[74.125.149.244])
	by alsa0.perex.cz (Postfix) with ESMTP id DDC62103B47
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 12:18:52 +0100 (CET)
Received: by ghbg2 with SMTP id g2so1362380ghb.7
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 03:18:50 -0800 (PST)
In-Reply-To: <1326885506-6140-1-git-send-email-peter.ujfalusi@ti.com>
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
