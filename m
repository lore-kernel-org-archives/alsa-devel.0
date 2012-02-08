From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: pcm: If pmdown_time is zero then shut
	down DAPM immediately
Date: Wed,  8 Feb 2012 20:11:24 +0000
Message-ID: <1328731884-12468-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2C031103899
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 21:11:28 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Since we've already got logic to special case immediate teardown of the
stream we may as well use it if the pmdown_time has been set to zero by
the application layer instead of scheduling a work item with zero delay.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-pcm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index ef28dd5..d7bb268 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -369,7 +369,7 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 	cpu_dai->runtime = NULL;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		if (codec->ignore_pmdown_time ||
+		if (!rtd->pmdown_time || codec->ignore_pmdown_time ||
 		    rtd->dai_link->ignore_pmdown_time) {
 			/* powered down playback stream now */
 			snd_soc_dapm_stream_event(rtd,
-- 
1.7.9.rc1
