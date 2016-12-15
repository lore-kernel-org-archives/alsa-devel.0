From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: remove unused 'ret'" to
	the asoc tree
Date: Thu, 15 Dec 2016 12:21:57 +0000
Message-ID: <E1cHV2r-0000xJ-7y@debutante>
References: <1481218297-17568-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7742759760654627656=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 82231266A53
 for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2016 13:22:03 +0100 (CET)
In-Reply-To: <1481218297-17568-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

--===============7742759760654627656==
Content-Type: text/plain

The patch

   ASoC: Intel: Skylake: remove unused 'ret'

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

>From 547cafa3efc3f12101cafd454e651c9a5a8feae4 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 8 Dec 2016 23:01:24 +0530
Subject: [PATCH] ASoC: Intel: Skylake: remove unused 'ret'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In skl_tplg_mixer_dapm_post_pmd_event(), a variable 'ret' is initialized but
not used.

We don't check return of skl_delete_pipe, so remove the assignment as
well, so remove this variable.

sound/soc/intel/skylake/skl-topology.c: In function ‘skl_tplg_mixer_dapm_post_pmd_event’:
sound/soc/intel/skylake/skl-topology.c:976:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
  int ret = 0;
      ^
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index bd313c907b20..eb440cd9a2a4 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -974,7 +974,6 @@ static int skl_tplg_mixer_dapm_post_pmd_event(struct snd_soc_dapm_widget *w,
 	struct skl_module_cfg *src_module = NULL, *dst_module;
 	struct skl_sst *ctx = skl->skl_sst;
 	struct skl_pipe *s_pipe = mconfig->pipe;
-	int ret = 0;
 
 	if (s_pipe->state == SKL_PIPE_INVALID)
 		return -EINVAL;
@@ -996,7 +995,7 @@ static int skl_tplg_mixer_dapm_post_pmd_event(struct snd_soc_dapm_widget *w,
 		src_module = dst_module;
 	}
 
-	ret = skl_delete_pipe(ctx, mconfig->pipe);
+	skl_delete_pipe(ctx, mconfig->pipe);
 
 	return skl_tplg_unload_pipe_modules(ctx, s_pipe);
 }
-- 
2.11.0


--===============7742759760654627656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7742759760654627656==--
