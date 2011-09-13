From: Timur Tabi <timur@freescale.com>
Subject: [PATCH 2/3] ASoC: support all possible sample rates in
	the WM8776 driver
Date: Tue, 13 Sep 2011 12:59:36 -0500
Message-ID: <1315936777-27994-2-git-send-email-timur@freescale.com>
References: <1315936777-27994-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 29F83103A3A
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Sep 2011 20:00:59 +0200 (CEST)
In-Reply-To: <1315936777-27994-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ASoC codec drivers can use the .set_sysclk function to dynamically specify
the list of support sample rates, because that list is often based on
the input clock frequency.  Although the WM8776 includes a .set_sysclk
function, it was also hard-coding the supported sample rates to a list
that depends on a specific input clock frequency.

So change the hard-coded list to a range within the capabilities of the
WM8776 itself, and let wm8776_set_sysclk() do its job.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/codecs/wm8776.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm8776.c b/sound/soc/codecs/wm8776.c
index ad6f0fa..ca8a593 100644
--- a/sound/soc/codecs/wm8776.c
+++ b/sound/soc/codecs/wm8776.c
@@ -321,11 +321,6 @@ static int wm8776_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-#define WM8776_RATES (SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
-		      SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |\
-		      SNDRV_PCM_RATE_96000)
-
-
 #define WM8776_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
@@ -350,7 +345,9 @@ static struct snd_soc_dai_driver wm8776_dai[] = {
 			.stream_name = "Playback",
 			.channels_min = 2,
 			.channels_max = 2,
-			.rates = WM8776_RATES,
+			.rates = SNDRV_PCM_RATE_CONTINUOUS,
+			.rate_min = 32000,
+			.rate_max = 192000,
 			.formats = WM8776_FORMATS,
 		},
 		.ops = &wm8776_dac_ops,
@@ -362,7 +359,9 @@ static struct snd_soc_dai_driver wm8776_dai[] = {
 			.stream_name = "Capture",
 			.channels_min = 2,
 			.channels_max = 2,
-			.rates = WM8776_RATES,
+			.rates = SNDRV_PCM_RATE_CONTINUOUS,
+			.rate_min = 32000,
+			.rate_max = 96000,
 			.formats = WM8776_FORMATS,
 		},
 		.ops = &wm8776_adc_ops,
-- 
1.7.3.4
