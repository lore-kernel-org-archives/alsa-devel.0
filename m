From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/4] Revert "ASoC: tlv320dac33: Use core to set
	the msbits constraint"
Date: Thu, 19 Jan 2012 19:24:13 +0100
Message-ID: <1326997456-16296-2-git-send-email-peter.ujfalusi@ti.com>
References: <1326997456-16296-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog106.obsmtp.com (na3sys009aob106.obsmtp.com
	[74.125.149.76])
	by alsa0.perex.cz (Postfix) with ESMTP id 847C3103C69
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 19:24:49 +0100 (CET)
Received: by mail-yx0-f169.google.com with SMTP id m10so159225yen.28
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 10:24:37 -0800 (PST)
In-Reply-To: <1326997456-16296-1-git-send-email-peter.ujfalusi@ti.com>
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

The core implementation applies the msbits constraint to samples
where it should not.
Do not ask core to do this, the original code does the right thing.

This reverts commit 6bb4f827f52a81db10405a4363877140273d669f.
---
 sound/soc/codecs/tlv320dac33.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 21ccf0a..f0aad26 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -806,6 +806,8 @@ static int dac33_startup(struct snd_pcm_substream *substream,
 	/* Stream started, save the substream pointer */
 	dac33->substream = substream;
 
+	snd_pcm_hw_constraint_msbits(substream->runtime, 0, 32, 24);
+
 	return 0;
 }
 
@@ -1514,7 +1516,6 @@ static struct snd_soc_dai_driver dac33_dai = {
 		.channels_max = 2,
 		.rates = DAC33_RATES,
 		.formats = DAC33_FORMATS,},
-		.sig_bits = 24,
 	.ops = &dac33_dai_ops,
 };
 
-- 
1.7.8.3
