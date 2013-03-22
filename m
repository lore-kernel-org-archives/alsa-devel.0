From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/14] ASoC: ux500_pcm: Remove duplicated
	SNDRV_PCM_HW_PARAM_PERIODS constraint
Date: Fri, 22 Mar 2013 14:12:01 +0100
Message-ID: <1363957934-20059-2-git-send-email-lars@metafoo.de>
References: <1363957934-20059-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-087.synserver.de (smtp-out-087.synserver.de
 [212.40.185.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CE962651EE
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 14:10:29 +0100 (CET)
In-Reply-To: <1363957934-20059-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The generic dmaengine based PCM driver code takes care of setting this
constraint, there is no need of doing it manually in the ux500 driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>
---
 sound/soc/ux500/ux500_pcm.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/soc/ux500/ux500_pcm.c b/sound/soc/ux500/ux500_pcm.c
index 846fa82..375ca6b 100644
--- a/sound/soc/ux500/ux500_pcm.c
+++ b/sound/soc/ux500/ux500_pcm.c
@@ -111,15 +111,6 @@ static int ux500_pcm_open(struct snd_pcm_substream *substream)
 		snd_soc_set_runtime_hwparams(substream,
 					&ux500_pcm_hw_capture);
 
-	/* ensure that buffer size is a multiple of period size */
-	ret = snd_pcm_hw_constraint_integer(runtime,
-					SNDRV_PCM_HW_PARAM_PERIODS);
-	if (ret < 0) {
-		dev_err(dev, "%s: Error: snd_pcm_hw_constraints failed (%d)\n",
-			__func__, ret);
-		return ret;
-	}
-
 	dev_dbg(dev, "%s: Set hw-struct for %s.\n", __func__,
 		snd_pcm_stream_str(substream));
 	runtime->hw = (stream_id == SNDRV_PCM_STREAM_PLAYBACK) ?
-- 
1.8.0
