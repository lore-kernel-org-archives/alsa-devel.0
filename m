From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2] ASoC: soc-compress: Send correct stream
	event for capture start
Date: Mon, 20 May 2013 08:33:54 +0100
Message-ID: <1369035234-22052-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8FC6D2608CF
 for <alsa-devel@alsa-project.org>; Mon, 20 May 2013 09:43:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, tiwai@suse.de, vinod.koul@intel.com
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/soc-compress.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 3853f7e..06a8000 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -220,8 +220,12 @@ static int soc_compr_set_params(struct snd_compr_stream *cstream,
 			goto err;
 	}
 
-	snd_soc_dapm_stream_event(rtd, SNDRV_PCM_STREAM_PLAYBACK,
-				SND_SOC_DAPM_STREAM_START);
+	if (cstream->direction == SND_COMPRESS_PLAYBACK)
+		snd_soc_dapm_stream_event(rtd, SNDRV_PCM_STREAM_PLAYBACK,
+					SND_SOC_DAPM_STREAM_START);
+	else
+		snd_soc_dapm_stream_event(rtd, SNDRV_PCM_STREAM_CAPTURE,
+					SND_SOC_DAPM_STREAM_START);
 
 	/* cancel any delayed stream shutdown that is pending */
 	rtd->pop_wait = 0;
-- 
1.7.2.5
