From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH] ASoC: cs53l30: Correct clock inversion check
Date: Wed,  8 Jun 2016 16:03:00 -0700
Message-ID: <1465426980-10924-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F542261687
 for <alsa-devel@alsa-project.org>; Thu,  9 Jun 2016 01:03:07 +0200 (CEST)
Received: by mail-pf0-f195.google.com with SMTP id c74so1442991pfb.0
 for <alsa-devel@alsa-project.org>; Wed, 08 Jun 2016 16:03:06 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: brian.austin@cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

SND_SOC_DAIFMT_IB_NF = 0x3 (11b) | SND_SOC_DAIFMT_IB_IF = 0x4 (100b)
creates a mask 0x7 (111b) which also includes SND_SOC_DAIFMT_IB_NF
= 0x2 (10b).

So this patch uses the traditional way to check the clock inversion.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/codecs/cs53l30.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index ac90dd7..62daa0c 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -598,8 +598,14 @@ static int cs53l30_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	}
 
 	/* Check to see if the SCLK is inverted */
-	if (fmt & (SND_SOC_DAIFMT_IB_NF | SND_SOC_DAIFMT_IB_IF))
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_IB_NF:
+	case SND_SOC_DAIFMT_IB_IF:
 		aspcfg ^= CS53L30_ASP_SCLK_INV;
+		break;
+	default:
+		break;
+	}
 
 	regmap_update_bits(priv->regmap, CS53L30_ASPCFG_CTL,
 			   CS53L30_ASP_MS | CS53L30_ASP_SCLK_INV, aspcfg);
-- 
2.1.4
