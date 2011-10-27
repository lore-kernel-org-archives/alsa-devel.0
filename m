From: ramesh.babu@linux.intel.com
Subject: [PATCH] ASoC:core:add flag ignore_pmdown_time in
	snd_soc_dai_link
Date: Thu, 27 Oct 2011 11:58:53 +0530
Message-ID: <1319696933-19942-1-git-send-email-ramesh.babu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id F0FB7245C6
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Oct 2011 08:28:03 +0200 (CEST)
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
Cc: Ramesh Babu K V <ramesh.babu@linux.intel.com>, Vinod Koul <vinod.koul@linux.intel.com>, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

With this flag, each dai_link in machine driver can choose
to ignore pmdown_time during DAPM shut down sequence.

If the ignore_pmdown_time is set, the DAPM for corresponding DAI
will be executed immediately.

Signed-off-by: Ramesh Babu K V <ramesh.babu@linux.intel.com>
Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
---
 include/sound/soc.h |    3 +++
 sound/soc/soc-pcm.c |    3 ++-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 11cfb59..877fcc1 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -718,6 +718,9 @@ struct snd_soc_dai_link {
 	/* Symmetry requirements */
 	unsigned int symmetric_rates:1;
 
+	/* pmdown_time is ignored at stop */
+	unsigned int ignore_pmdown_time:1;
+
 	/* codec/machine specific init - e.g. add machine controls */
 	int (*init)(struct snd_soc_pcm_runtime *rtd);
 
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index ee15337..52a7259 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -319,7 +319,8 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 	cpu_dai->runtime = NULL;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		if (unlikely(codec->ignore_pmdown_time)) {
+		if (unlikely(codec->ignore_pmdown_time ||
+			rtd->dai_link->ignore_pmdown_time)) {
 			/* powered down playback stream now */
 			snd_soc_dapm_stream_event(rtd,
 				codec_dai->driver->playback.stream_name,
-- 
1.7.4.1
