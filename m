From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dpcm: Don't apply symmetry for BE with
	hw param fixup" to the asoc tree
Date: Wed, 14 Sep 2016 18:15:44 +0100
Message-ID: <E1bkDmi-0001hM-F8@debutante>
References: <1473151675-1945-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AF45C266619
 for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2016 19:15:50 +0200 (CEST)
In-Reply-To: <1473151675-1945-1-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dpcm: Don't apply symmetry for BE with hw param fixup

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

>From f11766143caa065b3aef4d794c104ea0f37ada76 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Tue, 6 Sep 2016 14:17:55 +0530
Subject: [PATCH] ASoC: dpcm: Don't apply symmetry for BE with hw param fixup

If be_hw_param_fixup is defined for BE then it will
force the BE to a specific configuration supported
by HW. In this case don't apply symmetry.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 60d702f8b9f0..c1bfe9d8406d 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1694,6 +1694,9 @@ static int dpcm_apply_symmetry(struct snd_pcm_substream *fe_substream,
 		struct snd_soc_pcm_runtime *rtd = be_substream->private_data;
 		int i;
 
+		if (rtd->dai_link->be_hw_params_fixup)
+			continue;
+
 		if (soc_pcm_has_symmetry(be_substream))
 			be_substream->runtime->hw.info |= SNDRV_PCM_INFO_JOINT_DUPLEX;
 
-- 
2.8.1
