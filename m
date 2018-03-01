From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 5/6] ASoC: max9867: DSP mode
Date: Thu, 1 Mar 2018 15:21:30 +0100
Message-ID: <20180301142130.GG30722@lenoch>
References: <20180301141843.GB30722@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 02D71267946
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 15:21:32 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23993890AbeCAOVbkaLHy (ORCPT
 <rfc822;alsa-devel@alsa-project.org>); Thu, 1 Mar 2018 15:21:31 +0100
Content-Disposition: inline
In-Reply-To: <20180301141843.GB30722@lenoch>
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
Cc: Mark Brown <broonie@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

Add configuration for DSP mode.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 sound/soc/codecs/max9867.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 4160523ea720..4ea3287162ad 100644
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -325,10 +325,16 @@ static int max9867_dai_set_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	/* for i2s compatible mode */
-	iface1A |= MAX9867_I2S_DLY;
-	/* SDOUT goes to hiz state after all data is transferred */
-	iface1A |= MAX9867_SDOUT_HIZ;
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		iface1A |= MAX9867_I2S_DLY;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		iface1A |= MAX9867_TDM_MODE | MAX9867_SDOUT_HIZ;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	/* Clock inversion bits, BCI and WCI */
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-- 
2.16.2
