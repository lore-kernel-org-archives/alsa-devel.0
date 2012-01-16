From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: 24 bits are significant on the
	WM8996 audio interfaces
Date: Mon, 16 Jan 2012 18:41:07 +0000
Message-ID: <1326739267-9678-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1326739267-9678-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B503810383D
	for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2012 19:41:13 +0100 (CET)
In-Reply-To: <1326739267-9678-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8996.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index d8da10f..691ae4e 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -3082,6 +3082,7 @@ static struct snd_soc_dai_driver wm8996_dai[] = {
 			.channels_max = 6,
 			.rates = WM8996_RATES,
 			.formats = WM8996_FORMATS,
+			.sig_bits = 24,
 		},
 		.capture = {
 			 .stream_name = "AIF1 Capture",
@@ -3089,6 +3090,7 @@ static struct snd_soc_dai_driver wm8996_dai[] = {
 			 .channels_max = 6,
 			 .rates = WM8996_RATES,
 			 .formats = WM8996_FORMATS,
+			 .sig_bits = 24,
 		 },
 		.ops = &wm8996_dai_ops,
 	},
@@ -3100,6 +3102,7 @@ static struct snd_soc_dai_driver wm8996_dai[] = {
 			.channels_max = 2,
 			.rates = WM8996_RATES,
 			.formats = WM8996_FORMATS,
+			.sig_bits = 24,
 		},
 		.capture = {
 			 .stream_name = "AIF2 Capture",
@@ -3107,6 +3110,7 @@ static struct snd_soc_dai_driver wm8996_dai[] = {
 			 .channels_max = 2,
 			 .rates = WM8996_RATES,
 			 .formats = WM8996_FORMATS,
+			.sig_bits = 24,
 		 },
 		.ops = &wm8996_dai_ops,
 	},
-- 
1.7.7.3
