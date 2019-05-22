From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 06/12] ASoC: SOF: pcm: remove warning -
	initialize workqueue on open
Date: Wed, 22 May 2019 11:21:36 -0500
Message-ID: <20190522162142.11525-7-pierre-louis.bossart@linux.intel.com>
References: <20190522162142.11525-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 64138F89633
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2019 18:21:56 +0200 (CEST)
In-Reply-To: <20190522162142.11525-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

If the SOF hw_params() fail, typically with an IPC error thrown by the
firmware, the period_elapsed workqueue is not initialized, but we
still cancel it in hw_free(), which results in a kernel warning.

Move the initialization to the .open callback. Tested on Broadwell
(Samus) and IceLake.

Fixes: e2803e610ae ("ASoC: SOF: PCM: add period_elapsed work to fix
race condition in interrupt context")

GitHub issue: https://github.com/thesofproject/linux/issues/932
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/pcm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index e94892053690..6dc5f97be0bc 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -211,9 +211,6 @@ static int sof_pcm_hw_params(struct snd_pcm_substream *substream,
 	/* save pcm hw_params */
 	memcpy(&spcm->params[substream->stream], params, sizeof(*params));
 
-	INIT_WORK(&spcm->stream[substream->stream].period_elapsed_work,
-		  sof_pcm_period_elapsed_work);
-
 	/* clear hw_params_upon_resume flag */
 	spcm->hw_params_upon_resume[substream->stream] = 0;
 
@@ -431,6 +428,9 @@ static int sof_pcm_open(struct snd_pcm_substream *substream)
 	dev_dbg(sdev->dev, "pcm: open stream %d dir %d\n", spcm->pcm.pcm_id,
 		substream->stream);
 
+	INIT_WORK(&spcm->stream[substream->stream].period_elapsed_work,
+		  sof_pcm_period_elapsed_work);
+
 	caps = &spcm->pcm.caps[substream->stream];
 
 	/* set any runtime constraints based on topology */
-- 
2.20.1
