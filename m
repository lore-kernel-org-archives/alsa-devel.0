From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: pcm: clear hw_params_upon_resume
	flag correctly" to the asoc tree
Date: Tue, 28 May 2019 16:07:04 +0100 (BST)
Message-ID: <20190528150704.4845A440049@finisterre.sirena.org.uk>
References: <20190524190925.5931-5-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 74179F8972C
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2019 17:07:09 +0200 (CEST)
In-Reply-To: <20190524190925.5931-5-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Libin Yang <libin.yang@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: pcm: clear hw_params_upon_resume flag correctly

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 04ea642ff62a2b2da3d5844283991a41328f49b1 Mon Sep 17 00:00:00 2001
From: Libin Yang <libin.yang@intel.com>
Date: Fri, 24 May 2019 14:09:20 -0500
Subject: [PATCH] ASoC: SOF: pcm: clear hw_params_upon_resume flag correctly

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/pcm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index 649968841dad..d6dc9a7df0f4 100644
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
 
@@ -429,9 +432,6 @@ static int sof_pcm_open(struct snd_pcm_substream *substream)
 	dev_dbg(sdev->dev, "pcm: open stream %d dir %d\n", spcm->pcm.pcm_id,
 		substream->stream);
 
-	/* clear hw_params_upon_resume flag */
-	spcm->hw_params_upon_resume[substream->stream] = 0;
-
 	caps = &spcm->pcm.caps[substream->stream];
 
 	ret = pm_runtime_get_sync(sdev->dev);
-- 
2.20.1
