From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] ASoC: have unique stream_names in codecs
Date: Fri,  5 Oct 2012 16:17:48 +0200
Message-ID: <1349446668-28299-1-git-send-email-pmeerw@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pmeerw.net (ns.pmeerw.net [87.118.82.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D3272650BD
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2012 16:17:50 +0200 (CEST)
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
Cc: Peter Meerwald <p.meerwald@bct-electronic.com>, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

From: Peter Meerwald <p.meerwald@bct-electronic.com>

for example, there are two 'Capture' stream_names in twl4030, resulting in

twl4030-codec twl4030-codec: ASoC: Failed to create Capture debugfs file

with debug enabled (fails to create two sysfs entries named 'Capture' under
/sys/kernel/debug/asoc/omap3beagle/twl4030-codec/dapm

this patch tries to avoid duplicate stream_names

Signed-off-by: Peter Meerwald <p.meerwald@bct-electronic.com>
---
 sound/soc/codecs/stac9766.c |    4 ++--
 sound/soc/codecs/twl4030.c  |    4 ++--
 sound/soc/codecs/twl6040.c  |    2 +-
 sound/soc/codecs/uda1380.c  |    4 ++--
 sound/soc/codecs/wm8753.c   |    4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index 33c0f3d..3379119 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -300,14 +300,14 @@ static struct snd_soc_dai_driver stac9766_dai[] = {
 
 	/* stream cababilities */
 	.playback = {
-		.stream_name = "stac9766 analog",
+		.stream_name = "stac9766 playback",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_8000_48000,
 		.formats = SND_SOC_STD_AC97_FMTS,
 	},
 	.capture = {
-		.stream_name = "stac9766 analog",
+		.stream_name = "stac9766 capture",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_8000_48000,
diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 391fcfc..55582db 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -2172,7 +2172,7 @@ static struct snd_soc_dai_driver twl4030_dai[] = {
 		.formats = TWL4030_FORMATS,
 		.sig_bits = 24,},
 	.capture = {
-		.stream_name = "Capture",
+		.stream_name = "HiFi Capture",
 		.channels_min = 2,
 		.channels_max = 4,
 		.rates = TWL4030_RATES,
@@ -2189,7 +2189,7 @@ static struct snd_soc_dai_driver twl4030_dai[] = {
 		.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
 	.capture = {
-		.stream_name = "Capture",
+		.stream_name = "Voice Capture",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index c084c54..6f3a9cf 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1046,7 +1046,7 @@ static struct snd_soc_dai_driver twl6040_dai[] = {
 {
 	.name = "twl6040-ul",
 	.capture = {
-		.stream_name = "Capture",
+		.stream_name = "Capture UL",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = TWL6040_RATES,
diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 2502214..d780fe7 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -671,7 +671,7 @@ static struct snd_soc_dai_driver uda1380_dai[] = {
 { /* playback only - dual interface */
 	.name = "uda1380-hifi-playback",
 	.playback = {
-		.stream_name = "Playback",
+		.stream_name = "Playback Only",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = UDA1380_RATES,
@@ -682,7 +682,7 @@ static struct snd_soc_dai_driver uda1380_dai[] = {
 { /* capture only - dual interface*/
 	.name = "uda1380-hifi-capture",
 	.capture = {
-		.stream_name = "Capture",
+		.stream_name = "Capture Only",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = UDA1380_RATES,
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 13bff87..783ac20 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1400,7 +1400,7 @@ static struct snd_soc_dai_driver wm8753_dai[] = {
 		.formats = WM8753_FORMATS
 	},
 	.capture = { /* dummy for fast DAI switching */
-		.stream_name = "Capture",
+		.stream_name = "HiFi Capture",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = WM8753_RATES,
@@ -1418,7 +1418,7 @@ static struct snd_soc_dai_driver wm8753_dai[] = {
 		.formats = WM8753_FORMATS,
 	},
 	.capture = {
-		.stream_name = "Capture",
+		.stream_name = "Voice Capture",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = WM8753_RATES,
-- 
1.7.9.5
