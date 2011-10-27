From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Remove needless unlikely()
Date: Thu, 27 Oct 2011 12:12:08 +0200
Message-ID: <1319710328-32136-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 42DBA24744
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Oct 2011 12:12:32 +0200 (CEST)
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

There's no point in adding unlikely() annotations outside of hot paths
and on systems using these features the annotation will always be wrong
(as opposed to being something that only comes up once in a while) so
the annotation may even be harmful.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-pcm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 52a7259..49aa71e 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -319,8 +319,8 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 	cpu_dai->runtime = NULL;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		if (unlikely(codec->ignore_pmdown_time ||
-			rtd->dai_link->ignore_pmdown_time)) {
+		if (codec->ignore_pmdown_time ||
+		    rtd->dai_link->ignore_pmdown_time) {
 			/* powered down playback stream now */
 			snd_soc_dapm_stream_event(rtd,
 				codec_dai->driver->playback.stream_name,
-- 
1.7.6.3
