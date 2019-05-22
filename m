From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 05/12] ASoC: SOF: pcm: clear
	hw_params_upon_resume flag correctly
Date: Wed, 22 May 2019 11:21:35 -0500
Message-ID: <20190522162142.11525-6-pierre-louis.bossart@linux.intel.com>
References: <20190522162142.11525-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B8145F89625
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
Cc: tiwai@suse.de, Libin Yang <libin.yang@intel.com>, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

sof_pcm_hw_params() can only be called once to setup the FW hw_params.
So after calling sof_pcm_hw_params(), hw_params_upon_resume flag must
be cleared to avoid multiple invoking sof_pcm_hw_params() by prepare.

For example, after resume, there is an xrun happened, prepare() will
be called. As the hw_params_upon_resume flag is not cleared,
sof_pcm_hw_params() will be called and this will cause IPC timeout.

This patch fixes such issues.

Fixes: 868bd00f495 ("ASoC: SOF: Add PCM operations support")
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Libin Yang <libin.yang@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/pcm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index 4f536c0de0a5..e94892053690 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -214,6 +214,9 @@ static int sof_pcm_hw_params(struct snd_pcm_substream *substream,
 	INIT_WORK(&spcm->stream[substream->stream].period_elapsed_work,
 		  sof_pcm_period_elapsed_work);
 
+	/* clear hw_params_upon_resume flag */
+	spcm->hw_params_upon_resume[substream->stream] = 0;
+
 	return ret;
 }
 
@@ -428,9 +431,6 @@ static int sof_pcm_open(struct snd_pcm_substream *substream)
 	dev_dbg(sdev->dev, "pcm: open stream %d dir %d\n", spcm->pcm.pcm_id,
 		substream->stream);
 
-	/* clear hw_params_upon_resume flag */
-	spcm->hw_params_upon_resume[substream->stream] = 0;
-
 	caps = &spcm->pcm.caps[substream->stream];
 
 	/* set any runtime constraints based on topology */
-- 
2.20.1
