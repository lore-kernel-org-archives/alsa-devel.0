From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 3/7] ASoC: 24 bits are significant on the
	WM8996 audio interfaces
Date: Wed, 18 Jan 2012 10:44:51 +0100
Message-ID: <1326879895-2973-4-git-send-email-peter.ujfalusi@ti.com>
References: <1326879895-2973-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog126.obsmtp.com (na3sys009aog126.obsmtp.com
	[74.125.149.155])
	by alsa0.perex.cz (Postfix) with ESMTP id F35E7245AA
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 10:45:42 +0100 (CET)
Received: by ghrr13 with SMTP id r13so773567ghr.15
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 01:45:41 -0800 (PST)
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

From: Mark Brown <broonie@opensource.wolfsonmicro.com>

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
1.7.8.3
