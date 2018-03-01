From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 4/6] ASoC: max9867: Fix codec capabilities
Date: Thu, 1 Mar 2018 15:20:56 +0100
Message-ID: <20180301142056.GF30722@lenoch>
References: <20180301141843.GB30722@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 4940A26793F
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 15:20:58 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23993890AbeCAOU6IC0jy (ORCPT
 <rfc822;alsa-devel@alsa-project.org>); Thu, 1 Mar 2018 15:20:58 +0100
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

Codes is stereo only with playback and capture streams bind
to the same rate.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 sound/soc/codecs/max9867.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 3620b38291f0..4160523ea720 100644
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -369,19 +369,20 @@ static struct snd_soc_dai_driver max9867_dai[] = {
 	.name = "max9867-aif1",
 	.playback = {
 		.stream_name = "HiFi Playback",
-		.channels_min = 1,
+		.channels_min = 2,
 		.channels_max = 2,
 		.rates = MAX9867_RATES,
 		.formats = MAX9867_FORMATS,
 	},
 	.capture = {
 		.stream_name = "HiFi Capture",
-		.channels_min = 1,
+		.channels_min = 2,
 		.channels_max = 2,
 		.rates = MAX9867_RATES,
 		.formats = MAX9867_FORMATS,
 	},
 	.ops = &max9867_dai_ops,
+	.symmetric_rates = 1,
 	}
 };
 
-- 
2.16.2
