From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Don't reset
	pass-through pipe in BE prepare" to the asoc tree
Date: Thu, 19 Jan 2017 18:03:53 +0000
Message-ID: <E1cUH3x-0004xw-Ki@debutante>
References: <1480700509-23380-11-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B7DE72678D4
 for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2017 19:04:02 +0100 (CET)
In-Reply-To: <1480700509-23380-11-git-send-email-jeeja.kp@intel.com>
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

   ASoC: Intel: Skylake: Don't reset pass-through pipe in BE prepare

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

>From 7cbfdf87f422211b9a1f2845acb2e39597b3ef7e Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Tue, 10 Jan 2017 17:57:46 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Don't reset pass-through pipe in BE
 prepare

When pipe is pass-through, BE and FE modules are defined inside
a pipe, reset of pipe will be done in FE DAI prepare. So don't
reset in the BE prepare.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 10fa10df4e57..aefcfca810f4 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -572,8 +572,8 @@ static int skl_link_pcm_prepare(struct snd_pcm_substream *substream,
 
 	/* In case of XRUN recovery, reset the FW pipe to clean state */
 	mconfig = skl_tplg_be_get_cpr_module(dai, substream->stream);
-	if (mconfig && (substream->runtime->status->state ==
-					SNDRV_PCM_STATE_XRUN))
+	if (mconfig && !mconfig->pipe->passthru &&
+		(substream->runtime->status->state == SNDRV_PCM_STATE_XRUN))
 		skl_reset_pipe(skl->skl_sst, mconfig->pipe);
 
 	return 0;
-- 
2.11.0
