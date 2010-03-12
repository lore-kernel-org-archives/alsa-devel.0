From: Jassi Brar <jassi.brar@samsung.com>
Subject: [PATCH] ASoC: PCM_RATE: Check for KNOT and CONTINUOUS
	flags
Date: Fri, 12 Mar 2010 13:38:52 +0900
Message-ID: <1268368732-27758-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 861C824471
	for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2010 05:48:36 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

For ASoC, if either CPU or CODEC driver has set the flag, the MACHINE driver
should be given a chance to figure out if the dai, that set the flag, can
accomodate a rate that it does not explicitly specify but is specified
by the dai at the other end of the link.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/soc-core.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 06c38d1..eb73aab 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -404,6 +404,12 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 			codec_dai->playback.formats & cpu_dai->playback.formats;
 		runtime->hw.rates =
 			codec_dai->playback.rates & cpu_dai->playback.rates;
+		if (codec_dai->playback.rates
+			   & (SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_CONTINUOUS))
+			runtime->hw.rates |= cpu_dai->playback.rates;
+		if (cpu_dai->playback.rates
+			   & (SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_CONTINUOUS))
+			runtime->hw.rates |= codec_dai->playback.rates;
 	} else {
 		runtime->hw.rate_min =
 			max(codec_dai->capture.rate_min,
@@ -421,6 +427,12 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 			codec_dai->capture.formats & cpu_dai->capture.formats;
 		runtime->hw.rates =
 			codec_dai->capture.rates & cpu_dai->capture.rates;
+		if (codec_dai->capture.rates
+			   & (SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_CONTINUOUS))
+			runtime->hw.rates |= cpu_dai->capture.rates;
+		if (cpu_dai->capture.rates
+			   & (SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_CONTINUOUS))
+			runtime->hw.rates |= codec_dai->capture.rates;
 	}
 
 	snd_pcm_limit_hw_rates(runtime);
-- 
1.6.2.5
