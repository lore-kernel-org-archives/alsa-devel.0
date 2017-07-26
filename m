From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 2/2] ASoC: rt5670: add symmetric_rates flag
Date: Wed, 26 Jul 2017 20:00:20 +0800
Message-ID: <1501070420-17773-2-git-send-email-bardliao@realtek.com>
References: <1501070420-17773-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id EEA6D267411
 for <alsa-devel@alsa-project.org>; Wed, 26 Jul 2017 14:00:33 +0200 (CEST)
In-Reply-To: <1501070420-17773-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

rt5670 requires symmetric rate of capture and playback.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5670.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 2866f9b..0f4e5bc 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -2733,6 +2733,7 @@ static struct snd_soc_dai_driver rt5670_dai[] = {
 			.formats = RT5670_FORMATS,
 		},
 		.ops = &rt5670_aif_dai_ops,
+		.symmetric_rates = 1,
 	},
 	{
 		.name = "rt5670-aif2",
@@ -2752,6 +2753,7 @@ static struct snd_soc_dai_driver rt5670_dai[] = {
 			.formats = RT5670_FORMATS,
 		},
 		.ops = &rt5670_aif_dai_ops,
+		.symmetric_rates = 1,
 	},
 };
 
-- 
2.7.4
