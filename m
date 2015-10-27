From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix not to ignore
	return value in be hw_params" to the asoc tree
Date: Tue, 27 Oct 2015 13:49:39 +0900
Message-ID: <E1ZqwCZ-0004xZ-6M@finisterre>
References: <1445905380-18167-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 45E832658DF
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 05:49:49 +0100 (CET)
In-Reply-To: <1445905380-18167-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix not to ignore return value in be hw_params

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 68a255813adf564f608ade539bceb994b176bdde Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Tue, 27 Oct 2015 09:22:45 +0900
Subject: [PATCH] ASoC: Intel: Skylake: Fix not to ignore return value in be
 hw_params

Return value from skl_tplg_be_update_params() is ignored. But if the
blob is null then the hw_params needs to return error.
This patch fixes the issue by not ignoring return value from
skl_tplg_be_update_params().

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index a2f94ce..1242bea 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -291,9 +291,8 @@ static int skl_be_hw_params(struct snd_pcm_substream *substream,
 	p_params.ch = params_channels(params);
 	p_params.s_freq = params_rate(params);
 	p_params.stream = substream->stream;
-	skl_tplg_be_update_params(dai, &p_params);
 
-	return 0;
+	return skl_tplg_be_update_params(dai, &p_params);
 }
 
 static int skl_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
@@ -352,9 +351,7 @@ static int skl_link_hw_params(struct snd_pcm_substream *substream,
 	p_params.stream = substream->stream;
 	p_params.link_dma_id = hdac_stream(link_dev)->stream_tag - 1;
 
-	skl_tplg_be_update_params(dai, &p_params);
-
-	return 0;
+	return skl_tplg_be_update_params(dai, &p_params);
 }
 
 static int skl_link_pcm_prepare(struct snd_pcm_substream *substream,
-- 
2.6.1
